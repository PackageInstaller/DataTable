-- chunkname: @modules/logic/room/controller/RoomBackpackController.lua

module("modules.logic.room.controller.RoomBackpackController", package.seeall)

local RoomBackpackController = class("RoomBackpackController", BaseController)

function RoomBackpackController:onInit()
	return
end

function RoomBackpackController:reInit()
	return
end

function RoomBackpackController:clear()
	return
end

function RoomBackpackController:clickCritterRareSort(filterMO)
	local isRareAscend = RoomBackpackCritterListModel.instance:getIsSortByRareAscend()

	RoomBackpackCritterListModel.instance:setIsSortByRareAscend(not isRareAscend)
	self:refreshCritterBackpackList(filterMO)
end

function RoomBackpackController:selectMatureFilterType(newFilterType, filterMO)
	local matureFilterType = RoomBackpackCritterListModel.instance:getMatureFilterType()

	if matureFilterType and matureFilterType == newFilterType then
		return
	end

	RoomBackpackCritterListModel.instance:setMatureFilterType(newFilterType)
	self:refreshCritterBackpackList(filterMO)
end

function RoomBackpackController:refreshCritterBackpackList(filterMO)
	RoomBackpackCritterListModel.instance:setBackpackCritterList(filterMO)
end

function RoomBackpackController:openCritterDecomposeView()
	ViewMgr.instance:openView(ViewName.RoomCritterDecomposeView)
end

function RoomBackpackController:refreshPropBackpackList()
	RoomBackpackPropListModel.instance:setBackpackPropList()
end

RoomBackpackController.instance = RoomBackpackController.New()

return RoomBackpackController
