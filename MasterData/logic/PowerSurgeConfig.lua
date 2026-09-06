-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/config/PowerSurgeConfig.lua

module("logic.extensions.bonus.config.PowerSurgeConfig", package.seeall)

local PowerSurgeConfig = class("PowerSurgeConfig", BaseConfig)

function PowerSurgeConfig:onInit()
	PowerSurgeConfig.super.onInit(self)

	self._prizeCfgs = nil
	self._sdTableCfgs = nil
	self._sdItemCfgs = nil
	self._rankCfgs = nil
end

function PowerSurgeConfig:getNames()
	return {
		"zdl_rampage_competition_prize",
		"summerdouble_tab",
		"summerdouble_item",
		"zdl_rampage_competition_rank",
		"zdl_rampage_competition_rank_prize"
	}
end

function PowerSurgeConfig:handleConfig(name, content)
	if name == "zdl_rampage_competition_prize" then
		self._prizeCfgs = content
	elseif name == "summerdouble_tab" then
		self._sdTableCfgs = content
	elseif name == "summerdouble_item" then
		self._sdItemCfgs = content
	elseif name == "zdl_rampage_competition_rank" then
		self._rankCfgs = content
	elseif name == "zdl_rampage_competition_rank_prize" then
		self._rankPrizeCfgs = content
	end
end

function PowerSurgeConfig:getOpenActivityCfg()
	return ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.PowerSurge)
end

function PowerSurgeConfig:getPowerSurgePrizeCfgs(planId)
	if self._prizeCfgs == nil or self._prizeCfgs[planId] == nil then
		return
	end

	return self._prizeCfgs[planId]
end

function PowerSurgeConfig:getSummerDoubleTableCfgs(tabId)
	if self._sdTableCfgs == nil then
		return nil
	end

	tabId = checknumber(tabId)

	if tabId <= 0 or self._sdTableCfgs[tabId] == nil then
		return self._sdTableCfgs
	end

	return self._sdTableCfgs[tabId]
end

function PowerSurgeConfig:getSummerDoubleItemCfgs(tabId)
	tabId = checknumber(tabId)

	if self._sdItemCfgs == nil or self._sdItemCfgs[tabId] == nil then
		return
	end

	return self._sdItemCfgs[tabId]
end

function PowerSurgeConfig:getRankCfgs(actId)
	return self._rankCfgs[actId]
end

function PowerSurgeConfig:getRankZoneId(actId, zdl)
	local zoneId
	local cfgs = self:getRankCfgs(actId)

	if cfgs then
		for i, cfg in ipairs(cfgs) do
			if zdl < cfg.zdlSection[1] then
				break
			else
				zoneId = cfg.id

				if zdl <= cfg.zdlSection[2] then
					break
				end
			end
		end
	end

	return zoneId
end

function PowerSurgeConfig:getRankPrizeByRank(actId, rank)
	if rank == -1 then
		return ""
	end

	local prizeCfgs = self._rankPrizeCfgs[actId]

	if prizeCfgs then
		for k, cfg in pairs(prizeCfgs) do
			if rank >= cfg.startRank and rank <= cfg.endRank then
				return cfg.prize
			end
		end
	end

	return ""
end

PowerSurgeConfig.instance = PowerSurgeConfig.New()

return PowerSurgeConfig
