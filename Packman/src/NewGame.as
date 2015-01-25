package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author denis sychev
	 */
	public class NewGame extends Event 
	{
		public var coords:Array;
		public var score:int;
		public var map:Vector.<Number>;
		public function NewGame(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			this.coords = new Array();
			map = new Vector.<Number>();
		}
		
	}

}