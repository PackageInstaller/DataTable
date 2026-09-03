-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/shuangdan/ActivityBlockHolidayMediator.lua

ActivityBlockHolidayMediator = class("ActivityBlockHolidayMediator", DmAreaViewMediator, _M)

ActivityBlockHolidayMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBlockHolidayMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityBlockHolidayMediator:has("_dreamChallengeSystem", {
	is = "r"
}):injectWith("DreamChallengeSystem")

local kBtnHandlers = {
	["main.ScrollView.panel.btn_sign"] = {
		ignoreClickAudio = true,
		func = "onClickSign"
	},
	["main.ScrollView.panel.btn_mjght"] = {
		ignoreClickAudio = true,
		func = "onClickSupport"
	},
	["main.ScrollView.panel.btn_draw"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickDraw"
	},
	["main.ScrollView.panel.btn_task"] = {
		ignoreClickAudio = true,
		func = "onClickTask"
	},
	["main.ScrollView.panel.btn_stage"] = {
		ignoreClickAudio = true,
		func = "onClickStage"
	},
	["main.ScrollView.panel.btn_shop"] = {
		ignoreClickAudio = true,
		func = "onClickShop"
	},
	["main.ScrollView.panel.btn_fudai"] = {
		ignoreClickAudio = true,
		func = "onClickFudai"
	},
	["main.ScrollView.panel.btn_dreamtower"] = {
		ignoreClickAudio = true,
		func = "onClickDreamTower"
	},
	["main.btn_rule"] = {
		ignoreClickAudio = true,
		func = "onClickRule"
	}
}

function ActivityBlockHolidayMediator:initialize()
	super.initialize(self)
end

function ActivityBlockHolidayMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityBlockHolidayMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._fudaiTimer then
		self._fudaiTimer:stop()

		self._fudaiTimer = nil
	end

	if self._dreamTimer then
		self._dreamTimer:stop()

		self._dreamTimer = nil
	end
end

function ActivityBlockHolidayMediator:onRegister()
	super.onRegister(self)
	self:setupTopInfoWidget()
end

function ActivityBlockHolidayMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
end

function ActivityBlockHolidayMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return
	end

	self:mapButtonHandlersClick(kBtnHandlers)
	self:updateInfoWidget()

	self._endtipStr = Strings:get(self._activity:getActivityConfig().SubActivityEndTip)

	self:mapEventListeners()
	self:setupView()
	self:refreshRedPoint()
end

function ActivityBlockHolidayMediator:resumeWithData(data)
	super.resumeWithData(self, data)
	self:doReset()
end

function ActivityBlockHolidayMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_REDPOINT_REFRESH, self, self.refreshRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.doReset)
end

function ActivityBlockHolidayMediator:doReset()
	self:stopTimer()

	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return true
	end

	self:initTimer()
	self:initFudaiTimer()
	self:initDreamChallengeTimer()
	self:refreshRedPoint()

	return false
end

function ActivityBlockHolidayMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ActivityBlockHolidayMediator:updateInfoWidget()
	if not self._topInfoWidget then
		return
	end

	local config = {
		hideLine = true,
		style = 1,
		currencyInfo = self._activity:getResourcesBanner()
	}

	self._topInfoWidget:updateView(config)
end

function ActivityBlockHolidayMediator:setupView()
	self._main = self:getView():getChildByName("main")
	self._scrollView = self._main:getChildByFullName("ScrollView")

	local winSize = cc.Director:getInstance():getWinSize()

	self._scrollView:setContentSize(cc.size(winSize.width, 852))
	self._scrollView:setInnerContainerSize(cc.size(2764, 852))
	AdjustUtils.adjustLayoutByType(self._scrollView, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._scrollView, AdjustUtils.kAdjustType.Left)
	AdjustUtils.adjustLayoutByType(self._main:getChildByName("Image_title"), AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Top)
	AdjustUtils.adjustLayoutByType(self._main:getChildByName("btn_rule"), AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Top)
	self._scrollView:setInnerContainerPosition(cc.p(-130, 0))

	local timeText = self._main:getChildByFullName("Image_title.Text_time")

	timeText:setString(self._activity:getTimeStr())
	self:initTimer()
	self:addAnim()
	self:addRole()
	self:initFudaiTimer()
	self:initDreamChallengeTimer()
end

