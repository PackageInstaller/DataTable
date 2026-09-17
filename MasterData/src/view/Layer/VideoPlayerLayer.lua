VideoPlayerLayer = class("VideoPlayerLayer", function()
	return ccexp.VideoPlayer:create()
end)

local var_0_0 = 0
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4

function VideoPlayerLayer.getInstance()
	return var_0_4
end

function VideoPlayerLayer.create(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = VideoPlayerLayer.new()

	var_3_0:init(arg_3_1, arg_3_2)

	return var_3_0
end

function VideoPlayerLayer:init(arg_4_1, arg_4_2)
	var_0_4 = self

	self:setKeepAspectRatioEnabled(true)
	self:setFullScreenEnabled(true)
	self:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.statusbar_height))
	self:setAnchorPoint(cc.p(0.5, 0.5))
	self:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy + GameDisplay.statusbar_height / 2))
	self:addFullScreenMask()

	if DeviceManager.platform == "android" then
		if cc.FileUtils:getInstance():isFileExist(arg_4_1) then
			self:setFileName(cc.FileUtils:getInstance():fullPathForFilename(arg_4_1))
		else
			self:setFileName("res/localvideo/" .. arg_4_1)
		end
	else
		self:setFileName(cc.FileUtils:getInstance():fullPathForFilename(arg_4_1))
	end

	if arg_4_2 then
		self:addskipbutton()
	end

	self.eventHandler = {
		[var_0_0] = nil,
		[var_0_1] = nil,
		[var_0_2] = nil,
		[var_0_3] = nil
	}

	self:addEventListener(function(arg_5_0, arg_5_1)
		if self.eventHandler[arg_5_1] then
			self.eventHandler[arg_5_1]()
		end
	end)
	self:initPlayTimeLine()
	self:initEventListener()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_4 = nil
		end
	end)
end

function VideoPlayerLayer:addFullScreenMask()
	local var_7_0 = ccui.Layout:create()

	var_7_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_7_0:setName("fullScreenMask")
	var_7_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_7_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_7_0:setBackGroundColorOpacity(127.5)
	var_7_0:setPosition(-GameDisplay.fix_x, -GameDisplay.fix_y)
	var_7_0:setTouchEnabled(true)
	self:addChild(var_7_0, -1)
end

function VideoPlayerLayer:registerEventHandler(arg_8_1, arg_8_2)
	self.eventHandler[arg_8_1] = arg_8_2
end

function VideoPlayerLayer.pauseVideo(arg_9_0)
	print("video player layer pause video.....")
end

function VideoPlayerLayer:resumeVideo()
	print("video player resume video.....")
	self:seekTo(self._playtime)
	self:play()
end

function VideoPlayerLayer:initPlayTimeLine()
	self._playtime = 0

	self:scheduleUpdateWithPriorityLua(function(arg_12_0)
		self._playtime = self._playtime + arg_12_0
	end, 0)
end

function VideoPlayerLayer:initEventListener()
	local var_13_0 = self:getEventDispatcher()

	var_13_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("APPENTERFOREGROUND", function(arg_14_0)
		self:resumeVideo()
	end), self)
	var_13_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("APPENTERBACKGROUND", function(arg_15_0)
		self:pauseVideo()
	end), self)
end
