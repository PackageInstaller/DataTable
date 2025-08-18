-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\BattleMixin.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local ResAsyncPVPMisc = require("ClientData/ResAsyncPVPMisc")
local VersionUtils = require("System/VersionUtils")
local PVPCommon = require("Logic/PVP/PVPCommon")
local RemoteController = require("SDK/Plugin/RemoteController")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local UserData = require("Helper/UserData")
local ResPlanWithPlayModeConfig = require("ClientData/ResPlanWithPlayModeConfig")
local BattleMiscConfig = require("Common/BattleMiscConfig")
local ASYNC_BATTLE_ID = ResAsyncPVPMisc[1].pve_id
local Const = Const
local GameFsm = GameFsm
local BattleMixin = {}

function BattleMixin:initBattleMixin(baseData, syncData)
	local battleCommon = baseData.necessary.battle.battle_common

	if baseData.necessary.battle.type ~= BattleConst.BATTLE_TYPE_NONE and battleCommon and battleCommon.seed ~= 0 and (not GameFsm.isInState(Const.STATE_BATTLE) or not self.isReconnect) then
		RPC.pVEQuit(baseData.necessary.battle.type, "kCSPVEQuitReasonTypeOffline")
	end

	utils.stagePreSuppressLevel = nil

	for index, info in ipairs(baseData.necessary.battle.suppres) do
		if info.type == BattleConst.BATTLE_TYPE_STAGE then
			utils.stagePreSuppressLevel = info.max_suppres
		end
	end
end

function BattleMixin:enterDefendFormation(pveId, battleType, battleData)
	self:enterFormation(pveId, battleType, battleData)
end

function BattleMixin:enterFormation(pveId, battleType, battleData, isRetry)
	battleData.type = battleType

	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	battleState:initPreBattleInfo(pveId, battleData, isRetry)

	if GameFsm.isInState(Const.STATE_BATTLE) and GameFsm.getState(Const.STATE_BATTLE).flagLoaded then
		GameFsm.getState(Const.STATE_BATTLE):startBattleFormation()
	else
		GameFsm.translateState(Const.STATE_BATTLE)
	end
end

function BattleMixin:battleMiscReq(tType)
	return
end

function BattleMixin:_onGetToken(tType, token)
	if token then
		RPC.roleMiscYD(token, tType)
	end
end

function BattleMixin:onPVEStartNotify(battleInfo)
	if battleInfo.type == BattleConst.BATTLE_TYPE_NONE then
		MsgManager.notice(Lang.get(1808))

		local battleState = GameFsm.getState(Const.STATE_BATTLE)

		battleState:onExitBattle()

		return
	end

	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	self:checkMultiPvpRobotFight(battleInfo)
	self:checkOpactPvpChallengeTimes(battleInfo.type)
	self:checkCircleBattle(battleInfo)
	self:checkStepTowerBattle(battleInfo)
	battleState:startFight(battleInfo)
end

function BattleMixin:onPVEStartRespError(ecode, battleInfo)
	if GameFsm.isInState(Const.STATE_BATTLE) then
		if ecode == "kCSErrorRentTaskDue" then
			MsgManager.notice(ResClientNotice[380].notice or Lang.get(1809))
		else
			MsgManager.notice(Lang.get(1810))
		end

		local battleState = GameFsm.getState(Const.STATE_BATTLE)

		battleState:onExitBattle()
	end

	local battleAutoChallengeDlg = UIManager.tryGetUI("battleAutoChallengeDlg")

	if battleAutoChallengeDlg then
		battleAutoChallengeDlg:onPVEStartRespError(ecode)
	end
end

function BattleMixin:onPVEFinishRespError(ecode, battleInfo)
	if ecode == "kCSErrorRentTaskDue" and GameFsm.isInState(Const.STATE_BATTLE) then
		MsgManager.notice(ResClientNotice[380].notice or Lang.get(1809))

		local battleState = GameFsm.getState(Const.STATE_BATTLE)

		battleState:onExitBattle()
	end
end

