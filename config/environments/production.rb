SalesClerk::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both thread web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.public_file_server.enabled = false
  config.assets.css_compressor = :sass
  config.assets.compile = false
  config.assets.digest = true

  # Specifies the header that your server uses for sending files.
  config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # ActionMailer Config
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
        :address              => "smtp.zoho.com",
        :port                 => 465,
        :domain               => Rails.application.secrets.domain_name,
        :user_name            => Rails.application.secrets.admin_email,
        :password             => Rails.application.secrets.admin_pass,
        :ssl                  => true,
        :tls                  => true,
        :authentication       => :login,
        :enable_starttls_auto => true
  }


  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_options = {from: Rails.application.secrets.admin_email ,
                                          cc: Rails.application.secrets.admin_email ,
                                          bcc: Rails.application.secrets.admin_bcc }
  config.action_mailer.default_url_options = { :host => Rails.application.secrets.domain_name }

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

end
