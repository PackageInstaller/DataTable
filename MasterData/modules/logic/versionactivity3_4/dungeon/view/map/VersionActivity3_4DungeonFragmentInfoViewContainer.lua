-- chunkname: @modules/logic/versionactivity3_4/dungeon/view/map/VersionActivity3_4DungeonFragmentInfoViewContainer.lua

module("modules.logic.versionactivity3_4.dungeon.view.map.VersionActivity3_4DungeonFragmentInfoViewContainer", package.seeall)

local VersionActivity3_4DungeonFragmentInfoViewContainer = class("VersionActivity3_4DungeonFragmentInfoViewContainer", BaseViewContainer)

function VersionActivity3_4DungeonFragmentInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_4DungeonFragmentInfoView.New())

	return views
end

return VersionActivity3_4DungeonFragmentInfoViewContainer
