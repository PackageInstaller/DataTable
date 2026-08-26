-- chunkname: @modules/logic/survival/view/map/comp/SurvivalSkillDescComp.lua

module("modules.logic.survival.view.map.comp.SurvivalSkillDescComp", package.seeall)

local SurvivalSkillDescComp = class("SurvivalSkillDescComp", SkillDescComp)

function SurvivalSkillDescComp:getNumberColor()
	return "#A74D23"
end

function SurvivalSkillDescComp:getLinkColor()
	return "#4E6698"
end

return SurvivalSkillDescComp
