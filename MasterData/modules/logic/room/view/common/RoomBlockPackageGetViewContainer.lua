-- chunkname: @modules/logic/room/view/common/RoomBlockPackageGetViewContainer.lua

module("modules.logic.room.view.common.RoomBlockPackageGetViewContainer", package.seeall)

local RoomBlockPackageGetViewContainer = class("RoomBlockPackageGetViewContainer", BaseViewContainer)

function RoomBlockPackageGetViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomBlockPackageGetView.New())

	return views
end

return RoomBlockPackageGetViewContainer
