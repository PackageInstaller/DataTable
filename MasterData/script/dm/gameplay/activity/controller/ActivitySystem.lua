-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/controller/ActivitySystem.lua

EVT_ACTIVITY_RESET = "EVT_ACTIVITY_RESET"
EVT_ACTIVITY_REFRESH = "EVT_ACTIVITY_REFRESH"
EVT_ACTIVITY_CLOSE = "EVT_ACTIVITY_CLOSE"
EVT_ACTIVITY_REDPOINT_REFRESH = "EVT_ACTIVITY_REDPOINT_REFRESH"
EVT_ACTIVITY_SAGA_SCORE = "EVT_ACTIVITY_SAGA_SCORE"
EVT_ACTIVITYT_PAY_SUCC = "EVT_ACTIVITYT_PAY_SUCC"

require("dm.gameplay.activity.controller.ResourceDoubleActivitySystem")

DailyGift = "FreeStamina"
ActivitySystem = class("ActivitySystem", legs.Actor)

ActivitySystem:has("_activityList", {
	is = "r"
})
ActivitySystem:has("_activityService", {
	is = "r"
}):injectWith("ActivityService")
ActivitySystem:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ActivitySystem:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ActivitySystem:has("_resourceDoubleActivitySystem", {
	is = "r"
})
ActivitySystem:has("_battleTeam", {
	is = "rw"
})
ActivitySystem:has("_curStageType", {
	is = "rw"
})

function ActivitySystem:initialize()
	super.initialize(self)

	self._curStageType = ""
	self._activityList = ActivityList:new()

	self._activityList:setActivitySystem(self)

	self._timeSchel = nil
	self._timer = {}
	self._initActivityClubBoss = false
	self._bannerData = ConfigReader:getDataTable("ActivityBanner")
	self._checkNewOpenActivity = {}

	for k, v in pairs(self._bannerData) do
		if v.Type == ActivityBannerType.kActivity then
			self._checkNewOpenActivity[#self._checkNewOpenActivity + 1] = v.TypeId
		end
	end

	self._resourceDoubleActivitySystem = ResourceDoubleActivitySystem:new(self)
end

function ActivitySystem:testActivity()
	local activityId = "Activity_WorldBoss_220501"
	local data = {
		todayOpen = true,
		activityId = activityId,
		timeStamp = {
			finishTs = 1652544000000,
			dailyReset = false,
			openTs = 1648137600000
		}
	}

	self._activityList:syncAloneActivity(activityId, data)
end

function ActivitySystem:dispose()
	self:shutSchedule()

	if self._spCheckSchedule then
		LuaScheduler:getInstance():unschedule(self._spCheckSchedule)

		self._spCheckSchedule = nil
	end

	super.dispose(self)
end

function ActivitySystem:checkEnabled()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("Activity")

	return unlock, tips
end

function ActivitySystem:tryEnter(data)
	local unlock, tips = self:checkEnabled()
	local outself = self

	if unlock then
		self:requestAllActicities(true, function()
			local _1, _2, actIds = outself:getActivitiesInActivity()

			if actIds and #actIds > 0 then
				local view = self:getInjector():getInstance("ActivityView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
			else
				self:dispatch(ShowTipEvent({
					duration = 0.35,
					tip = Strings:get("Activity_Not_Found")
				}))
			end
		end)
	else
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = tips
		}))
	end
end

function ActivitySystem:getActivitysByType(actType)
	return self:getActivityList():getActivitysByType(actType)
end

