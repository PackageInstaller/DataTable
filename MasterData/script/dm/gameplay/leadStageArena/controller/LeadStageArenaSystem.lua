-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/controller/LeadStageArenaSystem.lua

require("dm.gameplay.leadStageArena.model.LeadStageArena")

LeadStageArenaSystem = class("LeadStageArenaSystem", legs.Actor)

LeadStageArenaSystem:has("_leadStageArenaService", {
	is = "r"
}):injectWith("LeadStageArenaService")
LeadStageArenaSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
LeadStageArenaSystem:has("_leadStageArena", {
	is = "r"
})
LeadStageArenaSystem:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
LeadStageArenaSystem:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
LeadStageArenaSystem:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

EVT_LEADSTAGE_AEANA_SEASONINFO = "EVT_LEADSTAGE_AEANA_SEASONINFO"
EVT_LEADSTAGE_AEANA_REFRESH_INFO = "EVT_LEADSTAGE_AEANA_REFRESH_INFO"

function LeadStageArenaSystem:initialize()
	super.initialize(self)

	self._leadStageArena = LeadStageArena:new()
	self._oldCoinAdd = 0
end

function LeadStageArenaSystem:tryEnter()
	if CommonUtils.GetSwitch("fn_arena_leadStage") then
		local systemKeeper = self:getInjector():getInstance("SystemKeeper")
		local unlock, tips = systemKeeper:isUnlock("StageArena")

		if unlock then
			local status = self._leadStageArena:getCurStatus()

			if status == LeadStageArenaState.KReset then
				self:requestGetSeasonInfo(function()
					local status = self:getArenaState()

					if status == LeadStageArenaState.KNoSeason then
						self:dispatch(ShowTipEvent({
							tip = Strings:get("StageArena_EntryUI03")
						}))

						return
					elseif status == LeadStageArenaState.KReset then
						self:dispatch(ShowTipEvent({
							tip = Strings:get("StageArena_EntryUI02")
						}))

						return
					else
						self:enterMainView()
					end
				end, false)
			else
				self:enterMainView()
			end
		else
			self:dispatch(ShowTipEvent({
				tip = tips
			}))
		end
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ClubNew_UI_37")
		}))
	end
end

function LeadStageArenaSystem:enterMainView()
	self:requestGetMainInfo(function()
		local status = self:getArenaState()

		if status == LeadStageArenaState.KNoSeason then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("StageArena_EntryUI03")
			}))

			return
		end

		if status == LeadStageArenaState.KReset then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("StageArena_EntryUI02")
			}))

			return
		end

		local view = self:getInjector():getInstance("LeadStageArenaMainView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
	end)
end

function LeadStageArenaSystem:requestBeginBattle(rivalId, times, callback, blockUI)
	local params = {}

	params.rivalId = rivalId
	params.times = self._developSystem:getPlayer():getPlayerStageArena().times

	dump(params, "requestBeginBattle", 2)
	self._leadStageArenaService:requestBeginBattle(params, function(response)
		if response.resCode == GS_SUCCESS then
			self:enterBattleChallenge(rivalId, response.data.battleData)
		elseif callback then
			callback()
		end
	end, blockUI)
end

