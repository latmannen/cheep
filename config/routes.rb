Rails.application.routes.draw do
  # Routes for the Message resource:

  root "recommendations#index"
  
  # CREATE
  post("/insert_message", { :controller => "messages", :action => "create" })
          
  # READ
  get("/messages", { :controller => "messages", :action => "index" })
  
  get("/messages/:path_id", { :controller => "messages", :action => "show" })
  
  # UPDATE
  
  post("/modify_message/:path_id", { :controller => "messages", :action => "update" })
  
  # DELETE
  get("/delete_message/:path_id", { :controller => "messages", :action => "destroy" })

  #------------------------------

  # Routes for the Recommendation resource:

  # CREATE
  post("/insert_recommendation", { :controller => "recommendations", :action => "create" })
          
  # READ
  get("/recommendations", { :controller => "recommendations", :action => "index" })
  
  get("/recommendations/:path_id", { :controller => "recommendations", :action => "show" })
  
  # UPDATE
  
  post("/modify_recommendation/:path_id", { :controller => "recommendations", :action => "update" })
  
  # DELETE
  get("/delete_recommendation/:path_id", { :controller => "recommendations", :action => "destroy" })

  #------------------------------

  devise_for :users

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  
end
