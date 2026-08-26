-- chunkname: @modules/logic/box/equiplvup/controller/EquipLvUpController.lua

module("modules.logic.box.equiplvup.controller.EquipLvUpController", package.seeall)

local EquipLvUpController = class("EquipLvUpController", BaseController)

function EquipLvUpController:checkOpenEquipLvUpChooseView(itemId, cb, cbObj)
	local isCanOpen, toast = EquipLvUpModel.instance:isCanOpenChooseView(itemId)

	if isCanOpen then
		local param = {
			itemId = itemId
		}

		EquipLvUpModel.instance:clearSelectEquip()
		ViewMgr.instance:openView(ViewName.EquipLvUpChooseView, param)

		return
	end

	if toast then
		ToastController.instance:showToast(toast)

		return
	end

	self:showMessageBox(itemId, cb, cbObj)
end

function EquipLvUpController:showMessageBox(itemId, cb, cbObj)
	self._itemId = itemId
	self._convertYesCb = cb
	self._convertYesCbObj = cbObj

	GameFacade.showMessageBox(MessageBoxIdDefine.EquipLvUpTip, MsgBoxEnum.BoxType.Yes_No, self._convertYesFunc, nil, nil, self)
end

function EquipLvUpController:_convertYesFunc()
	if not self._itemId then
		return
	end

	self:useItem(self._itemId, 0, self._convertYesCb, self._convertYesCbObj)
end

function EquipLvUpController:useItem(itemId, targetId, cb, cbObj)
	local item = {
		quantity = 1,
		materialId = itemId
	}

	ItemRpc.instance:sendUseItemRequest({
		item
	}, targetId, cb, cbObj)
end

EquipLvUpController.instance = EquipLvUpController.New()

return EquipLvUpController
