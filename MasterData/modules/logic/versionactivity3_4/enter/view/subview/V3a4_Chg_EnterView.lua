-- chunkname: @modules/logic/versionactivity3_4/enter/view/subview/V3a4_Chg_EnterView.lua

module("modules.logic.versionactivity3_4.enter.view.subview.V3a4_Chg_EnterView", package.seeall)

local V3a4_Chg_EnterView = class("V3a4_Chg_EnterView", BaseView)

function V3a4_Chg_EnterView:onInitView()
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

function V3a4_Chg_EnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	self._btnitem:AddClickListener(self._btnitemOnClick, self)
end

function V3a4_Chg_EnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
	self._btnitem:RemoveClickListener()
end

function V3a4_Chg_EnterView:_btnitemOnClick()
	return
end

function V3a4_Chg_EnterView:_btnEnterOnClick()
	self:_enterGame()
end

function V3a4_Chg_EnterView:_btnLockedOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status == ActivityEnum.ActivityStatus.NotUnlock and toastId then
		GameFacade.showToastWithTableParam(toastId, paramList)
	end
end

function V3a4_Chg_EnterView:_editableInitView()
	self.actId = self.viewContainer.activityId
	RoleActivityEnum.LevelView[self.actId] = ViewName.V3a4_Chg_LevelView
	self.config = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.config.actDesc
	self._txtUnLocked.text = OpenHelper.getActivityUnlockTxt(self.config.openId)
	self.animComp = VersionActivitySubAnimatorComp.get(self.viewGO, self)
end

function V3a4_Chg_EnterView:onOpen()
	local goreddot = gohelper.findChild(self._btnEnter.gameObject, "#go_reddot")
	local redDotIcon = RedDotController.instance:addRedDot(goreddot, RedDotEnum.DotNode.V1a6RoleActivityTask, self.actId)

	redDotIcon:setRedDotTranScale(RedDotEnum.Style.Normal, 1.4, 1.4)
	self:_freshLockStatus()
	self:_refreshTime()
	TaskDispatcher.cancelTask(self._refreshTime, self)
	TaskDispatcher.runRepeat(self._refreshTime, self, TimeUtil.OneMinuteSecond)
	self.animComp:playOpenAnim()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onActStatusChange, self)
end

function V3a4_Chg_EnterView:_enterGame()
	local config = ActivityConfig.instance:getActivityCo(self.actId)
	local condition = config.confirmCondition

	if string.nilorempty(condition) then
		RoleActivityController.instance:enterActivity(self.actId)
	else
		local strs = string.split(condition, "=")
		local openId = tonumber(strs[2])
		local userid = PlayerModel.instance:getPlayinfo().userId
		local key = PlayerPrefsKey.EnterRoleActivity .. self.actId .. userid
		local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

		if OpenModel.instance:isFunctionUnlock(openId) or hasTiped then
			RoleActivityController.instance:enterActivity(self.actId)
		else
			local openCO = OpenConfig.instance:getOpenCo(openId)
			local dungeonDisplay = DungeonConfig.instance:getEpisodeDisplay(openCO.episodeId)
			local dungeonName = DungeonConfig.instance:getEpisodeCO(openCO.episodeId).name
			local name = dungeonDisplay .. dungeonName

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(key, 1)
				RoleActivityController.instance:enterActivity(self.actId)
			end, nil, nil, nil, nil, nil, name)
		end
	end
end

function V3a4_Chg_EnterView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTime, self)
	self.animComp:destroy()
end

function V3a4_Chg_EnterView:_freshLockStatus()
	local status = ActivityHelper.getActivityStatus(self.actId)

	gohelper.setActive(self._btnEnter.gameObject, status ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(self._btnLocked.gameObject, status == ActivityEnum.ActivityStatus.NotUnlock)
end

function V3a4_Chg_EnterView:_onActStatusChange()
	self:_freshLockStatus()
end

function V3a4_Chg_EnterView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.config.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function V3a4_Chg_EnterView:_btnTrialOnClick()
	if ActivityHelper.getActivityStatus(VersionActivity3_4Enum.ActivityId.Chg) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.config.tryoutEpisode

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

function V3a4_Chg_EnterView:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end

		local isLock = ActivityHelper.getActivityStatus(self.actId) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter.gameObject, not isLock)
		gohelper.setActive(self._btnLocked.gameObject, isLock)
	end
end

function V3a4_Chg_EnterView:onClose()
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function V3a4_Chg_EnterView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

return V3a4_Chg_EnterView