function BattleMixin:onPVEFinishRequest(battleType)
	self.cachedBattleBonus = {}

	if battleType == BattleConst.BATTLE_TYPE_STAGE then
		self.battleBonusNotifyType = "kListAttrUseTypePVEStage"
	elseif battleType == BattleConst.BATTLE_TYPE_STEPTOWER then
		self.battleBonusNotifyType = "kListAttrUseTypePVETower"
	elseif battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
		self.battleBonusNotifyType = "kListAttrUseTypePVEEquipTower"
	elseif battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
		self.battleBonusNotifyType = "kListAttrUseTypePVEBossTower"
	elseif battleType == BattleConst.BATTLE_TYPE_ONCETOWER then
		self.battleBonusNotifyType = "kListAttrUseTypePVEOnceTower"
	elseif battleType == BattleConst.BATTLE_TYPE_ASYNC_PVP then
		self.battleBonusNotifyType = "kListAttrUseTypeAsyncPVPBattle"
	elseif battleType == BattleConst.BATTLE_TYPE_MAZE then
		self.battleBonusNotifyType = "kListAttrUseTypeMaze"
	elseif battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		self.battleBonusNotifyType = "kListAttrUseTypePVEWorldBoss"
	elseif battleType == BattleConst.BATTLE_TYPE_OPACT_PVP then
		self.battleBonusNotifyType = "kListAttrUseTypeOpActArena"
	elseif battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
		self.battleBonusNotifyType = "kListAttrUseTypeOpActTowerFight"
	elseif battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
		self.battleBonusNotifyType = "kListAttrUseTypeCampTower"
	elseif battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
		self.battleBonusNotifyType = "kListAttrUseTypeOpActNewMaze"
	elseif battleType == BattleConst.BATTLE_TYPE_MAZE_PET then
		self.battleBonusNotifyType = "kListAttrUseTypePetMaze"
	elseif battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
		self.battleBonusNotifyType = "kListAttrUseTypeNewPveBattle"
	else
		self.battleBonusNotifyType = nil
	end

	self.battleBonusNotifyMailReason = Const.LISTATTR_TYPE_MAP[self.battleBonusNotifyType]
end

function BattleMixin:onNotifyBattleBonus(notifyType, attrs, items, heros, equip, artifact, relic, param, petGems)
	if notifyType == self.battleBonusNotifyType then
		if notifyType == "kListAttrUseTypePVEBossTower" or notifyType == "kListAttrUseTypeOpActNewMaze" then
			self.cachedBattleBonus = self.cachedBattleBonus or {}

			if param ~= nil then
				self.cachedBattleBonus[param] = ClientUtils.getAllClientItems(attrs, items, heros, equip, artifact, relic, petGems)
			end
		else
			self.cachedBattleBonus = ClientUtils.getAllClientItems(attrs, items, heros, equip, artifact, relic, petGems)
		end
	end

	if notifyType == Const.LISTATTR_USETYPE_ACHIEVE_STAGE and self.cachedBattleBonus then
		self.cachedBattleBonus.activityBonus = ClientUtils.getAllClientItems(attrs, items, heros, equip, artifact, relic, petGems)
	end
end

function BattleMixin:onMailBonus(mailReason, mailAttach)
	if mailReason == self.battleBonusNotifyMailReason then
		MsgManager.notice(Lang.get(1811))
	end
end

function BattleMixin:onPVEFinishResp(battleType, result, finish, canShare)
	self.battleBonusNotifyType = nil

	if battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		local _result = self:isCircleBattleResultWin(finish.spec.clan_battle)

		if _result then
			result = BattleConst.BATTLE_RESULT_WIN
		end

		self:circleFightMonsterOver(self.uid, finish.spec.clan_battle, _result)
	end

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	if battleType == BattleConst.BATTLE_TYPE_RENT then
		CurAvatar:onRentTaskCompletBattle()
	end

	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	battleState:onBattleResult({
		battleType,
		result,
		finish,
		self.cachedBattleBonus,
		canShare
	})

	self.cachedBattleBonus = {}

	local pveId = finish.common.pve_id

	BeginnerManager.noticeBattleOver(pveId)

	if result == BattleConst.BATTLE_RESULT_LOSE then
		local battleData = {}

		battleData.battleType = battleType

		if battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
			battleData.specData = battleState.battlePreInfo.equipTowerData
		elseif battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
			battleData.specData = finish.spec.boss_tower
		elseif battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
			battleData.specData = battleState.battlePreInfo.bossTowerExpandData
		elseif battleType == BattleConst.BATTLE_TYPE_ONCETOWER then
			battleData.specData = battleState.battlePreInfo.onceTowerData.layerData
		elseif battleType == BattleConst.BATTLE_TYPE_STEPTOWER then
			battleData.specData = finish.spec.tower
		end

		CurAvatar:checkGameAssistant(Const.GAME_ASSISTANT_TRIGGER_TYPE.BattleFail, battleData)
	elseif battleType == BattleConst.BATTLE_TYPE_STAGE and result == BattleConst.BATTLE_RESULT_WIN then
		CurAvatar:checkGameAssistant(Const.GAME_ASSISTANT_TRIGGER_TYPE.PassMainStage)
	elseif battleType == BattleConst.BATTLE_TYPE_STEPTOWER and result == BattleConst.BATTLE_RESULT_WIN then
		local star = finish.spec.tower.star or 0

		if star < 3 then
			local battleData = {}

			battleData.battleType = battleType
			battleData.specData = finish.spec.tower

			CurAvatar:checkGameAssistant(Const.GAME_ASSISTANT_TRIGGER_TYPE.BattleFail, battleData)
		else
			CurAvatar:clearBattleAssistantUserData(BattleConst.BATTLE_TYPE_STEPTOWER)
		end
	end
