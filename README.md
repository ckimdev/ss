# README


## Required tool

Only required tool is [Docker]
- For Mac: Download [here](https://docs.docker.com/docker-for-mac/)
- For Ubuntu: Download [here](https://docs.docker.com/engine/installation/linux/ubuntu/)

## To start the server
```
1. docker build -t indie-app .
2. docker run -p 3000:3000 indie-app
3. Check your localhost @ port 3000! (http://localhost:3000)
```

## To run tests
```
docker run indie-app rspec
```

## To access deployed and live app.
* Running live [here](http://ec2-54-153-94-68.us-west-1.compute.amazonaws.com/)
* Deployed using Docker + AWS ECS ([EC2 Container Service](https://aws.amazon.com/ecs/))


## Why Rails?
This could have been built in purely frontend, pure javascript for example.
But that's a bit boring, so RoR it is!

## App Overview
* This is an extremly simple RoR App with **no model, 1 controller, 1 view, and 1 module.**
* `SearchController` at `app/controllers/search_controller.rb`
  * Uses `TrendingCampaign` moudle to access parsed and filtered campaign data.
* `Search#Index view` at `app/views/search/index.html.erb`
  * Uses result data from `SearchController` and displays the results (and the search bar too)
* `TrendingCampaign module` at `lib/trending_campaign.rb`
  * Makes an api call to Indiegogo API.
  * Correctly parses and filters the json API response
