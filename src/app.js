/* eslint-disable linebreak-style */
require("dotenv").config()
const Link = require("./scraper/link")
const app = require("express")()
const morgan = require("morgan")
const bodyParser = require("body-parser")

const { errorHandler, ErrorHandler } = require("./helpers/error_handler")
const port = process.env.PORT || 8000
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(morgan("tiny"))

app.use("/api", require("./routes/user"))
app.use("/api", require("./routes/spider"))
app.use("/api", require("./routes/purifier"))
// 404 page not found
app.all("*", (req, res) => {
  throw new ErrorHandler(404, "Page not found!")
})
app.listen(port, console.log(`Server running on port ${port}`))
// Error handler
app.use((err, req, res, next) => {
  errorHandler(err, res)
})
// Spider Instantiation.
const Spider = require("./scraper/spider")
const MindBodyPurifier = require("./purifier/healthAndBeauty/MindBodyGreenPurifier")
const spider = Spider.spawn(
  new Link(
    "https://www.mindbodygreen.com/",
    "articles/dr-perlmutter-wants-you-to-eat-more-of-this-in-2020"
  )
)
;(async function name() {
  const horizion = await spider.resolveUrl()
  console.log(horizion.readLinks().length)
  spider.getNewLinks()
  const purifier = new MindBodyPurifier(spider.html, spider.link)
  purifier.purify()
  // console.log(purifier.html)
  console.log(purifier.toString())
  // await purifier.persistPurified()
})()
