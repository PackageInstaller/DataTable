-- chunkname: @modules/logic/room/view/critter/train/RoomCritterTrainEventResultViewContainer.lua

module("modules.logic.room.view.critter.train.RoomCritterTrainEventResultViewContainer", package.seeall)

local RoomCritterTrainEventResultViewContainer = class("RoomCritterTrainEventResultViewContainer", BaseViewContainer)

function RoomCritterTrainEventResultViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterTrainEventResultView.New())

	return views
end

return RoomCritterTrainEventResultViewContainer
