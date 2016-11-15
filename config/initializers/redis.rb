$redis = Redis.new(url: ENV["REDIS_URL"]) if Rails.env.production?
	$redis = Redis.new(:host => 'localhost', :port => 6379) if Rails.env.development?