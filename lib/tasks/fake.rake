namespace :fake do
  desc '創造 10 個假活動'
  task events: :environment do
    10.times do |i|
      Admin::Event.create title:"活動 #{i+1}",
        start_date: Time.at(rand * Time.now.to_i),
        place: "地點 #{i+1}",
        description: "敘述 #{i+1}"
    end
  end
end