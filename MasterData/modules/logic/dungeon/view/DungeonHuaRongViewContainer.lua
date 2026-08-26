-- chunkname: @modules/logic/dungeon/view/DungeonHuaRongViewContainer.lua

module("modules.logic.dungeon.view.DungeonHuaRongViewContainer", package.seeall)

local DungeonHuaRongViewContainer = class("DungeonHuaRongViewContainer", BaseViewContainer)

function DungeonHuaRongViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonHuaRongView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function DungeonHuaRongViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return DungeonHuaRongViewContainer
