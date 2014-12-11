package ;
import flash.events.Event;

class MapLoadedEvent extends Event
{

	public function new(type:String, bubbles:Bool=false, cancelable:Bool=false) 
	{
		super(type, bubbles, cancelable);
	}
	
}