end

function BattleMixin:onPVEQuitResp(battleType, finish)
	if battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		self:circleFightMonsterQuit(self.uid, finish.spec.clan_battle)
	end

	self.battleBonusNotifyType = nil

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	battleState:onBattleResult({
		battleType,
		BattleConst.BATTLE_RESULT_LOSE,
		finish,
		self.cachedBattleBonus
	})

	self.cachedBattleBonus = {}
end

function BattleMixin:onPVEAutoBattleResp(type, result, finish)
	self.battleBonusNotifyType = nil

	local battleAutoChallengeDlg = UIManager.tryGetUI("battleAutoChallengeDlg")

	if battleAutoChallengeDlg then
		battleAutoChallengeDlg:onPVEAutoBattleResp(type, result, finish, self.cachedBattleBonus)
	end

	self.cachedBattleBonus = {}
end

function BattleMixin:onPVEAutoBattleRespError(ecode)
	local battleAutoChallengeDlg = UIManager.tryGetUI("battleAutoChallengeDlg")

	if battleAutoChallengeDlg then
		battleAutoChallengeDlg:onPVEStartRespError(ecode)
	end
end

function BattleMixin:onAsyncPVPTargetCacheResp(data)
	local battleData = {}

	battleData.asyncPVPData = {}
	battleData.asyncPVPData.pvpId = data.base.comm.uid
	battleData.asyncPVPData.asyncPVPEnemy = data.formation

	self:enterFormation(ASYNC_BATTLE_ID, BattleConst.BATTLE_TYPE_ASYNC_PVP, battleData)
end

function BattleMixin:onAsyncPVPTargetCacheRespError(...)
	MsgManager.notice(Lang.get(1812))
end

function BattleMixin:onMultiPVPTargetCacheRespError(...)
	MsgManager.notice(Lang.get(1812))
end

function BattleMixin:onMultiPVPTargetCacheResp(formation, robot_id)
	local isRobot = false

	if utils.isRobot(robot_id) then
		isRobot = true
		robot_id = tostring(robot_id)
	else
		self.seniorPvpFormations[formation.uid] = self.seniorPvpFormations[formation.uid] or {}
		self.seniorPvpFormations[formation.uid].tick = Time.time
		self.seniorPvpFormations[formation.uid].formation = formation.formation

		local ui = UIManager.getUI("seniorPvpEnemyDlg", nil, false)

		if ui then
			ui:refreshList()
		end

		local ui = UIManager.getUI("seniorPvpMainDlg", nil, false)

		if ui then
			ui:refreshRankList()
		end
	end

	local uid, _formation
	local battleData = {}

	battleData.multiPvpData = {}

	if self.seniorPvpReadyFightUid == formation.uid or self.seniorPvpReadyFightUid == robot_id and isRobot == true then
		self.seniorPvpReadyFightUid = nil

		if isRobot == true then
			uid = robot_id
			_formation = PVPCommon.getMultiPvpRobotServerFormation(uid)
		else
			uid = formation.uid
			_formation = formation.formation
		end

		battleData.multiPvpData.pvpId = uid
		battleData.multiPvpData.formation = _formation

		self:enterFormation(ASYNC_BATTLE_ID, BattleConst.BATTLE_TYPE_THREE_TEAM_PVP, battleData)
	end
end

