const Article = require("../Article")
const Purifier = require("../Purifier")
const cheerio = require("cheerio")
const Link = require("../../scraper/link")

class DavidWalshPurifier extends Purifier {
  /**
   *
   * @param {String} html
   * @param {Link} url
   */
  constructor(html, url) {
    super(html, url)
    this.website = "DavidWalsh"
  }
  /**
   * @returns {Article}
   */
  purify() {
    const $ = cheerio.load(this.html)
    this.title = $("#masthead-title #masthead-title-text")
      .text()
      .trim()
    this.description = ""
    $("article p").each((i, e) => {
      if (i < 5) {
        this.description += $(e).text()
      }
    })
    this.description = this.description.substr(0, 500)
    if (
      $(".main")
        .find("img")
        .attr("src") !== undefined
    )
      this.image_url = $(".main")
        .find("img")
        .attr("src")
    return new Article(
      this.title,
      this.description,
      this.website,
      this.image_url,
      this.link_url
    )
  }
}
module.exports = DavidWalshPurifier
