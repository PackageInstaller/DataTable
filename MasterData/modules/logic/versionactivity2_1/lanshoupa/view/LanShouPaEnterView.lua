-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaEnterView.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaEnterView", package.seeall)

local LanShouPaEnterView = class("LanShouPaEnterView", VersionActivityEnterBaseSubView)

function LanShouPaEnterView:onInitView()
	self._txtLimitTime = gohelper.findChildTextMesh(self.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_Descr")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._gored = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/image_TryBtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LanShouPaEnterView:addEvents()
	self._btnEnter:AddClickListener(self._enterGame, self)
	self._btnLocked:AddClickListener(self._clickLock, self)
	self._btnTrial:AddClickListener(self._clickTrial, self)
end

function LanShouPaEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
end

function LanShouPaEnterView:_editableInitView()
	self.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_1Enum.ActivityId.LanShouPa)
	self._txtDescr.text = self.actCo.actDesc

	RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V2a1LanShouPaTaskRed, VersionActivity2_1Enum.ActivityId.LanShouPa)
end

function LanShouPaEnterView:onOpen()
	LanShouPaEnterView.super.onOpen(self)
	self:_refreshTime()
end

function LanShouPaEnterView:onClose()
	LanShouPaEnterView.super.onClose(self)
end

function LanShouPaEnterView:_enterGame()
	Activity164Rpc.instance:sendGetActInfoRequest(VersionActivity2_1Enum.ActivityId.LanShouPa, self._onRecvMsg, self)
end

function LanShouPaEnterView:_onRecvMsg(cmd, resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.LanShouPaMapView)
	end
end

function LanShouPaEnterView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function LanShouPaEnterView:_clickTrial()
	if ActivityHelper.getActivityStatus(VersionActivity2_1Enum.ActivityId.LanShouPa) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function LanShouPaEnterView:everySecondCall()
	self:_refreshTime()
end

function LanShouPaEnterView:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_1Enum.ActivityId.LanShouPa]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end

		local isLock = ActivityHelper.getActivityStatus(VersionActivity2_1Enum.ActivityId.LanShouPa) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
	end
end

return LanShouPaEnterView
