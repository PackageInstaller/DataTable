-- chunkname: @modules/logic/sodache/view/inside/SodacheHeroGroupFightViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheHeroGroupFightViewContainer", package.seeall)

local SodacheHeroGroupFightViewContainer = class("SodacheHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function SodacheHeroGroupFightViewContainer:getFightLevelView()
	return SodacheHeroGroupFightViewLevel.New()
end

function SodacheHeroGroupFightViewContainer:addLastViews(views)
	SodacheHeroGroupFightViewContainer.super.addLastViews(self, views)
	table.insert(views, SodacheHeroGroupAmmoView.New())
end

function SodacheHeroGroupFightViewContainer:defineFightView(...)
	SodacheHeroGroupFightViewContainer.super.defineFightView(self, ...)

	self._heroGroupFightView = SodacheHeroGroupFightView.New()
end

return SodacheHeroGroupFightViewContainer
