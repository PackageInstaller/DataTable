-- chunkname: @modules/logic/room/controller/RoomBlockGiftController.lua

module("modules.logic.room.controller.RoomBlockGiftController", package.seeall)

local RoomBlockGiftController = class("RoomBlockGiftController", BaseController)

function RoomBlockGiftController:openBlockView(rare, id, useGiftCallback, useObjct)
	if RoomBlockBuildingGiftModel.instance:isAllColloct(rare) then
		GameFacade.showToast(ToastEnum.RoomBlockAllCollect)
	else
		RoomBlockBuildingGiftModel.instance:initBlockBuilding(rare)

		local param = {
			rare = rare,
			id = id
		}

		ViewMgr.instance:openView(ViewName.RoomBlockGiftChoiceView, param)
	end

	function self._useGiftCallback()
		useGiftCallback(useObjct)
	end
end

function RoomBlockGiftController:useItemCallback()
	RoomBlockBuildingGiftModel.instance:clearSelect()

	if self._useGiftCallback then
		self._useGiftCallback()

		return
	end

	if ViewMgr.instance:isOpen(ViewName.MaterialTipView) then
		ViewMgr.instance:closeView(ViewName.MaterialTipView)
	end
end

RoomBlockGiftController.instance = RoomBlockGiftController.New()

return RoomBlockGiftController
