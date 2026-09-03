-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/controller/PassSystem.lua

require("dm.gameplay.activity.controller.ActivitySystem")

PassSystem = class("PassSystem", legs.Actor, _M)

PassSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PassSystem:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
PassSystem:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
PassSystem:has("_passListModel", {
	is = "r"
}):injectWith("PassListModel")
PassSystem:has("_levelRewards", {
	is = "r"
})
PassSystem:has("_currentLevel", {
	is = "r"
})
PassSystem:has("_currentLevelExp", {
	is = "r"
})
PassSystem:has("_currentLevelMaxExp", {
	is = "r"
})
PassSystem:has("_haveBuyLevelCount", {
	is = "r"
})
PassSystem:has("_maxRewardLevel", {
	is = "r"
})
PassSystem:has("_currentActivityID", {
	is = "r"
})
PassSystem:has("_currentActivity", {
	is = "r"
})
PassSystem:has("_shopActivityID", {
	is = "r"
})
PassSystem:has("_currentPassShopActivity", {
	is = "r"
})
PassSystem:has("_payConfig", {
	is = "r"
})
PassSystem:has("_goodShow", {
	is = "r"
})
PassSystem:has("_payRoad", {
	is = "r"
})
PassSystem:has("_freeRoad", {
	is = "r"
})
PassSystem:has("_hasRemarkableStatus", {
	is = "r"
})
PassSystem:has("_expWeekLimit", {
	is = "r"
})
PassSystem:has("_expWeek", {
	is = "r"
})
PassSystem:has("_todayOpen", {
	is = "r"
})
PassSystem:has("_subActivityID", {
	is = "r"
})
PassSystem:has("_dailyResetTime", {
	is = "rw"
})
PassSystem:has("_weekResetTime", {
	is = "rw"
})
PassSystem:has("_playBuyEndVoice", {
	is = "rw"
})
PassSystem:has("_playSoldOutVoice", {
	is = "rw"
})
PassSystem:has("_showViewTabIndex", {
	is = "rw"
})

function PassSystem:initialize()
	super.initialize(self)

	self._showAwardAfterBattle = {}
	self._levelRewards = {}
	self._currentLevel = 8
	self._oldLevel = 0
	self._haveBuyLevelCount = 3
	self._expWeek = 0
	self._expWeekLimit = 0
	self._currentActivityID = ""
	self._subActivityID = ""
	self._shopActivityID = ""
	self._currentLevelExp = 250
	self._currentLevelMaxExp = 1000
	self._hasOldRemarkableStatus = -1
	self._hasRemarkableStatus = 0
	self._dailyResetTime = 0
	self._weekResetTime = 0
	self._levelUpExpCost = 1000
	self._maxRewardLevel = 10
	self._payConfig = {}
	self._goodShow = {}
	self._payRoad = {}
	self._freeRoad = {}
	self._nomalrewards = {}
	self._remarkablerewards = {}
	self.initLocalTableData = false
	self._todayOpen = false
	self._dailyLevel = 0
	self._dailyExp = 0
	self._playBuyEndVoice = false
	self._playSoldOutVoice = false
end

function PassSystem:checkEnabled()
	local unlock, tips = self._systemKeeper:isUnlock("BattlePass")

	return unlock, tips
end

function PassSystem:checkPassActivityData()
	local activitySystem = self:getInjector():getInstance(ActivitySystem)
	local activityList = activitySystem:getAllActivityIds()

	for k, activityId in ipairs(activityList) do
		local activity = activitySystem:getActivityById(activityId)

		if activity:getUI() == ActivityType_UI.kActivityPassShop then
			self:initShopDataByActivityInfo(activity)
		end

		if activity:getUI() == ActivityType_UI.kActivityPass then
			self:initDataByActivityInfo(activity)
		end
	end
end

