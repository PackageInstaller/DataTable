-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/zero/ActivityZero.lua

EVT_ACTIVITY_ZERO_EXPORTPOINT = "EVT_ACTIVITY_ZERO_EXPORTPOINT"

require("dm.gameplay.activity.model.zero.ActivityZeroMap")
require("dm.gameplay.activity.model.zero.ActivityZeroEvent")

ActivityZero = class("ActivityZero", BaseActivity, _M)

ActivityZero:has("_subActivityMap", {
	is = "r"
})
ActivityZero:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityZero:has("_map", {
	is = "r"
})
ActivityZero:has("_mapList", {
	is = "r"
})
ActivityZero:has("_bigReward", {
	is = "r"
})
ActivityZero:has("_event", {
	is = "r"
})
ActivityZero:has("_blockPoint", {
	is = "r"
})
ActivityZero:has("_team", {
	is = "rw"
})
ActivityZero:has("_curMapId", {
	is = "rw"
})

ActivityZeroEventType = {
	KBonus = "Bonus",
	KBoss = "Boss",
	KBattle = "Battle",
	KEmpty = "Empty",
	KTrans = "Trans",
	KMore = "More",
	KStory = "Story",
	KCoin = "Coin"
}
ActivityZeroEventName = {
	[ActivityZeroEventType.KBattle] = "Battle普通战斗",
	[ActivityZeroEventType.KBoss] = "Boss战斗",
	[ActivityZeroEventType.KBonus] = "Bonus奖励",
	[ActivityZeroEventType.KStory] = "Story剧情",
	[ActivityZeroEventType.KCoin] = "Coin代币奖励",
	[ActivityZeroEventType.KTrans] = "Trans传送",
	[ActivityZeroEventType.KEmpty] = "Empty空",
	[ActivityZeroEventType.KMore] = "More再来投1回骰子"
}
ActivityZeroDiceType = {
	KRandom = 2,
	KFixed = 1
}

function ActivityZero:initialize()
	super.initialize(self)

	self._subActivityMap = {}
	self._map = {}
	self._mapList = {}
	self._bigReward = false
	self._event = {}
	self._blockPoint = {}
	self._curMapId = ""

	self:initMap()
	self:initEvent()
end

function ActivityZero:dispose()
	super.dispose(self)
end

function ActivityZero:initMap()
	local config = ConfigReader:getDataTable("ActivityMonopMap")
	local mapNum = 0
	local firstMapId

	for id, v in pairs(config) do
		self._map[id] = ActivityZeroMap:new(id)
		mapNum = mapNum + 1

		if not firstMapId and v.BeforeMap == "" then
			firstMapId = v.Id
		end
	end

	for i = 1, mapNum do
		table.insert(self._mapList, firstMapId)

		firstMapId = config[firstMapId].NextMap
	end
end

function ActivityZero:getCurTotalPoint()
	local pointNum = 0

	for mapId, map in pairs(self._map) do
		pointNum = pointNum + map:getExplorePoint()
	end

	return pointNum
end

function ActivityZero:initEvent()
	local config = ConfigReader:getDataTable("ActivityMonopEvent")

	for eventId, v in pairs(config) do
		self._event[eventId] = ActivityZeroEvent:new(eventId)
	end
end

function ActivityZero:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.subActivities then
		for id, value in pairs(data.subActivities) do
			local activity = self:getSubActivityById(id)

			if activity then
				activity:synchronize(value)
			else
				local config = ConfigReader:getRecordById("Activity", id)

				if config and ActivityModel[config.Type] then
					activity = ActivityModel[config.Type]:new()

					activity:synchronize(value)

					self._subActivityMap[id] = activity
				end
			end
		end
	end

	if data.monops then
		for id, v in pairs(data.monops) do
			self._map[id]:synchronize(v)
			DmGame:getInstance():dispatch(Event:new(EVT_ACTIVITY_ZERO_EXPORTPOINT))
		end
	end

	if data.bigReward then
		self._bigReward = data.bigReward
	end

	if data.team then
		self._team = self._team or Team:new({})

		self._team:synchronize(data.team)
	end
