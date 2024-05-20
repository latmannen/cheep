class RecommendationsController < ApplicationController
  def index
    matching_recommendations = Recommendation.all

    @list_of_recommendations = matching_recommendations.order({ :created_at => :desc })

    render({ :template => "recommendations/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_recommendations = Recommendation.where({ :id => the_id })

    @the_recommendation = matching_recommendations.at(0)

    render({ :template => "recommendations/show" })
  end

  def create
    the_recommendation = Recommendation.new
    the_recommendation.user_id = params.fetch("query_user_id")
    the_recommendation.visit_type = params.fetch("query_visit_type")
    the_recommendation.interests = params.fetch("query_interests")
    the_recommendation.other_content = params.fetch("query_other_content")

    if the_recommendation.valid?
      the_recommendation.save
      
      #create the system message
      system_message = Message.new
      system_message.rec_id = the_recommendation.id
      system_message.role = "system"
      system_message.content = "You are a an expert on recommending activities, restuarants, and generally things to do in the city of chicago. you should respond succinctly when giving recommendations. The person asking for advice is a #{the_recommendation.visit_type}, and your responses should reflect that. The person asking for advice also has these interests: #{the_recommendation.interests}. Please tailor your recommendations to those interests, but feel free to provide your best recommendations that might fall outside of those interests as well. Finally, here is some additional context that the user might provide: #{the_recommendation.other_content}"
      system_message.save

      #create the assistant response

      prior_messages = [
        { role: "user", content: "system_message.content"}
      ]

      client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

      api_response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo", # Required.
            messages: prior_messages, # Required.
            temperature: 0.7})

        pp api_response

      redirect_to("/recommendations/#{the_recommendation.id}", { :notice => "Recommendation created successfully." })
    else
      redirect_to("/recommendations", { :alert => the_recommendation.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recommendation = Recommendation.where({ :id => the_id }).at(0)

    the_recommendation.user_id = params.fetch("query_user_id")
    the_recommendation.visit_type = params.fetch("query_visit_type")
    the_recommendation.interests = params.fetch("query_interests")
    the_recommendation.other_content = params.fetch("query_other_content")

    if the_recommendation.valid?
      the_recommendation.save
      redirect_to("/recommendations/#{the_recommendation.id}", { :notice => "Recommendation updated successfully."} )
    else
      redirect_to("/recommendations/#{the_recommendation.id}", { :alert => the_recommendation.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recommendation = Recommendation.where({ :id => the_id }).at(0)

    the_recommendation.destroy

    redirect_to("/recommendations", { :notice => "Recommendation deleted successfully."} )
  end
end
