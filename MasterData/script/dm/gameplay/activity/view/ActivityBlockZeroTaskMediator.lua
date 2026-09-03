-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBlockZeroTaskMediator.lua

require("dm.gameplay.activity.view.ActivityTaskDailyMediator")
require("dm.gameplay.activity.view.ActivityTaskAchievementMediator")

ActivityBlockZeroTaskMediator = class("ActivityBlockZeroTaskMediator", DmAreaViewMediator, _M)

ActivityBlockZeroTaskMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ActivityBlockZeroTaskMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBlockZeroTaskMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

local kBtnHandlers = {}

function ActivityBlockZeroTaskMediator:initialize()
	super.initialize(self)
end

function ActivityBlockZeroTaskMediator:dispose()
	self._viewClose = true

	self:disposeView()
	super.dispose(self)
end

function ActivityBlockZeroTaskMediator:userInject()
	return
end

function ActivityBlockZeroTaskMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.updateViewByEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)

	self._mainPanel = self:getView():getChildByFullName("main")
	self._bg = self._mainPanel:getChildByFullName("bg")
	self._timeNode = self._mainPanel:getChildByFullName("timeNode")
	self._timeStr = self._timeNode:getChildByFullName("time")
	self._titleImageBg = self._mainPanel:getChildByFullName("titleImage_bg.titleImage_bg")
end

function ActivityBlockZeroTaskMediator:doReset()
	local model = self._activitySystem:getActivityById(self._activityId)

	if not model then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return true
	end

	local activities = model:getTaskActivities() or {}

	if #activities == 0 then
		self:dismiss()

		return true
	end

	return false
end

function ActivityBlockZeroTaskMediator:enterWithData(data)
	data = data or {}
	self._activityId = data.activityId
	self._activityModel = self._activitySystem:getActivityById(self._activityId)
	self._activities = self._activityModel:getTaskActivities()
	self._viewCache = {}

	local viewType = self:getFirstEnterTabType()

	self._curViewType = data.tabType or viewType
	self._refreshFirst = true

	self:setupTopInfoWidget()
	self:initTabController()
	self:setRolePanel()
	self:setTalkView()
end

function ActivityBlockZeroTaskMediator:setRolePanel()
	self._main = self:getView():getChildByName("main")
	self._rolePanel = self._main:getChildByFullName("talkPanel.rolePanel")
	self._talkText = self._main:getChildByFullName("talkPanel.Text_talk")
	self._talkRole = self._main:getChildByFullName("talkPanel")

	self._rolePanel:removeAllChildren()
	self._talkRole:getChildByName("Image_19"):setVisible(false)

	self._shopSpine = ShopSpine:new()

	self._shopSpine:addSpine(self._rolePanel)
	self._talkRole:addClickEventListener(function(sender)
		self:onClickTalkRole(sender)
	end)
end

function ActivityBlockZeroTaskMediator:setTalkView()
	self._showTalk = false

	self:onClickTalkRole()
end

function ActivityBlockZeroTaskMediator:onClickTalkRole(sender)
	self._showTalk = false

	local talkBg = self._talkRole:getChildByName("Image_20")

	talkBg:setVisible(self._showTalk)
	self._talkText:setVisible(self._showTalk)
	self._talkText:setString(self._shopSystem:getShopTalkShow())
	self:playAnimation(sender)
end

function ActivityBlockZeroTaskMediator:playAnimation(sender)
	local function callback(voice)
		return
	end

	if self._buySuccessedInstance then
		self._buySuccessedInstance = false

		self._shopSpine:playAnimation(nil, nil, KShopVoice.buyEnd, callback)

		return
	end

	if sender then
		if self._shopSpine:getActionStatus() then
			self._shopSpine:playAnimation(KShopAction.click, false, KShopVoice.click, callback)
		end
	else
		self._shopSpine:playAnimation(KShopAction.begin, false, KShopVoice.begin, callback)
	end
end

function ActivityBlockZeroTaskMediator:resumeWithData()
	local quit = self:doReset()

	if quit then
		return
	end

	self:setLayout(self._curViewType, true)
	self:setTalkView()
end

function ActivityBlockZeroTaskMediator:updateViewByEvent()
	self:setLayout(self._curViewType, false)
end

function ActivityBlockZeroTaskMediator:updateView()
	return
end

function ActivityBlockZeroTaskMediator:getFirstEnterTabType()
	local tabType = 1

	for i = 1, #self._activities do
		local activity = self._activities[i]

		if activity:hasRedPoint() then
			tabType = i

			break
		end
	end

	return tabType