end

function ActivityZero:reset()
	super.reset(self)

	self._subActivityMap = {}
end

function ActivityZero:getExchangeActivity()
	local activityIds = self:getActivity()

	for i = 1, #activityIds do
		local id = activityIds[i]
		local activity = self:getSubActivityById(id)

		if activity and self:subActivityOpen(id) and activity:getType() == ActivityType.KEXCHANGE then
			return activity
		end
	end

	return nil
end

function ActivityZero:getSubActivityById(id)
	if id then
		return self._subActivityMap[id]
	end
end

function ActivityZero:getBlockMapActivity()
	local activityIds = self:getActivity()

	for i = 1, #activityIds do
		local id = activityIds[i]
		local activity = self:getSubActivityById(id)

		if activity and self:subActivityOpen(id) and activity:getType() == ActivityType.KActivityBlockMap then
			return activity
		end
	end

	return nil
end

function ActivityZero:getTaskActivities()
	local taskActivities = {}
	local activityIds = self:getActivity()

	for i = 1, #activityIds do
		local id = activityIds[i]
		local activity = self:getSubActivityById(id)

		if activity and self:subActivityOpen(id) and activity:getType() == ActivityType.kTASK then
			table.insert(taskActivities, activity)
		end
	end

	return taskActivities
end

function ActivityZero:getExchangeActivity()
	local activityIds = self:getActivity()

	for i = 1, #activityIds do
		local id = activityIds[i]
		local activity = self:getSubActivityById(id)

		if activity and self:subActivityOpen(id) and activity:getType() == ActivityType.KEXCHANGE then
			return activity
		end
	end

	return nil
end

function ActivityZero:hasRedPoint()
	if self:activityHasRedPoint() then
		return true
	end

	local acts = self:getActivity()

	for i = 1, #acts do
		local id = acts[i]

		if self:subActivityHasRedPoint(id) and self:subActivityOpen(id) then
			return true
		end
	end

	return false
end

function ActivityZero:hasBigRewardRedPoint()
	local curTotalPoint = self:getCurTotalPoint()
	local MaxPoint = self:getActivityConfig().TotalPoint
	local isBigReward = self._bigReward

	return not isBigReward and MaxPoint <= curTotalPoint
end

function ActivityZero:subActivityHasRedPoint(id)
	local activity = self:getSubActivityById(id)

	if activity then
		return activity:hasRedPoint()
	end

	return false
end

function ActivityZero:activityHasRedPoint()
	return false
end

function ActivityZero:subActivityOpen(id)
	local activity = self:getSubActivityById(id)

	if activity then
		local curTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimeMillis()

		if curTime < activity:getStartTime() or curTime > activity:getEndTime() or not activity:getIsTodayOpen() then
			return false
		end

		return true
	end

	return false
end

function ActivityZero:subActivityHasNoFinish(id)
	local activity = self:getSubActivityById(id)

	if activity then
		local taskList = activity:getTaskList()

		for index, task in pairs(taskList) do
			local status = task.status

			if status == ActivityTaskStatus.kUnfinish then
				return true
			end
		end
	end

	return false
end

function ActivityZero:getBgPath()
	return string.format("asset/scene/%s.jpg", self:getActivityConfig().Bmg)
end

function ActivityZero:getTitlePath()
	return string.format("%s.png", self:getActivityConfig().Logo)
end

function ActivityZero:getTimeStr()
	if self._timeStr then
		return self._timeStr
	end

	local timeStr = self._config.TimeFactor
	local start = ""
	local end_ = ""

	if timeStr.start then
		start = type(timeStr.start) == "table" and string.split(timeStr.start[1], " ")[1] or string.split(timeStr.start, " ")[1]

		local startTemp = string.split(start, "-")

		start = string.format("%s.%s.%s", startTemp[1], tonumber(startTemp[2]), tonumber(startTemp[3]))
	end

	if timeStr["end"] then
		end_ = string.split(timeStr["end"], " ")[1]

		local endTemp = string.split(end_, "-")

		end_ = string.format("%s.%s.%s", endTemp[1], tonumber(endTemp[2]), tonumber(endTemp[3]))
	end

	self._timeStr = string.format("%s~%s", start, end_)

	return self._timeStr
