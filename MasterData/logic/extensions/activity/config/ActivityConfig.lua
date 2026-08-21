-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activity/config/ActivityConfig.lua

module("logic.extensions.activity.config.ActivityConfig", package.seeall)

local M = class("ActivityConfig", BaseConfig)

function M:onInit()
	self._activityExchange = {}
end

function M:getNames()
	return {
		ConfigName.ActivityExchange
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.ActivityExchange then
		for k, cfg in pairs(content.dataList or {}) do
			if not self._activityExchange[cfg.logic] then
				self._activityExchange[cfg.logic] = {}
			end

			self._activityExchange[cfg.logic][cfg.config] = cfg
		end
	end
end

function M:getActExchangeCfg(logicTyp, planId)
	if self._activityExchange[logicTyp] and self._activityExchange[logicTyp][planId] then
		return self._activityExchange[logicTyp][planId]
	end
end

function M:getActExchangeSeconds(logicTyp, planId)
	local cfg = self:getActExchangeCfg(logicTyp, planId)
	local day = cfg and cfg.redeemDays or 0

	return day * 24 * 60 * 60
end

M.instance = M.New()

return M
