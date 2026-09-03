-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/newArena/controller/ArenaNewSystem.lua

require("dm.gameplay.newArena.model.ArenaNew")
require("dm.gameplay.newArena.view.AreanaNewLoadingModel")

ArenaNewSystem = class("ArenaNewSystem", Facade, _M)

ArenaNewSystem:has("_arenaNewService", {
	is = "r"
}):injectWith("ArenaNewService")
ArenaNewSystem:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ArenaNewSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ArenaNewSystem:has("_arenaNew", {
	is = "r"
})
ArenaNewSystem:has("_showViewAfterBattle", {
	is = "rw"
})
ArenaNewSystem:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

EVT_NEW_ARENA_FRESH_RIVAL = "EVT_NEW_ARENA_FRESH_RIVAL"
EVT_NEW_ARENA_OFFLINE_REPORT = "EVT_NEW_ARENA_OFFLINE_REPORT"
EVT_NEW_ARENA_MAIN_INFO = "EVT_NEW_ARENA_MAIN_INFO"
EVT_NEW_ARENA_REWAERD_INFO = "EVT_NEW_ARENA_REWAERD_INFO"

function ArenaNewSystem:initialize()
	self._arenaNew = ArenaNew:new()
	self._showViewAfterBattle = "ArenaNewView"

	super.initialize(self)
end

function ArenaNewSystem:tryEnter(data)
	if not CommonUtils.GetSwitch("fn_arena_new") then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_ArenaClose")
		}))

		return
	end

	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("ChessArena_System")

	if not unlock then
		self:dispatch(ShowTipEvent({
			tip = tips
		}))

		return
	end

	local function getDataSucc(response)
		if response.resCode == GS_SUCCESS then
			if not self:getSeasonData() then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("ClassArena_UI77")
				}))

				return
			end

			local curTime = self._gameServerAgent:remoteTimestamp()
			local remainTime = self:getEndTime() - curTime

			if remainTime < 1 then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("ClassArena_UI77")
				}))

				return
			end

			local view = self:getInjector():getInstance("ArenaNewView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
		end
	end

	self:requestGainChessArena(getDataSucc, true)
end

function ArenaNewSystem:checkSeasonData(callback)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("ChessArena_System")

	if unlock then
		self:requestMainInfoChessArena(callback, false)
	elseif callback then
		callback()
	end
end

function ArenaNewSystem:showNewseasonView()
	local isShow = self:isShowNewSeasonView()

	if isShow then
		local view = self:getInjector():getInstance("ArenaNewSeasonView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			isFromNewArea = true
		}))
	end
end

function ArenaNewSystem:isShowNewSeasonView()
	local playerId = self:getDevelopSystem():getPlayer():getRid()
	local curSeasonId = cc.UserDefault:getInstance():getStringForKey(playerId .. UserDefaultKey.KNewArenaSeasonIsNew)
	local seasonData = self:getSeasonData()

	return curSeasonId ~= seasonData.Id
end

function ArenaNewSystem:setCurSeasonForIsShowView()
	local seasonData = self:getSeasonData()
	local playerId = self:getDevelopSystem():getPlayer():getRid()

	cc.UserDefault:getInstance():setStringForKey(playerId .. UserDefaultKey.KNewArenaSeasonIsNew, seasonData.Id)
	cc.UserDefault:getInstance():setStringForKey(playerId .. UserDefaultKey.KNewArenaSeasonIsNewTip, seasonData.Id)
end

function ArenaNewSystem:getSeasonData()
	return self:getArenaNew():getSeasonData()
end

function ArenaNewSystem:getCurSeasonSkillData()
	local seasonData = self:getSeasonData()
	local ret = {}

	for i, v in ipairs(seasonData.SeasonSkill) do
		local seasonSkillData = ConfigReader:getRecordById("Skill", seasonData.SeasonSkill[i])

		table.insert(ret, seasonSkillData)
	end

	return ret
end

function ArenaNewSystem:getCurSeasonData()
	return self:getSeasonData()
end

function ArenaNewSystem:getSeasonTime()
	local startTime = TimeUtil:localDate("%Y.%m.%d %H:%M", self._arenaNew:getStartTime())
	local endTime = TimeUtil:localDate("%Y.%m.%d %H:%M", self._arenaNew:getEndTime())

	return startTime, endTime
end

function ArenaNewSystem:getStartTime()
	return self:getArenaNew():getStartTime()
end

function ArenaNewSystem:getEndTime()
	return self:getArenaNew():getEndTime()
end

function ArenaNewSystem:getRivalByIndex(index)
	return (self:getArenaNew():getRivalByIndex(index))
