-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/controller/ArenaSystem.lua

EVT_ARENA_SYNC_DIFF = "EVT_ARENA_SYNC_DIFF"
EVT_ARENA_CHALLENGE_OPPO_ERROR = "EVT_ARENA_CHALLENGE_OPPO_ERROR"
EVT_ARENA_GET_REPORT_DETAIL_SUCC = "EVT_ARENA_GET_REPORT_DETAIL_SUCC"
EVT_ARENA_BE_CHALLENGED = "EVT_ARENA_BE_CHALLENGED"
EVT_ARENA_SHARE_REPORT_SUCC = "EVT_ARENA_SHARE_REPORT_SUCC"
EVT_ARENA_REQUEST_RANK_REWARD_SUCC = "EVT_ARENA_REQUEST_RANK_REWARD_SUCC"
EVT_ARENA_REQUEST_CHANGE_DECLARE_SUCC = "EVT_ARENA_REQUEST_CHANGE_DECLARE_SUCC"
EVT_ARENA_ONEKEY_WORSHIP_SUCC = "EVT_ARENA_ONEKEY_WORSHIP_SUCC"
EVT_ARENA_ONEKEY_GETAWARD_SUCC = "EVT_ARENA_ONEKEY_GETAWARD_SUCC"
EVT_ARENA_CHANGE_TEAM_SUCC = "EVT_ARENA_CHANGE_TEAM_SUCC"
EVT_ARENA_NEW_SEASON = "EVT_ARENA_NEW_SEASON"
EVT_ARENA_SEASON_OVER = "EVT_ARENA_SEASON_OVER"
EVT_ARENA_RECEIVE_AWARD = "EVT_ARENA_RECEIVE_AWARD"

require("dm.gameplay.arena.model.Arena")

ArenaSystem = class("ArenaSystem", Facade, _M)

ArenaSystem:has("_player", {
	is = "r"
}):injectWith("Player")
ArenaSystem:has("_arenaService", {
	is = "r"
}):injectWith("ArenaService")
ArenaSystem:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ArenaSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ArenaSystem:has("_taskListModel", {
	is = "r"
}):injectWith("TaskListModel")
ArenaSystem:has("_arena", {
	is = "r"
})
ArenaSystem:has("_showViewAfterBattle", {
	is = "rw"
})
ArenaSystem:has("_showAwardAfterBattle", {
	is = "rw"
})

ArenaBattlePlayType = {
	kReport = 2,
	kNormal = 1
}
ArenaBattleStatus = {
	kLoseBattle = 2,
	kWinBattle = 1,
	kNoBattle = 0
}

function ArenaSystem:initialize()
	self._arena = Arena:new()
	self._showViewAfterBattle = "ArenaView"
	self._showAwardAfterBattle = {}

	super.initialize(self)

	self._rewardBaseBum = 0

	self:initRewardBase()
end

function ArenaSystem:initRewardBase()
	local rewardId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_RewardBase", "content")
	local rewards = ConfigReader:getRecordById("Reward", rewardId)

	if rewards and rewards.Content then
		for i = 1, #rewards.Content do
			local reward = rewards.Content[i]

			if reward.type == RewardType.kSpecialValue then
				self._rewardBaseBum = reward.amount
			end
		end
	end
end

function ArenaSystem:checkEnabled(data)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("Arena_All")

	if not unlock then
		return unlock, tips
	end

	unlock, tips = systemKeeper:isUnlock("Arena_System")

	return unlock, tips
end

function ArenaSystem:tryEnter(data)
	if not CommonUtils.GetSwitch("fn_arena_normal") then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_ArenaClose")
		}))

		return
	end

	local unlock, tips = self:checkEnabled(data)

	if not unlock then
		self:dispatch(ShowTipEvent({
			tip = tips
		}))

		return
	end

	local function getDataSucc(response)
		if response.resCode == GS_SUCCESS then
			local view = self:getInjector():getInstance("ArenaView")
			local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {})

			self:dispatch(event)

			local storyDirector = self:getInjector():getInstance(story.StoryDirector)
			local guideAgent = storyDirector:getGuideAgent()

			if GameConfigs.closeGuide or not guideAgent:isGuiding() then
				self:showNewseasonView()
			end
		end
	end

	self:requestArenaInfo(getDataSucc)
end

function ArenaSystem:checkLeftCount(data)
	local unlock, tips = self:checkEnabled()

	if not unlock then
		return 1, tips
	end

	local kArenaTimeCoin = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_ItemUse", "content")
	local remainTimes = self._developSystem:getBagSystem():getItemCount(kArenaTimeCoin)

	return remainTimes, Strings:get("Arena_LeftCount_NotEnough")