function PassSystem:initDataByActivityInfo(activity)
	if not activity then
		return
	end

	if self._currentActivity == nil then
		self._currentActivity = activity
		self._currentActivityID = activity:getId()
		self._currentPassTableId = self._currentActivity:getActivityConfig().ActivityBattlePass
		self._subActivityID = self._currentActivity:getActivityConfig().Activity[1]
	end

	local activityInfo = activity:getAllData()
	local passInfo = activityInfo.passInfo

	if passInfo then
		if passInfo.currentExp then
			self._currentLevelExp = passInfo.currentExp
		end

		if passInfo.passType then
			self._hasRemarkableStatus = passInfo.passType
		end

		if self._hasOldRemarkableStatus == -1 then
			self._hasOldRemarkableStatus = self._hasRemarkableStatus
		end

		if passInfo.level then
			self._currentLevel = passInfo.level
		end

		if self._oldLevel == 0 then
			self._oldLevel = self._currentLevel
		end

		if passInfo.dailyLevel then
			self._dailyLevel = passInfo.dailyLevel
		end

		if passInfo.dailyExp then
			self._dailyExp = passInfo.dailyExp
		end

		if passInfo.expWeek then
			self._expWeek = passInfo.expWeek
		end
	end

	local DailyTask = activityInfo.showDailyTasks
	local WeekTask = activityInfo.showWeekTasks
	local MonthTask = activityInfo.showOtherTasks

	self._passListModel:initPassTask(DailyTask, WeekTask, MonthTask)

	if DailyTask ~= nil or WeekTask ~= nil or MonthTask ~= nil then
		self:dispatch(Event:new(EVT_PASSPORT_TASK_REFRESH, {}))
	end

	if activityInfo.bugLevelTimes then
		self._haveBuyLevelCount = activityInfo.bugLevelTimes
	end

	if activityInfo.todayOpen then
		self._todayOpen = activityInfo.todayOpen
	end

	local changeLevelReward = false

	if self.initLocalTableData == false then
		self.initLocalTableData = true
		changeLevelReward = true
		self._expWeekLimit = ConfigReader:getRecordById("ActivityBattlePass", self._currentPassTableId).ExpLimit

		local levelIDs = ConfigReader:getRecordById("ActivityBattlePass", self._currentPassTableId).Level

		self._passListModel:initLevelReward(levelIDs, self._currentLevel, self._hasRemarkableStatus)

		self._maxRewardLevel = #levelIDs
		self._payConfig = ConfigReader:getRecordById("ActivityBattlePass", self._currentPassTableId).PayConfig
		self._goodShow = ConfigReader:getRecordById("ActivityBattlePass", self._currentPassTableId).GoodShow
		self._payRoad = ConfigReader:getRecordById("ActivityBattlePass", self._currentPassTableId).PayRoad
		self._freeRoad = ConfigReader:getRecordById("ActivityBattlePass", self._currentPassTableId).FreeRoad
	end

	local dailyLevelChange = false

	if passInfo and passInfo.dailyExp and passInfo.dailyExp > 0 then
		self:dispatch(Event:new(EVT_PASSPORT_DAILYEXP, {}))

		dailyLevelChange = true
	end

	if self._oldLevel ~= self._currentLevel and dailyLevelChange == false then
		self._passListModel:synchronizeLevelRewardStatusByCurrentLevel(self._oldLevel, self._currentLevel, self._hasRemarkableStatus)

		if dailyLevelChange == false then
			self:dispatch(Event:new(EVT_PASSPORT_LEVELUP, {
				type = 2,
				level1 = self._oldLevel,
				level2 = self._currentLevel
			}))
		end

		changeLevelReward = true
	end

	if self._hasOldRemarkableStatus ~= self._hasRemarkableStatus then
		self._passListModel:synchronizeLevelRewardStatusByCurrentLevel(0, self._currentLevel, self._hasRemarkableStatus)

		changeLevelReward = true
	end

	if self._hasOldRemarkableStatus == 0 and self._hasRemarkableStatus > 0 then
		self:dispatch(Event:new(EVT_PASSPORT_LEVELUP, {
			showType = 2,
			type = 1
		}))

		self._hasOldRemarkableStatus = self._hasRemarkableStatus
	end

	if activityInfo.passRewardStu then
		self._passListModel:synchronizeLevelRewardStatus(activityInfo.passRewardStu, 1)

		changeLevelReward = true
	end

	if activityInfo.passRewardMas then
		self._passListModel:synchronizeLevelRewardStatus(activityInfo.passRewardMas, 2)

		changeLevelReward = true
	end

	if changeLevelReward == true then
		self._passListModel:refreshLevelRewardVector()
	end

	if activityInfo.subActivities then
		local subActivitiesData = activityInfo.subActivities[self._subActivityID]

		if subActivitiesData then
			if subActivitiesData.activityId then
				self._subActivityID = subActivitiesData.activityId
			end

			if subActivitiesData.exchangeAmount then
				self._passListModel:synchronizePassExchangeList(subActivitiesData.exchangeAmount)
			end

			if subActivitiesData.timeStamp then
				self._subActivitytimeStamp = subActivitiesData.timeStamp
			end
		end
	end

	self._currentLevelMaxExp = self._passListModel:getLevelUpExpByRewardLevel(self._currentLevel)
	self._levelUpExpCost = self._currentLevelMaxExp
