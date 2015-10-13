require_relative "spec_helper"

  describe HangMan::GamePlay do
    before :each do
    @game = HangMan::GamePlay.new
    @display = HangMan::Display.new 
    @save_load = HangMan::SaveLoad.new
  end


  it "should check if class GamePlay exits" do
    expect(@game.class).to eql(HangMan::GamePlay)
  end

  it "should check if class Display exits" do
    expect(@display.class).to eql(HangMan::Display)
  end

  it "should check if class SaveLoad exits" do
    expect(@save_load.class).to eql(HangMan::SaveLoad)
  end

  describe "#get_user_input" do
    before :each do 
      allow(@display).to receive(:display_new_intro).and_return(nil)
      allow(@game).to receive(:puts).and_return(nil)
      allow(@display).to receive(:intro).and_return(nil)
      allow(@game).to receive(:sleep).and_return(nil)
      allow(@display).to receive(:intro).and_return(nil)
      allow(@display.intro).to receive(:puts).and_return(nil)
    end


    it "should return true for load game input" do 
      allow(@game).to receive(:gets).and_return("load")
      allow(@game).to receive(:load_initial_saved_game).and_return(true)
      expect(@game.methods.include? :get_user_input).to eql(true)
      expect(@game.get_user_input).to be true
    end
  


    
    it "should return true for start game input" do
      allow(@game).to receive(:gets).and_return("start")
      allow(@game).to receive(:start_new_game).and_return(true)
      expect(@game.methods.include? :get_user_input).to eql(true)
      expect(@game.get_user_input).to be true
    end
  

  
    it "should throw an error for exit game input" do
      allow(@game).to receive(:gets).and_return("exit")
      allow(@game).to receive(:start_new_game).and_return(true)
      expect{@game.get_user_input}.to raise_error SystemExit
    end
 

    it "should throw an error for inappropriate input" do
      allow(@game).to receive(:gets).and_return("test")
      allow(@game).to receive(:start_new_game).and_return(nil)
      expect{@game.get_user_input}.to raise_error SystemExit
    end
  end


  describe "#start_new_game" do
    it "should return true for successful method call" do
      allow(@game).to receive(:puts).and_return(nil)
      allow(@game).to receive(:sleep).and_return(nil)
      allow(@game).to receive(:generate_word).and_return(true)
      expect(@game.start_new_game).to be true
    end
  end

  describe "#load_initial_saved_game" do
    it "should return true for successful method call" do
      allow(@game).to receive(:puts).and_return(nil)
      allow(@game).to receive(:sleep).and_return(nil)
      allow(@save_load).to receive(:load_game).and_return(true)
      allow(@game).to receive(:game_save_new).and_return(@save_load)
      expect(@game.load_initial_saved_game).to be true
    end
  end


  describe "#exit_game" do
    it "acts on appropriate input" do
      allow(@game).to receive(:puts).and_return(nil)
      expect{@game.exit_game}.to raise_error SystemExit
    end
  end

 
  describe "#generate_word" do

    it "should raise an ArgumentError error if no parameters passed" do
      expect { @game.generate_word }.to raise_error(ArgumentError)
    end
  end
  

  describe "#load_libraries" do

    it "should return true for for appropriate variable assignment" do
      allow(@game).to receive(:generate_lives).and_return(nil)
      expect(@game.remaining_letters).to eql(@game.word)
      expect(@game.methods.include? :load_libraries).to eql(true)
    end
  end


  describe "#generate_lives" do
    it "should return true for the appropriate method call" do
      allow(@game.word).to receive(:length).and_return(11)
      allow(@game).to receive(:/).and_return(nil)
      allow(@game).to receive(:+).and_return(nil)
      allow(@game).to receive(:initial_visual_update).and_return(true)
      expect(@game.generate_lives).to be true
    end
  end

  describe "#load_saved_game" do
    it "should raise an ArgumentError error if no parameters are passed" do
      expect { @game.generate_word }.to raise_error(ArgumentError)
    end
  end

  describe "#display_lives" do
    before :each do 
    end


    it "acts on appropriate input" do
      allow(@game).to receive(:puts).and_return(nil)
      allow(@game).to receive(:visual_update).and_return(true)
      expect(@game.display_lives).to be true
    end
  end


  describe "#game_play" do
    it "acts on appropriate input" do
      allow(@game).to receive(:lives).and_return(1)
      allow(@game).to receive(:game_over).and_return(nil)
      allow(@game.remaining_letters).to receive(:length).and_return(0)
      allow(@game.word).to receive(:join).and_return(nil)
      allow(@game).to receive(:puts).and_return(nil)
      allow(@game).to receive(:overall_success).and_return(true)
      expect(@game.game_play).to be true
    end
  


    it "acts on appropriate input" do
      allow(@game).to receive(:lives).and_return(1)
      allow(@game).to receive(:game_over).and_return(nil)
      allow(@game.remaining_letters).to receive(:length).and_return(3)
      allow(@game).to receive(:overall_success).and_return(nil)
      allow(@game).to receive(:gets).and_return("h")
      allow(@game).to receive(:input_check).and_return(true)
      expect(@game.game_play).to be true
    end


   it "acts on appropriate input" do
      allow(@game).to receive(:lives).and_return(1)
      allow(@game).to receive(:game_over).and_return(nil)
      allow(@game.remaining_letters).to receive(:length).and_return(0)
      allow(@game.word).to receive(:join).and_return(nil)
      allow(@game).to receive(:overall_success).and_return(true)
      allow(@game).to receive(:gets).and_return(nil)
      allow(@game).to receive(:input_check).and_return(nil)
      expect(@game.game_play).to be true
    end

    it "acts on appropriate input" do
      allow(@game).to receive(:lives).and_return(0)
      allow(@game).to receive(:game_over).and_return(true)
      expect(@game.game_play).to be true
    end
  end


  describe "#save_quit" do
    before :each do 
      allow(@game).to receive(:puts).and_return(nil)
      allow(@display).to receive(:display_save_menu).and_return(nil)
    end

    it "should raise SystemExit error message" do
      allow(@game).to receive(:gets).and_return("q")
      expect{@game.save_quit}.to raise_error SystemExit
    end

  
    it "should return true for appropriate method call" do
      allow(@game).to receive(:gets).and_return('l')
      allow(@game).to receive(:downcase).and_return(nil)
      allow(@game).to receive(:strip).and_return(nil)
      allow(@game.game_save).to receive(:load_game).and_return(false)
      expect(@game.save_quit).to be false
    end

     
    it "acts on load game option of the save_quit method" do
      allow(HangMan::Display.new).to receive(:display_save_menu).and_return(nil)
      allow(@game).to receive(:gets).and_return("r")
      allow(@game).to receive(:game_play).and_return(true)
      expect(@game.save_quit).to be true
    end
  end





  describe "#good_guess" do
    it "acts on appropriate input" do
      allow(@game.remaining_letters).to receive(:delete).and_return(nil)
      allow(@display).to receive(:display_good_guess).and_return(true)
      allow(@game).to receive(:visual_update).and_return(true)
      expect(@game.good_guess).to be true
    end
  end

  describe "#overall_success" do

    it "acts on appropriate input" do
      allow(@display).to receive(:display_good_game).and_return(nil)
      allow(@game).to receive(:gets).and_return("y")
      allow(@game).to receive(:get_user_input).and_return(true)
      expect(@game.overall_success).to be true
    end
  

    it "should be able to return false for overall success" do
      allow(@display).to receive(:display_good_game).and_return(nil)
      allow(@game).to receive(:gets).and_return("n")
      allow(@game).to receive(:get_user_input).and_return(true)
      allow(@game).to receive(:exit).and_return(false)
      expect(@game.overall_success).to be false
    end



    it "acts on appropriate input" do
      allow(HangMan::Display.new).to receive(:display_good_game).and_return(nil)
      allow(@game).to receive(:gets).and_return("n")
      allow(@game).to receive(:get_user_input).and_return(nil)
      expect{@game.overall_success}.to raise_error SystemExit
    end
  end


  describe "#game_over" do
    it "acts on appropriate input" do
      allow(@game).to receive(:puts).and_return(nil)
      allow(@game.word).to receive(:join).and_return("word")
      allow(@display).to receive(:display_game_over).and_return(nil)
      allow(@game).to receive(:gets).and_return("y")
      allow(@game).to receive(:get_user_input).and_return(nil)
      expect(@game.game_over).to be nil
    end
  end

end