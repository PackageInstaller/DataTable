-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operatingGift/config/OperatingGiftConfig.lua

module("logic.extensions.operatingGift.config.OperatingGiftConfig", package.seeall)

local OperatingGiftConfig = class("OperatingGiftConfig", BaseConfig)

function OperatingGiftConfig:onInit()
	self:onReset()
end

function OperatingGiftConfig:onReset()
	self._baseCfgs = nil
end

function OperatingGiftConfig:getNames()
	return {
		"campaign_theme_gift"
	}
end

function OperatingGiftConfig:handleConfig(name, content)
	if name == "campaign_theme_gift" then
		self._baseCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._baseCfgs[v.activityId] = self._baseCfgs[v.activityId] or {}

			table.insert(self._baseCfgs[v.activityId], v)
		end
	end
end

function OperatingGiftConfig:getActCfgsById(actId)
	if actId == nil or self._baseCfgs == nil then
		return
	end

	return self._baseCfgs[actId]
end

OperatingGiftConfig.instance = OperatingGiftConfig.New()

return OperatingGiftConfig
