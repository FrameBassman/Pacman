package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author denis sychev
	 */
	public class ResultTable extends Sprite implements IDispose 
	{
		private var loader:URLLoader;
		private var table:TextField;
		private var login:TextField;
		private var btnNewGamer:Sprite;
		private var score:int;
		
		private static var countResult:int = 0;
		
		public function ResultTable(score:int) 
		{			
			this.score = score;
			this.loader = new URLLoader();
			this.loader.addEventListener(Event.COMPLETE, onDataLoaded);
			var b:URLRequest = new URLRequest("http://localhost:1444/result/" + countResult++);
			this.loader.dataFormat = "text";
			this.loader.load(b);
			
			this.table = new TextField();
			this.table.type = TextFieldType.DYNAMIC;
			this.table.selectable = false;
			this.addChild(this.table);
			this.table.x = -150;
			this.table.y = 250;
			this.table.border = true;
			this.table.borderColor = 200;
			this.table.height = 300;
			this.table.width = 100;
			
			this.login = new TextField();
			this.addChild(this.login);
			this.login.border = true;
			this.login.borderColor = 0;
			this.login.x = -150;
			this.login.y = 150;
			this.login.height = 30;
			this.login.type = TextFieldType.INPUT;
			
			this.btnNewGamer = new Sprite();
			this.btnNewGamer.x = -150;
			this.btnNewGamer.y = 200;
			this.btnNewGamer.addEventListener(MouseEvent.CLICK, this.onNewGamerClick);
			//this.btnNewGamer.height = 30;
			//this.btnNewGamer.width = 100;
			
			var textField = new TextField();
			textField.border = true;
			textField.selectable = false;
			textField.height = 30;
			textField.text = "add new gamer";
			this.btnNewGamer.addChild(textField);
			this.addChild(this.btnNewGamer);
		}
		
		private function onNewGamerClick(e:Event):void {			
			this.loader = new URLLoader();
			this.loader.addEventListener(Event.COMPLETE, onDataLoaded);
			var b:URLRequest = new URLRequest("http://localhost:1444/add/" + this.login.text + '/' + this.score);
			this.loader.dataFormat = "text";
			this.loader.load(b);
		}
		
		private function onAddedNewPlayer (e:Event):void {
			this.table.text = '';
			
			this.loader = null;
			this.loader = new URLLoader();
			this.loader.addEventListener(Event.COMPLETE, onDataLoaded);
			var b:URLRequest = new URLRequest("http://localhost:1444/result/" + countResult++);
			this.loader.dataFormat = "text";
			this.loader.load(b);			
		}
		
		private function onDataLoaded (e:Event):void {
			this.table.text = '\n' + this.loader.data;
			
		}
		
		/* INTERFACE IDispose */
		
		public function Dispose():void 
		{
			
		}
		
	}

}