config = require './config'
fs = require 'fs'
request = require 'request'
pool = require('feed-poll')(config.feeds)
Powersteer = require 'powersteer'

rpc = new Powersteer config.daemon

pool.on 'article', (article) ->
  type = ''
  if article.link.indexOf('magnet') isnt -1
    type = 'magnet'
  if article.link.split('.').pop() is 'torrent'
    type = 'torrent'

  console.log "\nNew feed from '#{article.feed.name}' added:"
  console.log "\t - Title: #{article.title}"
  console.log "\t - Date: #{article.published}"
  console.log "\t - Type: #{type}"

  switch type
    when 'torrent'
      filename = article.link.split('/').pop()
      request({url: article.link, method: 'GET'})
        .pipe(fs.createWriteStream(config.download_dir + '/' + filename))
      console.log "\t #{filename}  saved in #{config.download_dir}"
      return
    when 'magnet'
      rpc.torrentAdd( url: article.link)
    else console.log "\t no recognisable type"


pool.on 'error', (error) ->
  throw error

console.log 'Start watching feed'
pool.start()
