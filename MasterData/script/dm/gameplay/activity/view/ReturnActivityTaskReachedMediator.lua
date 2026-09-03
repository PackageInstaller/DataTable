-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ReturnActivityTaskReachedMediator.lua

ReturnActivityTaskReachedMediator = class("ReturnActivityTaskReachedMediator", DmPopupViewMediator, _M)

ReturnActivityTaskReachedMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ReturnActivityTaskReachedMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function ReturnActivityTaskReachedMediator:initialize()
	super.initialize(self)
end

function ReturnActivityTaskReachedMediator:dispose()
	super.dispose(self)
end

function ReturnActivityTaskReachedMediator:onRegister()
	super.onRegister(self)
	self:initUI()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RETURN_ACTIVITY_REFRESH, self, self.refreshHeroShowByEvent)
end

function ReturnActivityTaskReachedMediator:enterWithData(data)
	self:initData(data)
	self:checkHeroChoose()
	self:refreshHeroShow()
	self:setupView()
	self:refreshRedPoint()
end

function ReturnActivityTaskReachedMediator:resumeView()
	return
end

function ReturnActivityTaskReachedMediator:initUI()
	self._main = self:getView():getChildByName("main")
	self._taskInfo = self._main:getChildByName("taskInfo")
	self._taskBtn = self._main:getChildByName("taskBtn")
	self._listView = self._main:getChildByName("taskList")

	self._listView:setScrollBarEnabled(false)

	self._dayList = self._main:getChildByName("dayList")

	self._dayList:setScrollBarEnabled(false)

	self._cloneCell = self:getView():getChildByName("cloneCell")
	self._dayTabCell = self:getView():getChildByName("dayTabCell")
end

function ReturnActivityTaskReachedMediator:initData(data)
	if data then
		self._activity = data.activity
		self._parentMediator = data.parentMediator
		self._activityConfig = self._activity:getActivityConfig()
		self._choiceActivityId = self._activityConfig.Choice
		self._curDayType = self._activity:getOpenDay()
	end

	self._baseActivity = self._activitySystem:getActivityByComplexUI(ActivityType.KReturn)
	self._choiceActivity = self._baseActivity:getSubActivityById(self._choiceActivityId)
	self._choiceId = self._choiceActivity:getSelectId()
end

function ReturnActivityTaskReachedMediator:checkHeroChoose()
	if not self._choiceId or self._choiceId == "" then
		local view = self:getInjector():getInstance("ReturnHeroChangeView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			activity = self._choiceActivity
		}))
	end
end

function ReturnActivityTaskReachedMediator:setupView()
	self._listView:removeAllChildren()
	self._dayList:removeAllChildren()

	local tabBtns = {}

	for k, v in ipairs(self._activityConfig.CarnivalTask) do
		local btn = self._dayTabCell:clone()

		btn:setTag(k)

		local name1 = btn:getChildByName("light_2")
		local name2 = btn:getChildByName("dark_2")

		name1:setString(Strings:get(v.GroupName))
		name2:setString(Strings:get(v.GroupName))
		btn:setVisible(true)

		tabBtns[#tabBtns + 1] = btn

		local redPoint = RedPoint:createDefaultNode()

		redPoint:setName("redPoint")
		redPoint:setScale(0.8)
		redPoint:addTo(btn):posite(130, 40)
		redPoint:setLocalZOrder(99900)
		redPoint:setVisible(self._activity:hasRedPointDay(k))
		self._dayList:pushBackCustomItem(btn)
	end

	self._tabBtns = tabBtns
	self._tabCDayontroller = TabController:new(tabBtns, function(name, tag, data)
		return self:onClickDayTab(name, tag, data)
	end, {
		clickState = TabClickAnswerState.kEnd
	})

	self._tabCDayontroller:selectTabByTag(self._curDayType)
	self:seletcTaskDay(self._curDayType)

	if self._curDayType >= 5 then
		self._dayList:jumpToRight()
	end
end

function ReturnActivityTaskReachedMediator:onClickDayTab(name, eventType, data)
	if self._curDayType == eventType then
		return false
	end

	if tonumber(eventType) > self._activity:getOpenDay() then
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = Strings:get("Activity_Return_Hero_Choose7")
		}))

		return false
	end

	self._curDayType = eventType

	AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)
	self:seletcTaskDay(eventType)

	return true
end

