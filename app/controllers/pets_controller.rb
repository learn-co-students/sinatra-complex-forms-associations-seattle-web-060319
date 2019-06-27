class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all 
    erb :'/pets/new'
  end
  post '/pets' do 
    @pet = Pet.create(name: params[:pet][:name])
    if params["pet"]["owner_id"].class == Array
      @pet.owner_id = params["pet"]["owner_id"][0]
    else
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = @owner.id
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owner = Owner.find(@pet.owner_id)
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end
end