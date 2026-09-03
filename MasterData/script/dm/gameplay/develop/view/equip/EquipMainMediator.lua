-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/equip/EquipMainMediator.lua

EquipMainMediator = class("EquipMainMediator", DmAreaViewMediator, _M)

EquipMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
EquipMainMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kTabBtnsNames = {
	[1] = "strengthenBtn"
}
local kTabViewNames = {
	[1] = "EquipAllUpdateView"
}
local kContentPanelTag = 10000

function EquipMainMediator:initialize()
	super.initialize(self)
end

function EquipMainMediator:dispose()
	self._equipSystem:resetEquipStarUpItem()

	if self._tabController then
		self._tabController:dispose()

		self._tabController = nil
	end

	super.dispose(self)
end

function EquipMainMediator:userInject()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()
	self._bagSystem = self._developSystem:getBagSystem()
end

function EquipMainMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshView)
end

function EquipMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Hero_Equip")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("EQUIP_TITLE")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function EquipMainMediator:enterWithData(data)
	data = data or {}
	self._viewCache = {}
	self._curTabType = data.tabType or 1
	self._equipId = data.equipId

	if not self._equipId then
		return
	end

	self:refreshData()
	self:initWidgetInfo()
	self:setupTopInfoWidget()
	self:initTabController()
	self:setupClickEnvs()
end

function EquipMainMediator:refreshView()
	self:refreshData()
	self:resetView()
end

function EquipMainMediator:refreshData()
	self._equipData = self._equipSystem:getEquipById(self._equipId)
end

function EquipMainMediator:initWidgetInfo()
	self._main = self:getView():getChildByName("main")
end

function EquipMainMediator:initTabController()
	self._tabPanel = self._main:getChildByFullName("tabbutton")
	self._tabBtns = {}

	local invalidBtns = {}

	self._ignoreSound = true

	for i, name in ipairs(kTabBtnsNames) do
		local btn = self._tabPanel:getChildByName(name)

		btn:getChildByFullName("dark_1.text1"):enableOutline(cc.c4b(3, 1, 4, 51), 1)
		btn:getChildByFullName("dark_1.text1"):setColor(cc.c3b(110, 108, 108))
		btn:getChildByFullName("dark_1.text1"):enableShadow(cc.c4b(3, 1, 4, 25.5), cc.size(1, 0), 1)
		btn:getChildByFullName("light_1.text1"):enableOutline(cc.c4b(3, 1, 4, 51), 1)
		btn:getChildByFullName("light_1.text1"):setColor(cc.c3b(110, 108, 108))
		btn:getChildByFullName("light_1.text1"):enableShadow(cc.c4b(3, 1, 4, 25.5), cc.size(1, 0), 1)
		btn:setTag(i)

		local unlock, tips = true, ""

		if i == 3 then
			unlock = true
			tips = Strings:get("Source_General_Unknown")
		end

		btn.unlock = unlock
		btn.tips = tips

		if not unlock then
			invalidBtns[#invalidBtns + 1] = btn

			btn:setGray(true)
		end

		self._tabBtns[#self._tabBtns + 1] = btn
	end

	self._tabController = TabController:new(self._tabBtns, function(name, tag)
		self:onClickTab(name, tag)
	end, {
		showAnim = 2
	})

	self._tabController:setInvalidButtons(invalidBtns)
	self._tabController:selectTabByTag(self._curTabType)
end

function EquipMainMediator:refreshTabRedPoint()
	local hasRed = self._equipSystem:hasRedPointByEquipStarUp(self._equipId)
	local btn = self._tabBtns[1]
	local redPoint = btn:getChildByTag(12138)

	if redPoint then
		redPoint:setVisible(hasRed)
	elseif hasRed then
		redPoint = ccui.ImageView:create(IconFactory.redPointPath, 1)

		redPoint:addTo(btn)
		redPoint:setAnchorPoint(cc.p(1, 1))
		redPoint:setPosition(cc.p(51, 106))
		redPoint:setTag(12138)
		redPoint:setLocalZOrder(999)
		redPoint:setRotation(-45)
	end
end

function EquipMainMediator:resetView(showAnim)
	local viewName = kTabViewNames[self._curTabType]

	if not self._viewCache[self._curTabType] then
		local view = self:getInjector():getInstance(viewName)

		if view then
			self._main:addChild(view, 1, kContentPanelTag)

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				view.mediator = mediator

				local data = {
					equipId = self._equipId,
					mediator = self
				}

				mediator:setupView(data)
			end

			self._viewCache[self._curTabType] = view
		end
	end

	for i, view in pairs(self._viewCache) do
		view:setVisible(i == self._curTabType)

		if view:isVisible() then
			local data = {
				equipId = self._equipId
			}

			view.mediator:refreshView(data)

			if showAnim then
				view.mediator:runStartAction()
			end
		end
	end

	self:refreshTabRedPoint()
end

function EquipMainMediator:refreshByMinus()
	self._viewCache[self._curTabType].mediator:refreshEquipByClick()
end

function EquipMainMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function EquipMainMediator:onClickTab(name, tag)
	if not self._ignoreSound then
		AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)
	else
		self._ignoreSound = false
	end

	local btn = self._tabPanel:getChildByName(name)

	if btn.unlock == false then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = btn.tips
		}))
	else
		self._equipSystem:resetEquipStarUpItem()

		self._curTabType = tag

		self._equipSystem:clearEquipConsumeItems()
		self:resetView(true)
	end
