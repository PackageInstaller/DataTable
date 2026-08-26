-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinBackpackItem.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinBackpackItem", package.seeall)

local AssassinBackpackItem = class("AssassinBackpackItem", ListScrollCellExtend)

function AssassinBackpackItem:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "#simage_icon")
	self._goequip = gohelper.findChild(self.viewGO, "#go_equip")
	self._txtequipIndex = gohelper.findChildText(self.viewGO, "#go_equip/#txt_equipIndex")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._btnclick = gohelper.findChildClickWithAudio(self.viewGO, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_itemchoose)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinBackpackItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnChangeEquippedItem, self._onChangeEquippedItem, self)
end

function AssassinBackpackItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnChangeEquippedItem, self._onChangeEquippedItem, self)
end

function AssassinBackpackItem:_btnclickOnClick()
	AssassinController.instance:backpackSelectItem(self._index, true)
end

function AssassinBackpackItem:_onChangeEquippedItem()
	self:refresh(true)
end

function AssassinBackpackItem:_editableInitView()
	self._animator = self._goselected:GetComponent(typeof(UnityEngine.Animator))
end

function AssassinBackpackItem:onUpdateMO(mo)
	self._mo = mo

	self:refresh()
end

function AssassinBackpackItem:refresh(checkAnim)
	local assassinItemId = self._mo:getId()

	AssassinHelper.setAssassinItemIcon(assassinItemId, self._imageicon)

	self._txtnum.text = self._mo:getCount()

	local assassinHeroId = self._view.viewContainer.viewParam.assassinHeroId
	local equipIndex = AssassinHeroModel.instance:getItemCarryIndex(assassinHeroId, assassinItemId)

	if equipIndex then
		self._txtequipIndex.text = equipIndex

		if checkAnim and equipIndex and not self._goequip.activeSelf then
			self._animator:Play("click", 0, 0)
		end
	end

	gohelper.setActive(self._goequip, equipIndex)
end

function AssassinBackpackItem:onSelect(isSelect)
	gohelper.setActive(self._goselected, isSelect)
end

function AssassinBackpackItem:onDestroyView()
	return
end

return AssassinBackpackItem
