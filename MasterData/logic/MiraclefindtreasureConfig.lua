-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclefindtreasure/config/MiraclefindtreasureConfig.lua

module("logic.extensions.miraclefindtreasure.config.MiraclefindtreasureConfig", package.seeall)

local MiraclefindtreasureConfig = class("MiraclefindtreasureConfig", BaseConfig)

function MiraclefindtreasureConfig:onInit()
	return
end

function MiraclefindtreasureConfig:getNames()
	return {
		"miracle_find_treasure_activity",
		"miracle_find_treasure_prize",
		"miracle_find_treasure_target"
	}
end

function MiraclefindtreasureConfig:handleConfig(name, content)
	if name == "miracle_find_treasure_activity" then
		self._miracle_find_treasure_activity = content
	elseif name == "miracle_find_treasure_prize" then
		self._miracle_find_treasure_prize = content
	elseif name == "miracle_find_treasure_target" then
		self._miracle_find_treasure_target = content
	end
end

function MiraclefindtreasureConfig:getTargetCfgById(targetId)
	return self._miracle_find_treasure_target[targetId]
end

function MiraclefindtreasureConfig:getPrizeCfgs(activityId)
	return self._miracle_find_treasure_prize[activityId]
end

function MiraclefindtreasureConfig:getPrizeCfg(activityId, prizeId)
	return self._miracle_find_treasure_prize[activityId][prizeId]
end

function MiraclefindtreasureConfig:getActCfg(activityId)
	return self._miracle_find_treasure_activity[activityId]
end

MiraclefindtreasureConfig.instance = MiraclefindtreasureConfig.New()

return MiraclefindtreasureConfig
