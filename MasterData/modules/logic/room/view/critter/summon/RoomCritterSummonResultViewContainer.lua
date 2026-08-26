-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterSummonResultViewContainer.lua

module("modules.logic.room.view.critter.summon.RoomCritterSummonResultViewContainer", package.seeall)

local RoomCritterSummonResultViewContainer = class("RoomCritterSummonResultViewContainer", BaseViewContainer)

function RoomCritterSummonResultViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterSummonResultView.New())

	return views
end

return RoomCritterSummonResultViewContainer
