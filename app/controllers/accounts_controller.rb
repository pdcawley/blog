class AccountsController < ApplicationController
  layout  'admin'

  def login
    case @request.method
      when :post
      if @session[:user] = User.authenticate(@params[:user_login], @params[:user_password])

        flash['notice']  = "Login successful"
        redirect_back_or_default :action => "welcome"
      else
        flash.now['notice']  = "Login unsuccessful"

        @login = @params[:user_login]
      end
    end
  end
  
  def signup
    redirect_to :action => "login" unless User.count.zero?
    
    @user = User.new(@params[:user])
    
    if @request.post? and @user.save
      @session[:user] = User.authenticate(@user.login, @params[:user][:password])
      flash['notice']  = "Signup successful"
      redirect_to :controller => "admin/general", :action => "index"
    end      
  end  
  
  def logout
    @session[:user] = nil
  end
    
  def welcome
  end
  
end
