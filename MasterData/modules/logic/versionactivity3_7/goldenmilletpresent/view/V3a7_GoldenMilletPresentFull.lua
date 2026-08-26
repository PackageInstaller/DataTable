-- chunkname: @modules/logic/versionactivity3_7/goldenmilletpresent/view/V3a7_GoldenMilletPresentFull.lua

module("modules.logic.versionactivity3_7.goldenmilletpresent.view.V3a7_GoldenMilletPresentFull", package.seeall)

local V3a7_GoldenMilletPresentFull = class("V3a7_GoldenMilletPresentFull", V3a7_GoldenMilletPresentImpl)

function V3a7_GoldenMilletPresentFull:onInitView()
	self._simageFullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_Fullbg")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "#simage_Title")
	self._simagelogo = gohelper.findChildSingleImage(self.viewGO, "#simage_logo")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._txtdesc = gohelper.findChildText(self.viewGO, "txt_descbg/#txt_desc")
	self._txtname1 = gohelper.findChildText(self.viewGO, "present1/img_namebg/#txt1/#txt_name1")
	self._btnPresent = gohelper.findChildButtonWithAudio(self.viewGO, "present1/#btn_Present")
	self._txtname2 = gohelper.findChildText(self.viewGO, "present2/img_namebg/#txt2/#txt_name2")
	self._txtname3 = gohelper.findChildText(self.viewGO, "present3/img_namebg/#txt3/#txt_name3")
	self._txtname4 = gohelper.findChildText(self.viewGO, "present4/img_namebg/#txt4/#txt_name4")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "#scroll_Reward")
	self._gorewarditem1 = gohelper.findChild(self.viewGO, "#scroll_Reward/Viewport/Content/#go_rewarditem1")
	self._gorewarditem2 = gohelper.findChild(self.viewGO, "#scroll_Reward/Viewport/Content/#go_rewarditem2")
	self._btnGoto = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Goto")
	self._goNormal = gohelper.findChild(self.viewGO, "#btn_Goto/#go_Normal")
	self._goReceived = gohelper.findChild(self.viewGO, "#btn_Goto/#go_Received")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_GoldenMilletPresentFull:addEvents()
	self._btnGoto:AddClickListener(self._btnGotoOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function V3a7_GoldenMilletPresentFull:removeEvents()
	self._btnGoto:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function V3a7_GoldenMilletPresentFull:ctor(...)
	V3a7_GoldenMilletPresentFull.super.ctor(self, ...)
end

function V3a7_GoldenMilletPresentFull:_editableInitView()
	V3a7_GoldenMilletPresentFull.super._editableInitView(self)
end

function V3a7_GoldenMilletPresentFull:onDestroyView()
	V3a7_GoldenMilletPresentFull.super.onDestroyView(self)
end

return V3a7_GoldenMilletPresentFull
