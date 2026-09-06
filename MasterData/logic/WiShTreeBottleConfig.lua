-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtreebottle/config/WiShTreeBottleConfig.lua

module("logic.extensions.wishtreebottle.config.WiShTreeBottleConfig", package.seeall)

local WiShTreeBottleConfig = class("WiShTreeBottleConfig", BaseConfig)

function WiShTreeBottleConfig:onInit()
	WiShTreeBottleConfig.super.onInit(self)
end

function WiShTreeBottleConfig:getNames()
	return {
		"wish_tree_bottle_activity",
		"wish_tree_bottle_system",
		"wish_tree_bottle_type",
		"wish_tree_bottle_title"
	}
end

function WiShTreeBottleConfig:handleConfig(name, content)
	if name == "wish_tree_bottle_activity" then
		self._wtbActCfg = content
	elseif name == "wish_tree_bottle_system" then
		self._wtbSystemCfg = content
	elseif name == "wish_tree_bottle_type" then
		self._wtbTypeCfg = content
	elseif name == "wish_tree_bottle_title" then
		self._wtbTitleCfg = content
	end
end

function WiShTreeBottleConfig:getWtbActCfg(activityId)
	return self._wtbActCfg[activityId]
end

function WiShTreeBottleConfig:getWtbSystemCfg(activityId)
	return self._wtbSystemCfg[activityId]
end

function WiShTreeBottleConfig:getWtbSystemCfgById(activityId, targetUserId)
	local id = Mathf.Abs(targetUserId)

	return self._wtbSystemCfg[activityId][id]
end

function WiShTreeBottleConfig:getWtbTypeCfg(activityId)
	return self._wtbTypeCfg[activityId]
end

function WiShTreeBottleConfig:getWtbTypeCfgById(activityId, id)
	return self._wtbTypeCfg[activityId][id]
end

function WiShTreeBottleConfig:getWtbTitleCfg(activityId)
	return self._wtbTitleCfg[activityId]
end

function WiShTreeBottleConfig:getWtbTitleCfgById(activityId, titleId)
	return self._wtbTitleCfg[activityId][titleId]
end

WiShTreeBottleConfig.instance = WiShTreeBottleConfig.New()

return WiShTreeBottleConfig
