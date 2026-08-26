-- chunkname: @modules/logic/versionactivity3_0/enter/view/subview/VersionActivity3_0KaRongEnterView.lua

module("modules.logic.versionactivity3_0.enter.view.subview.VersionActivity3_0KaRongEnterView", package.seeall)

local VersionActivity3_0KaRongEnterView = class("VersionActivity3_0KaRongEnterView", BaseView)

function VersionActivity3_0KaRongEnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Left/#txt_Descr")
	self._gorewards = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._txtLocked = gohelper.findChildText(self.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/#btn_Trial")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_0KaRongEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
end

function VersionActivity3_0KaRongEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
end

function VersionActivity3_0KaRongEnterView:_btnEnterOnClick()
	local condition = self.config.confirmCondition

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

function VersionActivity3_0KaRongEnterView:_btnLockedOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status == ActivityEnum.ActivityStatus.NotUnlock and toastId then
		GameFacade.showToastWithTableParam(toastId, paramList)
	end
end

function VersionActivity3_0KaRongEnterView:_editableInitView()
	self.actId = self.viewContainer.activityId
	self.config = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.config.actDesc
	self._txtLocked.text = OpenHelper.getActivityUnlockTxt(self.config.openId)
	self.animComp = VersionActivitySubAnimatorComp.get(self.viewGO, self)
end

function VersionActivity3_0KaRongEnterView:onOpen()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onActStatusChange, self)

	local goreddot = gohelper.findChild(self._btnEnter.gameObject, "#go_reddot")
	local redDotIcon = RedDotController.instance:addRedDot(goreddot, RedDotEnum.DotNode.V1a6RoleActivityTask, self.actId)

	redDotIcon:setRedDotTranScale(RedDotEnum.Style.Normal, 1.4, 1.4)
	self:_freshLockStatus()
	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
	self.animComp:playOpenAnim()
end

function VersionActivity3_0KaRongEnterView:onDestroyView()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	self.animComp:destroy()
end

function VersionActivity3_0KaRongEnterView:_freshLockStatus()
	local status = ActivityHelper.getActivityStatus(self.actId)

	gohelper.setActive(self._btnEnter, status ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(self._btnLocked, status == ActivityEnum.ActivityStatus.NotUnlock)
end

function VersionActivity3_0KaRongEnterView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function VersionActivity3_0KaRongEnterView:_onActStatusChange()
	self:_freshLockStatus()
end

function VersionActivity3_0KaRongEnterView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.config.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function VersionActivity3_0KaRongEnterView:_btnTrialOnClick()
	if ActivityHelper.getActivityStatus(VersionActivity3_0Enum.ActivityId.KaRong) == ActivityEnum.ActivityStatus.Normal then
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

return VersionActivity3_0KaRongEnterView
