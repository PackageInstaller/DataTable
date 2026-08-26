-- chunkname: @modules/logic/weekwalk/view/HeroGroupFightWeekwalkViewContainer.lua

module("modules.logic.weekwalk.view.HeroGroupFightWeekwalkViewContainer", package.seeall)

local HeroGroupFightWeekwalkViewContainer = class("HeroGroupFightWeekwalkViewContainer", HeroGroupFightViewContainer)

function HeroGroupFightWeekwalkViewContainer:defineFightView()
	HeroGroupFightWeekwalkViewContainer.super.defineFightView(self)

	self._heroGroupFightListView = WeekWalkHeroGroupListView.New()
end

function HeroGroupFightWeekwalkViewContainer:addLastViews(views)
	table.insert(views, HeroGroupFightWeekWalkView.New())
end

return HeroGroupFightWeekwalkViewContainer