function ActivitySystem:enterActstageBattle(data, activityId, subActivityId, bossSkip)
	local blockPointId = data.blockPointId
	local blockMapId = data.blockMapId
	local pointType = data.pointType
	local isReplay = false
	local outSelf, battleDelegate = self, {}
	local battleSession = ActstageBattleSession:new(data)

	battleSession:buildAll()

	local battleData = battleSession:getPlayersData()
	local battleConfig = battleSession:getBattleConfig()
	local battleSimulator = battleSession:getBattleSimulator()
	local battleLogic = battleSimulator:getBattleLogic()
	local battleInterpreter = BattleInterpreter:new()

	battleInterpreter:setRecordsProvider(battleSession:getBattleRecordsProvider())

	local battleDirector = LocalBattleDirector:new()

	battleDirector:setBattleSimulator(battleSimulator)
	battleDirector:setBattleInterpreter(battleInterpreter)

	local battlePassiveSkill = battleSession:getBattlePassiveSkill()
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(SettingBattleTypes.kActstage)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local canSkip, skipTime

	if bossSkip then
		canSkip = true
		skipTime = tonumber(ConfigReader:getDataByNameIdAndKey("ConfigValue", "ActivtyBoss_SkipTime", "content"))
	else
		canSkip = false
		skipTime = 0
	end

	local speedOpenSta = systemKeeper:getBattleSpeedOpen("actstage")
	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local autoFight = systemKeeper:canShow("AutoFight")
	local speedCanshow = systemKeeper:canShow("BattleSpeed")
	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter,
		teams = battleSession:genTeamAiInfo(),
		mainPlayerId = {
			data.playerData.rid
		}
	}

	function battleDelegate:onLeavingBattle()
		local params = {
			type = pointType,
			mapId = blockMapId,
			pointId = blockPointId,
			pointType = pointType
		}

		if data.isWorldBoss then
			params.resultData = battleSession:getResultSummary()

			outSelf:requestFinishWorldBossBattle(activityId, params, true)
		else
			params.doActivityType = "104"

			outSelf:requestLeaveActstage(activityId, subActivityId, params)
		end
	end

	function battleDelegate:onPauseBattle(continueCallback, leaveCallback)
		local popupDelegate = {}

		if data.isWorldBoss then
			function popupDelegate:willClose(sender, data)
				if data.response == AlertResponse.kOK then
					leaveCallback(true)
				else
					continueCallback(data.hpShow, data.effectShow)
				end
			end

			local content = data.pointType == WorldBossPointType.kVanguard and "Activity_WorldBoss_Tip1" or "Activity_WorldBoss_Tip2"
			local data = {
				title = Strings:get("Tip_Remind"),
				content = Strings:get(content),
				sureBtn = {},
				cancelBtn = {}
			}
			local view = outSelf:getInjector():getInstance("AlertView")

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, popupDelegate))
		else
			function popupDelegate:willClose(sender, data)
				if data.opt == BattlePauseResponse.kLeave then
					leaveCallback()
				else
					continueCallback(data.hpShow, data.effectShow)
				end
			end

			local pauseView = outSelf:getInjector():getInstance("battlePauseView")

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, nil, {}, popupDelegate))
		end
	end

	function battleDelegate:onAMStateChanged(sender, isAuto)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(SettingBattleTypes.kActstage, isAuto)
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onSkipBattle()
		return
	end

	function battleDelegate:onBattleFinish(result)
		local realData = battleSession:getResultSummary()
		local params = {
			type = pointType,
			mapId = blockMapId,
			pointId = blockPointId,
			resultData = realData,
			pointType = pointType
		}

		if data.isWorldBoss then
			outSelf:requestFinishWorldBossBattle(activityId, params)
		else
			params.doActivityType = "103"

			outSelf:requestFinishActstage(activityId, subActivityId, params)
		end
	end

	function battleDelegate:onDevWin()
		local realData = {
			randomSeed = 123321,
			opData = "dev",
			result = kBattleSideAWin,
			winners = {
				data.playerData.rid
			},
			pointId = data.blockPointId,
			mapId = blockMapId,
			statist = {
				totalTime = 10000,
				roundCount = 4,
				players = {
					[data.playerData.rid] = {
						unitsDeath = 0,
						hpRatio = 0.99999,
						unitsTotal = 3,
						unitSummary = {}
					},
					[data.blockPointId] = {
						unitsDeath = 20,
						hpRatio = 0,
						unitsTotal = 20,
						unitSummary = {}
					}
				}
			}
		}
		local params = {
			type = pointType,
			mapId = blockMapId,
			pointId = blockPointId,
			resultData = realData,
			pointType = pointType
		}

		if data.isWorldBoss then
			outSelf:requestFinishWorldBossBattle(activityId, params)
		else
			params.doActivityType = "103"

			outSelf:requestFinishActstage(activityId, subActivityId, params)
		end
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(SettingBattleTypes.kActstage, nil, timeScale)
	end

	function battleDelegate:showBossCome(pauseFunc, resumeCallback, paseSta)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if resumeCallback then
				resumeCallback()
			end
		end

		local bossView = outSelf:getInjector():getInstance("battleBossComeView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
			paseSta = paseSta
		}, popupDelegate))

		if pauseFunc then
			pauseFunc()
		end
	end

	function battleDelegate:showBattleItem(pauseFunc, resumeCallback, paseSta)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if resumeCallback then
				resumeCallback()
			end
		end

		local bossView = outSelf:getInjector():getInstance("BattleItemShowView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, {
			maskOpacity = 0
		}, {
			paseSta = paseSta
		}, popupDelegate))

		if pauseFunc then
			pauseFunc()
		end
	end

	function battleDelegate:onShowRestraint(continueCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender)
			continueCallback()
		end

		local view = outSelf:getInjector():getInstance("battlerofessionalRestraintView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, popupDelegate))
	end

	local pointConfig = ConfigReader:getRecordById("ActivityBlockPoint", blockPointId)

	pointConfig = pointConfig or ConfigReader:getRecordById("ActivityBlockBattle", blockPointId)
	pointConfig = pointConfig or ConfigReader:getRecordById("WolrdBossBlockBattle", blockPointId)

	if not pointConfig.Background then
		local bgRes = "battle_scene_1"
		local BGM = pointConfig.BGM
		local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
		local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
		local var_8_1 = {
			battleType = battleSession:getBattleType(),
			battleData = battleData,
			battleConfig = battleConfig,
			isReplay = isReplay,
			logicInfo = logicInfo,
			delegate = battleDelegate
		}
		local var_8_2 = {
			mainView = "battlePlayer",
			opPanelRes = "asset/ui/BattleUILayer.csb",
			canChangeSpeedLevel = true,
			opPanelClazz = "BattleUIMediator",
			battleSettingType = SettingBattleTypes.kActstage,
			bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVE_Main"),
			bgm = BGM,
			background = bgRes,
			refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
			battleSuppress = BattleDataHelper:getBattleSuppress()
		}

		var_8_2.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
		var_8_2.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
		var_8_2.passiveSkill = battlePassiveSkill
		var_8_2.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
		var_8_2.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("crusade")
		var_8_2.changeMaxNum = pointConfig.BossRound or 1

		local var_8_3 = {
			speed = {
				visible = speedOpenSta and speedCanshow,
				lock = not unlockSpeed,
				tip = tipsSpeed,
				speedConfig = battleSpeed_Actual,
				speedShowConfig = battleSpeed_Display,
				timeScale = timeScale
			},
			skip = {
				enable = true,
				waitTips = "ARENA_SKIP_TIP",
				visible = canSkip,
				skipTime = skipTime
			},
			auto = {
				canChangeAuto = true,
				visible = autoFight,
				state = isAuto
			},
			pause = {
				enable = true,
				visible = true
			}
		}
		local var_8_4 = {}

		var_8_4.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
		var_8_4.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
		var_8_3.restraint = var_8_4
		var_8_2.btnsShow = var_8_3
		var_8_1.viewConfig = var_8_2
		var_8_1.loadingType = LoadingType.KActivity

		local data = var_8_1

		BattleLoader:pushBattleView(self, data, nil, true)
	end
end

function ActivitySystem:requestFinishActstage(activityId, subActivityId, params)
	local function callback(response)
		if response.resCode == GS_SUCCESS then
			local function finishCallBack()
				local data = response.data

				data.activityId = activityId
				data.subActivityId = subActivityId
				data.pointId = params.pointId
				data.params = params

				if data.pass then
					local function endFunc()
						self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("ActivityStageFinishView"), {}, data, self))
					end

					local activity = self:getActivityById(activityId)
					local subActivity = activity:getBlockMapActivity(subActivityId)
					local point
					local pointConfig = (subActivity:getType() == ActivityType.KActivityBlockMapNew and subActivity:getSubPointById(params.pointId) or subActivity:getPointById(params.pointId)):getConfig()
					local storyLink = pointConfig.StoryLink
					local storynames = storyLink and storyLink.win
					local storyDirector = self:getInjector():getInstance(story.StoryDirector)
					local storyAgent = storyDirector:getStoryAgent()

					storyAgent:setSkipCheckSave(false)
					storyAgent:trigger(storynames, nil, endFunc)
				else
					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("ActivityStageUnFinishView"), {}, data, self))
				end
			end

			if response.data.reviewFailed then
				local data = {
					title = Strings:get("Tip_Remind"),
					title1 = Strings:get("UITitle_EN_Tishi"),
					content = Strings:get("FAC_Des"),
					sureBtn = {
						text1 = "FAC_Btn"
					}
				}
				local outSelf, delegate = self, {}

				function delegate:willClose(popupMediator, data)
					finishCallBack()
				end

				local view = self:getInjector():getInstance("AlertView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, data, delegate))
			else
				finishCallBack()
			end
		else
			print("requestFinishActstage error .activityId:" .. tostring(activityId))
			BattleLoader:popBattleView(self, {})

			if self:checkComplexActivity(activityId) then
				self:complexActivityTryEnter({
					activityId = activityId
				})
			else
				self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "mainScene", nil, nil))
			end
		end
	end

	self:requestDoChildActivity(activityId, subActivityId, params, callback, true)
end

function ActivitySystem:requestLeaveActstage(activityId, subActivityId, params)
	local function callback(response)
		if response.resCode == GS_SUCCESS then
			local data = response.data

			data.activityId = activityId
			data.subActivityId = subActivityId
			data.pointId = params.pointId
			data.activeLeave = true
			data.params = params

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("ActivityStageUnFinishView"), {}, data))
		else
			print("requestLeaveActstage error .activityId:" .. tostring(activityId))
			BattleLoader:popBattleView(self, {})

			if self:checkComplexActivity(activityId) then
				self:complexActivityTryEnter({
					activityId = activityId
				})
			else
				self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "mainScene", nil, nil))
			end
		end
	end

	self:requestDoChildActivity(activityId, subActivityId, params, callback, true)
end

function ActivitySystem:requestFinishWorldBossBattle(activityId, data)
	local function callback(response)
		if response.resCode == GS_SUCCESS then
			local param = response.data

			param.activityId = activityId
			param.pointId = data.pointId
			param.params = data
			param.pointType = data.pointType

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("WorldBossFinishView"), {}, param))
		else
			print("requestLeaveWorldBoss error .activityId:" .. tostring(activityId))
			BattleLoader:popBattleView(self, {})

			if not self:isActivityOver(activityId) then
				self:enterWorldBossView({
					activityId = activityId
				})
			else
				self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "mainScene", nil, nil))
			end
		end
	end

	local params = {
		doActivityType = 103,
		pointType = data.pointType,
		resultData = data.resultData
	}

	self:requestDoActivity(activityId, params, callback, true)
end

function ActivitySystem:getActivityOpenStatusById(activityId)
	local activityId = tostring(activityId)
	local _, activities = self:getActivitiesInActivity()
	local activity = activities[activityId]

	if activity then
		return true
	end

	return false
end

function ActivitySystem:getAllActivityIds()
	return self:getActivityList():getAllActivityIds()
end

function ActivitySystem:checkActivityState()
	self:shutSchedule()

	local activityList = self:getAllActivityIds()
	local hasNewActivity = false

	for k, activityId in pairs(activityList) do
		local isOver = self:isActivityOver(activityId)

		if not isOver and not self._timer[activityId] then
			self._timer[activityId] = 1

			if table.indexof(self._checkNewOpenActivity, activityId) then
				hasNewActivity = true
			end
		end
	end

	if hasNewActivity then
		self:dispatch(Event:new(EVT_CHARGETASK_FIN))
	end

	self:createTimeSchedule()