function BattleMixin:onOpactArenaOpponentDetailNotify(opponent)
	local fightData
	local data = opponent

	self.opactPvpFormations[data.uid] = self.opactPvpFormations[data.uid] or {}
	self.opactPvpFormations[data.uid].tick = Time.time
	self.opactPvpFormations[data.uid].formation = data.formation

	if self.opactPvpReadyFightUid and self.opactPvpReadyFightUid == data.uid then
		fightData = data
		self.opactPvpReadyFightUid = nil
	end

	if fightData == nil then
		local ui = UIManager.getUI("activityPvpEnemyDlg", nil, false)

		if ui then
			ui:refreshList()
		end

		local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

		if ui then
			ui:refreshRankList()
		end

		local ui = UIManager.getUI("activityPvpRecordDlg", nil, false)

		if ui then
			ui:refreshList()
		end
	else
		local battleData = {}

		battleData.opactPvpData = {}

		local actObj = self:getPVPArenaActivity()

		if actObj then
			battleData.opactPvpData.actId = actObj.actId
		end

		battleData.opactPvpData.pvpId = fightData.uid
		battleData.opactPvpData.formation = fightData.formation

		self:enterFormation(ASYNC_BATTLE_ID, BattleConst.BATTLE_TYPE_OPACT_PVP, battleData)
	end
end

function BattleMixin:onBPPvpOpponentDetailNotify(opponent)
	local fightData
	local data = opponent
	local actData = CurAvatar:getTopPVPActivityData()

	if actData.topPvpReadyFightUid and actData.topPvpReadyFightUid == data.uid then
		fightData = data
		actData.topPvpReadyFightUid = nil
	end

	if fightData == nil then
		local ui = UIManager.tryGetUI("topPvpRecordDlg")

		if ui then
			ui:refreshList()
		end

		local ui = UIManager.tryGetUI("topPvpPlayerDetailsDlg")

		if ui then
			ui:setFormationData(opponent)
		end
	else
		local battleData = {}

		battleData.topPvpData = {}

		local actObj = self:getTopPVPActivity()

		if actObj then
			battleData.topPvpData.actId = actObj.actId
		end

		battleData.topPvpData.pvpId = fightData.uid
		battleData.topPvpData.formation = fightData.formation

		self:enterFormation(ASYNC_BATTLE_ID, BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH, battleData)
	end
end

function BattleMixin:requestSeasonTowerReplay(rData, playerComm)
	if self.waitingBattleReplay and ClientUtils.getServerTime() - self.preGetReplayTime < 5 then
		MsgManager.notice(Lang.get(37172))

		return
	end

	self.waitingBattleData = {}
	self.replayPlayerComm = playerComm
	self.preGetReplayTime = ClientUtils.getServerTime()

	if #rData == 2 then
		RPC.pVEBattleReplay(rData[1].replay_id, BattleConst.BATTLE_TYPE_ONCETOWER)
		RPC.pVEBattleReplay(rData[2].replay_id, BattleConst.BATTLE_TYPE_ONCETOWER)

		self.waitingBattleReplay = {
			rData[1].replay_id,
			rData[2].replay_id
		}
	else
		RPC.pVEBattleReplay(rData[1].replay_id, BattleConst.BATTLE_TYPE_ONCETOWER)

		self.waitingBattleReplay = {
			rData[1].replay_id
		}
	end
end

function BattleMixin:onPVEBattleReplayResp(data)
	local onceTowerRecordDlg = UIManager.getUI("onceTowerRecordDlg", nil, false)

	if onceTowerRecordDlg then
		onceTowerRecordDlg:cacheReplayData(data, self.checkJustShowReplayHeroInfo)
	end

	local battleRecommendDlg = UIManager.getUI("battleRecommendDlg", nil, false)

	if battleRecommendDlg then
		battleRecommendDlg:cacheReplayData(data, self.checkJustShowReplayHeroInfo)
	end

	if self.checkJustShowReplayHeroInfo then
		self.checkJustShowReplayHeroInfo = nil

		return
	end

	if BattleConst.CHECK_REPLAY_RECORD[data.start_data.type] and not BattleConst.CHECK_REPLAY_RECORD[data.start_data.type].specialDlg and next(data.camp) ~= nil then
		UIManager.getUI("battleReplayRecordDlg", true):show(data)
	elseif data.start_data.type == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP then
		self:onReceiveTeamPvpReplay(data)
	elseif data.start_data.type == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		self:onReceiveWorldBossReplay(data)
	elseif data.start_data.type == BattleConst.BATTLE_TYPE_OPACT_PVP then
		self:onReceiveOpactPvpReplay(data)
	elseif data.start_data.type == BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH then
		self:onReceiveTopPvpReplay(data)
	elseif data.start_data.type == BattleConst.BATTLE_TYPE_SEASON_TOWER then
		self:onReceiveSeasonTowerReplay(data)
	elseif data.start_data.type == BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT then
		self:onReceiveTopPVPKnockOutReplay(data)
	elseif data.control.version ~= VersionUtils.getBattleDataVersion() then
		MsgManager.clientNotice(178)
	else
		local replayState = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

		replayState:setServerReplayData(data)
		GameFsm.translateState(Const.STATE_BATTLE_REPLAY)
	end
