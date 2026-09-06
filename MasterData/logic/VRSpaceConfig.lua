-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/config/VRSpaceConfig.lua

module("logic.extensions.vrspace.config.VRSpaceConfig", package.seeall)

local VRSpaceConfig = class("VRSpaceConfig", BaseConfig)

function VRSpaceConfig:getNames()
	return {
		"vr_space_activity",
		"vr_space_rank_prize",
		"vr_space_stage",
		"vr_space_mode_plan",
		"vr_space_monster",
		"vr_space_creeps"
	}
end

function VRSpaceConfig:handleConfig(name, content)
	if name == "vr_space_activity" then
		self._vr_space_activity = content
	elseif name == "vr_space_rank_prize" then
		self._vr_space_rank_prize = content
	elseif name == "vr_space_stage" then
		self._vr_space_stage = content
	elseif name == "vr_space_mode_plan" then
		self._vr_space_mode_plan = content
	elseif name == "vr_space_monster" then
		self._vr_space_monster = content
	elseif name == "vr_space_creeps" then
		self._vr_space_creeps = content
	end
end

function VRSpaceConfig:getActivityCfgById(activityId)
	return self._vr_space_activity[activityId]
end

function VRSpaceConfig:getPlanCfgById(activityId, mode, spaceType)
	if self._vr_space_mode_plan[activityId] and self._vr_space_mode_plan[activityId][mode] then
		return self._vr_space_mode_plan[activityId][mode][spaceType]
	end
end

function VRSpaceConfig:getStageCfgById(planId, stageId)
	if self._vr_space_stage[planId] then
		return self._vr_space_stage[planId][stageId]
	end
end

function VRSpaceConfig:getStageCfgListById(planId)
	return self._vr_space_stage[planId]
end

function VRSpaceConfig:getMonsterCfgById(id)
	return self._vr_space_monster[id]
end

function VRSpaceConfig:getCreepsCfgById(id)
	return self._vr_space_creeps[id]
end

function VRSpaceConfig:getRankListCfgById(activityId)
	return self._vr_space_rank_prize[activityId]
end

VRSpaceConfig.instance = VRSpaceConfig.New()

return VRSpaceConfig