function LeadStageArenaSystem:requestFinishBattle(rivalId, resultData, callback, blockUI, isLeaveBattle)
	local var_8_0 = {
		rivalId = rivalId
	}

	var_8_0.times = self._developSystem:getPlayer():getPlayerStageArena().times
	var_8_0.battleResult = resultData
	var_8_0.leaveBattle = isLeaveBattle or false

	local params = var_8_0

	dump(params, "requestFinishBattle", 2)
	self._leadStageArenaService:requestFinishBattle(params, function(response)
		if response.resCode == GS_SUCCESS then
			local view = self:getInjector():getInstance("LeadStageAreaBattleFinishView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, response.data))
		end
	end, blockUI)
end

function LeadStageArenaSystem:requestQuickBeginBattle(rivalId, resultData, callback, blockUI, isLeaveBattle)
	local params = {
		rivalId = rivalId
	}

	dump(params, "requestQuickBeginBattle", 2)
	self._leadStageArenaService:requestQuickBeginBattle(params, function(response)
		if response.resCode == GS_SUCCESS then
			dump(response)

			response.data.isQuickBattle = true

			local view = self:getInjector():getInstance("LeadStageAreaBattleFinishView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, response.data))
		end
	end, blockUI)
end

function LeadStageArenaSystem:getThePrice()
	local times = self._developSystem:getPlayer():getPlayerStageArena().buyEnergeTimes
	local value = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageArena_Price", "content")

	if not value[times + 1] then
		return value[times + 1]
	end
end

function LeadStageArenaSystem:requestBuyTimes()
	local params = {}

	self._leadStageArenaService:requestBuyTimes(params, function(response)
		if response.resCode == GS_SUCCESS then
			dump(response)
			self:dispatch(ShowTipEvent({
				tip = Strings:get("StageArena_PartyUI31")
			}))
		end
	end, blockUI)
end

function LeadStageArenaSystem:enterBattleChallenge(rivalId, data)
	local isReplay = false
	local canSkip = true
	local outSelf, battleDelegate = self, {}
	local battleSession = StageArenaBattleSession:new(data)

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
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(SettingBattleTypes.kStageArena)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("AutoFight")

	if not unlock then
		isAuto = false
	end

	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local speedOpenSta = systemKeeper:getBattleSpeedOpen("stagearena")
	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter,
		teams = battleSession:genTeamAiInfo(),
		mainPlayerId = {
			data.playerData.rid
		}
	}
	local skipTime = tonumber(ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageArena_SkipBattle_WaitTime", "content"))

	function battleDelegate:onLeavingBattle()
		if battleSession then
			local realData = battleSession:getExitSummary()

			outSelf:requestFinishBattle(rivalId, battleSession, true, true, true)
		end
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

		local pauseView = outSelf:getInjector():getInstance("battlePauseView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, nil, {}, popupDelegate))
	end

	function battleDelegate:onAMStateChanged(sender, isAuto)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(SettingBattleTypes.kStageArena, isAuto)
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onSkipBattle()
		outSelf:requestFinishBattle(rivalId, realData, callback)
	end

	function battleDelegate:onBattleFinish(result)
		local realData = battleSession:getResultSummary()

		local function callback(response, rewards)
			return
		end

		outSelf:requestFinishBattle(rivalId, realData, callback)
	end

	function battleDelegate:onDevWin()
		self:onSkipBattle()
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(SettingBattleTypes.kStageArena, nil, timeScale)
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

	function battleDelegate:showMaster(friend, enemy, pauseFunc, resumeCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if resumeCallback then
				resumeCallback()
			end
		end

		local bossView = outSelf:getInjector():getInstance("MasterCutInView")
		local matchIndex = outSelf._developSystem:getPlayer():getPlayerStageArena().times
		local titles = {
			"StageArena_PartyUI20",
			"StageArena_PartyUI21",
			"StageArena_PartyUI22"
		}

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
			friend = friend,
			enemy = enemy,
			title = (titles[matchIndex] or nil) and Strings:get(titles[matchIndex])
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

	local bgRes = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ArenaStage_Background", "content") or "battle_scene_1"
	local BGM = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Music_BattleBGM_Arena", "content")
	local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
	local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
	local var_15_0 = {
		battleType = battleSession:getBattleType(),
		battleData = battleData,
		battleConfig = battleConfig,
		isReplay = isReplay,
		logicInfo = logicInfo,
		delegate = battleDelegate
	}
	local var_15_1 = {
		opPanelClazz = "BattleUIMediator",
		mainView = "battlePlayer",
		opPanelRes = "asset/ui/BattleUILayer.csb",
		canChangeSpeedLevel = true,
		finalHitShow = true,
		battleSettingType = SettingBattleTypes.kArena,
		bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVP_StageArena"),
		bgm = BGM,
		background = bgRes,
		refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
		battleSuppress = BattleDataHelper:getBattleSuppress()
	}

	var_15_1.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
	var_15_1.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
	var_15_1.passiveSkill = battlePassiveSkill
	var_15_1.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
	var_15_1.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("arena_challenge")

	local var_15_2 = {}
	local var_15_3 = {}

	var_15_3.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
	var_15_3.lock = not unlockSpeed
	var_15_3.tip = tipsSpeed
	var_15_3.speedConfig = battleSpeed_Actual
	var_15_3.speedShowConfig = battleSpeed_Display
	var_15_3.timeScale = timeScale
	var_15_2.speed = var_15_3
	var_15_2.skip = {
		enable = true,
		waitTips = "ARENA_SKIP_TIP",
		visible = canSkip,
		skipTime = skipTime
	}

	local var_15_4 = {
		enable = false,
		state = true,
		lock = true
	}

	var_15_4.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
	var_15_2.auto = var_15_4
	var_15_2.pause = {
		enable = true,
		visible = true
	}

	local var_15_5 = {}

	var_15_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
	var_15_5.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
	var_15_2.restraint = var_15_5
	var_15_1.btnsShow = var_15_2
	var_15_0.viewConfig = var_15_1
	var_15_0.loadingType = LoadingType.kLeadStageArena

	local data = var_15_0

	BattleLoader:pushBattleView(self, data, nil, true)
end

function LeadStageArenaSystem:enterBattleReoprt(defenderId, battleSummery, replayIndex)
	local outSelf = self
	local battleDelegate = {
		_replayIndex = replayIndex or 1
	}
	local cjson = require("cjson.safe")
	local battleData = cjson.decode(battleSummery.battleResultMap["STAGE_ARENA_" .. battleDelegate._replayIndex])
	local selfRid = outSelf:getDevelopSystem():getPlayer():getRid()
	local isReplay = true
	local skipTime = tonumber(ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageArena_SkipBattle_WaitTime", "content"))
	local battleRecorder = BattleRecorder:new():restoreRecords(battleData.timelines)
	local battleInterpreter = BattleInterpreter:new()

	battleInterpreter:setRecordsProvider(battleRecorder)

	local battleDirector = LocalBattleDirector:new()

	battleDirector:setBattleInterpreter(battleInterpreter)

	local battlePassiveSkill = battleData.passiveSkill
	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter
	}
	local defenderId = battleSummery.fightRecordMap[tostring(battleDelegate._replayIndex)].rivalId

	logicInfo.mainPlayerId = selfRid == defenderId and defenderId or selfRid

	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("Arena_SkipBattleCountdown")
	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local speedOpenSta = systemKeeper:getBattleSpeedOpen("stagearena")
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(SettingBattleTypes.kStageArena)

	function battleDelegate:onLeavingBattle()
		self._replayIndex = 3

		local view = outSelf:getInjector():getInstance("LeadStageAreaBattleFinishView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, self:getSummary()))
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

		local pauseView = outSelf:getInjector():getInstance("battlePauseView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, nil, {}, popupDelegate))
	end

	function battleDelegate:getSummary()
		if not self._replayIndex then
			local summer = {}

			for k, v in pairs(battleSummery) do
				if k ~= "fightRecordMap" then
					summer[k] = v
				end
			end

			summer.fightRecordMap = {}
			summer.winTimes = 0
			summer.loseTimes = 0

			local rid = outSelf._developSystem:getPlayer():getRid()

			for i = 1, self._replayIndex do
				summer.fightRecordMap[tostring(i)] = battleSummery.fightRecordMap[tostring(i)]

				if battleSummery.fightRecordMap[tostring(i)].winRid == rid then
					summer.winTimes = summer.winTimes + 1
				else
					summer.loseTimes = summer.loseTimes + 1
				end
			end

			summer.playNextReport = self.playNextReport
			summer.playNextReportSender = self
			summer.reportMode = true
			summer.isWatch = true

			return summer
		end
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:playNextReport()
		self._replayIndex = self._replayIndex + 1

		outSelf:enterBattleReoprt(challengerId, battleSummery, self._replayIndex)
	end

	function battleDelegate:onSkipBattle()
		local view = outSelf:getInjector():getInstance("LeadStageAreaBattleFinishView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, self:getSummary()))
	end

	function battleDelegate:onBattleFinish(result)
		local view = outSelf:getInjector():getInstance("LeadStageAreaBattleFinishView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, self:getSummary()))
	end

	function battleDelegate:onDevWin()
		self:onSkipBattle()
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(SettingBattleTypes.kArena, nil, timeScale)
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

	function battleDelegate:onShowRestraint(continueCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender)
			continueCallback()
		end

		local view = outSelf:getInjector():getInstance("battlerofessionalRestraintView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, popupDelegate))
	end

	local bgRes = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ArenaStage_Background", "content") or "battle_scene_1"
	local BGM = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Music_BattleBGM_Arena", "content")
	local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
	local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
	local var_32_0 = {
		battleRecords = battleData.timelines,
		isReplay = isReplay,
		logicInfo = logicInfo,
		delegate = battleDelegate
	}
	local var_32_1 = {
		mainView = "battlePlayer",
		opPanelRes = "asset/ui/BattleUILayer.csb",
		canChangeSpeedLevel = true,
		opPanelClazz = "BattleUIMediator",
		finalHitShow = true,
		bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVP_Arena"),
		bgm = BGM,
		background = bgRes,
		refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
		battleSuppress = BattleDataHelper:getBattleSuppress()
	}

	var_32_1.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
	var_32_1.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
	var_32_1.passiveSkill = battlePassiveSkill
	var_32_1.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
	var_32_1.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("arena_challenge")

	local var_32_2 = {}
	local var_32_3 = {}

	var_32_3.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
	var_32_3.lock = not unlockSpeed
	var_32_3.tip = tipsSpeed
	var_32_3.speedConfig = battleSpeed_Actual
	var_32_3.speedShowConfig = battleSpeed_Display
	var_32_3.timeScale = timeScale
	var_32_2.speed = var_32_3
	var_32_2.skip = {
		enable = true,
		waitTips = "ARENA_SKIP_TIP",
		visible = (not unlock or nil) and false,
		skipTime = skipTime
	}

	local var_32_4 = {
		enable = false,
		lock = true
	}

	var_32_4.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
	var_32_2.auto = var_32_4
	var_32_2.pause = {
		enable = true,
		visible = true
	}

	local var_32_5 = {}

	var_32_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
	var_32_5.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
	var_32_2.restraint = var_32_5
	var_32_1.btnsShow = var_32_2
	var_32_0.viewConfig = var_32_1
	var_32_0.loadingType = LoadingType.kLeadStageArena

	local data = var_32_0

	BattleLoader:pushBattleView(self, data, nil, true)
end

function LeadStageArenaSystem:checkShowRed()
	if not CommonUtils.GetSwitch("fn_arena_leadStage") then
		return false
	end

	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("StageArena")

	if not unlock then
		return false
	end

	local status = self:getArenaState()

	if status == LeadStageArenaState.KShow then
		return self:checkRewardRedpoint()
	end

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason then
		return false
	end

	if self:checkIsNewseason() then
		return true
	end

	if self:checkPowerShowRed() then
		return true
	end

	if self:checkRewardRedpoint() then
		return true
	end

	return false
end

function LeadStageArenaSystem:checkIsNewseason()
	local status = self:getArenaState()

	if status == LeadStageArenaState.kFighting then
		local playerId = self:getDevelopSystem():getPlayer():getRid()

		if not cc.UserDefault:getInstance():getStringForKey(playerId .. UserDefaultKey.KLeadStageAreanaNewSeasonKey) then
			local seasonId = ""
			local curSeasonId = self._leadStageArena:getSeasonId()

			return curSeasonId ~= seasonId
		end
	end

	return false
end

function LeadStageArenaSystem:setNewSeasonKeyValue()
	local playerId = self:getDevelopSystem():getPlayer():getRid()
	local curSeasonId = self._leadStageArena:getSeasonId()

	cc.UserDefault:getInstance():setStringForKey(playerId .. UserDefaultKey.KLeadStageAreanaNewSeasonKey, curSeasonId)
end

function LeadStageArenaSystem:checkPowerShowRed()
	local bagSystem = self._developSystem:getBagSystem()
	local curPower, lastRecoverTime = bagSystem:getPowerByCurrencyId(CurrencyIdKind.kStageArenaPower)

	return curPower >= self:getStageArenaPowerLimit()
end

function LeadStageArenaSystem:checkRewardRedpoint()
	return self._taskSystem:hasUnreceivedTask(TaskType.kStageArena)
end

function LeadStageArenaSystem:getRewardConfigInfo()
	return self._leadStageArena:getRewardConfigInfo()
end

function LeadStageArenaSystem:getArenaState()
	local curSeasonId = self._leadStageArena:getSeasonId()

	if curSeasonId == "" then
		return LeadStageArenaState.KNoSeason
	end

	local gameServerAgent = self:getInjector():getInstance(GameServerAgent)
	local currentTime = gameServerAgent:remoteTimestamp()

	if currentTime < self._leadStageArena:getStartTime() then
		return LeadStageArenaState.KReset
	end

	if currentTime >= self._leadStageArena:getStartTime() and currentTime <= self._leadStageArena:getEndTime() then
		return LeadStageArenaState.kFighting
	end

	if currentTime <= self._leadStageArena:getCloseTime() then
		return LeadStageArenaState.KShow
	end

	return LeadStageArenaState.KReset
end

function LeadStageArenaSystem:getOldCoin()
	return self._developSystem:getStageArenaStage().rlyehCoin - self._oldCoinAdd
end

function LeadStageArenaSystem:setOldCoinAdd(coin)
	self._oldCoinAdd = coin
end

function LeadStageArenaSystem:getOldCoinAdd()
	return self._oldCoinAdd
end

function LeadStageArenaSystem:getRivalHidden()
	local ret = {}
	local data = self._developSystem:getStageArenaStage().rivalHidden

	for k, v in pairs(data) do
		ret[k + 1] = v
	end

	return ret
end

function LeadStageArenaSystem:enterShopView()
	self._shopSystem:tryEnter({
		shopId = "Shop_Normal"
	})
end

function LeadStageArenaSystem:enterRivalView()
	local status = self:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason or status == LeadStageArenaState.KShow then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	local view = self:getInjector():getInstance("LeadStageArenaRivalView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
end

function LeadStageArenaSystem:enterTeamListView(cheerNum)
	self:requestCheers({
		battleCount = cheerNum
	}, function()
		local view = self:getInjector():getInstance("LeadStageArenaTeamListView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
	end)
end

function LeadStageArenaSystem:enterTeamView(teamIndex)
	local view = self:getInjector():getInstance("LeadStageArenaTeamView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		teamIndex = teamIndex,
		outself = self
	}))
end

function LeadStageArenaSystem:enterReportView()
	self:requestBattleReportList(function()
		local view = self:getInjector():getInstance("LeadStageArenaReportView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
	end)
end

function LeadStageArenaSystem:getConfigLevelLimit()
	local config = self._leadStageArena:getConfig()

	if config and next(config) then
		return config.ConfigLevelLimitID
	end

	return ""
end

function LeadStageArenaSystem:getStageArenaPowerLimit()
	return ConfigReader:getRecordById("ConfigValue", "StageArena_RedPoint_Num").content
end

function LeadStageArenaSystem:getSeasonNextCD()
	local status = self._leadStageArena:getCurStatus()

	if status == LeadStageArenaState.KReset then
		return self._leadStageArena:getStartTime()
	end

	return -1
end

function LeadStageArenaSystem:getOwnTeams()
	local ownTeamInfo = {}

	for i = 1, 3 do
		local teamInfo = self._developSystem:getSpTeamByType(StageTeamType["STAGE_ARENA_" .. i])

		ownTeamInfo[i] = {}
		ownTeamInfo[i].masterId = teamInfo:getMasterId()
		ownTeamInfo[i].heroes = teamInfo:getHeroes()
		ownTeamInfo[i].teamIndex = i
		ownTeamInfo[i].teamId = "STAGE_ARENA_" .. i
	end

	return ownTeamInfo
end

function LeadStageArenaSystem:getNotOnTeamPet(ids, teamIndex)
	local heroSystem = self:getDevelopSystem():getHeroSystem()
	local allPet = heroSystem:getAllHeroIds()
	local notOnTeamPet = {}
	local checkIds = table.copy(ids, {})
	local ownTeamInfo = self:getOwnTeams()

	for i, teamInfo in ipairs(ownTeamInfo) do
		if i ~= teamIndex then
			for i, v in ipairs(teamInfo.heroes) do
				table.insert(checkIds, v)
			end
		end
	end

	for i = 1, #allPet do
		local id = allPet[i]
		local index = table.indexof(checkIds, id)

		if index then
			table.remove(checkIds, index)
		else
			notOnTeamPet[#notOnTeamPet + 1] = id
		end
	end

	return notOnTeamPet
end

function LeadStageArenaSystem:enterRewardView()
	local data = {}
	local view = self:getInjector():getInstance("LeadStageArenaRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, nil))
end

function LeadStageArenaSystem:getReportList()
	return self._leadStageArena:getReportList()
end

function LeadStageArenaSystem:getConfig()
	return self._leadStageArena:getConfig()
end

function LeadStageArenaSystem:checkSeasonData(callback)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("StageArena")

	if unlock then
		self:requestGetSeasonInfo(callback, false)
	elseif callback then
		callback()
	end
end

function LeadStageArenaSystem:requestGetSeasonInfo(callback, blockUI)
	self._leadStageArenaService:requestGetSeasonInfo({}, function(response)
		if response.resCode == GS_SUCCESS then
			self._leadStageArena:synchronize(response.data)

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_LEADSTAGE_AEANA_SEASONINFO))
		end
	end, blockUI)
end

function LeadStageArenaSystem:requestGetMainInfo(callback, blockUI)
	self._leadStageArenaService:requestGetMainInfo({}, function(response)
		if response.resCode == GS_SUCCESS then
			self._leadStageArena:synchronize(response.data)

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_LEADSTAGE_AEANA_SEASONINFO))
		end
	end, blockUI)
end

function LeadStageArenaSystem:requestRefreshRival(callback, blockUI)
	self._leadStageArenaService:requestRefreshRival({}, function(response)
		if response.resCode == GS_SUCCESS then
			self._leadStageArena:synchronize({
				rival = response.data
			})

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_LEADSTAGE_AEANA_REFRESH_INFO))
		end
	end, blockUI)
end

function LeadStageArenaSystem:requestSpeedUp(callback, blockUI)
	self._leadStageArenaService:requestSpeedUp({}, function(response)
		if response.resCode == GS_SUCCESS then
			self._leadStageArena:synchronize(response.data)

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_LEADSTAGE_AEANA_SEASONINFO))
		end
	end, blockUI)
end

function LeadStageArenaSystem:getEnterErrorCode()
	return self._enterErrorCode
end

function LeadStageArenaSystem:requestEnter(callback, blockUI)
	self._enterErrorCode = 1

	self._leadStageArenaService:requestEnter({}, function(response)
		self._enterErrorCode = response.resCode

		if response.resCode == GS_SUCCESS then
			self._leadStageArena:synchronize({
				rival = response.data
			})

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_LEADSTAGE_AEANA_SEASONINFO))
		end
	end, blockUI)
end

function LeadStageArenaSystem:requestCheers(param, callback, blockUI)
	self._leadStageArenaService:requestCheers(param, function(response)
		if response.resCode == GS_SUCCESS then
			self._leadStageArena:synchronize({
				teams = response.data
			})

			if callback then
				callback(response)
			end
		end
	end, blockUI)
end

function LeadStageArenaSystem:requestLineUp(param, callback, blockUI)
	self._leadStageArenaService:requestLineUp({
		teams = param
	}, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_LEADSTAGE_AEANA_SEASONINFO))

			if callback then
				callback(response)
			end
		end
	end, blockUI)
