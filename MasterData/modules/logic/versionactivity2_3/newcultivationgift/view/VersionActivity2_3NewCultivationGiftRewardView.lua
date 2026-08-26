-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationGiftRewardView.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationGiftRewardView", package.seeall)

local VersionActivity2_3NewCultivationGiftRewardView = class("VersionActivity2_3NewCultivationGiftRewardView", BaseView)

function VersionActivity2_3NewCultivationGiftRewardView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagedecbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg/#simage_decbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "#scroll_reward")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#scroll_reward/viewport/content/#go_rewarditem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3NewCultivationGiftRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity2_3NewCultivationGiftRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function VersionActivity2_3NewCultivationGiftRewardView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity2_3NewCultivationGiftRewardView:_editableInitView()
	return
end

function VersionActivity2_3NewCultivationGiftRewardView:onDestroyView()
	return
end

return VersionActivity2_3NewCultivationGiftRewardView
