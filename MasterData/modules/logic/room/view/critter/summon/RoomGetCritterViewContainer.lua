-- chunkname: @modules/logic/room/view/critter/summon/RoomGetCritterViewContainer.lua

module("modules.logic.room.view.critter.summon.RoomGetCritterViewContainer", package.seeall)

local RoomGetCritterViewContainer = class("RoomGetCritterViewContainer", BaseViewContainer)

function RoomGetCritterViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomGetCritterView.New())

	return views
end

return RoomGetCritterViewContainer
