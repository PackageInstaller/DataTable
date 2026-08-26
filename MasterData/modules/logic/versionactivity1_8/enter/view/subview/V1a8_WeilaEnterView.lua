-- chunkname: @modules/logic/versionactivity1_8/enter/view/subview/V1a8_WeilaEnterView.lua

module("modules.logic.versionactivity1_8.enter.view.subview.V1a8_WeilaEnterView", package.seeall)

local V1a8_WeilaEnterView = class("V1a8_WeilaEnterView", BaseView)

function V1a8_WeilaEnterView:onInitView()
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

function V1a8_WeilaEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
end

function V1a8_WeilaEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
end

function V1a8_WeilaEnterView:_btnEnterOnClick()
	local condition = self.config.confirmCondition

	if string.nilorempty(condition) then
		ActWeilaController.instance:enterActivity()
	else
		local strs = string.split(condition, "=")
		local openId = tonumber(strs[2])
		local userid = PlayerModel.instance:getPlayinfo().userId
		local key = PlayerPrefsKey.EnterRoleActivity .. "#" .. tostring(VersionActivity1_8Enum.ActivityId.Weila) .. "#" .. tostring(userid)
		local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

		if OpenModel.instance:isFunctionUnlock(openId) or hasTiped then
			ActWeilaController.instance:enterActivity()
		else
			local openCO = OpenConfig.instance:getOpenCo(openId)
			local dungeonDisplay = DungeonConfig.instance:getEpisodeDisplay(openCO.episodeId)
			local dungeonName = DungeonConfig.instance:getEpisodeCO(openCO.episodeId).name
			local name = dungeonDisplay .. dungeonName

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(key, 1)
				ActWeilaController.instance:enterActivity()
			end, nil, nil, nil, nil, nil, name)
		end
	end
end

function V1a8_WeilaEnterView:_btnLockedOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status == ActivityEnum.ActivityStatus.NotUnlock and toastId then
		GameFacade.showToastWithTableParam(toastId, paramList)
	end
end

function V1a8_WeilaEnterView:_editableInitView()
	self.actId = VersionActivity1_8Enum.ActivityId.Weila
	self.config = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.config.actDesc
	self._txtLocked.text = OpenHelper.getActivityUnlockTxt(self.config.openId)
	self.animComp = VersionActivitySubAnimatorComp.get(self.viewGO, self)
end

function V1a8_WeilaEnterView:onOpen()
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

function V1a8_WeilaEnterView:onClose()
	V1a8_WeilaEnterView.super.onClose(self)
end

function V1a8_WeilaEnterView:onDestroyView()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	self.animComp:destroy()
end

function V1a8_WeilaEnterView:_freshLockStatus()
	local status = ActivityHelper.getActivityStatus(self.actId)

	gohelper.setActive(self._btnEnter, status ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(self._btnLocked, status == ActivityEnum.ActivityStatus.NotUnlock)
end

function V1a8_WeilaEnterView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function V1a8_WeilaEnterView:_onActStatusChange()
	self:_freshLockStatus()
end

return V1a8_WeilaEnterView
