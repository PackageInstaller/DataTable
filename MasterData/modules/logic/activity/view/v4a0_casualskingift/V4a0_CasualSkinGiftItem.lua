-- chunkname: @modules/logic/activity/view/v4a0_casualskingift/V4a0_CasualSkinGiftItem.lua

module("modules.logic.activity.view.v4a0_casualskingift.V4a0_CasualSkinGiftItem", package.seeall)

local V4a0_CasualSkinGiftItem = class("V4a0_CasualSkinGiftItem", RougeSimpleItemBase)

function V4a0_CasualSkinGiftItem:onInitView()
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "#simage_signature")
	self._txtskinname = gohelper.findChildText(self.viewGO, "#txt_skinname")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_skinname/#txt_name")
	self._txtenname = gohelper.findChildText(self.viewGO, "#txt_skinname/#txt_name/#txt_enname")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "#txt_skinname/#btn_check")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a0_CasualSkinGiftItem:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
end

function V4a0_CasualSkinGiftItem:removeEvents()
	self._btncheck:RemoveClickListener()
end

function V4a0_CasualSkinGiftItem:_btncheckOnClick()
	local p = self:parent()

	p:onPresentBtnClick(self)
end

function V4a0_CasualSkinGiftItem:ctor(...)
	V4a0_CasualSkinGiftItem.super.ctor(self, ...)
end

function V4a0_CasualSkinGiftItem:_editableInitView()
	V4a0_CasualSkinGiftItem.super._editableInitView(self)

	self._txtskinname.text = ""
	self._txtname.text = ""
	self._txtenname.text = ""
end

function V4a0_CasualSkinGiftItem:setData(mo)
	V4a0_CasualSkinGiftItem.super.setData(self, mo)

	local skinId = mo[1]
	local c = self:baseViewContainer()
	local skinCo = c:getSkinCo(skinId)

	if skinCo then
		local heroCo = c:getHeroCO(skinCo.characterId)

		self._txtskinname.text = skinCo.name
		self._txtname.text = heroCo.name
		self._txtenname.text = heroCo.nameEng
	else
		self._txtskinname.text = ""
		self._txtname.text = ""
		self._txtenname.text = ""
	end
end

function V4a0_CasualSkinGiftItem:onDestroyView()
	V4a0_CasualSkinGiftItem.super.onDestroyView(self)
end

return V4a0_CasualSkinGiftItem
