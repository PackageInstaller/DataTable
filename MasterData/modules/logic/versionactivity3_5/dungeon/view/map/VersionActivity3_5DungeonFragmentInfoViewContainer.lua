-- chunkname: @modules/logic/versionactivity3_5/dungeon/view/map/VersionActivity3_5DungeonFragmentInfoViewContainer.lua

module("modules.logic.versionactivity3_5.dungeon.view.map.VersionActivity3_5DungeonFragmentInfoViewContainer", package.seeall)

local VersionActivity3_5DungeonFragmentInfoViewContainer = class("VersionActivity3_5DungeonFragmentInfoViewContainer", BaseViewContainer)

function VersionActivity3_5DungeonFragmentInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_5DungeonFragmentInfoView.New())

	return views
end

return VersionActivity3_5DungeonFragmentInfoViewContainer
