-- chunkname: @modules/logic/versionactivity2_8/nuodika/config/NuoDiKaConfig.lua

module("modules.logic.versionactivity2_8.nuodika.config.NuoDiKaConfig", package.seeall)

local NuoDiKaConfig = class("NuoDiKaConfig", BaseConfig)

function NuoDiKaConfig:onInit()
	self:reInit()
end

function NuoDiKaConfig:reInit()
	return
end

function NuoDiKaConfig:reqConfigNames()
	return {
		"activity_nuodika_180_const",
		"activity_nuodika_180_event",
		"activity_nuodika_180_enemy",
		"activity_nuodika_180_item",
		"activity_nuodika_180_skill"
	}
end

function NuoDiKaConfig:getMapCo(mapId)
	local mapCo = addGlobalModule("modules.configs.nuodika.lua_nuodika_map_" .. tostring(mapId), "lua_nuodika_map_" .. tostring(mapId))

	if not mapCo then
		logError("诺谛卡地图配置不存在" .. mapId)

		return
	end

	return mapCo
end

function NuoDiKaConfig:getEpisodeCoList(activityId)
	return (WuErLiXiConfig.instance:getEpisodeCoList(activityId))
end

function NuoDiKaConfig:getEpisodeCo(activityId, episodeId)
	return (WuErLiXiConfig.instance:getEpisodeCo(activityId, episodeId))
end

function NuoDiKaConfig:getTaskByActId(activityId)
	return (WuErLiXiConfig.instance:getTaskByActId(activityId))
end

function NuoDiKaConfig:getEventList()
	return lua_activity_nuodika_180_event.configList
end

function NuoDiKaConfig:getEventCo(eventId)
	return lua_activity_nuodika_180_event.configDict[eventId]
end

function NuoDiKaConfig:getEnemyList()
	local list = {}

	for _, enemy in pairs(lua_activity_nuodika_180_enemy.configList) do
		if enemy.main == NuoDiKaEnum.EnemyType.Normal then
			table.insert(list, enemy)
		end
	end

	return list
end

function NuoDiKaConfig:getMainRoleList()
	local list = {}

	for _, enemy in pairs(lua_activity_nuodika_180_enemy.configList) do
		if enemy.main == NuoDiKaEnum.EnemyType.MainRole then
			table.insert(list, enemy)
		end
	end

	return list
end

function NuoDiKaConfig:getEnemyCo(enemyId)
	return lua_activity_nuodika_180_enemy.configDict[enemyId]
end

function NuoDiKaConfig:getItemList()
	return lua_activity_nuodika_180_item.configList
end

function NuoDiKaConfig:getItemCo(itemId)
	return lua_activity_nuodika_180_item.configDict[itemId]
end

function NuoDiKaConfig:getConstCo(constId)
	local actId = VersionActivity2_8Enum.ActivityId.NuoDiKa

	return lua_activity_nuodika_180_const.configDict[actId][constId]
end

function NuoDiKaConfig:getSkillCo(skillId)
	return lua_activity_nuodika_180_skill.configDict[skillId]
end

NuoDiKaConfig.instance = NuoDiKaConfig.New()

return NuoDiKaConfig
