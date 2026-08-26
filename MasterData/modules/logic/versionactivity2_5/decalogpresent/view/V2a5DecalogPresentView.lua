-- chunkname: @modules/logic/versionactivity2_5/decalogpresent/view/V2a5DecalogPresentView.lua

module("modules.logic.versionactivity2_5.decalogpresent.view.V2a5DecalogPresentView", package.seeall)

local V2a5DecalogPresentView = class("V2a5DecalogPresentView", V1a9DecalogPresentView)

function V2a5DecalogPresentView:_editableInitView()
	self.btnMask = gohelper.findChildButton(self.viewGO, "Mask")
end

function V2a5DecalogPresentView:addEvents()
	V2a5DecalogPresentView.super.addEvents(self)
	self.btnMask:AddClickListener(self._btnCloseOnClick, self)
end

function V2a5DecalogPresentView:removeEvents()
	V2a5DecalogPresentView.super.removeEvents(self)
	self.btnMask:RemoveClickListener()
end

function V2a5DecalogPresentView:refreshRemainTime()
	local actId = DecalogPresentModel.instance:getDecalogPresentActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	self._txtremainTime.text = actInfoMo:getRemainTimeStr3(false, true)
end

function V2a5DecalogPresentView:onOpen()
	self:refreshReceiveStatus()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_qiyuan_unlock_1)
end

return V2a5DecalogPresentView
