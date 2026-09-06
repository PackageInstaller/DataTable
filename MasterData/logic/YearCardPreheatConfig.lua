-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat/config/YearCardPreheatConfig.lua

module("logic.extensions.preheatsale.config.YearCardPreheatConfig", package.seeall)

local YearCardPreheatConfig = class("YearCardPreheatConfig", BaseConfig)

function YearCardPreheatConfig:onInit()
	YearCardPreheatConfig.super.onInit(self)

	self._commonCfgs = nil
	self._prizeCfgs = nil
	self._infoCfgs = nil
	self._gameCfgs = nil
end

function YearCardPreheatConfig:getNames()
	return {
		"annual_fee_preheat",
		"annual_fee_preheat_prize",
		"annual_fee_preheat_information",
		"annual_fee_preheat_game"
	}
end

function YearCardPreheatConfig:handleConfig(name, content)
	if name == "annual_fee_preheat" then
		self._commonCfgs = content
	elseif name == "annual_fee_preheat_prize" then
		self._prizeCfgs = content
	elseif name == "annual_fee_preheat_information" then
		self._infoCfgs = content
	elseif name == "annual_fee_preheat_game" then
		self._gameCfgs = content
	end
end

function YearCardPreheatConfig:getCommonCfgByActId(actId)
	return self._commonCfgs[actId]
end

function YearCardPreheatConfig:getPrizeCfgByPlanId(planId)
	return self._prizeCfgs[planId]
end

function YearCardPreheatConfig:getInfoCfgByPlanId(planId)
	return self._infoCfgs[planId]
end

function YearCardPreheatConfig:getGameCfgByStageId(stageId)
	return self._gameCfgs[stageId]
end

YearCardPreheatConfig.instance = YearCardPreheatConfig.New()

return YearCardPreheatConfig
