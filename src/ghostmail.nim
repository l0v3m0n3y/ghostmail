import asyncdispatch, httpclient, json, strutils

const api = "https://api.ghost-mail.io"
var headers = newHttpHeaders({
    "Connection": "keep-alive",
    "user-agent":"Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Mobile Safari/537.3",
    "Host": "api.ghost-mail.io",
    "Content-Type": "application/json",
    "accept": "application/json"
  })
var token=""

proc get_domains*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/v1/domains")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_emails*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.post(api & "/v1/mailbox/random",body="{}")
    let body = await response.body
    let json = parseJson(body)
    token = json["token"].getStr()
    result = json
  finally:
    client.close()

proc get_messages*(email_token:string=""): Future[JsonNode] {.async.} =
  if email_token!="":token = email_token
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/v2/emails?token=" & token)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()
