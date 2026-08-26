-- chunkname: @modules/logic/versionactivity2_8/wuerlixigift/view/V2a8_WuErLiXiGiftView.lua

module("modules.logic.versionactivity2_8.wuerlixigift.view.V2a8_WuErLiXiGiftView", package.seeall)

local V2a8_WuErLiXiGiftView = class("V2a8_WuErLiXiGiftView", DecalogPresentView)

function V2a8_WuErLiXiGiftView:onInitView()
	self._txtremainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Claim")
	self._goNormal = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Normal")
	self._goHasReceived = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Received")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a8_WuErLiXiGiftView:_btnClaimOnClick()
	V2a8_WuErLiXiGiftController.instance:receiveV2a8_WuErLiXiGift()
end

function V2a8_WuErLiXiGiftView:refreshReceiveStatus()
	local actId = V2a8_WuErLiXiGiftModel.instance:getV2a8_WuErLiXiGiftActId()
	local index = V2a8_WuErLiXiGiftModel.REWARD_INDEX
	local canReceive = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)

	gohelper.setActive(self._goNormal, canReceive)
	gohelper.setActive(self._goHasReceived, not canReceive)
end

function V2a8_WuErLiXiGiftView:refreshRemainTime()
	local actId = V2a8_WuErLiXiGiftModel.instance:getV2a8_WuErLiXiGiftActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local timeStr = actInfoMo:getRemainTimeStr3(false, true)

	self._txtremainTime.text = string.format(luaLang("remain"), timeStr)
end

function V2a8_WuErLiXiGiftView:onOpen()
	self:refreshReceiveStatus()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_button_display)
end

return V2a8_WuErLiXiGiftView
