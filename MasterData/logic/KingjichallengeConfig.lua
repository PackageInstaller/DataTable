-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/config/KingjichallengeConfig.lua

module("logic.extensions.kingjichallenge.config.KingjichallengeConfig", package.seeall)

local KingjichallengeConfig = class("KingjichallengeConfig", BaseConfig)

function KingjichallengeConfig:onInit()
	return
end

function KingjichallengeConfig:getNames()
	return {
		"king_ji_challenge",
		"king_ji_courier_stage",
		"king_ji_courier_prize",
		"king_ji_soul_stage",
		"king_ji_soul_stage_plan",
		"king_ji_soul_prize",
		"king_ji_mix_stage",
		"king_ji_pass_plan",
		"king_ji_master",
		"king_ji_creeps"
	}
end

function KingjichallengeConfig:handleConfig(name, content)
	if name == "king_ji_challenge" then
		self._king_ji_challenge = content
	elseif name == "king_ji_courier_stage" then
		self._king_ji_courier_stage = content
	elseif name == "king_ji_courier_prize" then
		self._king_ji_courier_prize = content
	elseif name == "king_ji_soul_stage" then
		self._king_ji_soul_stage = content
	elseif name == "king_ji_soul_stage_plan" then
		self._king_ji_soul_stage_plan = content
	elseif name == "king_ji_soul_prize" then
		self._king_ji_soul_prize = content
	elseif name == "king_ji_mix_stage" then
		self._king_ji_mix_stage = content
	elseif name == "king_ji_pass_plan" then
		self._king_ji_pass_plan = content
	elseif name == "king_ji_master" then
		self._king_ji_master = content
	elseif name == "king_ji_creeps" then
		self._king_ji_creeps = content
	end
end

function KingjichallengeConfig:getRankJumpTo(activityId)
	return self._king_ji_challenge[activityId].rankJumpTo
end

function KingjichallengeConfig:getLotterJumpTo(activityId)
	return self._king_ji_challenge[activityId].lotterJumpTo
end

function KingjichallengeConfig:getAttrJumpTo(activityId)
	return self._king_ji_challenge[activityId].attrJumpTo
end

function KingjichallengeConfig:getActivityCfg(activityId)
	return self._king_ji_challenge[activityId]
end

function KingjichallengeConfig:getCourierPrizeCfgs(activityId)
	return self._king_ji_courier_prize[activityId]
end

function KingjichallengeConfig:getCourierPrizeCfg(activityId, prizeId)
	return self._king_ji_courier_prize[activityId][prizeId]
end

function KingjichallengeConfig:getCourierStageCfgs(activityId)
	return self._king_ji_courier_stage[activityId]
end

function KingjichallengeConfig:getCourierStageCfg(activityId, stageId)
	return self._king_ji_courier_stage[activityId][stageId]
end

function KingjichallengeConfig:getCourierPrizeDamages(activityId)
	local list = {}

	for i, v in ipairs(self:getCourierPrizeCfgs(activityId)) do
		table.insert(list, v.damage)
	end

	return list
end

function KingjichallengeConfig:getSoulPrizeCfgs(activityId)
	return self._king_ji_soul_prize[activityId]
end

function KingjichallengeConfig:getSoulPrizeCfg(activityId, prizeId)
	return self._king_ji_soul_prize[activityId][prizeId]
end

function KingjichallengeConfig:getSoulStageCfg(activityId, stageId)
	return self._king_ji_soul_stage[activityId][stageId]
end

function KingjichallengeConfig:getSoulStagePlanCfgs(activityId, stageId)
	local cfg = self._king_ji_soul_stage[activityId][stageId]

	return self._king_ji_soul_stage_plan[cfg.stagePlanId]
end

function KingjichallengeConfig:getSoulPrizePassStages(activityId)
	local list = {}

	for i, v in ipairs(self:getSoulPrizeCfgs(activityId)) do
		table.insert(list, v.progress)
	end

	return list
end

function KingjichallengeConfig:getSoulMaxSmallStageNum(activityId, stageId)
	local cfgs = self:getSoulStagePlanCfgs(activityId, stageId)
	local num = 0

	for k, v in pairs(cfgs) do
		num = num + 1
	end

	return num
end

function KingjichallengeConfig:getSoulBtnIconName(activityId, stageId)
	local cfg = self._king_ji_soul_stage[activityId][stageId]

	return cfg.btnIcon
end

function KingjichallengeConfig:getSoulSmallStageBuffDesc(activityId, stageId, smallStageId)
	local cfgs = self:getSoulStagePlanCfgs(activityId, stageId)

	return cfgs[smallStageId].buffDesc
end

function KingjichallengeConfig:getMixStageCfgs(activityId)
	return self._king_ji_mix_stage[activityId]
end

function KingjichallengeConfig:getMixStageCfg(activityId, stageId)
	return self._king_ji_mix_stage[activityId][stageId]
end

function KingjichallengeConfig:getMixStagePlanCfgs(activityId, stageId)
	local cfg = self._king_ji_mix_stage[activityId][stageId]

	return self._king_ji_pass_plan[cfg.passPlanId]
end

function KingjichallengeConfig:getMixStageCreepsMasterIds(activityId, stageId)
	local cfg = self._king_ji_mix_stage[activityId][stageId]

	return cfg.creepsMasterIds
end

function KingjichallengeConfig:getCourierDailyChallengeTimes(activityId)
	return self._king_ji_challenge[activityId].courierDailyChallengeTimes
end

function KingjichallengeConfig:getCreepMonstersCfgs(creepsMasterId)
	return self._king_ji_creeps[creepsMasterId]
end

function KingjichallengeConfig:getCreepMasterCfg(creepsMasterId)
	return self._king_ji_master[creepsMasterId]
end

function KingjichallengeConfig:getActShowRaceId(activityId)
	return self._king_ji_challenge[activityId].raceId
end

KingjichallengeConfig.instance = KingjichallengeConfig.New()

return KingjichallengeConfig