end

function ActivitySystem:createTimeSchedule()
	local function update()
		local activityList = self:getAllActivityIds()

		for k, activityId in ipairs(activityList) do
			if self._timer[activityId] == 1 then
				local isOver = self:isActivityOver(activityId)

				if isOver then
					self:dispatch(Event:new(EVT_ACTIVITY_CLOSE, {
						activityId = activityId
					}))

					self._timer[activityId] = 0
				end
			end
		end
	end

	self._timeSchel = self._timeSchel or LuaScheduler:getInstance():schedule(update, 2, true)
end

function ActivitySystem:checkSpecialActivityOpen()
	local function checkFunc()
		local activity = self:getActivityByType("Carnival")

		if activity and activity:getIsCanShow() == "false" and self:checkConditionWithId("Carnival") then
			activity:setIsCanShow("true")
			self:dispatch(Event:new(EVT_CHARGETASK_FIN))
		end
	end

	self._spCheckSchedule = self._spCheckSchedule or LuaScheduler:getInstance():schedule(checkFunc, 2, true)
end

function ActivitySystem:shutSchedule()
	if self._timeSchel then
		LuaScheduler:getInstance():unschedule(self._timeSchel)

		self._timeSchel = nil
	end
end

function ActivitySystem:checkCarnival()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("Carnival")
	local isOpen = self:isActivityOpen("Carnival")
	local isOver = self:isActivityOver("Carnival")
	local openCondition = self:checkConditionWithId("Carnival")

	return isOpen and not isOver and unlock and openCondition
end

function ActivitySystem:tryEnterCarnival()
	if self:checkCarnival() then
		self:requestAllActicities(true, function()
			local view = self:getInjector():getInstance("CarnivalView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
		end)
	end
end

function ActivitySystem:enterEasterEgg(data)
	local view = self:getInjector():getInstance("ActivityBlockEggView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		activityId = data.activityId
	}))
end

function ActivitySystem:showEasterRewards(data)
	local view = self:getInjector():getInstance("ActivityEggRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		activityId = data.activityId
	}))
end

function ActivitySystem:enterTeam(activityId, blockActivity, param)
	local view = self:getInjector():getInstance("ActivityBlockTeamView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		activity = blockActivity,
		activityId = activityId,
		param = param
	}))
end

function ActivitySystem:enterSurface(param)
	local surfaceSystem = self:getInjector():getInstance(SurfaceSystem)

	surfaceSystem:tryEnter(param)
end

function ActivitySystem:showEggSucc(activityId, eggActivity, callback)
	local view = self:getInjector():getInstance("ActivityEggSuccView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		activityId = activityId,
		eggActivity = eggActivity,
		callback = callback
	}))
end

function ActivitySystem:showActivityRules(rules, param, extraParams)
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = rules,
		param1 = param,
		useParam = param ~= nil or extraParams ~= nil,
		extraParams = extraParams
	}, nil)

	self:dispatch(event)
end

function ActivitySystem:enterSummerExchange(activityId)
	local view = self:getInjector():getInstance("ActivityBlockSummerExchangeView")
	local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		activityId = activityId
	})

	self:dispatch(event)
end

function ActivitySystem:monsterShopGoodsExchange(activityId, subActivityId, data, callback)
	local var_52_0 = {
		doActivityType = 101,
		exchangeId = data.goodsId
	}

	var_52_0.index = data.index or 1
	var_52_0.exchangeAmount = data.goodsNum or 1

	local params = var_52_0
	local activityId = activityId

	local function callbackFunc(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			local data = response.data.rewards

			self:dispatch(Event:new(EVT_MONSTERSHOP_REFRESH, {
				activityId = activityId
			}))

			if data and next(data) then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = data
				}))
			end
		end
	end

	if subActivityId then
		self:requestDoChildActivity(activityId, subActivityId, params, callbackFunc)
	else
		self:requestDoActivity(activityId, params, callbackFunc)
	end
end

function ActivitySystem:monsterShopCandyExchange(activityId, subActivityId, callback)
	local params = {
		doActivityType = 102
	}
	local activityId = activityId

	local function callbackFunc(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			local data = response.data.rewards

			self:dispatch(Event:new(EVT_MONSTERSHOP_REFRESH, {
				activityId = activityId
			}))

			if data and next(data) then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = data
				}))
			end
		end
	end

	if subActivityId then
		self:requestDoChildActivity(activityId, subActivityId, params, callbackFunc)
	else
		self:requestDoActivity(activityId, params, callbackFunc)
	end
end

function ActivitySystem:monsterShopGetMoneyRates(activityId, subActivityId, callback)
	local params = {
		doActivityType = 103
	}
	local activityId = activityId

	local function callbackFunc(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response)
		end
	end

	if subActivityId then
		self:requestDoChildActivity(activityId, subActivityId, params, callbackFunc)
	else
		self:requestDoActivity(activityId, params, callbackFunc)
	end
end

function ActivitySystem:colourEggGetAll(activityId, subActivityId, callback)
	local params = {
		doActivityType = 101
	}
	local activityId = activityId

	local function callbackFunc(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response.data)
			end

			self:dispatch(Event:new(EVT_COLOUR_EGG_REFRESH, response.data))
		end
	end

	if subActivityId then
		self:requestDoChildActivity(activityId, subActivityId, params, callbackFunc)
	else
		self:requestDoActivity(activityId, params, callbackFunc)
	end
end

function ActivitySystem:colourEggGetTarget(activityId, subActivityId, eggId, callback)
	local params = {
		doActivityType = 102,
		eggId = eggId
	}
	local activityId = activityId

	local function callbackFunc(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data)
		end
	end

	if subActivityId then
		self:requestDoChildActivity(activityId, subActivityId, params, callbackFunc)
	else
		self:requestDoActivity(activityId, params, callbackFunc)
	end
end

function ActivitySystem:getCurrentTime()
	return self._gameServerAgent:remoteTimestamp()
end

function ActivitySystem:getActivityById(activityId)
	return self:getActivityList():getActivityById(activityId)
end

function ActivitySystem:getActivityByType(actType)
	return self:getActivityList():getActivityByType(actType)
end

function ActivitySystem:getActivityByComplexId(activityId)
	local activity = self:getActivityList():getActivityById(activityId)

	if activity and self:checkComplexActivity(activityId) then
		return activity
	end

	return nil
end

function ActivitySystem:getActivityByComplexUI(ui)
	local activity = self:getActivityList():getActivityByComplexUI(ui)

	if activity and self:checkComplexActivity(activity:getId()) then
		return activity
	end

	return nil
end

function ActivitySystem:getActivitiesByType(type)
	return self:getActivityList():getActivitiesByType(type)
end

function ActivitySystem:getActivitiesByShowTab(showTab)
	local activitiesForIndex = {}
	local activitiesForId = {}
	local allActivities = self:getActivityList():getAllActivities()
	local index = 1

	for id, activity in pairs(allActivities) do
		if activity:getShowTab() == showTab and self:isActivityOpen(id) and not self:isActivityOver(id) then
			activitiesForIndex[index] = activity
			activitiesForId[id] = activity
			index = index + 1
		end
	end

	table.sort(activitiesForIndex, function(a, b)
		return a:getShowIndex() < b:getShowIndex()
	end)

	return activitiesForIndex, activitiesForId
end

function ActivitySystem:getActivitiesInActivity()
	local activitiesForIndex = {}
	local activitiesForId = {}
	local activityList = {}
	local allActivities = self:getActivityList():getAllActivities()
	local index = 1

	for id, activity in pairs(allActivities) do
		if (activity:getShowTab() == ActivityShowTab.kInActivity or activity:getShowTab() == ActivityShowTab.kInAll) and self:isActivityOpen(id) and not self:isActivityOver(id) and self:checkConditionWithId(id) then
			activitiesForIndex[index] = activity
			activitiesForId[id] = activity
			activityList[index] = id
			index = index + 1
		end
	end

	table.sort(activitiesForIndex, function(a, b)
		return a:getShowIndex() < b:getShowIndex()
	end)

	return activitiesForIndex, activitiesForId, activityList
