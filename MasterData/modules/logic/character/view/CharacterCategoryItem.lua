-- chunkname: @modules/logic/character/view/CharacterCategoryItem.lua

module("modules.logic.character.view.CharacterCategoryItem", package.seeall)

local CharacterCategoryItem = class("CharacterCategoryItem", BaseChildView)

function CharacterCategoryItem:onInitView()
	self._gounselected = gohelper.findChild(self.viewGO, "#go_unselected")
	self._txtitemcn1 = gohelper.findChildText(self.viewGO, "#go_unselected/#txt_itemcn1")
	self._txtitemen1 = gohelper.findChildText(self.viewGO, "#go_unselected/#txt_itemen1")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._selectedAnim = gohelper.findChild(self.viewGO, "#go_selected/itemicon2"):GetComponent(typeof(UnityEngine.Animator))
	self._txtitemcn2 = gohelper.findChildText(self.viewGO, "#go_selected/#txt_itemcn2")
	self._txtitemen2 = gohelper.findChildText(self.viewGO, "#go_selected/#txt_itemen2")
	self._gocatereddot = gohelper.findChild(self.viewGO, "#go_catereddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterCategoryItem:addEvents()
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, self._refreshRedDot, self)
end

function CharacterCategoryItem:removeEvents()
	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, self._refreshRedDot, self)
end

function CharacterCategoryItem:_editableInitView()
	self._txtitemcn1.text = self.viewParam.name
	self._txtitemcn2.text = self.viewParam.name
	self._txtitemen1.text = self.viewParam.enName
	self._txtitemen2.text = self.viewParam.enName
	self._index = self.viewParam.index

	self:updateSeletedStatus(1)
	self:_refreshRedDot()

	self._click = gohelper.getClick(self.viewGO)

	self._click:AddClickListener(self._onClick, self)
end

function CharacterCategoryItem:_refreshRedDot()
	if self._index == 1 then
		local roleShow = CharacterModel.instance:hasRoleCouldUp() or CharacterModel.instance:hasRewardGet()

		gohelper.setActive(self._gocatereddot, roleShow)
	else
		local equipShow = false

		gohelper.setActive(self._gocatereddot, equipShow)
	end
end

function CharacterCategoryItem:_onClick()
	if self._isSelected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_first_tabs_click)
	CharacterController.instance:dispatchEvent(CharacterEvent.BackpackChangeCategory, self._index)
end

function CharacterCategoryItem:updateSeletedStatus(index)
	self._isSelected = self._index == index

	self._gounselected:SetActive(not self._isSelected)
	self._goselected:SetActive(self._isSelected)

	if self._isSelected then
		self._selectedAnim:Play("icon_click", 0, 0)
		self._selectedAnim:Update(0)
	end
end

function CharacterCategoryItem:onUpdateParam()
	return
end

function CharacterCategoryItem:onOpen()
	return
end

function CharacterCategoryItem:onClose()
	return
end

function CharacterCategoryItem:onDestroyView()
	self._click:RemoveClickListener()
end

return CharacterCategoryItem
