module OmniAuthUser

  def mock_omniauth_user
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => 'twitter',
      :uid => '309565235',
      :info => { :nickname => 'hearmemihir',
      :image => "mock_user_thumbnail_url"},
      :credentials => { :token =>"222333444" }
    })
  end
end
