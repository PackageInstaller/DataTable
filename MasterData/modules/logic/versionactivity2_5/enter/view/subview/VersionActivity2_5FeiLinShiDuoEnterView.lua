-- chunkname: @modules/logic/versionactivity2_5/enter/view/subview/VersionActivity2_5FeiLinShiDuoEnterView.lua

module("modules.logic.versionactivity2_5.enter.view.subview.VersionActivity2_5FeiLinShiDuoEnterView", package.seeall)

local VersionActivity2_5FeiLinShiDuoEnterView = class("VersionActivity2_5FeiLinShiDuoEnterView", VersionActivityEnterBaseSubView)

function VersionActivity2_5FeiLinShiDuoEnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._gorewards = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._txtUnLocked = gohelper.findChildText(self.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	self._goTry = gohelper.findChild(self.viewGO, "Right/#go_Try")
	self._goTips = gohelper.findChild(self.viewGO, "Right/#go_Try/#go_Tips")
	self._simageReward = gohelper.findChildSingleImage(self.viewGO, "Right/#go_Try/#go_Tips/#simage_Reward")
	self._txtNum = gohelper.findChildText(self.viewGO, "Right/#go_Try/#go_Tips/#txt_Num")
	self._btnitem = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/#go_Tips/#btn_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_5FeiLinShiDuoEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	self._btnitem:AddClickListener(self._btnitemOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
end

function VersionActivity2_5FeiLinShiDuoEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnitem:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
end

function VersionActivity2_5FeiLinShiDuoEnterView:_btnEnterOnClick()
	FeiLinShiDuoGameController.instance:enterEpisodeLevelView(self.actId)
end

function VersionActivity2_5FeiLinShiDuoEnterView:_btnLockedOnClick()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToast(toastId)
	end
end

function VersionActivity2_5FeiLinShiDuoEnterView:_btnitemOnClick()
	return
end

function VersionActivity2_5FeiLinShiDuoEnterView:_btnTrialOnClick()
	if ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal then
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

function VersionActivity2_5FeiLinShiDuoEnterView:_editableInitView()
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/image_TryBtn")
	self.actId = VersionActivity2_5Enum.ActivityId.FeiLinShiDuo
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.actCo.actDesc
end

function VersionActivity2_5FeiLinShiDuoEnterView:onUpdateParam()
	return
end

function VersionActivity2_5FeiLinShiDuoEnterView:onOpen()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a5_Act185)
	VersionActivity2_5FeiLinShiDuoEnterView.super.onOpen(self)
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, TimeUtil.OneMinuteSecond)
end

function VersionActivity2_5FeiLinShiDuoEnterView:_refreshTime()
	local actId = self.actId
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end

		local isLock = ActivityHelper.getActivityStatus(actId) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
	end
end

function VersionActivity2_5FeiLinShiDuoEnterView:onClose()
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function VersionActivity2_5FeiLinShiDuoEnterView:onDestroyView()
	return
end

return VersionActivity2_5FeiLinShiDuoEnterView
