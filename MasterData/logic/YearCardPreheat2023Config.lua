-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/config/YearCardPreheat2023Config.lua

module("logic.extensions.yearcardpreheat2023.config.YearCardPreheat2023Config", package.seeall)

local YearCardPreheat2023Config = class("YearCardPreheat2023Config", BaseConfig)

function YearCardPreheat2023Config:onInit()
	YearCardPreheat2023Config.super.onInit(self)
end

function YearCardPreheat2023Config:getNames()
	return {
		"2023_annual_fee_preheat",
		"2023_annual_fee_preheat_design",
		"2023_annual_fee_preheat_monster",
		"2023_annual_fee_preheat_creeps",
		"2023_annual_fee_preheat_clue",
		"2023_annual_fee_preheat_progress"
	}
end

function YearCardPreheat2023Config:handleConfig(name, content)
	if name == "2023_annual_fee_preheat" then
		self._actCfg = content
	elseif name == "2023_annual_fee_preheat_design" then
		self._designCfg = content
	elseif name == "2023_annual_fee_preheat_monster" then
		self._formationCfg = content
	elseif name == "2023_annual_fee_preheat_creeps" then
		self._mosterCfg = content
	elseif name == "2023_annual_fee_preheat_clue" then
		self._clueCfg = content
	elseif name == "2023_annual_fee_preheat_progress" then
		self._progressCfg = content
	end
end

function YearCardPreheat2023Config:getActCfgByActId(id)
	return self._actCfg[id]
end

function YearCardPreheat2023Config:getDesignCfgsByPlanId(planId)
	return self._designCfg[planId]
end

function YearCardPreheat2023Config:getFormationCfgById(id)
	return self._formationCfg[id]
end

function YearCardPreheat2023Config:getMostersCfgById(id)
	return self._mosterCfg[id]
end

function YearCardPreheat2023Config:getClueCfgsByPlanId(planId)
	return self._clueCfg[planId]
end

function YearCardPreheat2023Config:getClueCfg(planId, id)
	local cfgs = self:getClueCfgsByPlanId(planId)

	return cfgs[id]
end

function YearCardPreheat2023Config:getProgressCfgsByPlanId(planId)
	return self._progressCfg[planId]
end

YearCardPreheat2023Config.instance = YearCardPreheat2023Config.New()

return YearCardPreheat2023Config
