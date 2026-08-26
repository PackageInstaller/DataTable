-- chunkname: @modules/logic/dungeon/view/DungeonEquipGuideViewContainer.lua

module("modules.logic.dungeon.view.DungeonEquipGuideViewContainer", package.seeall)

local DungeonEquipGuideViewContainer = class("DungeonEquipGuideViewContainer", BaseViewContainer)

function DungeonEquipGuideViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonEquipGuideView.New())

	return views
end

return DungeonEquipGuideViewContainer