function ReturnActivityTaskReachedMediator:seletcTaskDay(day)
	local size = self._cloneCell:getContentSize()
	local taslList = self._activity:getSortDayTasks(day)

	self._listView:removeAllChildren()

	for i = 1, #taslList do
		local cloneCell = self._cloneCell:clone()

		cloneCell:setVisible(true)
		self:updataCell(cloneCell, taslList[i])
		self._listView:pushBackCustomItem(cloneCell)
	end
end

function ReturnActivityTaskReachedMediator:updataCell(mainView, data)
	local desc = data._config.Desc
	local conditionText = mainView:getChildByName("content")

	conditionText:setString(Strings:get(desc))

	local name = data._config.Name
	local nameText = mainView:getChildByName("title")

	nameText:setString(Strings:get(name))

	local taskValueList = data:getTaskValueList()

	mainView:getChildByName("cur"):setString(taskValueList[1].currentValue)
	mainView:getChildByName("target"):setString("/" .. taskValueList[1].targetValue)

	local rewardPanel = mainView:getChildByName("reward")

	rewardPanel:removeAllChildren()

	local rewards = data:getReward()

	if rewards and rewards.Content then
		for i, rewardData in pairs(rewards.Content) do
			local icon = IconFactory:createRewardIcon(rewardData, {
				isWidget = true
			})

			icon:setAnchorPoint(cc.p(0, 0))
			icon:setScaleNotCascade(0.5)
			icon:addTo(rewardPanel):posite(-4.5 + (i - 1) * 66, 0)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), rewardData, {
				needDelay = true
			})
		end
	end

	local status = data:getStatus()
	local actBtn = mainView:getChildByName("actBtn")

	actBtn:setVisible(true)

	local recieveImg = mainView:getChildByName("recieve")

	recieveImg:setVisible(false)

	if status == ActivityTaskStatus.kUnfinish then
		local text = actBtn:getChildByName("Text_str")

		text:setString(Strings:get("SOURCE_DESC2"))
		actBtn:loadTexture("hd_btn_qw.png", ccui.TextureResType.plistType)

		if data:getDestUrl() ~= nil and data:getDestUrl() ~= "" then
			local function callFuncGo(sender, eventType)
				local beganPos = sender:getTouchBeganPosition()
				local endPos = sender:getTouchEndPosition()

				if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
					self:onClickGo(data)
				end
			end

			mapButtonHandlerClick(nil, actBtn, {
				func = callFuncGo
			})
		else
			actBtn:setVisible(false)
		end
	elseif status == ActivityTaskStatus.kFinishNotGet then
		local text = actBtn:getChildByName("Text_str")

		text:setString(Strings:get("Task_UI11"))

		local function callFuncGo(sender, eventType)
			local beganPos = sender:getTouchBeganPosition()
			local endPos = sender:getTouchEndPosition()

			if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
				self:onClickGet(data)
			end
		end

		actBtn:loadTexture("hd_btn_lq.png", ccui.TextureResType.plistType)
		mapButtonHandlerClick(nil, actBtn, {
			func = callFuncGo
		})
	else
		local children = rewardPanel:getChildren()

		for i = 1, #children do
			local node = children[i]

			node:setColor(cc.c3b(120, 120, 120))

			local img = ccui.ImageView:create("hd_14r_btn_go.png", 1)

			img:setScale(0.5)
			img:addTo(rewardPanel)
			img:setPosition(cc.p(-42 + i * 66, 28))
		end

		actBtn:setVisible(false)
		recieveImg:setVisible(true)
	end
end

function ReturnActivityTaskReachedMediator:onClickGo(data)
	local url = data:getDestUrl()
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end

function ReturnActivityTaskReachedMediator:onClickGet(data)
	local status = data:getStatus()

	if status == ActivityTaskStatus.kUnfinish then
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("Task_Text1")
		}))

		return
	end

	local data = {
		doActivityType = 101,
		taskId = data:getId(),
		day = self._curDayType
	}
	local baseActivity = self._activitySystem:getActivityByComplexUI(ActivityType.KReturn)

	self._activitySystem:requestDoChildActivity(baseActivity:getId(), self._activity:getId(), data, function(response)
		if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
			return
		end

		local rewards = response.data.rewards

		if rewards then
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = rewards
			}))
		end
	end)
end

