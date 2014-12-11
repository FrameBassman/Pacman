package ;
import flash.events.Event;

class NewGameEvent extends Event 
{

	public function new (type:String, bubbles:Bool=false, cancelable:Bool=false) 
	{
		super(type, bubbles, cancelable);
	}
	
}