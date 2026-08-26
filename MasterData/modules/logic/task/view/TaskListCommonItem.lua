-- chunkname: @modules/logic/task/view/TaskListCommonItem.lua

module("modules.logic.task.view.TaskListCommonItem", package.seeall)

local TaskListCommonItem = class("TaskListCommonItem", LuaCompBase)

function TaskListCommonItem:init(go, type, index, co, open)
	self.go = go
	self.go.name = "item" .. tostring(index)
	self._index = index
	self._mo = co
	self._taskType = type
	self._open = open
	self._itemAni = go:GetComponent(typeof(UnityEngine.Animator))
	self._gocommon = gohelper.findChild(self.go, "#go_common")
	self._imgBg = gohelper.findChildImage(self._gocommon, "#simage_bg")
	self._gonotget = gohelper.findChild(self._gocommon, "#go_notget")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self._gocommon, "#go_notget/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButton(self._gocommon, "#go_notget/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self._gocommon, "#go_notget/#go_allfinish")
	self._godoing = gohelper.findChild(self._gocommon, "#go_notget/#go_doing")
	self._txttaskdes = gohelper.findChildText(self._gocommon, "right/#txt_taskdes")
	self._imgcompleteproc = gohelper.findChildImage(self._gocommon, "right/completeproc/#image_full")
	self._txttotal = gohelper.findChildText(self._gocommon, "right/#txt_total")
	self._txtcomplete = gohelper.findChildText(self._gocommon, "right/#txt_total/#txt_complete")
	self._txtcommonnum = gohelper.findChildText(self._gocommon, "#txt_num")
	self._simagegetmask = gohelper.findChildSingleImage(self._gocommon, "#simage_getmask")
	self._goget = gohelper.findChild(self._gocommon, "#go_get")
	self._gocollectionCanvasGroup = gohelper.findChild(self._gocommon, "#go_get/collecticon"):GetComponent(typeof(UnityEngine.CanvasGroup))
	self._goreddot = gohelper.findChild(self._gocommon, "#go_reddot")
	self._gocommonclick = gohelper.findChild(self._gocommon, "click")
	self._simagecommonclickmask = gohelper.findChildSingleImage(self._gocommon, "click/getmask")
	self._goreward = gohelper.findChild(self.go, "#go_reward")
	self._simagerewardbg = gohelper.findChildSingleImage(self._goreward, "#simage_bg")
	self._txtrewardnum = gohelper.findChildText(self._goreward, "#txt_num")
	self._btngetall = gohelper.findChildButton(self._goreward, "#go_getall/#btn_getall")
	self._gorewardclick = gohelper.findChild(self._goreward, "click")
	self._simagerewardclickmask = gohelper.findChildSingleImage(self._goreward, "click/getmask")

	self._simagegetmask:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))
	self._simagecommonclickmask:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))
	self._simagerewardclickmask:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))
	self._simagerewardbg:LoadImage(ResUrl.getTaskBg("bg_quanbulqd"))
	gohelper.setActive(self._gocommonclick, false)
	gohelper.setActive(self._gorewardclick, false)
	gohelper.setActive(self._goreddot, false)

	self._rewardItems = {}

	self:addEvents()

	if not self._mo then
		self:_refreshRewardItem()
	else
		self:_refreshCommonItem()
	end
end

function TaskListCommonItem:hasFinished()
	if self._mo then
		return self._mo.finishCount >= self._mo.config.maxFinishCount
	end

	return false
end

function TaskListCommonItem:isAllGetType()
	return not self._mo
end

function TaskListCommonItem:reset(type, index, co)
	self._index = index
	self._mo = co
	self._taskType = type
	self._open = false

	gohelper.setActive(self._gocommonclick, false)
	gohelper.setActive(self._gorewardclick, false)

	self.go.name = "item" .. tostring(index)
	self._rewardItems = {}

	if not self._mo then
		self:_refreshRewardItem()
	else
		self:_refreshCommonItem()
	end
end

function TaskListCommonItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btnGetAllOnClick, self)
	ActivityController.instance:registerCallback(TaskEvent.GetTaskReward, self._onGetReward, self)
	ActivityController.instance:registerCallback(TaskEvent.GetAllTaskReward, self._onGetAllReward, self)
end

function TaskListCommonItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
	ActivityController.instance:unregisterCallback(TaskEvent.GetTaskReward, self._onGetReward, self)
	ActivityController.instance:unregisterCallback(TaskEvent.GetAllTaskReward, self._onGetAllReward, self)
