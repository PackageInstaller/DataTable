-- chunkname: @modules/logic/critter/view/RoomCritterFilterViewContainer.lua

module("modules.logic.critter.view.RoomCritterFilterViewContainer", package.seeall)

local RoomCritterFilterViewContainer = class("RoomCritterFilterViewContainer", BaseViewContainer)

function RoomCritterFilterViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterFilterView.New())

	return views
end

return RoomCritterFilterViewContainer
