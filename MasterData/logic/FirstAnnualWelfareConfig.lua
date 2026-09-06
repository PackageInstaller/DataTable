-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstannualwelfare/config/FirstAnnualWelfareConfig.lua

module("logic.extensions.firstannualwelfare.config.FirstAnnualWelfareConfig", package.seeall)

local FirstAnnualWelfareConfig = class("FirstAnnualWelfareConfig", BaseConfig)

function FirstAnnualWelfareConfig:onInit()
	FirstAnnualWelfareConfig.super.onInit(self)
end

function FirstAnnualWelfareConfig:getNames()
	return {
		"first_annual_welfare_activity",
		"first_annual_welfare_exchange",
		"first_annual_welfare_choice_pool",
		"first_annual_welfare_skin",
		"first_annual_welfare_activity_hud",
		"first_annual_welfare_choice_cost_pool"
	}
end

function FirstAnnualWelfareConfig:handleConfig(name, content)
	if name == "first_annual_welfare_activity" then
		self._fawCfgs = content
	elseif name == "first_annual_welfare_exchange" then
		self._exchangeCfgs = content
	elseif name == "first_annual_welfare_choice_pool" then
		self._cPoolCfgs = content
	elseif name == "first_annual_welfare_choice_cost_pool" then
		self._cCostPoolCfgs = content
	elseif name == "first_annual_welfare_skin" then
		self._skinCfgs = content
	elseif name == "first_annual_welfare_activity_hud" then
		self._HudCfgs = content
	end
end

function FirstAnnualWelfareConfig:getFawCfg(actId)
	return self._fawCfgs[actId] or {}
end

function FirstAnnualWelfareConfig:getExchangeCfgs()
	return self._exchangeCfgs or {}
end

function FirstAnnualWelfareConfig:getExchangeData(exchangeId)
	return self._exchangeCfgs[exchangeId]
end

function FirstAnnualWelfareConfig:getCPoolCfg(poolId)
	return self._cPoolCfgs[poolId]
end

function FirstAnnualWelfareConfig:getCPoolData(poolId, index)
	return self._cPoolCfgs[poolId][index]
end

function FirstAnnualWelfareConfig:getCCostPoolCfg(poolId)
	return self._cCostPoolCfgs[poolId]
end

function FirstAnnualWelfareConfig:getCCostPoolData(poolId, index)
	return self._cCostPoolCfgs[poolId][index]
end

function FirstAnnualWelfareConfig:getHudCfgs(actId)
	return self._HudCfgs[actId]
end

function FirstAnnualWelfareConfig:getSkinCfgs(actId)
	local actCfg = self:getFawCfg(actId)

	if actCfg then
		return self._skinCfgs[actCfg.skinPlanId] or {}
	end
end

FirstAnnualWelfareConfig.instance = FirstAnnualWelfareConfig.New()

return FirstAnnualWelfareConfig
