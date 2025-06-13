# Write your solution here!
require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
response = ""

message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant."
  }
]

while response != "bye"
  #Initial request
  border = "-" * 50
  puts "Hello! how can I help you today?"
  puts border
  response = gets.chomp
  puts

  message_list.push({"role" => "user", "content" => response})

  #API stuff
  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )

  #Chat response
  chat = api_response.fetch("choices")
  chat_index = chat.at(0)
  chat_messages = chat_index.fetch("message")
  chat_response = chat_messages.fetch("content")
  puts chat_response
  puts border

  message_list.push({"role" => "assistant", "content" => chat_response})  
end