end

function ActivitySystem:getExtraMarkByType(type)
	local activities = self:getActivitiesByType(ActivityType.kBLOCKSPEXTRA)

	for id, activity in pairs(activities) do
		local config = activity:getActivityConfig()

		if config[type] then
			return (string.format("asset/commonLang/%s.png", config[type]))
		end
	end

	return nil
end

function ActivitySystem:checkConditionWithId(activityId)
	local activity = self:getActivityById(activityId)

	if not activity then
		return false
	end

	local condition = activity:getClientCondition()

	if not condition or type(condition) ~= "table" then
		return true
	end

	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local unlockSystem = self:getInjector():getInstance(SystemKeeper)
	local playerLevel = developSystem:getPlayer():getLevel()
	local isOk = true

	for k, v in pairs(condition) do
		if k == "LEVEL" then
			isOk = isOk and v <= playerLevel
		end

		if k == "STAGE" then
			isOk = isOk and unlockSystem:checkStagePointLock(v)
		end
	end

	return isOk
end

function ActivitySystem:getActivitiesInHome()
	local activitiesForIndex = {}
	local activitiesForId = {}
	local allActivities = self:getActivityList():getAllActivities()
	local index = 1

	for id, activity in pairs(allActivities) do
		if (activity:getShowTab() == ActivityShowTab.kInHome or activity:getShowTab() == ActivityShowTab.kInAll) and self:isActivityOpen(id) and not self:isActivityOver(id) then
			activitiesForIndex[index] = activity
			activitiesForId[id] = activity
			index = index + 1
		end
	end

	table.sort(activitiesForIndex, function(a, b)
		return a:getShowIndex() < b:getShowIndex()
	end)

	return activitiesForIndex, activitiesForId
end

function ActivitySystem:hasActivitySystemRedPoint()
	local activitiesForIndex, activitiesForId = self:getActivitiesInActivity()

	for index, activity in pairs(activitiesForIndex) do
		if activity:hasRedPoint() then
			return true
		end
	end

	return false
end

function ActivitySystem:hasRedPointForActivity(activityId)
	local activity = self:getActivityById(activityId)

	if activity then
		if self:hasRedPointForActivityById(activityId) then
			return true
		end

		local var_77_0 = self:getActivityById(activityId):getActivityConfig().RedPointRelatedActivity

		if not var_77_0 then
			var_77_0 = {}

			local redPointRelatedActivity = var_77_0

			for i, actId in ipairs(redPointRelatedActivity) do
				if self:hasRedPointForActivityById(actId) then
					return true
				end
			end
		end
	end

	return false
end

function ActivitySystem:hasRedPointForActivityById(activityId)
	local activity = self:getActivityById(activityId)

	if activity and activity.hasRedPoint and activity:hasRedPoint() then
		return true
	end

	return false
end

function ActivitySystem:hasRedPointForActivityWsj(activityId)
	if not self:hasRedPointForActivity(activityId) then
		return self:hasRedPointForActivity(self:getActivityById(activityId):getActivityConfig().LoginActivity)
	end

	return true
end

function ActivitySystem:hasRedPointForActivitySummer(activityId)
	if not self:hasRedPointForActivity(activityId) then
		local limit = ConfigReader:getRecordById("Reset", "AcitvitySummerStamina_Reset").ResetSystem.limit
		local bagSystem = self:getInjector():getInstance(BagSystem)
		local num = bagSystem:getAcitvitySummerPower()
		local isHave, tips = self:getActivityById(activityId):getActivityClubBossActivity()

		return isHave and limit <= num
	end

	return true
end

function ActivitySystem:hasRedPointForActivityZero(activityId)
	if not self:hasRedPointForActivity(activityId) then
		local activity = self:getActivityById(activityId)

		return activity:hasBigRewardRedPoint()
	end

	return true
end

function ActivitySystem:isActivityOpen(activityId, startTime)
	local activity = self:getActivityById(activityId)

	if activity then
		local curTime = self._gameServerAgent:remoteTimeMillis()
		local startTime = startTime or activity:getStartTime()

		if curTime < startTime or curTime > activity:getEndTime() then
			return false
		end

		return activity:getIsTodayOpen()
	end

	return false
end

function ActivitySystem:isActivityOver(activityId)
	local activity = self:getActivityById(activityId)

	if activity then
		local curTime = self._gameServerAgent:remoteTimeMillis()

		return curTime >= activity:getEndTime()
	end

	return false
end

function ActivitySystem:getActivityRemainTime(activityId)
	local activity = self:getActivityById(activityId)

	if activity then
		local curTime = self._gameServerAgent:remoteTimeMillis()

		return math.floor(activity:getEndTime() - curTime)
	end

	return 0
end

function ActivitySystem:disableEightDayLoginPop()
	local activity = self:getActivityById("EightDaysCheckIn")

	if activity then
		activity:setCanHomePop(false)
	end
end

function ActivitySystem:isCarnivalGruopOpen(index)
	local activity = self:getActivityById("Carnival")

	return activity:isGroupOpen(index)
end

function ActivitySystem:doReset(resetId, value, response)
	if response then
		self:getActivityList():synchronize(response.activityMap, true)
		self:dispatch(Event:new(EVT_ACTIVITY_REFRESH))
	end

	local activity = self:getActivityByType("AISHOP")

	if activity then
		activity:doReset()
		delayCallByTime(3000, function()
			self:requestActicityById(activity:getId())
		end)
	end
end

function ActivitySystem:hasOverActivity(showTab)
	local activities = self:getActivitiesByShowTab(showTab)

	for _, activity in pairs((tabType == nil or nil) and self:getActivityList():getAllActivities()) do
		if self:isActivityOver(activity:getId()) then
			return true
		end
	end

	return false
end

function ActivitySystem:hasOverActivityInActivity(list)
	local activities = list

	for _, activity in pairs(activities) do
		if self:isActivityOver(activity:getId()) then
			return true
		end
	end

	return false
end

function ActivitySystem:deleteActivity(activityMap)
	self:getActivityList():deleteActivity(activityMap)
end

