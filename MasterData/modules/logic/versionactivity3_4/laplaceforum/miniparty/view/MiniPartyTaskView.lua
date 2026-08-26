-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/view/MiniPartyTaskView.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.view.MiniPartyTaskView", package.seeall)

local MiniPartyTaskView = class("MiniPartyTaskView", BaseView)

function MiniPartyTaskView:onInitView()
	self._btngrouptask = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Top/#btn_grouptask")
	self._gogroupselect = gohelper.findChild(self.viewGO, "Right/Top/#btn_grouptask/select")
	self._gogroupreddot = gohelper.findChild(self.viewGO, "Right/Top/#btn_grouptask/#go_grouptaskreddot")
	self._btnselftask = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Top/#btn_selftask")
	self._goselfselect = gohelper.findChild(self.viewGO, "Right/Top/#btn_selftask/select")
	self._goselfreddot = gohelper.findChild(self.viewGO, "Right/Top/#btn_selftask/#go_selftaskreddot")
	self._gonodeselect = gohelper.findChild(self.viewGO, "Right/Top/node_select")
	self._gotips = gohelper.findChild(self.viewGO, "Right/layout/#go_tips")
	self._gotipeffect = gohelper.findChild(self.viewGO, "Right/layout/#go_tips/effect")
	self._gotipuneffect = gohelper.findChild(self.viewGO, "Right/layout/#go_tips/uneffect")
	self._gogrouptasks = gohelper.findChild(self.viewGO, "Right/layout/#go_grouptasks")
	self._gogrouptaskcontentroot = gohelper.findChild(self.viewGO, "Right/layout/#go_grouptasks/Viewport/Content")
	self._goselftasks = gohelper.findChild(self.viewGO, "Right/layout/#go_selftasks")
	self._goselftaskcontentroot = gohelper.findChild(self.viewGO, "Right/layout/#go_selftasks/Viewport/Content")
	self._gotaskitem = gohelper.findChild(self.viewGO, "Right/layout/#go_taskitem")
	self._gofinisheff = gohelper.findChild(self.viewGO, "Right/vx_up")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MiniPartyTaskView:addEvents()
	self._btngrouptask:AddClickListener(self._btngrouptaskOnClick, self)
	self._btnselftask:AddClickListener(self._btnselftaskOnClick, self)
end

function MiniPartyTaskView:removeEvents()
	self._btngrouptask:RemoveClickListener()
	self._btnselftask:RemoveClickListener()
end

function MiniPartyTaskView:_btngrouptaskOnClick()
	if self._taskType == MiniPartyEnum.TaskType.GroupTask then
		return
	end

	MiniPartyTaskModel.instance:setCurTaskType(MiniPartyEnum.TaskType.GroupTask)
	self:_refresh()
end

function MiniPartyTaskView:_btnselftaskOnClick()
	if self._taskType == MiniPartyEnum.TaskType.SelfTask then
		return
	end

	MiniPartyTaskModel.instance:setCurTaskType(MiniPartyEnum.TaskType.SelfTask)
	self:_refresh()
end

function MiniPartyTaskView:_editableInitView()
	self._groupTasks = self:getUserDataTb_()
	self._selfTasks = self:getUserDataTb_()

	gohelper.setActive(self._gotaskitem, false)

	self._btnAnim = self._gonodeselect:GetComponent(typeof(UnityEngine.Animator))

	self:_addSelfEvents()
end

function MiniPartyTaskView:_addSelfEvents()
	self.addEventCb(self, MiniPartyController.instance, MiniPartyEvent.OnInviteSend, self._refresh, self)
	self.addEventCb(self, MiniPartyController.instance, MiniPartyEvent.OnInfoChange, self._refresh, self)
	self.addEventCb(self, MiniPartyController.instance, MiniPartyEvent.InviteFriendAgreeBack, self._refresh, self)
	self.addEventCb(self, MiniPartyController.instance, MiniPartyEvent.ShowTaskAnim, self._onShowFinishAnim, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._refresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refresh, self)
