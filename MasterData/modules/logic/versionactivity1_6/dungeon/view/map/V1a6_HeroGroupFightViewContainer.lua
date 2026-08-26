-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/map/V1a6_HeroGroupFightViewContainer.lua

module("modules.logic.versionactivity1_6.dungeon.view.map.V1a6_HeroGroupFightViewContainer", package.seeall)

local V1a6_HeroGroupFightViewContainer = class("V1a6_HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function V1a6_HeroGroupFightViewContainer:addFirstViews(views)
	V1a6_HeroGroupFightViewContainer.super.addFirstViews(self, views)
	table.insert(views, V1a6_HeroGroupFightLayoutView.New())
end

function V1a6_HeroGroupFightViewContainer:addLastViews(views)
	V1a6_HeroGroupFightViewContainer.super.addLastViews(self, views)
	table.insert(views, V1a6HeroGroupSkillView.New())
end

return V1a6_HeroGroupFightViewContainer
