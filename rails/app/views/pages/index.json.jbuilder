json.array!(@pages) do |page|
  json.extract! page, :id, :body, :permalink, :is_public
  json.url page_url(page, format: :json)
end