end

function ActivityBlockZeroTaskMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		hasAnim = true,
		currencyInfo = self._activityModel:getResourcesBanner(),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("ActivityBlock_UI_10")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ActivityBlockZeroTaskMediator:initTabController()
	local config = {}
	local data = {}

	for i = 1, #self._activities do
		local activity = self._activities[i]
		local entitle = activity:getActivityConfig().entitle

		data[#data + 1] = {
			tabText = Strings:get(activity:getTitle()),
			tabTextTranslate = Strings:get(entitle),
			redPointFunc = function()
				return activity:hasRedPoint()
			end,
			viewType = i
		}

		local taskBtn = self._mainPanel:getChildByFullName("titleImage_bg.taskBtn" .. i)

		if taskBtn then
			local text = taskBtn:getChildByFullName("text")

			taskBtn:setTag(i)
			text:setTag(i)
			text:setTouchEnabled(true)
			text:addClickEventListener(function(sender)
				self:onClickTab("", sender:getTag())
			end)
		end
	end

	config.btnDatas = data
	self.btnConfig = config

	self:onClickTab("", self._curViewType)
end

function ActivityBlockZeroTaskMediator:updateBtn(curViewType)
	for i = 1, 10 do
		local btn = self._mainPanel:getChildByFullName("titleImage_bg.taskBtn" .. i)

		if btn then
			local btnTag = btn:getTag()
			local data = self.btnConfig.btnDatas[btnTag]
			local text = btn:getChildByFullName("text")
			local img = btn:getChildByFullName("img")
			local color = curViewType ~= btnTag and cc.c3b(121, 121, 121) or cc.c3b(255, 255, 255)
			local imgName = curViewType ~= btnTag and "clks_hdrw_rcrebat2.png" or "clks_hdrw_rcrwbat1.png"
			local zOrder = curViewType == btnTag and 3 or 1

			self._titleImageBg:setLocalZOrder(2)
			text:setColor(color)
			text:setString(data.tabText)
			img:loadTexture(imgName, 1)
			btn:setLocalZOrder(zOrder)

			local redPoint = btn:getChildByFullName("redPoint")
			local activity = self._activities[i]

			redPoint:setVisible(activity and activity:hasRedPoint())
		end
	end
end

function ActivityBlockZeroTaskMediator:onClickTab(name, viewType)
	if self._curViewType == viewType and not self._refreshFirst then
		return
	end

	self:setLayout(viewType, true)
	self:dispatch(Event:new(EVT_REDPOINT_REFRESH))

	self._refreshFirst = false
end

function ActivityBlockZeroTaskMediator:setLayout(viewType, hasAnim)
	self._bg:removeAllChildren()

	self._selectView = self:getViewByType(viewType)

	if self._selectView.mediator then
		self._selectView:setVisible(true)
		self._selectView.mediator:refreshView(hasAnim)
		self._selectView.mediator:setBg(self._bg)
		self._selectView.mediator:refreshTime(self._timeStr)
	end

	self._curViewType = viewType

	self:updateBtn(viewType)
end

function ActivityBlockZeroTaskMediator:getViewByType(viewType)
	if not self._viewCache[viewType] then
		local activity = self._activities[viewType]
		local viewName = ActivityUI[activity:getUI()]
		local view = self:getInjector():getInstance(viewName)

		if view then
			view:addTo(self:getView():getChildByFullName("main"))
			AdjustUtils.adjustLayoutUIByRootNode(view)
			view:setPosition(0, 0)

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				view.mediator = mediator

				local data = {
					mainActivityId = self._activityId,
					activityId = activity:getId()
				}

				mediator:setupView(self, data)
			end

			self._viewCache[viewType] = view
		end
	end

	for type, view in pairs(self._viewCache) do
		if viewType == type then
			view:setVisible(true)
		else
			local mediator = view.mediator

			mediator:removeTableView()
			view:setVisible(false)
		end
	end

	return self._viewCache[viewType]
end

function ActivityBlockZeroTaskMediator:disposeView()
	for k, view in pairs(self._viewCache) do
		if view and view.mediator then
			view.mediator:dispose()

			view.mediator = nil
		end
	end

	self._viewCache = nil

	if self._tabController then
		self._tabController:dispose()

		self._tabController = nil
	end
end

function ActivityBlockZeroTaskMediator:onClickBack()
	self:dismiss()
end

function ActivityBlockZeroTaskMediator:onGetRewardCallback(rewards)
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = rewards
	}))
end
