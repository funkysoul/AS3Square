package ch.publicis.dealer.social.AS3Square.data
{
	public class Badge
	{
		private var _badgeID:String;
		private var _hint:String;
		private var _name:String;
		private var _image:Object;
		private var _unlocks:Array;
		private var _imageURL:String;
		private var _imageSize:int;
		private var _id:Object;

		public function Badge()
		{
			
		}

		public function get id():Object
		{
			return _id;
		}

		public function set id(value:Object):void
		{
			_id = value;
		}

		public function get imageURL():String
		{
			return _imageURL;
		}

		public function get imageSize():int
		{
			return _imageSize;
		}

		public function set imageSize(value:int):void
		{
			_imageSize = value;
		}

		public function get unlocks():Array
		{
			return _unlocks;
		}

		public function set unlocks(value:Array):void
		{
			_unlocks = value;
		}

		public function set image(value:Object):void
		{
			var combinedString:String = value.prefix + value.sizes[_imageSize] + value.name;
			_imageURL = combinedString;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get hint():String
		{
			return _hint;
		}

		public function set hint(value:String):void
		{
			_hint = value;
		}

		public function get badgeID():String
		{
			return _badgeID;
		}

		public function set badgeID(value:String):void
		{
			_badgeID = value;
		}

	}
}