end

function ActivityZero:getRoleParams()
	return self:getActivityConfig().ModelId
end

function ActivityZero:getResourcesBanner()
	return self:getActivityConfig().ResourcesBanner or {}
end

function ActivityZero:getActivity()
	local actConfig = self:getActivityConfig()

	return actConfig.Activity
end

function ActivityZero:deleteSubActivity(activityMap)
	for activityId, v in pairs(activityMap) do
		if v == 1 then
			self._subActivityMap[activityId] = nil
		else
			local activity = self._subActivityMap[activityId]

			if activity and activity.delete then
				activity:delete(v)
			end
		end
	end
end

function ActivityZero:getMapData(mapId)
	return self._map[mapId]
end

function ActivityZero:getMapList()
	return self._mapList
end

function ActivityZero:getActivityPointItemId()
	return self:getActivityConfig().PointItemId or "IM_Re0ChengjiuDian"
end

function ActivityZero:getMapStepEventData(mapId, stepId)
	local stepData = self._map[mapId]:getStep(stepId)
	local eventId = stepData:getCurEventId()

	return self._event[eventId]
end

function ActivityZero:synchronizeEventInfo(data, callback)
	if data.eventId then
		local event = self._event[data.eventId]
		local eventType = event:getConfig().Type
		local eventConfig = event:getConfig().Config

		if eventType == ActivityZeroEventType.KBattle or eventType == ActivityZeroEventType.KBoss then
			self:enterBattle(data)
		end

		if data.rewards and #data.rewards > 0 then
			local view = DmGame:getInstance()._injector:getInstance("getRewardView")

			DmGame:getInstance():dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = data.rewards
			}))
		end

		if callback then
			callback(data)
		end
	end
end

function ActivityZero:handleEvent(activityId, mapId, eventId, blockUI, callback)
	if eventId then
		local event = self._event[eventId]
		local eventType = event:getConfig().Type
		local eventConfig = event:getConfig().Config

		if eventType == ActivityZeroEventType.KBattle or eventType == ActivityZeroEventType.KBoss then
			local data = {
				activityId = activityId,
				mapId = mapId,
				eventId = eventId,
				pointId = eventConfig
			}
			local view = DmGame:getInstance()._injector:getInstance("ActivityZeroPointDetailView")

			DmGame:getInstance():dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
		else
			self:requestDoEvent(activityId, mapId, eventId, blockUI, callback)
		end
	end
end