end

function BattleMixin:onReceiveTeamPvpReplay(data)
	local replayId = data.replay_id
	local battleReplayShowData = {}

	if utils.isRobot(data.start_data.spec.mpvp.robot) then
		local formations = PVPCommon.getMultiPvpReplayRobotFormation(data.start_data.spec.mpvp.robot)

		for i, formation in ipairs(formations) do
			table.insert(data.start_data.start_common.formation, formation)
		end
	end

	battleReplayShowData.formations, battleReplayShowData.pets = utils.getBattleFormationHero(data.start_data)

	local results = {}

	for round, winCamp in ipairs(data.control.round_result) do
		results[round] = winCamp.wincamp
	end

	battleReplayShowData.results = results

	if not self.cachedTeamReplay then
		self.cachedTeamReplay = {}
	end

	self.cachedTeamReplay[replayId] = {
		data,
		battleReplayShowData,
		Time.time
	}

	for repId, info in pairs(self.cachedTeamReplay) do
		if Time.time - info[3] > 600 then
			self.cachedTeamReplay[repId] = nil
		end
	end

	if self.cachedSeniorPvpReplayData and self.cachedSeniorPvpReplayData.replay_id == replayId then
		UIManager.getUI("seniorPvpRecordInfoDlg", true):show(self.cachedTeamReplay[replayId], self.cachedSeniorPvpReplayData, BattleConst.BATTLE_TYPE_THREE_TEAM_PVP)
	elseif self.willGetTeamPvpReplayId ~= nil then
		local info = self.cachedTeamReplay[self.willGetTeamPvpReplayId]

		if info then
			local ui = UIManager.getUI("seniorPvpRecordDlg", nil, false)

			if ui then
				ui:refreshList()
			end
		end
	end
end

function BattleMixin:onReceiveOpactPvpReplay(data)
	local replayId = data.replay_id
	local battleReplayShowData = {}

	battleReplayShowData.formations, battleReplayShowData.pets = utils.getBattleFormationHero(data.start_data)

	local results = {}

	for round, winCamp in ipairs(data.control.round_result) do
		results[round] = winCamp.wincamp
	end

	battleReplayShowData.results = results

	if not self.cachedTeamReplay then
		self.cachedTeamReplay = {}
	end

	self.cachedTeamReplay[replayId] = {
		data,
		battleReplayShowData,
		Time.time
	}

	for repId, info in pairs(self.cachedTeamReplay) do
		if Time.time - info[3] > 600 then
			self.cachedTeamReplay[repId] = nil
		end
	end

	if self.cachedOpactPvpReplayData and self.cachedOpactPvpReplayData.replay_id == replayId then
		UIManager.getUI("seniorPvpRecordInfoDlg", true):show(self.cachedTeamReplay[replayId], self.cachedOpactPvpReplayData, BattleConst.BATTLE_TYPE_OPACT_PVP)
	elseif self.willGetOpactPvpReplayId ~= nil then
		local info = self.cachedTeamReplay[self.willGetOpactPvpReplayId]

		if info then
			local ui = UIManager.getUI("activityPvpRecordDlg", nil, false)

			if ui then
				ui:refreshList()
			end
		end
	end
end

function BattleMixin:onReceiveTopPvpReplay(data)
	local replayId = data.replay_id
	local battleReplayShowData = {}

	battleReplayShowData.formations, battleReplayShowData.pets = utils.getBattleFormationHero(data.start_data)

	local results = {}

	for round, winCamp in ipairs(data.control.round_result) do
		results[round] = winCamp.wincamp
	end

	battleReplayShowData.results = results

	if not self.cachedTeamReplay then
		self.cachedTeamReplay = {}
	end

	self.cachedTeamReplay[replayId] = {
		data,
		battleReplayShowData,
		Time.time
	}

	for repId, info in pairs(self.cachedTeamReplay) do
		if Time.time - info[3] > 600 then
			self.cachedTeamReplay[repId] = nil
		end
	end

	if self.cachedOpTopPvpReplayData and self.cachedOpTopPvpReplayData.replay_id == replayId then
		UIManager.getUI("seniorPvpRecordInfoDlg", true):show(self.cachedTeamReplay[replayId], self.cachedOpTopPvpReplayData, BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH)
	elseif self.willGetTopPvpReplayId ~= nil then
		local info = self.cachedTeamReplay[self.willGetTopPvpReplayId]

		if info then
			local ui = UIManager.getUI("topPvpRecordDlg", nil, false)

			if ui then
				ui:refreshList()
			end
		end
	end
