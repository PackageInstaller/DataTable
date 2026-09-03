-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friend/view/FriendMainMediator.lua

FriendMainMediator = class("FriendMainMediator", DmPopupViewMediator, _M)

FriendMainMediator:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")

local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_1",
		func = "onCloseClicked"
	}
}
local kTabViewNames = {
	[kFriendType.kGame] = "FriendListView",
	[kFriendType.kRecent] = "FriendListView",
	[kFriendType.kFind] = "FriendFindView",
	[kFriendType.kApply] = "FriendApplyView",
	[kFriendType.kBlack] = "FriendBlcakView"
}
local kTabNames = {
	[kFriendType.kGame] = "kGame",
	[kFriendType.kRecent] = "kRecent",
	[kFriendType.kFind] = "kFind",
	[kFriendType.kApply] = "kApply",
	[kFriendType.kApply] = "kBlack"
}
local TabName = {
	"Friend_UI5",
	"Friend_UI49",
	"Friend_UI4",
	"Friend_UI50",
	"Friend_UI50_1"
}
local TabNameTranslate = {
	"UITitle_EN_Haoyou",
	"UITitle_EN_Xiaoxi",
	"UITitle_EN_Shenqing",
	"UITitle_EN_Shenhe",
	"UITitle_EN_Heimingdan"
}

function FriendMainMediator:initialize()
	super.initialize(self)
end

function FriendMainMediator:dispose()
	self._friendSystem:clearHasApplyList()
	super.dispose(self)
end

function FriendMainMediator:onRemove()
	super.onRemove(self)
end

function FriendMainMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._tabPanel = self._main:getChildByName("tabpanel")

	self._main:getChildByFullName("bg.title_text1"):setString(Strings:get("UITitle_EN_Haoyou"))

	if getCurrentLanguage() ~= GameLanguageType.CN then
		local title_text = self._main:getChildByFullName("bg.title_text")

		title_text:setFontSize(50)
	end
end

function FriendMainMediator:userInject()
	return
end

function FriendMainMediator:enterWithData(data)
	self._curTabType = data and (data.tabType or 1) or 1

	if data then
		self._selectFriendIndex = data.selectFriendIndex or -1
	end

	self._selectFriendId = data.selectFriendId

	self:setupBgWidget()
	self:initTabView()
	self:setupRedPoints()
	self:mapEventListeners()
end

function FriendMainMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIENDAPPLY_REFRESH, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIEND_AGREEORREFUSE_SUCC, self, self.refreshMainInfo)
end

function FriendMainMediator:refreshView()
	if self._curTabType == kFriendType.kApply then
		self:showView()
		self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
	end
end

function FriendMainMediator:setupBgWidget()
	local btnClose = self:getView():getChildByFullName("main.btn_close")

	btnClose:setLocalZOrder(10)
end

function FriendMainMediator:initTabView()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #TabName do
		data[#data + 1] = {
			tabText = Strings:get(TabName[i]),
			tabTextTranslate = Strings:get(TabNameTranslate[i])
		}
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 482)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabType)
	self._tabBtnWidget:removeTabBg()

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabPanel):posite(0, 10)
	view:setLocalZOrder(1100)
end

function FriendMainMediator:showView()
	local viewName = kTabViewNames[self._curTabType]
	local view = self:getInjector():getInstance(viewName)

	if view then
		if self._selectView ~= nil then
			self._selectView:removeFromParent()

			self._selectView = nil
		end

		self._selectView = view

		self._main:addChild(view, 1)
		view:setName(kTabNames[self._curTabType])

		self._selectTabName = kTabNames[self._curTabType]

		local mediator = self:getMediatorMap():retrieveMediator(view)

		if mediator then
			local data = {}

			if self._curTabType == kFriendType.kGame then
				if self._oldTabType == kFriendType.kRecent then
					self._selectFriendIndex = -1
				end
			elseif self._curTabType == kFriendType.kRecent then
				if self._oldTabType == kFriendType.kGame then
					self._selectFriendIndex = -1
				end
			elseif self._curTabType == kFriendType.kFind then
				-- block empty
			elseif self._curTabType == kFriendType.kApply then
				-- block empty
			end

			data.mediator = self
			data.tabType = self._curTabType
			data.selectFriendIndex = self._selectFriendIndex
			data.selectFriendId = self._selectFriendId

			mediator:setupView(data)
		end
	end
end

function FriendMainMediator:refreshMainInfo()
	self._friendSystem:requestFriendsMainInfo()
end

function FriendMainMediator:changeTabView(tabType)
	self._curTabType = tabType

	self._tabBtnWidget:selectTabByTag(self._curTabType)
end

function FriendMainMediator:setupRedPoints()
	local applyBtn = self._tabBtnWidget:getTabBtns()[4]
	local node = RedPoint:createDefaultNode()

	node:setScale(0.8)
	RedPoint:new(node, applyBtn, function()
		return self._friendSystem:getHasNewApplyFriends() or self._friendSystem:getFriendModel():getFriendApplyCount() > 0
	end)
end

function FriendMainMediator:setSelectFriendIndex(tabType, index)
	self._oldTabType = tabType
	self._selectFriendIndex = index
end

function FriendMainMediator:onCloseClicked(sender, eventType)
	self._friendSystem:getFriendModel():synchronize({}, kFriendType.kFind, true)
	self:close()
end

function FriendMainMediator:onClickTab(name, tag)
	self._curTabType = tag

	self:showView()
	self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
end
