-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/share/view/ShareMediator.lua

ShareMediator = class("ShareMediator", DmPopupViewMediator, _M)

ShareMediator:has("_shareSystem", {
	is = "r"
}):injectWith("ShareSystem")

local kBtnHandlers = {}

function ShareMediator:initialize()
	super.initialize(self)
end

function ShareMediator:dispose()
	super.dispose(self)
end

function ShareMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function ShareMediator:mapEventListeners()
	return
end

function ShareMediator:enterWithData(data)
	self._data = data
	self._enterType = data.enterType
	self._startNode = data.startNode

	self:setUpView(data)
	self:addCapturedView()
end

function ShareMediator:setUpView()
	self._main = self:getView():getChildByName("main")
	self._serverNode = self._main:getChildByName("serverNode")

	self._main:setTouchEnabled(true)
	mapButtonHandlerClick(nil, self._main, {
		func = function()
			self._shareSystem:removeCapturedView(self._data)
		end
	})
end

function ShareMediator:addCapturedView()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local idStr = string.split(player:getRid(), "_")[1]
	local serverInfo = DmGame:getInstance()._injector:getInstance(LoginSystem):getCurServer()
	local name = serverInfo:getName()

	self._serverNode:getChildByName("btnName"):setString(Strings:get("Share_serverName", {
		name = name
	}))
	self._serverNode:getChildByName("serverId"):setString(Strings:get("Share_playerId", {
		id = idStr
	}))

	local config = ShareEnterContent[self._enterType]

	if config.nodePosition then
		self._serverNode:setPosition(config.nodePosition)
	end

	if config.textType then
		self._main:getChildByName("textNode" .. config.textType):setVisible(true)
	end

	if config.rotation then
		self._serverNode:setRotation(config.rotation)
	end

	local channelId = SDKHelper:getChannelID()
	local logo = ConfigReader:getRecordById("ConfigValue", "SocialSahringLogo").content

	logo = logo[channelId] or logo.normal
	logo = logo .. ".png"

	self._serverNode:getChildByName("serverImg"):loadTexture(logo, ccui.TextureResType.plistType)
end
