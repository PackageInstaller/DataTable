-- chunkname: @modules/logic/versionactivity2_5/goldenmilletpresent/view/V2a5_GoldenMilletPresentReceiveView.lua

module("modules.logic.versionactivity2_5.goldenmilletpresent.view.V2a5_GoldenMilletPresentReceiveView", package.seeall)

local V2a5_GoldenMilletPresentReceiveView = class("V2a5_GoldenMilletPresentReceiveView", BaseViewExtended)

function V2a5_GoldenMilletPresentReceiveView:onInitView()
	gohelper.setActive(self.viewGO, true)

	self._txtReceiveRemainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Claim")
	self._goNormal = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Normal")
	self._goHasReceived = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Received")
	self._btnCloseReceive = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._btnBgClose = gohelper.findChildButtonWithAudio(self.viewGO, "close")
end

function V2a5_GoldenMilletPresentReceiveView:addEvents()
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)

	if self._btnCloseReceive then
		self._btnCloseReceive:AddClickListener(self._btnCloseReceiveOnClick, self)
	end

	if self._btnBgClose then
		self._btnBgClose:AddClickListener(self._btnCloseReceiveOnClick, self)
	end

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.afterReceive, self)
end

function V2a5_GoldenMilletPresentReceiveView:removeEvents()
	self._btnClaim:RemoveClickListener()

	if self._btnCloseReceive then
		self._btnCloseReceive:RemoveClickListener()
	end

	if self._btnBgClose then
		self._btnBgClose:RemoveClickListener()
	end

	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.afterReceive, self)
end

function V2a5_GoldenMilletPresentReceiveView:_btnClaimOnClick()
	GoldenMilletPresentController.instance:receiveGoldenMilletPresent(self.afterReceive, self)
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.stop_ui_tangren_songpifu_loop)
end

function V2a5_GoldenMilletPresentReceiveView:_btnCloseReceiveOnClick()
	self.viewContainer:openGoldMilletPresentDisplayView()
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.stop_ui_tangren_songpifu_loop)
end

function V2a5_GoldenMilletPresentReceiveView:onOpen()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	self:refreshReceiveStatus()
	AudioMgr.instance:trigger(AudioEnum.UI.GoldenMilletReceiveViewOpen)
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.play_ui_tangren_songpifu_loop)
end

function V2a5_GoldenMilletPresentReceiveView:refreshReceiveStatus()
	local haveReceived = GoldenMilletPresentModel.instance:haveReceivedSkin()

	gohelper.setActive(self._goNormal, not haveReceived)
	gohelper.setActive(self._goHasReceived, haveReceived)
end

function V2a5_GoldenMilletPresentReceiveView:afterReceive(viewName)
	if viewName == ViewName.CharacterSkinGainView then
		self.viewContainer:openGoldMilletPresentDisplayView()
	end
end

function V2a5_GoldenMilletPresentReceiveView:refreshRemainTime()
	local actId = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local timeStr = actInfoMo:getRemainTimeStr3(false, true)

	self._txtReceiveRemainTime.text = string.format(luaLang("remain"), timeStr)
end

function V2a5_GoldenMilletPresentReceiveView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.stop_ui_tangren_songpifu_loop)
end

return V2a5_GoldenMilletPresentReceiveView
