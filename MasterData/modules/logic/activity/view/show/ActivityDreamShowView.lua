-- chunkname: @modules/logic/activity/view/show/ActivityDreamShowView.lua

module("modules.logic.activity.view.show.ActivityDreamShowView", package.seeall)

local ActivityDreamShowView = class("ActivityDreamShowView", BaseView)

function ActivityDreamShowView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_icon")
	self._txttime = gohelper.findChildText(self.viewGO, "title/time/#txt_time")
	self._txtdesc = gohelper.findChildText(self.viewGO, "title/#txt_desc")
	self._txttask = gohelper.findChildText(self.viewGO, "reward/rewardItem/#txt_task")
	self._gorewardTask = gohelper.findChild(self.viewGO, "reward/rewardItem/rewarditem")
	self._simagerewardicon = gohelper.findChildSingleImage(self.viewGO, "reward/rewardItem/rewarditem/#simage_rewardicon")
	self._gocanget = gohelper.findChild(self.viewGO, "reward/rewardItem/rewarditem/#go_canget")
	self._btnrewardicon = gohelper.findChildButtonWithAudio(self.viewGO, "reward/rewardItem/rewarditem/#btn_rewardIcon")
	self._gofinished = gohelper.findChild(self.viewGO, "reward/rewardItem/rewarditem/#go_finished")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "reward/rewardPreview/#scroll_reward")
	self._gorewardContent = gohelper.findChild(self.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent")
	self._gorewarditem = gohelper.findChild(self.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent/#go_rewarditem")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityDreamShowView:addEvents()
	self._btnrewardicon:AddClickListener(self._btncangetOnClick, self)
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self.refreshTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshTask, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onViewOpenedFinish, self)
end

function ActivityDreamShowView:removeEvents()
	self._btnrewardicon:RemoveClickListener()
	self._btnjump:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onViewOpenedFinish, self)
end

ActivityDreamShowView.ShowCount = 1
ActivityDreamShowView.taskConfigId = 160002
ActivityDreamShowView.unlimitDay = 42

function ActivityDreamShowView:_btncangetOnClick()
	local canget = self._taskMo.hasFinished

	if canget then
		TaskRpc.instance:sendFinishTaskRequest(self._taskMo.id)
	else
		MaterialTipController.instance:showMaterialInfo(tonumber(self._rewardCo[1]), tonumber(self._rewardCo[2]))
	end
end

function ActivityDreamShowView:_btnjumpOnClick()
	local jumpId = self._config.jumpId

	if jumpId ~= 0 then
		local jumpConfig = JumpConfig.instance:getJumpConfig(jumpId)

		if JumpController.instance:isJumpOpen(jumpId) and JumpController.instance:canJumpNew(jumpConfig.param) then
			GameFacade.jump(jumpId, nil, self)
		else
			GameFacade.showToast(ToastEnum.DreamShow)
		end
	end
end

function ActivityDreamShowView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getActivityBg("full/img_dream_bg"))
	self._simageicon:LoadImage(ResUrl.getActivityBg("show/img_dream_lihui"))

	self._rewardItems = self:getUserDataTb_()

	gohelper.setActive(self._gorewarditem, false)
	gohelper.setActive(self._gorewardTask, false)
end

function ActivityDreamShowView:onUpdateParam()
	return
end

function ActivityDreamShowView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = self.viewParam.actId

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityShow
	})
	self:refreshUI()
end

function ActivityDreamShowView:refreshUI()
	self._config = ActivityConfig.instance:getActivityShowTaskList(self._actId, 1)
	self._txtdesc.text = self._config.actDesc

	local day, hour = ActivityModel.instance:getRemainTime(self._actId)

	self._txttime.text = day > ActivityDreamShowView.unlimitDay and luaLang("activityshow_unlimittime") or string.format(luaLang("activityshow_remaintime"), day, hour)

	local rewards = string.split(self._config.showBonus, "|")

	for i = 1, #rewards do
		local rewardItem = self._rewardItems[i]

		if not rewardItem then
			rewardItem = self:getUserDataTb_()
			rewardItem.go = gohelper.clone(self._gorewarditem, self._gorewardContent, "rewarditem" .. i)
			rewardItem.item = IconMgr.instance:getCommonPropItemIcon(rewardItem.go)

			table.insert(self._rewardItems, rewardItem)
		end

		gohelper.setActive(self._rewardItems[i].go, true)

		local itemCo = string.splitToNumber(rewards[i], "#")

		self._rewardItems[i].item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		self._rewardItems[i].item:isShowCount(itemCo[4] == ActivityDreamShowView.ShowCount)
		self._rewardItems[i].item:setCountFontSize(56)
		self._rewardItems[i].item:setHideLvAndBreakFlag(true)
		self._rewardItems[i].item:hideEquipLvAndBreak(true)
	end

	for i = #rewards + 1, #self._rewardItems do
		gohelper.setActive(self._rewardItems[i].go, false)
	end

	self:refreshTask()
end

function ActivityDreamShowView:refreshTask()
	gohelper.setActive(self._gorewardTask, true)

	local taskConfig = TaskConfig.instance:getTaskActivityShowConfig(ActivityDreamShowView.taskConfigId)

	self._txttask.text = taskConfig.desc
	self._rewardCo = string.splitToNumber(taskConfig.bonus, "#")

	local config, icon = ItemModel.instance:getItemConfigAndIcon(self._rewardCo[1], self._rewardCo[2], true)

	self._simagerewardicon:LoadImage(icon)

	local taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityShow, taskConfig.activityId)

	self._taskMo = taskMoList[1]

	if self._taskMo.finishCount >= self._taskMo.config.maxFinishCount then
		gohelper.setActive(self._gofinished, true)
		gohelper.setActive(self._gocanget, false)
		SLFramework.UGUI.GuiHelper.SetColor(self._simagerewardicon.gameObject:GetComponent(gohelper.Type_Image), "#666666")
	elseif self._taskMo.hasFinished then
		gohelper.setActive(self._gofinished, false)
		gohelper.setActive(self._gocanget, true)
		SLFramework.UGUI.GuiHelper.SetColor(self._simagerewardicon.gameObject:GetComponent(gohelper.Type_Image), "#FFFFFF")
	else
		gohelper.setActive(self._gofinished, false)
		gohelper.setActive(self._gocanget, false)
		SLFramework.UGUI.GuiHelper.SetColor(self._simagerewardicon.gameObject:GetComponent(gohelper.Type_Image), "#FFFFFF")
	end
end

function ActivityDreamShowView:onViewOpenedFinish(viewName)
	if viewName == ViewName.DungeonView then
		ViewMgr.instance:closeView(ViewName.ActivityBeginnerView, true)
	end
end

function ActivityDreamShowView:onClose()
	TaskDispatcher.cancelTask(self._closeAllView, self)
end

function ActivityDreamShowView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageicon:UnLoadImage()
end

return ActivityDreamShowView