end

function ArenaNewSystem:getReportList()
	return self:getArenaNew():getReportList()
end

function ArenaNewSystem:getCurrentTime()
	return self._gameServerAgent:remoteTimestamp()
end

function ArenaNewSystem:getReportById(reportId)
	return self:getArenaNew():getReportById(reportId)
end

function ArenaNewSystem:setLoadingBarTime(time)
	self._lodingBarTime = time
end

function ArenaNewSystem:getLoadingBarTime()
	return self._lodingBarTime
end

function ArenaNewSystem:getRewardNumById(id)
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", id, "Content")

	return rewards[1].amount
end

function ArenaNewSystem:getNextFirstReward(curRank)
	local ret = {}
	local allReward = self:getAllRewardConfig()

	if curRank > allReward[#allReward].RankRange[2] then
		ret.nextRank = allReward[#allReward].RankRange[2]
		ret.rewardNum = self:getRewardNumById(allReward[#allReward].FirstReward)

		return ret
	end

	if curRank <= allReward[1].RankRange[2] then
		return ret
	end

	local curReward

	for i, v in ipairs(allReward) do
		if curRank >= v.RankRange[1] and curRank <= v.RankRange[2] then
			curReward = v

			break
		end
	end

	if curReward then
		local nextReward = allReward[curReward.Sort - 1]

		if curReward.FirstRewardType == 1 and nextReward.FirstRewardType == 1 then
			local space = curReward.RankRange[2] - curReward.RankRange[1]

			if space == 0 or (curRank - curReward.RankRange[1]) / space <= 0.3 then
				ret.nextRank = nextReward.RankRange[1]

				local curNum = self:getRewardNumById(curReward.FirstReward) * (curRank - curReward.RankRange[1])
				local nextNum = self:getRewardNumById(nextReward.FirstReward) * (nextReward.RankRange[2] - nextReward.RankRange[1] + 1)

				ret.rewardNum = curNum + nextNum
			else
				ret.nextRank = curReward.RankRange[1]
				ret.rewardNum = self:getRewardNumById(curReward.FirstReward) * (curRank - curReward.RankRange[1])
			end
		elseif curReward.FirstRewardType == 1 and nextReward.FirstRewardType == 2 then
			ret.nextRank = nextReward.RankRange[2]

			local curNum = self:getRewardNumById(curReward.FirstReward) * (curRank - curReward.RankRange[1])
			local nextNum = self:getRewardNumById(nextReward.FirstReward)

			ret.rewardNum = curNum + nextNum
		elseif curReward.FirstRewardType == 2 and nextReward.FirstRewardType == 1 then
			ret.nextRank = nextReward.RankRange[1]
			ret.rewardNum = self:getRewardNumById(nextReward.FirstReward) * (nextReward.RankRange[2] - nextReward.RankRange[1] + 1)
		elseif curReward.FirstRewardType == 2 and nextReward.FirstRewardType == 2 then
			ret.nextRank = nextReward.RankRange[2]
			ret.rewardNum = self:getRewardNumById(nextReward.FirstReward)
		end
	end

	return ret
end

function ArenaNewSystem:goBackToMainView()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("ClassArena_UI42")
	}))
	self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, {
		viewName = "FunctionEntranceView"
	}))
end

function ArenaNewSystem:isShowNewArenaBtn()
	local playerId = self:getDevelopSystem():getPlayer():getRid()
	local curSeasonId = cc.UserDefault:getInstance():getStringForKey(playerId .. UserDefaultKey.KNewArenaSeasonIsNewTip)
	local seasonData = self:getSeasonData()

	return curSeasonId ~= seasonData.Id
end

function ArenaNewSystem:setCurSeasonForIsNewArenaBtn()
	local seasonData = self:getSeasonData()
	local playerId = self:getDevelopSystem():getPlayer():getRid()

	cc.UserDefault:getInstance():setStringForKey(playerId .. UserDefaultKey.KNewArenaSeasonIsNewTip, seasonData.Id)
end

function ArenaNewSystem:setOpenNewArenaBtn()
	self._isOpenAreanaBtn = true
end

function ArenaNewSystem:getOpenNewArenaBtn()
	return self._isOpenAreanaBtn
end

function ArenaNewSystem:getNewArenaRecordVis()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("ChessArena_System")

	if not unlock then
		return 0
	end

	local seasonData = self:getSeasonData()

	if not seasonData then
		return 0
	end

	local rerank = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ChessArena_RecordRank", "content")
	local myRank = self._developSystem:getPlayer():getChessArena().offLineRank

	if rerank < myRank or myRank < 1 then
		return 0
	end

	if self:isShowNewArenaBtn() then
		return 1
	end

	local offline = self._arenaNew:getReportOfflineList()

	if next(offline) and not self:getOpenNewArenaBtn() then
		return 2
	end

	return 0
