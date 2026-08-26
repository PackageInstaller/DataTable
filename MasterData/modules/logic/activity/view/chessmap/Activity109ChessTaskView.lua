-- chunkname: @modules/logic/activity/view/chessmap/Activity109ChessTaskView.lua

module("modules.logic.activity.view.chessmap.Activity109ChessTaskView", package.seeall)

local Activity109ChessTaskView = class("Activity109ChessTaskView", BaseViewExtended)

function Activity109ChessTaskView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagedog = gohelper.findChildSingleImage(self.viewGO, "#simage_dog")
	self._txtremaintime = gohelper.findChildTextMesh(self.viewGO, "remaintime/#txt_remaintime")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "#scroll_task")
	self._gotaskitemcontent = gohelper.findChild(self.viewGO, "#scroll_task/viewport/#go_taskitemcontent")
	self._gotaskitem = gohelper.findChild(self.viewGO, "#go_task_item")
	self._gogetall = gohelper.findChild(self.viewGO, "#scroll_task/viewport/#go_taskitemcontent/#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#scroll_task/viewport/#go_taskitemcontent/#go_getall/#simage_getallbg")
	self._btngetallreward = gohelper.findChildButtonWithAudio(self.viewGO, "#scroll_task/viewport/#go_taskitemcontent/#go_getall/#btn_getallreward")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity109ChessTaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._onFinishTask, self)
	self._btngetallreward:AddClickListener(self._btngetallrewardOnClick, self)
end

function Activity109ChessTaskView:removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._onFinishTask, self)
	self._btngetallreward:RemoveClickListener()
end

function Activity109ChessTaskView:_btngetallrewardOnClick()
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity109)
end

function Activity109ChessTaskView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getVersionactivitychessIcon("full/bg"))
	self._simagedog:LoadImage(ResUrl.getVersionactivitychessIcon("img_gou"))
	self._simagegetallbg:LoadImage(ResUrl.getVersionactivitychessIcon("img_quanbulingqu"))
end

function Activity109ChessTaskView:onOpen()
	self._activity_data = ActivityModel.instance:getActivityInfo()[Activity109Model.instance:getCurActivityID()]
	self._task_list = Activity109Config.instance:getTaskList()

	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 60)
	self:_showTaskList()
end

function Activity109ChessTaskView:_showLeftTime()
	self._txtremaintime.text = string.format(luaLang("activity_warmup_remain_time"), self._activity_data:getRemainTimeStr())
end

function Activity109ChessTaskView:_onFinishTask()
	self:_showTaskList()
end

function Activity109ChessTaskView:_showTaskList()
	table.sort(self._task_list, Activity109ChessTaskView.sortTaskList)

	self._obj_list = self._obj_list or self:getUserDataTb_()

	TaskDispatcher.runDelay(self._showTaskItem, self, 0.2)
end

function Activity109ChessTaskView:_showTaskItem()
	local tempTaskList = {}
	local couldGetRewardCount = 0

	for k, v in pairs(self._task_list) do
		table.insert(tempTaskList, v)

		local task_data = Activity109Model.instance:getTaskData(v.id)

		if task_data.hasFinished then
			couldGetRewardCount = couldGetRewardCount + 1
		end
	end

	table.insert(tempTaskList, 1, {
		isGetAllTaskUI = true,
		isNeedShowGetAllUI = couldGetRewardCount >= 2
	})
	self:com_createObjList(self._onItemShow, tempTaskList, self._gotaskitemcontent, self._gotaskitem, nil, 0.06)
end

function Activity109ChessTaskView.sortTaskList(item1, item2)
	local task1 = Activity109Model.instance:getTaskData(item1.id)
	local task2 = Activity109Model.instance:getTaskData(item2.id)

	if not task1 or not task2 then
		return false
	end

	local hasGetBonus1 = task1.finishCount > 0
	local hasGetBonus2 = task2.finishCount > 0

	if hasGetBonus1 and not hasGetBonus2 then
		return false
	elseif not hasGetBonus1 and hasGetBonus2 then
		return true
	else
		local can_get_reward1 = task1.hasFinished
		local can_get_reward2 = task2.hasFinished

		if can_get_reward1 and not can_get_reward2 then
			return true
		elseif not can_get_reward1 and can_get_reward2 then
			return false
		else
			if item1.sortId ~= item2.sortId then
				return item1.sortId < item2.sortId
			end

			return item1.id < item2.id
		end
	end
end