function ReturnActivityTaskReachedMediator:onClickGet2(data, index)
	local status = data:getStatus()

	if status == ActivityTaskStatus.kUnfinish then
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("Task_Text1")
		}))

		return
	end

	local data = {
		doActivityType = 101,
		taskId = self._choiceId
	}

	self._activitySystem:requestDoChildActivity(self._baseActivity:getId(), self._choiceActivity:getId(), data, function(response)
		local rewards = response.data.reward

		if rewards then
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = rewards
			}))
		end
	end)
end

function ReturnActivityTaskReachedMediator:refreshHeroShow()
	if not self._choiceId or self._choiceId == "" then
		self._taskInfo:setVisible(false)
		self._taskBtn:setVisible(false)
	else
		local choiceList = self._choiceActivity:getTaskList()
		local activity

		for i = 1, #choiceList do
			if choiceList[i]:getId() == self._choiceId then
				activity = choiceList[i]
			end
		end

		if activity then
			self._taskInfo:setVisible(true)
			self._taskBtn:setVisible(true)

			local showHero = ConfigReader:getDataByNameIdAndKey("Activity", self._choiceId, "ActivityConfig").showHero
			local name = DataReader:getDataByNameIdAndKey("RoleModel", showHero.modelId, "Name")

			self._taskInfo:getChildByName("taskDesc"):setString(Strings:get(activity:getDesc(), {
				Hero = Strings:get(name)
			}))

			local taskValueList = activity:getTaskValueList()
			local leaveTimes = activity:getTaskUnFinishNum()
			local totalTimes = activity:getTaskTotalhNum()

			self._taskInfo:getChildByName("totalNum"):setString("/" .. totalTimes .. ")")
			self._taskInfo:getChildByName("curNum"):setString(tostring(totalTimes - leaveTimes))

			local status = activity:getStatus()

			if status == ActivityTaskStatus.kUnfinish then
				local text = self._taskBtn:getChildByName("Text_str")

				text:setString(Strings:get("Task_UI11"))
				self._taskBtn:loadTexture("hd_btn_lq.png", ccui.TextureResType.plistType)
				self._taskBtn:setGray(true)
			elseif status == ActivityTaskStatus.kFinishNotGet then
				local text = self._taskBtn:getChildByName("Text_str")

				text:setString(Strings:get("Task_UI11"))
				self._taskBtn:addTouchEventListener(function(sender, eventType)
					if eventType == ccui.TouchEventType.ended then
						self:onClickGet2(activity)
					end
				end)
				self._taskBtn:setGray(false)
				self._taskBtn:loadTexture("hd_btn_lq.png", ccui.TextureResType.plistType)
			else
				local text = self._taskBtn:getChildByName("Text_str")

				text:setString(Strings:get("Activity_Received"))
				self._taskBtn:loadTexture("hd_btn_lq.png", ccui.TextureResType.plistType)
				self._taskBtn:setGray(true)
				self._taskBtn:addTouchEventListener(function(sender, eventType)
					if eventType == ccui.TouchEventType.ended then
						-- block empty
					end
				end)
				self._taskInfo:getChildByName("curNum"):setTextColor(cc.c3b(255, 255, 255))
			end

			local showHero = ConfigReader:getDataByNameIdAndKey("Activity", self._choiceId, "ActivityConfig").showHero
			local heroPanel = self._main:getChildByName("heroPanel")

			if showHero and showHero.modelId then
				heroPanel:removeAllChildren()

				local heroSprite = IconFactory:createRoleIconSpriteNew({
					frameId = "bustframe9",
					id = showHero.modelId,
					useAnim = showHero.anim == "1" and true or false
				})

				heroSprite:setScale(showHero.scale or 0.85)
				heroSprite:setPosition(cc.p(showHero.pos.x or 355, showHero.pos.y or 140))
				heroSprite:addTo(heroPanel)
			end
		end
	end
end

function ReturnActivityTaskReachedMediator:refreshRedPoint()
	local items = self._dayList:getItems()

	for i = 1, #items do
		items[i]:getChildByName("redPoint"):setVisible(self._activity:hasRedPointDay(i))
	end
end

function ReturnActivityTaskReachedMediator:refreshHeroShowByEvent()
	dump("refreshHeroShowByEvent >>>>>>>")

	if self._activitySystem:isReturnActivityShow() then
		self:initData()
		self:refreshHeroShow()
		self:refreshRedPoint()
		self:seletcTaskDay(self._curDayType)
	end
end
