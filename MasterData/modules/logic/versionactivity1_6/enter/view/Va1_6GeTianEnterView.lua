-- chunkname: @modules/logic/versionactivity1_6/enter/view/Va1_6GeTianEnterView.lua

module("modules.logic.versionactivity1_6.enter.view.Va1_6GeTianEnterView", package.seeall)

local Va1_6GeTianEnterView = class("Va1_6GeTianEnterView", VersionActivityEnterBaseSubView)

function Va1_6GeTianEnterView:onInitView()
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

function Va1_6GeTianEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
end

function Va1_6GeTianEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
end

function Va1_6GeTianEnterView:_btnEnterOnClick()
	ActGeTianController.instance:enterActivity()
end

function Va1_6GeTianEnterView:_btnLockedOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status == ActivityEnum.ActivityStatus.NotUnlock and toastId then
		GameFacade.showToastWithTableParam(toastId, paramList)
	end
end

function Va1_6GeTianEnterView:_editableInitView()
	self.actId = VersionActivity1_6Enum.ActivityId.Role2
	self.config = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.config.actDesc
	self._txtLocked.text = OpenHelper.getActivityUnlockTxt(self.config.openId)

	self:initRewards()
end

function Va1_6GeTianEnterView:onOpen()
	Va1_6GeTianEnterView.super.onOpen(self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onActStatusChange, self)

	local goreddot = gohelper.findChild(self._btnEnter.gameObject, "#go_reddot")
	local redDotIcon = RedDotController.instance:addRedDot(goreddot, RedDotEnum.DotNode.V1a6RoleActivityTask, self.actId)

	redDotIcon:setRedDotTranScale(RedDotEnum.Style.Normal, 1.4, 1.4)
	self:_freshUnlockStatus()
	self:_showLeftTime()
end

function Va1_6GeTianEnterView:onClose()
	Va1_6GeTianEnterView.super.onClose(self)
end

function Va1_6GeTianEnterView:onDestroyView()
	return
end

function Va1_6GeTianEnterView:_freshUnlockStatus()
	local status = ActivityHelper.getActivityStatus(self.actId)

	gohelper.setActive(self._btnEnter, status ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(self._btnLocked, status == ActivityEnum.ActivityStatus.NotUnlock)
end

function Va1_6GeTianEnterView:initRewards()
	local rewards = string.split(self.config.activityBonus, "|")

	for _, reward in ipairs(rewards) do
		local itemCo = string.splitToNumber(reward, "#")
		local item = IconMgr.instance:getCommonItemIcon(self._gorewards)

		item:setMOValue(itemCo[1], itemCo[2], 1)
		item:isShowCount(false)
	end
end

function Va1_6GeTianEnterView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function Va1_6GeTianEnterView:_onActStatusChange()
	self:_freshUnlockStatus()
end

function Va1_6GeTianEnterView:everySecondCall()
	self:_showLeftTime()
end

return Va1_6GeTianEnterView