function ActivitySystem:getTimeWillOpen(start)
	local _, _, y, mon, d, h, m, s = string.find(start, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
	local table = {
		year = y,
		month = mon,
		day = d,
		hour = h,
		min = m,
		sec = s
	}
	local mills = TimeUtil:timeByRemoteDate(table)
	local remoteTimestamp = self:getCurrentTime()
	local remainTime = mills - remoteTimestamp
	local str = ""
	local fmtStr = "${d}:${H}:${M}:${S}"
	local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
	local parts = string.split(timeStr, ":", nil, true)
	local timeTab = {}

	timeTab.day = tonumber(parts[1])
	timeTab.hour = tonumber(parts[2])
	timeTab.min = tonumber(parts[3])

	if timeTab.day > 0 then
		str = timeTab.day .. Strings:get("TimeUtil_Day")
	elseif timeTab.hour > 0 then
		str = timeTab.hour .. Strings:get("TimeUtil_Hour")
	else
		timeTab.min = math.max(1, timeTab.min)
		str = timeTab.min .. Strings:get("TimeUtil_Min")
	end

	return str
end

function ActivitySystem:isCanGetStamina(timeList, index)
	local activity = self:getActivityById("FreeStamina")
	local timeSlot = activity:getTotalTimeSlot()
	local receiveStatus = activity:getRewardStatusByIndex(index)
	local dayMaxTime = activity:getDayMaxTimeList()
	local dayMaxDataMin = string.split(dayMaxTime[1], ":")
	local minData = string.split(timeList[1], ":")
	local maxData = string.split(timeList[2], ":")
	local currentTimeStamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
	local curData = TimeUtil:remoteDate("*t", currentTimeStamp)
	local minDayTimeStamp = TimeUtil:timeByRemoteDate({
		year = curData.year,
		month = curData.month,
		day = curData.day,
		hour = dayMaxDataMin[1],
		min = dayMaxDataMin[2],
		sec = dayMaxDataMin[3]
	})
	local minTimeStamp, maxTimeStamp

	if minDayTimeStamp <= currentTimeStamp and index ~= timeSlot then
		minTimeStamp = TimeUtil:timeByRemoteDate({
			year = curData.year,
			month = curData.month,
			day = curData.day + 1,
			hour = minData[1],
			min = minData[2],
			sec = minData[3]
		})
		maxTimeStamp = TimeUtil:timeByRemoteDate({
			year = curData.year,
			month = curData.month,
			day = curData.day + 1,
			hour = maxData[1],
			min = maxData[2],
			sec = maxData[3]
		})
	else
		minTimeStamp = TimeUtil:timeByRemoteDate({
			year = curData.year,
			month = curData.month,
			day = curData.day,
			hour = minData[1],
			min = minData[2],
			sec = minData[3]
		})
		maxTimeStamp = TimeUtil:timeByRemoteDate({
			year = curData.year,
			month = curData.month,
			day = curData.day,
			hour = maxData[1],
			min = maxData[2],
			sec = maxData[3]
		})
	end

	local canDiamondGet = false
	local status

	if maxTimeStamp < currentTimeStamp then
		if TimeUtil:isSameDay(currentTimeStamp, maxTimeStamp, {
			sec = 0,
			min = 0,
			hour = 5
		}) and receiveStatus ~= ActivityTaskStatus.kGet then
			canDiamondGet = true
		end

		status = StaminaRewardTimeStatus.kBefore
	elseif currentTimeStamp <= maxTimeStamp and minTimeStamp <= currentTimeStamp then
		status = receiveStatus == ActivityTaskStatus.kGet and StaminaRewardTimeStatus.kBefore or StaminaRewardTimeStatus.kNow
	else
		local baseTime = TimeUtil:timeByRemoteDate({
			hour = 5,
			min = 0,
			sec = 0,
			year = curData.year,
			month = curData.month,
			day = curData.day
		})

		if receiveStatus ~= ActivityTaskStatus.kGet and (currentTimeStamp < baseTime or minDayTimeStamp < currentTimeStamp) then
			canDiamondGet = true
		end

		status = StaminaRewardTimeStatus.kAfter
	end

	return status, canDiamondGet
end

function ActivitySystem:getTimeLimitShopLeaveTime()
	local activity = self:getActivityByComplexUI("FESTIVALPACKAGE")

	if activity then
		local endTime = activity:getEndTime() / 1000
		local currentTime = self:getCurrentTime()

		if currentTime < endTime then
			return endTime - currentTime
		end
	end

	return 0
end

function ActivitySystem:checkTimeLimitShopShow()
	local activity = self:getActivityByComplexUI("FESTIVALPACKAGE")

	if activity then
		local srartTime = activity:getStartTime() / 1000
		local endTime = activity:getEndTime() / 1000
		local currentTime = self:getCurrentTime()

		if currentTime < endTime and srartTime < currentTime then
			return true
		end
	end

	return false
end

function ActivitySystem:tryEnterTimeLimitSHop()
	if self:checkTimeLimitShopRedpointShow() then
		self:saveTimeLimitShopRedpoint()
	end

	if self:checkTimeLimitShopShow() then
		local view = self:getInjector():getInstance("TimeShopActivityView")

		if view then
			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, {
				activity = self:getActivityByComplexUI("FESTIVALPACKAGE")
			}))
		end
	end
end

function ActivitySystem:saveTimeLimitShopRedpoint()
	local activity = self:getActivityByComplexUI("FESTIVALPACKAGE")

	if activity then
		local activityId = activity:getId()
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local rid = developSystem:getPlayer():getRid()
		local diskData = CommonUtils.getDataFromLocalByKey(rid .. "TimeLimitShopActivity")

		if diskData == nil then
			diskData = {}
		end

		if diskData then
			table.insert(diskData, activityId)
			CommonUtils.saveDataToLocalByKey(diskData, rid .. "TimeLimitShopActivity")
		end
	end
end

function ActivitySystem:checkTimeLimitShopRedpointShow()
	local activity = self:getActivityByComplexUI("FESTIVALPACKAGE")

	if activity then
		local activityId = activity:getId()
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local rid = developSystem:getPlayer():getRid()
		local diskData = CommonUtils.getDataFromLocalByKey(rid .. "TimeLimitShopActivity")

		if diskData == nil then
			diskData = {}
		end

		for i = 1, #diskData do
			if diskData[i] == activityId then
				return false
			end
		end

		return true
	end

	return false
end

function ActivitySystem:getFestivalPackageTitle()
	local activity = self:getActivityByComplexUI("FESTIVALPACKAGE")

	if activity then
		return activity:getTitle()
	end

	return ""
end

function ActivitySystem:tryEnterActivityCalendar()
	local view = self:getInjector():getInstance("ActivityListiew")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}))
end

function ActivitySystem:isActivityCalendarTimeType(type)
	if type == "RANGE_CONTINUE" or type == "RANGE_CONTINUE_TOP" or type == "FIXED" or type == "SERVER_FIXED" then
		return true
	end

	return false
end

