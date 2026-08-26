-- chunkname: @modules/logic/room/view/RoomCharacterPlaceInfoViewContainer.lua

module("modules.logic.room.view.RoomCharacterPlaceInfoViewContainer", package.seeall)

local RoomCharacterPlaceInfoViewContainer = class("RoomCharacterPlaceInfoViewContainer", BaseViewContainer)

function RoomCharacterPlaceInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCharacterPlaceInfoView.New())

	return views
end

return RoomCharacterPlaceInfoViewContainer
