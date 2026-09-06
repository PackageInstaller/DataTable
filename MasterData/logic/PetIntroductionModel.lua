-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petintroduction/model/PetIntroductionModel.lua

module("logic.extensions.petintroduction.model.PetIntroductionModel", package.seeall)

local PetIntroductionModel = class("PetIntroductionModel", BaseModel)

function PetIntroductionModel:getIntroducePetId()
	local raceId = self:getPlotCopyIntroducePetId()

	if raceId and raceId > 0 then
		return raceId
	end

	raceId = self:getResCopyIntroducePetId()

	if raceId and raceId > 0 then
		return raceId
	end

	raceId = self:getPVEIntroducePetId()

	if raceId and raceId > 0 then
		return raceId
	end

	raceId = self:getWTowerIntroducePetId()

	if raceId and raceId > 0 then
		return raceId
	end

	raceId = self:getBreakFormationIntroducePetId()

	if raceId and raceId > 0 then
		return raceId
	end

	raceId = self:getLegendIntroducePetId()

	if raceId and raceId > 0 then
		return raceId
	end

	raceId = self:getKingRoadIntroducePetId()

	if raceId and raceId > 0 then
		return raceId
	end

	raceId = self:getKingWayIntroducePetId()

	if raceId and raceId > 0 then
		return raceId
	end

	raceId = self:getNinePalaceIntroducePetId()

	if raceId and raceId > 0 then
		return raceId
	end
end

function PetIntroductionModel:getPlotCopyIntroducePetId()
	local copyId = BattleModel.instance.copyId
	local copyLevelId = BattleModel.instance.copyLevelId
	local copyPassed = BattleModel.instance.copyPassed

	if copyId and copyLevelId and not copyPassed then
		local stageCo = CopyConfig.instance:getStageById(copyId, copyLevelId)
		local teamCo = CopyConfig.instance:getTeamCfg(stageCo.teamIds)

		return teamCo.introdRaceId
	end

	return 0
end

function PetIntroductionModel:getResCopyIntroducePetId()
	local chapterId = BattleModel.instance.resChapterId
	local stageId = BattleModel.instance.resStageId
	local resStagePassed = BattleModel.instance.resStagePassed

	if chapterId and stageId and not resStagePassed then
		local stageCo = MaterialChallengeConfig.instance:getStageById(chapterId, stageId)
		local teamCo = MaterialChallengeConfig.instance:getTeamCfg(stageCo.teamIds)

		return teamCo.introdRaceId
	end

	return 0
end

function PetIntroductionModel:getPVEIntroducePetId()
	local pveId = BattleModel.instance.pveId

	if pveId and pveId > 0 then
		local teamCo = CopyConfig.instance:getTeamCfg(pveId)

		return teamCo.introdRaceId
	end

	return 0
end

function PetIntroductionModel:getWTowerIntroducePetId()
	local wtowerIndex = BattleModel.instance.wtowerIndex
	local towerId = WTowerModel.instance:getTowerId()

	if wtowerIndex and wtowerIndex > 0 then
		local wtowerCo = WTowerConfig.instance:getCfgById(wtowerIndex, towerId)

		return wtowerCo.introdRaceId
	end

	return 0
end

function PetIntroductionModel:getKingRoadIntroducePetId()
	local kindRoadId = BattleModel.instance.kindRoadId
	local kindRoadPassed = BattleModel.instance.kindRoadPassed

	if kindRoadId and kindRoadId > 0 and not kindRoadPassed then
		local kindRoadCo = PetTrialConfig.instance:getStageCfgById(kindRoadId)

		return kindRoadCo.introdRaceId
	end

	return 0
end

function PetIntroductionModel:getKingWayIntroducePetId()
	local kingWayId = BattleModel.instance.kingWayId
	local kingWayStageId = BattleModel.instance.kingWayStageId
	local kingWayPassed = BattleModel.instance.kingWayPassed

	if kingWayId and kingWayId > 0 and kingWayStageId and kingWayStageId > 0 and not kingWayPassed then
		local allCfgs = KingWayConfig.instance:GetWayStageCfg(kingWayId)

		if allCfgs == nil or allCfgs[kingWayStageId] == nil then
			return 0
		end

		local cfg = allCfgs[kingWayStageId]

		return cfg.introdRaceId or 0
	end

	return 0
end

function PetIntroductionModel:getBreakFormationIntroducePetId()
	local breakFormationId = BattleModel.instance.breakFormationId
	local breakFormationLvId = BattleModel.instance.breakFormationLvId

	if breakFormationId and breakFormationId > 0 and breakFormationLvId and breakFormationLvId > 0 then
		local key = "pet_intr_bf_" .. breakFormationId .. "_" .. breakFormationLvId
		local pass = UnityEngine.PlayerPrefs.GetInt(key, 0) == 1

		if not pass then
			local cfg = BreakFormationConfig.instance:getMonsterCfg(breakFormationId, breakFormationLvId)

			return cfg.introdRaceId
		end
	end

	return 0
end

function PetIntroductionModel:saveBreakFormationIntroduce()
	local breakFormationId = BattleModel.instance.breakFormationId
	local breakFormationLvId = BattleModel.instance.breakFormationLvId

	if breakFormationId and breakFormationId > 0 and breakFormationLvId and breakFormationLvId > 0 then
		local key = "pet_intr_bf_" .. breakFormationId .. "_" .. breakFormationLvId

		UnityEngine.PlayerPrefs.GetInt(key, 1)
	end
end

function PetIntroductionModel:getLegendIntroducePetId()
	local legendChallengeId = BattleModel.instance.legendChallengeId
	local legendStageIdId = BattleModel.instance.legendStageIdId
	local legendPassed = BattleModel.instance.legendPassed

	if legendChallengeId and legendChallengeId > 0 and legendStageIdId and legendStageIdId > 0 and not legendPassed then
		local cfg = LegendConfig.instance:getLegendChallengeStageCfg(legendChallengeId, legendStageIdId)

		return cfg.introdRaceId
	end

	return 0
end

function PetIntroductionModel:getNinePalaceIntroducePetId()
	local nightPalaceStageId = BattleModel.instance.nightPalaceStageId
	local nightPalaceMasterId = BattleModel.instance.nightPalaceMasterId
	local nightPalaceStagePassed = BattleModel.instance.nightPalaceStagePassed

	if nightPalaceStageId and nightPalaceStageId > 0 and nightPalaceMasterId and not nightPalaceStagePassed then
		local cfg = NinePlaceConfig.instance:getMonsterCfg(nightPalaceStageId, nightPalaceMasterId)

		return cfg.introdRaceId
	end

	return 0
end

PetIntroductionModel.instance = PetIntroductionModel.New()

return PetIntroductionModel
