-- chunkname: @modules/logic/versionactivity4_0/enter/view/subview/VersionActivity4_0DeleikeEnterView.lua

module("modules.logic.versionactivity4_0.enter.view.subview.VersionActivity4_0DeleikeEnterView", package.seeall)

local VersionActivity4_0DeleikeEnterView = class("VersionActivity4_0DeleikeEnterView", VersionActivityEnterBaseSubView)

function VersionActivity4_0DeleikeEnterView:onInitView()
	self._txtDescr = gohelper.findChildText(self.viewGO, "Left/#txt_Descr")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/image_LimitTimeBG/#txt_LimitTime")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._goEnterRedDot = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._goTry = gohelper.findChild(self.viewGO, "Right/#go_Try")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/#btn_Trial")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity4_0DeleikeEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
end

function VersionActivity4_0DeleikeEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
end

function VersionActivity4_0DeleikeEnterView:_btnEnterOnClick()
	local condition = self.actCo.confirmCondition

	if string.nilorempty(condition) then
		self:_enterLevelView()
	else
		local strs = string.split(condition, "=")
		local openId = tonumber(strs[2])
		local userid = PlayerModel.instance:getPlayinfo().userId
		local key = PlayerPrefsKey.EnterRoleActivity .. self.actId .. userid
		local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

		if OpenModel.instance:isFunctionUnlock(openId) or hasTiped then
			self:_enterLevelView()
		else
			local openCO = OpenConfig.instance:getOpenCo(openId)
			local dungeonDisplay = DungeonConfig.instance:getEpisodeDisplay(openCO.episodeId)
			local dungeonName = DungeonConfig.instance:getEpisodeCO(openCO.episodeId).name
			local name = dungeonDisplay .. dungeonName

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(key, 1)
				self:_enterLevelView()
			end, nil, nil, nil, nil, nil, name)
		end
	end
end

function VersionActivity4_0DeleikeEnterView:_enterLevelView()
	DeleikeController.instance:enterEpisodeLevelView()
end

function VersionActivity4_0DeleikeEnterView:_btnLockOnClick()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function VersionActivity4_0DeleikeEnterView:_btnTrialOnClick()
	if ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		if config then
			DungeonFightController.instance:enterFight(config.chapterId, episodeId)
		end
	else
		self:_btnLockOnClick()
	end
end

function VersionActivity4_0DeleikeEnterView:_editableInitView()
	self._animator = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function VersionActivity4_0DeleikeEnterView:onOpen()
	self.actId = self.viewContainer.activityId
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.actCo.actDesc

	RedDotController.instance:addRedDot(self._goEnterRedDot, RedDotEnum.DotNode.Activity220Task, self.actId)
	VersionActivity4_0DeleikeEnterView.super.onOpen(self)
end

function VersionActivity4_0DeleikeEnterView:everySecondCall()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end

		local isLock = ActivityHelper.getActivityStatus(self.actId) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
	end
end

return VersionActivity4_0DeleikeEnterView
