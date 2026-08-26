-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/V1a5_HeroGroupFightViewContainer.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.V1a5_HeroGroupFightViewContainer", package.seeall)

local V1a5_HeroGroupFightViewContainer = class("V1a5_HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function V1a5_HeroGroupFightViewContainer:addFirstViews(views)
	V1a5_HeroGroupFightViewContainer.super.addFirstViews(self, views)
	table.insert(views, V1a5_HeroGroupFightLayoutView.New())
end

function V1a5_HeroGroupFightViewContainer:addLastViews(views)
	V1a5_HeroGroupFightViewContainer.super.addLastViews(self, views)
	table.insert(views, V1a5HeroGroupBuildingView.New())
end

return V1a5_HeroGroupFightViewContainer
