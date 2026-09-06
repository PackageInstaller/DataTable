-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/improveinfo/config/ImproveInfoConfig.lua

module("logic.extensions.improveinfo.config.ImproveInfoConfig", package.seeall)

local ImproveInfoConfig = class("ImproveInfoConfig", BaseConfig)

function ImproveInfoConfig:onInit()
	ImproveInfoConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function ImproveInfoConfig:getNames()
	return {
		"player_check_in_prize"
	}
end

function ImproveInfoConfig:handleConfig(name, content)
	if name == "player_check_in_prize" then
		self._prize = content
	end
end

function ImproveInfoConfig:getPrize()
	return self._prize
end

ImproveInfoConfig.instance = ImproveInfoConfig.New()

return ImproveInfoConfig