end

function ArenaSystem:showNewseasonView()
	local isShow = self:isShowNewSeasonView()

	if isShow then
		local view = self:getInjector():getInstance("ArenaNormalNewSeasonView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {}))
	end
end

function ArenaSystem:_syncArenaModel(data)
	self:getArena():synchronize(data)

	local rivalsChanged = data.rivals ~= nil

	self:dispatch(Event:new(EVT_ARENA_SYNC_DIFF, {
		rivalsChanged = rivalsChanged
	}))
end

function ArenaSystem:getRefreshTime()
	return self:getArena():getRefreshTime()
end

function ArenaSystem:requestQuickBattle(rivalIndex, callback, blockUI)
	local params = {}

	params.rivalIndex = rivalIndex

	self._arenaService:requestQuickBattle(params, function(response)
		if response.resCode == GS_SUCCESS then
			local var_11_0 = {}

			var_11_0.numReward = response.data.numReward or {}
			var_11_0.rankRewards = response.data.rankRewards or {}
			self._showAwardAfterBattle = var_11_0
		end

		self:dispatch(Event:new(EVT_ARENAQUICKBATTLE_SUCC, {
			resetData = response
		}))
	end, blockUI)
end

function ArenaSystem:isShowNewSeasonView()
	local playerId = self:getDevelopSystem():getPlayer():getRid()
	local curSeasonId = cc.UserDefault:getInstance():getStringForKey(playerId .. UserDefaultKey.kCurSeasonForIsShowView)
	local seasonData = self:getSeasonData()

	return curSeasonId ~= seasonData.id
end

function ArenaSystem:setCurSeasonForIsShowView()
	local seasonData = self:getSeasonData()
	local playerId = self:getDevelopSystem():getPlayer():getRid()

	cc.UserDefault:getInstance():setStringForKey(playerId .. UserDefaultKey.kCurSeasonForIsShowView, seasonData.id)
end

function ArenaSystem:getSeasonData()
	return self:getArena():getSeasonData()
end

function ArenaSystem:getCurSeasonData()
	local seasonData = self:getSeasonData()

	return (ConfigReader:getRecordById("ArenaSeason", seasonData.id))
end

function ArenaSystem:getSeasonTime()
	local seasonData = self:getSeasonData()
	local startTime = TimeUtil:localDate("%Y.%m.%d %H:%M", seasonData.start / 1000)
	local endTime = TimeUtil:localDate("%Y.%m.%d %H:%M", seasonData["end"] / 1000)

	return startTime, endTime
end

function ArenaSystem:getIsRecommend(heroId)
	local seasonData = self:getSeasonData()
	local HeroBase = ConfigReader:getRecordById("HeroBase", heroId)

	for k, v in pairs(seasonData.bufCond) do
		if v.type == "ALL" then
			return false
		elseif v.type == "Job" then
			for k, value in pairs(v.value) do
				if HeroBase.Type == value then
					return true
				end
			end
		elseif v.type == "Tag" then
			for k, value in pairs(v.value) do
				for key, Flag in pairs(HeroBase.Flags) do
					if Flag == value then
						return true
					end
				end
			end
		elseif v.type == "Party" then
			for k, value in pairs(v.value) do
				if HeroBase.Party == value then
					return true
				end
			end
		end
	end

	return false
end

function ArenaSystem:getCurSeasonSkillData()
	local seasonData = self:getSeasonData()

	return (ConfigReader:getRecordById("Skill", seasonData.buff))
end

function ArenaSystem:getMyRank()
	return self:getArena():getRank()
end

function ArenaSystem:getRank()
	local rank = self:getMyRank()
	local count = self:getTotalExtra()
	local data = self:getRankList()

	for index, info in ipairs(data) do
		if (info.RankAmount == -1 or rank <= info.RankAmount) and count >= info.ArenaAmount then
			return 8 - info.Sort, info
		end
	end

	return 0
end

function ArenaSystem:getRivalByIndex(index)
	return (self:getArena():getRivalByIndex(index))
end

function ArenaSystem:getReportList()
	return self:getArena():getReportList()
end

function ArenaSystem:getCurrentTime()
	return self._gameServerAgent:remoteTimestamp()
end

function ArenaSystem:checkAwardRed()
	return false
end

local Arena_PlayerExtraColor = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_PlayerExtraColor", "content")

function ArenaSystem:getExtraCoinBg(num)
	num = num - self._rewardBaseBum

	for i, v in pairs(Arena_PlayerExtraColor) do
		if num >= v[1] and num <= v[2] then
			return i .. ".png"
		end
	end

	return "jjc_bg_txk_1.png"
end

function ArenaSystem:getReportById(reportId)
	return self:getArena():getReportById(reportId)
end

function ArenaSystem:getTotalExtra(reportId)
	return self:getArena():getTotalExtra(reportId)
end

function ArenaSystem:getHistoryRank()
	return self:getArena():getHistoryRank()
end

function ArenaSystem:requestArenaInfo(callback, blockUI)
	self._arenaService:requestArenaInfo(nil, function(response)
		if response.resCode == GS_SUCCESS then
			self:_syncArenaModel(response.data)
		end

		if callback then
			callback(response)
		end
	end, blockUI)
end

function ArenaSystem:requestReportDetail(reportId, callback, blockUI)
	local params = {}

	params.reportId = reportId

	self._arenaService:requestReportDetail(params, function(response)
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

function ArenaSystem:requestBeginBattle(rivalIndex, callback, blockUI)
	local params = {}

	params.rivalIndex = rivalIndex

	self._arenaService:requestBeginBattle(params, function(response)
		if response.resCode == GS_SUCCESS then
			self:enterBattleChallenge(rivalIndex, response.data)
		elseif callback then
			callback()
		end
	end, blockUI)
end

function ArenaSystem:requestFinishBattle(rivalIndex, resultData, callback, blockUI)
	local params = {
		rivalIndex = rivalIndex,
		resultData = resultData
	}

	self._arenaService:requestFinishBattle(params, function(response)
		if response.resCode == GS_SUCCESS then
			self:_syncArenaModel(response.data)

			local function finishCallBack()
				local var_37_0 = {}

				var_37_0.numReward = response.data.numReward or {}
				var_37_0.rankRewards = response.data.rankRewards or {}
				self._showAwardAfterBattle = var_37_0

				if callback then
					if not response.data.reward then
						local reward = {}

						if not response.data.extraReward then
							local extraReward = 0

							for i = 1, #reward do
								local rewardData = reward[i]

								if rewardData.code == CurrencyIdKind.kHonor then
									rewardData.amount = rewardData.amount + extraReward

									break
								end
							end

							callback(response, reward)
						end
					end
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
		end
	end, blockUI)
end

function ArenaSystem:requestRefreshRivalList(params, callback, blockUI)
	self._arenaService:requestRefreshRivalList(params, function(response)
		if response.resCode == GS_SUCCESS then
			self:_syncArenaModel(response.data)
		elseif callback then
			callback()
		end
	end, blockUI)
end

function ArenaSystem:requestRenameArenaTeam(params, callback, blockUI)
	self._arenaService:requestRenameArenaTeam(params, function(response)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Stage_UI2")
		}))
		self:dispatch(Event:new(EVT_STAGE_CHANGENAME_SUCC))

		if callback then
			callback()
		end
	end, blockUI)