end

function LeadStageArenaSystem:requestBattleReportList(callback, blockUI)
	local params = {}

	self._leadStageArenaService:requestBattleReportList(params, function(response)
		if response.resCode == GS_SUCCESS then
			for i = 1, #response.data do
				response.data[i].nickname = self._developSystem:getNickName()
				response.data[i].headImg = self._developSystem:getheadId()
				response.data[i].level = self._developSystem:getLevel()
			end

			self._leadStageArena:syncReportList(response.data)
		end

		if callback then
			callback(response)
		end
	end, blockUI)
end

function LeadStageArenaSystem:requestBattleReport(reportId, callback, blockUI)
	local status = self:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	local params = {}

	params.reportId = reportId

	self._leadStageArenaService:requestBattleReport(params, function(response)
		if response.resCode == GS_SUCCESS then
			local reportData = self._leadStageArena:getReportById(response.data.reportId)

			self:enterBattleReoprt(reportData.rid, response.data)
		end

		if callback then
			callback(response)
		end
	end, blockUI)
end

function LeadStageArenaSystem:stageArenaOpen()
	if CommonUtils.GetSwitch("fn_arena_leadStage") then
		local systemKeeper = self:getInjector():getInstance("SystemKeeper")
		local unlock, tips = systemKeeper:isUnlock("StageArena")

		if unlock then
			return self._leadStageArena:getCurStatus() ~= LeadStageArenaState.KReset
		end
	end

	return false
end

function LeadStageArenaSystem:stageArenaState()
	return self._leadStageArena:getCurStatus() == LeadStageArenaState.kFighting
end
