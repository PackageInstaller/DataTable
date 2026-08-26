-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonFragmentInfoViewContainer.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonFragmentInfoViewContainer", package.seeall)

local VersionActivity2_9DungeonFragmentInfoViewContainer = class("VersionActivity2_9DungeonFragmentInfoViewContainer", BaseViewContainer)

function VersionActivity2_9DungeonFragmentInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_9DungeonFragmentInfoView.New())

	return views
end

return VersionActivity2_9DungeonFragmentInfoViewContainer
