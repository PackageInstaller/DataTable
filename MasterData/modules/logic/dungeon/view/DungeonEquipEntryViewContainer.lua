-- chunkname: @modules/logic/dungeon/view/DungeonEquipEntryViewContainer.lua

module("modules.logic.dungeon.view.DungeonEquipEntryViewContainer", package.seeall)

local DungeonEquipEntryViewContainer = class("DungeonEquipEntryViewContainer", BaseViewContainer)

function DungeonEquipEntryViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonEquipEntryView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function DungeonEquipEntryViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self._navigateButtonView
	}
end

return DungeonEquipEntryViewContainer
