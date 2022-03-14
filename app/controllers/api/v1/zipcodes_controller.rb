module Api
    module V1
        class ZipcodesController < ApplicationController
            def index
                zipcodes = Zipcode.order('RANDOM()').limit(20);
                if zipcodes
                    render json: {
                        data: zipcodes
                    }, status: :ok
                else
                    render json: {
                        status: 422,
                        message: 'Invalid information',
                        data: zipcodes
                    }, status: :unprocessable_entity
                end
            end

            def show
                zipcode = Zipcode.find_by(zipcode: params[:id]);
                if zipcode
                    render json: {
                        zipcode: zipcode[:zipcode],
                        locality: zipcode[:locality],
                        federal_entity: zipcode[:federal_entity],
                        settlements: {
                            name:zipcode[:municipality]
                        },
                        municipality: zipcode[:municipality]
                    }, status: :ok
                else
                    render json: {
                        status: 422,
                        message: 'Zipcode not valid',
                        data: zipcode
                    }, status: :unprocessable_entity
                end
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
