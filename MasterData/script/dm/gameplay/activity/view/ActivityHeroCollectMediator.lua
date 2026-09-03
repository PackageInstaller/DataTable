-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityHeroCollectMediator.lua

ActivityHeroCollectMediator = class("ActivityHeroCollectMediator", BaseActivityMediator, _M)

ActivityHeroCollectMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

EVT_RECRUIT_SUCC = "EVT_RECRUIT_SUCC"

local kBtnHandlers = {
	["main.infoBtn"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onActivityInfoClicked"
	},
	["main.gotoBtn"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onActivityGotoBtnClicked"
	},
	["main.leftBtn"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onActivityLeftBtnClicked"
	},
	["main.rightBtn"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onActivityRightBtnClicked"
	}
}
local kTaskTitleList = {
	"ACT_XDML_Text3",
	"ACT_XDML_Text4",
	"ACT_XDML_Text5"
}
local kTaskRewardState = {
	FINISH = 2,
	REWARD = 1,
	UNFINISH = 0
}
local infoPosx = {
	sr = {
		666,
		727,
		785,
		842
	},
	ssr = {
		687,
		757,
		821,
		842
	}
}

function ActivityHeroCollectMediator:initialize()
	super.initialize(self)
end

function ActivityHeroCollectMediator:dispose()
	super.dispose(self)

	if self._timeSchedule then
		LuaScheduler:getInstance():unschedule(self._timeSchedule)

		self._timeSchedule = nil
	end
end

function ActivityHeroCollectMediator:onRemove()
	super.onRemove(self)
end

function ActivityHeroCollectMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RECRUIT_SUCC, self, self.onRecruitSucc)

	local btn = self:getView():getChildByFullName("main.rewardBtn")

	self:bindWidget(btn, ThreeLevelViceButton, {
		handler = {
			func = bind1(self.onActivityRewardBtnClicked, self)
		}
	})

	local btn = self:getView():getChildByFullName("main.rewardFinishBtn")

	self:bindWidget(btn, ThreeLevelViceButton, {})
end

function ActivityHeroCollectMediator:enterWithData(data)
	self._activity = data.activity
	self._taskList = self._activity:getTaskList()
	self._activityConfig = self._activity:getConfig()
	self._currentTaskIndex = self:getDefaultIndex()

	self:initWidget()
	self:setupTimer()
	self:setupView()
end

function ActivityHeroCollectMediator:initWidget()
	self._goText = self:getView():getChildByFullName("main.gotoBtn.gotoText")
	self._recrText = self:getView():getChildByFullName("main.gotoBtn.recrText")

	local lineGradiantVec = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 218, 68, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 250, 227, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	self._goText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec, lineGradiantDir))
	self._recrText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec, lineGradiantDir))

	self._heroNumText = self:getView():getChildByFullName("main.infoLine1_0")

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 251, 228, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 199, 86, 255)
		}
	}
	local lineGradiantDir2 = {
		x = 0,
		y = -1
	}

	self._heroNumText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir2))

	self._taskTitle = self:getView():getChildByFullName("main.title")
	self._timeText = self:getView():getChildByFullName("main.TimeText")
	self._leftBtn = self:getView():getChildByFullName("main.leftBtn")
	self._rightBtn = self:getView():getChildByFullName("main.rightBtn")
	self._rewardNode = self:getView():getChildByFullName("main.rewardNode")
	self._progressNode = self:getView():getChildByFullName("main.progressNode")
	self._progressBar = self:getView():getChildByFullName("main.progressNode.progress")
	self._progressText = self:getView():getChildByFullName("main.progressNode.text")
	self._heroType = self:getView():getChildByFullName("main.common_img_sr")
	self._info1 = self:getView():getChildByFullName("main.infoLine1")
	self._info2 = self:getView():getChildByFullName("main.infoLine1_1")
	self._timeEndText = self:getView():getChildByFullName("main.endText")

	local lineGradiantVec3 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(129, 118, 113, 255)
		}
	}
	local lineGradiantDir3 = {
		x = 0,
		y = -1
	}

	self._progressText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec3, lineGradiantDir3))

	self._btnText1 = self:getView():getChildByFullName("main.gotoBtn.gotoText")
	self._btnText2 = self:getView():getChildByFullName("main.gotoBtn.recrText")
	self._rewardBtn = self:getView():getChildByFullName("main.rewardBtn")
	self._rewardedBtn = self:getView():getChildByFullName("main.rewardFinishBtn")
end

