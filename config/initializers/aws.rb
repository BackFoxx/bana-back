require 'aws-sdk-s3'

Aws.config.update({
                    region: 'ap-northeast-2',
                    credentials: Aws::Credentials.new(ENV['ACCESS_KEY'], ENV['SECRET_ACCESS_KEY']),
                  })

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET'])