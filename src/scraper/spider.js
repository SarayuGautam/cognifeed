/* eslint-disable linebreak-style */
"use strict"

/**
 * The Spider module:
 * This module is responsible for spawning a spider with a seed url, getting new links from a page and adding those links to a links collection.
 * @module src/scraper/spider
 */

const Link = require("./link")
const requestPromise = require("request-promise-native")
const pool = require("../database/database")
const { ErrorHandler } = require("../helpers/error_handler")
const cheerio = require("cheerio")
const axios = require("axios").default
const LinksCollection = require("./links-collection")
const baseUrl = "http://127.0.0.1:" + process.env.PORT

/**
 * @class
 */
class Spider {
  /**
   * Returns a new Spider object with link as parameter.
   * If the links collection of one spider spawned in a url is full,
   * then links collecction field can be added to spawn
   * @param {Link} link
   * @returns {Spider}
   */
  static spawn(link) {
    return new Spider(link)
  }
  /**
   * Collect all links from within the seed url into a links collecton
   * @returns {LinksCollection}
   */
  async getNewLinks() {
    try {
      this._html = await requestPromise.get(this._link.resolve())
    } catch (err) {
      throw new Error(err.message)
    }

    const $ = cheerio.load(this._html)
    $("a").each((i, e) => {
      if ($(e).attr("href") !== undefined) {
        this._horizon.addLinks([
          new Link(this._link.baseURL, $(e).attr("href"))
        ])
      }
    })
    // eslint-disable-next-line no-undef
    return this._horizon
  }

  /**
   * Getter for the link property
   * @returns {Link} - The link the spider is currently visiting
   */
  get link() {
    return this._link
  }

  /**
   * Saves or returns html from this._link
   * @private
   */
  async _persistHtml() {
    console.log(this._html.length)

    try {
      const payload = {
        url: this._link.resolve(),
        html: this._html
      }
      const response = await axios.post(
        `${baseUrl}/api/spider/persist`,
        payload
      )
      console.log(response)
    } catch (error) {
      console.error(error)
    }
  }

  /**
   * Create a new Spider object
   * @param {Link} link
   * @private
   */
  constructor(link) {
    /**
     * The seed link to which to send the spider
     * @private
     * @type {Link}
     */
    this._link = link
    /**
     * The collection to which the spider adds links encountered in a page
     * @private
     * @type {LinksCollection}
     */
    this._horizon = LinksCollection.create()
  }
}

module.exports = Spider
