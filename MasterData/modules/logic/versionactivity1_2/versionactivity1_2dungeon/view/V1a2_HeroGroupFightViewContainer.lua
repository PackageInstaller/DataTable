-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/V1a2_HeroGroupFightViewContainer.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.V1a2_HeroGroupFightViewContainer", package.seeall)

local V1a2_HeroGroupFightViewContainer = class("V1a2_HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function V1a2_HeroGroupFightViewContainer:defineFightView()
	V1a2_HeroGroupFightViewContainer.super.defineFightView(self)

	self._heroGroupFightView = VersionActivity_1_2_HeroGroupView.New()
end

function V1a2_HeroGroupFightViewContainer:addLastViews(views)
	V1a2_HeroGroupFightViewContainer.super.addLastViews(self)
	table.insert(views, VersionActivity_1_2_HeroGroupBuildView.New())
end

return V1a2_HeroGroupFightViewContainer
