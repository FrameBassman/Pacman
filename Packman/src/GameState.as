package  
{
		import flash.display.Bitmap;
		import flash.display.BitmapData;
		import flash.display.Shader;
		import flash.display.Shape;
		import flash.display.Sprite;
		import flash.events.Event;
		import flash.events.MouseEvent;
		import flash.net.URLLoader;
		import flash.net.URLRequest;
		
		import flash.geom.*;
		
	/**
	 * ...
	 * @author denis sychev
	 */
	public class GameState extends Sprite implements IDispose
	{
		public static var countLoad:int = 0;
		private var size:Number = MapMatrix.mapWidth;
		
		private var mobs:Vector.<Monster>;
		
		private var directX:Number = 1;
		private var directY:Number = 0;
		
		private var circle:Shape = new Shape();
		
		private var packmanX:Number = 10000;
		private var packmanY:Number = 10000;
		
		private var map:MapMatrix;
		private var count:Number = 10;
		public var packmanColor:Number = 0xffff00;
		public var deadPackmanColor:Number = 0xff0000;
		
		private var btnSave:Button = new Button('Save');
		private var btnLoad:Button = new Button('Load');
		
		private var loader = new URLLoader();
		
		private var gameScore:ScoreCounter;
		
		public function GameState(map:MapMatrix, score:ScoreCounter, mobsCoord:Array) 
		{			
			this.gameScore = score;
			this.btnSave.x = 970;
			this.btnSave.y = 30;
			
			this.btnLoad.x = 970;
			this.btnLoad.y = 70;
			
			this.addChild(this.btnLoad);
			this.addChild(this.btnSave);
			
			this.x = MapMatrix.deltaX;
			this.map = map;
			this.mobs = new Vector.<Monster>(count);
			
			for (var i:Number = 0; i < count; i++ ){
				this.mobs[i] = new Monster(this.map, 0, 0);
				
				if (mobsCoord == null){
					this.mobs[i].mobY = MapMatrix.squareSize * 1.5;
					this.mobs[i].mobX = MapMatrix.squareSize * i + MapMatrix.squareSize / 2;
				} else {
					this.mobs[i].mobY = mobsCoord[i][1];
					this.mobs[i].mobX = mobsCoord[i][0];
				}
				
				this.addChild(this.mobs[i]);
			}
			
			this.addEventListener(Event.ENTER_FRAME, this.maybeKill)
			this.btnLoad.addEventListener(MouseEvent.CLICK, this.onLoadHandler);
			this.btnSave.addEventListener(MouseEvent.CLICK, this.onSaveHandler);
		}
		
		private function onSaveHandler(e:Event):void {
			var result:String = '';
			
			for (var i:int = 0; i < this.mobs.length; i++) {
				// (this.mobX % MapMatrix.squareSize < 1) && (this.mobY % MapMatrix.squareSize < 1)
				result += (this.mobs[i].mobX - (this.mobs[i].mobX - MapMatrix.squareSize / 2) % MapMatrix.squareSize) + ':' + (this.mobs[i].mobY - (this.mobs[i].mobY - MapMatrix.squareSize / 2) % MapMatrix.squareSize) + ';';
			}
			result += '*' + this.packmanX + ':' + this.packmanY;
			
			result += '*' + this.gameScore.countScore;
			
			var map:String = '';
			
			for (var i:int = 0; i < this.map.scoreMatrix.length; i++ ) {
				map += this.map.scoreMatrix[i].toString() + '%';
			}
			
			result += '*' + map;
			
			var loader:URLLoader = new URLLoader();
			var b:URLRequest = new URLRequest("http://localhost:1444/save/" + result + '/' + login.UserName);
			loader.dataFormat = "text";
			loader.load(b);
		}
		
		private function onLoadHandler(e:Event):void {
			this.Dispose();
			
			this.loader = new URLLoader();
			this.loader.addEventListener(Event.COMPLETE, this.onGameLoaded);
			var b:URLRequest = new URLRequest("http://localhost:1444/load/" + login.UserName + '/' + GameState.countLoad++);
			this.loader.dataFormat = "text";
			this.loader.load(b);
		}
		
		private function onGameLoaded(e:Event) {
			var oldGame = this.loader.data;
			var mobs:Array = oldGame.split(';');
			
			var newGameArgs:NewGame = new NewGame(typeof NewGame);
			
			for (var i:int = 0; i < mobs.length - 1; i++ ) {
				newGameArgs.coords.push(mobs[i].split(':'));
			}
			var packmanData:Array = oldGame.split('*');
			newGameArgs.coords.push(packmanData[1]);
			newGameArgs.score = packmanData[2];
			
			var map:Array = packmanData[3].split('%');
			
			for (var i:int = 0; i < map.length - 1; i++ ) {
				newGameArgs.map.push(map[i]);
			}		
			 
			this.dispatchEvent(newGameArgs);
		}
		
		public function Dispose():void {
			this.removeEventListener(Event.ENTER_FRAME, this.maybeKill)
			
			for (var i:Number = 0; i < count; i++ ) {
				this.mobs[i].Dispose();
				this.removeChild(this.mobs[i]);
			}
		}
		
		private function maybeKill(event:Event):void {
			for (var i:Number = 0; i < count; i++ ){
				if ((Math.abs(this.mobs[i].mobY - this.packmanY) < MapMatrix.squareSize / 2) && (Math.abs(this.mobs[i].mobX - this.packmanX) < MapMatrix.squareSize / 2)) {
					this.packmanColor = this.deadPackmanColor;
					this.removeEventListener(Event.ENTER_FRAME, this.maybeKill)
				}
			}
		}
		
		public function setPackmansCord(x:Number, y:Number):void {
			this.packmanX = x;
			this.packmanY = y;
			
		}
	}
}