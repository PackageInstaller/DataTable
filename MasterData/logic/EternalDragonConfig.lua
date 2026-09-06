-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternaldragon/config/EternalDragonConfig.lua

module("logic.extensions.eternaldragon.config.EternalDragonConfig", package.seeall)

local EternalDragonConfig = class("EternalDragonConfig", BaseConfig)

function EternalDragonConfig:onInit()
	EternalDragonConfig.super.onInit(self)
end

function EternalDragonConfig:getNames()
	return {
		"eternal_dragon_activity",
		"eternal_dragon_score",
		"eternal_dragon_story",
		"eternal_dragon_common"
	}
end

function EternalDragonConfig:handleConfig(name, content)
	if name == "eternal_dragon_activity" then
		self._edActCfg = content
	elseif name == "eternal_dragon_score" then
		self._edScoreCfg = content
	elseif name == "eternal_dragon_story" then
		self._edStoryCfg = content
	elseif name == "eternal_dragon_common" then
		self._edCommonCfg = content
	end
end

function EternalDragonConfig:getEdActData(activityId)
	return self._edActCfg[activityId]
end

function EternalDragonConfig:getEdScoreDataList(activityId)
	return self._edScoreCfg[activityId]
end

function EternalDragonConfig:getEdScoreData(activityId, id)
	return self._edScoreCfg[activityId][id]
end

function EternalDragonConfig:getEdStoryData(storyId)
	return self._edStoryCfg[storyId]
end

function EternalDragonConfig:getEdCommonValue(activityId, key)
	local actData = self:getEdActData(activityId)

	if actData then
		if not actData.comPlanId then
			local comPlanId = 0
			local data = self._edCommonCfg[comPlanId]

			if data then
				return data[key]
			end
		end
	end
end

EternalDragonConfig.instance = EternalDragonConfig.New()

return EternalDragonConfig
