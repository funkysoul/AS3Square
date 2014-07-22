package ch.publicis.dealer.social.AS3Square.data
{
	import ch.publicis.dealer.social.AS3Square.data.user.UserInfoCompact;

	public class Tips
	{
		private var _createdAt:Number;
		private var _done:int;
		private var _id:String;
		private var _status:String;
		private var _text:String;
		private var _todo:int;
		private var _venue:Venue;
		private var _user:UserInfoCompact;
		
		public function Tips()
		{
		}

		public function get createdAt():Number
		{
			return _createdAt;
		}

		public function set createdAt(value:Number):void
		{
			_createdAt = value;
		}

		public function get done():int
		{
			return _done;
		}

		public function set done(value:int):void
		{
			_done = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get status():String
		{
			return _status;
		}

		public function set status(value:String):void
		{
			_status = value;
		}

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
		}

		public function get todo():int
		{
			return _todo;
		}

		public function set todo(value:int):void
		{
			_todo = value;
		}

		public function get venue():Venue
		{
			return _venue;
		}

		public function set venue(value:Venue):void
		{
			_venue = value;
		}

		public function get user():UserInfoCompact
		{
			return _user;
		}

		public function set user(value:UserInfoCompact):void
		{
			_user = value;
		}


	}
}