function ActivityHeroCollectMediator:setupTimer()
	local endTime = self._activity:getActivityEndTime()
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local currentTime = gameServerAgent:remoteTimestamp()

	if endTime > currentTime * 1000 then
		self._timeEndText:setVisible(true)

		local function checkTimeFunc()
			currentTime = gameServerAgent:remoteTimestamp()

			local endMills = endTime / 1000
			local remainTime = endMills - currentTime

			if math.floor(remainTime) <= 0 then
				if self._timeSchedule then
					LuaScheduler:getInstance():unschedule(self._timeSchedule)
					self._timeEndText:setVisible(false)
					self._timeText:setString(Strings:get("ACT_XDML_Text2"))

					self._timeSchedule = nil
				end

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

			self._timeText:setString(timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec"))
		end

		checkTimeFunc()

		self._timeSchedule = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	else
		self._timeEndText:setVisible(false)
		self._timeText:setString(Strings:get("ACT_XDML_Text2"))
	end
end

function ActivityHeroCollectMediator:setupView()
	local listData = self._taskList[self._currentTaskIndex]

	self._leftBtn:setVisible(self._currentTaskIndex ~= 1)
	self._rightBtn:setVisible(#self._taskList ~= self._currentTaskIndex)
	self._taskTitle:setString(Strings:get(kTaskTitleList[self._currentTaskIndex]))

	local condition = ConfigReader:getDataByNameIdAndKey("ActivityTask", listData.taskId, "Condition")
	local rarity = condition[1].factor1[1]

	self._info2:setVisible(rarity < 14)

	if rarity < 14 then
		if not infoPosx.sr then
			local posXList = infoPosx.ssr

			self._info1:setPositionX(posXList[1])
			self._heroNumText:setPositionX(posXList[2])
			self._heroType:setPositionX(posXList[3])
			self._info2:setPositionX(posXList[4])

			local imageFile = GameStyle:getHeroRarityImage(rarity)

			self._heroType:loadTexture(imageFile, 1)

			local targerNum = self._activity:getTaskTargerNum(listData.taskId)
			local currentNum = self._activity:getTaskProgressNum(listData.taskId)

			self._heroNumText:setString(Strings:get("ACT_XDML_Text7", {
				num = targerNum
			}))
			self._rewardNode:removeAllChildren()

			local layout = ccui.Layout:create()

			layout:setContentSize(cc.size(115, 115))

			local reward = self._activity:getReward(listData.taskId)
			local icon = IconFactory:createRewardIcon(reward, {
				showAmount = true,
				isWidget = true
			})

			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
				needDelay = true
			})
			icon:addTo(layout)
			self._rewardNode:addChild(layout)
			self._progressBar:setContentSize(cc.size(160 * (currentNum / targerNum), 32))
			self._progressText:setString(tostring(currentNum) .. "/" .. tostring(targerNum))

			local rewardState = self._activity:getRewardState(listData.taskId)

			if kTaskRewardState.UNFINISH == rewardState then
				self._rewardBtn:setVisible(false)
				self._progressNode:setVisible(true)
				self._rewardedBtn:setVisible(false)
			elseif kTaskRewardState.REWARD == rewardState then
				self._rewardBtn:setVisible(true)
				self._progressNode:setVisible(false)
				self._rewardedBtn:setVisible(false)
			elseif kTaskRewardState.FINISH == rewardState then
				self._rewardBtn:setVisible(false)
				self._rewardedBtn:setVisible(true)
				self._progressNode:setVisible(false)
			end
		end
	end
end

function ActivityHeroCollectMediator:onActivityInfoClicked()
	local Hero_EquipEnergyTranslate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ACT_XDML_RuleTranslate", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Hero_EquipEnergyTranslate
	}, nil)

	self:dispatch(event)
end

function ActivityHeroCollectMediator:onActivityGotoBtnClicked()
	local listData = self._taskList[self._currentTaskIndex]
	local url = self._activity:getTaskURL(listData.taskId)
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end

function ActivityHeroCollectMediator:onActivityRewardBtnClicked()
	local endTime = self._activity:getActivityEndTime()
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local currentTime = gameServerAgent:remoteTimestamp()

	if endTime <= currentTime * 1000 then
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = Strings:get("ACT_XDML_Text14")
		}))

		return
	end

	local listData = self._taskList[self._currentTaskIndex]
	local data = {
		doActivityType = 101,
		taskId = listData.taskId
	}

	self._activitySystem:requestDoActivity(self._activity:getId(), data, function(response)
		local rewards = response.data.reward

		if rewards then
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = rewards
			}))
		end

		self._taskList = self._activity:getTaskList()
		self._currentTaskIndex = self:getDefaultIndex()

		self:setupView()
	end)
end

function ActivityHeroCollectMediator:onActivityLeftBtnClicked()
	if self._currentTaskIndex == 1 then
		return
	end

	self._currentTaskIndex = self._currentTaskIndex - 1

	self:setupView()
end

function ActivityHeroCollectMediator:onActivityRightBtnClicked()
	if #self._taskList == self._currentTaskIndex then
		return
	end

	self._currentTaskIndex = self._currentTaskIndex + 1

	self:setupView()
end

function ActivityHeroCollectMediator:onRecruitSucc(event)
	self:setupView()
end

function ActivityHeroCollectMediator:getDefaultIndex()
	for i = 1, #self._taskList do
		local taskData = self._taskList[i]

		if taskData.taskStatus ~= kTaskRewardState.FINISH then
			return i
		end
	end

	return #self._taskList
end
