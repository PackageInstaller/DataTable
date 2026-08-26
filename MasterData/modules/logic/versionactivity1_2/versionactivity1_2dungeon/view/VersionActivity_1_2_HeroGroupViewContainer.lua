-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_HeroGroupViewContainer.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupViewContainer", package.seeall)

local VersionActivity_1_2_HeroGroupViewContainer = class("VersionActivity_1_2_HeroGroupViewContainer", HeroGroupFightViewContainer)

function VersionActivity_1_2_HeroGroupViewContainer:buildViews()
	self._heroGroupFightView = VersionActivity_1_2_HeroGroupView.New()

	return {
		self._heroGroupFightView,
		VersionActivity_1_2_HeroGroupBuildView.New(),
		VersionActivity_1_2_HeroGroupListView.New(),
		HeroGroupFightViewLevel.New(),
		HeroGroupFightViewRule.New(),
		CheckActivityEndView.New(),
		TabViewGroup.New(1, "#go_container/btnContain/commonBtns"),
		TabViewGroup.New(2, "#go_righttop/#go_power")
	}
end

return VersionActivity_1_2_HeroGroupViewContainer
