-- chunkname: @modules/logic/survival/view/shelter/ShelterHeroGroupFightViewContainer.lua

module("modules.logic.survival.view.shelter.ShelterHeroGroupFightViewContainer", package.seeall)

local ShelterHeroGroupFightViewContainer = class("ShelterHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function ShelterHeroGroupFightViewContainer:defineFightView()
	ShelterHeroGroupFightViewContainer.super.defineFightView(self)

	self._heroGroupFightView = ShelterHeroGroupFightView.New()
	self._heroGroupFightListView = ShelterHeroGroupListView.New()
end

function ShelterHeroGroupFightViewContainer:getFightLevelView()
	return ShelterHeroGroupFightView_Level.New()
end

function ShelterHeroGroupFightViewContainer:addLastViews(views)
	table.insert(views, SurvivalHeroGroupEquipView.New())
end

return ShelterHeroGroupFightViewContainer
