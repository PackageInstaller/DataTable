-- chunkname: @modules/logic/activity/view/V2a8_DragonBoat_PanelView.lua

module("modules.logic.activity.view.V2a8_DragonBoat_PanelView", package.seeall)

local V2a8_DragonBoat_PanelView = class("V2a8_DragonBoat_PanelView", V2a8_DragonBoat_ViewImpl)

function V2a8_DragonBoat_PanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "root/#simage_FullBG")
	self._imagetitle = gohelper.findChildImage(self.viewGO, "root/#image_title")
	self._imagelogo = gohelper.findChildImage(self.viewGO, "root/#image_logo")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "root/timebg/#txt_LimitTime")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "root/Left/#btn_start")
	self._goitem = gohelper.findChild(self.viewGO, "root/reward/normal/#go_item")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_ItemList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a8_DragonBoat_PanelView:addEvents()
	V2a8_DragonBoat_PanelView.super.addEvents(self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnnormal:AddClickListener(self._onItemClick, self)
	self._btncanget:AddClickListener(self._onItemClick, self)
	self._btnhasget:AddClickListener(self._onItemClick, self)
end

function V2a8_DragonBoat_PanelView:removeEvents()
	V2a8_DragonBoat_PanelView.super.removeEvents(self)
	self._btnclose:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnnormal:RemoveClickListener()
	self._btncanget:RemoveClickListener()
	self._btnhasget:RemoveClickListener()
end

function V2a8_DragonBoat_PanelView:_btncloseOnClick()
	self:closeThis()
end

function V2a8_DragonBoat_PanelView:_btnstartOnClick()
	self:_onClickMedicinalBath()
end

function V2a8_DragonBoat_PanelView:_btnemptyTopOnClick()
	self:closeThis()
end

function V2a8_DragonBoat_PanelView:_btnemptyBottomOnClick()
	self:closeThis()
end

function V2a8_DragonBoat_PanelView:_btnemptyLeftOnClick()
	self:closeThis()
end

function V2a8_DragonBoat_PanelView:_btnemptyRightOnClick()
	self:closeThis()
end

function V2a8_DragonBoat_PanelView:onClickModalMask()
	self:closeThis()
end

function V2a8_DragonBoat_PanelView:_editableInitView()
	self._normalGo = gohelper.findChild(self.viewGO, "root/reward/normal")
	self._cangetGo = gohelper.findChild(self.viewGO, "root/reward/canget")
	self._hasgetGo = gohelper.findChild(self.viewGO, "root/reward/hasget")
	self._txt_dec = gohelper.findChildText(self._normalGo, "tips/txt_dec")
	self._leftGo = gohelper.findChild(self.viewGO, "root/Left")
	self._btnstartGO = self._btnstart.gameObject
	self._scrollItemListGo = self._scrollItemList.gameObject
	self._btnnormal = gohelper.getClickWithDefaultAudio(self._normalGo)
	self._btncanget = gohelper.getClickWithDefaultAudio(self._cangetGo)
	self._btnhasget = gohelper.getClickWithDefaultAudio(self._hasgetGo)

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	V2a8_DragonBoat_PanelView.super._editableInitView(self)
end

return V2a8_DragonBoat_PanelView
