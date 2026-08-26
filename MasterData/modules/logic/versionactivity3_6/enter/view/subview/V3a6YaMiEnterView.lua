-- chunkname: @modules/logic/versionactivity3_6/enter/view/subview/V3a6YaMiEnterView.lua

module("modules.logic.versionactivity3_6.enter.view.subview.V3a6YaMiEnterView", package.seeall)

local V3a6YaMiEnterView = class("V3a6YaMiEnterView", VersionActivityEnterBaseSubView)

function V3a6YaMiEnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Left/#txt_Descr")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._txtUnLocked = gohelper.findChildText(self.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	self._goTry = gohelper.findChild(self.viewGO, "Right/#go_Try")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/#btn_Trial")
	self._goTips = gohelper.findChild(self.viewGO, "Right/#go_Try/#go_Tips")
	self._simageReward = gohelper.findChildSingleImage(self.viewGO, "Right/#go_Try/#go_Tips/#simage_Reward")
	self._txtNum = gohelper.findChildText(self.viewGO, "Right/#go_Try/#go_Tips/#txt_Num")
	self._btnitem = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/#go_Tips/#btn_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	self._btnitem:AddClickListener(self._btnitemOnClick, self)
end

function V3a6YaMiEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
	self._btnitem:RemoveClickListener()
end

function V3a6YaMiEnterView:_btnEnterOnClick()
	V3a6YaMiController.instance:openMainView(false)
end

function V3a6YaMiEnterView:_btnLockedOnClick()
	self:_clickLock()
end

function V3a6YaMiEnterView:_btnTrialOnClick()
	if ActivityHelper.getActivityStatus(self._actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self._actCo.tryoutEpisode

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

function V3a6YaMiEnterView:_clickLock()
	local isCanOpen, toastId, paramList = VersionActivity3_6CanJumpFunc:canJumpTo13608()

	if toastId then
		GameFacade.showToastWithTableParam(toastId, paramList)
	end
end

function V3a6YaMiEnterView:_btnitemOnClick()
	return
end

function V3a6YaMiEnterView:_editableInitView()
	self._actId = VersionActivity3_6Enum.ActivityId.YaMi
	self._actCo = ActivityConfig.instance:getActivityCo(self._actId)
	self._txtDescr.text = self._actCo.actDesc

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V3a6YaMi)
end

function V3a6YaMiEnterView:everySecondCall()
	self:_refreshTime()
end

function V3a6YaMiEnterView:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self._actId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end

		local isLock = ActivityHelper.getActivityStatus(self._actId) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
	end
end

function V3a6YaMiEnterView:onClose()
	V3a6YaMiEnterView.super.onClose(self)
	V3a6YaMiController.instance:onExit()
end

return V3a6YaMiEnterView