function ActivityBlockHolidayMediator:instantiateBuildingHero(node)
	return self:getInjector():instantiate("ActivityHolidayHero", {
		view = node
	})
end

local posList = {
	cc.p(250, 100),
	cc.p(250, 30),
	cc.p(750, 100),
	cc.p(750, 30),
	cc.p(1250, 100),
	cc.p(1250, 30),
	cc.p(1750, 100),
	cc.p(1750, 30),
	cc.p(2200, 100),
	cc.p(2200, 30)
}

function ActivityBlockHolidayMediator:addRole()
	self._heroList = {}

	local panel = self._scrollView:getChildByFullName("panel")
	local roleList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Newyear_ModelWalkConfig", "content")
	local random = math.random(1, #roleList)

	local function hasHero(index)
		for i, hero in pairs(self._heroList) do
			local posIndex = hero:getPosIndex()

			if index == posIndex then
				return true
			end
		end
	end

	local function getCreatePosIndex()
		local list = {}

		for i, v in pairs(posList) do
			if not hasHero(i) then
				list[#list + 1] = v
			end
		end

		return (math.random(1, #list))
	end

	local function createRole(index, posIndex)
		local roleInfo = roleList[index]

		if roleInfo then
			local node = cc.Node:create():addTo(panel)
			local buildingHero = self:instantiateBuildingHero(node)

			node.__mediator = buildingHero

			buildingHero:setHeroInfo(roleInfo, self)

			self._heroList[roleInfo.hero] = buildingHero

			buildingHero:enterWithData(posIndex or getCreatePosIndex())
		end
	end

	local function getRoleIndex()
		local random = math.random(1, #roleList)
		local roleInfo = roleList[random]

		if table.nums(self._heroList) >= #roleList then
			return 0
		end

		if self._heroList[roleInfo.hero] == nil then
			return random
		else
			return getRoleIndex()
		end
	end

	local spwanSec = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Newyear_ModelSpwanSec", "content")

	local function action()
		local delay = cc.DelayTime:create(spwanSec)
		local call = cc.CallFunc:create(function()
			local roleIndex = getRoleIndex()

			if roleIndex > 0 then
				createRole(roleIndex)
				action()
			end
		end)

		self:getView():runAction(cc.Sequence:create(delay, call))
	end

	createRole(random, math.random(1, 4))
	action()
end

function ActivityBlockHolidayMediator:hasHeroStay(posIndex)
	for i, v in pairs(self._heroList) do
		if posIndex == v:getPosIndex() then
			return true
		end
	end

	return false
end

function ActivityBlockHolidayMediator:addAnim()
	local panel = self._scrollView:getChildByFullName("panel")
	local anim = cc.MovieClip:create("changjing_newyearscene")

	anim:addTo(panel):posite(1367, 320)
end

function ActivityBlockHolidayMediator:initDreamChallengeTimer()
	local dreamBtn = self._main:getChildByFullName("ScrollView.panel.btn_dreamtower")
	local remainLabel = dreamBtn:getChildByName("Text_time")

	remainLabel:setString("")

	local timeDi = dreamBtn:getChildByName("Image_2")

	timeDi:setVisible(false)

	local dreamChallengeId = self._activity:getActivityConfig().DreamChallenge

	if not dreamChallengeId then
		return
	end

	local config = ConfigReader:getRecordById("DreamChallengeMap", dreamChallengeId)

	local function checkTimeFunc()
		local isUnlock = self._dreamChallengeSystem:checkMapLock(dreamChallengeId)
		local curTime = self._activitySystem:getCurrentTime()

		if not isUnlock then
			local cond = config.UnlockCondition
			local endd = config.TimeFactor

			if cond and cond.Day then
				local time = TimeUtil:formatStrToRemoteTImestamp(cond.Day)
				local endTime = TimeUtil:formatStrToRemoteTImestamp(endd.value)

				if curTime < time then
					local str = ""
					local remainTime = math.max(time - curTime, 0)
					local fmtStr = "${d}:${HH}:${M}:${SS}"
					local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
					local parts = string.split(timeStr, ":", nil, true)
					local timeTab = {}

					timeTab.day = tonumber(parts[1])
					timeTab.hour = tonumber(parts[2])
					timeTab.min = tonumber(parts[3])
					timeTab.sec = tonumber(parts[4])
					str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.min > 0 and timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.sec .. Strings:get("TimeUtil_Sec")

					remainLabel:setString(Strings:get("Newyyear_DreamTower_UI02", {
						time = str
					}))
					remainLabel:setTextColor(cc.c3b(255, 226, 68))

					self._dreamEndtipStr = Strings:get("Newyyear_DreamTower_UI02", {
						time = str
					})

					timeDi:setVisible(true)
				elseif time <= curTime and curTime <= endTime then
					remainLabel:setString(Strings:get("Newyyear_DreamTower_UI03"))
					remainLabel:setTextColor(cc.c3b(37, 255, 52))

					if cond and cond.LEVEL then
						if self._developSystem:getPlayer():getLevel() < cond.LEVEL then
							self._dreamEndtipStr = Strings:get("Unlock_Level_Tips", {
								uLevel = cond.LEVEL
							})
						end
					end
				elseif endTime < curTime then
					remainLabel:setString(Strings:get("Newyyear_DreamTower_UI04"))
					remainLabel:setTextColor(cc.c3b(255, 58, 58))

					self._dreamEndtipStr = Strings:get("Newyyear_DreamTower_UI04")
				end
			end
		else
			local mapData = self._dreamChallengeSystem:getDreamChallenge():getMapData(dreamChallengeId)

			if mapData then
				local endCond = mapData:getMapEndCondition()

				if endCond.type == "Day" then
					timeDi:setVisible(true)

					local endTime = TimeUtil:formatStrToRemoteTImestamp(endCond.value)

					if curTime < endTime then
						remainLabel:setString(Strings:get("Newyyear_DreamTower_UI03"))
						remainLabel:setTextColor(cc.c3b(37, 255, 52))
					else
						remainLabel:setString(Strings:get("Newyyear_DreamTower_UI04"))
						remainLabel:setTextColor(cc.c3b(255, 58, 58))

						self._dreamEndtipStr = Strings:get("Newyyear_DreamTower_UI04")
					end
				end
			end
		end
	end

	self._dreamTimer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

	checkTimeFunc()
end

function ActivityBlockHolidayMediator:initTimer()
	local supportBtn = self._main:getChildByFullName("ScrollView.panel.btn_mjght")
	local supportActivityId = self._activity:getActivityConfig().ActivitySupport
	local supportActivity = self._activitySystem:getActivityByComplexId(supportActivityId)
	local remainLabel = supportBtn:getChildByName("Text_time")

	if supportActivity then
		local remoteTimestamp = self._activitySystem:getCurrentTime()
		local endTime = supportActivity:getLastPeriodEndTime() / 1000

		if remoteTimestamp < endTime then
			if self._timer then
				return
			end

			local status = supportActivity:getPeriodStatus()

			local function checkTimeFunc()
				remoteTimestamp = self._activitySystem:getCurrentTime()

				local remainTime = endTime - remoteTimestamp

				if remainTime <= 0 then
					if DisposableObject:isDisposed(self) then
						return
					end

					self._timer:stop()

					self._timer = nil

					remainLabel:setString(Strings:get("SingingCompetition_Entry_UI03"))
					remainLabel:setTextColor(cc.c3b(255, 58, 58))

					return
				end

				if status == ActivitySupportStatus.Preparing then
					local timeFactor = supportActivity:getConfig().TimeFactor
					local start = TimeUtil:parseDateTime({}, timeFactor.start[1])
					local startTs = TimeUtil:timeByRemoteDate(start)
					local periodId = supportActivity:getActivityConfig().ActivitySupportId[1]
					local periodCfg = ConfigReader:getRecordById("ActivitySupport", periodId)
					local periodStartTime = startTs + periodCfg.PrepareTime
					local str = ""
					local remainTime = math.max(periodStartTime - remoteTimestamp, 0)
					local fmtStr = "${d}:${HH}:${M}:${SS}"
					local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
					local parts = string.split(timeStr, ":", nil, true)
					local timeTab = {}

					timeTab.day = tonumber(parts[1])
					timeTab.hour = tonumber(parts[2])
					timeTab.min = tonumber(parts[3])
					timeTab.sec = tonumber(parts[4])
					str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.min > 0 and timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.sec .. Strings:get("TimeUtil_Sec")

					remainLabel:setString(Strings:get("SingingCompetition_Entry_UI01", {
						time = str
					}))
					remainLabel:setTextColor(cc.c3b(255, 226, 68))
				elseif status == ActivitySupportStatus.Starting then
					remainLabel:setString(Strings:get("SingingCompetition_Entry_UI02"))
					remainLabel:setTextColor(cc.c3b(37, 255, 52))
				elseif status == ActivitySupportStatus.Ended then
					remainLabel:setString(Strings:get("SingingCompetition_Entry_UI03"))
					remainLabel:setTextColor(cc.c3b(255, 58, 58))
				end
			end

			self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

			checkTimeFunc()
		else
			remainLabel:setString(Strings:get("SingingCompetition_Entry_UI03"))
			remainLabel:setTextColor(cc.c3b(255, 58, 58))
		end
	else
		remainLabel:setString(Strings:get("SingingCompetition_Entry_UI03"))
		remainLabel:setTextColor(cc.c3b(255, 58, 58))
	end
end

function ActivityBlockHolidayMediator:refreshRedPoint()
	local btns = {
		"btn_sign",
		"btn_mjght",
		"btn_draw",
		"btn_stage",
		"btn_task",
		"btn_shop",
		"btn_fudai",
		"btn_dreamtower"
	}
	local redFunc = {
		function()
			local activityId = self._activity:getActivityConfig().LoginActivity

			return self._activitySystem:hasRedPointForActivity(activityId)
		end,
		function()
			local activityId = self._activity:getActivityConfig().ActivitySupport

			return self._activitySystem:hasRedPointForActivity(activityId)
		end,
		function()
			return false
		end,
		function()
			local blockActivity = self._activity:getBlockMapActivity()

			if blockActivity then
				return blockActivity:hasRedPoint()
			end

			return false
		end,
		function()
			local taskActivities = self._activity:getTaskActivities()

			for i = 1, #taskActivities do
				if taskActivities[i]:hasRedPoint() then
					return true
				end
			end

			return false
		end,
		function()
			local monsterShopActivity = self._activity:getMonsterShopActivity()

			if monsterShopActivity then
				self._activitySystem:hasRedPointForActivity(monsterShopActivity:getId())
			end

			return false
		end,
		function()
			return false
		end,
		function()
			return self._dreamChallengeSystem:checkIsShowRedPoint()
		end
	}

	for i, name in pairs(btns) do
		local btn = self._main:getChildByFullName("ScrollView.panel." .. name)
		local redPoint = btn:getChildByName("redPoint")

		redPoint:setVisible(redFunc[i]())
	end
end

function ActivityBlockHolidayMediator:initFudaiTimer()
	local str = ""
	local fudaiBtn = self._main:getChildByFullName("ScrollView.panel.btn_fudai")
	local remainLabel = fudaiBtn:getChildByName("Text_time")
	local activityFudai = self._activity:getActivityTpurchase()

	if not activityFudai then
		remainLabel:setString(str)

		return
	end

	local purchaseId = activityFudai:getTimePurchaseId()
	local config = ShopPackage:new(purchaseId)
	local remoteTimestamp = self._activitySystem:getCurrentTime()
	local startTime = config:getStartMills()
	local endTime = config:getEndMills()

	if remoteTimestamp < startTime then
		local function checkTimeFunc()
			remoteTimestamp = self._activitySystem:getCurrentTime()

			local remainTime = startTime - remoteTimestamp

			if remainTime <= 0 then
				self._fudaiTimer:stop()

				self._fudaiTimer = nil

				remainLabel:setString(Strings:get("NewYear_LuckyBag_Entry_UI02"))
				remainLabel:setTextColor(cc.c3b(37, 255, 52))

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
			str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.min > 0 and timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.sec .. Strings:get("TimeUtil_Sec")
			str = Strings:get("NewYear_LuckyBag_Entry_UI01", {
				time = str
			})

			remainLabel:setTextColor(cc.c3b(255, 226, 68))
			remainLabel:setString(str)
		end

		self._fudaiTimer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	elseif endTime < remoteTimestamp then
		remainLabel:setTextColor(cc.c3b(255, 58, 58))

		str = Strings:get("NewYear_LuckyBag_Entry_UI03")
	else
		str = Strings:get("NewYear_LuckyBag_Entry_UI02")

		remainLabel:setTextColor(cc.c3b(37, 255, 52))
	end

	remainLabel:setString(str)
end

function ActivityBlockHolidayMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dismiss()
	end
end

function ActivityBlockHolidayMediator:onClickStage()
	self._blockActivity = self._activity:getBlockMapActivity()

	if not self._blockActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endtipStr
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Story_Dream", false)
	self._activitySystem:enterBlockMap(self._activityId)
end

function ActivityBlockHolidayMediator:onClickTask()
	self._taskActivities = self._activity:getTaskActivities()

	if #self._taskActivities == 0 then
		self:dispatch(ShowTipEvent({
			tip = self._endtipStr
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterSupportTaskView(self._activityId)
end

function ActivityBlockHolidayMediator:onClickDraw()
	local drawCardList = self._activity:getActivityConfig().DrawCard
	local drawId

	for i, id in pairs(drawCardList) do
		local activity = self._activitySystem:getActivityByComplexId(id)

		if activity then
			drawId = activity:getActivityConfig().DRAW

			break
		end
	end

	if not drawId then
		self:dispatch(ShowTipEvent({
			tip = self._endtipStr
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local recruitSystem = self:getInjector():getInstance(RecruitSystem)
	local data = {
		recruitId = drawId
	}

	recruitSystem:tryEnter(data)
end

function ActivityBlockHolidayMediator:onClickSign()
	local loginId = self._activity:getActivityConfig().LoginActivity
	local model = self._activitySystem:getActivityByComplexId(loginId)

	if not model then
		self:dispatch(ShowTipEvent({
			tip = self._endtipStr
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = self._activity:getActivityConfig().LoginActivityLink,
		extParams = {}
	}))
end

function ActivityBlockHolidayMediator:onClickSupport()
	local supportActivityId = self._activity:getActivityConfig().ActivitySupport
	local supportActivity = self._activitySystem:getActivityByComplexId(supportActivityId)

	if not supportActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endtipStr
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local winId = supportActivity:getWinHeroId()
	local data = supportActivity:getHeroDataById(winId)

	if data then
		local params = {
			doActivityType = 101
		}

		self._activitySystem:requestDoActivity(supportActivityId, params, function(response)
			self._activitySystem:getActivityByComplexId(supportActivityId):synchronizePeriodsInfo(response.data)
			self._activitySystem:enterSagaWinView(supportActivityId)
		end)
	else
		self._activitySystem:enterSagaSupportStage(supportActivityId)
	end
end

function ActivityBlockHolidayMediator:onClickShop()
	self._monsterShopActivity = self._activity:getMonsterShopActivity()

	if not self._monsterShopActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endtipStr
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterBlockMonsterShopView(self._activityId)
end

function ActivityBlockHolidayMediator:onClickFudai()
	self._tpurchaseActivity = self._activity:getActivityTpurchase()

	if not self._tpurchaseActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endtipStr
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterBlockFudaiView(self._activityId)
end

function ActivityBlockHolidayMediator:onClickDreamTower()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local dreamChallengeId = self._activity:getActivityConfig().DreamChallenge

	if not dreamChallengeId then
		return
	end

	local isUnlock = self._dreamChallengeSystem:checkMapShow(dreamChallengeId)

	if isUnlock then
		local data = {
			mapId = dreamChallengeId
		}

		self._dreamChallengeSystem:tryEnter(data)
	else
		self:dispatch(ShowTipEvent({
			tip = self._dreamEndtipStr
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
	end
end

function ActivityBlockHolidayMediator:onClickRule()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local rules = self._activity:getActivityConfig().RuleDesc
	local supportActivityId = self._activity:getActivityConfig().ActivitySupport
	local supportActivity = self._activitySystem:getActivityByComplexId(supportActivityId)
	local param

	if supportActivity then
		local timeFactor = supportActivity:getConfig().TimeFactor
		local start = TimeUtil:parseDateTime({}, timeFactor.start[1])
		local startTs = TimeUtil:timeByRemoteDate(start)
		local periodId = supportActivity:getActivityConfig().ActivitySupportId[1]
		local periodCfg = ConfigReader:getRecordById("ActivitySupport", periodId)
		local startTime = startTs + periodCfg.PrepareTime
		local endTime = startTs + periodCfg.PrepareTime + periodCfg.Time

		param = {
			startTime = TimeUtil:localDate("%Y.%m.%d %H:%M", startTime),
			endTime = TimeUtil:localDate("%Y.%m.%d %H:%M", endTime)
		}
	end

	self._activitySystem:showActivityRules(rules, nil, param)
end
