-- chunkname: @modules/logic/survival/controller/work/step/SurvivalRoleLevelUpWork.lua

module("modules.logic.survival.controller.work.step.SurvivalRoleLevelUpWork", package.seeall)

local SurvivalRoleLevelUpWork = class("SurvivalRoleLevelUpWork", SurvivalStepBaseWork)

function SurvivalRoleLevelUpWork:onStart2()
	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
	local level = survivalShelterRoleMo.level

	survivalShelterRoleMo:setLevelUpCache(level)
	self:onDone(true)
end

function SurvivalRoleLevelUpWork:onViewClose(viewName)
	return
end

function SurvivalRoleLevelUpWork:clearWork()
	return
end

return SurvivalRoleLevelUpWork
