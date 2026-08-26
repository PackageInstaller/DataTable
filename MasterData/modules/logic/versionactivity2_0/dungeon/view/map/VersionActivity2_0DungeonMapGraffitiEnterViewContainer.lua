-- chunkname: @modules/logic/versionactivity2_0/dungeon/view/map/VersionActivity2_0DungeonMapGraffitiEnterViewContainer.lua

module("modules.logic.versionactivity2_0.dungeon.view.map.VersionActivity2_0DungeonMapGraffitiEnterViewContainer", package.seeall)

local VersionActivity2_0DungeonMapGraffitiEnterViewContainer = class("VersionActivity2_0DungeonMapGraffitiEnterViewContainer", BaseViewContainer)

function VersionActivity2_0DungeonMapGraffitiEnterViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_0DungeonMapGraffitiEnterView.New())

	return views
end

return VersionActivity2_0DungeonMapGraffitiEnterViewContainer