function ActivitySystem:getActivityCalendarList()
	local bannerConfig = self._bannerData
	local sortOpenBanner = {}
	local sortCloseBanner = {}
	local closeDay = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MainPage_PreviewDays", "content")

	for k, v in pairs(bannerConfig) do
		if CommonUtils.GetSwitch(v.Switch) then
			local isOpen = false

			if ActivityBannerType.kCooperateBoss == v.Type then
				local coopSystem = self:getInjector():getInstance(CooperateBossSystem)

				isOpen = coopSystem:cooperateBossShow()
			elseif ActivityBannerType.kActivity == v.Type then
				local activity = self:getActivityById(v.TypeId)

				if activity and activity:getConfig().Enable ~= 0 then
					isOpen = activity:getIsTodayOpen()

					if isOpen then
						local mills
						local bannerTime = v.BannerTime

						if bannerTime then
							local start = bannerTime.start[1]
							local _, _, y, mon, d, h, m, s = string.find(start, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

							mills = TimeUtil:timeByRemoteDate({
								year = y,
								month = mon,
								day = d,
								hour = h,
								min = m,
								sec = s
							})
							mills = mills * 1000
							isOpen = self:isActivityOpen(v.TypeId, mills)
						end
					end
				end
			end

			if isOpen then
				table.insert(sortOpenBanner, v)
			elseif v.TypeId and v.TypeId ~= "" then
				local config = ConfigReader:getRecordById("Activity", v.TypeId)

				if config and config.Time and self:isActivityCalendarTimeType(config.Time) and config.Enable ~= 0 then
					closeDay = v.EarlyShow and v.EarlyShow ~= "" and v.EarlyShow or ConfigReader:getDataByNameIdAndKey("ConfigValue", "MainPage_PreviewDays", "content")

					local _, _, y, m, d, hour, min, sec = string.find(config.TimeFactor.start[1], "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
					local timestamp = TimeUtil:timeByRemoteDate({
						year = y,
						month = m,
						day = d,
						hour = hour,
						min = min,
						sec = sec
					})
					local curstamp = TimeUtil:timeByRemoteDate()

					if curstamp < timestamp and timestamp < curstamp + closeDay * 24 * 60 * 60 then
						table.insert(sortCloseBanner, v)
					end
				end
			end
		end
	end

	table.sort(sortOpenBanner, function(a, b)
		return a.Sort > b.Sort
	end)
	table.sort(sortCloseBanner, function(a, b)
		return a.Sort > b.Sort
	end)

	return sortOpenBanner, sortCloseBanner
end

function ActivitySystem:isActivityCalendarShow(data)
	if ActivityBannerType.kCooperateBoss == data.Type then
		local coopSystem = self:getInjector():getInstance(CooperateBossSystem)

		return coopSystem:cooperateBossShow()
	elseif ActivityBannerType.kActivity == data.Type then
		local activity = self:getActivityById(data.TypeId)

		if activity then
			return activity:getIsTodayOpen()
		end
	end

	return false
end

function ActivitySystem:isActivityCalendarRedpointShowAll(data)
	local openList = self:getActivityCalendarList()

	for i = 1, #openList do
		local tmpRedPoint = self:isActivityCalendarRedpointShow(openList[i])

		if tmpRedPoint then
			return true
		end
	end

	return false
end

function ActivitySystem:isActivityCalendarRedpointShow(data)
	if ActivityBannerType.kCooperateBoss == data.Type then
		local coopSystem = self:getInjector():getInstance(CooperateBossSystem)

		return coopSystem:redPointShow()
	elseif ActivityBannerType.kActivity == data.Type then
		return self:hasRedPointForActivity(data.TypeId)
	end

	return false
end

function ActivitySystem:getActivityCalendarEndTime(data)
	if ActivityBannerType.kCooperateBoss == data.Type then
		local coopSystem = self:getInjector():getInstance(CooperateBossSystem)

		return coopSystem:getCooperateBoss():getEndTime()
	elseif ActivityBannerType.kActivity == data.Type then
		local activityData = self:getActivityById(data.TypeId)

		return activityData:getEndTime() * 0.001
	end

	return nil
end

function ActivitySystem:saveActivityCalNewTag(activityId)
	if activityId then
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local rid = developSystem:getPlayer():getRid()
		local diskData = CommonUtils.getDataFromLocalByKey(rid .. "ActivityCalender")

		if diskData == nil then
			diskData = {}
		end

		if diskData then
			table.insert(diskData, activityId)
			CommonUtils.saveDataToLocalByKey(diskData, rid .. "ActivityCalender")
		end
	end
end

function ActivitySystem:checkActivityCalNewTagShow(activityId)
	if activityId then
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local rid = developSystem:getPlayer():getRid()
		local diskData = CommonUtils.getDataFromLocalByKey(rid .. "ActivityCalender")

		if diskData == nil then
			diskData = {}
		end

		for i = 1, #diskData do
			if diskData[i] == activityId then
				return false
			end
		end

		return true
	end

	return false
end

function ActivitySystem:tryEnterBentoView(data)
	local view = self:getInjector():getInstance("ActivityBentoView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
end

function ActivitySystem:enterWorldBossView(data)
	local function enterView(response)
		local activity = self:getActivityById(data.activityId)

		activity:synchronize(response.data)

		local view = self:getInjector():getInstance("WorldBossMainView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
	end

	local params = {
		doActivityType = 101
	}

	self:requestDoActivity(data.activityId, params, enterView)
end

function ActivitySystem:checkIsRecommend(checkId, activity)
	local recommendData = {}

	recommendData.isRecommend = false
	recommendData.desc = ""

	if activity then
		if activity:getType() == ActivityType.KWorldBoss then
			local buffList = activity:getBuffOpenTime()
			local activeIndex = activity:getCurBuffIndex()
			local buffData = buffList[activeIndex]

			if buffData then
				if buffData.HeroId then
					for i, v in pairs(buffData.HeroId) do
						if v == checkId then
							recommendData.isRecommend = true
							recommendData.order = 1
							recommendData.desc = Strings:get("clubBoss_46")
							recommendData.color = cc.c3b(255, 203, 63)
							recommendData.showType = "recommend"
						end
					end
				end

				if buffData.Party then
					local heroSystem = self:getInjector():getInstance("DevelopSystem"):getHeroSystem()
					local heroData = heroSystem:getHeroById(checkId)
					local party = heroData:getParty()

					for i, v in pairs(buffData.Party) do
						if party == v then
							recommendData.isRecommend = true
							recommendData.order = 2
							recommendData.desc = Strings:get("EXPLORE_UI22")
							recommendData.color = cc.c3b(255, 255, 255)
							recommendData.showType = "recommend"
						end
					end
				end
			end
		else
			local cardsRecommend = activity:getActivityConfig().BonusHero

			if cardsRecommend then
				for i = 1, #cardsRecommend do
					if cardsRecommend[i] == checkId then
						recommendData.isRecommend = true
						recommendData.order = 1
						recommendData.showType = "attrMark"
					end
				end
			end
		end
	end

	return recommendData
end

function ActivitySystem:getRecommendHeroes(activity)
	local heroSystem = self:getInjector():getInstance("DevelopSystem"):getHeroSystem()
	local allHeroes = heroSystem:getAllHeroIds()
	local list = {}
	local maxList = {}

	for i, v in pairs(allHeroes) do
		local recommendData = self:checkIsRecommend(v, activity)

		if recommendData.isRecommend then
			if recommendData.order == 1 then
				maxList[#maxList + 1] = v
			else
				list[#list + 1] = v
			end
		end
	end

	return list, maxList
end

function ActivitySystem:requestAllActicities(blockUI, callback)
	blockUI = blockUI or true

	local params = {}

	self._activityService:requestAllActicities(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			self:getActivityList():synchronize(response.data.activityMap)
			self:dispatch(Event:new(EVT_ACTIVITY_REFRESH))

			if callback then
				callback(response)
			end
		end
	end)
end

function ActivitySystem:requestActicityById(activityId, callback)
	local params = {}

	params.activityId = activityId

	self._activityService:requestActicityById(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:getActivityList():syncAloneActivity(activityId, response.data)

			if callback then
				callback(response)
			end
		end
	end)
end

function ActivitySystem:requestDoActivity(activityId, param, callback)
	if not self:getVersionCanBuy(activityId) then
		return
	end

	local cjson = require("cjson.safe")
	local params = {}

	params.activityId = activityId
	params.param = param

	self._activityService:requestDoActivity(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_ACTIVITY_REDPOINT_REFRESH, {
				param = param,
				response = response
			}))
		end
	end)
end

function ActivitySystem:getActivityRemainTime1(activityId, endTime)
	local activity = self:getActivityById(activityId)

	if activity then
		local curTime = self._gameServerAgent:remoteTimeMillis()

		endTime = endTime or activity:getEndTime()

		if endTime then
			return math.floor(endTime - curTime)
		end
	end

	return 0
end

function ActivitySystem:requestDoActivity2(activityId, param, callback)
	if not self:getVersionCanBuy(activityId) then
		return
	end

	local cjson = require("cjson.safe")
	local params = {}

	params.activityId = activityId
	params.param = param

	self._activityService:requestDoActivity(params, true, function(response)
		if callback then
			callback(response)
		end

		self:dispatch(Event:new(EVT_ACTIVITY_REDPOINT_REFRESH, {}))
	end)
end

function ActivitySystem:requestDoActivity3(activityId, param, callback)
	if not self:getVersionCanBuy(activityId) then
		return
	end

	local cjson = require("cjson.safe")
	local params = {}

	params.activityId = activityId
	params.param = param

	self._activityService:requestDoActivity(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:getActivityList():syncAloneActivity(activityId, response.data, params.param)

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_ACTIVITY_REDPOINT_REFRESH, {}))
		end
	end)
end

function ActivitySystem:requestDoChildActivity(activityId, subActivityId, param, callback, forceCallback)
	if not self:getVersionCanBuy(activityId) then
		return
	end

	local params = {}

	params.subActivityId = subActivityId
	params.activityId = activityId
	params.param = param

	self._activityService:requestDoChildActivity(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_ACTIVITY_REDPOINT_REFRESH, {}))
		elseif forceCallback and callback then
			callback(response)
		end
	end)
end

function ActivitySystem:getHomeRedPointSta()
	if self:checkEnabled() and self:hasActivitySystemRedPoint() then
		return true
	end

	return false
end

function ActivitySystem:getPlatform()
	return device.platform
end

function ActivitySystem:getVersionCanBuy(activityId)
	local config = ConfigReader:getRecordById("Activity", activityId)

	if config then
		local v = config.Version

		if v then
			local p = self:getPlatform()
			local baseVersion = app.pkgConfig.packJobId

			if baseVersion and v[p] and tonumber(baseVersion) < tonumber(v[p]) then
				local tips = Strings:get("Activity_Version_Tips3")

				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = (config.Type == "EXCHANGE" or nil) and Strings:get("Activity_Version_Tips2")
				}))

				return false
			end
		end
	end

	return true
