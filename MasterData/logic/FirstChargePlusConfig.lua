-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/config/FirstChargePlusConfig.lua

module("logic.extensions.firstcharge.config.FirstChargePlusConfig", package.seeall)

local FirstChargePlusConfig = class("FirstChargePlusConfig", BaseConfig)

function FirstChargePlusConfig:onInit()
	self:onReset()
end

function FirstChargePlusConfig:onReset()
	self._baseCfgs = nil
	self._signCfgs = nil
end

function FirstChargePlusConfig:getNames()
	return {
		"scope_consume_plus_gift",
		"scope_consume_plus_sign"
	}
end

function FirstChargePlusConfig:handleConfig(name, content)
	if name == "scope_consume_plus_gift" then
		self._scope_consume_plus_gift = content
	elseif name == "scope_consume_plus_sign" then
		self._scope_consume_plus_sign = content
	end
end

function FirstChargePlusConfig:getActCfgsById(actId, sortId)
	if sortId then
		return self._scope_consume_plus_gift[actId][sortId]
	else
		return self._scope_consume_plus_gift[actId]
	end
end

function FirstChargePlusConfig:getActSignCfgsById(actId, dayId)
	if dayId then
		return self._scope_consume_plus_sign[actId][dayId]
	end

	return self._scope_consume_plus_sign[actId]
end

FirstChargePlusConfig.instance = FirstChargePlusConfig.New()

return FirstChargePlusConfig