end

function ArenaSystem:requestFailBattle(params, callback, blockUI)
	self._arenaService:requestFailBattle(params, function(response)
		if callback then
			callback()
		end
	end, blockUI)
end

function ArenaSystem:enterBattleReoprt(battleData, reportData)
	local outSelf = self
	local result = battleData.result
	local battleDelegate = {}
	local challengerId = reportData:getAttacker():getId()
	local defenderId = reportData:getDefender():getId()
	local selfRid = outSelf:getDevelopSystem():getPlayer():getRid()
	local isReplay = true
	local skipTime = tonumber(ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_SkipBattle_WaitTime", "content"))
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

	logicInfo.mainPlayerId = selfRid == defenderId and defenderId or challengerId

	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("Arena_SkipBattleCountdown")
	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local speedOpenSta = systemKeeper:getBattleSpeedOpen("arena_challenge")
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(SettingBattleTypes.kArena)

	function battleDelegate:onLeavingBattle()
		if selfRid == challengerId and result == 1 or selfRid ~= challengerId and result == -1 then
			local battleStatist = battleData.statist.players
			local view = outSelf:getInjector():getInstance("ArenaVictoryView")
			local userData = {
				replayType = ArenaBattlePlayType.kReport,
				resultData = reportData,
				battleStatist = battleStatist
			}

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, userData, outSelf))
		else
			local id = challengerId
			local loseData = {
				battleStatist = battleData.statist.players,
				title = Strings:get("ARENA_Defeat_Text"),
				loseId = id
			}

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, outSelf:getInjector():getInstance("StageLosePopView"), {}, loseData, self))
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

	function battleDelegate:onBattleFinish(result)
		if selfRid == challengerId and result == 1 or selfRid ~= challengerId and result == -1 then
			local battleStatist = battleData.statist.players
			local view = outSelf:getInjector():getInstance("ArenaVictoryView")
			local userData = {
				replayType = ArenaBattlePlayType.kReport,
				resultData = reportData,
				battleStatist = battleStatist
			}

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, userData, outSelf))
		else
			local id = challengerId
			local loseData = {
				battleStatist = battleData.statist.players,
				title = Strings:get("ARENA_Defeat_Text"),
				loseId = id
			}

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, outSelf:getInjector():getInstance("StageLosePopView"), {}, loseData, self))
		end
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

	local bgRes = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_Background", "content") or "battle_scene_1"
	local BGM = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Music_BattleBGM_Arena", "content")
	local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
	local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
	local var_45_0 = {
		battleRecords = battleData.timelines,
		isReplay = isReplay,
		logicInfo = logicInfo,
		delegate = battleDelegate
	}
	local var_45_1 = {
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

	var_45_1.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
	var_45_1.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
	var_45_1.passiveSkill = battlePassiveSkill
	var_45_1.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
	var_45_1.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("arena_challenge")

	local var_45_2 = {}
	local var_45_3 = {}

	var_45_3.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
	var_45_3.lock = not unlockSpeed
	var_45_3.tip = tipsSpeed
	var_45_3.speedConfig = battleSpeed_Actual
	var_45_3.speedShowConfig = battleSpeed_Display
	var_45_3.timeScale = timeScale
	var_45_2.speed = var_45_3
	var_45_2.skip = {
		enable = true,
		visible = (not unlock or nil) and false
	}

	local var_45_4 = {
		enable = false,
		lock = true
	}

	var_45_4.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
	var_45_2.auto = var_45_4
	var_45_2.pause = {
		enable = true,
		visible = false
	}

	local var_45_5 = {}

	var_45_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
	var_45_5.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
	var_45_2.restraint = var_45_5
	var_45_1.btnsShow = var_45_2
	var_45_0.viewConfig = var_45_1
	var_45_0.loadingType = LoadingType.KArena

	local data = var_45_0

	BattleLoader:pushBattleView(self, data, nil, true)
end

function ArenaSystem:enterBattleChallenge(rivalIndex, data)
	local isReplay = false
	local outSelf, battleDelegate = self, {}
	local battleSession = ArenaBattleSession:new(data)

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
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(SettingBattleTypes.kArena)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("AutoFight")

	if not unlock then
		isAuto = false
	end

	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local speedOpenSta = systemKeeper:getBattleSpeedOpen("arena_challenge")
	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter,
		teams = battleSession:genTeamAiInfo(),
		mainPlayerId = {
			data.playerData.rid
		}
	}
	local skipTime = tonumber(ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_SkipBattle_WaitTime", "content"))

	function battleDelegate:onLeavingBattle()
		local params = {
			rivalIndex = rivalIndex
		}

		outSelf:requestFailBattle(params, nil, true)

		if battleSession then
			local realData = battleSession:getExitSummary()
			local loseData = {
				viewType = "arena",
				battleStatist = realData and realData.statist.players,
				title = Strings:get("ARENA_Defeat_Text")
			}

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, outSelf:getInjector():getInstance("StageLosePopView"), {}, loseData, outSelf))
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
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(SettingBattleTypes.kArena, isAuto)
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onSkipBattle()
		local realData = {
			randomSeed = 123321,
			opData = "dev",
			result = kBattleSideAWin,
			winners = {
				data.playerData.rid
			},
			statist = {
				totalTime = 10000,
				roundCount = 4,
				players = {
					[data.playerData.rid] = {
						unitsDeath = 0,
						hpRatio = 0.99999,
						unitsTotal = 3,
						unitSummary = {}
					}
				}
			}
		}

		local function callback(response, rewards)
			local battleReport = response.data.battleReport
			local rank = response.data.rank
			local attWin = response.data.attWin

			if attWin then
				local view = outSelf:getInjector():getInstance("ArenaVictoryView")
				local var_65_0 = {
					replayType = ArenaBattlePlayType.kNormal,
					resultData = battleReport
				}

				var_65_0.battleStatist = response.data and response.data.statist.players
				var_65_0.rank = rank or 999999
				var_65_0.rewards = rewards or {}

				local userData = var_65_0

				outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, userData, outSelf))
			else
				local var_65_1 = {}

				var_65_1.battleStatist = response.data and response.data.statist.players
				var_65_1.title = Strings:get("ARENA_Defeat_Text")

				local loseData = var_65_1

				outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, outSelf:getInjector():getInstance("StageLosePopView"), {}, loseData, outSelf))
			end
		end

		outSelf:requestFinishBattle(rivalIndex, realData, callback)
	end

	function battleDelegate:onBattleFinish(result)
		local realData = battleSession:getResultSummary()

		local function callback(response, rewards)
			local battleReport = response.data.battleReport
			local rank = response.data.rank
			local attWin = response.data.attWin

			if attWin then
				local view = outSelf:getInjector():getInstance("ArenaVictoryView")
				local var_67_0 = {
					replayType = ArenaBattlePlayType.kNormal,
					resultData = battleReport
				}

				var_67_0.battleStatist = response.data and response.data.statist.players
				var_67_0.rank = rank or 999999
				var_67_0.rewards = rewards or {}

				local userData = var_67_0

				outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, userData, outSelf))
			else
				local var_67_1 = {}

				var_67_1.battleStatist = response.data and response.data.statist.players
				var_67_1.title = Strings:get("ARENA_Defeat_Text")

				local loseData = var_67_1

				outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, outSelf:getInjector():getInstance("StageLosePopView"), {}, loseData, outSelf))
			end
		end

		outSelf:requestFinishBattle(rivalIndex, realData, callback)
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

	function battleDelegate:showMaster(friend, enemy, pauseFunc, resumeCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if resumeCallback then
				resumeCallback()
			end
		end

		local bossView = outSelf:getInjector():getInstance("MasterCutInView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
			friend = friend,
			enemy = enemy
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

	local bgRes = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_Background", "content") or "battle_scene_1"
	local BGM = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Music_BattleBGM_Arena", "content")
	local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
	local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
	local var_58_0 = {
		battleType = battleSession:getBattleType(),
		battleData = battleData,
		battleConfig = battleConfig,
		isReplay = isReplay,
		logicInfo = logicInfo,
		delegate = battleDelegate
	}
	local var_58_1 = {
		opPanelClazz = "BattleUIMediator",
		mainView = "battlePlayer",
		opPanelRes = "asset/ui/BattleUILayer.csb",
		canChangeSpeedLevel = true,
		finalHitShow = true,
		battleSettingType = SettingBattleTypes.kArena,
		bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVP_Arena"),
		bgm = BGM,
		background = bgRes,
		refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
		battleSuppress = BattleDataHelper:getBattleSuppress()
	}

	var_58_1.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
	var_58_1.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
	var_58_1.passiveSkill = battlePassiveSkill
	var_58_1.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
	var_58_1.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("arena_challenge")

	local var_58_2 = {}
	local var_58_3 = {}

	var_58_3.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
	var_58_3.lock = not unlockSpeed
	var_58_3.tip = tipsSpeed
	var_58_3.speedConfig = battleSpeed_Actual
	var_58_3.speedShowConfig = battleSpeed_Display
	var_58_3.timeScale = timeScale
	var_58_2.speed = var_58_3
	var_58_2.skip = {
		enable = true,
		waitTips = "ARENA_SKIP_TIP",
		visible = (systemKeeper:isUnlock("Arena_SkipBattleCountdown") or nil) and true,
		skipTime = skipTime
	}

	local var_58_4 = {}

	var_58_4.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
	var_58_4.state = isAuto
	var_58_4.lock = not unlock
	var_58_2.auto = var_58_4
	var_58_2.pause = {
		enable = true,
		visible = true
	}

	local var_58_5 = {}

	var_58_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
	var_58_5.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
	var_58_2.restraint = var_58_5
	var_58_1.btnsShow = var_58_2
	var_58_0.viewConfig = var_58_1
	var_58_0.loadingType = LoadingType.KArena

	local data = var_58_0

	BattleLoader:pushBattleView(self, data, nil, true)
end

function ArenaSystem:getRankData(rankId)
	self._rankData = self._rankData or ConfigReader:getDataTable("ArenaRank")

	if rankId then
		return self._rankData[rankId]
	end

	return self._rankData
end

function ArenaSystem:getRankList()
	local data = self:getRankData()
	local list = {}

	for key, value in pairs(data) do
		list[#list + 1] = value
	end

	table.sort(list, function(a, b)
		return a.Sort < b.Sort
	end)

	return list
end
