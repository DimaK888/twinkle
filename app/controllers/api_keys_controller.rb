# frozen_string_literal: true
class ApiKeysController < ApplicationController
  def new
    authorize ::User, :create_api_key?

    @expire_at = params.require(:expire_at).to_s.to_time
    if Time.current > @expire_at
      redirect_to profile_url, error: 'Expire at less then now'
      return
    end

    @token = ::Knock::AuthToken.new(payload: token_claims).token
  end

  private

  def token_claims
    {
      sub: current_user.id,
      exp: @expire_at.to_i
    }
  end
end