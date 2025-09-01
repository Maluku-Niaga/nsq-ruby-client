
require "nsq"


consumer = Nsq::Consumer.new(
  nsqlookupd: "127.0.0.1:4161",
  topic: "hello",
  channel: "test",
  max_attempts: 3
)


consumer.callbacks.max_attempt do |topic, channel|
  # max_attempt block will be called when a message reaches the max_attempts

  puts "max attempt: #{topic} - #{channel}"
end

loop do
  msg = consumer.pop_without_blocking
  next if msg.nil?

  puts "message: #{msg.body}"
  msg.requeue
  sleep 2
end



