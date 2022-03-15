class MessageController < ApplicationController
    before_action :json_payload

    def index
        begin
          request_data = @data
          data = []
          response_data = []
          context_table = Context.all

          if request_data.is_a? Array #in a correct body format
            data = request_data
          else
            data.push request_data
          end

          data.each do |d|
            if d.key?("conversion_id") && d.key?("message")
                r = Hash.new
                r[:response_id] = d['conversion_id']

                d['message'].split(' ').each { |mes|
                    break if r.key?(:response)

                    for i in context_table
                        break if r.key?(:response)
                        r[:response] = i.message if i.context.downcase.match(mes.downcase)
                    end
                }

                unless r.key?(:response)
                    r[:response] = 'Sorry, I don’t understand.'
                end 

                response_data.push r
            else
                raise 'Invalid JSON format'
            end
          end 

          render json: response_data

        rescue => e
          render json: {error: "Invalid JSON format : #{e.message}"}, status: :unprocessable_entity
        end
    end

    private

    def json_payload
        begin
            @data = JSON.parse(request.body.read)
        rescue JSON::ParserError => e
            render json: {error: "Invalid JSON format"}, status: :unprocessable_entity
        end 
    end

end
