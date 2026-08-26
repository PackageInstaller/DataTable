-- chunkname: @modules/logic/herogroup/view/HeroGroupFightRuleDescViewContainer.lua

module("modules.logic.herogroup.view.HeroGroupFightRuleDescViewContainer", package.seeall)

local HeroGroupFightRuleDescViewContainer = class("HeroGroupFightRuleDescViewContainer", BaseViewContainer)

function HeroGroupFightRuleDescViewContainer:buildViews()
	local views = {}

	table.insert(views, HeroGroupFightRuleDescView.New())

	return views
end

return HeroGroupFightRuleDescViewContainer
