-- chunkname: @/tmp/or_script/lua_compile/dm/DmGame.lua

EVT_ENTER_FOREGROUND = "EVT_ENTER_FOREGROUND"
EVT_ENTER_BACKGROUND = "EVT_ENTER_BACKGROUND"
EVT_RESIGN_ACTIVE = "EVT_RESIGN_ACTIVE"
EVT_BECOME_ACTIVE = "EVT_BECOME_ACTIVE"
EVT_WILL_TERMINATE = "EVT_WILL_TERMINATE"
EVT_RECEIVE_MEMORY_WARNING = "EVT_RECEIVE_MEMORY_WARNING"
EVT_CONTEXT_STARTUP = "EVT_CONTEXT_STARTUP"
EVT_CONTEXT_SHUTDOWN = "EVT_CONTEXT_SHUTDOWN"
CCSViewFactory = class("CCSViewFactory", legs.ViewFactoryAdapter, _M)

function CCSViewFactory:createViewByResourceId(resId)
	if GAME_SHOW_TIMECONSUME or app.pkgConfig.showTimeConsume == 1 or GameConfigs.dpsLoggerEnable then
		local t0 = app.getTimeInMilliseconds()
		local node = cc.CSLoader:createNode(resId)
		local t = app.getTimeInMilliseconds()

		if node then
			node.csloader_t = t - t0
		end

		return node
	end

	return cc.CSLoader:createNode(resId)
end

DmGameContext = class("DmGameContext", GameContext)

function DmGameContext:startup()
	super.startup(self)

	local injector = self:getInjector()
	local commandMap = self:getCommandMap()

	injector:mapSingletonOf("legs.ViewFactoryAdapter", CCSViewFactory)

	SDKHelper = require("sdk.SDKHelper"):new()

	injector:injectInto(SDKHelper)

	local language = GameLanguageTypeForSdkAndroid[getCurrentLanguage()]

	SDKHelper:setLanguage((device.platform == "ios" or nil) and GameLanguageTypeForSdk[getCurrentLanguage()])

	local modules = require("dm.modules")

	if modules then
		self:initModuleConfigs(modules)
		self:loadModuleByName("__startup__")
	end

	commandMap:unmapEvent(EVT_PUSH_VIEW, "PushViewCommand")
	commandMap:mapEvent(EVT_PUSH_VIEW, "DmPushViewCommand")
	commandMap:unmapEvent(EVT_SWITCH_VIEW, "SwitchViewCommand")
	commandMap:mapEvent(EVT_SWITCH_VIEW, "DmSwitchViewCommand")
	commandMap:mapEvent(EVT_POP_VIEW, "DmPopViewCommand")
	commandMap:mapEvent(EVT_POP_TO_TARGETVIEW, "DmPopToTargetViewCommand")

	local dispatcher = self:getEventDispatcher()

	dispatcher:dispatchEvent(Event:new(EVT_CONTEXT_STARTUP))

	local content = {
		point = "login_game_startup",
		type = "loginflow"
	}

	StatisticSystem:send(content)
end

function DmGameContext:shutdown()
	local dispatcher = self:getEventDispatcher()

	dispatcher:dispatchEvent(Event:new(EVT_CONTEXT_SHUTDOWN))
	super.shutdown(self)
end

DmGame = class("DmGame", BaseGame)

function DmGame:initialize()
	super.initialize(self)
end

function DmGame:dispose()
	super.dispose(self)
end

function DmGame:run(...)
	cclog("[info]", "========================================")
	cclog("[info]", "Game is running...")
	super.run(self, ...)
end

function DmGame:setup(injector)
	super.setup(injector)

	local sharedDispatcher = EventDispatcher:new()
	local gameContext = DmGameContext:new(injector, sharedDispatcher)

	injector:injectInto(gameContext)
	app.setLuaAppDelegate(self)

	return gameContext
end

function DmGame:cleanup()
	app.setLuaAppDelegate(nil)
end

function DmGame:appWillResignActive()
	cclog("[info]", "appWillResignActive")
	self:dispatch(Event:new(EVT_RESIGN_ACTIVE))
	dmAudio.pauseAll()
	cri.suspendLibraryContext()
end

function DmGame:appDidBecomeActive()
	cclog("[info]", "appDidBecomeActive")
	self:dispatch(Event:new(EVT_BECOME_ACTIVE))
	dmAudio.resumeAll()
	cri.resumeLibraryContext()
end

function DmGame:appDidEnterBackground()
	cclog("[info]", "appDidEnterBackground")
	self:dispatch(Event:new(EVT_ENTER_BACKGROUND))
	dmAudio.pauseAll()
	cri.suspendLibraryContext()
end

function DmGame:appWillEnterForeground()
	cclog("[info]", "appWillEnterForeground")
	self:dispatch(Event:new(EVT_ENTER_FOREGROUND))
	dmAudio.resumeAll()
	cri.resumeLibraryContext()
end

function DmGame:appWillTerminate()
	cclog("[info]", "appWillTerminate")
	self:dispatch(Event:new(EVT_WILL_TERMINATE))
end

function DmGame:didReceiveMemoryWarning()
	cclog("[info]", "didReceiveMemoryWarning")
	self:dispatch(Event:new(EVT_RECEIVE_MEMORY_WARNING))
end

function DmGame:resolveStringContent(strid)
	return Strings:get(strid)
end
