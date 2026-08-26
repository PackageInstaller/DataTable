-- chunkname: @modules/logic/versionactivity2_4/enter/view/subview/VersionActivity2_4WuErLiXiEnterView.lua

module("modules.logic.versionactivity2_4.enter.view.subview.VersionActivity2_4WuErLiXiEnterView", package.seeall)

local VersionActivity2_4WuErLiXiEnterView = class("VersionActivity2_4WuErLiXiEnterView", VersionActivityEnterBaseSubView)

function VersionActivity2_4WuErLiXiEnterView:onInitView()
	self._txtDescr = gohelper.findChildTextMesh(self.viewGO, "#txt_Descr")
	self._txtLimitTime = gohelper.findChildTextMesh(self.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._goEnterRedDot = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4WuErLiXiEnterView:addEvents()
	self._btnEnter:AddClickListener(self._enterGame, self)
	self._btnLocked:AddClickListener(self._clickLock, self)
end

function VersionActivity2_4WuErLiXiEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
end

function VersionActivity2_4WuErLiXiEnterView:_editableInitView()
	self.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_4Enum.ActivityId.WuErLiXi)
	self._txtDescr.text = self.actCo.actDesc
end

function VersionActivity2_4WuErLiXiEnterView:onOpen()
	RedDotController.instance:addRedDot(self._goEnterRedDot, RedDotEnum.DotNode.V2a4WuErLiXiTask)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_jinru)
	VersionActivity2_4WuErLiXiEnterView.super.onOpen(self)
	self:_refreshTime()
end

function VersionActivity2_4WuErLiXiEnterView:_enterGame()
	WuErLiXiController.instance:enterLevelView()
end

function VersionActivity2_4WuErLiXiEnterView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToast(toastId)
	end
end

function VersionActivity2_4WuErLiXiEnterView:everySecondCall()
	self:_refreshTime()
end

function VersionActivity2_4WuErLiXiEnterView:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_4Enum.ActivityId.WuErLiXi]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end

		local isLock = ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.WuErLiXi) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
	end
end

return VersionActivity2_4WuErLiXiEnterView
