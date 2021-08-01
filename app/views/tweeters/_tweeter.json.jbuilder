json.extract! tweeter, :id, :content, :user_id, :created_at, :updated_at
json.url tweeter_url(tweeter, format: :json)
