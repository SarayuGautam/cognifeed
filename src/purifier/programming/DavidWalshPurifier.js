const Purifier = require("../Purifier")
const cheerio = require("cheerio")
class DavidWalshPurifier extends Purifier {
  /**
   *
   * @param {String} html
   * @param {String} url
   */
  constructor(html, url) {
    super(html, url)
  }
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
  }
}
module.exports = DavidWalshPurifier
