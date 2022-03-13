module Api
    module V1
        class ZipcodesController < ApplicationController
            def index
                zipcodes = Zipcode.order('zipcode').limit(20);
                render json: {
                    status: 200,
                    message: 'Zipcodes loaded',
                    data: zipcodes
                }, status: :ok
            end

            def show
                zipcode = Zipcode.find_by(zipcode: params[:id]);
                render json: {
                    status: 200,
                    message: 'Zipcode loaded',
                    data: zipcode
                }, status: :ok
            end

            def create
                zipcode = Zipcode.new(zipcode_params);
                if zipcode.save
                    render json: {
                        status: 200,
                        message: 'Zipcode added',
                        data: zipcode
                    }, status: :ok
                else
                    render json: {
                        status: 500,
                        message: 'Zipcode failed to add',
                        data: zipcode.errors
                    }, status: :unprocessable_entity
                end
            end

            def destroy
                zipcode = Zipcode.find(params[:id]);
                if zipcode.destroy
                    render json: {
                        status: 200,
                        message: 'Zipcode deleted',
                        data: zipcode
                    }, status: :ok
                else
                    render json: {
                        status: 500,
                        message: 'Zipcode failed to delete',
                        data: zipcode.errors
                    }, status: :unprocessable_entity
                end
            end

            def update
                zipcode = Zipcode.find(params[:id]);
                if zipcode.update_attributes(zipcode_params)
                    render json: {
                        status: 200,
                        message: 'Zipcode updated',
                        data: zipcode
                    }, status: :ok
                else
                    render json: {
                        status: 500,
                        message: 'Zipcode failed to update',
                        data: zipcode.errors
                    }, status: :unprocessable_entity
                end
            end

            private
            
            def zipcode_params
                params.permit(:zipcode, :locality, :federal_entity, :municipality)
            end
        end
    end
end
