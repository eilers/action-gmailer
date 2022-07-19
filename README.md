# ActionMailer delivery method for oauth2/smtp

Get access to [Gmail IMAP and STMP via OAuth2](https://developers.google.com/google-apps/gmail/xoauth2_protocol) using [ActionMailer](https://github.com/rails/rails/tree/master/actionmailer) or just a plain [Mail::Message](https://github.com/mikel/mail)

It's using the [gmail_xauth gem](https://github.com/nfo/gmail_xoauth) so it can be extended to support a few other auth variants pretty simple.

# Installation

Add the following to your Gemfile:

    gem 'action-gmailer'

# Configuration

You need to set oauth2_token and account to send mail with `ActionGmailer`. For more information, check [SASL XOAUTH2](https://developers.google.com/google-apps/gmail/xoauth2_protocol)

## Using Rails and ActionMailer:

    settings = {
      smtp_host:    'FIXME', # default: 'smtp.gmail.com'
      smtp_port:    'FIXME', # default: 587
      helo_domain:  'FIXME', # default:'gmail.com'
      auth_type:    'FIXME', # default: :xoauth2
      oauth2_token: 'FIXME',
      account:      'FIXME'
    }

    config.action_mailer.delivery_method = :action_gmailer
    config.action_mailer.action_gmailer_settings = settings

## Using a plain Mail::Message

    mail = Mail.new {
      from    "from@example.com"
      to      "to@example.com
      subject "test subject"
      body    'test mail body'
    }
    mail.delivery_method ActionGmailer::DeliveryMethod, settings

# Testing/Development

Run all tests

    rake

Run all tests with sending a live email, uncomment the skips and set some secret env variables.

    ACTION_GMAILER_ACCOUNT='joel@example.com' ACTION_MAILER_OAUTH2_TOKEN='FIXME' rake

# Contributing to action_gmailer

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

# Copyright

Copyright (c) 2013 Joel Larsson. See LICENSE.txt for
further details.
