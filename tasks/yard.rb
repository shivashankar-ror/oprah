require 'yard'
require 'yard/rake/yardoc_task'

YARD::Rake::YardocTask.new(:doc) do |t|
  t.files   = ['lib/**/*.rb']
  t.options = %w{
    --verbose
    --markup markdown
    --readme README.md
    --tag comment
    --hide-tag comment
    --hide-void-return
    -M
    redcarpet
  }
end
