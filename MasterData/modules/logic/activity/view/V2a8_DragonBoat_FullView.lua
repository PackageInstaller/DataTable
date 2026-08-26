-- chunkname: @modules/logic/activity/view/V2a8_DragonBoat_FullView.lua

module("modules.logic.activity.view.V2a8_DragonBoat_FullView", package.seeall)

local V2a8_DragonBoat_FullView = class("V2a8_DragonBoat_FullView", V2a8_DragonBoat_ViewImpl)

function V2a8_DragonBoat_FullView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._imagetitle = gohelper.findChildImage(self.viewGO, "#image_title")
	self._imagelogo = gohelper.findChildImage(self.viewGO, "#image_logo")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "timebg/#txt_LimitTime")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_start")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "#scroll_ItemList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a8_DragonBoat_FullView:addEvents()
	V2a8_DragonBoat_FullView.super.addEvents(self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnnormal:AddClickListener(self._onItemClick, self)
	self._btncanget:AddClickListener(self._onItemClick, self)
	self._btnhasget:AddClickListener(self._onItemClick, self)
end

function V2a8_DragonBoat_FullView:removeEvents()
	V2a8_DragonBoat_FullView.super.removeEvents(self)
	self._btnstart:RemoveClickListener()
	self._btnnormal:RemoveClickListener()
	self._btncanget:RemoveClickListener()
	self._btnhasget:RemoveClickListener()
end

function V2a8_DragonBoat_FullView:_btnstartOnClick()
	self:_onClickMedicinalBath()
end

function V2a8_DragonBoat_FullView:_editableInitView()
	self._normalGo = gohelper.findChild(self.viewGO, "reward/normal")
	self._cangetGo = gohelper.findChild(self.viewGO, "reward/canget")
	self._hasgetGo = gohelper.findChild(self.viewGO, "reward/hasget")
	self._txt_dec = gohelper.findChildText(self._normalGo, "tips/txt_dec")
	self._leftGo = gohelper.findChild(self.viewGO, "Left")
	self._btnstartGO = self._btnstart.gameObject
	self._scrollItemListGo = self._scrollItemList.gameObject
	self._btnnormal = gohelper.getClickWithDefaultAudio(self._normalGo)
	self._btncanget = gohelper.getClickWithDefaultAudio(self._cangetGo)
	self._btnhasget = gohelper.getClickWithDefaultAudio(self._hasgetGo)

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	V2a8_DragonBoat_FullView.super._editableInitView(self)
end

return V2a8_DragonBoat_FullView
