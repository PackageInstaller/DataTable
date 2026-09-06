-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plantgodtree/config/PlantGodTreeConfig.lua

module("logic.extensions.planetarium.config.PlantGodTreeConfig", package.seeall)

local PlantGodTreeConfig = class("PlantGodTreeConfig", BaseConfig)

function PlantGodTreeConfig:onInit()
	PlantGodTreeConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function PlantGodTreeConfig:getNames()
	return {
		"plant_god_tree_activity",
		"plant_god_tree_tree",
		"plant_god_tree_event"
	}
end

function PlantGodTreeConfig:handleConfig(name, content)
	if name == "plant_god_tree_activity" then
		self._plant_god_tree_activity = content
	elseif name == "plant_god_tree_tree" then
		self._plant_god_tree_tree = content
	elseif name == "plant_god_tree_event" then
		self._plant_god_tree_event = content
	end
end

function PlantGodTreeConfig:getActCfg(activityId)
	return self._plant_god_tree_activity[activityId]
end

function PlantGodTreeConfig:getTreeCfg(activityId)
	return self._plant_god_tree_tree[activityId]
end

function PlantGodTreeConfig:getTreeCfgById(activityId, treeId)
	return self._plant_god_tree_tree[activityId] and self._plant_god_tree_tree[activityId][treeId]
end

function PlantGodTreeConfig:getEventCfg(activityId)
	return self._plant_god_tree_event[activityId]
end

function PlantGodTreeConfig:getEventCfgByEventId(activityId, eventId)
	return self._plant_god_tree_event[activityId] and self._plant_god_tree_event[activityId][eventId]
end

PlantGodTreeConfig.instance = PlantGodTreeConfig.New()

return PlantGodTreeConfig
