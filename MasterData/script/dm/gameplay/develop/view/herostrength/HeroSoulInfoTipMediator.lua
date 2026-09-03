-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroSoulInfoTipMediator.lua

HeroSoulInfoTipMediator = class("HeroSoulInfoTipMediator", DmPopupViewMediator, _M)

HeroSoulInfoTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.bg.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onBackClicked"
	}
}

function HeroSoulInfoTipMediator:initialize()
	super.initialize(self)
end

function HeroSoulInfoTipMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function HeroSoulInfoTipMediator:onRemove()
	super.onRemove(self)
end

function HeroSoulInfoTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function HeroSoulInfoTipMediator:enterWithData(data)
	self:initData(data)
	self:initNodes()
	self:createUpView()
	self:createTableView()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SOULUPBYITEM_SUCC, self, self.refreshViewBySoulUpByItems)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SOULUPBYDIMOND_SUCC, self, self.refreshViewBySoulUpByDimond)
end

function HeroSoulInfoTipMediator:refreshViewBySoulUpByItems()
	self._upView.mediator:refreshViewBySoulUpByItems()
end

function HeroSoulInfoTipMediator:refreshViewBySoulUpByDimond()
	self._upView.mediator:refreshViewBySoulUpByDimond()
end

function HeroSoulInfoTipMediator:initData(data)
	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()
	self._player = self._developSystem:getPlayer()
	self._curIndex = data.index
	self._heroId = data.heroId
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._heroPro = PrototypeFactory:getInstance():getHeroPrototype(self._heroId)
	self._soulList = self._heroData:getHeroSoulList():getSoulArray()
end

function HeroSoulInfoTipMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._tabpanel = self._mainPanel:getChildByName("tabpanel")
end

function HeroSoulInfoTipMediator:createUpView()
	local viewData = {
		heroId = self._heroId,
		index = self._curIndex
	}

	if not self._upView then
		local view = self:getInjector():getInstance("HeroSoulUpView")

		if view then
			view:addTo(self._mainPanel):center(self._mainPanel:getContentSize())
			view:setLocalZOrder(990)

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				view.mediator = mediator

				mediator:enterWithData(self, viewData)
			end

			self._upView = view
		end
	end

	self._upView.mediator:refreshView(viewData)

	return self._upView
end

function HeroSoulInfoTipMediator:createTableView()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #self._soulList do
		local soul = self._soulList[i]

		data[#data + 1] = {
			tabText = soul:getName(),
			lock = soul:getLockState() == HeroSoulLockState.kLock
		}
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 390)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		ignoreAdjustSize = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curIndex)
	self._tabBtnWidget:removeTabBg()

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(0, 0)
	view:setLocalZOrder(1100)
end

function HeroSoulInfoTipMediator:onBackClicked(sender, eventType)
	self:close()
end

function HeroSoulInfoTipMediator:onClickTab(name, tag)
	local soulData = self._soulList[tag]

	if soulData:getLock() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("HeroSoul_Tip6")
		}))

		return
	end

	self._curIndex = tag

	self._upView.mediator:refreshView({
		heroId = self._heroId,
		index = self._curIndex
	})
end
