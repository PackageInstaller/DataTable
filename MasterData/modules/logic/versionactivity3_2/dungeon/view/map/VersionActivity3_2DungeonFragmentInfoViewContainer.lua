-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonFragmentInfoViewContainer.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonFragmentInfoViewContainer", package.seeall)

local VersionActivity3_2DungeonFragmentInfoViewContainer = class("VersionActivity3_2DungeonFragmentInfoViewContainer", BaseViewContainer)

function VersionActivity3_2DungeonFragmentInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_2DungeonFragmentInfoView.New())

	return views
end

return VersionActivity3_2DungeonFragmentInfoViewContainer