end

function MiniPartyTaskView:_removeSelfEvents()
	self.removeEventCb(self, MiniPartyController.instance, MiniPartyEvent.OnInviteSend, self._refresh, self)
	self.removeEventCb(self, MiniPartyController.instance, MiniPartyEvent.OnInfoChange, self._refresh, self)
	self.removeEventCb(self, MiniPartyController.instance, MiniPartyEvent.InviteFriendAgreeBack, self._refresh, self)
	self.removeEventCb(self, MiniPartyController.instance, MiniPartyEvent.ShowTaskAnim, self._onShowFinishAnim, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._refresh, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refresh, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refresh, self)
end

function MiniPartyTaskView:onUpdateParam()
	return
end

function MiniPartyTaskView:onOpen()
	self._taskType = MiniPartyTaskModel.instance:getCurTaskType()

	RedDotController.instance:addRedDot(self._gogroupreddot, RedDotEnum.DotNode.V3a4LaplaceMiniPartyGroupTask)
	RedDotController.instance:addRedDot(self._goselfreddot, RedDotEnum.DotNode.V3a4LaplaceMiniPartySelfTask)
	self:_refresh()
end

function MiniPartyTaskView:_onShowFinishAnim()
	gohelper.setActive(self._gofinisheff, true)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("minipartytaskfinishshow")
	TaskDispatcher.runDelay(self._onShowFinishAnimDone, self, 2)
end

function MiniPartyTaskView:_onShowFinishAnimDone()
	gohelper.setActive(self._gofinisheff, false)
	UIBlockMgr.instance:endBlock("minipartytaskfinishshow")
end

function MiniPartyTaskView:_refresh()
	local taskType = MiniPartyTaskModel.instance:getCurTaskType()

	if taskType == self._taskType then
		if taskType == MiniPartyEnum.TaskType.GroupTask then
			self._btnAnim:Play("idle1")
		else
			self._btnAnim:Play("idle2")
		end
	elseif taskType == MiniPartyEnum.TaskType.GroupTask then
		self._btnAnim:Play("switch1", 0, 0)
	else
		self._btnAnim:Play("switch2", 0, 0)
	end

	self._taskType = taskType

	self:_refreshBtns()
	self:_refreshTasks()
end

function MiniPartyTaskView:_refreshBtns()
	gohelper.setActive(self._gogroupselect, self._taskType == MiniPartyEnum.TaskType.GroupTask)
	gohelper.setActive(self._goselfselect, self._taskType == MiniPartyEnum.TaskType.SelfTask)
end

function MiniPartyTaskView:_refreshTasks()
	gohelper.setActive(self._gogrouptasks, self._taskType == MiniPartyEnum.TaskType.GroupTask)
	gohelper.setActive(self._goselftasks, self._taskType == MiniPartyEnum.TaskType.SelfTask)

	if self._taskType == MiniPartyEnum.TaskType.GroupTask then
		self:_refreshGroupTasks()
	elseif self._taskType == MiniPartyEnum.TaskType.SelfTask then
		self:_refreshSelfTasks()
	end
end

