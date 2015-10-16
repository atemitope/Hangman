require_relative "spec_helper"

  describe HangMan::GamePlay do
    let(:game) { HangMan::GamePlay.new }
    let(:display) { HangMan::Display.new }
    let(:save_load) { HangMan::SaveLoad.new(@game)}
    let(:dictionary) {HangMan::Dictionary.new}


  it "should check if class GamePlay exits" do
    expect(game.class).to eql(HangMan::GamePlay)
  end

  it "should check if class Display exits" do
    expect(display.class).to eql(HangMan::Display)
  end

  it "should check if class SaveLoad exits" do
    expect(save_load.class).to eql(HangMan::SaveLoad)
  end

    it "should check if class Dictionary exits" do
    expect(dictionary.class).to eql(HangMan::Dictionary)
  end


  describe "#get_user_input" do
    before :each do 
      allow(display).to receive(:display_new_intro).and_return(nil)
      # allow(game).to receive(:puts).and_return(nil)
      allow(display).to receive(:intro).and_return(nil)
      allow(game).to receive(:sleep).and_return(nil)
      allow(display).to receive(:intro).and_return(nil)
      # allow(display.intro).to receive(:puts).and_return(nil)
    end


    it "should return true for load game input" do 
      allow(game).to receive(:gets).and_return("load")
      allow(game).to receive(:load_initial_saved_game).and_return(true)
      expect(game.get_user_input).to be true
    end
  


    
    it "should return true for start game input" do
      allow(game).to receive(:gets).and_return("start")
      allow(game).to receive(:start_new_game).and_return(true)
      expect(game.get_user_input).to be true
    end
  

  
    it "should throw an error for exit game input" do
      allow(game).to receive(:gets).and_return("exit")
      allow(game).to receive(:start_new_game).and_return(true)
      expect{game.get_user_input}.to raise_error SystemExit
    end
 

    it "should throw an error for inappropriate input" do
      allow(game).to receive(:gets).and_return("test")
      allow(game).to receive(:start_new_game).and_return(nil)
      expect{game.get_user_input}.to raise_error SystemExit
    end
  end


  describe "#start_new_game" do
    before :each do
      allow(game).to receive(:puts).and_return(nil)
      allow(game).to receive(:sleep).and_return(nil)
      allow(game).to receive(:gets).and_return(nil)
    end

    it "should return true for successful method call" do
      allow(game).to receive(:generate_remaining_letters).and_return(nil)
      game.start_new_game
      expect(game.word).to be_an(Array) 
    end


    it "should return true for successful method call" do
      allow(dictionary).to receive(:generate_word).and_return(nil)
      allow(game).to receive(:generate_remaining_letters).and_return(true)
      expect(game.start_new_game).to be true
    end
  end



  describe "#load_initial_saved_game" do
    it "should return true for a successful method call" do
      allow(game).to receive(:puts).and_return(nil)
      allow(game).to receive(:sleep).and_return(nil)
      allow(save_load).to receive(:load_game).and_return(true)
      allow(game).to receive(:game_save).and_return(save_load)
      expect(game.load_initial_saved_game).to be true
    end
  end


  describe "#exit_game" do
    it "acts on appropriate input" do
      allow(game).to receive(:puts).and_return(nil)
      expect{game.exit_game}.to raise_error SystemExit
    end
  end


  describe "#generate_remaining_letters" do

    it "should return true for for appropriate variable assignment" do
      game.instance_variable_set(:@word, "andela")
      # require "pry"; binding.pry
      allow(game).to receive(:generate_lives).and_return(true)
      game.generate_remaining_letters
      expect(game.remaining_letters).to eql(game.word)
      expect(game.generate_remaining_letters).to be true
    end
  end

  describe "#generate_lives" do

    it "should return true for the appropriate method call" do
      game.instance_variable_set(:@word, "tabernacle")
      allow(game).to receive(:initial_visual_update).and_return(nil)
      game.generate_lives
      expect(game.lives).to eql 8
    end

    it "should return true for the appropriate method call" do
      game.instance_variable_set(:@word, "oscar")
      allow(game).to receive(:initial_visual_update).and_return(nil)
      game.generate_lives
      expect(game.lives).to eql 4
    end

    it "should return true for the appropriate method call" do
      allow(game).to receive(:word).and_return("a"*11)
      allow(game).to receive(:/).and_return(nil)
      allow(game).to receive(:+).and_return(nil)
      allow(game).to receive(:initial_visual_update).and_return(true)
      expect(game.generate_lives).to be true
    end
  end



  describe "#display_lives" do
     it "should return true for appropriate method call" do
      allow(game).to receive(:puts).and_return(nil)
      allow(game).to receive(:visual_update).and_return(true)
      expect(game.display_lives).to be true
    end
  end


  describe "#initial_visual_update" do
     it "should return true for appropriate method call" do
      allow(game).to receive(:game_play).and_return(true)
      allow(game).to receive(:puts).and_return(nil)
      game.instance_variable_set(:@word, "tabernacle")
      game.initial_visual_update
      expect(game.answer_display).to eql("_ _ _ _ _ _ _ _ _ _ ")
      expect(game.answer).to eql( ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_"] )
      expect(game.initial_visual_update).to eql true
    end
  end


  describe "#load_saved_game" do
    it "should raise an ArgumentError error if no parameters are passed" do
      expect { game.load_saved_game }.to raise_error(ArgumentError)
    end

    it "should return true for appropriate method call and all test cases" do
      allow(game).to receive(:visual_update).and_return(true)
      allow(game).to receive(:puts).and_return(nil)
      game.instance_variable_set(:@word, "tabernacle")
      game.load_saved_game("tabernacle", "nacle", "t a b e r _ _ _ _ _ ", 5 )
      expect(game.word).to eql("tabernacle")
      expect(game.remaining_letters).to eql("nacle")
      expect(game.answer).to eql("t a b e r _ _ _ _ _ ")
      expect(game.lives).to eql(5)
    end
  end

  describe "#visual_update" do

    it "should return true for appropriate method call" do
      allow(game).to receive(:game_play).and_return(true)
      allow(game).to receive(:puts).and_return(nil)
      game.instance_variable_set(:@word, ["t","a","b","e","r","n","a","c","l","e"])
      game.instance_variable_set(:@answer, ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_"])
      game.instance_variable_set(:@guess, "n")
      game.visual_update
      expect(game.visual).to eql(["_", "_", "_", "_", "_", "n", "_", "_", "_", "_"])
      expect(game.visual_update).to be true
    end
  end


  describe "#game_play" do
    it "should return true for appropriate method call" do
      allow(game).to receive(:lives).and_return(1)
      allow(game.win_lose).to receive(:game_over).and_return(nil)
      allow(game).to receive(:remaining_letters).and_return([])
      allow(game).to receive(:word).and_return([])
      allow(game).to receive(:puts).and_return(nil)
      allow(game.win_lose).to receive(:overall_success).and_return(true)
      expect(game.game_play).to be true
    end
  


    it "should return true for appropriate method call" do
      allow(game).to receive(:lives).and_return(1)
      allow(game.win_lose).to receive(:game_over).and_return(nil)
      allow(game).to receive(:remaining_letters).and_return("abc")
      allow(game.win_lose).to receive(:overall_success).and_return(nil)
      allow(game).to receive(:gets).and_return("h")
      allow(game).to receive(:input_check).and_return(true)
      expect(game.game_play).to be true
    end


   it "should return true for appropriate method call" do
      allow(game).to receive(:lives).and_return(1)
      allow(game.win_lose).to receive(:game_over).and_return(nil)
      allow(game).to receive(:remaining_letters).and_return([])
      allow(game).to receive(:word).and_return([])
      allow(game.win_lose).to receive(:overall_success).and_return(true)
      allow(game).to receive(:gets).and_return(nil)
      allow(game).to receive(:input_check).and_return(nil)
      expect(game.game_play).to be true
    end

    it "should return true for appropriate method call" do
      allow(game).to receive(:lives).and_return(0)
      allow(game.win_lose).to receive(:game_over).and_return(true)
      expect(game.game_play).to be true
    end
  end


  describe "#save_quit" do
    before :each do 
      allow(game).to receive(:puts).and_return(nil)
      allow(display).to receive(:display_save_menu).and_return(nil)
    end

    it "should raise SystemExit error message" do
      allow(game).to receive(:gets).and_return("s")
      allow(game).to receive(:strip).and_return(nil)
      allow(game.game_save).to receive(:save_game).with(game).and_return(true)
      expect(game.save_quit).to be true
    end 

    it "should raise SystemExit error message" do
      allow(game).to receive(:gets).and_return("q")
      expect{game.save_quit}.to raise_error SystemExit
    end

  
    it "should return true for appropriate method call" do
      allow(game).to receive(:gets).and_return('l')
      allow(game).to receive(:downcase).and_return(nil)
      allow(game).to receive(:strip).and_return(nil)
      allow(game.game_save).to receive(:load_game).and_return(false)
      expect(game.save_quit).to be false
    end

     
    it "acts on load game option of the save_quit method" do
      allow(game).to receive(:gets).and_return("r")
      allow(game).to receive(:game_play).and_return(true)
      expect(game.save_quit).to be true
    end

     it "acts on load game option of the save_quit method" do
      allow(game).to receive(:gets).and_return("g")
      allow(game).to receive(:puts).and_return(nil)
      allow(game).to receive(:save_quit).and_return(true)
      expect(game.save_quit).to be true
    end
  end

  describe "#input_check" do
    before :each do 
      game.instance_variable_set(:@remaining_letters, ["t","a","b","e","r","n","a","c","l","e"])
    end

    it "should return true for the appropriate method call" do
      game.instance_variable_set(:@guess, "t")
      allow(game).to receive(:good_guess).and_return(true)
      expect(game.input_check).to be true
    end

    it "should return true for the appropriate method call" do
      game.instance_variable_set(:@guess, "2")
      allow(game).to receive(:puts).and_return(true)
      allow(game).to receive(:game_play).and_return(true)
      expect(game.input_check).to be true
    end

    it "should return true for the appropriate method call" do
      game.instance_variable_set(:@guess, "*")
      allow(game).to receive(:save_quit).and_return(true)
      expect(game.input_check).to be true
    end

    it "should return true for the appropriate method call" do
      game.instance_variable_set(:@guess, "w")
      allow(game).to receive(:wrong_guess).and_return(true)
      expect(game.input_check).to be true
    end
  end


  describe "#good_guess" do
    it "should return true for appropriate method call" do
      game.instance_variable_set(:@remaining_letters, ["t","a","b","e","r","n","a","c","l","e"])
      game.instance_variable_set(:@guess, "t")
      allow(display).to receive(:display_good_guess).and_return(true)
      allow(game).to receive(:puts).and_return(nil)
      allow(game).to receive(:display_lives).and_return(true) 
      allow(game).to receive(:visual_update).and_return(true)
      expect(game.good_guess).to be true
      expect(game.remaining_letters).to eql(["a","b","e","r","n","a","c","l","e"])
    end
  end


  describe "#wrong_guess" do
    it "should return true for appropriate method call" do
      game.instance_variable_set(:@lives, 4)
      allow(display).to receive(:display_good_guess).and_return(true)
      allow(game).to receive(:puts).and_return(nil)
      allow(game).to receive(:display_lives).and_return(true) 
      allow(game).to receive(:visual_update).and_return(true)
      expect(game.wrong_guess).to be true
      expect(game.lives).to eql(3)
    end
  end
end