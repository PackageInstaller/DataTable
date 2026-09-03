-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/task/view/TaskMediator.lua

require("dm.gameplay.task.view.TaskDailyMediator")
require("dm.gameplay.task.view.TaskGrowMediator")
require("dm.gameplay.task.view.TaskStageMediator")

TaskMediator = class("TaskMediator", DmAreaViewMediator, _M)

TaskMediator:has("_taskListModel", {
	is = "r"
}):injectWith("TaskListModel")
TaskMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
TaskMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kTabBtnsNames = {
	{
		"Task_UI2",
		"UITitle_EN_Richangrenwu"
	},
	{
		"Task_UI4",
		"UITitle_EN_Zhuxiantupo"
	},
	{
		"Task_UI30",
		"UITitle_EN_Gerenchengjiu"
	}
}
local kTaskViewPath = {
	"TaskDailyView",
	"TaskStageView",
	"TaskAchieveView"
}
local kViewType = {
	kDailyTask = 1,
	kAchieveTask = 3,
	kStageTask = 2
}
local kViewUnlock = {
	"DailyQuest",
	"MainTask",
	"Task_Achievement"
}
local kFuntionSwitch = {
	"fn_task_daily",
	"fn_task_main",
	"fn_task_achievement"
}
local kBtnHandlers = {
	["onekeyNode.btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickOnekey"
	}
}

function TaskMediator:initialize()
	super.initialize(self)
end

function TaskMediator:dispose()
	self._viewClose = true

	self:disposeView()
	super.dispose(self)
end

function TaskMediator:userInject()
	return
end

function TaskMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_RESET, self, self.updateView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_REFRESHVIEW, self, self.updateViewByEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_REWARD_SUCC, self, self.onGetRewardCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_ACHI_REWARD_SUCC, self, self.onGetRewardCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BOX_REWARD_SUCC, self, self.onGetRewardCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.updateViewByEvent)

	self._mainPanel = self:getView():getChildByFullName("main")
	self._bg = self._mainPanel:getChildByFullName("bg")
	self._onkeyBtn = self:getView():getChildByFullName("onekeyNode")

	self:setupTopInfoWidget()
end

function TaskMediator:enterWithData(data)
	self._data = data
	self._viewCache = {}

	local viewType = self:getFirstEnterTabType()

	if data then
		self._curViewType = data.tabType or viewType
	end

	self._refreshFirst = true

	self:setupClickEnvs()
	self:initTabController()
end

function TaskMediator:resumeWithData()
	self:setLayout(self._curViewType, true)
	self._tabBtnWidget:refreshAllRedPoint()
	self:setOneKeyGray()
end

function TaskMediator:updateViewByEvent()
	self:setLayout(self._curViewType, false)
	self._tabBtnWidget:refreshAllRedPoint()
end

function TaskMediator:updateView()
	local params = {
		taskType = {
			TaskType.kDaily,
			TaskType.kBranch,
			TaskType.kStage
		}
	}

	self._taskSystem:requestTaskList(params)
	self:setOneKeyGray()
end

function TaskMediator:getFirstEnterTabType()
	local tabType = kViewType.kDailyTask
	local unLockState1 = self._systemKeeper:isUnlock("DailyQuest")
	local unLockState2 = self._systemKeeper:isUnlock("MainTask")
	local unLockState3 = self._systemKeeper:isUnlock("Task_Achievement")

	if unLockState1 then
		tabType = kViewType.kDailyTask
	elseif unLockState2 then
		tabType = kViewType.kStageTask
	elseif unLockState3 then
		tabType = kViewType.kAchieveTask
	end

	if self._taskSystem:hasDailyRedPoint() then
		tabType = kViewType.kDailyTask
	elseif self._taskSystem:hasStageRedPoint() then
		tabType = kViewType.kStageTask
	elseif self._taskSystem:hasAchieveRedPoint() then
		tabType = kViewType.kAchieveTask
	end

	return tabType
end

function TaskMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Task_System")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		hasAnim = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Task_UI1")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function TaskMediator:initTabController()
	local unLockState = {}
	local tips = {}
	local canShowState = {}

	for i = 1, #kViewUnlock do
		local unlockName = kViewUnlock[i]
		local unlock, tip = self._systemKeeper:isUnlock(unlockName)

		unLockState[i] = unlock
		tips[i] = tip
		canShowState[i] = self._systemKeeper:canShow(unlockName) and CommonUtils.GetSwitch(kFuntionSwitch[i])
	end

	local redPointData = {
		function()
			return self._taskSystem:hasDailyRedPoint()
		end,
		function()
			return self._taskSystem:hasStageRedPoint()
		end,
		function()
			return self._taskSystem:hasAchieveRedPoint()
		end
	}
	local config = {}
	local data = {}

	for i = 1, #kTabBtnsNames do
		if canShowState[i] then
			data[#data + 1] = {
				lock = not unLockState[i],
				tabText = Strings:get(kTabBtnsNames[i][1]),
				tabTextTranslate = Strings:get(kTabBtnsNames[i][2]),
				redPointFunc = redPointData[i],
				viewType = i
			}
		end
	end

	config.btnDatas = data

	function config.onClickTab(name, tag)
		local viewType = data[tag].viewType

		if not unLockState[viewType] then
			self:dispatch(ShowTipEvent({
				tip = tips[tag]
			}))

			return
		end

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

	local function getRealTabTag(viewType)
		for index, v in pairs(data) do
			if v.viewType == viewType then
				return index
			end
		end

		return 1
	end

	self._tabBtnWidget:selectTabByTag(getRealTabTag(self._curViewType))

	local view = self._tabBtnWidget:getMainView()
	local tabPanel = self:getView():getChildByFullName("tab_panel")

	view:addTo(tabPanel):posite(0, 0)
end

function TaskMediator:onClickTab(name, viewType)
	if self._curViewType == viewType and not self._refreshFirst then
		return
	end

	if self._selectView and self._selectView.mediator._boxTipsWidget then
		self._selectView.mediator:removeBoxTipsView()
	end

	self:setLayout(viewType, true)
	self:setOneKeyVisible()
	self:dispatch(Event:new(EVT_REDPOINT_REFRESH))

	self._refreshFirst = false

	self:setOneKeyGray()
end

function TaskMediator:setOneKeyVisible()
	local unlock, tips = self._systemKeeper:isUnlock("Daily_Task_Receive")

	self._onkeyBtn:setVisible(unlock and (self._curViewType == kViewType.kDailyTask or self._curViewType == kViewType.kAchieveTask))
end

function TaskMediator:setOneKeyGray()
	local gray = false

	if self._curViewType == kViewType.kDailyTask then
		if not self._taskSystem:hasRedPoint(self._taskSystem:getShowDailyTaskList()) then
			gray = true
		end
	elseif self._curViewType == kViewType.kAchieveTask then
		dump(self._taskSystem:hasAchieveRedPoint(), " FFFFFFFFF self._taskSystem:hasAchieveRedPoin")

		if not self._taskSystem:hasAchieveRedPoint() then
			gray = true
		end
	end

	self._onkeyBtn:setGray(gray)
end

function TaskMediator:setLayout(viewType, hasAnim)
	self._bg:removeAllChildren()

	self._selectView = self:getViewByType(viewType)

	if self._selectView.mediator then
		self._selectView:setVisible(true)
		self._selectView.mediator:refreshView(hasAnim)
		self._selectView.mediator:setBg(self._bg)
	end

	self._curViewType = viewType
end

function TaskMediator:getViewByType(viewType)
	if not self._viewCache[viewType] then
		local view = self:getInjector():getInstance(kTaskViewPath[viewType])

		if view then
			view:addTo(self:getView():getChildByFullName("main"))
			AdjustUtils.adjustLayoutUIByRootNode(view)
			view:setPosition(0, 0)

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				view.mediator = mediator

				local var_21_0 = {}

				var_21_0.growSelectTag = self._data and self._data.growSelectTag

				local data = var_21_0

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

function TaskMediator:disposeView()
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

function TaskMediator:refreshRedPoint(event)
	self._tabBtnWidget:refreshAllRedPoint()
end

function TaskMediator:onClickOnekey()
	if self._curViewType == kViewType.kDailyTask then
		if not self._taskSystem:hasDailyTaskRedPoint() then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Task_Receive_All_Tips")
			}))

			return
		end

		self._taskSystem:requestOneKeyDailyTaskReward(nil, function()
			self:setOneKeyGray()
		end)
	elseif self._curViewType == kViewType.kAchieveTask then
		if not self._taskSystem:hasAchieveRedPoint() then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Task_Receive_All_Tips")
			}))

			return
		end

		self._taskSystem:requestOneKeyAchievementReward(nil, function()
			self:setOneKeyGray()
		end)
	end
end

function TaskMediator:onClickBack()
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function TaskMediator:onGetRewardCallback(event)
	local response = event:getData().response
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = response
	}))
end

function TaskMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local scriptName = guideAgent:getCurrentScriptName()

	if guideAgent:isGuiding() then
		self._curViewType = kViewType.kDailyTask
	end

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local tabBtns = self._tabBtnWidget._tabBtns

		for k, v in pairs(kViewUnlock) do
			local env = "TaskMediator." .. v
			local btnNode = tabBtns[k]

			storyDirector:setClickEnv(env, btnNode, function(sender, eventType)
				self._tabBtnWidget:selectTabByTag(k)
			end)
		end

		storyDirector:notifyWaiting("enter_TaskMediator_view")
	end))

	self:getView():runAction(sequence)
end
