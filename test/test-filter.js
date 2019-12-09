"use strict"

const { expect } = require("chai")
const Link = require("../src/scraper/link.js")
const LinksCollection = require("../src/scraper/links-collection")
const Filter = require("../src/scraper/filter")

describe("Filter", () => {
  context("#getOriginalLinks", () => {
    it("should return only non-duplicate links", () => {
      let filter = new Filter()
      let links = new LinksCollection([
        new Link("https://wikipedia.org"),
        new Link("https://wikipedia.org"),
        new Link("https://medium.org")
      ])

      expect(filter.getOriginalLinks(links).size)
        .to.equal(2)
    })
  })
})