end

function ArenaNewSystem:enterNewArenaRecord(state)
	self:setCurSeasonForIsNewArenaBtn()
	self:setOpenNewArenaBtn()

	local view = self:getInjector():getInstance("ArenaNewRecordView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		state = state
	}))
end

function ArenaNewSystem:enterShopView(sid)
	self._shopSystem:tryEnter({
		shopId = sid
	})
end

function ArenaNewSystem:getAllSeansonConfig()
	if not self._seansonAllConfig then
		local data = ConfigReader:getDataTable("ChessArenaSeason")

		self._seansonAllConfig = {}

		for k, v in pairs(data) do
			self._seansonAllConfig[#self._seansonAllConfig + 1] = v
		end

		table.sort(self._seansonAllConfig, function(a, b)
			return a.Sort < b.Sort
		end)
	end

	return self._seansonAllConfig
end

function ArenaNewSystem:getNextSeasonStartTime()
	local remoteTimestamp = self._gameServerAgent:remoteTimestamp()
	local year = TimeUtil:remoteDate("*t", remoteTimestamp).year
	local allConfig = self:getAllSeansonConfig()

	for i, v in ipairs(allConfig) do
		local str = v.TimeFactor.start

		str = year .. "-" .. str

		local _, _, y, m, d, hour, min, sec = string.find(str, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
		local timestamp = TimeUtil:timeByRemoteDate({
			year = year,
			month = m,
			day = d,
			hour = hour,
			min = min,
			sec = sec
		})

		str = v.TimeFactor["end"]
		str = year .. "-" .. v.TimeFactor["end"]

		local _, _, y, m, d, hour, min, sec = string.find(year .. "-" .. v.TimeFactor["end"], "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
		local timestampEnd = TimeUtil:timeByRemoteDate({
			year = year,
			month = m,
			day = d,
			hour = hour,
			min = min,
			sec = sec
		})

		if remoteTimestamp <= timestamp or remoteTimestamp <= timestampEnd then
			return v
		end
	end

	return nil
end

function ArenaNewSystem:checkShowRed()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("ChessArena_System")

	if not unlock then
		return false
	end

	if not self:getSeasonData() then
		return false
	end

	local ret = false
	local cur = self._developSystem:getPlayer():getChessArena().challengeTime.value

	if cur > 0 then
		ret = true
	end

	return (self:checkNewArenaRewardRedpoint() or nil) and true
end

function ArenaNewSystem:getRivalMatchOffset(beforeRank, curRank)
	local rate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ChessArena_StepValueRate", "content")
	local data = ConfigReader:getDataTable("ChessArenaRank")
	local curStepValue = 0

	for k, v in pairs(data) do
		if beforeRank >= v.RankRange[1] and beforeRank <= v.RankRange[2] then
			curStepValue = v.StepValue

			break
		end
	end

	if curStepValue == 0 then
		return false
	end

	if math.abs(beforeRank - curRank) > curStepValue * rate then
		return true
	end

	return false
end

function ArenaNewSystem:getArenaRewardInfo()
	local info = {}
	local rewards = self._developSystem:getPlayer():getChessArena().rewards
	local curMaxRank = self._developSystem:getPlayer():getChessArena().maxRank
	local data = self:getAllRewardConfig()

	for i, v in ipairs(data) do
		info[v.Id] = rewards[v.Id] and rewards[v.Id] == 1 and RTPKGradeRewardState.kHadGet or curMaxRank <= v.RankRange[2] and RTPKGradeRewardState.kCanGet or RTPKGradeRewardState.kCanNotGet
	end

	return info
end

function ArenaNewSystem:checkNewArenaRewardRedpoint()
	local rewardInfo = self:getArenaRewardInfo()

	for i, v in pairs(rewardInfo) do
		if v == RTPKGradeRewardState.kCanGet then
			return true
		end
	end

	return false
end

local refreshRivalSpace = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClassArena_ReloadCD", "content")

function ArenaNewSystem:requestMainInfoChessArena(callback, blockUI)
	self._arenaNewService:requestMainInfoChessArena(nil, function(response)
		if response.resCode == GS_SUCCESS then
			self:getArenaNew():synchronize(response.data)
			self:dispatch(Event:new(EVT_NEW_ARENA_MAIN_INFO))
		end

		if callback then
			callback(response)
		end
	end, blockUI)
end

function ArenaNewSystem:requestGainChessArena(callback, blockUI, notCd)
	if self._lastTime and not notCd then
		local cur = self._gameServerAgent:remoteTimestamp()

		if cur < self._lastTime + tonumber(refreshRivalSpace) then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Error_10702")
			}))

			return
		end

		self._lastTime = cur
	end

	self._lastTime = self._lastTime or self._gameServerAgent:remoteTimestamp()

	self._arenaNewService:requestGainChessArena(nil, function(response)
		if response.resCode == GS_SUCCESS then
			self:getArenaNew():synchronize(response.data)
			self:dispatch(Event:new(EVT_NEW_ARENA_FRESH_RIVAL))

			if callback then
				callback(response)
			end
		end
	end, blockUI)
