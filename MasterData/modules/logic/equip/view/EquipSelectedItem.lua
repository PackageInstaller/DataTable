-- chunkname: @modules/logic/equip/view/EquipSelectedItem.lua

module("modules.logic.equip.view.EquipSelectedItem", package.seeall)

local EquipSelectedItem = class("EquipSelectedItem", ListScrollCellExtend)

function EquipSelectedItem:onInitView()
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._goequip = gohelper.findChild(self.viewGO, "#go_equip")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goClickEffect = gohelper.findChild(self.viewGO, "#click_effect")
	self._goEffectImage = gohelper.findChild(self.viewGO, "#click_effect/images")
	self._addEffectAnim = self._goClickEffect:GetComponent(typeof(UnityEngine.Animation))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipSelectedItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onAddEquipToPlayEffect, self._playAddEquipEffect, self)
end

function EquipSelectedItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function EquipSelectedItem:_btnclickOnClick()
	if self._isEmpty then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, true)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		EquipChooseListModel.instance:deselectEquip(self._mo)
		EquipController.instance:dispatchEvent(EquipEvent.onChooseEquip)
	end
end

function EquipSelectedItem:_editableInitView()
	self._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(self._goequip, 1)

	self._commonEquipIcon._overrideLoadIconFunc(self._commonEquipIcon, EquipHelper.getEquipIconLoadPath, self._commonEquipIcon)
	gohelper.setActive(self._goequip, false)
	gohelper.removeUIClickAudio(self._btnclick.gameObject)

	self._isEmpty = true

	self:initAddEquipEffect()
end

function EquipSelectedItem:_editableAddEvents()
	return
end

function EquipSelectedItem:_editableRemoveEvents()
	return
end

function EquipSelectedItem:onUpdateMO(mo)
	self:_stopAddEquipEffect()

	self._mo = mo
	self._isEmpty = true

	if self._mo.config then
		self._isEmpty = false

		self._commonEquipIcon:setEquipMO(self._mo)

		self._commonEquipIcon._txtnum.text = string.format("%s/%s", self._mo._chooseNum, GameUtil.numberDisplay(self._mo.count))
	end

	gohelper.setActive(self._goClickEffect, not self._isEmpty)
	gohelper.setActive(self._goequip, not self._isEmpty)
	gohelper.setActive(self._goempty, self._isEmpty)
end

function EquipSelectedItem:initAddEquipEffect()
	local image = gohelper.findChildImage(self._goClickEffect, "images")
	local material = image.material

	image.material = UnityEngine.Object.Instantiate(material)

	local materialPropsCtrl = self._goClickEffect:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	materialPropsCtrl.mas:Clear()
	materialPropsCtrl.mas:Add(image.material)
	self._addEffectAnim:Stop()
end

function EquipSelectedItem:_playAddEquipEffect(idList)
	if tabletool.indexOf(idList, self._mo.uid) then
		self._addEffectAnim.enabled = true

		gohelper.setActive(self._goEffectImage, true)
		self._addEffectAnim:Stop()
		self._addEffectAnim:Play()
	end
end

function EquipSelectedItem:dispose()
	return
end

function EquipSelectedItem:_stopAddEquipEffect()
	self._addEffectAnim:Rewind()

	self._addEffectAnim.enabled = false

	gohelper.setActive(self._goEffectImage, false)
end

function EquipSelectedItem:onSelect(isSelect)
	return
end

function EquipSelectedItem:onDestroyView()
	return
end

return EquipSelectedItem