end

function PassSystem:initShopDataByActivityInfo(activity)
	if not activity then
		return
	end

	if self._currentPassShopActivity == nil then
		self._currentPassShopActivity = activity
		self._shopActivityID = activity:getId()
	end

	local activityInfo = activity:getAllData()

	if activityInfo then
		self._passListModel:synchronizePassShopList(activityInfo.exchangeAmount)

		self._subActivitytimeStamp = activityInfo.timeStamp
	end
end

function PassSystem:resetOldLevel()
	self._oldLevel = self._currentLevel
end

function PassSystem:tryEnter()
	AudioEngine:getInstance():playEffect("Se_Click_Cat", false)

	local unlock, tips = self:checkEnabled()

	if not unlock then
		self:dispatch(ShowTipEvent({
			tip = tips
		}))

		return
	end

	local showPassEnter, showPass, showPassShop = self:checkShowPassAndPassShop()

	if showPassEnter == false then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Unlock_Joking_Tips")
		}))

		return
	end

	local function callback()
		local activitySystem = self:getInjector():getInstance(ActivitySystem)

		if activitySystem then
			activitySystem:requestAllActicities(true, function()
				self:checkPassActivityData()

				local view = self:getInjector():getInstance("PassMainView")
				local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {})

				self:dispatch(event)
			end)
		end
	end

	callback()
end

function PassSystem:showMainPassView()
	self:tryEnter()
end

