-- chunkname: @modules/logic/equip/view/EquipRefineSelectedItem.lua

module("modules.logic.equip.view.EquipRefineSelectedItem", package.seeall)

local EquipRefineSelectedItem = class("EquipRefineSelectedItem", ListScrollCellExtend)

function EquipRefineSelectedItem:onInitView()
	self._goempty = gohelper.findChild(self.viewGO, "#go_cost_empty")
	self._goequip = gohelper.findChild(self.viewGO, "#go_cost_equip")
	self._btnclick = gohelper.findChildButton(self.viewGO, "#btn_add_click")
	self._goClickEffect = gohelper.findChild(self.viewGO, "#click_effect")
	self._effectImage = gohelper.findChildImage(self.viewGO, "#click_effect/images")
	self._addEffectAnim = self._goClickEffect:GetComponent(typeof(UnityEngine.Animation))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipRefineSelectedItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function EquipRefineSelectedItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function EquipRefineSelectedItem:_btnclickOnClick()
	if self._isEmpty then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, true)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		EquipRefineListModel.instance:deselectEquip(self._mo)
		EquipRefineListModel.instance:refreshData()
	end
end

function EquipRefineSelectedItem:_editableInitView()
	self._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(self._goequip, 1)

	self._commonEquipIcon._overrideLoadIconFunc(self._commonEquipIcon, EquipHelper.getEquipIconLoadPath, self._commonEquipIcon)
	gohelper.setActive(self._goequip, false)

	self._isEmpty = true

	self:initAddEquipEffect()
end

function EquipRefineSelectedItem:_editableAddEvents()
	return
end

function EquipRefineSelectedItem:_editableRemoveEvents()
	return
end

function EquipRefineSelectedItem:onUpdateMO(mo)
	self:_stopAddEquipEffect()

	self._mo = mo
	self._isEmpty = true

	if self._mo.config then
		self._isEmpty = false

		self._commonEquipIcon:setEquipMO(self._mo)
	end

	gohelper.setActive(self._goClickEffect, not self._isEmpty)
	gohelper.setActive(self._goequip, not self._isEmpty)
	gohelper.setActive(self._goempty, self._isEmpty)
end

function EquipRefineSelectedItem:initAddEquipEffect()
	local material = self._effectImage.material

	self._effectImage.material = UnityEngine.Object.Instantiate(material)

	local materialPropsCtrl = self._goClickEffect:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	materialPropsCtrl.mas:Clear()
	materialPropsCtrl.mas:Add(self._effectImage.material)
	self._addEffectAnim:Stop()
end

function EquipRefineSelectedItem:_playAddEquipEffect(id)
	if self._mo.uid == id then
		self._addEffectAnim.enabled = true

		gohelper.setActive(self._effectImage.gameObject, true)
		self._addEffectAnim:Stop()
		self._addEffectAnim:Play()
	end
end

function EquipRefineSelectedItem:dispose()
	return
end

function EquipRefineSelectedItem:_stopAddEquipEffect()
	self._addEffectAnim:Rewind()

	self._addEffectAnim.enabled = false

	gohelper.setActive(self._effectImage.gameObject, false)
end

function EquipRefineSelectedItem:onDestroyView()
	return
end

return EquipRefineSelectedItem
