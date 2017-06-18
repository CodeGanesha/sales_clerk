# config valid only for current version of Capistrano
lock '3.8.2'

set :application, 'kauppa'
set :repo_url, 'https://github.com/rubyclerks/sales_clerk'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/vhosts/auringostaitaan.fi'

append :linked_dirs, "public/images" ,"log" ,"tmp/pids", "tmp/cache"

set :passenger_restart_command, 'passenger-config restart-app'

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