end

function ArenaNewSystem:resetChallengeTime(callback)
	self._arenaNewService:resetChallengeTime(nil, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("ClassArena_UI74")
			}))
		end

		if callback then
			callback(response)
		end
	end, true)
end

function ArenaNewSystem:queryRivalRank(index, callback)
	local param = {
		index = index
	}

	self._arenaNewService:queryRivalRank(param, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response)
		end
	end, true)
end

function ArenaNewSystem:requestReport(callback)
	local params = {}

	self._arenaNewService:requestReport(params, function(response)
		if response.resCode == GS_SUCCESS then
			self:getArenaNew():synchronizeReportData(response.data)
		end

		if callback then
			callback(response)
		end
	end, true)
end

function ArenaNewSystem:requestOfflineReport(callback)
	local params = {}

	self._arenaNewService:requestOfflineReport(params, function(response)
		if response.resCode == GS_SUCCESS then
			self:getArenaNew():synchronizeReportOfflineData(response.data)
		end

		if callback then
			callback(response)
		end

		self:dispatch(Event:new(EVT_NEW_ARENA_OFFLINE_REPORT))
	end, false)
end

function ArenaNewSystem:requestReportDetail(reportId, callback, blockUI)
	local params = {}

	params.reportId = reportId

	self._arenaNewService:requestReportDetail(params, function(response)
		if response.resCode == GS_SUCCESS then
			local reportData = self:getReportById(reportId)
			local cjson = require("cjson.safe")
			local battleData = cjson.decode(response.data.battle)

			self:enterBattleReoprt(battleData, reportData)
		end

		if callback then
			callback(response)
		end
	end, blockUI)
end

function ArenaNewSystem:requestGetChessArenaReward(params, callback, blockUI)
	self._arenaNewService:requestGetChessArenaReward(params, function(response)
		if response.resCode == GS_SUCCESS then
			local rewards = response.data

			if rewards then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					needClick = true,
					rewards = rewards
				}))
			end

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_NEW_ARENA_REWAERD_INFO))
		end
	end, blockUI)
end

function ArenaNewSystem:requestBeginBattle(rivalIndex, quickbattle, callback)
	local params = {}

	params.index = rivalIndex

	self._arenaNewService:requestBeginBattle(params, function(response)
		if response.resCode == GS_SUCCESS then
			local curTime = self._gameServerAgent:remoteTimestamp()

			if curTime > self:getEndTime() then
				return
			end

			local reportData = response.data.battleReport

			self:getArenaNew():synchronizeReportData({
				reportData
			})
			self:getArenaNew():synchronize(response.data.mainInfo)

			local report = self:getReportById(reportData.reportId)

			if callback then
				callback(response.data.battleRobot, report)
			end

			if not quickbattle then
				self:enterBattleReoprt(response.data.battleRobot, report, true)
			end
		elseif callback then
			callback()
		end
	end, true)
end

