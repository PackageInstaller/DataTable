-- chunkname: @modules/logic/activity/view/LinkageActivity_FullView_Page1.lua

module("modules.logic.activity.view.LinkageActivity_FullView_Page1", package.seeall)

local LinkageActivity_FullView_Page1 = class("LinkageActivity_FullView_Page1", LinkageActivity_Page1)

function LinkageActivity_FullView_Page1:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "view/#simage_bg")
	self._simagesignature1 = gohelper.findChildSingleImage(self.viewGO, "view/left/role1/#simage_signature1")
	self._simagesignature2 = gohelper.findChildSingleImage(self.viewGO, "view/left/role2/#simage_signature2")
	self._txtdurationTime = gohelper.findChildText(self.viewGO, "view/right/time/#txt_durationTime")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/right/#btn_buy")
	self._btnChange = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Change")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LinkageActivity_FullView_Page1:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnChange:AddClickListener(self._btnChangeOnClick, self)
end

function LinkageActivity_FullView_Page1:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btnChange:RemoveClickListener()
end

function LinkageActivity_FullView_Page1:ctor(...)
	LinkageActivity_FullView_Page1.super.ctor(self, ...)
end

function LinkageActivity_FullView_Page1:_editableInitView()
	LinkageActivity_FullView_Page1.super._editableInitView(self)

	self._txtdurationTime.text = ""

	self:setActive(false)
end

function LinkageActivity_FullView_Page1:_btnbuyOnClick()
	self:jump()
end

function LinkageActivity_FullView_Page1:_btnChangeOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_switch_20220009)
	self:selectedPage(2)
end

function LinkageActivity_FullView_Page1:onUpdateMO(mo)
	LinkageActivity_FullView_Page1.super.onUpdateMO(self, mo)

	self._txtdurationTime.text = self:getDurationTimeStr()
end

return LinkageActivity_FullView_Page1
