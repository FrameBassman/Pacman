package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author denis sychev
	 */
	public class Main extends Sprite 
	{
		private var game:StartGame;
		private var start:login;
		
		public function Main() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			this.start = new login();
			this.start.addEventListener(typeof NewGame, this.onNewGame);
			this.addChild(this.start);
			
			//this.startGame(null);
		}
		
		private function startGame(e:NewGame):void {
			this.game = new StartGame(e);
			this.addChild(this.game);
			this.game.addEventListener(typeof NewGame, this.onNewGame);
		}
		
		private function onNewGame(e:NewGame):void {
			if (this.game != null){
				this.game.Dispose();
				this.removeChild(this.game);
				this.game.removeEventListener(typeof NewGame, this.onNewGame);
			} else {
				this.start.removeEventListener(typeof NewGame, this.onNewGame);
				this.removeChild(this.start);				
				e = null;
			}
			
			this.startGame(e);
			this.stage.focus = this.game;
		}
		
	}

}