end

function BattleMixin:onReceiveTopPVPKnockOutReplay(data)
	local replayId = data.replay_id
	local battleReplayShowData = {}

	battleReplayShowData.formations, battleReplayShowData.pets = utils.getBattleFormationHero(data.start_data)

	local results = {}

	for round, winCamp in ipairs(data.control.round_result) do
		results[round] = winCamp.wincamp
	end

	battleReplayShowData.results = results

	if not self.cachedTeamReplay then
		self.cachedTeamReplay = {}
	end

	self.cachedTeamReplay[replayId] = {
		data,
		battleReplayShowData,
		Time.time
	}

	for repId, info in pairs(self.cachedTeamReplay) do
		if Time.time - info[3] > 600 then
			self.cachedTeamReplay[repId] = nil
		end
	end

	if self.cachedOpTopPvpKnockoutReplayData and self.cachedOpTopPvpKnockoutReplayData.replay_id == replayId then
		UIManager.getUI("topPvpRecordInfoDlg", true):show(self.cachedTeamReplay[replayId], self.cachedOpTopPvpKnockoutReplayData, BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT)
	else
		self:onEnterTopPVPKnockOutRePlay(data)
	end
end

function BattleMixin:onEnterTopPVPKnockOutRePlay(data)
	if self.cachedKnockOutData then
		local startTime = self.cachedKnockOutData.startTime
		local passedTime = ClientUtils.getServerTime() - startTime
		local passedFrame = math.floor(passedTime * 20 * BattleMiscConfig.SYNC_REPLAY_TIME_SPEED)
		local startRound, startFrame = utils.GetBattleFrameRound(passedFrame, self.cachedKnockOutData.roundTime)

		for index, t in ipairs(self.cachedKnockOutData.roundTime) do
			if t and t.time > 0 then
				-- block empty
			end
		end

		local results = {}

		for round, winCamp in ipairs(data.control.round_result) do
			if round < startRound then
				results[round] = {
					winCamp.wincamp == BattleConst.CAMP_PLAYER and BattleConst.BATTLE_RESULT_WIN or BattleConst.BATTLE_RESULT_LOSE
				}
			end
		end

		local replayEnv = {}

		replayEnv.nowUiIndex = nil

		local actData = CurAvatar:getTopPVPActivityData()

		replayEnv.actId = actData.actId

		local ui = UIManager.tryGetUI("topPvpMainDlg")

		if ui then
			replayEnv.nowUiIndex = ui.panelKnockoutPanel.index
		end

		local ui = UIManager.tryGetUI("topPvpKnockoutDragHeroDlg")

		if ui and ui:getVisible() then
			replayEnv.nowUiIndex = 3
		end

		GameFsm.getState(Const.STATE_BATTLE_REPLAY):recordReplayEnv(replayEnv)

		local replayState = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

		replayState:setServerReplayData(data, startRound, startFrame, self.cachedKnockOutData.roundTime, results)
		GameFsm.translateState(Const.STATE_BATTLE_REPLAY)
	end
end

function BattleMixin:onReceiveSeasonTowerReplay(data)
	if not self.waitingBattleReplay then
		return
	end

	local replayId = data.replay_id

	for index, reId in pairs(self.waitingBattleReplay) do
		if reId == replayId then
			self.waitingBattleData[index] = data
			self.waitingBattleReplay[index] = nil

			break
		end
	end

	if next(self.waitingBattleReplay) then
		return
	end

	self.waitingBattleReplay = nil

	UIManager.getUI("seasonTowerRecordDlg", true):onShow(self.waitingBattleData, self.replayPlayerComm)
end

