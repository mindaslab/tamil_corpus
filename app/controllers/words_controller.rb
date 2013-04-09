class WordsController < ApplicationController
  # GET /words
  # GET /words.json
  def index
    @words = Word.all
    @heeading = "All Words"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @words }
    end
  end

  # GET /words/1
  # GET /words/1.json
  def show
    @word = Word.find(params[:id])
    @tags = @word.tags.order(:name)
    @untags = Tag.order(:name) - @tags
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @word }
    end
  end

  # GET /words/new
  # GET /words/new.json
  def new
    @word = Word.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @word }
    end
  end

  # GET /words/1/edit
  def edit
    @word = Word.find(params[:id])
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(params[:word])

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render json: @word, status: :created, location: @word }
      else
        format.html { render action: "new" }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /words/1
  # PUT /words/1.json
  def update
    @word = Word.find(params[:id])

    respond_to do |format|
      if @word.update_attributes(params[:word])
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    respond_to do |format|
      format.html { redirect_to words_url }
      format.json { head :no_content }
    end
  end
  
  def tagged
    @words = Word.where(tagged: true)
    @heading = "Tagged Words" 
    render :index 
  end
  
  def untagged
    @words = Word.where(tagged: false)
    @heading = "Untagged Words"
    render :index
  end
  
  def locked
    @words = Word.where(locked: true)
    @heading = "Locked Words"
    render :index
  end
  
  def tag
    tag = Tag.find(params[:tag_id])
    word = Word.find(params[:id])
    word.tags << tag
    word.tagged = true
    word.save
    # @untags = Tag.order(:name) - word.tags
    respond_to do |format|
      format.js{}
    end
  end
  
  def untag
    tag = Tag.find(params[:tag_id])
    word = Word.find(params[:id])
    word.tags.delete tag
    word.tagged = false if word.tags.count == 0 
    word.save
    # @tags = word.tags
    respond_to do |format|
      format.js{}
    end
  end
  
  def refresh_tags
    @tags = Word.find(params[:id]).tags.order(:name)
    render layout: 'none'
  end
  
  def refresh_untags
    @untags = Tag.order(:name) - Word.find(params[:id]).tags
    render layout: 'none'
  end
  
  def lock_it
    word = Word.find(params[:id])
    word.locked = true
    word.save
    redirect_to word, notice: "Word has been locked"
  end
  
  def unlock_it
    word = Word.find(params[:id])
    word.locked = false
    word.save
    redirect_to word, notice: "Word has ben unlocked"
  end
end
