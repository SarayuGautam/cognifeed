const Purifier = require("../Purifier")
const { cheerio } = require("cheerio")
class pinchofyumPurifier extends Purifier {
  // static baseUrl = "https://pinchofyum.com/";

  /**
   *
   * @param{String} html
   * @param{string} url
   */
  constructor(html, url) {
    super(html, url)
  }
  purify() {
    const $ = cheerio.load(this.html)
    this.title = " "
    $(".one-third .caption").each((index, element) => {
      if (index < 3) {
        this.title = $(element).text()
      }
    })

    this.image_url = " "
    $(".one-third img").each((index, element) => {
      if (index < 3) {
        this.image_url = $(element).attr("src")
      }
    })
  }
}
module.exports = pinchofyumPurifier
