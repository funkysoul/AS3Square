package ch.publicis.dealer.social.AS3Square.data
{
		
	import ch.publicis.dealer.social.AS3Square.data.user.Friends;
	import ch.publicis.dealer.social.AS3Square.data.user.MayorShip;
	import ch.publicis.dealer.social.AS3Square.data.user.UserInfo;
	import ch.publicis.dealer.social.AS3Square.data.user.UserInfoCompact;
	
	import com.adobe.serialization.json.JSON;
	
	import flash.net.SharedObject;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 *  Static class that only does data parsing from the FourSquare API (JSON) to AS3 friendly Objects
	 *  @author Tiago Dias [Publicis Modem, Switzerland]
	*/
	public class DataParser
	{
		private static var _searchString:String;
		
		/**
		 * 
		 * @param data
		 * @return 
		 * 
		 */					
		public static function parseUserInfo( data:Object ):UserInfo
		{
			var userInfo:UserInfo = parseuserinfo( data );
			return userInfo;
		}
		
		/**
		 * 
		 * @param data
		 * @return 
		 * 
		 */		
		public static function parseCompactUserInfo( data:Object ):Array
		{
			var arr:Array = new Array();
			for each( var obj:Object in data )
			{
				var userInfo:UserInfoCompact = parsecompactuserinfo( obj );
				arr.push( userInfo );
			}
			return arr;
		}
		
		/**
		 * 
		 * @param data
		 * @return 
		 * 
		 */		
		public static function parseBadges( data:Object ):Array
		{
			
			var arr:Array = new Array();
			
			if ( SharedObject.getLocal( "4sq" ).data.badgeList == null )
			{
				for each ( var badgeSet:Object in data.badges )
				{
					var badge:Badge = parsebadge( badgeSet );
					arr.push( badge );
				}
				SharedObject.getLocal( "4sq" ).data.badgeList = arr;
				SharedObject.getLocal( "4sq" ).flush();
				arr = [];
			}			
			
			var badgeArray:Array = SharedObject.getLocal( "4sq" ).data.badgeList;
			for each ( var str:String in data.sets.groups[0].items )
			{ 
				_searchString = str;			
				arr.push( badgeArray.filter( filterEarnedBadges )[0] );
			}
			
			return arr;
		}
		
		public static function parseCheckins( data:Object ):Array
		{
			var arr:Array = new Array();
			
			for each ( var obj:Object in data )
			{
				var checkin:Checkin = parsecheckins( obj );
				arr.push( checkin );
			}
			
			return arr;
		}
		
		public static function parseCheckin( data:Object ):Checkin
		{
			var checkin:Checkin = parsecheckins( data.checkin );
			return checkin;
		}
		
		public static function parseTips( data:Object ):Array
		{
			var arr:Array = new Array();
			
			for each ( var obj:Object in data.tips.items )
			{
				var tip:Tips = parsetips( obj );
				arr.push( tip );
			}
			
			return arr;
		}
		
		public static function parseTip( data:Object ):Tips
		{
			var tip:Tips = parsetips( data );						
			return tip;
		}
		
		public static function parseSearchTips( data:Object ):Array
		{
			var arr:Array = new Array();
			
			for each ( var obj:Object in data.tips )
			{
				var tip:Tips = parsetips( obj );
				arr.push( tip );
			}
			
			return arr;
		}
		
		public static function parseTodos( data:Object ):Array
		{
			var arr:Array = new Array();
			
			for each ( var obj:Object in data.todos.items )
			{
				var todo:Todo = parsetodos( obj );
				arr.push( todo );
			}
			
			return arr;
		}
		
		public static function parseVenueHistory( data:Object ):Array
		{
			var arr:Array = new Array();
			
			for each ( var obj:Object in data.venues.items )
			{
				var compactVenue:VenueCompact = parsecompactvenues( obj );
				arr.push( compactVenue );
			}
			
			return arr;
		}
		
		public static function parseVenue( data:Object ):Venue
		{
			var venueInfo:Venue = parsevenueinfo( data.venue );
			return venueInfo;
		}
		
		public static function parseVenues( data:Object ):Array
		{
			var arr:Array = new Array();
			
			for each ( var obj:Object in data.venues )
			{
				var venue:Venue = parsevenueinfo( obj );
				arr.push( venue );
			}
			
			return arr;
		}
		
		public static function parsePhotos( data:Object ):Array
		{
			var arr:Array = new Array();
			
			for each ( var obj:Object in data )
			{
				var photo:Photo = parsephoto( obj );
				arr.push( photo );
			}
			
			return arr;
		}
		
		public static function parseTodo( data:Object ):Todo
		{
			var todo:Todo = parsetodos( data );
			return todo;
		}
		
		public static function parseComment( data:Object ):Comment
		{
			var comment:Comment = parsecomment( data );
			return comment;
		}
		
		

		//------------------------------------------------------------------------------
		//INTERNAL STATIC FUNCTIONS
		//------------------------------------------------------------------------------
		//------------------------------------------------------------------------------
		
		internal static function parseuserinfo( obj:Object ):UserInfo
		{
			var mayorships:Array	= new Array();
			var userInfo:UserInfo 	= new UserInfo();
			userInfo.firstName		= obj.firstName;
			userInfo.friends 		= new Friends( obj.friends );
			userInfo.gender			= obj.gender;
			userInfo.homeCity		= obj.homeCity;
			userInfo.id				= obj.id;
			userInfo.lastName		= obj.lastName;
			userInfo.numBadges		= obj.badges.count;
			userInfo.numCheckins	= obj.checkins.count;
			userInfo.numFollowing	= obj.following.count;
			userInfo.contactEmail	= obj.contact.email;
			userInfo.contactFacebook= obj.contact.facebook;
			
			for each ( var item:Object in obj.mayorships.items )
			{
				var mayorShip:MayorShip = new MayorShip( item );
				mayorships.push( mayorShip );
			}
			
			userInfo.mayorShips		= mayorships;
			userInfo.numTips		= obj.tips.count;
			userInfo.numTodos		= obj.todos.count;
			userInfo.relationShip	= obj.relationship;
			userInfo.photo			= obj.photo;
			userInfo.pings			= obj.pings;
			userInfo.type			= obj.type;
			return userInfo; 
		}
		
		internal static function parsecompactuserinfo( obj:Object ):UserInfoCompact
		{
			var userInfo:UserInfoCompact 	= new UserInfoCompact();
			userInfo.firstName		= obj.firstName;
			userInfo.gender			= obj.gender;
			userInfo.homeCity		= obj.homeCity;
			userInfo.id				= obj.id;
			userInfo.lastName		= obj.lastName;
			userInfo.photo			= obj.photo;
			userInfo.relationShip	= obj.relationship;
			return userInfo; 
		}
		
		internal static function parsebadge( obj:Object ):Badge
		{
			var badge:Badge 	= new Badge();
			badge.badgeID		= obj.badgeId;
			badge.id			= obj.id;
			badge.hint			= obj.hint;
			badge.imageSize		= 0;
			badge.image			= obj.image;
			badge.name			= obj.name;
			return badge; 
		}
		
		internal static function parsecheckins( obj:Object ):Checkin
		{
			var checkin:Checkin = new Checkin();
			checkin.comments = obj.comments;
			checkin.createdAt = obj.createdAt;
			checkin.id = obj.id;
			checkin.photos = obj.photos;
			checkin.privateCheckin = obj.private;
			checkin.timeZone = obj.timeZone;
			checkin.type = obj.type;
			
			var venue:Venue = new Venue();
			venue.categories = obj.venue.categories;
			venue.contact = obj.venue.contact;
			venue.id = obj.venue.id;
			venue.locationAddress = obj.venue.location.address;
			venue.locationLat = obj.venue.location.lat;
			venue.locationLong = obj.venue.location.lng;
			venue.locationPostalCode = obj.venue.location.postalCode;
			venue.locationState = obj.venue.location.state;
			venue.categories = obj.venue.location.categories;
			venue.name = obj.venue.name;
			venue.verified = obj.venue.location.verified;
			checkin.venue = venue;
			
			return checkin;
		}
		
		internal static function parsetips( obj:Object ):Tips
		{
			var tip:Tips = new Tips();
			tip.createdAt = obj.createdAt;
			tip.done = obj.done.count;
			tip.id = obj.id;
			tip.status = obj.status;
			tip.text = obj.text;
			tip.todo = obj.todo.count;

			if ( obj.venue )
			{
				var venue:Venue = new Venue();
				venue.categories = obj.venue.categories;
				venue.contact = obj.venue.contact;
				venue.id = obj.venue.id;
				venue.locationAddress = obj.venue.location.address;
				venue.locationLat = obj.venue.location.lat;
				venue.locationLong = obj.venue.location.lng;
				venue.locationPostalCode = obj.venue.location.postalCode;
				venue.locationState = obj.venue.location.state;
				venue.categories = obj.venue.location.categories;
				venue.name = obj.venue.name;
				venue.verified = obj.venue.location.verified;
				
				tip.venue = venue;
			}
			
			if ( obj.user )
			{
				var user:UserInfoCompact = new UserInfoCompact();
				user.firstName = obj.user.firstName;
				user.gender = obj.user.gender;
				user.homeCity = obj.user.homeCity;
				user.id = obj.user.id;
				user.lastName = obj.user.lastName;
				user.photo = obj.user.photo;
				user.relationShip = obj.user.relationShip;
				
				tip.user = user;
			}
			
			return tip;
		}
		
		internal static function parsetodos( obj:Object ):Todo
		{
			MonsterDebugger.trace(DataParser, obj );
			var todo:Todo = new Todo();
			todo.createdAt = obj.createdAt;
			todo.id = obj.id;
			
			var tip:Tips = new Tips();
			tip.createdAt = obj.tip.createdAt;
			tip.done = obj.tip.done.count;
			tip.id = obj.tip.id;
			tip.status = obj.tip.status;
			tip.text = obj.tip.text;
			tip.todo = obj.tip.todo.count;
			
			var user:UserInfoCompact = new UserInfoCompact();
			user.firstName = obj.tip.user.firstName;
			user.gender = obj.tip.user.gender;
			user.homeCity = obj.tip.user.homeCity;
			user.id = obj.tip.user.id;
			user.lastName = obj.tip.user.lastName;
			user.photo = obj.tip.user.photo;
			user.relationShip = obj.tip.user.relationShip;
			
			tip.user = user;
			
			var venue:Venue = new Venue();
			venue.categories = obj.tip.venue.categories;
			venue.contact = obj.tip.venue.contact;
			venue.id = obj.tip.venue.id;
			venue.locationAddress = obj.tip.venue.location.address;
			venue.locationLat = obj.tip.venue.location.lat;
			venue.locationLong = obj.tip.venue.location.lng;
			venue.locationPostalCode = obj.tip.venue.location.postalCode;
			venue.locationState = obj.tip.venue.location.state;
			venue.categories = obj.tip.venue.location.categories;
			venue.name = obj.tip.venue.name;
			venue.verified = obj.tip.venue.location.verified;
			
			tip.venue = venue;
			
			todo.tip = tip;
			
			return todo;
		}
		
		internal static function parsecompactvenues( obj:Object ):VenueCompact
		{
			var venueCompact:VenueCompact = new VenueCompact();
			venueCompact.beenHere = obj.beenHere;
			venueCompact.lastHereAt = obj.lastHereAt;
			
			var venue:Venue = new Venue();
			venue.categories = obj.venue.categories;
			venue.contact = obj.venue.contact;
			venue.id = obj.venue.id;
			venue.locationAddress = obj.venue.location.address;
			venue.locationLat = obj.venue.location.lat;
			venue.locationLong = obj.venue.location.lng;
			venue.locationPostalCode = obj.venue.location.postalCode;
			venue.locationState = obj.venue.location.state;
			venue.categories = obj.venue.location.categories;
			venue.name = obj.venue.name;
			venue.verified = obj.venue.location.verified;
			
			venueCompact.venue = venue;
			
			return venueCompact
		}
		
		internal static function parsevenueinfo( obj:Object ):Venue
		{
			var venue:Venue = new Venue();
			venue.categories = obj.categories;
			venue.contact = obj.contact;
			venue.id = obj.id;
			venue.locationAddress = obj.location.address;
			venue.locationLat = obj.location.lat;
			venue.locationLong = obj.location.lng;
			venue.locationPostalCode = obj.location.postalCode;
			venue.locationState = obj.location.state;
			venue.categories = obj.location.categories;
			venue.name = obj.name;
			venue.verified = obj.location.verified;
			
			return venue;
		}
		
		internal static function parsephoto( obj:Object ):Photo
		{
			var photo:Photo = new Photo();
			photo.createdAt = obj.createdAt;
			photo.id = obj.id;
			photo.sizes = obj.sizes;
			photo.source = obj.source;
			photo.url = obj.url;
			
			if ( obj.user )
			{
				var user:UserInfoCompact = new UserInfoCompact();
				user.firstName = obj.user.firstName;
				user.gender = obj.user.gender;
				user.homeCity = obj.user.homeCity;
				user.id = obj.user.id;
				user.lastName = obj.user.lastName;
				user.photo = obj.user.photo;
				user.relationShip = obj.user.relationShip;
				
				photo.user = user;
			}
			
			return photo;
		}
		
		internal static function parsecomment( obj:Object ):Comment
		{
			MonsterDebugger.trace(DataParser, obj );
			var comment:Comment = new Comment();
			comment.createdAt = obj.createdAt;
			comment.id = obj.id;
			comment.text = obj.text;
		
			if ( obj.user )
			{
				var user:UserInfoCompact = new UserInfoCompact();
				user.firstName = obj.user.firstName;
				user.gender = obj.user.gender;
				user.homeCity = obj.user.homeCity;
				user.id = obj.user.id;
				user.lastName = obj.user.lastName;
				user.photo = obj.user.photo;
				user.relationShip = obj.user.relationShip;
				
				comment.user = user;
			}
			
			return comment;
		}
		
		internal static function filterEarnedBadges( item:*, index:int, array:Array ):Boolean
		{
			return ( item.id == _searchString );
		}
		
	}
}