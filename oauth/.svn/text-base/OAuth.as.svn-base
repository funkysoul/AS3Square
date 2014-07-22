package ch.publicis.dealer.social.AS3Square.oauth
{	

	
	import ch.publicis.dealer.social.AS3Square.events.OAuthEvent;
	
	import com.adobe.serialization.json.JSON;
	
	import flash.display.NativeWindow;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Rectangle;
	import flash.html.HTMLLoader;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	/**
	 * 
	 * 
	 * @author tiago.dias
	 * 
	 */	
	public class OAuth extends EventDispatcher
	{
		private static const OAUTHURL				:String				= "https://foursquare.com/oauth2/authenticate";
		private static const ACCESSTOKENURL			:String				= "https://foursquare.com/oauth2/access_token";	
		
		private var _sharedObj				:SharedObject;
		
		private var _consumerKey			:String;
		private var _consumerSecret			:String;
		private var _callbackURL			:String;
		private var _authCode				:String;	
		
		private var _accessToken			:String;
		
		private var _nativeWin				:NativeWindow;
		private var _htmlLoader				:HTMLLoader;
		private var _urlLoader				:URLLoader;
		private var _type					:String;
		
				
		/**
		 * 
		 * 
		 */		
		public function OAuth()
		{
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener( Event.COMPLETE, onDataComplete );
			_urlLoader.addEventListener( IOErrorEvent.IO_ERROR, handleError );
			_urlLoader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, handleError );		
		}
		
		/**
		 * 
		 * 
		 */		
		public function requestAccessToken():void
		{
			if ( SharedObject.getLocal( "fsData" ).data.accessToken )
			{				
				accessToken = SharedObject.getLocal( "fsData" ).data.accessToken;
				dispatchEvent( new OAuthEvent( OAuthEvent.SUCCESS ) );
			}
			else
			{
				var urlReq:URLRequest = new URLRequest( OAUTHURL + "?client_id=" + _consumerKey + "&response_type=code&redirect_uri=" +  _callbackURL );
				var rect:Rectangle = new Rectangle( 300, 300, 700, 500 );
				
				_htmlLoader	= HTMLLoader.createRootWindow( true, null, true, rect );
				_htmlLoader.addEventListener( Event.COMPLETE, accessCodeReceived );
				_htmlLoader.load( urlReq );
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function accessCodeReceived( event:Event ):void
		{
			var oauthString:String = "?code=";
			var location:String = _htmlLoader.location;
			var hasOAuthCode:Boolean = location.indexOf("?code") != -1;
			var ind:int = location.indexOf( oauthString );
			
			if ( hasOAuthCode )
			{
				_htmlLoader.removeEventListener( Event.COMPLETE, accessCodeReceived );
				
				_authCode = location.substr( ind + oauthString.length, location.length );
				_htmlLoader.stage.nativeWindow.close();
				_htmlLoader = null;
				
				getAccessToken();
			}
			else
			{
				dispatchEvent( new OAuthEvent( OAuthEvent.ERROR ) );
			}
		}
		
		/**
		 * 
		 * 
		 */		
		private function getAccessToken():void
		{
			var url:String = ACCESSTOKENURL + "?client_id=" + _consumerKey + "&client_secret=" + _consumerSecret + "&grant_type=authorization_code" + "&redirect_uri=" + _callbackURL + "&code=" + _authCode ;
			
			var urlRequest:URLRequest = new URLRequest( url );
			urlRequest.method = URLRequestMethod.POST;
			
			_urlLoader.load( urlRequest );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function onDataComplete(event:Event):void
		{
			var obj:Object 	= JSON.decode( event.target.data );
			_accessToken	= obj.access_token;
			
			_sharedObj		= SharedObject.getLocal("fsData");
			_sharedObj.data.accessToken = _accessToken;
												
			dispatchEvent( new OAuthEvent( OAuthEvent.SUCCESS ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function handleError(event:ErrorEvent):void
		{
			
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get consumerKey():String
		{
			return _consumerKey;
		}

		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set consumerKey(value:String):void
		{
			_consumerKey = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get consumerSecret():String
		{
			return _consumerSecret;
		}

		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set consumerSecret(value:String):void
		{
			_consumerSecret = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get callbackURL():String
		{
			return _callbackURL;
		}

		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set callbackURL(value:String):void
		{
			_callbackURL = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get accessToken():String
		{
			return _accessToken;
		}

		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set accessToken(value:String):void
		{
			_accessToken = value;
		}
	}
}