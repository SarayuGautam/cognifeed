const Purifier = require("../Purifier")
const cheerio = require("cheerio")
const Link = require("../../scraper/link")

class LiveSciencePurifier extends Purifier {
  /**
   *
   * @param {String} html
   * @param {Link} url
   */
  constructor(html, url) {
    super(html, url)
    this.website = "LiveScience"
  }
  purify() {
    const $ = cheerio.load(this.html)
    this.title = $(".news-article header>h1")
      .text()
      .trim()
    this.image_url = $("section.content-wrapper div.box>img").attr("src")
    this.description = $("div#article-body p")
      .text()
      .substr(0, 500)
  }
}
module.exports = LiveSciencePurifier