function BattleMixin:onReceiveWorldBossReplay(data)
	local name = self.name
	local score = 0
	local actData = self:getWorldBossActData()

	if actData then
		score = actData:getMaxScore()
	end

	local recorMaxScore

	if self.cachedWorldBossRecord then
		name = self.cachedWorldBossRecord.name
		score = data.spec.world_boss.max_score
	else
		recorMaxScore = tonumber(data.spec.world_boss.record_max_score) or 0
	end

	self.cachedWorldBossRecord = nil

	if self.cachedReplayEliteMode then
		if self.cachedReplayEliteMode == 1 then
			if self.cachedWorldBossRecordDatas then
				self.cachedWorldBossRecordDatas = nil
			end

			self.cachedWorldBossRecordDatas = {}
			self.cachedWorldBossMaxScore = recorMaxScore

			table.insert(self.cachedWorldBossRecordDatas, data)

			self.cachedReplayEliteMode = 2
		else
			local score2 = 0
			local actData = self:getWorldBossActData()

			if actData then
				score2 = actData:getEliteMaxScore()
			end

			table.insert(self.cachedWorldBossRecordDatas, data)

			self.cachedReplayEliteMode = nil

			UIManager.getUI("worldBossRecordDlg", true):show({
				{
					data = self.cachedWorldBossRecordDatas[1],
					name = name,
					score = score,
					recorMaxScore = self.cachedWorldBossMaxScore
				},
				{
					data = self.cachedWorldBossRecordDatas[2],
					name = name,
					score = score2,
					recorMaxScore = recorMaxScore
				}
			})

			self.cachedWorldBossRecordDatas = nil
		end
	else
		UIManager.getUI("worldBossRecordDlg", true):show({
			data = data,
			name = name,
			score = score,
			recorMaxScore = recorMaxScore
		})
	end
end

function BattleMixin:getTeamPvpReplayInfo(replayId, isOnlyFormation)
	if self.cachedTeamReplay == nil or self.cachedTeamReplay[replayId] == nil then
		self.willGetTeamPvpReplayId = replayId

		RPC.pVEBattleReplay(replayId, BattleConst.BATTLE_TYPE_THREE_TEAM_PVP)
	else
		local info = self.cachedTeamReplay[replayId]

		if isOnlyFormation == true then
			return info[2].formations, info[2].pets
		else
			UIManager.getUI("seniorPvpRecordInfoDlg", true):show(info, self.cachedSeniorPvpReplayData, BattleConst.BATTLE_TYPE_THREE_TEAM_PVP)
		end
	end
end

function BattleMixin:getOpactPvpReplayInfo(replayId, isOnlyFormation)
	if self.cachedTeamReplay == nil or self.cachedTeamReplay[replayId] == nil then
		self.willGetTopPvpReplayId = replayId

		RPC.pVEBattleReplay(replayId, BattleConst.BATTLE_TYPE_OPACT_PVP)
	else
		local info = self.cachedTeamReplay[replayId]

		if isOnlyFormation == true then
			return info[2].formations, info[2].pets
		else
			UIManager.getUI("seniorPvpRecordInfoDlg", true):show(info, self.cachedOpactPvpReplayData, BattleConst.BATTLE_TYPE_OPACT_PVP)
		end
	end
end

function BattleMixin:getTopPvpReplayInfo(replayId, isOnlyFormation)
	if self.cachedTeamReplay == nil or self.cachedTeamReplay[replayId] == nil then
		self.willGetOpactPvpReplayId = replayId

		RPC.pVEBattleReplay(replayId, BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH)
	else
		local info = self.cachedTeamReplay[replayId]

		if isOnlyFormation == true then
			return info[2].formations, info[2].pets
		else
			UIManager.getUI("seniorPvpRecordInfoDlg", true):show(info, self.cachedOpTopPvpReplayData, BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH)
		end
	end
end

function BattleMixin:onTeamPvpReplay(data, roundNum)
	local replayState = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

	replayState:setServerReplayData(data, roundNum)
	GameFsm.translateState(Const.STATE_BATTLE_REPLAY)
end

function BattleMixin:checkMultiPvpRobotFight(info)
	if info.type == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP and info.spec.mpvp and utils.isRobot(info.spec.mpvp.robot) then
		local formations = PVPCommon.getMultiPvpReplayRobotFormation(info.spec.mpvp.robot)

		for i, formation in ipairs(formations) do
			table.insert(info.start_common.formation, formation)
		end
	end
end

function BattleMixin:onPVEShareResp(...)
	MsgManager.notice(Lang.get(1813))

	if self.cachedShareUIName then
		local ui = UIManager.getUI(self.cachedShareUIName, nil, false)

		if ui then
			ui:refreshUI()
		end
	end
end

