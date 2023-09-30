FactoryBot.define do
  factory :postit do
    title { "MyString" }
    body { "MyText" }
    user { nil }
  end
end
