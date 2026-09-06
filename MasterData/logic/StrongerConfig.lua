-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stronger/config/StrongerConfig.lua

module("logic.extensions.stronger.config.StrongerConfig", package.seeall)

local StrongerConfig = class("StrongerConfig", BaseConfig)

function StrongerConfig:onInit()
	StrongerConfig.super.onInit(self)

	self._strongerCfg = nil
	self._strongerPageCfg = nil
end

function StrongerConfig:getNames()
	return {
		"stronger",
		"stronger_page"
	}
end

function StrongerConfig:handleConfig(name, content)
	if name == "stronger" then
		self._strongerCfg = content
	elseif name == "stronger_page" then
		self._strongerPageCfg = content
	end
end

function StrongerConfig:getStrongerCfgById(id)
	return self._strongerCfg[id]
end

function StrongerConfig:getStrongerCfgs()
	return self._strongerCfg
end

function StrongerConfig:getStrongerPageCfgsById(id)
	return self._strongerPageCfg[id]
end

StrongerConfig.instance = StrongerConfig.New()

return StrongerConfig
