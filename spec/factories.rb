FactoryGirl.define do
  factory :category do
    name 'BOOKS'
  end

  factory :expense do
    name 'Cook the books'
  end

  # factory :done_task, :class => :task do
  #   name 'finish the job'
  #   association :list, :factory => :list
  # end
end