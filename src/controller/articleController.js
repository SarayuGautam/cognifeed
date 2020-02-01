const pool = require("../database/database")
const { ErrorHandler } = require("../helpers/error_handler")
module.exports.articles = async (req, res, next) => {
  try {
    const articles = await pool.query("SELECT * FROM article")
    if (articles.length == 0) {
      throw new ErrorHandler(404, "articles not found")
    }
    return res.json({
      articles
    })
  } catch (error) {
    next(error)
  }
}

module.exports.showArticle = async (req, res, next) => {
  try {
    const article_id = req.params.article_id
    const article = await pool.query("SELECT * FROM article where article_id=?", [article_id])
    if (article.length == 0) {
      throw new ErrorHandler(404, "article not found")
    } else {
      await pool.query("UPDATE article SET view_count=view_count+1 WHERE article_id=?", [
        article_id
      ])
    }
    article[0].view_count += 1
    return res.json({
      article: article[0]
    })
  } catch (error) {
    next(error)
  }
}

module.exports.getFav = async (req, res, next) => {
  try {
    const user_id = req.user.user_id
    const articles = await pool.query(
      "SELECT article_id,title,description,image_url,link_url,view_count FROM article join favourites using(article_id) WHERE favourites.user_id=?",
      [user_id]
    )
    if (articles.length == 0) {
      throw new ErrorHandler(404, "articles not found")
    }

    return res.json({
      articles
    })
  } catch (error) {
    next(error)
  }
}
module.exports.setFav = async (req, res, next) => {
  try {
    const user_id = req.user.user_id
    const article_id = req.params.article_id
    await pool.query("INSERT INTO favourites SET user_id=?,article_id=?", [user_id, article_id])
    return res.json({
      message: "Added to favourite"
    })
  } catch (error) {
    next(error)
  }
}
