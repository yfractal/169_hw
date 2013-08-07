Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :github, 'c2bdd4c17ba750c12c2f', '7cadfc67698002022ce9c335cb7bb9390ed19718'
  # provider :github, 'd78181e1ec709f32d844', '7fd79b37dd8a4423c5989b6ae6d4fe358af11dc'
  provider :twitter, 'jhtFvB56v87qZSFVlxQ', 'ik6z317IAtHUAXiLEczL8GRCgmO5TJBtmwSlGKR05k'
  provider :douban, '0af46e302d26a64620dd4a908773f2d2', 'a42a2641d69b5d50'
end