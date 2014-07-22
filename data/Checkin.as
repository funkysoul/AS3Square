package ch.publicis.dealer.social.AS3Square.data
{
	public class Checkin
	{
		private var _comments:Object;
		private var _createdAt:Number;
		private var _id:String;
		private var _timeZone:String;
		private var _type:String;
		private var _venue:Venue;
		private var _photos:Object;
		private var _privateCheckin:Boolean;
		
		public function Checkin()
		{
			
		}

		public function get comments():Object
		{
			return _comments;
		}

		public function set comments(value:Object):void
		{
			_comments = value;
		}

		public function get createdAt():Number
		{
			return _createdAt;
		}

		public function set createdAt(value:Number):void
		{
			_createdAt = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get timeZone():String
		{
			return _timeZone;
		}

		public function set timeZone(value:String):void
		{
			_timeZone = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get venue():Venue
		{
			return _venue;
		}

		public function set venue(value:Venue):void
		{
			_venue = value;
		}

		public function get photos():Object
		{
			return _photos;
		}

		public function set photos(value:Object):void
		{
			_photos = value;
		}

		public function get privateCheckin():Boolean
		{
			return _privateCheckin;
		}

		public function set privateCheckin(value:Boolean):void
		{
			_privateCheckin = value;
		}


	}
}