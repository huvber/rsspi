config = require './config'
pool = require('feed-poll')(config.feeds)

pool.on 'article', (article) ->
  console.log article

pool.on 'error', (error) ->
  throw error

console.log 'Start watching feed'
pool.start()
