require("dotenv").config()
const Link = require("./link")
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
// 404 page not found
app.all("*", (req, res) => {
  throw new ErrorHandler(404, "Page not found!")
})
app.listen(port, console.log(`Server running on port ${port}`))
// Error handler
app.use((err, req, res, next) => {
  errorHandler(err, res)
})
//Spider Instantiation.
const Spider = require("./Spider")
const spider = Spider.spawn(new Link("https://en.wikipedia.org", "/wiki/Node.js"))
;(async function name() {
  const horizion = await spider.resolveUrl()
  console.log(horizion.links.length)
  spider.getNewLinks()
  await spider.persistHtml()
})()
