-- chunkname: @modules/logic/activity/view/goldenmilletpresent/GoldenMilletPresentFull.lua

module("modules.logic.activity.view.goldenmilletpresent.GoldenMilletPresentFull", package.seeall)

local GoldenMilletPresentFull = class("GoldenMilletPresentFull", GoldenMilletPresentImpl)

function GoldenMilletPresentFull:onInitView()
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

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GoldenMilletPresentFull:addEvents()
	self._btnGoto:AddClickListener(self._btnGotoOnClick, self)
end

function GoldenMilletPresentFull:removeEvents()
	self._btnGoto:RemoveClickListener()
end

function GoldenMilletPresentFull:ctor(...)
	GoldenMilletPresentFull.super.ctor(self, ...)
end

function GoldenMilletPresentFull:_editableInitView()
	GoldenMilletPresentFull.super._editableInitView(self)
end

function GoldenMilletPresentFull:onDestroyView()
	GoldenMilletPresentFull.super.onDestroyView(self)
end

function GoldenMilletPresentFull:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_building_collect_20234002)
	GoldenMilletPresentFull.super.onOpen(self)
end

return GoldenMilletPresentFull
