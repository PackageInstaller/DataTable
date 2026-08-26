-- chunkname: @modules/logic/abyss/view/AbyssHeroGroupFightViewRule.lua

module("modules.logic.abyss.view.AbyssHeroGroupFightViewRule", package.seeall)

local AbyssHeroGroupFightViewRule = class("AbyssHeroGroupFightViewRule", HeroGroupFightViewRule)

function AbyssHeroGroupFightViewRule:_btnadditionRuleOnClick()
	AbyssHeroGroupFightViewRule.super._btnadditionRuleOnClick(self)
end

return AbyssHeroGroupFightViewRule
