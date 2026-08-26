-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9HeroGroupFightViewContainer.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9HeroGroupFightViewContainer", package.seeall)

local VersionActivity2_9HeroGroupFightViewContainer = class("VersionActivity2_9HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function VersionActivity2_9HeroGroupFightViewContainer:addCommonViews(views)
	table.insert(views, self._heroGroupFightView)
	table.insert(views, HeroGroupAnimView.New())
	table.insert(views, self._heroGroupFightListView.New())
	table.insert(views, VersionActivity2_9HeroGroupFightViewLevel.New())
	table.insert(views, HeroGroupFightViewRule.New())
	table.insert(views, HeroGroupInfoScrollView.New())
	table.insert(views, CheckActivityEndView.New())
	table.insert(views, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(views, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

return VersionActivity2_9HeroGroupFightViewContainer
