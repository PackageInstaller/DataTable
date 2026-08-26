-- chunkname: @modules/logic/equip/view/EquipChooseView.lua

module("modules.logic.equip.view.EquipChooseView", package.seeall)

local EquipChooseView = class("EquipChooseView", BaseView)

function EquipChooseView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrollequip = gohelper.findChildScrollRect(self.viewGO, "#scroll_equip")
	self._gostrengthenbtns = gohelper.findChild(self.viewGO, "topright/#go_strengthenbtns")
	self._btnfastadd = gohelper.findChildButtonWithAudio(self.viewGO, "topright/#go_strengthenbtns/fast/#btn_fastadd")
	self._btnupgrade = gohelper.findChildButtonWithAudio(self.viewGO, "topright/#go_strengthenbtns/start/#btn_upgrade")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipChooseView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnfastadd:AddClickListener(self._btnfastaddOnClick, self)
	self._btnupgrade:AddClickListener(self._btnupgradeOnClick, self)
end

function EquipChooseView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnfastadd:RemoveClickListener()
	self._btnupgrade:RemoveClickListener()
end

function EquipChooseView:_btnfastaddOnClick()
	EquipController.instance:dispatchEvent(EquipEvent.onStrengthenFast)
end

function EquipChooseView:_btnupgradeOnClick()
	EquipController.instance:dispatchEvent(EquipEvent.onStrengthenUpgrade)
end

function EquipChooseView:_btncloseOnClick()
	self:closeThis()
end

function EquipChooseView:_editableInitView()
	EquipChooseListModel.instance:setEquipList()
end

function EquipChooseView:_refreshBtns()
	return
end

function EquipChooseView:onUpdateParam()
	return
end

function EquipChooseView:onOpen()
	return
end

function EquipChooseView:onClose()
	return
end

function EquipChooseView:onDestroyView()
	return
end

return EquipChooseView
