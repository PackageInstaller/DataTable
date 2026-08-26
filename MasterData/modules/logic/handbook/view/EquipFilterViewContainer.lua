-- chunkname: @modules/logic/handbook/view/EquipFilterViewContainer.lua

module("modules.logic.handbook.view.EquipFilterViewContainer", package.seeall)

local EquipFilterViewContainer = class("EquipFilterViewContainer", BaseViewContainer)

function EquipFilterViewContainer:buildViews()
	local views = {}

	table.insert(views, EquipFilterView.New())

	return views
end

return EquipFilterViewContainer
