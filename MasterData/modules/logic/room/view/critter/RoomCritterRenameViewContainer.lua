-- chunkname: @modules/logic/room/view/critter/RoomCritterRenameViewContainer.lua

module("modules.logic.room.view.critter.RoomCritterRenameViewContainer", package.seeall)

local RoomCritterRenameViewContainer = class("RoomCritterRenameViewContainer", BaseViewContainer)

function RoomCritterRenameViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterRenameView.New())

	return views
end

return RoomCritterRenameViewContainer