function Activity109ChessTaskView:_onItemShow(obj, config, index)
	if config.isGetAllTaskUI then
		gohelper.setActive(obj, config.isNeedShowGetAllUI)

		return
	end

	local task_data = Activity109Model.instance:getTaskData(config.id)

	if not task_data then
		gohelper.setActive(obj, false)

		return
	end

	index = index - 1

	obj:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Idle, 0, 0)

	obj.name = index

	local txt_progress = gohelper.findChildTextMesh(obj, "#txt_progress")
	local txt_maxprogress = gohelper.findChildTextMesh(obj, "#txt_maxprogress")
	local txt_taskdes = gohelper.findChildTextMesh(obj, "#txt_taskdes")
	local btn_notfinishbg = gohelper.findChildClickWithAudio(obj, "#go_notget/#btn_notfinishbg")
	local btn_finishbg = gohelper.findChildClickWithAudio(obj, "#go_notget/#btn_finishbg")
	local go_notget = gohelper.findChild(obj, "#go_notget")
	local go_get = gohelper.findChild(obj, "#go_get")
	local go_blackmask = gohelper.findChild(obj, "#go_blackmask")
	local scroll_rewards = gohelper.findChild(obj, "scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	local go_rewards = gohelper.findChild(obj, "scroll_reward/Viewport/#go_rewards")
	local simage_bg = gohelper.findChildSingleImage(obj, "#simage_bg")
	local simage_blackmask = gohelper.findChildSingleImage(obj, "#go_blackmask")

	txt_progress.text = task_data.progress
	txt_maxprogress.text = config.maxProgress
	txt_taskdes.text = config.desc

	self.addClickCb(self, btn_notfinishbg, self._onClickTaskJump, self, index)
	self.addClickCb(self, btn_finishbg, self._onClickTaskReward, self, index)
	gohelper.setActive(go_notget, task_data.finishCount == 0)
	gohelper.setActive(go_get, task_data.finishCount > 0)
	gohelper.setActive(go_blackmask, true)

	gohelper.findChildImage(obj, "#go_blackmask").raycastTarget = false

	ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(obj, "#go_blackmask"), task_data.finishCount > 0 and 1 or 0)
	gohelper.setActive(btn_notfinishbg.gameObject, task_data.progress < config.maxProgress)
	gohelper.setActive(btn_finishbg.gameObject, task_data.hasFinished)

	local item_list = ItemModel.instance:getItemDataListByConfigStr(config.bonus)

	IconMgr.instance:getCommonPropItemIconList(self, self._onRewardItemShow, item_list, go_rewards)

	local rewards = string.split(config.bonus, "|")

	go_rewards:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #rewards > 1
	scroll_rewards.parentGameObject = self._scrolltask.gameObject

	simage_bg:LoadImage(ResUrl.getVersionactivitychessIcon("img_changgui"))
	simage_blackmask:LoadImage(ResUrl.getVersionactivitychessIcon("img_mengban"))

	self._image_list = self._image_list or {}

	if not self._image_list[index] then
		self._image_list[index] = self:getUserDataTb_()

		table.insert(self._image_list[index], simage_bg)
		table.insert(self._image_list[index], simage_blackmask)
		obj:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Open, 0, 0)
	end

	table.insert(self._obj_list, obj)
end

function Activity109ChessTaskView:_releaseTaskItemImage()
	if self._image_list then
		for i, v in ipairs(self._image_list) do
			for index, image in ipairs(v) do
				image:UnLoadImage()
			end
		end
	end

	self._image_list = {}
end

function Activity109ChessTaskView:_onRewardItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
	cell_component:setScale(0.6)
end

function Activity109ChessTaskView:_onClickTaskJump(index)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local task_cfg = self._task_list[index]

	Activity109ChessController.instance:dispatchEvent(ActivityChessEvent.TaskJump, task_cfg)
	self:closeThis()
end

function Activity109ChessTaskView:_onClickTaskReward(index)
	UIBlockMgr.instance:startBlock("Activity109ChessTaskView")
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)

	self._reward_task_id = self._task_list[index].id

	local obj = self._obj_list[index]

	ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(obj, "#go_blackmask"), 1)
	obj:GetComponent(typeof(UnityEngine.Animator)):Play("finsh", 0, 0)
	TaskDispatcher.runDelay(self._getTaskReward, self, 0.6)
end

function Activity109ChessTaskView:_getTaskReward()
	UIBlockMgr.instance:endBlock("Activity109ChessTaskView")
	TaskRpc.instance:sendFinishTaskRequest(self._reward_task_id)
end

function Activity109ChessTaskView:onClose()
	UIBlockMgr.instance:endBlock("Activity109ChessTaskView")
	TaskDispatcher.cancelTask(self._getTaskReward, self)
	TaskDispatcher.cancelTask(self._showTaskItem, self)
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function Activity109ChessTaskView:onDestroyView()
	self:_releaseTaskItemImage()
	self._simagebg:UnLoadImage()
	self._simagedog:UnLoadImage()
	self._simagegetallbg:UnLoadImage()
end

return Activity109ChessTaskView
