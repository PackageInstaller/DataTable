-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/config/MainActivityConfig.lua

module("logic.extensions.mainui.config.MainActivityConfig", package.seeall)

local MainActivityConfig = class("MainActivityConfig", BaseConfig)

function MainActivityConfig:onInit()
	MainActivityConfig.super.onInit(self)
end

function MainActivityConfig:getNames()
	return {
		"mainui_redpoint"
	}
end

function MainActivityConfig:handleConfig(name, content)
	if name == "mainui_redpoint" then
		self._mainui_redpoint = content
	end
end

function MainActivityConfig:getRedPointCfg()
	return self._mainui_redpoint.dataList
end

MainActivityConfig.instance = MainActivityConfig.New()

return MainActivityConfig
