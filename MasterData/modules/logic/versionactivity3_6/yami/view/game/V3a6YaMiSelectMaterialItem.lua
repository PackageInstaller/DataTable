-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiSelectMaterialItem.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiSelectMaterialItem", package.seeall)

local V3a6YaMiSelectMaterialItem = class("V3a6YaMiSelectMaterialItem", V3a6YaMiMaterialItem)

function V3a6YaMiSelectMaterialItem:_editableAddEvents()
	V3a6YaMiSelectMaterialItem.super._editableAddEvents(self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectProductMaterial, self._onSelectProductMaterial, self)
end

function V3a6YaMiSelectMaterialItem:_editableRemoveEvents()
	V3a6YaMiSelectMaterialItem.super._editableRemoveEvents(self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectProductMaterial, self._onSelectProductMaterial, self)
end

function V3a6YaMiSelectMaterialItem:_btnclickOnClick()
	local isUnlock = self._mo:isUnlock()

	if not isUnlock then
		GameFacade.showToast(V3a6YaMiEnum.ToastId.NoEnoughLevel)

		return
	end

	local isSelect, toast2 = V3a6YaMiModel.instance:onSelectProductMaterial(self._type, self._id)

	self:onSelect(isSelect)

	if toast2 then
		GameFacade.showToast(toast2)

		return
	end
end

function V3a6YaMiSelectMaterialItem:onUpdateMO(mo)
	V3a6YaMiSelectMaterialItem.super.onUpdateMO(self, mo)
	self:refreshSelect()

	self._isCanSelect = true
end

function V3a6YaMiSelectMaterialItem:refreshNum()
	local isSelect = V3a6YaMiModel.instance:isSelectProductMaterial(self._type, self._id)
	local cost = self._mo.co.cost
	local curCost = V3a6YaMiModel.instance:getCurSelectMaterialCost()
	local isEnoughCurrency = V3a6YaMiModel.instance:isEnoughCurrency(curCost + cost)
	local color = (isSelect or isEnoughCurrency) and "#CBCBCB" or "#C36363"

	self._txtnum.color = GameUtil.parseColor(color)
	self._txtnum.text = self._mo.co.cost
end

function V3a6YaMiSelectMaterialItem:_onSelectProductMaterial()
	self:refreshNum()
end

function V3a6YaMiSelectMaterialItem:refreshSelect()
	local isSelect = V3a6YaMiModel.instance:isSelectProductMaterial(self._type, self._id)

	self:onSelect(isSelect)
end

return V3a6YaMiSelectMaterialItem
