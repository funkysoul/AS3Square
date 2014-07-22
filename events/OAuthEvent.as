package ch.publicis.dealer.social.AS3Square.events
{
	import flash.events.Event;
	
	public class OAuthEvent extends Event
	{
		public static const SUCCESS		:String 	= "success";
		public static const ERROR		:String		= "error";
				
		public function OAuthEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event {
			return new OAuthEvent(type);
		}
	}
}