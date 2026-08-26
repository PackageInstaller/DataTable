-- chunkname: @modules/logic/activity/view/goldenmilletpresent/GoldenMilletPresent.lua

module("modules.logic.activity.view.goldenmilletpresent.GoldenMilletPresent", package.seeall)

local GoldenMilletPresent = class("GoldenMilletPresent", GoldenMilletPresentImpl)

function GoldenMilletPresent:onInitView()
	self._simageFullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_Fullbg")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "#simage_Title")
	self._simagelogo = gohelper.findChildSingleImage(self.viewGO, "#simage_logo")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._txtdesc = gohelper.findChildText(self.viewGO, "txt_descbg/#txt_desc")
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

function GoldenMilletPresent:addEvents()
	self._btnGoto:AddClickListener(self._btnGotoOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function GoldenMilletPresent:removeEvents()
	self._btnGoto:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function GoldenMilletPresent:ctor(...)
	GoldenMilletPresent.super.ctor(self, ...)
end

function GoldenMilletPresent:_editableInitView()
	GoldenMilletPresent.super._editableInitView(self)
end

function GoldenMilletPresent:onDestroyView()
	GoldenMilletPresent.super.onDestroyView(self)
end

function GoldenMilletPresent:onClickModalMask()
	self:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function GoldenMilletPresent:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_langchao_pailian_special)
	GoldenMilletPresent.super.onOpen(self)
end

return GoldenMilletPresent
