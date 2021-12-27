import asyncio
import calendar
import datetime as dt
import sys
from dataclasses import dataclass, field
from urllib.parse import urljoin

import aiohttp
from aiofile import async_open
from aiopath import AsyncPath
from aiostream import async_, operator, pipe, stream, streamcontext
from bs4 import BeautifulSoup


@dataclass
class Article:
    """docs here."""

    date: dt.date = field(init=False)
    title: str
    magazine_url: str
    url: str

    def __post_init__(self):
        """Sets article date based on URL."""

        path_split = self.magazine_url.split("/")
        month_names = list(map(str.lower, calendar.month_name))

        if len(month := path_split[-1].split("-")) == 1:
            month, day = month[0], 1
        else:
            month, day = month[0], int(month[1])

        month_num = month_names.index(month)
        try:
            year = int(path_split[-3].split("-")[-1])
        except ValueError:
            year = int(path_split[-2].split("-")[-1])

        self.date = dt.date(
            year=year,
            month=month_num,
            day=day,
        )

    async def content(self) -> asyncio.StreamReader:
        """docs here."""
        ps = await asyncio.create_subprocess_exec(
            "links",
            "-dump",
            self.url,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
        )
        await ps.wait()
        return ps.stdout


async def fetch_magazine(session, url):
    """docs here."""

    async with session.get(
        url,
        headers={"User-Agent": ""},
        allow_redirects=False,
    ) as resp:
        resp.raise_for_status()
        # ignores redirects, for they sign magazine for this month doesn't
        # exist.
        if 400 > resp.status >= 300:
            return stream.iterate(tuple())

        bs = BeautifulSoup(await resp.read(), "html.parser")

        articles = []
        for a_tag in bs.find("article").select("a.lnk"):
            study, title = None, None

            article_link = urljoin(url, a_tag["href"])

            if card_line1 := a_tag.find("div", class_="cardLine1"):
                study = card_line1.text.strip()
            if card_line2 := a_tag.find("div", class_="cardLine2"):
                title = card_line2.text.strip()

            if study and not title:
                title = study
            else:
                title = f"{study}-{title}"

            articles.append(
                Article(
                    title=title,
                    magazine_url=url,
                    url=article_link,
                )
            )

        return stream.iterate(articles)


async def fetch_month(session, year: int, month: int):
    """docs here."""

    year_wts_url = urljoin(
        "https://wol.jw.org/en/wol/library/r1/lp-e/all-publications/watchtower/",
        f"the-watchtower-{year}/study-edition/",
    )

    month_name = calendar.month_name[month].lower()
    if 2022 >= year >= 2016:
        month_wt_urls = (urljoin(year_wts_url, month_name),)
    elif 2015 >= year >= 2008:
        month_wt_urls = (urljoin(year_wts_url, month_name + "-15"),)
    elif 2007 >= year:
        month_wt_urls = (
            urljoin(year_wts_url, month_name + "-15"),
            urljoin(year_wts_url, month_name + "-1"),
        )

    return stream.flatten(
        stream.iterate(month_wt_urls)
        | pipe.map(async_(lambda url: fetch_magazine(session, url)))
    )


async def fetch_year(session, year):
    """docs here."""
    return stream.flatten(
        stream.range(1, 13)
        | pipe.map(async_(lambda month: fetch_month(session, year, month)))
    )


async def save_article(base_path: str, article: Article):
    """docs here."""
    base_path = AsyncPath(base_path)
    date = article.date
    year_path = base_path / str(date.year)
    await year_path.mkdir(parents=True, exist_ok=True)

    article_filename = f"{date.year}-{date.month:02}-{date.day:02}-{article.title}.txt"
    article_path = year_path / article_filename

    async with async_open(article_path, "wb") as file:
        await file.write(await (await article.content()).read())


@operator(pipable=True)
async def streamprogress(source):
    """Logs stream progress as records are processed and returns the number of
    records processed.."""
    count = 0
    async with streamcontext(source) as streamer:
        async for _ in streamer:
            sys.stdout.write(".")
            sys.stdout.flush()
            count += 1
    yield count


async def main():
    """docs here."""
    base_path = "/ext/media/articles/wt/"

    async with aiohttp.ClientSession() as session:
        saved = await (
            stream.flatten(
                stream.map(
                    stream.range(220, 2022),
                    async_(lambda year: fetch_year(session, year)),
                )
            )
            | pipe.map(
                async_(lambda article: save_article(base_path, article)),
            )
            | streamprogress.pipe()
        )
    print(f"\nsaved {saved} articles")


if __name__ == "__main__":
    asyncio.run(main())
