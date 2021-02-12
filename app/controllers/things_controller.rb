class ThingsController < ApplicationController
    skip_before_action :authorized, only: [:create]
    def index
        things = Thing.all 
        render json: things
    end
end
