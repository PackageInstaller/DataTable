-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/VersionActivity1_5DungeonMapTaskViewContainer.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapTaskViewContainer", package.seeall)

local VersionActivity1_5DungeonMapTaskViewContainer = class("VersionActivity1_5DungeonMapTaskViewContainer", BaseViewContainer)

function VersionActivity1_5DungeonMapTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity1_5DungeonMapTaskView.New())

	return views
end

return VersionActivity1_5DungeonMapTaskViewContainer
