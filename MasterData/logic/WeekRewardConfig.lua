-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weekreward/config/WeekRewardConfig.lua

module("logic.extensions.weekreward.config.WeekRewardConfig", package.seeall)

local WeekRewardConfig = class("WeekRewardConfig", BaseConfig)

function WeekRewardConfig:onInit()
	WeekRewardConfig.super.onInit(self)

	self._config = nil
end

function WeekRewardConfig:getNames()
	return {
		"battle_item"
	}
end

function WeekRewardConfig:handleConfig(name, content)
	if name == "battle_item" then
		self._config = content
	end
end

function WeekRewardConfig:getCfgById(id)
	return self._config[id]
end

WeekRewardConfig.instance = WeekRewardConfig.New()

return WeekRewardConfig
