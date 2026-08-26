-- chunkname: @modules/logic/versionactivity1_9/semmelweisgift/view/SemmelWeisGiftView.lua

module("modules.logic.versionactivity1_9.semmelweisgift.view.SemmelWeisGiftView", package.seeall)

local SemmelWeisGiftView = class("SemmelWeisGiftView", DecalogPresentView)

function SemmelWeisGiftView:onInitView()
	self._txtremainTime = gohelper.findChildText(self.viewGO, "Root/image_TimeBG/#txt_remainTime")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Claim")
	self._goNormal = gohelper.findChild(self.viewGO, "Root/#btn_Claim/#go_Normal")
	self._goHasReceived = gohelper.findChild(self.viewGO, "Root/#btn_Claim/#go_Received")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SemmelWeisGiftView:_btnClaimOnClick()
	SemmelWeisGiftController.instance:receiveSemmelWeisGift()
end

function SemmelWeisGiftView:refreshReceiveStatus()
	local actId = SemmelWeisGiftModel.instance:getSemmelWeisGiftActId()
	local index = SemmelWeisGiftModel.REWARD_INDEX
	local canReceive = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)

	gohelper.setActive(self._goNormal, canReceive)
	gohelper.setActive(self._goHasReceived, not canReceive)
end

function SemmelWeisGiftView:refreshRemainTime()
	local actId = SemmelWeisGiftModel.instance:getSemmelWeisGiftActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local timeStr = actInfoMo:getRemainTimeStr3(false, true)

	self._txtremainTime.text = string.format(luaLang("remain"), timeStr)
end

return SemmelWeisGiftView
