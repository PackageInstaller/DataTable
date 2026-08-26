-- chunkname: @modules/logic/room/view/critter/RoomTrainAccelerateViewContainer.lua

module("modules.logic.room.view.critter.RoomTrainAccelerateViewContainer", package.seeall)

local RoomTrainAccelerateViewContainer = class("RoomTrainAccelerateViewContainer", BaseViewContainer)

function RoomTrainAccelerateViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomTrainAccelerateView.New())

	return views
end

return RoomTrainAccelerateViewContainer
