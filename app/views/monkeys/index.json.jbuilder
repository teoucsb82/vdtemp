json.array!(@monkeys) do |monkey|
  json.extract! monkey, :id
  json.url monkey_url(monkey, format: :json)
end
