-- chunkname: @modules/logic/herogroup/view/HeroGroupFightFiveHeroViewContainer.lua

module("modules.logic.herogroup.view.HeroGroupFightFiveHeroViewContainer", package.seeall)

local HeroGroupFightFiveHeroViewContainer = class("HeroGroupFightFiveHeroViewContainer", HeroGroupFightViewContainer)

function HeroGroupFightFiveHeroViewContainer:defineFightView()
	self._heroGroupFightView = HeroGroupFightFiveHeroView.New()
	self._heroGroupFightListView = HeroGroupListFiveHeroView.New()
end

return HeroGroupFightFiveHeroViewContainer
