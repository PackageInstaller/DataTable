-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/SettingStoreCommentMediator.lua

SettingStoreCommentMediator = class("SettingStoreCommentMediator", DmPopupViewMediator, _M)

SettingStoreCommentMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.layout.step1.btn_good"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickGood"
	},
	["main.layout.step1.btn_bad"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBad"
	},
	["main.layout.step1.btn_not"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickNot"
	},
	["main.layout.step2.btn_ok"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickOk"
	}
}
local steps = {
	step1 = 1,
	step2 = 2
}

function SettingStoreCommentMediator:initialize()
	super.initialize(self)
end

function SettingStoreCommentMediator:dispose()
	super.dispose(self)
end

function SettingStoreCommentMediator:onRemove()
	super.onRemove(self)
end

function SettingStoreCommentMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function SettingStoreCommentMediator:enterWithData(data)
	self._main = self:getView():getChildByName("main")
	self._layout = self._main:getChildByName("layout")
	self._step1 = self._layout:getChildByFullName("step1")
	self._step2 = self._layout:getChildByFullName("step2")

	local bgNode = self._layout:getChildByFullName("tipnode")

	bindWidget(self, bgNode, PopupNormalWidget, {
		fontSize = 35,
		ignoreBtnBg = true,
		title = "",
		ignoreWhiteBg = true,
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onOkClicked, self)
		},
		title1 = Strings:get(""),
		bgSize = {
			width = 760,
			height = 470
		},
		offsetForImage_bg3 = {
			diffX = 50,
			diffY = 0
		}
	})
	self:initView(steps.step1)

	self._starLayer = self._step2:getChildByFullName("starLayer")

	for i = 1, 5 do
		local star = self._starLayer:getChildByFullName("btn_star" .. i)

		star:setTag(i)
		star:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				-- block empty
			elseif eventType == ccui.TouchEventType.moved then
				-- block empty
			elseif eventType == ccui.TouchEventType.ended then
				self:setStarView(sender:getTag())
			end
		end)
	end

	self:setStarView(5)
end

function SettingStoreCommentMediator:setStarView(curTag)
	self._curStar = curTag

	for i = 1, 5 do
		local starBtn = self._starLayer:getChildByFullName("btn_star" .. i)
		local star = starBtn:getChildByFullName("star")

		if curTag >= starBtn:getTag() then
			star:loadTexture("common_icon_star.png", ccui.TextureResType.plistType)
			star:setScale(0.8)
		else
			star:loadTexture("common_icon_star2.png", ccui.TextureResType.plistType)
			star:setScale(0.6)
		end
	end
end

function SettingStoreCommentMediator:initView(step)
	self._curStep = step

	self._step1:setVisible(step == steps.step1)
	self._step2:setVisible(step == steps.step2)
end

function SettingStoreCommentMediator:refreshView()
	return
end

function SettingStoreCommentMediator:onOkClicked()
	if self._curStep == steps.step2 then
		self:initView(steps.step1)

		return
	end

	self:close()
end

function SettingStoreCommentMediator:onClickOk()
	if self._curStar >= 4 and SDKHelper then
		SDKHelper:requestReviewInApp({})
	end

	self:close()
end

function SettingStoreCommentMediator:onClickGood()
	self:initView(steps.step2)
end

function SettingStoreCommentMediator:onClickBad()
	local configValueKey = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StoreComment_url", "content")

	assert(configValueKey ~= nil, "ConfigValue表中没有StoreComment_url值")

	local url = configValueKey.URL[getCurrentLanguage()] or configValueKey.URL[GameLanguageType.EN]

	if url then
		local loginSystem = self:getInjector():getInstance(LoginSystem)
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local curServer = loginSystem:getCurServer()
		local player = developSystem:getPlayer()

		url = string.format("%sroleid=%s&serverid=%s&uid=%s", url, player:getRid(), curServer:getSecId(), loginSystem:getUid())

		local view = cc.CSLoader:createNode("asset/ui/NativeWebView.csb")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, nil, nil))

		local mediator = NativeWebViewMediator:new()

		mediator:setView(view)
		mediator:onRegister()
		mediator:enterWithData({
			url = url
		})
	end

	self:close()
end

function SettingStoreCommentMediator:onClickNot()
	self:close()
end
