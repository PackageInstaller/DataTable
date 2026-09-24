-- chunkname: @modules/logic/college/view/task/CollegeTaskTipsView.lua

module("modules.logic.college.view.task.CollegeTaskTipsView", package.seeall)

local CollegeTaskTipsView = class("CollegeTaskTipsView", BaseView)

function CollegeTaskTipsView:onInitView()
	self._goTaskContainer = gohelper.findChild(self.viewGO, "Left/TaskContainer")
	self._goHasTask = gohelper.findChild(self.viewGO, "Left/TaskContainer/has")
	self._goTaskItem = gohelper.findChild(self.viewGO, "Left/TaskContainer/has/#go_taskitem")
	self._goEmptyTask = gohelper.findChild(self.viewGO, "Left/TaskContainer/empty")
	self._goTaskTitle = gohelper.findChild(self.viewGO, "Left/TaskTitle")
	self._goUnfold = gohelper.findChild(self.viewGO, "Left/TaskTitle/#go_unfold")
	self._goFold = gohelper.findChild(self.viewGO, "Left/TaskTitle/#go_fold")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "Left/TaskTitle/#btn_click")
	self._btnOpenTask = gohelper.findChildButtonWithAudio(self.viewGO, "Left/TaskContainer/#btn_OpenTask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeTaskTipsView:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnOpenTask:AddClickListener(self._btnOpenTaskOnClick, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.TaskFinish, self._onTaskFinish, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.UpdateTask, self._onUpdateTask, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.OnTaskAnimDone, self._onTaskAnimDone, self)
end

function CollegeTaskTipsView:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnOpenTask:RemoveClickListener()
end

function CollegeTaskTipsView:_btnClickOnClick()
	self:setFold(not self._isFold)
end

function CollegeTaskTipsView:_btnOpenTaskOnClick()
	CollegeStatHelper.instance:statBtnClick(CollegeStatEnum.ViewName.Main, CollegeStatEnum.BtnName.TaskDetail)
	ViewMgr.instance:openView(ViewName.CollegeTaskView)
end

function CollegeTaskTipsView:_editableInitView()
	self._animPlayer = ZProj.ProjAnimatorPlayer.Get(self._goTaskContainer)
	self._canvasGroup = gohelper.onceAddComponent(self._goTaskContainer, gohelper.Type_CanvasGroup)
	self._titleCanvasGroup = gohelper.onceAddComponent(self._goTaskTitle, gohelper.Type_CanvasGroup)
	self._showMaxTaskNum = CollegeConfig.instance:getConstNum(CollegeEnum.ConstId.ShowMaxTaskNum)
	self._freeTaskItemList = self:getUserDataTb_()
	self._showingTaskNum = 0
	self._showingTaskMap = {}

	gohelper.setActive(self._goTaskItem, false)
end

function CollegeTaskTipsView:onOpen()
	self._taskBoxMo = CollegeModel.instance:getSceneMo().taskBox

	self:setFold(false)
	self:refreshUI()
end

function CollegeTaskTipsView:refreshUI()
	self:showNextDoingTask()
	self:refreshContainer()
end

function CollegeTaskTipsView:showNextDoingTask()
	if self._showingTaskNum >= self._showMaxTaskNum then
		return
	end

	local allDoingTasks = self._taskBoxMo:getDoingTasks()

	if not allDoingTasks or #allDoingTasks <= 0 then
		return
	end

	for _, doingTaskMo in ipairs(allDoingTasks) do
		if not self._showingTaskMap[doingTaskMo.id] then
			local taskItem = self:_getOrCreateTaskItem()

			taskItem:onUpdateMO(doingTaskMo)

			self._showingTaskMap[doingTaskMo.id] = true
		end

		if self._showingTaskNum >= self._showMaxTaskNum then
			break
		end
	end
end

function CollegeTaskTipsView:refreshContainer()
	gohelper.setActive(self._goHasTask, self._showingTaskNum > 0)
	gohelper.setActive(self._goEmptyTask, self._showingTaskNum <= 0)
end

function CollegeTaskTipsView:_recycleTaskItem(taskId, taskItem)
	gohelper.setActive(taskItem.go, false)

	self._showingTaskMap[taskId] = nil
	self._showingTaskNum = self._showingTaskNum - 1

	table.insert(self._freeTaskItemList, taskItem)
end

function CollegeTaskTipsView:_getOrCreateTaskItem()
	local taskItem = table.remove(self._freeTaskItemList, 1)

	if not taskItem then
		local goTask = gohelper.cloneInPlace(self._goTaskItem, "task")

		taskItem = MonoHelper.addNoUpdateLuaComOnceToGo(goTask, CollegeTaskTipsListItem)
	end

	self._showingTaskNum = self._showingTaskNum + 1

	gohelper.setActive(taskItem.go, true)
	gohelper.setAsLastSibling(taskItem.go)

	return taskItem
end

function CollegeTaskTipsView:_refreshTaskItem(taskItem, taskMo, index)
	taskItem:onUpdateMO(taskMo)
end

function CollegeTaskTipsView:setFold(isFold)
	if self._isFold == isFold then
		return
	end

	self._isFold = isFold

	gohelper.setActive(self._goFold, self._isFold)
	gohelper.setActive(self._goUnfold, not self._isFold)
	gohelper.setActive(self._goTaskContainer, true)

	self._canvasGroup.blocksRaycasts = false
	self._titleCanvasGroup.blocksRaycasts = false

	local animName = self._isFold and "close" or "open"

	self._animPlayer:Play(animName, self._onPlayContainerAnimDone, self)
end

function CollegeTaskTipsView:_onPlayContainerAnimDone()
	self._titleCanvasGroup.blocksRaycasts = true
	self._canvasGroup.blocksRaycasts = not self._isFold

	gohelper.setActive(self._goTaskContainer, not self._isFold)
end

function CollegeTaskTipsView:_onTaskFinish()
	self:setFold(false)
end

function CollegeTaskTipsView:_onUpdateTask()
	self:refreshUI()
end

function CollegeTaskTipsView:_onTaskAnimDone(taskId, taskItem)
	self:_recycleTaskItem(taskId, taskItem)
	self:refreshUI()
end

function CollegeTaskTipsView:onClose()
	return
end

return CollegeTaskTipsView
