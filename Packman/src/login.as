package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author denis sychev
	 */
	public class login extends Sprite implements IDispose 
	{
		private var btnLog:Button = new Button('login');
		private var input:TextField = new TextField();
		
		public static var UserName:String;
		
		public function login() 
		{
			super();
			this.addChild(this.input);
			this.addChild(this.btnLog);
			this.btnLog.addEventListener(MouseEvent.CLICK, this.onClick);
			
			this.input.type = TextFieldType.INPUT;
			this.input.border = true;
			this.input.borderColor = 0x0;
			this.input.y = 30;
			this.input.height = 40;
			
			this.y = 100;
		}
		
		private function onClick (e:Event):void {
			UserName = this.input.text;
			this.dispatchEvent(new NewGame(typeof NewGame));
		}
		
		/* INTERFACE IDispose */
		
		public function Dispose():void 
		{
			
		}
		
	}

}