set :environment, :production

LOG_FOLDER="/srv/datahub/shared/log"
set :output, {:error => "#{LOG_FOLDER}/cron_error.log", :standard => "#{LOG_FOLDER}/cron.log"}

every 1.hours, :roles => [:db] do
  %w(bami2).each do |name|
    rake "run[#{name}]"
  end
end
