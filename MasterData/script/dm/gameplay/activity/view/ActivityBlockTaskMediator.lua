-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBlockTaskMediator.lua

require("dm.gameplay.activity.view.ActivityTaskDailyMediator")
require("dm.gameplay.activity.view.ActivityTaskAchievementMediator")

ActivityBlockTaskMediator = class("ActivityBlockTaskMediator", DmAreaViewMediator, _M)

ActivityBlockTaskMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ActivityBlockTaskMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

function ActivityBlockTaskMediator:initialize()
	super.initialize(self)
end

function ActivityBlockTaskMediator:dispose()
	self._viewClose = true

	self:disposeView()
	super.dispose(self)
end

function ActivityBlockTaskMediator:userInject()
	return
end

function ActivityBlockTaskMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.updateViewByEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)

	self._mainPanel = self:getView():getChildByFullName("main")
	self._bg = self._mainPanel:getChildByFullName("bg")
	self._titleImage = self._mainPanel:getChildByFullName("titleImage")

	self._titleImage:ignoreContentAdaptWithSize(true)

	self._timeNode = self._mainPanel:getChildByFullName("timeNode")
	self._timeStr = self._timeNode:getChildByFullName("time")
end

function ActivityBlockTaskMediator:doReset()
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

function ActivityBlockTaskMediator:enterWithData(data)
	data = data or {}
	self._activityId = data.activityId
	self._activityModel = self._activitySystem:getActivityById(self._activityId)
	self._activities = self._activityModel:getTaskActivities()
	self._viewCache = {}

	local viewType = self:getFirstEnterTabType(data.taskId)

	self._curViewType = data.tabType or viewType
	self._refreshFirst = true

	self:setupTopInfoWidget()
	self:initTabController()
end

function ActivityBlockTaskMediator:resumeWithData()
	local quit = self:doReset()

	if quit then
		return
	end

	self:setLayout(self._curViewType, true)
	self._tabBtnWidget:refreshAllRedPoint()
end

function ActivityBlockTaskMediator:updateViewByEvent()
	self:setLayout(self._curViewType, false)
	self._tabBtnWidget:refreshAllRedPoint()
end

function ActivityBlockTaskMediator:updateView()
	return
end

function ActivityBlockTaskMediator:getFirstEnterTabType(taskId)
	local tabType = 1

	for i = 1, #self._activities do
		local activity = self._activities[i]

		if taskId then
			if activity:getId() == taskId then
				tabType = i

				break
			end
		elseif activity:hasRedPoint() then
			tabType = i

			break
		end
	end

	return tabType
end

function ActivityBlockTaskMediator:setupTopInfoWidget()
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

function ActivityBlockTaskMediator:initTabController()
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
	end

	config.btnDatas = data

	function config.onClickTab(name, tag)
		local viewType = data[tag].viewType

		self:onClickTab(name, viewType)
	end

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curViewType)

	local view = self._tabBtnWidget:getMainView()
	local tabPanel = self:getView():getChildByFullName("tab_panel")

	view:addTo(tabPanel):posite(0, 0)
end

function ActivityBlockTaskMediator:onClickTab(name, viewType)
	if self._curViewType == viewType and not self._refreshFirst then
		return
	end

	self:setLayout(viewType, true)
	self:dispatch(Event:new(EVT_REDPOINT_REFRESH))

	self._refreshFirst = false
end

function ActivityBlockTaskMediator:setLayout(viewType, hasAnim)
	self._bg:removeAllChildren()

	self._selectView = self:getViewByType(viewType)

	if self._selectView.mediator then
		self._selectView:setVisible(true)
		self._selectView.mediator:refreshView(hasAnim)
		self._selectView.mediator:setBg(self._bg, self._titleImage)
		self._selectView.mediator:refreshTime(self._timeStr)
	end

	self._curViewType = viewType
end

function ActivityBlockTaskMediator:getViewByType(viewType)
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

function ActivityBlockTaskMediator:disposeView()
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

function ActivityBlockTaskMediator:refreshRedPoint(event)
	self._tabBtnWidget:refreshAllRedPoint()
end

function ActivityBlockTaskMediator:onClickBack()
	self:dismiss()
end

function ActivityBlockTaskMediator:onGetRewardCallback(rewards)
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = rewards
	}))
end
