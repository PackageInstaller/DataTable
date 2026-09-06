-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/config/FirstChargeConfig.lua

module("logic.extensions.firstcharge.config.FirstChargeConfig", package.seeall)

local FirstChargeConfig = class("FirstChargeConfig", BaseConfig)

function FirstChargeConfig:onInit()
	self:onReset()
end

function FirstChargeConfig:onReset()
	self._baseCfgs = nil
	self._signCfgs = nil
end

function FirstChargeConfig:getNames()
	return {
		"scope_consume_gift",
		"scope_consume_sign_prize"
	}
end

function FirstChargeConfig:handleConfig(name, content)
	if name == "scope_consume_gift" then
		self._baseCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._baseCfgs[v.activityId] = self._baseCfgs[v.activityId] or {}

			table.insert(self._baseCfgs[v.activityId], v)
		end
	elseif name == "scope_consume_sign_prize" then
		self._signCfgs = content
	end
end

function FirstChargeConfig:getActCfgsById(actId, sortId)
	if actId == nil or self._baseCfgs == nil then
		return
	end

	if sortId then
		return self._baseCfgs[actId][sortId]
	end

	return self._baseCfgs[actId]
end

function FirstChargeConfig:getActSignCfgsById(actId, money, dayId)
	if dayId then
		return self._signCfgs[actId][money][dayId]
	end

	return self._signCfgs[actId][money]
end

FirstChargeConfig.instance = FirstChargeConfig.New()

return FirstChargeConfig
