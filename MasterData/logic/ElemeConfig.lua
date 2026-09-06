-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eleme/config/ElemeConfig.lua

module("logic.extensions.eleme.config.ElemeConfig", package.seeall)

local ElemeConfig = class("ElemeConfig", BaseConfig)

function ElemeConfig:getNames()
	return {
		"eleme_activity",
		"eleme_order",
		"eleme_npc",
		"eleme_prize",
		"eleme_master",
		"eleme_creeps"
	}
end

function ElemeConfig:handleConfig(name, content)
	if name == "eleme_activity" then
		self._eleme_activity = content
	elseif name == "eleme_order" then
		self._eleme_order = content
	elseif name == "eleme_npc" then
		self._eleme_npc = content
	elseif name == "eleme_prize" then
		self._eleme_prize = content
	elseif name == "eleme_master" then
		self._eleme_master = content
	elseif name == "eleme_creeps" then
		self._eleme_creeps = content
	end
end

function ElemeConfig:getActivityCfgById(id)
	return self._eleme_activity[id]
end

function ElemeConfig:getOrderByActId(activityId, orderId)
	if self._eleme_order[activityId] then
		return self._eleme_order[activityId][orderId]
	end
end

function ElemeConfig:getOrderListByActId(activityId)
	return self._eleme_order[activityId]
end

function ElemeConfig:getNpcById(index)
	return self._eleme_npc[index] or {}
end

function ElemeConfig:getPrizeList(activityId)
	return self._eleme_prize[activityId]
end

function ElemeConfig:getMonsterCfgById(creepsMasterId)
	return self._eleme_master[creepsMasterId]
end

function ElemeConfig:getCreepsCfgById(creepsMasterId)
	return self._eleme_creeps[creepsMasterId]
end

ElemeConfig.instance = ElemeConfig.New()

return ElemeConfig
