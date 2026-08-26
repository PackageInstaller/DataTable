-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/Anniversary3MailView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.Anniversary3MailView", package.seeall)

local Anniversary3MailView = class("Anniversary3MailView", BaseView)

function Anniversary3MailView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagePaper3 = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_Paper3")
	self._simagePaper2 = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_Paper2")
	self._simagePaper1 = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_Paper1")
	self._scrollDescr = gohelper.findChildScrollRect(self.viewGO, "Panel/#scroll_Descr")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "Panel/#scroll_Reward")
	self._gorewarditemcontent = gohelper.findChild(self.viewGO, "Panel/#scroll_Reward/Viewport/Content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "Panel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	self._btnclose = gohelper.findChildButton(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Anniversary3MailView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function Anniversary3MailView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Anniversary3MailView:_editableInitView()
	self._rewardList = {}

	self:_addSelfEvents()
end

function Anniversary3MailView:_addSelfEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function Anniversary3MailView:_removeSelfEvents()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function Anniversary3MailView:_onCloseView(viewName)
	if viewName == ViewName.CommonPropView then
		self:_refresh()
	end
end

function Anniversary3MailView:onRefreshActivity()
	local status = ActivityHelper.getActivityStatus(self._actId)

	if status == ActivityEnum.ActivityStatus.NotOnLine or status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function Anniversary3MailView:onUpdateParam()
	return
end

function Anniversary3MailView:_refresh()
	local received = ActivityType101Model.instance:isType101RewardGet(self._actId, 1)

	if received then
		for _, node in ipairs(self._rewardList) do
			gohelper.setActive(node.goreceive, true)
			gohelper.setActive(node.gocanget, false)
		end
	end
end

function Anniversary3MailView:onOpen()
	self._actId = VersionActivity3_7Enum.ActivityId.Anniversary3Mail

	Activity101Rpc.instance:sendGet101InfosRequest(self._actId, self._tryGetReward, self)

	self._config = ActivityConfig.instance:getNorSignActivityCo(self._actId, 1)

	if not self._config then
		logError("没有活动" .. self._actId .. "的配置")

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
	self:_initReward()
	self:_tryGetReward()
end

function Anniversary3MailView:_tryGetReward()
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1)

	if couldGet then
		TaskDispatcher.runDelay(self._getReward, self, 0.8)
	end
end

function Anniversary3MailView:_getReward()
	TaskDispatcher.cancelTask(self._getReward, self)
	Activity101Rpc.instance:sendGet101BonusRequest(self._actId, 1)
end

function Anniversary3MailView:_initReward()
	local rewardConfig = GameUtil.splitString2(self._config.bonus, true)

	for index, rewardCo in ipairs(rewardConfig) do
		local item = self._rewardList[index]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.clone(self._gorewarditem, self._gorewarditemcontent, "reward" .. index)
			item.goreceive = gohelper.findChild(item.go, "go_receive")
			item.goitem = gohelper.findChild(item.go, "go_icon")
			item.gocanget = gohelper.findChild(item.go, "go_canget")
			item.goitemcomp = IconMgr.instance:getCommonPropItemIcon(item.goitem)

			if rewardCo and #rewardCo > 0 then
				item.goitemcomp:setMOValue(rewardCo[1], rewardCo[2], rewardCo[3], nil, true)
			end

			gohelper.setActive(item.go, true)
			table.insert(self._rewardList, item)
		end
	end
end

function Anniversary3MailView:onClose()
	TaskDispatcher.cancelTask(self._getReward, self)
end

function Anniversary3MailView:onDestroyView()
	self:_removeSelfEvents()
end

return Anniversary3MailView
