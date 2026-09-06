-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/config/ConstConfig.lua

module("logic.extensions.config.ConstConfig", package.seeall)

local ConstConfig = class("ConstConfig", BaseConfig)

function ConstConfig:onInit()
	self._constCfg = nil
end

function ConstConfig:init()
	ConfigMgr.instance:requestConfig("const", self)
end

function ConstConfig:getNames()
	return {
		"const"
	}
end

function ConstConfig:handleConfig(name, content)
	if name == "const" then
		self._constCfg = content
	end
end

function ConstConfig:getConstConfig()
	return self._constCfg
end

function ConstConfig:getConstDataByKey(key)
	return self._constCfg[key]
end

function ConstConfig:getStrValueByKey(key)
	if self._constCfg[key] then
		return self._constCfg[key].strValue
	end

	return ""
end

function ConstConfig:getNumValueByKey(key)
	if self._constCfg[key] then
		return self._constCfg[key].numValue
	end

	return 0
end

function ConstConfig:getPetLimltCount()
	return self:getNumValueByKey("bagSpiritLimit")
end

function ConstConfig:getPetLimltTips()
	return self:getStrValueByKey("bagSpiritLimit")
end

ConstConfig.instance = ConstConfig.New()

return ConstConfig
