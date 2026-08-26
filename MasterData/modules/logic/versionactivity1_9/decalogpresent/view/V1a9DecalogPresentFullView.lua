-- chunkname: @modules/logic/versionactivity1_9/decalogpresent/view/V1a9DecalogPresentFullView.lua

module("modules.logic.versionactivity1_9.decalogpresent.view.V1a9DecalogPresentFullView", package.seeall)

local V1a9DecalogPresentFullView = class("V1a9DecalogPresentFullView", BaseView)

function V1a9DecalogPresentFullView:onInitView()
	self._txtremainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Claim")
	self._goNormal = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Normal")
	self._goReceived = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Received")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a9DecalogPresentFullView:addEvents()
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
end

function V1a9DecalogPresentFullView:removeEvents()
	self._btnClaim:RemoveClickListener()
end

function V1a9DecalogPresentFullView:_btnClaimOnClick()
	DecalogPresentController.instance:receiveDecalogPresent(self.refreshCanGet, self)
end

function V1a9DecalogPresentFullView:_editableInitView()
	return
end

function V1a9DecalogPresentFullView:onUpdateParam()
	return
end

function V1a9DecalogPresentFullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	self:refresh()
	AudioMgr.instance:trigger(AudioEnum.UI.decalog_present_full_view)
end

function V1a9DecalogPresentFullView:refresh()
	self:refreshCanGet()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
end

function V1a9DecalogPresentFullView:refreshCanGet()
	local isCanGet = DecalogPresentModel.instance:isShowRedDot()

	gohelper.setActive(self._goNormal, isCanGet)
	gohelper.setActive(self._goReceived, not isCanGet)
end

function V1a9DecalogPresentFullView:refreshRemainTime()
	local actId = DecalogPresentModel.instance:getDecalogPresentActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local timeStr = actInfoMo:getRemainTimeStr3(false, true)

	self._txtremainTime.text = string.format(luaLang("remain"), timeStr)
end

function V1a9DecalogPresentFullView:onClose()
	return
end

function V1a9DecalogPresentFullView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

return V1a9DecalogPresentFullView
