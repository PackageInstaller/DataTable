-- chunkname: @modules/logic/survival/view/map/SurvivalHeroGroupFightView_Rule.lua

module("modules.logic.survival.view.map.SurvivalHeroGroupFightView_Rule", package.seeall)

local SurvivalHeroGroupFightView_Rule = class("SurvivalHeroGroupFightView_Rule", HeroGroupFightViewRule)

function SurvivalHeroGroupFightView_Rule:_getRuleList(episodeConfig)
	local list = SurvivalHeroGroupFightView_Rule.super._getRuleList(self, episodeConfig)

	return SurvivalShelterModel.instance:addExRule(list)
end

return SurvivalHeroGroupFightView_Rule
