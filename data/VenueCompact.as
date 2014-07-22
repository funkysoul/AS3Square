package ch.publicis.dealer.social.AS3Square.data
{
	public class VenueCompact
	{
		private var _beenHere:int;
		private var _lastHereAt:Number;
		private var _venue:Venue;
		
		public function VenueCompact()
		{
		}

		public function get beenHere():int
		{
			return _beenHere;
		}

		public function set beenHere(value:int):void
		{
			_beenHere = value;
		}

		public function get lastHereAt():Number
		{
			return _lastHereAt;
		}

		public function set lastHereAt(value:Number):void
		{
			_lastHereAt = value;
		}

		public function get venue():Venue
		{
			return _venue;
		}

		public function set venue(value:Venue):void
		{
			_venue = value;
		}


	}
}