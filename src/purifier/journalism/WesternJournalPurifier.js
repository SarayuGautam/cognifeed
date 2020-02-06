const Purifier = require("../Purifier")
const cheerio = require("cheerio")
const Link = require("../../scraper/link")
class PhilosophyForLifePurifier extends Purifier {
  /**
   *
   * @param {String} html
   * @param {Link} url
   */
  constructor(html, url) {
    super(html, url)
  }
  purify() {
    const $ = cheerio.load(this.html)
    this.title = $(".entry-title")
      .text()
      .trim()

    this.description = $(".entry-content p")
      .text()
      .substr(0, 500)

    this.image_url = $("meta[property='og:image']")
      .eq(0)
      .attr("content")
  }
}
module.exports = PhilosophyForLifePurifier
