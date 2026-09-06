-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehope/config/DivinehopeConfig.lua

module("logic.extensions.divinehope.config.DivinehopeConfig", package.seeall)

local DivinehopeConfig = class("DivinehopeConfig", BaseConfig)

function DivinehopeConfig:onInit()
	return
end

function DivinehopeConfig:getNames()
	return {
		"divine_hope_floor",
		"divine_hope_wish",
		"divine_hope_stage",
		"divine_hope_master",
		"divine_hope_activity",
		"divine_hope_creeps"
	}
end

function DivinehopeConfig:handleConfig(name, content)
	if name == "divine_hope_floor" then
		self._divine_hope_floor = content
	elseif name == "divine_hope_wish" then
		self._divine_hope_wish = content
	elseif name == "divine_hope_stage" then
		self._divine_hope_stage = content
	elseif name == "divine_hope_master" then
		self._divine_hope_master = content
	elseif name == "divine_hope_activity" then
		self._divine_hope_activity = content
	elseif name == "divine_hope_creeps" then
		self._divine_hope_creeps = content
	end
end

function DivinehopeConfig:getActCfg(activityId)
	return self._divine_hope_activity[activityId]
end

function DivinehopeConfig:getSkinId(activityId)
	return self._divine_hope_activity[activityId].skinId
end

function DivinehopeConfig:getFloorCfgs(activityId)
	return self._divine_hope_floor[activityId]
end

function DivinehopeConfig:getFloorCfg(activityId, floorId)
	return self._divine_hope_floor[activityId][floorId]
end

function DivinehopeConfig:getStageCfgs(stagePlanId)
	return self._divine_hope_stage[stagePlanId]
end

function DivinehopeConfig:getStageCfgsByFloor(activityId, floorId)
	local floorCfg = self:getFloorCfg(activityId, floorId)

	return self._divine_hope_stage[floorCfg.stagePlanId]
end

function DivinehopeConfig:getStageCfg(stagePlanId, stageId)
	return self._divine_hope_stage[stagePlanId][stageId]
end

function DivinehopeConfig:getWishCfg(activityId, wishId)
	return self._divine_hope_wish[activityId][wishId]
end

function DivinehopeConfig:getCreepsCfgs(creepsMasterId)
	return self._divine_hope_creeps[creepsMasterId]
end

function DivinehopeConfig:getCreepsMasterCfg(creepsMasterId)
	return self._divine_hope_master[creepsMasterId]
end

DivinehopeConfig.instance = DivinehopeConfig.New()

return DivinehopeConfig
