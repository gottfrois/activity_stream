require 'resque/tasks'

task "resque:setup" => :environment # Will load rails environment when starting queue
