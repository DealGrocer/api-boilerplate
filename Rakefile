desc 'Run Shumoku Specs'
task spec: :environment do
  require 'microspec'

  runner = Microspec::Runner.new
  runner.includes << 'spec/**/*.rb'
  runner.excludes << 'spec/examples/**/*.rb'

  success = runner.perform

  exit 1 unless success
end
