package ch.publicis.dealer.social.AS3Square.events
{
	import flash.events.Event;
	
	public class FourSquareErrorEvent extends Event
	{
		public static const REQUEST_COMPLETE		:String 	= "requestcomplete";
		
		private var _status:String;
		
		public function FourSquareErrorEvent(type:String, status:String = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_status = status;
		}
		
		public override function clone():Event {
			return new FourSquareErrorEvent(type, _status );
		}
		
		public function get status():Object {
			return _status;
		}
	}
}