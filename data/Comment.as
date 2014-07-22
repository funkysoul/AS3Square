package ch.publicis.dealer.social.AS3Square.data
{
	import ch.publicis.dealer.social.AS3Square.data.user.UserInfoCompact;

	public class Comment
	{
		private var _createdAt:Number;
		private var _id:String;
		private var _text:String;
		private var _user:UserInfoCompact;
		
		public function Comment()
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

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
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