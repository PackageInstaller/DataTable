-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityDailyChargeMediator.lua

ActivityDailyChargeMediator = class("ActivityDailyChargeMediator", BaseActivityMediator, _M)

ActivityDailyChargeMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local baseTime = {
	sec = 0,
	min = 0,
	hour = 5
}
local kBtnHandlers = {
	["main.Panel_reward.getBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickGetTodayReward"
	},
	["main.Panel_reward.goBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickGoBtn"
	}
}

function ActivityDailyChargeMediator:initialize()
	super.initialize(self)
end

function ActivityDailyChargeMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function ActivityDailyChargeMediator:onRemove()
	super.onRemove(self)
end

function ActivityDailyChargeMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.updateView)

	self._main = self:getView():getChildByName("main")
	self._refreshPanel = self._main:getChildByName("refreshPanel")
	self._heroPanel = self._main:getChildByName("heroPanel")
	self._bottomPanel = self._main:getChildByName("Panel_bottom")
	self._todayRewardPanel = self._main:getChildByName("Panel_reward")
	self._timePanel = self._main:getChildByName("refreshPanel")
	self._boxClone = self._bottomPanel:getChildByName("Panel_box")

	self._boxClone:setVisible(false)
end

function ActivityDailyChargeMediator:enterWithData(data)
	self._activity = data.activity
	self._activityId = self._activity:getId()
	self._parentMediator = data.parentMediator
	self._todayTask = self._activity:getTodayTask()
	self._rewardBoxList = {}

	self:setupView()
end

function ActivityDailyChargeMediator:setupView()
	local modelId = ConfigReader:getDataByNameIdAndKey("HeroBase", self._activity:getShowHeroId(), "RoleModel")
	local heroSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = modelId
	})

	heroSprite:setScale(0.85)
	heroSprite:addTo(self._heroPanel):posite(630, 150)
	self:updateTime()
	self:updateView()
end

function ActivityDailyChargeMediator:updateView()
	self:refreshTodayReward()
	self:refreshRewardProgress()
	self:refreshFreeReward()
end

