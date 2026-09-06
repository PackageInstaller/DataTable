-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickapet/config/PickAPetConfig.lua

module("logic.extensions.pickapet.config.PickAPetConfig", package.seeall)

local PickAPetConfig = class("PickAPetConfig", BaseConfig)

function PickAPetConfig:onInit()
	PickAPetConfig.super.onInit(self)

	self._cofignameCfg = nil
	self._levelCfg = nil
end

function PickAPetConfig:getNames()
	return {
		"pickApet",
		"pickLevel"
	}
end

function PickAPetConfig:handleConfig(name, content)
	if name == "pickApet" then
		self._cofignameCfg = content
	elseif name == "pickLevel" then
		self._levelCfg = content
	end
end

function PickAPetConfig:getCfgById(id)
	return self._cofignameCfg[id]
end

function PickAPetConfig:getLevelCfg(id)
	return self._levelCfg[id]
end

PickAPetConfig.instance = PickAPetConfig.New()

return PickAPetConfig
