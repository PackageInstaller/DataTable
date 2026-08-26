-- chunkname: @modules/logic/dungeon/view/DungeonFragmentInfoViewContainer.lua

module("modules.logic.dungeon.view.DungeonFragmentInfoViewContainer", package.seeall)

local DungeonFragmentInfoViewContainer = class("DungeonFragmentInfoViewContainer", BaseViewContainer)

function DungeonFragmentInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonFragmentInfoView.New())

	return views
end

return DungeonFragmentInfoViewContainer
