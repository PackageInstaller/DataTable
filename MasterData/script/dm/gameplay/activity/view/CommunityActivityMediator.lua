-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/CommunityActivityMediator.lua

CommunityActivityMediator = class("CommunityActivityMediator", BaseActivityMediator, _M)

CommunityActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.Button_go"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onQuestionClicked"
	},
	["main.Node_complete"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onQuestionComplete"
	}
}

function CommunityActivityMediator:initialize()
	super.initialize(self)
end

function CommunityActivityMediator:dispose()
	local activityData = self._activityData

	if activityData._rewardStatus == true then
		activityData._endTime = 0
	end

	super.dispose(self)
end

function CommunityActivityMediator:onRemove()
	super.onRemove(self)
end

function CommunityActivityMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function CommunityActivityMediator:enterWithData(data)
	self._activityData = data.activity
	self._parentMediator = data.parentMediator
	self._activityConfig = self._activityData._config.ActivityConfig

	self:setupView()
end

function CommunityActivityMediator:setupView()
	self:refreshView()
end

function CommunityActivityMediator:refreshView()
	local node_reward = self:getView():getChildByFullName("main.Node_reward")
	local button_go = self:getView():getChildByFullName("main.Button_go")
	local button_get = self:getView():getChildByFullName("main.Button_get")
	local node_complete = self:getView():getChildByFullName("main.Node_complete")
	local Text_des = self:getView():getChildByFullName("main.descText")

	Text_des:removeAllChildren()

	local goImg = ccui.ImageView:create("hd_sqyd_btn.png", ccui.TextureResType.plistType)
	local getImg = ccui.ImageView:create("hd_sqyd_btn.png", ccui.TextureResType.plistType)
	local completeImg = ccui.ImageView:create("hd_sqyd_btn.png", ccui.TextureResType.plistType)

	getImg:addTo(button_get):center(button_get:getContentSize())
	goImg:addTo(button_go):center(button_go:getContentSize())
	completeImg:addTo(node_complete):center(node_complete:getContentSize())

	local function callFunc(sender, eventType)
		self:onQuestionClicked(sender)
	end

	mapButtonHandlerClick(nil, goImg, {
		ignoreClickAudio = true,
		func = callFunc
	}, nil, true)

	local function callFunc(sender, eventType)
		self:onQuestionComplete(sender)
	end

	mapButtonHandlerClick(nil, completeImg, {
		ignoreClickAudio = true,
		func = callFunc
	}, nil, true)

	local desc = Strings:get("commounity_desc_1", {
		fontName = TTF_FONT_FZYH_M
	})
	local richText = ccui.RichText:createWithXML(desc, {})

	richText:setAnchorPoint(cc.p(0.5, 0.5))
	richText:setPosition(cc.p(Text_des:getPosition()))
	richText:addTo(Text_des:getParent())

	local canGetRewSta = self._activityData._canGetRewSta
	local rewardStatus = self._activityData._rewardStatus

	if rewardStatus then
		button_go:setVisible(false)
		button_get:setVisible(false)
		node_complete:setVisible(true)
	else
		node_complete:setVisible(false)

		if canGetRewSta then
			button_go:setVisible(false)
			button_get:setVisible(true)
		else
			button_go:setVisible(true)
			button_get:setVisible(false)
		end
	end

	node_reward:removeAllChildren()
end

function CommunityActivityMediator:onQuestionClicked()
	local url

	if self._activityData then
		local dict = self._activityConfig.URL
		local language = getCurrentLanguage()

		url = dict[language] or dict.en
	end

	if url then
		local loginSystem = self:getInjector():getInstance(LoginSystem)
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local curServer = loginSystem:getCurServer()
		local player = developSystem:getPlayer()

		url = string.format("%sroleid=%s&serverid=%s&uid=%s", url, player:getRid(), curServer:getSecId(), loginSystem:getUid())

		local view = cc.CSLoader:createNode("asset/ui/NativeWebView.csb")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, nil, nil))

		self._activityData._canGetRewSta = true

		local mediator = NativeWebViewMediator:new()

		mediator:setView(view)
		mediator:onRegister()

		local function callback()
			self:onRewardClicked()
		end

		mediator:enterWithData({
			url = url,
			callback = callback
		})
	end
end

function CommunityActivityMediator:onQuestionComplete(data)
	local url

	if self._activityData then
		local dict = self._activityConfig.URL
		local language = getCurrentLanguage()

		url = dict[language] or dict.en
	end

	if url then
		local loginSystem = self:getInjector():getInstance(LoginSystem)
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local curServer = loginSystem:getCurServer()
		local player = developSystem:getPlayer()

		url = string.format("%sroleid=%s&serverid=%s&uid=%s", url, player:getRid(), curServer:getSecId(), loginSystem:getUid())

		local view = cc.CSLoader:createNode("asset/ui/NativeWebView.csb")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, nil, nil))

		self._activityData._canGetRewSta = true

		local mediator = NativeWebViewMediator:new()

		mediator:setView(view)
		mediator:onRegister()

		local function callback()
			return
		end

		mediator:enterWithData({
			url = url,
			callback = callback
		})
	end
end

function CommunityActivityMediator:onRewardClicked()
	local activityData = self._activityData
	local activityId = self._activityData._id
	local param = {
		doActivityType = 101
	}

	self._activitySystem:requestDoActivity(activityId, param, function(response)
		activityData._rewardStatus = true

		self:showRewardView(response.data)
		self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
	end)
end
