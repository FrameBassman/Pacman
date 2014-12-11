package ;

import flash.Lib;
	
import flash.display.Sprite;
import flash.events.Event;

class Main
{
	private static var game:GameStage;
	
	static function main() 
	{
		startGame();
	}
	
	private static function onAddedToStage(e:Event) {
		startGame();
	}
	
	private static function startGame() {
		game = new GameStage();
		//this.addChild(this.game);
		Lib.current.addChild(game);
		game.addEventListener('NewGameEvent', onNewGame);
	}
	
	private static function onNewGame(e:Event) {
		//this.removeChild(this.game);
		game.removeEventListener('NewGameEvent', onNewGame);
		startGame();
		//this.stage.focus = this.game;
	}
}