Clerk.configure do |config|
  config.publishable_key = ENV.fetch("CLERK_PUBLIC_KEY")
  config.secret_key = ENV.fetch("CLERK_SECRET_KEY")
  config.cache_store = Rails.cache
end