function MiniPartyTaskView:_refreshGroupTasks()
	local hasGrouped = MiniPartyModel.instance:hasGrouped()

	gohelper.setActive(self._gotips, true)
	gohelper.setActive(self._gotipeffect, hasGrouped)
	gohelper.setActive(self._gotipuneffect, not hasGrouped)

	local taskList = MiniPartyTaskModel.instance:getAllUnlockTasks(self._taskType)

	for index, taskId in ipairs(taskList) do
		if not self._groupTasks[taskId] then
			local go = gohelper.clone(self._gotaskitem, self._gogrouptaskcontentroot)

			self._groupTasks[taskId] = MiniPartyTaskItem.New()

			self._groupTasks[taskId]:init(go, self._taskType)
			self._groupTasks[taskId]:setScrollParentGo(self._gogrouptasks)
		end

		local taskMo = TaskModel.instance:getTaskById(taskId)

		self._groupTasks[taskId]:refresh(taskMo)
		gohelper.setSibling(self._groupTasks[taskId].go, index)
	end

	local taskCount = MiniPartyTaskModel.instance:getCanGetTaskCount(self._taskType)
	local needShowWating = MiniPartyTaskModel.instance:needWaitingTaskItem(self._taskType)

	if not self._groupTasks[0] then
		local go = gohelper.clone(self._gotaskitem, self._gogrouptaskcontentroot)

		self._groupTasks[0] = MiniPartyTaskItem.New()

		self._groupTasks[0]:init(go, self._taskType)
	end

	if taskCount > 1 then
		self._groupTasks[0]:showItem(true, MiniPartyEnum.TaskItemType.GetAll)
		gohelper.setAsFirstSibling(self._groupTasks[0].go)
	elseif needShowWating then
		self._groupTasks[0]:showItem(true, MiniPartyEnum.TaskItemType.Waiting)
		gohelper.setAsFirstSibling(self._groupTasks[0].go)
	elseif self._groupTasks[0] then
		self._groupTasks[0]:showItem(false)
		gohelper.setAsLastSibling(self._groupTasks[0].go)
	end
end

function MiniPartyTaskView:_refreshSelfTasks()
	gohelper.setActive(self._gotips, false)

	local taskList = MiniPartyTaskModel.instance:getAllUnlockTasks(self._taskType)

	for index, taskId in ipairs(taskList) do
		if not self._selfTasks[taskId] then
			local go = gohelper.clone(self._gotaskitem, self._goselftaskcontentroot)

			self._selfTasks[taskId] = MiniPartyTaskItem.New()

			self._selfTasks[taskId]:init(go, self._taskType)
			self._selfTasks[taskId]:setScrollParentGo(self._goselftasks)
		end

		local taskMo = TaskModel.instance:getTaskById(taskId)

		self._selfTasks[taskId]:refresh(taskMo)

		self._selfTasks[taskId].go.name = taskId

		gohelper.setSibling(self._selfTasks[taskId].go, index)
	end

	local taskCount = MiniPartyTaskModel.instance:getCanGetTaskCount(self._taskType)
	local needShowWating = MiniPartyTaskModel.instance:needWaitingTaskItem(self._taskType)

	if not self._selfTasks[0] then
		local go = gohelper.clone(self._gotaskitem, self._goselftaskcontentroot)

		self._selfTasks[0] = MiniPartyTaskItem.New()

		self._selfTasks[0]:init(go, self._taskType)
	end

	if taskCount > 1 then
		self._selfTasks[0]:showItem(true, MiniPartyEnum.TaskItemType.GetAll)
		gohelper.setAsFirstSibling(self._selfTasks[0].go)
	elseif needShowWating then
		self._selfTasks[0]:showItem(true, MiniPartyEnum.TaskItemType.Waiting)
		gohelper.setAsFirstSibling(self._selfTasks[0].go)
	elseif self._selfTasks[0] then
		self._selfTasks[0]:showItem(false)
		gohelper.setAsLastSibling(self._selfTasks[0].go)
	end
end

function MiniPartyTaskView:onClose()
	UIBlockMgr.instance:endBlock("minipartytaskfinishshow")
	TaskDispatcher.cancelTask(self._onShowFinishAnimDone, self)
end

function MiniPartyTaskView:onDestroyView()
	self:_removeSelfEvents()

	if self._groupTasks then
		for _, task in pairs(self._groupTasks) do
			task:destroy()
		end

		self._groupTasks = nil
	end

	if self._selfTasks then
		for _, task in pairs(self._selfTasks) do
			task:destroy()
		end

		self._selfTasks = nil
	end
end

return MiniPartyTaskView