end

function EquipMainMediator:onClickEquipCell(cellTouchCallback)
	local cellEquipId = self._equipListView:getSelectEquipId()
	local equipData = self._equipData

	local function callback()
		if self._equipSystem:getEquipById(cellEquipId) then
			self._equipSystem:setStrengthenConsumeItems(cellEquipId)
		else
			self._equipSystem:setStrengthenConsumeItems(cellEquipId, 1)
		end

		if cellTouchCallback then
			cellTouchCallback()
		end

		self._viewCache[self._curTabType].mediator:refreshEquipByClick()
	end

	local hasConsumeItem = self._equipSystem:hasConsumeItem(cellEquipId)

	if hasConsumeItem then
		callback()

		return
	end

	local maxExp = equipData:getMaxExp()
	local preExp = self._equipSystem:getPreExp(equipData)

	if maxExp <= preExp then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI44")
		}))

		return
	end

	local isExpFull = self._equipSystem:checkIsExpFull(equipData, cellEquipId)

	if not isExpFull then
		callback()

		return
	end

	local data = {
		title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
		content = Strings:get("Equip_UI35"),
		sureBtn = {},
		cancelBtn = {}
	}
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			callback()
		elseif data.response == "cancel" then
			-- block empty
		elseif data.response == "close" then
			-- block empty
		end
	end

	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function EquipMainMediator:onClickEquipCellToStarUp()
	local cellEquipId = self._equipListView:getSelectEquipId()

	self._equipSystem:setStarConsumeItem(cellEquipId)
	self._viewCache[self._curTabType].mediator:refreshEquipByClick()
end

function EquipMainMediator:onClickEquipUnLock(equipId, cancelCallback, sureCallback)
	local data = {
		title = Strings:get("Equip_UnlockTitle"),
		content = Strings:get("Equip_UnlockText"),
		sureBtn = {},
		cancelBtn = {}
	}
	local this = self
	local delegate = {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			this._equipSystem:setStarConsumeItem(equipId)

			local params = {
				viewtype = 1,
				equipId = equipId
			}

			this._equipSystem:requestEquipLock(params, function()
				if sureCallback then
					sureCallback()
				end
			end)
		elseif data.response == "cancel" then
			if cancelCallback then
				cancelCallback()
			end
		elseif data.response == "close" and cancelCallback then
			cancelCallback()
		end
	end

	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function EquipMainMediator:runStartAction()
	self._equipPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/EquipMain.csb")

	self._equipPanel:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 32, false)
	action:setTimeSpeed(1.5)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "EndAnim" then
			-- block empty
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function EquipMainMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local mediator = self._viewCache[self._curTabType].mediator

	if self._curTabType == 1 then
		local quickBtn = mediator:getView():getChildByFullName("main.itemPanel.quickBtn")

		storyDirector:setClickEnv("EquipMainMediator.quickBtn", quickBtn, function(sender, eventType)
			mediator:onClickQuick(sender, eventType)
			storyDirector:notifyWaiting("click_EquipMainMediator_quickBtn")
		end)

		local strengthenBtn = mediator:getView():getChildByFullName("main.itemPanel.strengthenBtn")

		storyDirector:setClickEnv("EquipMainMediator.strengthenBtn", strengthenBtn, function(sender, eventType)
			mediator:onClickStrengthen(sender, eventType)
		end)
	end

	local tabBtns = self._tabBtns

	for i = 1, #tabBtns do
		local btn = tabBtns[i]
		local name = btn:getName()
		local tag = btn:getTag()

		storyDirector:setClickEnv("EquipMainMediator.tabBtn" .. i, btn, function(sender, eventType)
			self:onClickTab(name, tag)
			self._tabController:selectTabByTag(self._curTabType)
			storyDirector:notifyWaiting("click_EquipMainMediator_tabBtn")
		end)
	end

	storyDirector:notifyWaiting("enter_EquipMainMediator")
end
