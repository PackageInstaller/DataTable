-- chunkname: @modules/logic/versionactivity1_7/enter/view/subview/V1a7_IsoldeEnterView.lua

module("modules.logic.versionactivity1_7.enter.view.subview.V1a7_IsoldeEnterView", package.seeall)

local V1a7_IsoldeEnterView = class("V1a7_IsoldeEnterView", BaseView)

function V1a7_IsoldeEnterView:onInitView()
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

function V1a7_IsoldeEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
end

function V1a7_IsoldeEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
end

function V1a7_IsoldeEnterView:_btnEnterOnClick()
	local userid = PlayerModel.instance:getPlayinfo().userId
	local key = PlayerPrefsKey.EnterRoleActivity .. "#" .. tostring(VersionActivity1_7Enum.ActivityId.Isolde) .. "#" .. tostring(userid)
	local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_70103) or hasTiped then
		ActIsoldeController.instance:enterActivity()

		return
	end

	local openCO = OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.Act_70103)
	local dungeonName = DungeonConfig.instance:getEpisodeDisplay(openCO.episodeId)

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130OpenTips, MsgBoxEnum.BoxType.Yes_No, function()
		PlayerPrefsHelper.setNumber(key, 1)
		ActIsoldeController.instance:enterActivity()
	end, nil, nil, nil, nil, nil, dungeonName)
end

function V1a7_IsoldeEnterView:_btnLockedOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status == ActivityEnum.ActivityStatus.NotUnlock and toastId then
		GameFacade.showToastWithTableParam(toastId, paramList)
	end
end

function V1a7_IsoldeEnterView:_editableInitView()
	self.actId = VersionActivity1_7Enum.ActivityId.Isolde
	self.config = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.config.actDesc
	self._txtLocked.text = OpenHelper.getActivityUnlockTxt(self.config.openId)

	self:initRewards()

	self.animComp = VersionActivitySubAnimatorComp.get(self.viewGO, self)
end

function V1a7_IsoldeEnterView:onOpen()
	V1a7_IsoldeEnterView.super.onOpen(self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onActStatusChange, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.UpdateActivity, self._showLeftTime, self)

	local goreddot = gohelper.findChild(self._btnEnter.gameObject, "#go_reddot")
	local redDotIcon = RedDotController.instance:addRedDot(goreddot, RedDotEnum.DotNode.PermanentRoleActivityTask, self.actId)

	redDotIcon:setRedDotTranScale(RedDotEnum.Style.Normal, 1.4, 1.4)
	self:_freshLockStatus()
	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
	self.animComp:playOpenAnim()
end

function V1a7_IsoldeEnterView:onClose()
	V1a7_IsoldeEnterView.super.onClose(self)
end

function V1a7_IsoldeEnterView:onDestroyView()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	self.animComp:destroy()
end

function V1a7_IsoldeEnterView:initRewards()
	local rewards = string.split(self.config.activityBonus, "|")

	for _, reward in ipairs(rewards) do
		local itemCo = string.splitToNumber(reward, "#")
		local item = IconMgr.instance:getCommonItemIcon(self._gorewards)

		item:setMOValue(itemCo[1], itemCo[2], 1)
		item:isShowCount(false)
	end
end

function V1a7_IsoldeEnterView:_freshLockStatus()
	local status = ActivityHelper.getActivityStatus(self.actId)

	gohelper.setActive(self._btnEnter, status ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(self._btnLocked, status == ActivityEnum.ActivityStatus.NotUnlock)
end

function V1a7_IsoldeEnterView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function V1a7_IsoldeEnterView:_onActStatusChange()
	self:_freshLockStatus()
end

return V1a7_IsoldeEnterView
