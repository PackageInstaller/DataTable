-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterSummonRuleTipsViewContainer.lua

module("modules.logic.room.view.critter.summon.RoomCritterSummonRuleTipsViewContainer", package.seeall)

local RoomCritterSummonRuleTipsViewContainer = class("RoomCritterSummonRuleTipsViewContainer", BaseViewContainer)

function RoomCritterSummonRuleTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterSummonRuleTipsView.New())

	return views
end

return RoomCritterSummonRuleTipsViewContainer