end

function TaskListCommonItem:_onGetAllReward(taskType)
	if self._taskType ~= taskType then
		return
	end

	if self._mo and self._mo.finishCount < self._mo.config.maxFinishCount and self._mo.hasFinished then
		gohelper.setActive(self._gocommonclick, true)

		self._itemAni.enabled = true

		self._itemAni:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(self._onPlayRewardFinished, self, 0.46)
	end
end

function TaskListCommonItem:_onGetReward(taskType)
	if self._taskType ~= taskType then
		return
	end

	if not self._mo then
		local rewardTasks = TaskModel.instance:getAllRewardUnreceivedTasks(self._taskType)

		if #rewardTasks < 3 then
			self._itemAni.enabled = true

			self._itemAni:Play(UIAnimationName.Close)
			TaskDispatcher.runDelay(self._onPlayRewardFinished, self, 0.76)
		end
	end
end

function TaskListCommonItem:_btnGetAllOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)
	gohelper.setActive(self._gorewardclick, true)

	self._itemAni.enabled = true

	self._itemAni:Play(UIAnimationName.Close)
	UIBlockMgr.instance:startBlock("taskani")
	ActivityController.instance:dispatchEvent(TaskEvent.GetAllTaskReward, self._taskType)
	TaskDispatcher.runDelay(self._onPlayRewardClickFinished, self, 0.76)
end

function TaskListCommonItem:_onPlayRewardFinished()
	gohelper.setAsLastSibling(self.go)
end

function TaskListCommonItem:_onPlayRewardClickFinished()
	local num = 0
	local list = TaskModel.instance:getAllUnlockTasks(self._taskType)

	for _, v in pairs(list) do
		if v.finishCount < v.config.maxFinishCount and v.hasFinished then
			num = num + v.config.activity
		end
	end

	local param = {}

	param.num = num
	param.taskType = self._taskType

	TaskController.instance:dispatchEvent(TaskEvent.RefreshActState, param)
	self:_getFinished()
	TaskDispatcher.runDelay(self._onPlayGetAllRewardFinished, self, 0.6)
end

function TaskListCommonItem:_onPlayGetAllRewardFinished()
	UIBlockMgr.instance:endBlock("taskani")
	TaskRpc.instance:sendFinishAllTaskRequest(self._taskType)
end

function TaskListCommonItem:_btnnotfinishbgOnClick()
	if self._mo.config.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)
		GameFacade.jump(self._mo.config.jumpId)
	end
end

function TaskListCommonItem:_btnfinishbgOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)
	TaskModel.instance:clearNewTaskIds()
	gohelper.setActive(self._gocommonclick, true)

	self._itemAni.enabled = true

	self._itemAni:Play(UIAnimationName.Close)
	UIBlockMgr.instance:startBlock("taskani")
	ActivityController.instance:dispatchEvent(TaskEvent.GetTaskReward, self._taskType)
	TaskDispatcher.runDelay(self._onPlayCommonClickFinished, self, 0.46)
end

function TaskListCommonItem:_onPlayCommonClickFinished()
	local param = {}

	param.num = self._taskType == TaskEnum.TaskType.Daily and TaskConfig.instance:gettaskdailyCO(self._mo.id).activity or TaskConfig.instance:gettaskweeklyCO(self._mo.id).activity
	param.taskType = self._taskType

	TaskController.instance:dispatchEvent(TaskEvent.RefreshActState, param)
	TaskDispatcher.runDelay(self._getFinished, self, 0.3)
	TaskDispatcher.runDelay(self._onPlayActAniFinished, self, 0.6)
end

function TaskListCommonItem:_getFinished()
	gohelper.setAsLastSibling(self.go)
end

function TaskListCommonItem:_onPlayActAniFinished()
	UIBlockMgr.instance:endBlock("taskani")
	TaskRpc.instance:sendFinishTaskRequest(self._mo.id)
end

