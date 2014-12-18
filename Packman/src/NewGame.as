package  
{
	import flash.events.Event;
	
	public class NewGame extends Event 
	{
		
		public function NewGame(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}