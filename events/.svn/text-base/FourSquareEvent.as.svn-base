package ch.publicis.dealer.social.AS3Square.events
{
	import flash.events.Event;
	
	public class FourSquareEvent extends Event
	{
		public static const REQUEST_COMPLETE		:String 	= "requestcomplete";
		
		private var _data:*;
		
		public function FourSquareEvent(type:String, data:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		public override function clone():Event {
			return new FourSquareEvent(type, _data);
		}
		
		public function get data():Object {
			return _data;
		}
	}
}