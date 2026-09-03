-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivitySagaSupportScoreRewardMediator.lua

ActivitySagaSupportScoreRewardMediator = class("ActivitySagaSupportScoreRewardMediator", DmPopupViewMediator, _M)

ActivitySagaSupportScoreRewardMediator:has("_rankSystem", {
	is = "rw"
}):injectWith("RankSystem")
ActivitySagaSupportScoreRewardMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {}

function ActivitySagaSupportScoreRewardMediator:initialize()
	super.initialize(self)
end

function ActivitySagaSupportScoreRewardMediator:dispose()
	super.dispose(self)
end

function ActivitySagaSupportScoreRewardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Activity_Saga_UI_16"),
		title1 = Strings:get("Activity_Saga_UI_17"),
		bgSize = {
			width = 840,
			height = 520
		}
	})
	self:getView():getChildByFullName("main.tipTxt"):setString(Strings:get("Activity_Saga_UI_18"))

	self._listView = self:getView():getChildByFullName("main.listview")

	self._listView:setScrollBarEnabled(false)
	self._listView:setSwallowTouches(false)

	self._contentPanel = self:getView():getChildByFullName("clonePanel")

	self._contentPanel:setVisible(false)
end

function ActivitySagaSupportScoreRewardMediator:enterWithData(data)
	self._activity = data.activity
	self._activityId = data.activityId or ActivityId.kActivityBlockZuoHe

	self:initData()
	self:initView()
end

function ActivitySagaSupportScoreRewardMediator:resumeWithData()
	return
end

function ActivitySagaSupportScoreRewardMediator:refreshView()
	self:initData()
	self:initView()
end

function ActivitySagaSupportScoreRewardMediator:initData()
	self._data = self._activity:getSupportScoreRewardData()
	self._score = self._activity:getAllScore()
end

function ActivitySagaSupportScoreRewardMediator:initView()
	self:initContent()

	if self._activityId == ActivityId.kActivityWxh or self._activity:getUI() == ActivityType_UI.KActivityReZhan then
		self:getView():getChildByFullName("main.tipTxt"):setString(Strings:get("Activity_Saga_UI_18_wxh"))
	end
end

function ActivitySagaSupportScoreRewardMediator:initContent()
	local scoreValue1 = self:getView():getChildByFullName("main.scoreValue1")
	local scoreValue = self:getView():getChildByFullName("main.scoreValue")

	scoreValue:setPositionX(scoreValue1:getPositionX() + scoreValue1:getContentSize().width + 10)
	scoreValue:setString(self._score)
	self._listView:removeAllChildren(true)

	for i = 1, #self._data do
		local panel = self._contentPanel:clone()

		panel:setVisible(true)
		self._listView:pushBackCustomItem(panel)

		local actBtn = panel:getChildByName("actBtn")

		actBtn:setSwallowTouches(false)
		self:updataCell(panel, self._data[i], i)
	end
end

function ActivitySagaSupportScoreRewardMediator:updataCell(cell, _data, index)
	local mainView = cell
	local data = _data
	local conditionText = mainView:getChildByName("content")

	conditionText:setString(Strings:get("Activity_Saga_UI_20", {
		nums = data.score
	}))

	local rewardPanel = mainView:getChildByName("reward")

	rewardPanel:removeAllChildren()

	local rewards = RewardSystem:getRewardsById(tostring(data.rewardId))

	for i, rewardData in pairs(rewards) do
		local icon = IconFactory:createRewardIcon(rewardData, {
			isWidget = true
		})

		icon:setAnchorPoint(cc.p(0, 0))
		icon:setScaleNotCascade(0.6)
		icon:addTo(rewardPanel):posite(-4.5 + (i - 1) * 75, 0)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
			needDelay = true
		})
	end

	local status = data.status
	local actBtn = mainView:getChildByName("actBtn")

	actBtn:setVisible(false)

	local recieveImg = mainView:getChildByName("recieve")

	recieveImg:setVisible(false)

	local notRechieve = mainView:getChildByName("notRechieve")

	notRechieve:setVisible(false)

	if status == ActivityTaskStatus.kUnfinish then
		notRechieve:setVisible(true)
	elseif status == ActivityTaskStatus.kFinishNotGet then
		actBtn:setVisible(true)

		local function callFuncGo(sender, eventType)
			local beganPos = sender:getTouchBeganPosition()
			local endPos = sender:getTouchEndPosition()

			if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
				self:onClickGet(data, index)
			end
		end

		mapButtonHandlerClick(nil, actBtn, {
			func = callFuncGo
		})
	else
		recieveImg:setVisible(true)
	end
end

function ActivitySagaSupportScoreRewardMediator:onClickGo(data)
	local url = data:getDestUrl()
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end

function ActivitySagaSupportScoreRewardMediator:onClickGet(data, index)
	local status = data.status

	if status == ActivityTaskStatus.kUnfinish then
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("Task_Text1")
		}))

		return
	end

	local data = {
		doActivityType = 103,
		score = tostring(data.score)
	}

	self._activitySystem:requestDoActivity(self._activity:getId(), data, function(response)
		if not response.data then
			return
		end

		if response.data.rewards then
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = response.data.rewards
			}))
		end

		self:refreshView()
		self:dispatch(Event:new(EVT_ACTIVITY_SAGA_SCORE))
	end)
end

function ActivitySagaSupportScoreRewardMediator:addRedPoint(panel, data, status)
	local redPoint = panel:getChildByName("redPoint" .. data.Id)

	if not redPoint then
		redPoint = RedPoint:createDefaultNode()

		redPoint:addTo(panel):posite(80, 75)
		redPoint:setLocalZOrder(99901)
		redPoint:setName("redPoint" .. data.Id)
		redPoint:setScale(0.7)
	end

	redPoint:setVisible(status)
end

function ActivitySagaSupportScoreRewardMediator:onClickBack()
	self:close()
end

function ActivitySagaSupportScoreRewardMediator:onClickRule()
	local Arena_RuleTranslate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Rank_RuleTranslate", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Arena_RuleTranslate
	}, nil)

	self:dispatch(event)
end
