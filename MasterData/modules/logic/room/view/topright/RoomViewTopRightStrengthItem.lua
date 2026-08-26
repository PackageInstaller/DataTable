-- chunkname: @modules/logic/room/view/topright/RoomViewTopRightStrengthItem.lua

module("modules.logic.room.view.topright.RoomViewTopRightStrengthItem", package.seeall)

local RoomViewTopRightStrengthItem = class("RoomViewTopRightStrengthItem", RoomViewTopRightBaseItem)

function RoomViewTopRightStrengthItem:ctor(param)
	RoomViewTopRightStrengthItem.super.ctor(self, param)
end

function RoomViewTopRightStrengthItem:_customOnInit()
	self._strengthId = self._param.strengthId
	self._strengthShowType = self._param.strengthShowType or 0
	self._resourceItem.simageicon = gohelper.findChildSingleImage(self._resourceItem.go, "icon")

	local icon = ItemModel.instance:getItemSmallIcon(self._strengthId)

	self._resourceItem.simageicon:LoadImage(icon)
	self:_setShow(true)
end

function RoomViewTopRightStrengthItem:_onClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, self._strengthId, nil, nil, nil, nil, true)
end

function RoomViewTopRightStrengthItem:addEventListeners()
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.ConfirmBuilding, self._refreshUI, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.UnUseBuilding, self._refreshUI, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshUI, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.UpdateBuildingLocalLevels, self._refreshUI, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.UpdateBuildingLevels, self._refreshUI, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshUI, self)
end

function RoomViewTopRightStrengthItem:removeEventListeners()
	return
end

function RoomViewTopRightStrengthItem:_refreshUI()
	local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, self._strengthId)

	self._resourceItem.txtquantity.text = string.format("%s/%s", GameUtil.numberDisplay(quantity), GameUtil.numberDisplay(quantity))

	gohelper.setActive(self._resourceItem.go, self._strengthShowType ~= 1 or quantity > 0)
end

function RoomViewTopRightStrengthItem:_customOnDestory()
	self._resourceItem.simageicon:UnLoadImage()
end

return RoomViewTopRightStrengthItem
