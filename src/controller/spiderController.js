const pool = require("../database/database")
const { ErrorHandler } = require("../helpers/error_handler")
module.exports.persistHtml = async (req, res, next) => {
  console.log("hit")
  const { url, html } = req.body

  try {
    const result = await pool.query("SELECT * FROM links WHERE url=?", [url])
    if (result.length > 0) {
      throw new ErrorHandler(401, "This url has already been resolved")
    } else {
      const resolve = await pool.query("INSERT INTO links SET url=?,html=?", [url, html])
      return res.json({
        id: resolve.insertId,
        html: html.length,
        url
      })
    }
  } catch (error) {
    next(error)
  }
}
