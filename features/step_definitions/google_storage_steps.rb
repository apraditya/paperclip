Given /I validate my Google Storage credentials/ do
  key = ENV['GS_ACCESS_KEY_ID']
  secret = ENV['GS_SECRET_ACCESS_KEY']

  key.should_not be_nil
  secret.should_not be_nil

  assert_gs_credentials( key, secret )
end