function PassSystem:showBuyView()
	local view = self:getInjector():getInstance("PassBuyView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}))
end

function PassSystem:showBuyLevelView()
	local view = self:getInjector():getInstance("PassBuyLevelView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}))
end

function PassSystem:showLevelUpView(data)
	self:resetOldLevel()

	local view = self:getInjector():getInstance("PassLevelUpView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
end

function PassSystem:showRewardsPreviewView()
	local view = self:getInjector():getInstance("PassRewardsPreviewView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}))
end

function PassSystem:getCrusadeWeekModel()
	return self._crusade:getCrusadeWeekModel()
end

function PassSystem:getCurrentTime()
	return self._gameServerAgent:remoteTimestamp()
end

function PassSystem:getRewardByLevel(level)
	return self._passListModel:getRewardByLevel(level)
end

function PassSystem:synLevelReward(level, rewardData)
	self._passListModel:synLevelReward(level, rewardData)
end

function PassSystem:isActivityTimeOut()
	return false
end

function PassSystem:checkIsHaveRewardCanGet()
	return self._passListModel:checkHaveRewardCanDoGain()
end

function PassSystem:checkIsHaveTaskRewardCanGet(passTaskType)
	return self._passListModel:checkHaveTaskRewardCanDoGain(passTaskType)
end

function PassSystem:getRewardsFromXLevelToYLevel(xLevel, yLevel)
	local rewards = self._passListModel:getRewardsFromXLevelToYLevel(xLevel, yLevel, self._hasRemarkableStatus)

	self:sortRewards(rewards)

	return rewards
end

function PassSystem:getAllNomalRewardsAndRemarkableReward()
	if self._nomalrewards == nil or #self._nomalrewards <= 0 then
		self._nomalrewards, self._remarkablerewards = self._passListModel:getAllNomalRewardsAndRemarkableReward()

		self:sortRewards(self._nomalrewards)
		self:sortRewards(self._remarkablerewards)
	end

	return self._nomalrewards, self._remarkablerewards
end

function PassSystem:isPassMaxLevel()
	return self._currentLevel >= self._maxRewardLevel
end

function PassSystem:getAllPriceByBuyCount(buyLevelCount)
	self._buyLevelCost = ConfigReader:getRecordById("ConfigValue", "BattlePass_BuyLevelCost").content

	if buyLevelCount < 1 then
		return 0
	end

	local allCost = 0
	local leftOffCount = #self._buyLevelCost - self._haveBuyLevelCount
	local toMaxLevelCount = self._maxRewardLevel - self._currentLevel

	if toMaxLevelCount <= buyLevelCount then
		local allCostWithoutMax = 0
		local fullLevelPrice = 0

		if leftOffCount <= 0 then
			fullLevelPrice = self._buyLevelCost[#self._buyLevelCost]
			allCostWithoutMax = (buyLevelCount - 1) * self._buyLevelCost[#self._buyLevelCost]
		elseif buyLevelCount <= leftOffCount then
			fullLevelPrice = self._buyLevelCost[self._haveBuyLevelCount + buyLevelCount]

			for i = self._haveBuyLevelCount + 1, self._haveBuyLevelCount + buyLevelCount - 1 do
				allCostWithoutMax = allCostWithoutMax + self._buyLevelCost[i]
			end
		else
			fullLevelPrice = self._buyLevelCost[#self._buyLevelCost]

			for i = self._haveBuyLevelCount + 1, #self._buyLevelCost do
				allCostWithoutMax = allCostWithoutMax + self._buyLevelCost[i]
			end

			allCostWithoutMax = allCostWithoutMax + (buyLevelCount - leftOffCount - 1) * fullLevelPrice
		end

		local needExp = self._levelUpExpCost - self._currentLevelExp
		local toFullLevelCost = math.round(needExp / self._levelUpExpCost * fullLevelPrice)

		allCost = allCostWithoutMax + toFullLevelCost
	elseif leftOffCount <= 0 then
		local oneLevelPrice = self._buyLevelCost[#self._buyLevelCost]

		allCost = buyLevelCount * oneLevelPrice
	elseif buyLevelCount <= leftOffCount then
		for i = self._haveBuyLevelCount + 1, self._haveBuyLevelCount + buyLevelCount do
			allCost = allCost + self._buyLevelCost[i]
		end
	else
		local fullLevelPrice = self._buyLevelCost[#self._buyLevelCost]

		for i = self._haveBuyLevelCount + 1, #self._buyLevelCost do
			allCost = allCost + self._buyLevelCost[i]
		end

		allCost = allCost + (buyLevelCount - leftOffCount) * fullLevelPrice
	end

	return allCost
end

function PassSystem:sortRewards(rewards)
	table.sort(rewards, function(a, b)
		local itemConfigA = ConfigReader:getRecordById("ItemConfig", a.code)
		local itemConfigB = ConfigReader:getRecordById("ItemConfig", b.code)
		local equipConfigA = ConfigReader:getRecordById("HeroEquipBase", a.code)
		local equipConfigB = ConfigReader:getRecordById("HeroEquipBase", b.code)
		local currencyA = itemConfigA and itemConfigA.Page == ItemPages.kCurrency
		local currencyB = itemConfigB and itemConfigB.Page == ItemPages.kCurrency

		if itemConfigA and itemConfigB then
			if currencyA == currencyB then
				if a.quality == b.quality then
					if itemConfigA.Sort == itemConfigB.Sort then
						return false
					end

					return itemConfigA.Sort < itemConfigB.Sort
				end

				return a.quality > b.quality
			end

			return currencyA and not currencyB
		elseif equipConfigA and equipConfigB then
			if equipConfigA.Rareity == equipConfigB.Rareity then
				if equipConfigA.Sort == equipConfigB.Sort then
					return false
				end

				return equipConfigA.Sort < equipConfigB.Sort
			end

			return equipConfigA.Rareity > equipConfigB.Rareity
		end

		if currencyA and not currencyB then
			return true
		elseif not currencyA and currencyB then
			return false
		end

		return not itemConfigA and itemConfigB
	end)
end

function PassSystem:getPassShopTalkShowByType(shopType)
	local str = ""

	if shopType == 1 then
		local content = ConfigReader:getDataByNameIdAndKey("ActivityBattlePass", self._currentPassTableId, "TalkBubble") or ""
		local index = math.random(1, #content)

		str = content[index] or content[1]
	end

	if shopType == 2 and self._currentPassShopActivity ~= nil then
		local content = self._currentPassShopActivity:getActivityConfig().BubleDesc
		local index = math.random(1, #content)

		str = content[index] or content[1]
	end

	return Strings:get(str)
end

function PassSystem:getPassShopHeroModel(shopType)
	local BoardMan = "Model_ZZBBWei"
	local position = {}
	local scale = {}

	if shopType == 1 and self._currentPassTableId ~= nil then
		local config = ConfigReader:getDataByNameIdAndKey("ActivityBattlePass", self._currentPassTableId, "BoardMan")

		BoardMan = config.showhero or "Model_ZZBBWei"
		position = config.position or {
			0,
			0
		}
		scale = config.zoom or {
			0.8
		}
	end

	if shopType == 2 and self._currentPassShopActivity ~= nil then
		BoardMan = self._currentPassShopActivity:getActivityConfig().ModelId
		position = self._currentPassShopActivity:getActivityConfig().position
		scale = self._currentPassShopActivity:getActivityConfig().zoom
	end

	return BoardMan, position, scale
end

function PassSystem:getPassModelTalkVoiceData(shopType)
	local data = {}

	data.ModelId, data.position, data.scale = self:getPassShopHeroModel(shopType)

	if shopType == 1 and self._currentPassTableId ~= nil then
		local TalkBubble = ConfigReader:getDataByNameIdAndKey("ActivityBattlePass", self._currentPassTableId, "TalkBubble")

		data.inVoice = TalkBubble["in"]
		data.buyVoice = TalkBubble.buy
		data.soldOutVoice = TalkBubble.sold_out
	end

	if shopType == 2 and self._currentPassShopActivity ~= nil then
		local Config = self._currentPassShopActivity:getActivityConfig()

		data.inVoice = Config["in"]
		data.buyVoice = Config.buy
		data.soldOutVoice = Config.sold_out
	end

	return data
end

function PassSystem:checkShowDailyChangePopUp()
	if self._dailyExp > 0 then
		self:showDailyPopUpView({
			dailyLevel = self._dailyLevel,
			dailyExp = self._dailyExp
		})
	end
end

function PassSystem:showDailyPopUpView(data)
	local view = self:getInjector():getInstance("PassDelayExpView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data))
end

function PassSystem:showActivateView(data)
	local view = self:getInjector():getInstance("PassLevelUpView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
end

function PassSystem:checkShowPassAndPassShop()
	local showPass = true
	local showPassShop = true
	local curTime = self._gameServerAgent:remoteTimeMillis()

	if self._currentActivity == nil then
		showPass = false
	elseif curTime >= self._currentActivity:getEndTime() then
		showPass = false
	end

	if self._currentPassShopActivity == nil then
		showPassShop = false
	elseif curTime >= self._currentPassShopActivity:getEndTime() then
		showPassShop = false
	end

	return showPass or showPassShop, showPass, showPassShop
end

function PassSystem:getResourceBannerIds(type)
	local resourceBanner

	if type == 1 or type == 2 then
		resourceBanner = self._currentActivity:getActivityConfig().ResourcesBanner
	end

	return (type == 3 or nil) and self._currentPassShopActivity:getActivityConfig().ResourcesBanner
end

function PassSystem:getMinCanGainReawrdLevel()
	return self._passListModel:getMinCanGainReawrdLevel()
end

function PassSystem:checkRedPointForHome()
	local showPassEnter, showPass, showPassShop = self:checkShowPassAndPassShop()

	if showPassEnter == false then
		return false
	end

	if CommonUtils.GetSwitch("fn_pass") == false then
		return false
	end

	return (showPass or nil) and (self:checkIsHaveRewardCanGet() or self:checkIsHaveTaskRewardCanGet(PassTaskType.kAllTask))
end

function PassSystem:chengRewardAmount(reward)
	local resultReward = {}
	local resultAmount = reward.amount

	if reward.code == "IGM_BP_Exp" then
		local config = ConfigReader:getRecordById("ItemConfig", reward.code)

		if config and config.Reward then
			local rewardCondig = ConfigReader:getRecordById("Reward", config.Reward[1])

			if rewardCondig and rewardCondig.Content then
				local amountData = rewardCondig.Content[1]

				if amountData and amountData.amount then
					resultAmount = amountData.amount * reward.amount
				end
			end
		end
	end

	if resultAmount == nil or resultAmount < 0 then
		resultAmount = 0
	end

	resultReward.code = reward.code
	resultReward.type = reward.type
	resultReward.amount = resultAmount

	return resultReward
end

function PassSystem:requestGetReward(type, level, callback)
	local activitySystem = self:getInjector():getInstance(ActivitySystem)
	local activityId = self._currentActivityID
	local param = {
		doActivityType = 102,
		type = type,
		level = level
	}

	activitySystem:requestDoActivity(activityId, param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			local data = response.data.rewards

			self:dispatch(Event:new(EVT_PASSPORT_REFRESH))

			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = data
			}))
		end
	end)
end

function PassSystem:requestBuyItemChildActivity(activityId, subActivityId, data, soldOut, callback)
	local activitySystem = self:getInjector():getInstance(ActivitySystem)

	activitySystem:requestDoChildActivity(activityId, subActivityId, data, function(response)
		if response.resCode == GS_SUCCESS then
			self:setPlayBuyEndVoice(true)

			if soldOut then
				self:setPlaySoldOutVoice(true)
			end

			if callback then
				callback(response)
			end

			local data = response.data.reward

			self:dispatch(Event:new(EVT_PASSPORT_REFRESH))

			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = data
			}))
		end
	end)
end

function PassSystem:requestBuyItemActivity(activityId, data, soldOut, callback)
	local activitySystem = self:getInjector():getInstance(ActivitySystem)

	activitySystem:requestDoActivity(activityId, data, function(response)
		if response.resCode == GS_SUCCESS then
			self:setPlayBuyEndVoice(true)

			if soldOut then
				self:setPlaySoldOutVoice(true)
			end

			if callback then
				callback(response)
			end

			local data = response.data.reward

			self:dispatch(Event:new(EVT_PASSPORT_REFRESH))

			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = data
			}))
		end
	end)
end

function PassSystem:requestBuyLevel(count, callback)
	local activitySystem = self:getInjector():getInstance(ActivitySystem)
	local activityId = self._currentActivityID
	local param = {
		doActivityType = 101,
		count = count
	}

	activitySystem:requestDoActivity(activityId, param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_PASSPORT_REFRESH))
		end
	end)
end

function PassSystem:requestBuyGiftBag(buyType, callback)
	local activitySystem = self:getInjector():getInstance(ActivitySystem)
	local activityId = self._currentActivityID
	local param = {
		doActivityType = 103,
		buyType = buyType
	}

	activitySystem:requestDoActivity(activityId, param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			local payOffSystem = self:getInjector():getInstance(PayOffSystem)

			payOffSystem:payOffToSdk(response.data)
		end
	end)
end

function PassSystem:requestGetTaskReward(taskType, taskId, callback)
	local activitySystem = self:getInjector():getInstance(ActivitySystem)
	local activityId = self._currentActivityID
	local param = {
		doActivityType = 105,
		taskType = taskType
	}

	if taskId ~= nil then
		param.taskId = taskId
	end

	activitySystem:requestDoActivity(activityId, param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			local rewards = response.data.rewards
			local resultReward = {}

			for i = 1, #rewards do
				resultReward[i] = self:chengRewardAmount(rewards[i])
			end

			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = resultReward
			}))
			self:dispatch(Event:new(EVT_PASSPORT_REFRESH))
		end
	end)
end

function PassSystem:requestTaskEndTime()
	local activitySystem = self:getInjector():getInstance(ActivitySystem)
	local activityId = self._currentActivityID
	local param = {
		doActivityType = 106
	}

	activitySystem:requestDoActivity(activityId, param, function(response)
		if response.resCode == GS_SUCCESS then
			local data = response.data

			if data.dailyResetTime then
				self._dailyResetTime = data.dailyResetTime / 1000
			end

			if data.weekResetTime then
				self._weekResetTime = data.weekResetTime / 1000
			end

			self:dispatch(Event:new(EVT_PASSPORT_REFRESH))
		end
	end)
end
