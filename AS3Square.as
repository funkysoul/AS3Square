package ch.publicis.dealer.social.AS3Square
{
	import ch.publicis.dealer.social.AS3Square.data.DataParser;
	import ch.publicis.dealer.social.AS3Square.events.FourSquareEvent;
	import ch.publicis.dealer.social.AS3Square.oauth.OAuth;
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * 
	 * @author tiago.dias
	 * 
	 */	
	public class AS3Square extends EventDispatcher
	{
		
		protected static const API_URL:String				= "https://api.foursquare.com/v2/";
		
		private var _loader:URLLoader;
		private var _dataType:String;
		private var _oauth:OAuth;
		private var _data:*;
		
		//SORTING METHODS
		public static const SORT_BY_RECENT		:String		= "recent";
		public static const SORT_BY_NEARBY		:String		= "nearby";
		public static const SORT_BY_POPULAR		:String		= "popular";
		//INTENT METHODS
		public static const INTENT_CHECKIN		:String		= "checkin";
		public static const INTENT_MATCH		:String		= "match";
		public static const INTENT_SPECIALS		:String		= "specials";
		//GROUP METHODS
		public static const GROUP_CHECKIN		:String		= "checkin";
		public static const GROUP_VENUE			:String		= "venue";
		public static const GROUP_MULTI			:String		= "multi";
		//PROBLEM METHODS
		public static const PROBLEM_MISLOCATION	:String		= "mislocated";
		public static const PROBLEM_CLOSED		:String		= "closed";
		public static const PROBLEM_DUPLICATE	:String		= "duplicate";
		//SETTINGS
		public static const SEND_TO_TWITTER		:String		= "sendToTwitter";
		public static const SEND_TO_FACEBOOK	:String		= "sendToFacebook";
		public static const RECEIVE_PINGS		:String		= "receivePings";
		public static const RECEIVECOMMPINGS	:String		= "receiveCommentPings";
		//BROADCAST METHODS
		public static const BROADCAST_TWITTER	:String		= "twitter";
		public static const BROADCAST_FACEBOOK	:String		= "facebook";
		public static const BROADCAST_BOTH		:String		= "twitter.facebook";
		
		
		//DATA TYPES - FOURSQUARE API
		//---USERS
		public static const DATA_TYPE_USERINFO				:String		= "profileInformation";
		public static const DATA_TYPE_USERSEARCH			:String		= "userSearch";
		public static const DATA_TYPE_USEREQUESTS			:String		= "userRequests";
		public static const DATA_TYPE_USERBADGES			:String		= "userBadges";
		public static const DATA_TYPE_USERCHECKINS			:String		= "userCheckins";
		public static const DATA_TYPE_USERFRIENDS			:String		= "userFriends";
		public static const DATA_TYPE_USERTIPS				:String		= "userTips";
		public static const DATA_TYPE_USERTODOS				:String		= "userTodos";
		public static const DATA_TYPE_USERVENUEHISTORY		:String		= "userVenueHistory";
		public static const DATA_TYPE_ACTIONSFRIENDREQ		:String		= "actionsFriendRequest";
		public static const DATA_TYPE_ACTIONSUNFRIEND		:String		= "actionsUnfriend";
		public static const DATA_TYPE_ACTIONSAPPROVE		:String		= "actionsApprove";
		public static const DATA_TYPE_ACTIONSDENY			:String		= "actionsDeny";
		public static const DATA_TYPE_ACTIONSSETPINGS		:String		= "actionsSetPings";
		//---VENUES
		public static const DATA_TYPE_VENUEINFO				:String		= "venueInfo";
		public static const DATA_TYPE_VENUEADD				:String		= "venueAdd";
		public static const DATA_TYPE_VENUECATEGORIES		:String		= "venueCategories";
		public static const DATA_TYPE_VENUESEARCH			:String		= "venueSearch";
		public static const DATA_TYPE_VENUEHERENOW			:String		= "venueHereNow";
		public static const DATA_TYPE_VENUETIPS				:String		= "venueTips";
		public static const DATA_TYPE_VENUEPHOTOS			:String		= "venuePhotos";
		public static const DATA_TYPE_VENUEMARKTODO			:String		= "venueMarkToDo";
		public static const DATA_TYPE_VENUEFLAG				:String		= "venueFlag";
		public static const DATA_TYPE_VENUEPROPOSEEDIT		:String		= "venueProposeEdit";
		public static const DATA_TYPE_VENUETRENDING			:String		= "venueTrending";
		//----Checkins
		public static const DATA_TYPE_CHECKINADD			:String		= "checkinAdd";
		public static const DATA_TYPE_CHECKINRECENT			:String		= "checkinRecent";
		public static const DATA_TYPE_CHECKINADDCOMMENT		:String		= "checkinAddComment";
		public static const DATA_TYPE_CHECKINDELCOMMENT		:String		= "checkinDelComment";
		//----TIPS
		public static const DATA_TYPE_TIPADD				:String		= "addTip";
		public static const DATA_TYPE_TIPSEARCH				:String		= "searchTip";
		public static const DATA_TYPE_TIPMARKTODO			:String		= "MarkToDoTip";
		public static const DATA_TYPE_TIPMARKDONE			:String		= "MarkDoneTip";
		public static const DATA_TYPE_TIPUNMARK				:String		= "UnmarkTip";
		//----PHOTOS
		public static const DATA_TYPE_ADDPHOTO				:String		= "addPhoto";
		public static const DATA_TYPE_GETPHOTO				:String		= "getPhoto";
		//---SETTINGS
		public static const DATA_TYPE_ALLSETTINGS			:String		= "allSettings";
		public static const DATA_TYPE_GETSETTING			:String		= "getSetting";
		public static const DATA_TYPE_SETSETTINGS			:String		= "setSettings";
		//---SPECIALS
		public static const DATA_TYPE_GETSPECIAL			:String		= "detailSpecial";
		public static const DATA_TYPE_SPECIALSEARCH			:String		= "searchSpecials";
		
		/**
		 * Returns profile information for a given user, including selected badges and mayorships.
		 * If the user is a friend, contact information, Facebook ID, and Twitter handle and the user's last checkin may also be present. 
 		 * 
		 * @param userID			Identity of the user to get details for. Pass self to get details of the acting user.
		 * 
		 */		
		public function getUser( userID:String = "self" ):void
		{
			_dataType = DATA_TYPE_USERINFO;
			requestData( API_URL + "users/" + userID );
		}
		
		/**
		 * Helps a User locate friends
		 *  
		 * @param phone				Optional. A comma delimited list of phone numbers to look for.
		 * @param email				Optional. A comma delimited list of email addresses to look for.
		 * @param twitter			Optional. A comma delimited list of twitter handlers to look for.
		 * @param twitterSource		Optional. A single twitter handle, Results will be Friends of this user.
		 * @param fbid				Optional. A comma delimited list of Facebook ID's to look for.
		 * @param name				Optional. A single String to search for in users names.
		 * 
		 */		
		public function searchUser( phone:String = "", email:String = "", twitter:String = "", twitterSource:String = "", fbid:String = "", name:String = "" ):void
		{
			var joinedStr:String = "";
			var args:Array = new Array();
			( phone != "" ) ? args.push( {name:"phone", val:phone } ) : null;
			( email != "" ) ? args.push( {name:"email", val:email } ) : null;
			( twitter != "" ) ? args.push( {name:"twitter", val:twitter } ) : null;
			( twitterSource != "" ) ? args.push( {name:"twitterSource", val:twitterSource } ) : null;
			( fbid != "" ) ? args.push( {name:"fbid", val:fbid } ) : null;
			( name != "" ) ? args.push( {name:"name", val:name } ) : null;
			
			for ( var i:int = 0; i < args.length; i++ )
			{
				joinedStr += args[i]["name"] + "=" + args[i]["val"];
				if ( i != args.length - 1 )
					joinedStr += "&";
			}
			
			_dataType = DATA_TYPE_USERSEARCH;
			requestData( API_URL + "users/search?" + joinedStr );
		}
		
		/**
		 * Shows a user the list of users with whom they have a pending friend request (i.e., someone tried to add the acting user as a friend, but the acting user has not accepted). 
		 * 
		 */		
		public function requestUser():void
		{
			_dataType = DATA_TYPE_USEREQUESTS;
			requestData( API_URL + "users/requests" );
		}
		
		/**
		 * Returns badges for a given user. 
		 * 
		 * @param userID				Optional. Identity of the user to get friends		
		 * 
		 */		
		public function getUsersBadges( userID:String = "self" ):void
		{
			_dataType = DATA_TYPE_USERBADGES;
			requestData( API_URL + "users/" + userID + "/badges" );
		}
		
		/**
		 * Returns a history of checkins for the authenticated user. 
		 * 
		 * @param userID				For now, only "self" is supported
		 * @param limit					Number of results to return, up to 500.
		 * @param offet					Used to page through results.
		 * @param afterTimeStamp		Retrieve the first results to follow these seconds since epoch. This should be useful for paging forward in time, or when polling for changes.
		 * @param beforeTimeStamp		Retrieve the first results prior to these seconds since epoch. Useful for paging backward in time.
		 * 
		 */		
		public function getUsersCheckins( userID:String = "self", limit:int = 100, offset:int = 0, after:String = "", before:String = "" ):void
		{
			_dataType = DATA_TYPE_USERCHECKINS;
			requestData( API_URL + "users/" + userID + "/checkins?limit=" + limit + "&offset=" + offset );//+ "&afterTimestamp" + after + "&beforeTimestamp" + before ); 
		}
		
		/**
		 * Returns an array of a user's friends. 
		 * 
		 * @param userID				Optional. Identity of the user to get friends
		 * @param limit					Optional. Number of results to return, up to 500.
		 * @param offset				Optional. Used to page through results.
		 * @return 
		 * 
		 */		
		public function getUsersFriendsList( userID:String = "self", limit:int = 100, offset:int = 0 ):void
		{
			_dataType = DATA_TYPE_USERFRIENDS;
			requestData( API_URL + "users/" + userID + "/friends?limit=" + limit + "&offset=" + offset );
		}
		
		/**
		 * 
		 * Returns tips from a user. 
		 * 
		 * @param userID				Optional. Identity of the user to get tips from.
		 * @param sort					Optional. One of recent, nearby, or popular. Nearby requires geolat and geolong to be provided.
		 * @param latLong				Optional. Comma Separated, Latitude and longitude of the user's location.
		 * @param limit					Optional. Number of results to return, up to 500.
		 * @param offset				Optional. Used to page through results.
		 * 
		 */		
		public function getUsersTips( userID:String = "self", sort:String = SORT_BY_RECENT, latLong:String = "", limit:int = 100, offset:int = 0 ):void
		{
			_dataType = DATA_TYPE_USERTIPS;
			requestData( API_URL + "users/" + userID + "/tips?sort=" + sort + "&ll=" + latLong + "&limit=" + limit + "&offset=" + offset ); 
		}
		
		/**
		 * Returns todos from a user. 
		 * 
		 * @param userID				Optional. Identity of the user to get todos from.
		 * @param sort					Optional. One of recent or popular. Nearby requires geolat and geolong to be provided.
		 * @param latLong				Optional. Latitude and longitude of the user's location.
		 * 
		 */		
		public function getUserToDos( userID:String = "self", sort:String = SORT_BY_RECENT, latLong:String = "" ):void
		{
			_dataType = DATA_TYPE_USERTODOS;
			requestData( API_URL + "users/" + userID + "/todos?sort=" + sort + "&ll=" + latLong );
		}
		
		/**
		 * Returns a list of all venues visited by the specified user, along with how many visits and when they were last there. 
		 * 
		 * @param userID				For now, only "self" is supported
		 * @param before				Optional. Seconds since epoch.
		 * @param after					Optional. Seconds after epoch.
		 * 
		 */		
		public function getUserVenueHistory( userID:String = "self", before:String = "", after:String = "" ):void
		{
			_dataType = DATA_TYPE_USERVENUEHISTORY;
			requestData( API_URL + "users/" + userID + "/venuehistory" );//?beforeTimestamp=" + before + "&afterTimestamp=" + after );
		}
		
		/**
		 * Sends a friend request to another user.
		 * 
		 * @param userID				The user ID to which a request will be sent.
		 * 
		 */		
		public function sendFriendRequest( userID:String ):void
		{
			_dataType = DATA_TYPE_ACTIONSFRIENDREQ;
			requestData( API_URL + "users/" + userID + "/request", "POST" );
		}
		
		/**
		 * Cancels any relationship between the acting user and the specified user.  
		 * 
		 * @param userID				Identity of the user to unfriend.
		 * 
		 */		
		public function removeFriend( userID:String ):void
		{
			_dataType = DATA_TYPE_ACTIONSUNFRIEND;
			requestData( API_URL + "users/" + userID + "/unfriend", "POST" );
		}
		
		/**
		 * Approves a pending friend request from another user. 
		 * 
		 * @param userID				The user ID of a pending friend.
		 * 
		 */		
		public function approveFriend( userID:String ):void
		{
			_dataType = DATA_TYPE_ACTIONSAPPROVE;
			requestData( API_URL + "users/" + userID + "/approve", "POST" );
		}
		
		/**
		 * Denies a pending friend request from another user. 
		 * 
		 * @param userID				The user ID of a pending friend.
		 * 
		 */		
		public function denyFriendRequest( userID:String ):void
		{
			_dataType = DATA_TYPE_ACTIONSDENY;
			requestData( API_URL + "users/" + userID + "/deny", "POST" );
		}
		
		/**
		 * Changes whether the acting user will receive pings (phone notifications) when the specified user checks in.  
		 * 
		 * @param userID				The user ID of a friend.
		 * @param value					True or False
		 * 
		 */		
		public function setPings( userID:String, value:Boolean ):void
		{
			var args:Array = new Array();
			args.push( {name:"value", val:value } );
			
			_dataType = DATA_TYPE_ACTIONSSETPINGS;
			requestData( API_URL + "users/" + userID + "/setpings", "POST", args );
		}
		
		/**
		 * Gives details about a venue, including location, mayorship, tags, tips, specials, and category.
		 * Authenticated users will also receive information about who is here now. 
		 * 
		 * @param venueID				ID of the Venue to retrieve
		 * 
		 */		
		public function getVenueInfo( venueID:String ):void
		{
			_dataType = DATA_TYPE_VENUEINFO;
			requestData( API_URL + "venues/" + venueID );
		}
		
		/**
		 * Returns a hierarchical list of categories applied to venues. Note that top-level categories do not have IDs because they cannot be assigned to a venue. 
		 * 
		 */		
		public function getVenueCategories():void
		{
			_dataType = DATA_TYPE_VENUECATEGORIES;
			requestData( API_URL + "venues/categories" );
		}
		
		/**
		 *Allows users to add a new venue. 
		 * If this method returns an error, give the user the option to edit her inputs. 
		 * In addition to this, give users the ability to say "never mind, check-in here anyway" and perform a manual ("venueless") 
		 * checkin by specifying just the venue name. This is rare, but there's a chance you'll see this case if the 
		 * user wants to force a duplicate venue. 
		 * 
		 * @param name
		 * @param latLong
		 * @param address
		 * @param crossStreet
		 * @param city
		 * @param state
		 * @param zip
		 * @param phone
		 * @param catID
		 */		
		
		public function addVenue( name:String, latLong:String, address:String = "", crossStreet:String = "", city:String = "", state:String = "", zip:String = "", phone:String = "", catID:String = "" ):void
		{
			var args:Array = new Array();
			( name != "" ) ? args.push( {name:"name", val:name } ) : null;
			( address != "" ) ? args.push( {name:"address", val:address } ) : null;
			( crossStreet != "" ) ? args.push( {name:"crossStreet", val:crossStreet } ) : null;
			( city != "" ) ? args.push( {name:"city", val:city } ) : null;
			( state != "" ) ? args.push( {name:"state", val:state } ) : null;
			( zip != "" ) ? args.push( {name:"zip", val:zip } ) : null;
			( phone != "" ) ? args.push( {name:"phone", val:phone } ) : null;
			( latLong != "" ) ? args.push( {name:"ll", val:latLong } ) : null;
			( catID != "" ) ? args.push( {name:"primaryCategoryId", val:catID } ) : null;
			
			_dataType = DATA_TYPE_VENUEADD;
			requestData( API_URL + "venues/add", "POST", args );
		}
		
		/**
		 * Returns a list of venues near the current location, optionally matching the search term.
		 * If lat and long is provided, each venue includes a distance. If authenticated, the method will return venue metadata related to you and your friends. If you do not authenticate, you will not get this data. 
		 * 
		 * @param latLong			Latitude and longitude of the user's location, so response can include distance.	
		 * @param accuracy			Optional. Accuracy of latitude and longitude, in meters.
		 * @param alt				Optional. Altitude of the user's location, in meters.
		 * @param altAccuracy		Optional. Accuracy of the user's altitude, in meters.
		 * @param query				Optional. A search term to be applied against titles.
		 * @param limit				Optional. Number of results to return, up to 50.
		 * @param intent			Optional. Indicates your intent in performing the search
		 * 
		 */		
		public function searchVenue( latLong:String, accuracy:int = 10000.0, alt:int = 0, altAccuracy:int = 10000.0, query:String = "", limit:int = 10, intent:String = INTENT_CHECKIN ):void
		{
			var joinedStr:String = "";
			var args:Array = new Array();
			( latLong != "" ) ? args.push( {name:"ll", val:latLong } ) : null;
			( accuracy != 0 ) ? args.push( {name:"llAcc", val:accuracy } ) : null;
			( alt != 0 ) ? args.push( {name:"alt", val:alt } ) : null;
			( altAccuracy != 0 ) ? args.push( {name:"altAcc", val:altAccuracy } ) : null;
			( query != "" ) ? args.push( {name:"query", val:query } ) : null;
			( limit != 0 ) ? args.push( {name:"limit", val:limit } ) : null;
			( intent != "" ) ? args.push( {name:"intent", val:intent } ) : null;
			
			for ( var i:int = 0; i < args.length; i++ )
			{
				joinedStr += args[i]["name"] + "=" + args[i]["val"];
				if ( i != args.length - 1 )
					joinedStr += "&";
				
			}
			
			_dataType = DATA_TYPE_VENUESEARCH;
			requestData( API_URL + "venues/search?" + joinedStr );
		}
		
		
		/**
		 * Returns a list of venues near the current location with the most people currently checked in.
		 * This is an experimental API. We're excited about the innovation we think it enables as a much more efficient version of 
		 * fetching all of a user's checkins, but we're also still learning if this right approach. 
		 * Please give it a shot and provide feedback on the mailing list. 
		 * 
		 * @param latLong
		 * @param limit
		 * @param radius
		 * 
		 */		
		public function trendingVenue( latLong:String, limit:int = 10, radius:int = 10000 ):void
		{
			_dataType = DATA_TYPE_VENUETRENDING;
			requestData( API_URL + "venues/trending?ll=" + latLong + "&limit=" + limit + "&radius=" + radius );
		}
		
		/**
		 * Provides a count of how many people are at a given venue, plus the first page of the users there, friends-first, and if the current user is authenticated. 
		 * 
		 * @param venueID				ID of venue to retrieve	
		 * @param limit					Optional. Number of results to return, up to 500.
		 * @param offset				Optional. Used to page through results.
		 * @param after					Optional. Retrieve the first results to follow these seconds since epoch.
		 * 
		 */		
		public function getVenueHereNow( venueID:String, limit:int = 100, offset:int = 100, after:String = "" ):void
		{
			_dataType = DATA_TYPE_VENUEHERENOW;
			requestData( API_URL + "venues/" + venueID + "/herenow?limit=" + limit + "&offset=" + offset + "&afterTimestamp=" + after );
		}
		
		/**
		 * Returns tips for a venue.
		 * 
		 * @param venueID				The venue you want tips for.
		 * @param sort					Optional. One of recent or popular.
		 * @param limit					Optional. Number of results to return, up to 500.
		 * @param offset				Optional. Used to page through results.
		 * 
		 */		
		public function getVenueTips( venueID:String, sort:String = SORT_BY_RECENT, limit:int = 10, offset:int = 0 ):void
		{
			_dataType = DATA_TYPE_VENUETIPS;
			requestData( API_URL + "venues/" + venueID + "/tips?sort=" + sort + "&limit=" + limit + "&offset=" + offset );
		}
		
		/**
		 * Returns Photos for a venue.
		 * 
		 * @param venueID				The venue you want tips for.
		 * @param group					Pass checkin for photos added by friends on their recent checkins. Pass venue for public photos added to the venue by anyone. Use multi to fetch both.
		 * @param limit					Optional. Number of results to return, up to 500.
		 * @param offset				Optional. Used to page through results.
		 * 
		 */		
		public function getVenuePhotos( venueID:String, group:String = GROUP_VENUE, limit:int = 100, offset:int = 0 ):void
		{
			_dataType = DATA_TYPE_VENUEPHOTOS;
			requestData( API_URL + "venues/" + venueID + "/photos?group=" + group + "&limit=" + limit + "&offset=" + offset );
		}
		
		/**
		 * Allows you to mark a venue to-do, with optional text. 
		 * 
		 * @param venueID				The venue you want to mark to-do.
		 * @param text					Optional. The text of the tip
		 * 
		 */		
		public function markVenueTodo( venueID:String, text:String = "" ):void
		{
			var args:Array = new Array();
			( text != "" ) ? args.push( {name:"text", val:text } ) : null;
			
			_dataType = DATA_TYPE_VENUEMARKTODO;
			requestData( API_URL + "venues/" + venueID + "/marktodo", "POST", args );
		}
		
		/**
		 * Allows users to indicate a venue is incorrect in some way. 
		 *  
		 * @param venueID				The venue id for which an edit is being proposed.
		 * @param problem				One of mislocated, closed, duplicate.
		 * 
		 */		
		public function flagVenue( venueID:String, problem:String = PROBLEM_MISLOCATION ):void
		{
			_dataType = DATA_TYPE_VENUEFLAG;
			requestData( API_URL + "venues/" + venueID + "/flag?problem=" + problem );
		}
		
		/**
		 * Allows you to propose a change to a venue. 
		 * 
		 * @param venueID				The venue id for which an edit is being proposed.
		 * @param name					Optional. The name of the venue.
		 * @param address				Optional. The address of the venue.
		 * @param crossStreet			Optional. The crossStreet of the venue.
		 * @param city					Optional. The city of the venue.
		 * @param state					Optional. The state of the venue.
		 * @param zip					Optional. The zip of the venue.
		 * @param phone					Optional. The phone of the venue.
		 * @param latLong				Optional. Latitude and longitude of the user's location, as accurate as is known.
		 * @param primCategory			Optional. The ID of the category to which you want to assign this venue.
		 * 
		 */		
		public function proposeEditVenue( venueID:String, name:String = "", address:String = "", crossStreet:String = "", city:String = "", state:String = "", zip:String = "", phone:String = "", latLong:String = "", primCategory:int = 123 ):void
		{
			var args:Array = new Array();
			( name != "" ) ? args.push( {name:"name", val:name } ) : null;
			( address != "" ) ? args.push( {name:"address", val:address } ) : null;
			( crossStreet != "" ) ? args.push( {name:"crossStreet", val:crossStreet } ) : null;
			( city != "" ) ? args.push( {name:"city", val:city } ) : null;
			( state != "" ) ? args.push( {name:"state", val:state } ) : null;
			( zip != "" ) ? args.push( {name:"zip", val:zip } ) : null;
			( phone != "" ) ? args.push( {name:"phone", val:phone } ) : null;
			( latLong != "" ) ? args.push( {name:"ll", val:latLong } ) : null;
			( primCategory != 0 ) ? args.push( {name:"primaryCategoryId", val:primCategory } ) : null;
						
			_dataType = DATA_TYPE_VENUEPROPOSEEDIT;
			requestData( API_URL + "venues/" + venueID + "/proposeedit", "POST", args );
		}
		
		/**
		 * Allows you to check in to a place. 
		 * 
		 * @param venueID
		 * @param venue
		 * @param shout
		 * @param broadcast
		 * @param latLong
		 * @param llAcc
		 * @param alt
		 * @param altAcc
		 * 
		 */		
		public function createCheckin(venueID:String, venue:String = "", shout:String = "", broadcast:String = "", latLong:String = "", llAcc:int = 0, alt:int = 0, altAcc:int = 0 ):void
		{
			var args:Array = new Array();
			( venueID != "" ) ? args.push( {name:"venueId", val:venueID } ) : null;
			( venue != "" ) ? args.push( {name:"venue", val:venue } ) : null;
			( shout != "" ) ? args.push( {name:"shout", val:shout } ) : null;
			( broadcast != "" ) ? args.push( {name:"broadcast", val:broadcast } ) : null;
			( latLong != "" ) ? args.push( {name:"ll", val:latLong } ) : null;
			( llAcc != 0 ) ? args.push( {name:"llAcc", val:llAcc } ) : null;
			( alt != 0 ) ? args.push( {name:"alt", val:alt } ) : null;
			( altAcc != 0 ) ? args.push( {name:"altAcc", val:altAcc } ) : null;
						
			_dataType = DATA_TYPE_CHECKINADD;
			requestData( API_URL + "checkins/add", "POST", args );
		}
		
		/**
		 * Returns a list of recent checkins from friends. 
		 * 
		 * @param latLong
		 * @param limit
		 * @param after
		 * 
		 */		
		public function recentCheckins( latLong:String = "", limit:int = 100, after:int = 0 ):void
		{
			_dataType = DATA_TYPE_CHECKINRECENT;
			requestData( API_URL + "checkins/recent" + "?ll=" + latLong + "&limit=" + limit );// + "&afterTimestamp=" + after );
		}
		
		/**
		 * Comment on a checkin-in 
		 * 
		 * @param checkinID
		 * @param message
		 * 
		 */		
		public function commentCheckin( checkinID:String, message:String ):void
		{
			_dataType = DATA_TYPE_CHECKINADDCOMMENT;
			requestData( API_URL + "checkins/" + checkinID + "/addcomment", "POST", new Array( {name:"text", val:message} ) );
		}
		
		/**
		 * Remove a comment from a checkin, if the acting user is the author or the owner of the checkin. 
		 * 
		 * @param checkinID			The ID of the checkin to remove a comment from.
		 * @param commentID			The id of the comment to remove.
		 * 	
		 */		
		public function deleteCommentCheckin( checkinID:String, commentID:String ):void
		{
			_dataType = DATA_TYPE_CHECKINDELCOMMENT;
			requestData( API_URL + "checkins/" + checkinID + "/deletecomment", "POST", new Array( {name:"commentId", val:commentID } ) );
		}
		
		/**
		 * Allows you to add a new tip at a venue. 
		 * 
		 * @param venueID			The venue where you want to add this tip.
		 * @param text				The text of the tip.
		 * @param url				Optional. A URL related to this tip.
		 * 
		 */		
		public function addTip( venueID:String, text:String, url:String = "" ):void
		{
			var args:Array = new Array();
			( venueID != "" ) ? args.push( {name:"venueId", val:venueID } ) : null;
			( text != "" ) ? args.push( {name:"text", val:text } ) : null;
			( url != "" ) ? args.push( {name:"url", val:url } ) : null;
			
			_dataType = DATA_TYPE_TIPADD;
			requestData( API_URL + "tips/add", "POST", args );
		}
		
		/**
		 * Returns a list of tips near the area specified. 
		 * 
		 * @param latLong			Latitude and longitude of the user's location.
		 * @param limit				Optional. Number of results to return, up to 500.
		 * @param offset			Optional. Used to page through results.
		 * @param filter			Optional. If set to friends, only show nearby tips from friends.
		 * @param query				Optional. Only find tips matching the given term, cannot be used in conjunction with friends filter.
		 * @return 
		 * 
		 */		
		public function searchTip( latLong:String, limit:int = 100, offset:int = 0, filter:String = "", query:String = "" ):void
		{
			_dataType = DATA_TYPE_TIPSEARCH;
			if ( filter != "" && query != "" )
			{
				throw new Error( "Cannot use filter and query in conjunction" );
			}
			requestData( API_URL + "tips/search?ll=" + latLong + "" + limit + "" + offset + "" + query );
		}
		
		/**
		 * Allows you to mark a tip to-do. 
		 * 
		 * @param tipID				The tip you want to mark to-do
		 * 
		 */		
		public function markTipTodo( tipID:String ):void
		{
			_dataType = DATA_TYPE_TIPMARKTODO;
			requestData( API_URL + "tips/" + tipID + "/marktodo", "POST" );
		}
		
		/**
		 * Allows the acting user to mark a tip done. 
		 * 
		 * @param tipID				The tip you want to mark done.
		 * 
		 */		
		public function markTipDone( tipID:String ):void
		{
			_dataType = DATA_TYPE_TIPMARKDONE;
			requestData( API_URL + "tips/" + tipID + "/markdone", "POST" );
		}
		
		/**
		 * Allows you to remove a tip from your to-do list or done list. 
		 * 
		 * @param tipID				The tip you want to unmark.
		 * 
		 */		
		public function unmarkTip( tipID:String ):void
		{
			_dataType = DATA_TYPE_TIPUNMARK;
			requestData( API_URL + "tips/" + tipID + "/unmark", "POST" );
		}
		
		/**
		 * Get details of a photo. 
		 * 
		 * @param photoID			The ID of the photo to retrieve additional information for.
		 * 
		 */		
		public function getPhoto( photoID:String ):void
		{
			_dataType = DATA_TYPE_GETPHOTO;
			requestData( API_URL + "photos/" + photoID );
		}
		
		/**
		 * Allows users to add a new photo to a checkin, tip, or a venue in general.
		 * All fields are optional, but exactly one of the id fields (checkinId, tipId, venueId) must be passed in. 
		 * In addition, the image file data must be posted. The photo should be uploaded as a jpeg and the Content-Type should be set to "image/jpeg"
		 * Attaching a photo to a tip or a venue makes it visible to anybody, while attaching a photo to a checkin makes it visible only to the people who can see the checkin (the user's friends, unless the checkin has been sent to Twitter or Facebook.).
		 * Multiple photos can be attached to a checkin or venue, but there can only be one photo per tip.
		 * To avoid double-tweeting, if you are sending a checkin that will be immediately followed by a photo, do not set broadcast=twitter on the checkin, and just set it on the photo.
		 *   
		 * @param checkinID				the ID of a checkin owned by the user
		 * @param tipID					the ID of a tip owned by the user
		 * @param venueID				the ID of a venue, provided only when adding a public photo of the venue in general, rather than a private checkin or tip photo using the parameters above
		 * @param broadcast				Whether to broadcast this photo, ranging from twitter if you want to send to twitter, facebook if you want to send to facebook, or twitter,facebook if you want to send to both.
		 * @param latLong				Latitude and longitude of the user's location.
		 * @param latLongAcc			Accuracy of the user's latitude and longitude, in meters.
		 * @param alt					Altitude of the user's location, in meters.
		 * @param altAcc				Vertical accuracy of the user's location, in meters.
		 * 
		 */		
		public function addPhoto( photo:String, checkinID:String, tipID:String, venueID:String, broadcast:String, latLong:String, llAcc:int = -1, alt:int = -1, altAcc:int = -1 ):void
		{
			_dataType = DATA_TYPE_ADDPHOTO;
			
			if ( checkinID == "" && tipID == "" && venueID == "" )
			{
				throw new Error( "You must supply at least one ID" );
			}
			
			var args:Array = new Array();
			( checkinID != "" ) ? args.push( {name:"checkinId", val:checkinID } ) : null;
			( tipID != "" ) ? args.push( {name:"tipId", val:tipID } ) : null;
			( venueID != "" ) ? args.push( {name:"venueId", val:venueID } ) : null;
			( broadcast != "" ) ? args.push( {name:"broadcast", val:broadcast } ) : null;
			( latLong != "" ) ? args.push( {name:"ll", val:latLong } ) : null;
			( llAcc != -1 ) ? args.push( {name:"llAcc", val:llAcc } ) : null;
			( alt != -1 ) ? args.push( {name:"alt", val:alt } ) : null;
			( altAcc != -1 ) ? args.push( {name:"altAcc", val:altAcc } ) : null;
			( photo != "" ) ? args.push( {name:"photo", val:photo } ) : null;
			
			requestData( API_URL + "photos/add", "POST", args );
		}
		
		/**
		 * Returns a setting for the acting user. 
		 * 
		 * @param settingID			The name of a setting.
		 * 
		 */		
		public function getUserSetting( settingID:String ):void
		{
			_dataType = DATA_TYPE_GETSETTING;
			requestData( API_URL + "settings/all?SETTING_ID=" + settingID );
		}
		
		/**
		 * Returns the settings of the acting user. 
		 * 
		 */		
		public function userSettings():void
		{
			_dataType = DATA_TYPE_ALLSETTINGS;
			requestData( API_URL + "settings/all" );
		}
		
		/**
		 * Change a setting for the given user. 
		 *  
		 * @param settingID			Name of setting to change. sendToTwitter, sendToFacebook, receivePings, receiveCommentPings
		 * @param value				1 for true 0 for false.
		 * 
		 */		
		public function changeUserSetting( settingID:String, value:int ):void
		{
			_dataType = DATA_TYPE_SETSETTINGS;
			
			var args:Array = new Array( { name:"value", val:value } );
			requestData( API_URL + "settings/" + settingID + "/set", "POST", args );
		}
		
		/**
		 * Gives details about a special, including text and unlock rules. 
		 * 
		 * @param specialID			ID of special to retrieve
		 * 
		 */		
		public function getSpecialDetail( specialID:String ):void
		{
			_dataType = DATA_TYPE_GETSPECIAL;
			requestData( API_URL + "specials/" + specialID, "USERLESS" );
		}
		
		/**
		 * EXPERIMENTAL Returns a list of specials near the current location. 
		 * 
		 * @param latLong			Required. Latitude and longitude to search near.
		 * @param llAcc				Optional. Accuracy of latitude and longitude, in meters.
		 * @param alt				Optional. Altitude of the user's location, in meters.
		 * @param altAcc			Optional. Accuracy of the user's altitude, in meters.
		 * @param limit				Optional. Number of results to return, up to 50.
		 * 
		 */		
		public function searchSpecials( latLong:String, llAcc:int = -1, alt:int = -1, altAcc:int = -1, limit:int = 10 ):void
		{
			_dataType = DATA_TYPE_SPECIALSEARCH;
			requestData( API_URL + "specials/search?ll" + latLong + "" + llAcc + "" + alt + "" + altAcc + "" + limit );
		}
		
		
		
		//////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////
		//------------------------------------------------------------------------------------////
		//-----------															 -------------////
		//-----------															 -------------////
		//-----------															 -------------////
		//------------------------------------------------------------------------------------////
		//////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////
		
		private final function requestData( url:String, type:String = "GET", args:Array = null ):void
		{
			MonsterDebugger.trace(this, type + " - request: " + url);
			
			_loader = new URLLoader();
			_loader.addEventListener( Event.COMPLETE, dataLoaded );
			_loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			var request:URLRequest;
			
			if (type == "GET" )
			{
				if ( url.lastIndexOf("?") == -1 )
				{
					request 				= new URLRequest( url + "?oauth_token=" + _oauth.accessToken );
				}
				else
				{
					request 				= new URLRequest( url + "&oauth_token=" + _oauth.accessToken );
				}
				
				request.method			= "GET";
			}
			else if ( type == "POST" )
			{
				var urlVars:URLVariables = new URLVariables();
				
				if ( args )
				{
					for each ( var obj:Object in args )
					{
						urlVars[obj["name"]] = obj["val"]; 
					}
				}
				
				urlVars.oauth_token 	= _oauth.accessToken;
				
				request					= new URLRequest( url );
				request.data			= urlVars;
				request.method			= type;
				_loader.dataFormat		= URLLoaderDataFormat.TEXT;	
			}
			else
			{
				request 				= new URLRequest( url + "?client_id=" + _oauth.consumerKey + "&client_secret=" + _oauth.consumerSecret );
			}
			
			_loader.load( request );
		}
		
		protected function httpStatusHandler(event:HTTPStatusEvent):void
		{
			MonsterDebugger.trace(this, event );
		}
		
		protected function ioErrorHandler(event:IOErrorEvent):void
		{
			MonsterDebugger.trace(this, event );
		}
		
		protected function dataLoaded(event:Event):void
		{
			MonsterDebugger.trace(this, JSON.decode( _loader.data ).response );
			
			switch( _dataType )
			{
				case DATA_TYPE_USERINFO:
				case DATA_TYPE_ACTIONSFRIENDREQ:
				case DATA_TYPE_ACTIONSUNFRIEND:
				case DATA_TYPE_ACTIONSAPPROVE:
				case DATA_TYPE_ACTIONSDENY:
				case DATA_TYPE_ACTIONSSETPINGS:
					_data = DataParser.parseUserInfo( JSON.decode( _loader.data ).response.user );
					break;
				case DATA_TYPE_USERSEARCH:
				case DATA_TYPE_USEREQUESTS:
					_data = DataParser.parseCompactUserInfo( JSON.decode( _loader.data ).response.results );
					break;
				case DATA_TYPE_USERBADGES:
					_data = DataParser.parseBadges( JSON.decode( _loader.data ).response );
					break;
				case DATA_TYPE_USERCHECKINS:
					_data = DataParser.parseCheckins( JSON.decode( _loader.data ).response.checkins.items );
					break;
				case DATA_TYPE_USERFRIENDS:
					_data = DataParser.parseCompactUserInfo( JSON.decode( _loader.data ).response.friends.items );
					break;
				case DATA_TYPE_USERTIPS:
				case DATA_TYPE_VENUETIPS:
					_data = DataParser.parseTips( JSON.decode( _loader.data ).response );
					break;
				case DATA_TYPE_USERTODOS:
					_data = DataParser.parseTodos( JSON.decode( _loader.data ).response );
					break;
				case DATA_TYPE_USERVENUEHISTORY:
					_data = DataParser.parseVenueHistory( JSON.decode( _loader.data ).response );
					break;
				case DATA_TYPE_VENUEINFO:
				case DATA_TYPE_VENUEADD:
					_data = DataParser.parseVenue( JSON.decode( _loader.data ).response );
					break;
				case DATA_TYPE_VENUETRENDING:
					_data = DataParser.parseVenues( JSON.decode( _loader.data ).response );
					break;
				case DATA_TYPE_VENUEHERENOW:
					_data = DataParser.parseCheckins( JSON.decode( _loader.data ).response.hereNow.items );
					break;
				case DATA_TYPE_VENUEPHOTOS:
					_data = DataParser.parsePhotos( JSON.decode( _loader.data ).response.photos.items);
					break;
				case DATA_TYPE_VENUEMARKTODO:
				case DATA_TYPE_TIPMARKTODO:
					_data = DataParser.parseTodo( JSON.decode( _loader.data ).response.todo );
					break;
				case DATA_TYPE_CHECKINADD:
					_data = DataParser.parseCheckin( JSON.decode( _loader.data ).response );
					break;
				case DATA_TYPE_CHECKINADDCOMMENT:
					_data = DataParser.parseComment( JSON.decode ( _loader.data ).response.comment );
					break;
				case DATA_TYPE_CHECKINDELCOMMENT:
					_data = DataParser.parseCheckin( JSON.decode ( _loader.data ).response );
					break;
				case DATA_TYPE_CHECKINRECENT:
					_data = DataParser.parseCheckins( JSON.decode( _loader.data ).response.recent );
					break;
				case DATA_TYPE_TIPSEARCH:
					_data = DataParser.parseSearchTips( JSON.decode( _loader.data ).response );
					break;
				case DATA_TYPE_TIPADD:
				case DATA_TYPE_TIPMARKTODO:
				case DATA_TYPE_TIPUNMARK:
				case DATA_TYPE_TIPMARKDONE:
					_data = DataParser.parseTip( JSON.decode( _loader.data ).response.tip );
					break;
			}
			
			dispatchEvent( new FourSquareEvent ( FourSquareEvent.REQUEST_COMPLETE, _data ) );
		}
		
		protected function statusError(event:HTTPStatusEvent):void
		{
			MonsterDebugger.trace(this, event );
			MonsterDebugger.trace(this, event.target.data );
		}

		public function get oauth():OAuth
		{
			return _oauth;
		}

		public function set oauth(value:OAuth):void
		{
			_oauth = value;
		}
		
		public function get dataType():String
		{
			return _dataType;
		}		
	}
}