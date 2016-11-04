config = require './config'
fs = require 'fs'
request = require 'request'
exec = require('child_process').exec
pool = require('feed-poll')(config.feeds)

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
      exec "tranmission-cli #{article.link}", (error, stdout, stderr) ->
        if error?
          console.log 'error to send link to transmission', error
          return
        console.log "\t #{article.link} sent to transmission"
        console.log stdout
      return
    else console.log "\t no recognisable type"


pool.on 'error', (error) ->
  throw error

console.log 'Start watching feed'
pool.start()
