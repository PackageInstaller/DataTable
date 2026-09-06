-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/config/MangTowerConfig.lua

module(..., package.seeall)

local MangTowerConfig = class("MangTowerConfig", BaseConfig)

function MangTowerConfig:onInit()
	return
end

function MangTowerConfig:getNames()
	return {
		"pursue_dream_activity",
		"pursue_dream_monster",
		"pursue_dream_creep",
		"pursue_dream_buff",
		"pursue_dream_common"
	}
end

function MangTowerConfig:handleConfig(name, content)
	if name == "pursue_dream_activity" then
		self._actCfg = content
	elseif name == "pursue_dream_monster" then
		self._monsterCfg = content
	elseif name == "pursue_dream_creep" then
		self._creepCfg = content
	elseif name == "pursue_dream_buff" then
		self._buffCfg = content
	elseif name == "pursue_dream_common" then
		self._commonCfg = content
	end
end

function MangTowerConfig:getActCfg(activityId)
	return self._actCfg[activityId]
end

function MangTowerConfig:getMonsterCfg(planId, type)
	return self._monsterCfg[planId][type]
end

function MangTowerConfig:getCreepCfg(creepsMasterId)
	return self._creepCfg[creepsMasterId]
end

function MangTowerConfig:getBuffCfg(planId)
	return self._buffCfg[planId]
end

function MangTowerConfig:getCommonCfg(key)
	return self._commonCfg[key].value
end

MangTowerConfig.instance = MangTowerConfig.New()

return MangTowerConfig
