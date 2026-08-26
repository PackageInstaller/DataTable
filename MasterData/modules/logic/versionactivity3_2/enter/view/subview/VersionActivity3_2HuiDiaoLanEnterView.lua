-- chunkname: @modules/logic/versionactivity3_2/enter/view/subview/VersionActivity3_2HuiDiaoLanEnterView.lua

module("modules.logic.versionactivity3_2.enter.view.subview.VersionActivity3_2HuiDiaoLanEnterView", package.seeall)

local VersionActivity3_2HuiDiaoLanEnterView = class("VersionActivity3_2HuiDiaoLanEnterView", BaseView)

function VersionActivity3_2HuiDiaoLanEnterView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
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

function VersionActivity3_2HuiDiaoLanEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	self._btnitem:AddClickListener(self._btnitemOnClick, self)
end

function VersionActivity3_2HuiDiaoLanEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
	self._btnitem:RemoveClickListener()
end

function VersionActivity3_2HuiDiaoLanEnterView:_btnEnterOnClick()
	local config = ActivityConfig.instance:getActivityCo(self.actId)
	local condition = config.confirmCondition

	if string.nilorempty(condition) then
		HuiDiaoLanGameController.instance:enterEpisodeLevelView(self.actId)
	else
		local strs = string.split(condition, "=")
		local openId = tonumber(strs[2])
		local userid = PlayerModel.instance:getPlayinfo().userId
		local key = PlayerPrefsKey.EnterRoleActivity .. self.actId .. userid
		local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

		if OpenModel.instance:isFunctionUnlock(openId) or hasTiped then
			HuiDiaoLanGameController.instance:enterEpisodeLevelView(self.actId)
		else
			local openCO = OpenConfig.instance:getOpenCo(openId)
			local dungeonDisplay = DungeonConfig.instance:getEpisodeDisplay(openCO.episodeId)
			local dungeonName = DungeonConfig.instance:getEpisodeCO(openCO.episodeId).name
			local name = dungeonDisplay .. dungeonName

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(key, 1)
				HuiDiaoLanGameController.instance:enterEpisodeLevelView(self.actId)
			end, nil, nil, nil, nil, nil, name)
		end
	end
end

function VersionActivity3_2HuiDiaoLanEnterView:_btnLockedOnClick()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToast(toastId)
	end
end

function VersionActivity3_2HuiDiaoLanEnterView:_btnTrialOnClick()
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

function VersionActivity3_2HuiDiaoLanEnterView:_btnitemOnClick()
	return
end

function VersionActivity3_2HuiDiaoLanEnterView:_editableInitView()
	self.actId = VersionActivity3_2Enum.ActivityId.HuiDiaoLan
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.actCo.actDesc
	self._animator = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function VersionActivity3_2HuiDiaoLanEnterView:onUpdateParam()
	return
end

function VersionActivity3_2HuiDiaoLanEnterView:onOpen()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.Activity220Task, self.actId)
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, TimeUtil.OneMinuteSecond)
	self._animator:Play("open", 0, 0)
end

function VersionActivity3_2HuiDiaoLanEnterView:everySecondCall()
	self:_refreshTime()
end

function VersionActivity3_2HuiDiaoLanEnterView:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end

		local isLock = ActivityHelper.getActivityStatus(self.actId) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
	end
end

function VersionActivity3_2HuiDiaoLanEnterView:onClose()
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function VersionActivity3_2HuiDiaoLanEnterView:onDestroyView()
	return
end

return VersionActivity3_2HuiDiaoLanEnterView
