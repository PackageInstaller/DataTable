-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/config/PkConfig.lua

module("logic.extensions.pk.config.PkConfig", package.seeall)

local PkConfig = class("PkConfig", BaseConfig)

function PkConfig:onInit()
	PkConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function PkConfig:getNames()
	return {
		"qie_cuo_common"
	}
end

function PkConfig:handleConfig(name, content)
	if name == "qie_cuo_common" then
		self._common = content
	end
end

function PkConfig:getCommonByKey(key)
	return self._common[key].value
end

PkConfig.instance = PkConfig.New()

return PkConfig
