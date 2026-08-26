-- chunkname: @modules/logic/advance/view/testtask/TestTaskView.lua

module("modules.logic.advance.view.testtask.TestTaskView", package.seeall)

local TestTaskView = class("TestTaskView", BaseViewExtended)

function TestTaskView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagedog = gohelper.findChildSingleImage(self.viewGO, "#simage_dog")
	self._txtremaintime = gohelper.findChildTextMesh(self.viewGO, "remaintime/#txt_remaintime")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "#scroll_task")
	self._gotaskitemcontent = gohelper.findChild(self.viewGO, "#scroll_task/viewport/#go_taskitemcontent")
	self._gotaskitem = gohelper.findChild(self.viewGO, "#go_task_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TestTaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function TestTaskView:removeEvents()
	return
end

function TestTaskView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getVersionactivitychessIcon("full/bg"))
	self._simagedog:LoadImage(ResUrl.getVersionactivitychessIcon("img_gou"))
end

function TestTaskView:onOpen()
	self._task_list = TestTaskConfig.instance:getTaskList()
	self._show_item_list = {}

	for _, item in ipairs(self._task_list) do
		local taskData = TestTaskModel.instance:getTaskData(item.id)

		if taskData then
			self._show_item_list[#self._show_item_list + 1] = item
		end
	end

	self:_showTaskList()
end

function TestTaskView:_onFinishTask()
	self:_showTaskList()
end

function TestTaskView:_showTaskList()
	table.sort(self._show_item_list, TestTaskView.sortTaskList)

	self._obj_list = self._obj_list or self:getUserDataTb_()

	TaskDispatcher.runDelay(self._showTaskItem, self, 0.2)
end

function TestTaskView:_showTaskItem()
	self:com_createObjList(self._onItemShow, self._show_item_list, self._gotaskitemcontent, self._gotaskitem, nil, 0.06)
end

function TestTaskView.sortTaskList(item1, item2)
	local task1 = TestTaskModel.instance:getTaskData(item1.id)
	local task2 = TestTaskModel.instance:getTaskData(item2.id)

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
			return item1.id < item2.id
		end
	end
end

function TestTaskView:_onItemShow(obj, config, index)
	local task_data = TestTaskModel.instance:getTaskData(config.id)

	if not task_data then
		gohelper.setActive(obj, false)

		return
	end

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

function TestTaskView:_releaseTaskItemImage()
	if self._image_list then
		for i, v in ipairs(self._image_list) do
			for index, image in ipairs(v) do
				image:UnLoadImage()
			end
		end
	end

	self._image_list = {}
end

function TestTaskView:_onRewardItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
	cell_component:setScale(0.6)
end

function TestTaskView:_onClickTaskJump(index)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local jumpId = self._show_item_list[index].jumpId

	if jumpId ~= 0 then
		GameFacade.jump(jumpId)
	end

	self:closeThis()
end

function TestTaskView:_onClickTaskReward(index)
	UIBlockMgr.instance:startBlock("TestTaskView")
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)

	self._reward_task_id = self._show_item_list[index].id

	local obj = self._obj_list[index]

	ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(obj, "#go_blackmask"), 1)
	obj:GetComponent(typeof(UnityEngine.Animator)):Play("finsh", 0, 0)
	TaskDispatcher.runDelay(self._getTaskReward, self, 0.6)
end

function TestTaskView:_getTaskReward()
	UIBlockMgr.instance:endBlock("TestTaskView")
	TaskRpc.instance:sendFinishTaskRequest(self._reward_task_id)
end

function TestTaskView:onClose()
	UIBlockMgr.instance:endBlock("TestTaskView")
	TaskDispatcher.cancelTask(self._getTaskReward, self)
	TaskDispatcher.cancelTask(self._showTaskItem, self)
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function TestTaskView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagedog:UnLoadImage()
	self:_releaseTaskItemImage()
end

return TestTaskView
