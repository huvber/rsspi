fs = require 'fs'
config = JSON.parse fs.readFileSync './config.json'
pool = require('feed-poll')(config.feeds)

pool.on 'article', (article) ->
  console.log article

pool.on 'error', (error) ->
  throw error

console.log 'Start watching feed'
pool.start()
