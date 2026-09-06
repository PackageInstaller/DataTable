-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mofang/config/MofangConfig.lua

module("logic.extensions.mofang.config.MofangConfig", package.seeall)

local MofangConfig = class("MofangConfig", BaseConfig)

function MofangConfig:onInit()
	MofangConfig.super.onInit(self)

	self._mofangCfg = {}
end

function MofangConfig:getNames()
	return {
		"player_level_config"
	}
end

function MofangConfig:handleConfig(name, content)
	if name == "player_level_config" then
		self._mofangCfg = content
	end

	self._maxPower = self._mofangCfg[#self._mofangCfg].lowestTotalExperience
end

function MofangConfig:getMaxPower()
	return self._maxPower
end

function MofangConfig:getLvCfg()
	return self._mofangCfg
end

function MofangConfig:getCfgNum()
	return #self._mofangCfg
end

function MofangConfig:getCfgById(id)
	return self._mofangCfg[id]
end

MofangConfig.instance = MofangConfig.New()

return MofangConfig
