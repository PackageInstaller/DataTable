-- chunkname: @modules/logic/survival/model/shelter/SurvivalIntrudeSchemeMo.lua

module("modules.logic.survival.model.shelter.SurvivalIntrudeSchemeMo", package.seeall)

local SurvivalIntrudeSchemeMo = pureTable("SurvivalIntrudeSchemeMo")

function SurvivalIntrudeSchemeMo:setData(survivalIntrudeScheme, point)
	self.survivalIntrudeScheme = survivalIntrudeScheme
	self.point = point
	self.intrudeSchemeCfg = lua_survival_shelter_intrude_scheme.configDict[self.survivalIntrudeScheme.id]
end

function SurvivalIntrudeSchemeMo:getDisplayIcon()
	return (self.survivalIntrudeScheme.repress or nil) and "survival_new_bossbuff1_0"
end

return SurvivalIntrudeSchemeMo
