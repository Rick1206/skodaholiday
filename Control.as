package {
	 
	 
	import asfiles.events.MetaEvent;
	import asfiles.events.PlayerEvent;
	import asfiles.utils.Player;
	import com.zehfernando.display.drawPlane;
	import fl.video.VideoEvent;
	import fl.video.VideoState;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.SoundTransform;
	import flash.utils.getDefinitionByName;
	public class Control extends Sprite {
		private var shadow:Bitmap;
		private var loadingPecent:Number;
		private var cs:Array=[];
		private var c:C;
		private var frame:int;
		private var isChecking:Boolean;
		private var coverVideo:CoverVideo;
		private var pointContainer:Sprite;
		private var soundvalue:int=1;
		public var fullscreenBtn:Sprite;
		public var voiceSlider:Sprite;
		public var playBtn:MovieClip;
		public var voiceIcon:MovieClip;
		public var bar:Sprite;
		public var loading:Sprite;
		public var flv:Player;
		public var cover:Sprite;
		public var index:int;
		public var trackingData:Object;
		public var waiting:MovieClip;
		
		
		public function Control():void {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			
			bar['progress'].width = 1;
			voiceIcon.gotoAndStop(1);
			voiceIcon.buttonMode = true;
			voiceIcon.addEventListener(MouseEvent.CLICK, onClickSwitchSoundTransformHandler);
			voiceSlider.visible = false;
			//voiceIcon.visible = false;
			
			playBtn.gotoAndStop(2);
			playBtn.buttonMode = true;
			playBtn.addEventListener(MouseEvent.CLICK, onClickPlayHandler);
			fullscreenBtn.buttonMode = true;
			fullscreenBtn.addEventListener(MouseEvent.CLICK, onClickHandler);
			showShadow();
			resize();
			
			/*bar['progress'].buttonMode = true;
			bar['progress'].addEventListener(MouseEvent.MOUSE_DOWN, onMouseHandler);*/
			
			/*flv.addEventListener(VideoEvent.READY, onReadyHandler);
			flv.addEventListener(VideoEvent.STATE_CHANGE, onStatusHandler);
			
			flv.addEventListener(VideoProgressEvent.PROGRESS, onLoadingHandler);
			
			
			flv.addEventListener(VideoEvent.REWIND, onPlayReWindHandler);*/
			flv.addEventListener(VideoEvent.PLAYHEAD_UPDATE, onPlayProgressHandler);
			flv.addEventListener(VideoEvent.READY, onReadyHandler);
			flv.addEventListener(PlayerEvent.ON_LOAD_PROGRESS, onLoadingHandler);
			flv.addEventListener (MetaEvent.ON_META, onMyMetaData);
			flv.addEventListener (PlayerEvent.ON_PROGRESS, onProgress);
			flv.addEventListener("waiting", onEnterCheckHandler);
			flv.addEventListener("ok", onEnterCheckHandler);
			flv.addEventListener(VideoEvent.COMPLETE, onPlayCompleteHandler);
			
			
			flv.bufferTime = 50;
			 
			stage.addEventListener(Event.RESIZE, onResizeHandler);
		}
		
		private function onEnterCheckHandler(e:Event):void 
		{
			switch(e.type) {
				case "ok":
					if(index>=2){
						if (!isChecking) {
							isChecking = true;
							addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
						}
					}
					break;
				case "waiting":
					 
							isChecking = false;
							removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
						 
					break;
			}
		}
		
		private function onMyMetaData ( pEvt:MetaEvent ):void 
		{	
			
		}

		private function onProgress ( pEvt:PlayerEvent ):void
		{
			//trace("progress:", pEvt.progress);
			

			bar['progress'].width =  pEvt.progress * (stage.stageWidth-bar['progressBtn'].width/2);
			bar['progressBtn'].x =  pEvt.progress * (stage.stageWidth - bar['progressBtn'].width);
			
			 
					
					
		}
		private function onClickSwitchSoundTransformHandler(e:MouseEvent):void 
		{
			//var st:SoundTransform = new SoundTransform();
			switch(e.currentTarget.currentFrame) {
				case 1:
					//st.volume = 0;
					flv.setVoice(0);
					break;
				case 2:
					//st.volume = soundvalue;
					flv.setVoice(soundvalue);
					break;
			}
			//flv.soundTransform = st;
			e.currentTarget.gotoAndStop(e.currentTarget.currentFrame % 2 + 1);
			
		}
		
		private function onPlayReWindHandler(e:VideoEvent):void 
		{
			
			cover.visible = true;
			 
			 if (index > 1) {
				 pointContainer.visible = false;
				 frame = 0;
				for (var i:int = 0; i < trackingData.length;i++){
					 
					cs[i].x = trackingData[i][0].x;
					cs[i].y = trackingData[i][0].y;
					 
					 
				} 
				
				if(ImageContainer.sourceBitmap){
				
					drawPlane(cover.graphics, ImageContainer.sourceBitmap, 
																		new Point(cs[0].x, cs[0].y),
																		new Point(cs[1].x, cs[1].y),
																		new Point(cs[2].x, cs[2].y),
																		new Point(cs[3].x, cs[3].y)
					);
				}
			}
			frame = 0;
		}
		
		private function onMouseHandler(e:MouseEvent):void 
		{
			switch(e.type) {
				case MouseEvent.MOUSE_DOWN:
						//flv.pause();
						// bar['progressBtn'].x = (bar.mouseX-bar['progressBtn'].width/2);
						removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
						frame = int((bar.mouseX - bar['progressBtn'].width / 2) / (stage.stageWidth - bar['progressBtn'].width / 2) * 471);
						 
						isChecking = false;
						onEnterFrameHandler(null);
						//flv.seek((bar.mouseX-bar['progressBtn'].width/2)/(stage.stageWidth-bar['progressBtn'].width/2)*flv.totalTime);
					break;
				 
				case MouseEvent.MOUSE_MOVE:
					break;
			}
		}
		
		private function onPlayProgressHandler(e:VideoEvent):void 
		{
			
			 
			//trace("flv.playheadTime:",flv.playheadTime);
			
			//bar['progress'].width =  flv.playheadTime/flv.totalTime * (stage.stageWidth-bar['progressBtn'].width/2);
			//bar['progressBtn'].x =  flv.playheadTime / flv.totalTime * (stage.stageWidth - bar['progressBtn'].width);
			
			
		}
		
	 
		
		private function onEnterFrameHandler(e:Event):void 
		{
			frame++;
			
			
			//trace("frame", frame);
			
			var scale:Number = Math.min(stage.stageWidth / 540, (stage.stageHeight - 63) / 303);
			var flvWidth:Number = 540 * scale;
			var flvHeight:Number = 303 * scale;
			
			if(coverVideo){
				coverVideo.width = flvWidth;
				coverVideo.height = flvHeight;
				coverVideo.gotoAndStop(frame);
			
			}
			 
				
			for (var i:int = 0; i < trackingData.length; i++) {
				
				var _data:Array = trackingData[i];
				for (var j = 0; j < _data.length; j++ ) {
					if (_data[j].frame==frame) {
						//cs[i].visible=true;
						if (i > 1) {
							cs[i].x = _data[j].x* flvWidth/1280;
							cs[i].y = (_data[j].y+60) * flvWidth / 1280;
						}else {
							cs[i].x = _data[j].x* flvWidth/1280;
							cs[i].y = _data[j].y * flvWidth / 1280;
						}
						
						continue;
					}
				}
				
			}
				
				 if(ImageContainer.sourceBitmap){
				
					drawPlane(cover.graphics, ImageContainer.sourceBitmap, 
																		new Point(cs[0].x, cs[0].y),
																		new Point(cs[1].x, cs[1].y),
																		new Point(cs[2].x, cs[2].y),
																		new Point(cs[3].x, cs[3].y)
					);
				} 
			  
		}
		
		private function onLoadingHandler(e:*):void 
		{
			
			//loadingPecent = e.bytesTotal / e.bytesTotal;
			bar["loading"].width = flv.loadPencent * stage.stageWidth;
		}
		
		private function onReadyHandler(e:VideoEvent):void 
		{
			
			 
			cover.visible = true;
			 
			trace("READY");
			 
			if(coverVideo==null){
				coverVideo = new CoverVideo();
				cover.addChild(coverVideo);
				coverVideo.stop();
			}
			
			if(index>1){
				if (pointContainer == null) {
					pointContainer = new Sprite();
					cover.addChild(pointContainer);
				}
				
				trace("trackingData.length:",trackingData.length);
				for (var i:int = 0; i < trackingData.length;i++){
					c = new C();
					cs[i] = c;
					
					c['id'].text = (i + 1).toString();
					c.x = trackingData[i][0].x;
					c.y = trackingData[i][0].y;
					 c.visible = false;
					pointContainer.addChild(c);
					
			 
				}
				pointContainer.mouseChildren = pointContainer.mouseEnabled = false;
				
				
			}
			
		}
		
		private function showShadow():void 
		{
			var _class:Class;
			try {
				_class = getDefinitionByName("Shadow" + index) as Class;
				shadow = new Bitmap(new _class(0, 0));
				cover.addChild(shadow);
			}catch (e:ReferenceError) {
				trace("")
			} 
			
		}
		
		private function onPlayCompleteHandler(e:VideoEvent):void 
		{
			playBtn.gotoAndStop(3);
			trace("totalframes:", frame);
			//ExternalInterface.call("alert",frame);
			
			if(index>1){
				frame = 0;
				removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
				isChecking = false;
				for (var i:int = 0; i < trackingData.length;i++){
					cs[i].x = trackingData[i][0].x;
					cs[i].y = trackingData[i][0].y;
				}
			}
		}
		
		private function onStatusHandler(e:VideoEvent):void 
		{
		 
			/*@see VideoState#DISCONNECTED
         * @see VideoState.STOPPED
         * @see VideoState.PLAYING
         * @see VideoState.PAUSED
         * @see VideoState.BUFFERING
         * @see VideoState.LOADING
         * @see VideoState.CONNECTION_ERROR
         * @see VideoState.REWINDING
         * @see VideoState.SEEKING
		 * 
		*/	
			
			Debug.log(e.state);
			switch(e.state) {
				case VideoState.REWINDING:
					 
					break;
				case VideoState.PLAYING:
					pointContainer.visible = true;
					waiting.visible = false;
					
					if(index>=2){
						if (!isChecking) {
							isChecking = true;
							addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
						}
					}
					break;
				case VideoState.PAUSED:
				case VideoState.STOPPED:
					waiting.visible = false;
					playBtn.gotoAndStop(1);
					removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
					isChecking = false;
					break;
				case VideoState.BUFFERING:
				case VideoState.LOADING:
					waiting.visible = true;
					 
					removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
					isChecking = false;
					break;
				
				
			}
		}
		
		private function onClickPlayHandler(e:MouseEvent):void 
		{
			
			if (playBtn.currentFrame == 3) {
				flv.replay();
				playBtn.gotoAndStop(2);
				 if (index > 1) {
					if (!isChecking) {
							isChecking = true;
							addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
						}
				} 
				return;
			}
			if (playBtn.currentFrame == 2) {
				flv.pause();
				 if (index > 1) {
					removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
					isChecking = false;
				} 
				playBtn.gotoAndStop(1);
			}else{
				//flv.play();
				flv.pause();
				playBtn.gotoAndStop(2);
				 if (index > 1) {
					if (!isChecking) {
						isChecking = true;
						addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
					}
				} 
			}
		}
		
		private function onResizeHandler(e:Event):void 
		{
			resize();
		}
		
		public function resize():void 
		{
			 
			var scale:Number = Math.min(stage.stageWidth / 540, (stage.stageHeight - 63) / 303);
			var flvWidth:Number = 540 * scale;
			var flvHeight:Number = 303 * scale;
			 
			if(shadow){
				 shadow.width = flvWidth;
				 shadow.height = flvHeight;
			}
			 fullscreenBtn.x = stage.stageWidth - fullscreenBtn.width - 10;
			 voiceSlider.x = fullscreenBtn.x - voiceSlider.width - 15;
			 bar['base'].width = stage.stageWidth;
			 bar["loading"].width = loadingPecent * stage.stageWidth;
			 voiceIcon.x = fullscreenBtn.x-voiceIcon.width-10;
		}
		
		private function onClickHandler(e:MouseEvent):void 
		{
			stage.displayState =( stage.displayState==StageDisplayState.NORMAL)?StageDisplayState.FULL_SCREEN:StageDisplayState.NORMAL;
		}
	}
}