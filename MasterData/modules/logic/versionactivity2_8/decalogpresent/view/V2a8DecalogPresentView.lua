-- chunkname: @modules/logic/versionactivity2_8/decalogpresent/view/V2a8DecalogPresentView.lua

module("modules.logic.versionactivity2_8.decalogpresent.view.V2a8DecalogPresentView", package.seeall)

local V2a8DecalogPresentView = class("V2a8DecalogPresentView", V1a9DecalogPresentView)

function V2a8DecalogPresentView:_editableInitView()
	self.btnMask = gohelper.findChildButton(self.viewGO, "Mask")
end

function V2a8DecalogPresentView:addEvents()
	V2a8DecalogPresentView.super.addEvents(self)
	self.btnMask:AddClickListener(self._btnCloseOnClick, self)
end

function V2a8DecalogPresentView:removeEvents()
	V2a8DecalogPresentView.super.removeEvents(self)
	self.btnMask:RemoveClickListener()
end

function V2a8DecalogPresentView:refreshRemainTime()
	local actId = DecalogPresentModel.instance:getDecalogPresentActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	self._txtremainTime.text = actInfoMo:getRemainTimeStr3(false, true)
end

function V2a8DecalogPresentView:onOpen()
	self:refreshReceiveStatus()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	AudioMgr.instance:trigger(AudioEnum2_8.UI.play_ui_molu_sky_open)
end

function V2a8DecalogPresentView:onClickModalMask()
	self:closeThis()
end

return V2a8DecalogPresentView
