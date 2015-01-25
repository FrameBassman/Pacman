package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.LoaderContext;
	
	
	/**
	 * ...
	 * @author denis sychev
	 */
	public class MapMatrix extends Sprite implements IDispose 
	{
		static public var mapHeight:Number = 30;
		static public var mapWidth:Number = 30;
		static public var squareSize:int = 32;
		static public var deltaX:int = -150;
		
		public var matrix:Vector.<Number>;
		public var scoreMatrix:Vector.<Number>;
		public var mapMatrix:Vector.<Shape>;

		private var loader:URLLoader;
		
		public function MapMatrix()
		{
		}
		
		public function Init(oldScoreMatrix:Vector.<Number>):void {
			this.mapMatrix = new Vector.<Shape>();
			if (oldScoreMatrix != null && oldScoreMatrix.length > 0) {
					this.scoreMatrix = new Vector.<Number>();
						this.matrix = new Vector.<Number>();
					for (var i:int = 0; i < oldScoreMatrix.length; i++ ) {
						this.mapMatrix.push(new Shape());
						this.scoreMatrix.push(oldScoreMatrix[i]);
						this.matrix.push(oldScoreMatrix[i]);
					}
					
				this.x = deltaX;
				this.y = 0
					this.addEventListener(Event.ADDED_TO_STAGE, this.addedtoStageHandler);
					this.dispatchEvent(new MapLoadedEvent(typeof MapLoadedEvent));
					
					return;
			}
			
			this.x = deltaX;
			this.y = 0
			this.loader = new URLLoader();
			this.loader.addEventListener(Event.COMPLETE, onDataLoaded);
			var b:URLRequest = new URLRequest("http://localhost:1444/map.txt");
			this.loader.dataFormat = "text";
			this.loader.load(b);	
		}
		
		public function Dispose():void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.addedtoStageHandler);
			
			for (var i:Number = 0; i < mapWidth; i++) {
				for (var j:Number = 0; j < mapHeight; j++) {
					if (this.matrix[i * mapWidth + j] > 0) {
						this.removeChild(this.mapMatrix[i * MapMatrix.mapWidth + j]);
					}
				}
			}
		}
		
		private function onDataLoaded (e:Event):void {
			var a:String = this.loader.data;
			var split:Array = a.split(',');
			
			
			this.initMatrix(split);
			//this.initMap();
			
			this.addEventListener(Event.ADDED_TO_STAGE, this.addedtoStageHandler);
			this.dispatchEvent(new MapLoadedEvent(typeof MapLoadedEvent));
		}
		
		private function addedtoStageHandler(event:Event):void {
			for (var i:int = 0; i < mapWidth; i++) {
				for (var j:int = 0; j < mapHeight; j++) {
					if (this.matrix[i * mapWidth + j] > 0) {
						this.matrix[i * mapWidth + j] += 10;
						this.mapMatrix[i * mapWidth + j].height = squareSize;
						this.mapMatrix[i * mapWidth + j].width = squareSize;
						this.mapMatrix[i * mapWidth + j].opaqueBackground = 0x0066CC;
						this.mapMatrix[i * mapWidth + j].graphics.drawRect(i * squareSize, j * squareSize, squareSize, squareSize);
						
						this.graphics.beginFill(0x0066CC);
						this.graphics.drawRect(i * squareSize, j * squareSize, squareSize, squareSize);
						this.graphics.endFill();
						
						this.addChild(this.mapMatrix[i * MapMatrix.mapWidth + j]);
						
					} else if (this.matrix[i * mapWidth + j] == 0) {
						this.graphics.beginFill(0xff8f0f, 0.5);
						this.graphics.drawCircle(i * squareSize + squareSize / 2, j * squareSize + squareSize / 2, MapMatrix.squareSize / 4);//mapMatrix[i * 30 + j].graphics.drawCircle(5, 5, 40);
						this.graphics.endFill();
						//	this.addChild(this.map.mapMatrix[i * 30 + j]);
					}
				}
			}

		}
		
	/*	private function initMap():void {
			for (var i:Number = 0; i < mapWidth; i++) {
				for (var j:Number = 0; j < mapHeight; j++) {
					this.mapMatrix[i * mapWidth + j] = new Shape();
					this.mapMatrix[i * mapWidth + j].height = squareSize;
					this.mapMatrix[i * mapWidth + j].width = squareSize;
					this.mapMatrix[i * mapWidth + j].opaqueBackground = 0x00ff00;
					this.addChild(this.mapMatrix[i * mapWidth + j]);
				}
			}
		}
*/		
		private function initMatrix(map:Array):void {
			this.matrix = new Vector.<Number>();
			this.scoreMatrix = new Vector.<Number>();
			for (var i:Number = 0; i < map.length; i++ ) {
				this.matrix.push(Number(map[i]));
				this.scoreMatrix.push(Number(map[i]));
				this.mapMatrix.push(new Shape());
			}
		}
		
	}

}