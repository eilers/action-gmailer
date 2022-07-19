# encoding: utf-8
require 'helper'
require_relative '../lib/action_gmailer.rb'

describe ActionGmailer do

  let(:account)      { ENV['ACTION_GMAILER_ACCOUNT'] || 'not-set@example.com' }
  let(:oauth2_token) { ENV['ACTION_MAILER_OAUTH2_TOKEN'] || 'not-set' }
  let(:settings)     { { account: account, oauth2_token: oauth2_token } }
  subject            { ActionGmailer::DeliveryMethod.new(settings) }

  describe '#deliver!' do

    describe 'live mail' do
      describe 'with valid mail' do
        let(:mail) do
          email = account
          Mail.new do
            from    "#{email}"
            to      "#{email}"
            subject "test subject from #{email} to: #{email}"
            body    'test mail body'
          end
        end

        it 'you must set ENV[ACTION_GMAILER_*]' do
          skip
          account.wont_equal 'not-set@example.com'
          oauth2_token.wont_equal 'not-set'
        end

        it 'should deliver the mail' do
          skip
          subject.deliver!(mail)
        end

        it 'should deliver the mail, with delivery_method' do
          skip
          mail.delivery_method ActionGmailer::DeliveryMethod, settings
          mail.deliver
        end
      end
    end

    describe 'with invalid mail' do
      let(:mail) { Mail.new { body'test mail body' } }
      it 'should raise DeliveryError' do
        -> { subject.deliver!(mail) }.must_raise ActionGmailer::DeliveryError
      end
    end
  end

  describe '#initialize' do
    describe 'with valid settings' do

      specify { subject.account.must_equal account }
      specify { subject.oauth2_token.must_equal oauth2_token }
      specify { subject.smtp_host.must_equal 'smtp.gmail.com' }
      specify { subject.smtp_port.must_equal 587 }
      specify { subject.helo_domain.must_equal 'gmail.com' }
      specify { subject.auth_type.must_equal :xoauth2 }

      describe 'with no default accessors' do
        let(:smtp_host)   { 'smtp.example.com' }
        let(:smtp_port)   { 42 }
        let(:helo_domain) { 'example.com' }
        let(:auth_type)   { :example }
        let(:settings) do
          { account: account,
            oauth2_token: oauth2_token,
            smtp_port: smtp_port,
            smtp_host: smtp_host,
            helo_domain: helo_domain,
            auth_type: auth_type
          }
        end

        specify { subject.smtp_host.must_equal 'smtp.example.com' }
        specify { subject.smtp_port.must_equal 42 }
        specify { subject.helo_domain.must_equal 'example.com' }
        specify { subject.auth_type.must_equal :example }
      end
    end

    describe 'with invalid settings' do
      describe 'with no account' do
        let(:settings)     { { account: account } }
        it 'raises DeliveryError' do
          -> {
            ActionGmailer::DeliveryMethod.new(settings)
          }.must_raise ActionGmailer::DeliveryError
        end
      end

      describe 'with no oauth2_token' do
        let(:settings)     { { oauth2_token: oauth2_token } }
        it 'raises DeliveryError' do
          -> {
            ActionGmailer::DeliveryMethod.new(settings)
          }.must_raise ActionGmailer::DeliveryError
        end
      end
    end
  end
end
