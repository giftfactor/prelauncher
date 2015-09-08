server 'prelaunch.giftfactor.co:20022', user: 'deploy', roles: %w{web app db cron}
set :stage, 'production'
# set :branch, 'production'
set :rails_env, 'production'
set :server_name, 'prelaunch.giftfactor.co'