function ActivityDailyChargeMediator:updateTime()
	self._refreshPanel:setVisible(true)

	local timeText = self._refreshPanel:getChildByName("times")
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = self._activity:getEndTime() / 1000

	if remoteTimestamp < endMills and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()

			local endMills = self._activity:getEndTime() / 1000
			local remainTime = endMills - remoteTimestamp

			if math.floor(remainTime) <= 0 then
				return
			end

			local fmtStr = "${d}:${H}:${M}:${S}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])

			timeText:setString((timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")) .. Strings:get("Activity_Collect_Finish"))
			self._refreshPanel:setVisible(true)
		end

		checkTimeFunc()

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	end
end

function ActivityDailyChargeMediator:refreshFreeReward()
	local lastGetFreeGiftTime = self._activity:getLastGetFreeGiftTime()
	local nowTime = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
	local freeBtn = self._main:getChildByName("btn_free")

	if not freeBtn.anim then
		freeBtn.anim = cc.MovieClip:create("003_huangshibaozhangeff")

		if freeBtn.anim then
			freeBtn.anim:addTo(freeBtn, -1):center(freeBtn:getContentSize())
		end
	end

	local function callFunc(sender, eventType)
		self:onClickFreeReward(sender, eventType)
	end

	mapButtonHandlerClick(self, freeBtn, {
		func = callFunc
	})

	if TimeUtil:isSameDay(lastGetFreeGiftTime / 1000, nowTime, baseTime) then
		freeBtn:setVisible(false)
	else
		freeBtn:setVisible(true)
	end

	if not freeBtn.redPoint then
		freeBtn.redPoint = RedPoint:createDefaultNode()

		freeBtn.redPoint:setScale(0.8)
		freeBtn.redPoint:addTo(freeBtn):posite(80, 80)
	end

	freeBtn.redPoint:setVisible(not TimeUtil:isSameDay(lastGetFreeGiftTime / 1000, nowTime, baseTime))
end

function ActivityDailyChargeMediator:addTodayReward(rewards, taskConfig)
	local rewardListView = self._todayRewardPanel:getChildByName("ListView")

	rewardListView:removeAllChildren()

	local startPosX = {
		177,
		112,
		50
	}

	if rewards then
		local count = #rewards

		if startPosX[count] then
			if not startPosX[count] then
				local posX = 40

				for i = 1, count do
					local reward = rewards[i]

					if reward then
						local rewardIcon = IconFactory:createRewardIcon(reward, {
							isWidget = true
						})

						IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self._parentMediator), reward, {
							needDelay = true
						})
						rewardIcon:setScale(0.8)
						rewardListView:pushBackCustomItem(rewardIcon)
					end
				end

				if count <= 3 then
					rewardListView:setPositionX(posX)
				end
			end
		end
	end

	local descText = self._todayRewardPanel:getChildByName("Text_desc")
	local tipsStr
	local status = self._todayTask:getStatus()
	local curTaskIndex = self._activity:getCurTaskIndex()
	local taskList = self._activity:getTaskList()

	descText:setString(status == ActivityTaskStatus.kGet and (curTaskIndex == #taskList - 1 and Strings:get("DailyCharge_MainTex03") or Strings:get("DailyCharge_MainTex02")) or status == ActivityTaskStatus.kFinishNotGet and Strings:get("DailyCharge_MainTex01") or Strings:get(taskConfig.Name))
end

function ActivityDailyChargeMediator:refreshTodayReward()
	local status = self._todayTask:getStatus()
	local goBtn = self._todayRewardPanel:getChildByName("goBtn")
	local getBtn = self._todayRewardPanel:getChildByName("getBtn")

	getBtn:setVisible(status == ActivityTaskStatus.kFinishNotGet)

	if not getBtn.redPoint then
		getBtn.redPoint = RedPoint:createDefaultNode()

		getBtn.redPoint:setScale(0.8)
		getBtn.redPoint:addTo(getBtn):posite(132, 42)
	end

	local hasGetImg = self._todayRewardPanel:getChildByName("Image_get")

	hasGetImg:setVisible(false)

	local taskList = self._activity:getTaskList()
	local curTaskIndex = self._activity:getCurTaskIndex()
	local index
	local taskId = taskList[status == ActivityTaskStatus.kGet and (curTaskIndex == #taskList - 1 and curTaskIndex + 1 or curTaskIndex + 2) or curTaskIndex + 1]
	local taskConfig = ConfigReader:getRecordById("ActivityTask", taskId)
	local rewardId = taskConfig and taskConfig.Reward
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

	self:addTodayReward(rewards, taskConfig)
	goBtn:setVisible(false)

	if status == ActivityTaskStatus.kUnfinish then
		goBtn:setVisible(true)
		goBtn:getChildByName("Text_str"):setString(Strings:get("SOURCE_DESC2"))
	elseif status == ActivityTaskStatus.kGet and curTaskIndex < #taskList - 1 then
		goBtn:setVisible(true)
		goBtn:getChildByName("Text_str"):setString(Strings:get("DailyCharge_ButtonText"))
	end

	if curTaskIndex == #taskList - 1 then
		hasGetImg:setVisible(status == ActivityTaskStatus.kGet)
	end
end

function ActivityDailyChargeMediator:refreshRewardProgress()
	local curTaskIndex = self._activity:getCurTaskIndex()
	local status = self._todayTask:getStatus()
	local taskList = self._activity:getTaskList()
	local progressBar = self._bottomPanel:getChildByName("LoadingBar")
	local size = progressBar:getContentSize()
	local width = size.width / (#taskList - 1) - 5

	if #self._rewardBoxList < 1 then
		for i = 1, #taskList - 1 do
			local posX = 9 + (i - 1) * width
			local cell = self._boxClone:clone()

			cell:setVisible(true)
			cell:addTo(self._bottomPanel):posite(posX, 10)

			self._rewardBoxList[#self._rewardBoxList + 1] = cell

			local boxPanel = cell:getChildByName("Panel_box")
			local boxpath = "ico_dailycharge_box0" .. i .. ".png"
			local boxImg = ccui.ImageView:create(boxpath, 1)

			boxImg:addTo(boxPanel):center(boxPanel:getContentSize()):setName("boxImg")

			local descText = cell:getChildByName("Text_desc")

			descText:setString(Strings:get("DailyCharge_BoxText", {
				day = i
			}))
		end

		local taskId = taskList[#taskList]
		local taskConfig = ConfigReader:getRecordById("ActivityTask", taskId)
		local finalCell = self._bottomPanel:getChildByName("Panel_final")

		self._rewardBoxList[#self._rewardBoxList + 1] = finalCell

		local finalDescText = self._bottomPanel:getChildByName("Text_finaldesc")

		finalDescText:setString(Strings:get("DailyCharge_MainTexBottom", {
			day = #taskList
		}))

		local rewards = ConfigReader:getDataByNameIdAndKey("Reward", taskConfig.Reward, "Content")

		if rewards and rewards[1] then
			local boxPanel = finalCell:getChildByName("Panel_box")
			local rewardIcon = IconFactory:createRewardIcon(rewards[1], {
				isWidget = true
			})

			rewardIcon:setScale(0.9)
			rewardIcon:addTo(boxPanel):center(boxPanel:getContentSize())
		end
	end

	for i = 1, #self._rewardBoxList do
		local cell = self._rewardBoxList[i]
		local normalImg = cell:getChildByName("Image_normal")
		local cangetImg = cell:getChildByName("Image_canget")
		local doneImg = cell:getChildByName("Image_get")
		local boxImg = cell:getChildByName("Panel_box")

		if i < curTaskIndex + 1 then
			normalImg:setVisible(true)

			cell.status = ActivityTaskStatus.kGet

			doneImg:setVisible(true)
			cangetImg:setVisible(false)
		elseif i == curTaskIndex + 1 then
			normalImg:setVisible(status ~= ActivityTaskStatus.kFinishNotGet)
			cangetImg:setVisible(status == ActivityTaskStatus.kFinishNotGet)

			cell.status = status

			if cangetImg.anim then
				cangetImg.anim:setVisible(false)
			end

			if status == ActivityTaskStatus.kFinishNotGet then
				if not cangetImg.anim then
					if i == 7 then
						local anim = cc.MovieClip:create("002_huangshibaozhangeff")

						if anim then
							anim:addTo(boxImg):center(boxImg:getContentSize())

							cangetImg.anim = anim
						end
					else
						local anim = cc.MovieClip:create("001_huangshibaozhangeff")

						if anim then
							anim:addTo(cangetImg):center(cangetImg:getContentSize())

							cangetImg.anim = anim
						end
					end
				end

				cangetImg.anim:setVisible(true)
			end

			doneImg:setVisible(status == ActivityTaskStatus.kGet)
		else
			doneImg:setVisible(false)
			normalImg:setVisible(true)
			cangetImg:setVisible(false)

			cell.status = ActivityTaskStatus.kUnfinish
		end

		cell:setTouchEnabled(true)

		local function callFunc(sender, eventType)
			self:onClickBottomReward(sender, eventType, i, false)
		end

		mapButtonHandlerClick(self, cell, {
			func = callFunc
		})
	end

	if status == ActivityTaskStatus.kUnfinish then
		local curValue = curTaskIndex == 0 and 0 or curTaskIndex - 1

		progressBar:setPercent(curValue / (#self._rewardBoxList - 1) * 100)
	elseif curTaskIndex == #self._rewardBoxList - 1 then
		progressBar:setPercent(100)
	else
		progressBar:setPercent(curTaskIndex / (#self._rewardBoxList - 1) * 100)
	end
end

function ActivityDailyChargeMediator:onGetRewardCallback(response, onlyFreeReward)
	if onlyFreeReward then
		self:refreshFreeReward()
	else
		self:updateView()
	end

	local response = response.data.rewards
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		rewards = response
	}))
end

function ActivityDailyChargeMediator:requestGetTodayReward(isFinalReward)
	local activityId = self._activity:getId()
	local param = {
		doActivityType = 102
	}

	self._activitySystem:requestDoActivity(activityId, param, function(response)
		self:onGetRewardCallback(response, false)
	end)
end

function ActivityDailyChargeMediator:onClickGetTodayReward(sender, eventType)
	self:requestGetTodayReward(self._isFinalRewardShow)
end

function ActivityDailyChargeMediator:onClickGoBtn()
	local status = self._todayTask:getStatus()
	local taskList = self._activity:getTaskList()
	local curTaskIndex = self._activity:getCurTaskIndex()

	if status == ActivityTaskStatus.kUnfinish then
		local shopSystem = self:getInjector():getInstance(ShopSystem)

		shopSystem:tryEnter({
			shopId = ShopSpecialId.kShopTimeLimit
		})
	elseif status == ActivityTaskStatus.kGet then
		local taskList = self._activity:getTaskList()
		local index = curTaskIndex + 2
		local taskId = taskList[index]
		local taskConfig = ConfigReader:getRecordById("ActivityTask", taskId)
		local info = {
			hasGet = false,
			rewardId = taskConfig and taskConfig.Reward,
			desc = Strings:get("DailyCharge_PopUp_TextIUI", {
				day = index
			})
		}
		local view = self:getInjector():getInstance("ArenaBoxView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, info))
	end
end

function ActivityDailyChargeMediator:onClickRecharge(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local systemKeeper = self:getInjector():getInstance(SystemKeeper)
		local unlock, tips = systemKeeper:isUnlock("Charge_System")

		if unlock then
			local view = self:getInjector():getInstance("rechargeMainView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
			self:close()
		else
			self:dispatch(ShowTipEvent({
				tip = tips
			}))
		end
	end
end

function ActivityDailyChargeMediator:onClickFreeReward(sender, eventType)
	local lastGetFreeGiftTime = self._activity:getLastGetFreeGiftTime()
	local nowTime = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()

	if TimeUtil:isSameDay(lastGetFreeGiftTime / 1000, nowTime, baseTime) then
		local info = {
			hasGet = true,
			rewardId = self._activity:getDailyFreeReward(),
			tips = Strings:get("DailyCharge_UI8", {
				fontName = DEFAULT_TTF_FONT
			})
		}
		local view = self:getInjector():getInstance("ActivityBoxView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, info))
	else
		local activityId = self._activity:getId()
		local param = {
			doActivityType = 101
		}

		self._activitySystem:requestDoActivity(activityId, param, function(response)
			self:onGetRewardCallback(response, true)
		end)
	end
end

function ActivityDailyChargeMediator:onClickBottomReward(sender, eventType, index, isFinalReward)
	local curTaskIndex = self._activity:getCurTaskIndex()

	if sender.status == ActivityTaskStatus.kFinishNotGet and index == curTaskIndex + 1 then
		self:requestGetTodayReward(false)
	else
		local taskList = self._activity:getTaskList()
		local taskId = taskList[index]
		local taskConfig = ConfigReader:getRecordById("ActivityTask", taskId)
		local info = {
			rewardId = taskConfig and taskConfig.Reward,
			desc = Strings:get("DailyCharge_PopUp_TextIUI", {
				day = index
			}),
			hasGet = sender.status == ActivityTaskStatus.kGet and true or false
		}
		local view = self:getInjector():getInstance("ArenaBoxView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, info))
	end
end
