package ch.publicis.dealer.social.AS3Square.data.user
{
	/**
	 * 
	 * @author tiago.dias
	 * 
	 */	
	public class UserInfo
	{
		private var _id:String;
		private var _firstName:String;
		private var _lastName:String;
		private var _photo:String;
		private var _gender:String;
		private var _homeCity:String;
		private var _relationShip:String;
		private var _type:String;
		private var _pings:Boolean;
		
		private var _numBadges:int;
		private var _numFollowing:int;
		private var _friends:Friends;
		private var _numCheckins:int;
		private var _mayorShips:Array;
		private var _numRequests:int;
		private var _numTips:int;
		private var _numTodos:int;
		
		private var _contactEmail:String;
		private var _contactFacebook:int;
		
		public function UserInfo()
		{
			
		}

		public function get contactFacebook():int
		{
			return _contactFacebook;
		}

		public function set contactFacebook(value:int):void
		{
			_contactFacebook = value;
		}

		public function get contactEmail():String
		{
			return _contactEmail;
		}

		public function set contactEmail(value:String):void
		{
			_contactEmail = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get firstName():String
		{
			return _firstName;
		}

		public function set firstName(value:String):void
		{
			_firstName = value;
		}

		public function get lastName():String
		{
			return _lastName;
		}

		public function set lastName(value:String):void
		{
			_lastName = value;
		}

		public function get photo():String
		{
			return _photo;
		}

		public function set photo(value:String):void
		{
			_photo = value;
		}

		public function get gender():String
		{
			return _gender;
		}

		public function set gender(value:String):void
		{
			_gender = value;
		}

		public function get homeCity():String
		{
			return _homeCity;
		}

		public function set homeCity(value:String):void
		{
			_homeCity = value;
		}

		public function get relationShip():String
		{
			return _relationShip;
		}

		public function set relationShip(value:String):void
		{
			_relationShip = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get pings():Boolean
		{
			return _pings;
		}

		public function set pings(value:Boolean):void
		{
			_pings = value;
		}

		public function get numBadges():int
		{
			return _numBadges;
		}

		public function set numBadges(value:int):void
		{
			_numBadges = value;
		}

		public function get numFollowing():int
		{
			return _numFollowing;
		}

		public function set numFollowing(value:int):void
		{
			_numFollowing = value;
		}

		public function get friends():Friends
		{
			return _friends;
		}

		public function set friends(value:Friends):void
		{
			_friends = value;
		}

		public function get numCheckins():int
		{
			return _numCheckins;
		}

		public function set numCheckins(value:int):void
		{
			_numCheckins = value;
		}

		public function get numRequests():int
		{
			return _numRequests;
		}

		public function set numRequests(value:int):void
		{
			_numRequests = value;
		}

		public function get numTips():int
		{
			return _numTips;
		}

		public function set numTips(value:int):void
		{
			_numTips = value;
		}

		public function get numTodos():int
		{
			return _numTodos;
		}

		public function set numTodos(value:int):void
		{
			_numTodos = value;
		}

		public function get mayorShips():Array
		{
			return _mayorShips;
		}

		public function set mayorShips(value:Array):void
		{
			_mayorShips = value;
		}


	}
}