-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineasheslessdragon/config/DivineasheslessdragonConfig.lua

module("logic.extensions.divineasheslessdragon.config.DivineasheslessdragonConfig", package.seeall)

local DivineasheslessdragonConfig = class("DivineasheslessdragonConfig", BaseConfig)

function DivineasheslessdragonConfig:onInit()
	return
end

function DivineasheslessdragonConfig:getNames()
	return {
		"divine_ashesless_dragon_activity",
		"divine_ashesless_dragon_stage",
		"divine_ashesless_dragon_master",
		"divine_ashesless_dragon_creeps"
	}
end

function DivineasheslessdragonConfig:handleConfig(name, content)
	if name == "divine_ashesless_dragon_activity" then
		self._divine_ashesless_dragon_activity = content
	elseif name == "divine_ashesless_dragon_stage" then
		self._divine_ashesless_dragon_stage = content
	elseif name == "divine_ashesless_dragon_master" then
		self._divine_ashesless_dragon_master = content
	elseif name == "divine_ashesless_dragon_creeps" then
		self._divine_ashesless_dragon_creeps = content
	end
end

function DivineasheslessdragonConfig:getActCfg(activityId)
	return self._divine_ashesless_dragon_activity[activityId]
end

function DivineasheslessdragonConfig:getStageCfgs(activityId)
	return self._divine_ashesless_dragon_stage[activityId]
end

function DivineasheslessdragonConfig:getCreepsCfgs(creepsMasterId)
	return self._divine_ashesless_dragon_creeps[creepsMasterId]
end

function DivineasheslessdragonConfig:getMasterCfg(creepsMasterId)
	return self._divine_ashesless_dragon_master[creepsMasterId]
end

function DivineasheslessdragonConfig:getSkinId(activityId)
	return self._divine_ashesless_dragon_activity[activityId].skinId
end

function DivineasheslessdragonConfig:getRuleKey(activityId, ruleKey)
	return self._divine_ashesless_dragon_activity[activityId][ruleKey]
end

DivineasheslessdragonConfig.instance = DivineasheslessdragonConfig.New()

return DivineasheslessdragonConfig
