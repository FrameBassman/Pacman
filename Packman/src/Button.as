package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author denis sychev
	 */
	public class Button extends Sprite implements IDispose 
	{
		private var textField:TextField = new TextField();
		
		public function Button(name:String) 
		{
			super();
			this.textField.text = name;
			this.textField.border = true;
			this.textField.height = 30;
			this.textField.width = 100;
			this.addChild(this.textField);
		}
		
		/* INTERFACE IDispose */
		
		public function Dispose():void 
		{
			
		}
		
	}

}