function TaskListCommonItem:_refreshCommonItem()
	gohelper.setActive(self._gocommon, true)
	gohelper.setActive(self._goreward, false)

	self._txtcommonnum.text = luaLang("multiple") .. self._mo.config.activity
	self._txttaskdes.text = string.format(self._mo.config.desc, self._mo.config.maxProgress)
	self._txtcomplete.text = GameUtil.numberDisplay(self._mo.progress)
	self._txttotal.text = GameUtil.numberDisplay(self._mo.config.maxProgress)
	self._imgcompleteproc.fillAmount = self._mo.progress / self._mo.config.maxProgress

	if self._mo.finishCount >= self._mo.config.maxFinishCount then
		gohelper.setActive(self._btnfinishbg.gameObject, false)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._godoing.gameObject, false)
		gohelper.setActive(self._goget, true)
		gohelper.setActive(self._gonotget, false)
		gohelper.setActive(self._simagegetmask.gameObject, true)
		gohelper.setActive(self._goreddot, false)
		ZProj.UGUIHelper.SetColorAlpha(self._imgBg, 0.8)
	elseif self._mo.hasFinished then
		gohelper.setActive(self._btnfinishbg.gameObject, true)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._godoing.gameObject, false)
		gohelper.setActive(self._goget, false)
		gohelper.setActive(self._gonotget, true)
		gohelper.setActive(self._simagegetmask.gameObject, false)
		ZProj.UGUIHelper.SetColorAlpha(self._imgBg, 1)
	else
		gohelper.setActive(self._btnfinishbg.gameObject, false)
		gohelper.setActive(self._btnnotfinishbg.gameObject, self._mo.config.jumpId ~= 0)
		gohelper.setActive(self._godoing.gameObject, self._mo.config.jumpId == 0)
		gohelper.setActive(self._goget, false)
		gohelper.setActive(self._gonotget, true)
		gohelper.setActive(self._simagegetmask.gameObject, false)
		gohelper.setActive(self._goreddot, false)
		ZProj.UGUIHelper.SetColorAlpha(self._imgBg, 1)
	end

	if self._open then
		self._itemAni:Play(UIAnimationName.Open, 0, 0)
	else
		self._itemAni:Play(UIAnimationName.Idle)
	end

	self:showAllComplete()
end

function TaskListCommonItem:showAllComplete()
	if not self._mo then
		return
	end

	local isAllFinished = TaskModel.instance:isAllRewardGet(self._taskType)

	self._gocollectionCanvasGroup.alpha = isAllFinished and 0.6 or 1

	if self._mo.finishCount >= self._mo.config.maxFinishCount then
		gohelper.setActive(self._goallfinish, isAllFinished)
	elseif self._mo.hasFinished then
		gohelper.setActive(self._btnfinishbg.gameObject, not isAllFinished)
		gohelper.setActive(self._goallfinish, isAllFinished)
	else
		gohelper.setActive(self._goallfinish, isAllFinished)
	end

	if isAllFinished then
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._simagegetmask.gameObject, true)
	end
end

function TaskListCommonItem:_refreshRewardItem()
	gohelper.setActive(self._goreward, true)
	gohelper.setActive(self._gocommon, false)

	local list = TaskModel.instance:getAllUnlockTasks(self._taskType)
	local totalAct = 0

	for _, v in pairs(list) do
		if v.finishCount < v.config.maxFinishCount and v.hasFinished then
			totalAct = totalAct + v.config.activity
		end
	end

	self._txtrewardnum.text = totalAct

	if self._open then
		self._itemAni:Play(UIAnimationName.Open, 0, 0)
	else
		self._itemAni:Play(UIAnimationName.Idle)
	end
end

function TaskListCommonItem:showIdle()
	gohelper.setActive(self.go, true)
	self._itemAni:Play(UIAnimationName.Idle)
end

function TaskListCommonItem:destroy()
	UIBlockMgr.instance:endBlock("taskani")
	self:removeEvents()
	TaskDispatcher.cancelTask(self._onPlayCommonClickFinished, self)
	TaskDispatcher.cancelTask(self._onPlayCommonFinished, self)
	TaskDispatcher.cancelTask(self._onPlayRewardClickFinished, self)
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)
	self._simagegetmask:UnLoadImage()
	self._simagerewardbg:UnLoadImage()
	self._simagecommonclickmask:UnLoadImage()
	self._simagerewardclickmask:UnLoadImage()

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	if self._posTweenId then
		ZProj.TweenHelper.KillById(self._posTweenId)
	end

	TaskDispatcher.cancelTask(self._showSelfItem, self)
	TaskDispatcher.cancelTask(self._itemEntered, self)

	if self._rewardItems then
		for _, v in pairs(self._rewardItems) do
			gohelper.destroy(v.itemIcon.go)
			gohelper.destroy(v.parentGo)
			v.itemIcon:onDestroy()
		end

		self._rewardItems = nil
	end

	gohelper.destroy(self.go)
end

return TaskListCommonItem
