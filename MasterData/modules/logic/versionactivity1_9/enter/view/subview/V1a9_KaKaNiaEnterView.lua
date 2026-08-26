-- chunkname: @modules/logic/versionactivity1_9/enter/view/subview/V1a9_KaKaNiaEnterView.lua

module("modules.logic.versionactivity1_9.enter.view.subview.V1a9_KaKaNiaEnterView", package.seeall)

local V1a9_KaKaNiaEnterView = class("V1a9_KaKaNiaEnterView", BaseView)

function V1a9_KaKaNiaEnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._gorewards = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._txtLocked = gohelper.findChildText(self.viewGO, "Right/#btn_Locked/#txt_UnLocked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a9_KaKaNiaEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
end

function V1a9_KaKaNiaEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
end

function V1a9_KaKaNiaEnterView:_btnEnterOnClick()
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

function V1a9_KaKaNiaEnterView:_btnLockedOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status == ActivityEnum.ActivityStatus.NotUnlock and toastId then
		GameFacade.showToastWithTableParam(toastId, paramList)
	end
end

function V1a9_KaKaNiaEnterView:_editableInitView()
	self.actId = VersionActivity1_9Enum.ActivityId.KaKaNia
	self.config = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.config.actDesc
	self._txtLocked.text = OpenHelper.getActivityUnlockTxt(self.config.openId)
	self.animComp = VersionActivitySubAnimatorComp.get(self.viewGO, self)
end

function V1a9_KaKaNiaEnterView:onOpen()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onActStatusChange, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.UpdateActivity, self._showLeftTime, self)

	local goreddot = gohelper.findChild(self._btnEnter.gameObject, "#go_reddot")
	local redDotIcon = RedDotController.instance:addRedDot(goreddot, RedDotEnum.DotNode.V1a6RoleActivityTask, self.actId)

	redDotIcon:setRedDotTranScale(RedDotEnum.Style.Normal, 1.4, 1.4)
	self:_freshLockStatus()
	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
	self.animComp:playOpenAnim()
end

function V1a9_KaKaNiaEnterView:onClose()
	V1a9_KaKaNiaEnterView.super.onClose(self)
end

function V1a9_KaKaNiaEnterView:onDestroyView()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	self.animComp:destroy()
end

function V1a9_KaKaNiaEnterView:_freshLockStatus()
	local status = ActivityHelper.getActivityStatus(self.actId)

	gohelper.setActive(self._btnEnter, status ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(self._btnLocked, status == ActivityEnum.ActivityStatus.NotUnlock)
end

function V1a9_KaKaNiaEnterView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function V1a9_KaKaNiaEnterView:_onActStatusChange()
	self:_freshLockStatus()
end

return V1a9_KaKaNiaEnterView
