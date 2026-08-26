-- chunkname: @modules/logic/equip/view/EquipStrengthenAlertView.lua

module("modules.logic.equip.view.EquipStrengthenAlertView", package.seeall)

local EquipStrengthenAlertView = class("EquipStrengthenAlertView", BaseView)

function EquipStrengthenAlertView:onInitView()
	self._simagetipbg = gohelper.findChildSingleImage(self.viewGO, "#simage_tipbg")
	self._txtcontent = gohelper.findChildText(self.viewGO, "#txt_content")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnselect = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_select")
	self._goselected = gohelper.findChild(self.viewGO, "#go_btns/#btn_select/#go_selected")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_cancel")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_ok")
	self._simagebgnum = gohelper.findChildSingleImage(self.viewGO, "#simage_bg_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipStrengthenAlertView:addEvents()
	self._btnselect:AddClickListener(self._btnselectOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
end

function EquipStrengthenAlertView:removeEvents()
	self._btnselect:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnok:RemoveClickListener()
end

function EquipStrengthenAlertView:_btnselectOnClick()
	self._isSelected = not self._isSelected

	self._goselected:SetActive(self._isSelected)
end

function EquipStrengthenAlertView:_btncancelOnClick()
	self:closeThis()
end

function EquipStrengthenAlertView:_btnokOnClick()
	self:closeThis()
	self.viewParam.callback(self._isSelected)
end

function EquipStrengthenAlertView:_editableInitView()
	self._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
	self._simagebgnum:LoadImage(ResUrl.getMessageIcon("bg_num"))
	gohelper.addUIClickAudio(self._btncancel.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.addUIClickAudio(self._btnok.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
end

function EquipStrengthenAlertView:onUpdateParam()
	return
end

function EquipStrengthenAlertView:onOpen()
	self._txtcontent.text = self.viewParam.content
	self._isSelected = false

	self._goselected:SetActive(self._isSelected)
end

function EquipStrengthenAlertView:onClose()
	return
end

function EquipStrengthenAlertView:onDestroyView()
	self._simagetipbg:UnLoadImage()
	self._simagebgnum:UnLoadImage()
end

return EquipStrengthenAlertView
