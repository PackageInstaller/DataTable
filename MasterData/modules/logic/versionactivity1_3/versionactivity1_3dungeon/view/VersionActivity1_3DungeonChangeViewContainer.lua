-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3DungeonChangeViewContainer.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonChangeViewContainer", package.seeall)

local VersionActivity1_3DungeonChangeViewContainer = class("VersionActivity1_3DungeonChangeViewContainer", BaseViewContainer)

function VersionActivity1_3DungeonChangeViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity1_3DungeonChangeView.New())

	return views
end

return VersionActivity1_3DungeonChangeViewContainer
