package ch.publicis.dealer.social.AS3Square.data.user
{
	/**
	 * 
	 * @author tiago.dias
	 * 
	 */	
	public class UserInfoCompact
	{
		private var _id:String;
		private var _firstName:String;
		private var _lastName:String;
		private var _photo:String;
		private var _gender:String;
		private var _homeCity:String;
		private var _relationShip:String;
		
		public function UserInfoCompact()
		{
			
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
	}
}