namespace :subscriptions do
  desc 'Process all subscriptions with next renewal date set for today'
  task :process do
    Subscription.to_process.each do |subscription|
      Subscriptions::ProcessRenewal.new(subscription).call
    end
  end
end