end

function ActivitySystem:setBattleTeamInfo(team)
	local teamInfo = {
		teamHeroInfo = {}
	}
	local heroIds = team:getHeroes()
	local heroSystem = self:getInjector():getInstance("DevelopSystem"):getHeroSystem()

	for _, v in ipairs(heroIds) do
		local heroInfo = heroSystem:getHeroById(v)

		teamInfo.teamHeroInfo[v] = {
			level = heroInfo:getLevel(),
			exp = heroInfo:getExp()
		}
	end

	self:setBattleTeam(teamInfo)
end

function ActivitySystem:checkPassActivityData()
	local passSystem = self:getInjector():getInstance(PassSystem)

	passSystem:checkPassActivityData()
end

function ActivitySystem:setInitActivityClubBossMark()
	self._initActivityClubBoss = true
end

function ActivitySystem:checkClubBossSummerActivityData()
	if self._initActivityClubBoss == false then
		return
	end

	if self:getBlockSummerActivity() ~= nil then
		local clubSystem = self:getInjector():getInstance(ClubSystem)

		clubSystem:refreshClubBossSummerActivityData()
	end
end

function ActivitySystem:getBlockSummerActivity()
	local resultActivity
	local activityList = self:getAllActivityIds()

	for k, activityId in ipairs(activityList) do
		local activity = self:getActivityById(activityId)

		if activity:getUI() == ActivityType_UI.kActivityBlockSummer then
			resultActivity = activity

			break
		end
	end

	return resultActivity
end

function ActivitySystem:checkComplexActivity(activityId)
	local isOpen = self:isActivityOpen(activityId)
	local isOver = self:isActivityOver(activityId)
	local openCondition = self:checkConditionWithId(activityId)

	return isOpen and not isOver and openCondition
end

function ActivitySystem:complexActivityTryEnter(data)
	local activityId = data.activityId
	local activity = self:getActivityByComplexId(activityId)

	if activity then
		local ui = activity:getActivityComplexUI()

		self:tryEnterComplexMainView(ui)
	end
end

function ActivitySystem:complexActivityTaskTryEnter(data)
	local activityId = data.activityId
	local activity = self:getActivityByComplexId(activityId)

	if activity then
		self:enterSupportTaskView(data.activityId, data.taskId)
	end
end

function ActivitySystem:tryEnterComplexMainView(ui)
	local activity = self:getActivityByComplexUI(ui)

	if activity then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
		self:requestAllActicities(true, function()
			local function enter(rewards)
				local view = self:getInjector():getInstance(ActivityComplexUI.tryEnterComplexMainView[ui])

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
					activityId = activity:getId(),
					rewards = rewards
				}))
			end

			local startStory = activity:getActivityConfig().StartStory

			if startStory and startStory.mapId and startStory.pointId then
				self:onClickPlayStory(activity, startStory.mapId, startStory.pointId, function(rewards)
					enter(rewards)
				end)
			else
				enter()
			end
		end)
	end
end

function ActivitySystem:tryEnterBlockMonsterShopView(data)
	local activityId = data.activityId

	self:enterBlockMonsterShopView(activityId)
end

function ActivitySystem:enterSupportStage(activityId)
	local activity = self:getActivityByComplexId(activityId)

	if activity then
		local ui = activity:getActivityComplexUI()
		local view = self:getInjector():getInstance(ActivityComplexUI.enterSupportStageView[ui])
		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			activityId = activity:getId()
		})

		self:dispatch(event)
	end
end

function ActivitySystem:enterSagaSupportStage(activityId)
	local params = {
		doActivityType = 101
	}

	self:requestDoActivity(activityId, params, function(response)
		local activity = self:getActivityByComplexId(activityId)

		if activity then
			activity:synchronizePeriodsInfo(response.data)

			local ui = activity:getActivityComplexUI()
			local view = self:getInjector():getInstance(ActivityComplexUI.enterSagaSupportStageView[ui])

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
				activityId = activityId
			}))
		end
	end)
end

function ActivitySystem:enterSagaSupportSchedule(activityId)
	local params = {
		doActivityType = 101
	}

	self:requestDoActivity(activityId, params, function(response)
		local activity = self:getActivityByComplexId(activityId)

		if activity then
			activity:synchronizePeriodsInfo(response.data)

			local ui = activity:getActivityComplexUI()
			local view = self:getInjector():getInstance(ActivityComplexUI.enterSagaSupportScheduleView[ui])

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
				activityId = activityId
			}))
		end
	end)
end

function ActivitySystem:enterSupportTaskView(activityId, taskId)
	local activity = self:getActivityByComplexId(activityId)

	if activity then
		local ui = activity:getActivityComplexUI()
		local view = self:getInjector():getInstance(ActivityComplexUI.enterSupportTaskView[ui])

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			activityId = activityId,
			taskId = taskId
		}))
	end
end

function ActivitySystem:enterSagaSupportRankRewardView(activityId, periodId)
	local activity = self:getActivityByComplexId(activityId)

	if activity then
		local ui = activity:getActivityComplexUI()
		local view = self:getInjector():getInstance(ActivityComplexUI.enterSagaSupportRankRewardView[ui])

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			periodId = periodId,
			activityId = activityId
		}))
	end
end

function ActivitySystem:enterSagaWinView(activityId)
	local activity = self:getActivityByComplexId(activityId)

	if activity then
		local ui = activity:getActivityComplexUI()
		local view = self:getInjector():getInstance(ActivityComplexUI.enterSagaWinView[ui])

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, {
			activityId = activityId
		}))
	end
end

function ActivitySystem:enterBlockMap(activityId, blockActivityId, stageType, useThreeChoice)
	local activity = self:getActivityByComplexId(activityId)

	if activity then
		local ui = activity:getActivityComplexUI()
		local view = self:getInjector():getInstance(ActivityComplexUI.enterSupportStageView[ui])
		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			activityId = activityId,
			blockActivityId = blockActivityId,
			stageType = stageType,
			useThreeChoice = useThreeChoice
		})

		self:dispatch(event)
	end
end

function ActivitySystem:enterSelecteZeroMap(activityId)
	local view = self:getInjector():getInstance("ActivityZeroSelectMapView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		activityId = activityId
	}))
end

function ActivitySystem:enterZeroShop(activityId)
	local view = self:getInjector():getInstance("ActivityBlockZeroShopView")
	local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		activityId = activityId
	})

	self:dispatch(event)
end

function ActivitySystem:enterBlockMonsterShopView(activityId)
	local activity = self:getActivityByComplexId(activityId)

	if activity then
		local ui = activity:getActivityComplexUI()
		local view = self:getInjector():getInstance(ActivityComplexUI.enterBlockMonsterShopView[ui])
		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			activityId = activityId
		})

		self:dispatch(event)
	end
end

function ActivitySystem:enterBlockFudaiView(activityId)
	AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

	local function callback()
		local view = self:getInjector():getInstance("ActivityBlockFudaiView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			activityId = activityId
		}))
	end

	self._shopSystem:requestGetPackageShop(callback)
end

function ActivitySystem:tryEnterCoopExchangeView(data)
	local unlock, tips = self:checkEnabled()

	if unlock then
		self:requestAllActicities(true, function()
			if self:checkCoopExchangeEnable(data.activityId) then
				local view = self:getInjector():getInstance("ShopCoopExchangeView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
			else
				self:dispatch(ShowTipEvent({
					duration = 0.35,
					tip = Strings:get("Activity_Not_Found")
				}))
			end
		end)
	else
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = tips
		}))
	end
end

function ActivitySystem:checkCoopExchangeEnable(activityId)
	local activity = self:getActivityById(activityId)

	if activity then
		return activity:getIsTodayOpen()
	end

	return false
end

