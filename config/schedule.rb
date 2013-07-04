env :PATH, ENV['PATH']
set :environment, :production

LOG_FOLDER="/srv/datahub/shared/log"
set :output, {:error => "#{LOG_FOLDER}/cron_error.log", :standard => "#{LOG_FOLDER}/cron.log"}

every '0 * * * *', :roles => [:db] do
  %w(bami2).each do |name|
    rake "run[#{name}]"
  end
end

every '30 * * * *', :roles => [:db] do
  %w(seijit).each do |name|
    rake "run[#{name}]"
  end
end
