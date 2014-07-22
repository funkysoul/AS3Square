package ch.publicis.dealer.social.AS3Square.data
{
	public class Venue
	{
		private var _categories:Array;
		private var _contact:Object;
		private var _id:String;
		private var _locationAddress:String;
		private var _locationLat:Number;
		private var _locationLong:Number;
		private var _locationPostalCode:int;
		private var _locationState:String;
		private var _name:String;
		private var _statsCheckinCount:int;
		private var _StatsUsersCount:int;
		private var _verified:Boolean;
		
		public function Venue()
		{
		}

		public function get categories():Array
		{
			return _categories;
		}

		public function set categories(value:Array):void
		{
			_categories = value;
		}

		public function get contact():Object
		{
			return _contact;
		}

		public function set contact(value:Object):void
		{
			_contact = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get locationAddress():String
		{
			return _locationAddress;
		}

		public function set locationAddress(value:String):void
		{
			_locationAddress = value;
		}

		public function get locationLat():Number
		{
			return _locationLat;
		}

		public function set locationLat(value:Number):void
		{
			_locationLat = value;
		}

		public function get locationLong():Number
		{
			return _locationLong;
		}

		public function set locationLong(value:Number):void
		{
			_locationLong = value;
		}

		public function get locationPostalCode():int
		{
			return _locationPostalCode;
		}

		public function set locationPostalCode(value:int):void
		{
			_locationPostalCode = value;
		}

		public function get locationState():String
		{
			return _locationState;
		}

		public function set locationState(value:String):void
		{
			_locationState = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get statsCheckinCount():int
		{
			return _statsCheckinCount;
		}

		public function set statsCheckinCount(value:int):void
		{
			_statsCheckinCount = value;
		}

		public function get StatsUsersCount():int
		{
			return _StatsUsersCount;
		}

		public function set StatsUsersCount(value:int):void
		{
			_StatsUsersCount = value;
		}

		public function get verified():Boolean
		{
			return _verified;
		}

		public function set verified(value:Boolean):void
		{
			_verified = value;
		}


	}
}