function ActivitySystem:getFanXingZhiMengActivity()
	local resultActivity
	local activityList = self:getAllActivityIds()

	for k, activityId in ipairs(activityList) do
		local activity = self:getActivityById(activityId)

		if activity:getUI() == ActivityType_UI.KTASKSTAGESTAR then
			resultActivity = activity

			break
		end
	end

	return resultActivity
end

function ActivitySystem:isReturnActivityShow()
	local returnActivity = self:getActivityByComplexUI(ActivityType.KReturn)

	if returnActivity and returnActivity:getIsBackFlow() then
		return true
	end

	return false
end

function ActivitySystem:isReturnLetterDraw()
	local returnActivity = self:getActivityByComplexUI(ActivityType.KReturn)

	if returnActivity then
		local letterActivity = returnActivity:getSubActivityByType(ActivityType.KLetter)

		if letterActivity then
			return letterActivity:getIsDraw()
		end
	end

	return false
end

function ActivitySystem:tryEnterActivityLetter(callback)
	local activity = self:getActivityByComplexUI(ActivityType.KReturn)
	local view = self:getInjector():getInstance("ActivityReturnLetterView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		activityId = activity:getId()
	}, callback))
end

function ActivitySystem:tryEnterActivityReturn()
	self:requestAllActicities(true, function()
		local activity = self:getActivityByComplexUI(ActivityType.KReturn)
		local view = self:getInjector():getInstance("ActivityReturnView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			activityId = activity:getId()
		}))
	end)
end

function ActivitySystem:activityReturnRedPointShow()
	local activity = self:getActivityByComplexUI(ActivityType.KReturn)

	if activity then
		return activity:hasRedPoint()
	end

	return false
end

function ActivitySystem:drawLetterReward(callback)
	local activity = self:getActivityByComplexUI(ActivityType.KReturn)
	local letterActivity = activity:getSubActivityByType(ActivityType.KLetter)
	local params = {
		doActivityType = 101
	}
	local activityId = activity:getId()
	local subActivityId = letterActivity:getId()

	local function callbackFunc(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			local data = response.data.rewards

			if data and next(data) then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = data
				}))
			end
		end
	end

	self:requestDoChildActivity(activityId, subActivityId, params, callbackFunc)
end

function ActivitySystem:requestRecruitActivity(activityId, data, callback)
	local params = {
		doActivityType = 101,
		drawId = data.id,
		times = data.times
	}
	local activityId = activityId

	local function callbackFunc(response)
		if response.resCode == GS_SUCCESS then
			local data = response.data

			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_RECRUIT_SUCC, data))
		else
			self:dispatch(Event:new(EVT_RECRUIT_FAIL))
		end
	end

	self:requestDoActivity(activityId, params, callbackFunc)
end

function ActivitySystem:requestRecruitActivityReward(activityId, subActivityId, data, callback)
	local params = {}

	params.doActivityType = data.doActivityType

	if data.taskId then
		params.taskId = data.taskId
	end

	if data.round then
		params.round = data.round
	end

	if data.TimeReward then
		params.TimeReward = data.TimeReward
	end

	local activityId = activityId

	local function callbackFunc(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			local data = response.data.rewards

			if subActivityId then
				data = response.data.reward
			end

			self:dispatch(Event:new(EVT_RECRUITNEWDRAWCARD_REFRESH))

			if data and next(data) then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = data
				}))
			end
		end
	end

	if subActivityId then
		self:requestDoChildActivity(activityId, subActivityId, params, callbackFunc)
	else
		self:requestDoActivity(activityId, params, callbackFunc)
	end
end

function ActivitySystem:tryEnterTrialRoadMainView(params)
	local activity = self:getActivityById(params.activityId)

	if not activity then
		return
	end

	local view = self:getInjector():getInstance("ActivityTrialRoadView")
	local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		activityId = params.activityId
	})

	self:dispatch(event)
end

function ActivitySystem:tryEnterActivityMailView()
	local activity = self:getActivityById("RiddlePreMail")

	if activity then
		local list = activity:getMailList()

		if #list > 0 then
			local view = self:getInjector():getInstance("ActivityMailView")
			local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {}, nil)

			self:dispatch(event)
		else
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("Activity_Not_Found")
			}))
		end
	else
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = Strings:get("Activity_Not_Found")
		}))
	end
end

function ActivitySystem:onClickPlayStory(activity, subActivityId, pointId, callback)
	local storyPoint = activity:getBlockMapActivity(subActivityId):getPointById(pointId)

	if not storyPoint:isPass() then
		local storyLink = ConfigReader:getDataByNameIdAndKey("ActivityStoryPoint", pointId, "StoryLink")
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local startTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
		local storyAgent = storyDirector:getStoryAgent()

		local function endCallBack()
			self:requestDoChildActivity(activity:getId(), subActivityId, {
				doActivityType = 106,
				pointId = pointId
			}, function(response)
				local gallerySystem = DmGame:getInstance()._injector:getInstance("GallerySystem")

				gallerySystem:setActivityStorySaveStatus(gallerySystem:getStoryIdByStoryLink(storyLink, pointId), true)
				storyDirector:notifyWaiting("story_play_end")
				callback(response.data.reward)
			end)

			local endTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
			local statisticsData = storyAgent:getStoryStatisticsData(storyLink)

			StatisticSystem:send({
				id_first = 1,
				type = "plot_end",
				op_type = "plot_activity",
				point = "plot_end",
				activityid = activity:getTitle(),
				plot_id = storyLink,
				plot_name = storyPoint:getName(),
				totaltime = endTs - startTs,
				detail = statisticsData.detail,
				amount = statisticsData.amount,
				misc = statisticsData.misc
			})
		end

		storyAgent:setSkipCheckSave(true)
		storyAgent:trigger(storyLink, function()
			AudioEngine:getInstance():stopBackgroundMusic()
		end, endCallBack)
	else
		callback()
	end
end

function ActivitySystem:requestLightPuzzleOnePiece(activityId, pieceIndex, callback)
	local param = {
		doActivityType = 101
	}

	if pieceIndex ~= nil then
		param.index = pieceIndex
	else
		return
	end

	self:requestDoActivity(activityId, param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_PUZZLEGAME_REFRESH))
		end
	end)
end

function ActivitySystem:requestGetPuzzleReward(activityId, rewardType, callback)
	local param = {
		doActivityType = 102
	}

	if rewardType ~= nil then
		param.type = rewardType
	else
		return
	end

	self:requestDoActivity(activityId, param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			local rewards = response.data.rewards
			local showRewards = {}

			for i = 1, #rewards do
				if rewards[i].type ~= RewardType.kGalleryMemory then
					table.insert(showRewards, rewards[i])
				end
			end

			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = showRewards
			}))
			self:dispatch(Event:new(EVT_PUZZLEGAME_REFRESH))
		end
	end)
end

function ActivitySystem:requestGetPuzzleTaskReward(activityId, taskId, callback)
	local param = {
		doActivityType = 103
	}

	if taskId ~= nil then
		param.taskId = taskId
	else
		return
	end

	self:requestDoActivity(activityId, param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			local rewards = response.data.reward
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = rewards
			}))
			self:dispatch(Event:new(EVT_PUZZLEGAME_TASK_REFRESH))
		end
	end)
end

function ActivitySystem:getChatActivity()
	local activity = self:getActivityByType(ActivityType.KChatActivity)

	if activity then
		local isOpen = self:isActivityOpen(activity:getId())

		dump(isOpen, "isOpen___53245")

		local isOver = self:isActivityOver(activity:getId())

		dump(isOver, "isOver____5325")

		if isOpen and not isOver then
			return activity
		end
	end

	return nil
end

function ActivitySystem:isChatActivityOpen()
	local unlockSystem = self:getInjector():getInstance(SystemKeeper)
	local specialSceneActivity = self:getChatActivity()

	if specialSceneActivity then
		local curTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimeMillis()

		if curTime > specialSceneActivity:getStartTime() and curTime < specialSceneActivity:getEndTime() then
			return true
		end
	end

	return false
end