function BattleMixin:onSharePullResp(replay_id, replay_data)
	local msgTable = protobuf.decode("datap.BattleData", replay_data)

	if msgTable then
		if msgTable.control.version ~= VersionUtils.getBattleDataVersion() then
			MsgManager.clientNotice(178)

			return
		end

		local replayEnv = {}

		replayEnv.replayId = replay_id
		replayEnv.isShareType = true

		GameFsm.getState(Const.STATE_BATTLE_REPLAY):recordReplayEnv(replayEnv)

		if msgTable.start_data.type == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP and utils.isRobot(msgTable.start_data.spec.mpvp.robot) then
			local formations = PVPCommon.getMultiPvpReplayRobotFormation(msgTable.start_data.spec.mpvp.robot)

			for i, formation in ipairs(formations) do
				table.insert(msgTable.start_data.start_common.formation, formation)
			end
		end

		local replayState = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

		replayState:recordReplayEnv(replayEnv)
		replayState:setServerReplayData(msgTable)
		GameFsm.translateState(Const.STATE_BATTLE_REPLAY)
	end
end

function BattleMixin:onSharePullRespError(ecode)
	if ecode == "kCSErrorShareExpire" then
		MsgManager.notice(Lang.get(1814))
	end
end

function BattleMixin:checkOpactPvpChallengeTimes(battleType)
	if battleType == BattleConst.BATTLE_TYPE_OPACT_PVP then
		local actData = self:getPVPArenaActData()

		if actData then
			actData:reduceChallengeTimes()
		end
	end
end

function BattleMixin:checkCircleBattle(battleInfo)
	if battleInfo.type == BattleConst.BATTLE_TYPE_CIRCLE then
		local data = battleInfo.spec.clan.data

		if data then
			self:circleFightMonster(self.uid, data.layer, data.grid_pos, ClientUtils.getServerTime())
		end
	end
end

function BattleMixin:checkStepTowerBattle(battleInfo)
	if battleInfo.type == BattleConst.BATTLE_TYPE_STEPTOWER then
		local data = battleInfo.spec.tower.data

		if data then
			local StepTowerBattleAwardDlg = require("UI/StepTower/StepTowerBattleAwardDlg")
			local star = self:getStepTowerStar(data.layer, data.level)

			StepTowerBattleAwardDlg.setPreStar(star)
		end
	end
end

function BattleMixin:getLastBattleMvp(...)
	local state = GameFsm.getState(Const.STATE_BATTLE)

	if state then
		return state:getCachedMvp()
	end
end

function BattleMixin:isBattleVersionMatch(version)
	return version == VersionUtils.getBattleDataVersion()
end

function BattleMixin:isCircleBattleResultWin(clan_battle)
	local data = clan_battle

	if data.isboss == 1 then
		if data.killed ~= 0 then
			return true
		elseif data.boss_lose_hp >= ResClanBattleMisc[1].boss_hp_percent then
			return true
		end
	elseif data.grid.item and #data.grid.item > 0 then
		for i, item in ipairs(data.grid.item) do
			if item.pos == data.grid_pos then
				return item.grid.status == Const.CIRCLE_GRID_STATUS.OPEN
			end
		end
	end
end

function BattleMixin:isFirstGetInPlayMode(battleType)
	local strPlayModeIDs = UserData.loadCommonData("AlreadyInPlayModeIDs" .. self.uid)
	local playModeIDs = ClientUtils.string2Table(strPlayModeIDs)
	local battleState = GameFsm.getState(Const.STATE_BATTLE)
	local formationIdx = battleState:getFormationIndex()
	local curPlayModeID

	for _, battleInfo in pairs(ResPlanWithPlayModeConfig) do
		if utils.tableIsContainsElement(battleInfo.battle_type, battleType) and utils.tableIsContainsElement(battleInfo.battle_array_id, formationIdx) then
			curPlayModeID = battleInfo.id

			if battleInfo.plan_condition_id and not ConditionLimitManager.inLimitState(battleInfo.plan_condition_id) then
				return false
			end

			break
		end
	end

	if playModeIDs == nil then
		playModeIDs = {}

		table.insert(playModeIDs, curPlayModeID)
		UserData.saveCommonData("AlreadyInPlayModeIDs" .. self.uid, ClientUtils.table2String(playModeIDs))

		return true
	elseif utils.tableIsContainsElement(playModeIDs, curPlayModeID) then
		return false
	else
		table.insert(playModeIDs, curPlayModeID)
		UserData.saveCommonData("AlreadyInPlayModeIDs" .. self.uid, ClientUtils.table2String(playModeIDs))

		return true
	end
end

return BattleMixin
