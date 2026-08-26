-- chunkname: @modules/logic/versionactivity2_7/enter/view/subview/V2a7_LengZhou6EnterView.lua

module("modules.logic.versionactivity2_7.enter.view.subview.V2a7_LengZhou6EnterView", package.seeall)

local V2a7_LengZhou6EnterView = class("V2a7_LengZhou6EnterView", VersionActivityEnterBaseSubView)

function V2a7_LengZhou6EnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._simageTitleeff = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title/#simage_Title_eff")
	self._gorewards = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
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

function V2a7_LengZhou6EnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	self._btnitem:AddClickListener(self._btnitemOnClick, self)
end

function V2a7_LengZhou6EnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
	self._btnitem:RemoveClickListener()
end

function V2a7_LengZhou6EnterView:_btnEnterOnClick()
	LengZhou6Controller.instance:enterLevelView(self.actId)
end

function V2a7_LengZhou6EnterView:_btnitemOnClick()
	return
end

function V2a7_LengZhou6EnterView:_btnTrialOnClick()
	if ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_btnLockedOnClick()
	end
end

function V2a7_LengZhou6EnterView:_btnLockedOnClick()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function V2a7_LengZhou6EnterView:_editableInitView()
	self.actId = LengZhou6Model.instance:getAct190Id()
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.actCo.actDesc
end

function V2a7_LengZhou6EnterView:onUpdateParam()
	return
end

function V2a7_LengZhou6EnterView:onOpen()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a7LengZhou6)
	V2a7_LengZhou6EnterView.super.onOpen(self)
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, TimeUtil.OneMinuteSecond)
end

function V2a7_LengZhou6EnterView:_refreshTime()
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

function V2a7_LengZhou6EnterView:onClose()
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function V2a7_LengZhou6EnterView:onDestroyView()
	return
end

return V2a7_LengZhou6EnterView
