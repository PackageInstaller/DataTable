-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/V1a3_HeroGroupFightViewContainer.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.V1a3_HeroGroupFightViewContainer", package.seeall)

local V1a3_HeroGroupFightViewContainer = class("V1a3_HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function V1a3_HeroGroupFightViewContainer:addFirstViews(views)
	V1a3_HeroGroupFightViewContainer.super.addFirstViews(self, views)
	table.insert(views, HeroGroupFairyLandView.New())
end

return V1a3_HeroGroupFightViewContainer
