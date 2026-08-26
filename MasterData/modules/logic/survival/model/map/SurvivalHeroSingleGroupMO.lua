-- chunkname: @modules/logic/survival/model/map/SurvivalHeroSingleGroupMO.lua

module("modules.logic.survival.model.map.SurvivalHeroSingleGroupMO", package.seeall)

local SurvivalHeroSingleGroupMO = class("SurvivalHeroSingleGroupMO", HeroSingleGroupMO)

function SurvivalHeroSingleGroupMO:getHeroMO()
	local tempInfo = SurvivalMapModel.instance:getSceneMo().teamInfo

	return tempInfo:getHeroMo(self.heroUid)
end

return SurvivalHeroSingleGroupMO
