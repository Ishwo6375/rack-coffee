class Application
 def call(env)
   req = Rack::Request.new(env)
#root url
  if req.path == '/'
    return [
        200,
        { 'Content-type' => 'application/json'},
         [{ message: "you're on the home page" }.to_json]
    ]

    # //Get Request//

    elsif req.path == '/coffees' && req.get?
    return[
        200,
        { 'Content-type' => 'application/json'},
        [ Coffee.all.to_json]
    ]

    #Post request
     elsif req.path == '/coffees' && req.post?
     body = JSON.parse(req.body.read)
     coffee = Coffee.create(body)
     return [
         200,
         { 'Content-type' => 'application/json'},
        [ Coffee.all.to_json]
     ]

      # get a resource by id
    elsif req.path.match(/coffees/) && req.get?
      id = req.path.split('/')[2]
      coffee = Coffee.find_by_id(id)

      if coffee 
        return [
          200,
          { 'Content-Type' => 'application/json' },
          [ coffee.to_json ]
        ]
      else
        return [
          204,
          { 'Content-Type' => 'application/json' },
          [ {}.to_json ]
        ]
      end

      #update a resource by id
       elsif req.path.match(/coffees/) && req.patch?
      id = req.path.split('/')[2]
      coffee = Coffee.find_by_id(id)
       body = JSON.parse(req.body.read)
       coffee.update(body)

        return [
          200,
          { 'Content-Type' => 'application/json' },
          [ coffee.to_json ]
        ]

        #delete a resource by id

        elsif req.path.match(/coffees/) && req.delete?
        id = req.path.split('/')[2]
        coffee = Coffee.find_by_id(id)
        coffee.destroy
           
        return [
            204,
            {},
            [' ']
        ]

        #search
    elsif req.path == '/coffees/search' && req.post?
    body = JSON.parse(req.body.read)
    field = body['field'].to_sym
    term = body['term']

    coffee = Coffee.find { |c| c[field].downcase.include?(term.downcase) }

    if coffee
     return[
         200,
         { 'Content-Type' => 'application/json' },
         [coffee.to_json]
     ]

     else
     return[
         204,
         {},
         [' ']
     ]
    end



     else
     return[
         400,
         {},
         [' OOOPS!!! sorry page not found.. try again later ']
     ]
  end
 end 
end