function ArenaNewSystem:enterBattleReoprt(battleData, reportData, refreshRival)
	local outSelf = self
	local result = battleData.result
	local battleDelegate = {}
	local challengerId = battleData.playersInfo.challenger.rid
	local defenderId = battleData.playersInfo.defender.rid
	local selfRid = outSelf:getDevelopSystem():getPlayer():getRid()
	local isReplay = true
	local skipTime = tonumber(ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClassArena_SkipBattle_WaitTime", "content"))
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

	if selfRid == defenderId then
		logicInfo.mainPlayerId = defenderId
		battlePassiveSkill.playerStagePassShow = battlePassiveSkill.enemyStagePassShow
		battlePassiveSkill.enemyStagePassShow = battlePassiveSkill.playerStagePassShow
	else
		logicInfo.mainPlayerId = challengerId
	end

	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("Arena_SkipBattleCountdown")
	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local speedOpenSta = systemKeeper:getBattleSpeedOpen("arena_new_challenge")
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(SettingBattleTypes.kArenaNew)

	function battleDelegate:onLeavingBattle()
		if selfRid == challengerId and result == 1 or selfRid ~= challengerId and result == -1 then
			local battleStatist = battleData.statist.players
			local view = outSelf:getInjector():getInstance("ArenaVictoryView")
			local userData = {
				isFromNewArena = true,
				replayType = ArenaBattlePlayType.kReport,
				resultData = reportData,
				battleStatist = battleStatist,
				rewards = reportData:getReward(),
				retData = {
					refreshRival = refreshRival
				}
			}

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, userData, outSelf))
		else
			local id = logicInfo.mainPlayerId
			local loseData = {
				battleStatist = battleData.statist.players,
				resultData = reportData,
				title = Strings:get("ARENA_Defeat_Text"),
				loseId = id,
				popName = outSelf._showViewAfterBattle,
				refreshRival = refreshRival
			}

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, outSelf:getInjector():getInstance("ArenaNewLoseView"), {}, loseData, self))
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

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onSkipBattle()
		battleDelegate:onLeavingBattle()
	end

	function battleDelegate:onBattleFinish()
		if selfRid == challengerId and result == 1 or selfRid ~= challengerId and result == -1 then
			local battleStatist = battleData.statist.players
			local view = outSelf:getInjector():getInstance("ArenaVictoryView")
			local userData = {
				isFromNewArena = true,
				replayType = ArenaBattlePlayType.kReport,
				resultData = reportData,
				battleStatist = battleStatist,
				rewards = reportData:getReward(),
				retData = {
					refreshRival = refreshRival
				}
			}

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, userData, outSelf))
		else
			local id = logicInfo.mainPlayerId
			local loseData = {
				battleStatist = battleData.statist.players,
				resultData = reportData,
				title = Strings:get("ARENA_Defeat_Text"),
				loseId = id,
				popName = outSelf._showViewAfterBattle,
				refreshRival = refreshRival
			}

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, outSelf:getInjector():getInstance("ArenaNewLoseView"), {}, loseData, self))
		end
	end

	function battleDelegate:onDevWin()
		self:onSkipBattle()
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(SettingBattleTypes.kArenaNew, nil, timeScale)
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

	local bgRes = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ChessArena_Background", "content") or "battle_scene_1"
	local BGM = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Music_BattleBGM_Arena", "content")
	local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
	local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
	local var_55_0 = {
		battleRecords = battleData.timelines,
		isReplay = isReplay,
		logicInfo = logicInfo,
		delegate = battleDelegate
	}
	local var_55_1 = {
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

	var_55_1.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
	var_55_1.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
	var_55_1.passiveSkill = battlePassiveSkill
	var_55_1.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
	var_55_1.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("arena_challenge")

	local var_55_2 = {}
	local var_55_3 = {}

	var_55_3.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
	var_55_3.lock = not unlockSpeed
	var_55_3.tip = tipsSpeed
	var_55_3.speedConfig = battleSpeed_Actual
	var_55_3.speedShowConfig = battleSpeed_Display
	var_55_3.timeScale = timeScale
	var_55_2.speed = var_55_3
	var_55_2.skip = {
		enable = true,
		waitTips = "ARENA_SKIP_TIP",
		visible = (not unlock or nil) and false,
		skipTime = skipTime
	}

	local var_55_4 = {
		enable = false,
		lock = true
	}

	var_55_4.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
	var_55_2.auto = var_55_4
	var_55_2.pause = {
		enable = true,
		visible = false
	}

	local var_55_5 = {}

	var_55_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
	var_55_5.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
	var_55_2.restraint = var_55_5
	var_55_1.btnsShow = var_55_2
	var_55_0.viewConfig = var_55_1
	var_55_0.loadingType = LoadingType.kChessArena

	local data = var_55_0

	BattleLoader:pushBattleView(self, data, nil, true)
end

function ArenaNewSystem:getAllRewardConfig()
	local data = ConfigReader:getDataTable("ChessArenaReward")
	local list = {}

	for key, value in pairs(data) do
		list[#list + 1] = value
	end

	table.sort(list, function(a, b)
		return a.Sort < b.Sort
	end)

	return list
end

function ArenaNewSystem:getDailyRewardConfigByRank(rank)
	local data = self:getAllRewardConfig()
	local info

	for key, value in ipairs(data) do
		if rank >= value.RankRange[1] and rank <= value.RankRange[2] then
			info = value
		end
	end

	return info
end

function ArenaNewSystem:doReset()
	self:checkSeasonData(nil)
end
