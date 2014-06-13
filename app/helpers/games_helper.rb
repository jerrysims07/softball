module GamesHelper

  def process_date_params params
    p = {}
    p[:year] =    params[:game]["date(1i)"]
    p[:month] =   params[:game]["date(2i)"]
    p[:day] =     params[:game]["date(3i)"]
    p[:hour] =    params[:game]["date(4i)"]
    p[:minute] =  params[:game]["date(5i)"]
    p
  end
end
