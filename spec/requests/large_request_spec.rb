# Large requests can fail if Devise tries to store the URL in the session cookie.
#
# http://daniel.fone.net.nz/blog/2014/11/28/actiondispatch-cookies-cookieoverflow-via-devise-s-user_return_to/
require 'spec_helper'

RSpec.describe 'A very large request', type: :request do
  it 'should not overflow cookies' do
    get '/admin', foo: 'x' * ActionDispatch::Cookies::SignedCookieJar::MAX_COOKIE_SIZE
    expect(response).to redirect_to 'http://www.example.com/#login?after_login=/admin'
  end
end
