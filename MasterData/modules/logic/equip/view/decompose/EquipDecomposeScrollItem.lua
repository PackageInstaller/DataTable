-- chunkname: @modules/logic/equip/view/decompose/EquipDecomposeScrollItem.lua

module("modules.logic.equip.view.decompose.EquipDecomposeScrollItem", package.seeall)

local EquipDecomposeScrollItem = class("EquipDecomposeScrollItem", ListScrollCellExtend)

function EquipDecomposeScrollItem:onInitView()
	self._goequip = gohelper.findChild(self.viewGO, "#go_commonequipicon")
	self._goselect = gohelper.findChild(self.viewGO, "#go_selected")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipDecomposeScrollItem:addEvents()
	return
end

function EquipDecomposeScrollItem:removeEvents()
	return
end

function EquipDecomposeScrollItem:_editableInitView()
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.goAni = gohelper.findChild(self.viewGO, "vx_compose")
	self.click = gohelper.getClickWithDefaultAudio(self.viewGO)

	self.click:AddClickListener(self.onClick, self)

	self.commonEquipIcon = IconMgr.instance:getCommonEquipIcon(self._goequip, 1)

	self.addEventCb(self, EquipController.instance, EquipEvent.OnEquipDecomposeSelectEquipChange, self.updateSelected, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.OnEquipBeforeDecompose, self.beforeDecompose, self)
end

function EquipDecomposeScrollItem:onClick()
	if self.equipMo.isLock then
		GameFacade.showToast(ToastEnum.EquipChooseLock)
		ViewMgr.instance:openView(ViewName.EquipInfoTipsView, {
			equipMo = self.equipMo
		})

		return
	end

	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

	if EquipDecomposeListModel.instance:isSelect(self.equipUid) then
		EquipDecomposeListModel.instance:desSelectEquipMo(self.equipMo)
	else
		EquipDecomposeListModel.instance:selectEquipMo(self.equipMo)
	end
end

function EquipDecomposeScrollItem:updateSelected()
	gohelper.setActive(self._goselect, EquipDecomposeListModel.instance:isSelect(self.equipMo.id))
end

function EquipDecomposeScrollItem:onUpdateMO(mo)
	self.equipMo = mo
	self.equipUid = self.equipMo.id

	self.commonEquipIcon:setEquipMO(mo)
	self:updateSelected()
	gohelper.setActive(self.goAni, false)
end

function EquipDecomposeScrollItem:beforeDecompose()
	if EquipDecomposeListModel.instance:isSelect(self.equipUid) then
		gohelper.setActive(self.goAni, true)
	end
end

function EquipDecomposeScrollItem:getAnimator()
	return self.animator
end

function EquipDecomposeScrollItem:onDestroyView()
	self.click:RemoveClickListener()
end

return EquipDecomposeScrollItem
