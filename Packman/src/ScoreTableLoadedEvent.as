package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author denis sychev
	 */
	public class ScoreTableLoadedEvent extends Event 
	{
		
		public function ScoreTableLoadedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ScoreTableLoadedEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ScoreTableLoadedEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}