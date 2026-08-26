-- chunkname: @modules/logic/room/view/RoomTipsViewContainer.lua

module("modules.logic.room.view.RoomTipsViewContainer", package.seeall)

local RoomTipsViewContainer = class("RoomTipsViewContainer", BaseViewContainer)

function RoomTipsViewContainer:buildViews()
	return {
		RoomTipsView.New()
	}
end

return RoomTipsViewContainer
