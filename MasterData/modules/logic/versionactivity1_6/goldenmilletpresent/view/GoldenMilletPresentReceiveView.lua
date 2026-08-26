-- chunkname: @modules/logic/versionactivity1_6/goldenmilletpresent/view/GoldenMilletPresentReceiveView.lua

module("modules.logic.versionactivity1_6.goldenmilletpresent.view.GoldenMilletPresentReceiveView", package.seeall)

local GoldenMilletPresentReceiveView = class("GoldenMilletPresentReceiveView", BaseViewExtended)

function GoldenMilletPresentReceiveView:onInitView()
	gohelper.setActive(self.viewGO, true)

	self._txtReceiveRemainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Claim")
	self._goNormal = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Normal")
	self._goHasReceived = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Received")
	self._btnCloseReceive = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
end

function GoldenMilletPresentReceiveView:addEvents()
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
	self._btnCloseReceive:AddClickListener(self._btnCloseReceiveOnClick, self)
end

function GoldenMilletPresentReceiveView:removeEvents()
	self._btnClaim:RemoveClickListener()
	self._btnCloseReceive:RemoveClickListener()
end

function GoldenMilletPresentReceiveView:_btnClaimOnClick()
	GoldenMilletPresentController.instance:receiveGoldenMilletPresent(self.refreshReceiveStatus, self)
end

function GoldenMilletPresentReceiveView:_btnCloseReceiveOnClick()
	self.viewContainer:openGoldMilletPresentDisplayView()
end

function GoldenMilletPresentReceiveView:onOpen()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	self:refreshReceiveStatus()
	AudioMgr.instance:trigger(AudioEnum.UI.GoldenMilletReceiveViewOpen)
end

function GoldenMilletPresentReceiveView:refreshReceiveStatus()
	local haveReceived = GoldenMilletPresentModel.instance:haveReceivedSkin()

	gohelper.setActive(self._goNormal, not haveReceived)
	gohelper.setActive(self._goHasReceived, haveReceived)
end

function GoldenMilletPresentReceiveView:refreshRemainTime()
	local actId = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local timeStr = actInfoMo:getRemainTimeStr3(false, true)

	self._txtReceiveRemainTime.text = string.format(luaLang("remain"), timeStr)
end

function GoldenMilletPresentReceiveView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

return GoldenMilletPresentReceiveView
