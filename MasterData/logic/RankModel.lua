-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/model/RankModel.lua

module("logic.extensions.rank.model.RankModel", package.seeall)

local RankModel = class("RankModel", BaseModel)

RankModel.selectedRoot = GameEnum.RankType.BreakFormation
RankModel.selectedLeaf = 1

function RankModel:ctor()
	self._rankMos = {}
	self._isDataInit = {}
end

function RankModel:onInit()
	self:onReset()
end

function RankModel:onReset()
	self._rankMos = {}
	self._isDataInit = {}
end

function RankModel:setRankData(msg, root, leaf)
	self._isDataInit[root] = self._isDataInit[root] or {}
	self._isDataInit[root][leaf] = ServerTime.now()
	self._rankMos[root] = self._rankMos[root] or {}
	self._rankMos[root][leaf] = msg or {}
end

function RankModel:clearDataInit()
	self._isDataInit = {}
end

function RankModel:sendReqRankData(root, leaf)
	if root == GameEnum.RankType.BreakFormation then
		BreachFormationAgent.instance:sendPM_BreachFormationGetRankInfoReq(1, 100, function(msg)
			RankModel.instance:setRankData(msg, GameEnum.RankType.BreakFormation, 0)
			GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
		end)
	elseif root == GameEnum.RankType.WTower then
		local wtCfgs = WTowerConfig.instance:getDicCfgList()
		local wtCfg = wtCfgs[math.max(1, leaf)]

		WarriorTowerAgent.instance:sendGetWarriorTowerRankInfoReq(wtCfg.towerId, function(msg)
			RankModel.instance:setRankData(msg, GameEnum.RankType.WTower, leaf)
			GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
		end)
	elseif root == GameEnum.RankType.Arena then
		local zoneId = ArenaModel.instance:getZoneId()

		if zoneId == -1 then
			zoneId = 2
		end

		ArenaAgent.instance:sendGetTopDetailReq(zoneId, 1, 100)
	elseif root == GameEnum.RankType.MaxPower then
		leaf = math.max(1, leaf)

		CommonRankAgent.instance:sendPM_MaxZdlRankGetInfoReq(leaf, 1, 100)
	elseif root == GameEnum.RankType.ShengGuangFeiLong then
		HolyChallengeAgent.instance:sendPM_HCGetRankInfoReq(1, 100, function(msg)
			RankModel.instance:setRankData(msg, GameEnum.RankType.ShengGuangFeiLong, 0)
			GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
		end)
	elseif root == GameEnum.RankType.RankMatchClass or root == GameEnum.RankType.RankMatchLimit then
		RankRaceController.instance:rankModelReq(root, leaf)
	elseif root == GameEnum.RankType.FlyNuo then
		FlyingNuoAgent.instance:sendPM_GetRankInfoReq(1, 100)
	elseif root == GameEnum.RankType.SeniorArena then
		SeniorArenaController.instance:reqRankData()
	elseif root == GameEnum.RankType.DuolaMM_RANK then
		TimedChallengeAgent.instance:sendPM_TimedChallengeGetPetRankReq(6, function(msg)
			self:_onTLCRankInfoRes(msg, root, leaf)
			GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
		end)
	elseif root == GameEnum.RankType.FamilyTeamPlay then
		local seasonId = FamilyWarController.instance:getSeasonIdOfNfsRank()

		printInfo("test seasonId = ", seasonId)

		if leaf == 1 then
			FamilyWarController.instance:sendPM_FamilySeasonRankViewNewRankReq(FamilySeasonRankEnum.RankType_Total, seasonId)
		elseif leaf == 2 then
			FamilyWarController.instance:sendPM_FamilySeasonRankViewNewRankReq(FamilySeasonRankEnum.StepType_GodStatuesWarZone, seasonId)
		elseif leaf == 3 then
			FamilyWarController.instance:sendPM_FamilySeasonRankViewNewRankReq(FamilySeasonRankEnum.StepType_GodStatuesWarSpace, seasonId)
		elseif leaf == 4 then
			FamilyWarController.instance:sendPM_FamilySeasonRankViewNewRankReq(FamilySeasonRankEnum.RankType_FamilyHoudingClg, seasonId)
		elseif leaf == 5 then
			FamilyHonorController.instance:csRequestFamilyMedalViewRankReq()
		end
	elseif root == GameEnum.RankType.SendFlower_RANK then
		if leaf == 1 then
			SendFlowerController.instance:reqMalegodRank()
		elseif leaf == 2 then
			SendFlowerController.instance:reqGoddess()
		elseif leaf == 3 then
			SendFlowerAgent.instance:sendPM_GetFlowerCharmRankReq()
		elseif leaf == 4 then
			SendFlowerAgent.instance:sendPM_GetFlowerSendRankReq()
		end
	elseif TimeLimitedConfig.instance:isTimedChallengeRank(root) then
		local cfg = TimeLimitedConfig.instance:getChallengeRankCfgByRootAndLeat(root, leaf)
		local challengeId = TimeLimitedConfig.instance:getChallengeIdByRankType(root)

		print("cfg.name = " .. cfg.name)

		if checknumber(cfg.classType) == GameEnum.RankClassType.GainTime then
			TimedChallengeAgent.instance:sendPM_TimedChallengeGetPetRankReq(challengeId, function(msg)
				self:_onTLCRankInfoRes(msg, root, leaf)
			end)
		elseif checknumber(cfg.classType) == GameEnum.RankClassType.Damage then
			TimedChallengeAgent.instance:sendPM_TimedChallengeGetDamageRankReq(challengeId, function(msg)
				self:_onTLCRankInfoRes(msg, root, leaf)
			end)
		elseif checknumber(cfg.classType) == GameEnum.RankClassType.TotalScore then
			TimedPointRaceModeController.instance:sendGetTotalRankInfo(challengeId, root, leaf)
		elseif checknumber(cfg.classType) == GameEnum.RankClassType.DailyScore then
			TimedPointRaceModeController.instance:sendGetDailyRankInfo(challengeId, root, leaf)
		end
	elseif root == GameEnum.RankType.Mirror_Rank then
		XinxiyaMirrorController.instance:csGetMirrorRankInfoReq()
	elseif root == GameEnum.RankType.FamilyHonor then
		FamilyHonorController.instance:csRequestFamilyMedalViewRankReq()
	elseif root == GameEnum.RankType.AchievementRank then
		AchievementController.instance:sendAchievementGetRankReq()
	elseif root == GameEnum.RankType.GloryTowerRank then
		HonourTowerController.instance:sendPM_HonorTowerRankViewReq(leaf)
	elseif root == GameEnum.RankType.PowerSurgeRank then
		-- block empty
	else
		self._isDataInit[root] = self._isDataInit[root] or {}
		self._isDataInit[root][leaf] = true

		GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
	end
end

function RankModel:_onTLCRankInfoRes(msg, root, leaf)
	local tem = RankModel.instance:creteTempMo(msg)

	RankModel.instance:setRankData(tem, root, leaf)
	GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
end

function RankModel:creteTempMo(msg)
	local tem = {}

	tem.rankList = msg.infoList
	tem.myRank = checknumber(msg.myRank)
	tem.rankSize = checknumber(msg.rankSize)

	return tem
end

function RankModel:getRankMo(root, leaf)
	if self._rankMos[root] then
		return self._rankMos[root][leaf]
	else
		return nil
	end
end

function RankModel:getIsDataInit(root, leaf)
	if self._isDataInit[root] then
		if root == GameEnum.RankType.BreakFormation then
			return ServerTime.now() - checknumber(self._isDataInit[root][leaf]) <= 30
		else
			return checknumber(self._isDataInit[root][leaf]) > 0
		end
	else
		return false
	end
end

RankModel.instance = RankModel.New()

return RankModel
