Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true

  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.active_storage.service = :local

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true

  config.assets.debug = true
  config.assets.quiet = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = {:host => Settings.u_host}

  config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      domain: ENV["USER_DOMAIN"],
      authentication: "plain",
      enable_starttls_auto: true,
      user_name: ENV["GMAIL_USERNAME"],
      password: ENV["GMAIL_PASSWORD"]
  }
end