function ActivityZero:enterBattle(data)
	local blockPointId = data.blockPointId
	local blockMapId = data.blockMapId
	local activityId = data.activityId
	local eventId = data.eventId
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
	local isAuto, timeScale = DmGame:getInstance()._injector:getInstance(SettingSystem):getSettingModel():getBattleSetting(SettingBattleTypes.kActstage)
	local systemKeeper = DmGame:getInstance()._injector:getInstance("SystemKeeper")
	local canSkip = false
	local skipTime = 0
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
		local function callback(response)
			outSelf:requestLevelMapCallback(response, activityId, blockMapId, blockPointId)
		end

		outSelf:requestLevelMap(activityId, blockMapId, blockPointId, eventId, true, callback)
	end

	function battleDelegate:onPauseBattle(continueCallback, leaveCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if data.opt == BattlePauseResponse.kLeave then
				leaveCallback()
			else
				continueCallback(data.hpShow, data.effectShow)
			end
		end

		local pauseView = DmGame:getInstance()._injector:getInstance("battlePauseView")

		DmGame:getInstance():dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, nil, {}, popupDelegate))
	end

	function battleDelegate:onAMStateChanged(sender, isAuto)
		DmGame:getInstance()._injector:getInstance(SettingSystem):getSettingModel():setBattleSetting(SettingBattleTypes.kActstage, isAuto)
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onSkipBattle()
		return
	end

	function battleDelegate:onBattleFinish(result)
		local realData = battleSession:getResultSummary()

		local function callback(response)
			outSelf:requestFinishMapCallBack(response, activityId, blockMapId, blockPointId)
		end

		outSelf:requestFinishMap(activityId, blockMapId, blockPointId, eventId, realData, true, callback)
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

		local function callback(response)
			outSelf:requestFinishMapCallBack(response, activityId, blockMapId, blockPointId)
		end

		outSelf:requestFinishMap(activityId, blockMapId, blockPointId, eventId, realData, true, callback)
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		DmGame:getInstance()._injector:getInstance(SettingSystem):getSettingModel():setBattleSetting(SettingBattleTypes.kActstage, nil, timeScale)
	end

	function battleDelegate:showBossCome(pauseFunc, resumeCallback, paseSta)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if resumeCallback then
				resumeCallback()
			end
		end

		local bossView = DmGame:getInstance()._injector:getInstance("battleBossComeView")

		DmGame:getInstance():dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
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

		local view = DmGame:getInstance()._injector:getInstance("battlerofessionalRestraintView")

		DmGame:getInstance():dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, popupDelegate))
	end

	local bgRes = ConfigReader:getDataByNameIdAndKey("ActivityBlockPoint", blockPointId, "Background") or "battle_scene_1"
	local BGM = ConfigReader:getDataByNameIdAndKey("ActivityBlockPoint", blockPointId, "BGM")
	local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
	local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
	local var_32_0 = {
		battleType = battleSession:getBattleType(),
		battleData = battleData,
		battleConfig = battleConfig,
		isReplay = isReplay,
		logicInfo = logicInfo,
		delegate = battleDelegate
	}
	local var_32_1 = {
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

	var_32_1.hpShow = DmGame:getInstance()._injector:getInstance(SettingSystem):getSettingModel():getHpShowSetting()
	var_32_1.effectShow = DmGame:getInstance()._injector:getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
	var_32_1.passiveSkill = battlePassiveSkill
	var_32_1.unlockMasterSkill = DmGame:getInstance()._injector:getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
	var_32_1.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("crusade")
	var_32_1.changeMaxNum = ConfigReader:getDataByNameIdAndKey("ActivityBlockPoint", blockPointId, "BossRound") or 1

	local var_32_2 = {
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
	local var_32_3 = {}

	var_32_3.visible = DmGame:getInstance()._injector:getInstance(SystemKeeper):canShow("Button_CombateDominating")
	var_32_3.lock = not DmGame:getInstance()._injector:getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
	var_32_2.restraint = var_32_3
	var_32_1.btnsShow = var_32_2
	var_32_0.viewConfig = var_32_1
	var_32_0.loadingType = LoadingType.KActivity

	local data = var_32_0

	BattleLoader:pushBattleView(self, data, nil, true)
end

function ActivityZero:requestFinishMapCallBack(response, activityId, blockMapId, blockPointId)
	local function finishCallBack()
		local data = response.data

		data.activityId = activityId
		data.mapId = blockMapId
		data.pointId = blockPointId
		data.model = self

		if data.pass then
			local function endFunc()
				DmGame:getInstance():dispatch(ViewEvent:new(EVT_SHOW_POPUP, DmGame:getInstance()._injector:getInstance("ActivityStageFinishView"), {}, data, self))
			end

			local storyLink = ConfigReader:getDataByNameIdAndKey("ActivityBlockPoint", data.pointId, "StoryLink")
			local storynames = storyLink and storyLink.win
			local storyDirector = DmGame:getInstance()._injector:getInstance(story.StoryDirector)
			local storyAgent = storyDirector:getStoryAgent()

			storyAgent:setSkipCheckSave(false)
			storyAgent:trigger(storynames, nil, endFunc)
		else
			DmGame:getInstance():dispatch(ViewEvent:new(EVT_SHOW_POPUP, DmGame:getInstance()._injector:getInstance("ActivityStageUnFinishView"), {}, data, self))
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

		local view = DmGame:getInstance()._injector:getInstance("AlertView")

		DmGame:getInstance():dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	else
		finishCallBack()
	end
end

function ActivityZero:requestLevelMapCallback(response, activityId, blockMapId, blockPointId)
	local data = response.data

	data.activityId = activityId
	data.mapId = blockMapId
	data.pointId = blockPointId
	data.activeLeave = true
	data.model = self

	DmGame:getInstance():dispatch(ViewEvent:new(EVT_SHOW_POPUP, DmGame:getInstance()._injector:getInstance("ActivityStageUnFinishView"), {}, data))
end

function ActivityZero:getPointById(pointId, mapId)
	self._blockPoint[pointId] = self._blockPoint[pointId] or ActivityStagePoint:new(pointId)

	local hpRate = self:getMapData(mapId):getBossRate()

	self._blockPoint[pointId]:setHpRate(hpRate)
	self._blockPoint[pointId]:setIndex("")

	return self._blockPoint[pointId]
end

function ActivityZero:requestDoEvent(activityId, mapId, eventId, blockUI, callback)
	local params = {
		doActivityType = 101,
		mapId = mapId,
		eventId = eventId
	}

	self._activitySystem:requestDoActivity(activityId, params, function(response)
		if response.resCode == GS_SUCCESS then
			self:synchronizeEventInfo(response.data, callback)
		end
	end)
end

function ActivityZero:requestThrowDice(activityId, mapId, type, point, blockUI, callback)
	local params = {
		doActivityType = 102,
		mapId = mapId,
		type = type,
		point = point
	}

	self._activitySystem:requestDoActivity(activityId, params, function(response)
		if response.resCode == GS_SUCCESS and (response.data and response.data.rewards and #response.data.rewards > 0 and false or callback) then
			callback(response.data)
		end
	end)
end

function ActivityZero:requestEmbattle(activityId, heroes, masterId, blockUI, callback)
	local params = {
		doActivityType = 103,
		heroes = heroes,
		masterId = masterId
	}

	self._activitySystem:requestDoActivity(activityId, params, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data)
		end
	end)
end

function ActivityZero:requestFinishMap(activityId, mapId, pointId, eventId, resultData, blockUI, callback)
	local params = {
		doActivityType = 104,
		mapId = mapId,
		pointId = pointId,
		eventId = eventId,
		resultData = resultData
	}

	self._activitySystem:requestDoActivity(activityId, params, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response)
		end
	end)
end

function ActivityZero:requestLevelMap(activityId, mapId, pointId, eventId, blockUI, callback)
	local params = {
		doActivityType = 105,
		mapId = mapId,
		pointId = pointId,
		eventId = eventId
	}

	self._activitySystem:requestDoActivity(activityId, params, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response)
		end
	end)
end

function ActivityZero:requestGetPointReward(activityId, mapId, explorePointStr, blockUI, callback)
	local params = {
		doActivityType = 106,
		mapId = mapId,
		explorePointStr = explorePointStr
	}

	self._activitySystem:requestDoActivity(activityId, params, function(response)
		if response.resCode == GS_SUCCESS then
			if response.data and response.data.rewards and #response.data.rewards > 0 then
				local view = DmGame:getInstance()._injector:getInstance("getRewardView")

				DmGame:getInstance():dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = response.data.rewards
				}))
			end

			if callback then
				callback(response.data)
			end
		end
	end)
end

function ActivityZero:requestGetResultReward(activityId, blockUI, callback)
	local params = {
		doActivityType = 107
	}

	self._activitySystem:requestDoActivity(activityId, params, function(response)
		if response.resCode == GS_SUCCESS then
			if response.data and response.data.rewards and #response.data.rewards > 0 then
				local view = DmGame:getInstance()._injector:getInstance("getRewardView")

				DmGame:getInstance():dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = response.data.rewards
				}))
			end

			if callback then
				callback(response.data)
			end
		end
	end)
end
