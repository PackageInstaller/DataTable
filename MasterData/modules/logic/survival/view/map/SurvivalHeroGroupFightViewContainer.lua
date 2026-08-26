-- chunkname: @modules/logic/survival/view/map/SurvivalHeroGroupFightViewContainer.lua

module("modules.logic.survival.view.map.SurvivalHeroGroupFightViewContainer", package.seeall)

local SurvivalHeroGroupFightViewContainer = class("SurvivalHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function SurvivalHeroGroupFightViewContainer:defineFightView()
	SurvivalHeroGroupFightViewContainer.super.defineFightView(self)

	self._heroGroupFightView = SurvivalHeroGroupFightView.New()
	self._heroGroupFightListView = SurvivalHeroGroupListView.New()
end

function SurvivalHeroGroupFightViewContainer:getFightRuleView()
	return SurvivalHeroGroupFightView_Rule.New()
end

function SurvivalHeroGroupFightViewContainer:getFightLevelView()
	return SurvivalHeroGroupFightView_Level.New()
end

function SurvivalHeroGroupFightViewContainer:addLastViews(views)
	table.insert(views, SurvivalHeroGroupEquipView.New())
end

return SurvivalHeroGroupFightViewContainer
