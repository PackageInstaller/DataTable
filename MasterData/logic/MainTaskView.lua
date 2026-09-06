-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainTaskView.lua

module("logic.extensions.mainui.view.MainTaskView", package.seeall)

local MainTaskView = class("MainTaskView", TableViewComponent)

function MainTaskView:ctor()
	self._curViewDatas = {}
end

function MainTaskView:buildUI()
	self._tableview = self:getGo("Nego_TaskAndTeam/TaskView/layout/SrlC_ItemTask"):GetComponent("UITableviewForLua")
	self._tableCell = self:getGo("item_task")
	self._taskItemDesc = self:getGo("item_task/bg/TxtC_Desc"):GetComponent("Text")

	self._tableCell:SetActive(false)
	self:registCallbacks()
end

function MainTaskView:destroyUI()
	MainTaskView.super.destroyUI(self)
end

function MainTaskView:bindEvents()
	MainTaskView.super.bindEvents(self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)
end

function MainTaskView:unbindEvents()
	MainTaskView.super.unbindEvents(self)
end

function MainTaskView:onEnter()
	MainTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DiamondTaskInfoGot, self._OnTaskUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.TaskDataReady, self._OnTaskUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.TaskDataUpdate, self._OnTaskUpdate, self, NotifyPriority.High)
	self:_OnTaskUpdate()
end

function MainTaskView:onEnterFinished()
	MainTaskView.super.onEnterFinished(self)
end

function MainTaskView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.TaskDataReady, self._OnTaskUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.TaskDataUpdate, self._OnTaskUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.DiamondTaskInfoGot, self._OnTaskUpdate, self)

	self._curViewDatas = nil

	self._tableview:Travel(self._clearTableview, self)
	MainTaskView.super.onExit(self)
end

function MainTaskView:_clearTableview(cell)
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "bg"):RemoveClickListener()
end

function MainTaskView:onExitFinished()
	MainTaskView.super.onExitFinished(self)
end

function MainTaskView:_numInView()
	local cnt = #self._curViewDatas

	if cnt == 0 then
		return 1
	end

	return cnt
end

function MainTaskView:_cellSize(view, idx)
	return 272, 79
end

function MainTaskView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	if not data then
		self:_fillEmpty(cell)

		return cell
	end

	if data.taskStep then
		self:_fillTaskStep(cell, data.taskStep)
	else
		self:_fillDiamondTask(cell, data.diamondTask, data)
	end

	return cell
end

function MainTaskView:_fillEmpty(cell)
	local bg = goutil.findChild(cell.gameObject, "bg")
	local selected = goutil.findChild(bg, "ImgC_Selected")
	local title = goutil.findChild(bg, "TxtC_Desc/TxtC_Title"):GetComponent("Text")
	local descText = goutil.findChild(bg, "TxtC_Desc"):GetComponent("Text")
	local lock = goutil.findChild(bg, "imgLock")

	goutil.setActive(lock, false)

	title.text = "<color=#6edbff>" .. lang("ui_new_journey") .. "</color>"
	descText.text = lang("tips_not_release")

	Framework.ButtonAdapter.Get(bg):AddClickListener(function()
		return
	end)
end

function MainTaskView:_fillTaskStep(cell, taskStep)
	local bg = goutil.findChild(cell.gameObject, "bg")
	local selected = goutil.findChild(bg, "ImgC_Selected")
	local title = goutil.findChild(bg, "TxtC_Desc/TxtC_Title"):GetComponent("Text")
	local descText = goutil.findChild(bg, "TxtC_Desc"):GetComponent("Text")
	local lock = goutil.findChild(bg, "imgLock")

	if taskStep then
		goutil.setActive(lock, not TaskModel.instance:isTaskAccpeted(taskStep.task:getTaskId()) and not TaskModel.instance:shouldTaskTrigger(taskStep.task, true))
	else
		goutil.setActive(lock, false)
	end

	self:_getTaskTitle(taskStep, title)

	descText.text = self:_getTaskDesc(taskStep)

	selected:SetActive(false)

	local viewIns = self

	Framework.ButtonAdapter.Get(bg):AddClickListener(function()
		if EscortModel.instance:IsPickupEscort() then
			FloatWordMgr.instance:show("护送期间不能进行<color=#ff00ff>[任务]</color>")

			return
		end

		if MountModel.instance:isTeamMountMember() then
			FloatWordMgr.instance:show("双人骑乘不能进行<color=#ff00ff>[任务]</color>")

			return
		end

		if taskStep then
			local taskStarterType = taskStep.task.taskCo.taskStarterType

			if taskStarterType == GameEnum.TaskType.Main then
				SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickMainTaskButton)
			elseif taskStarterType == GameEnum.TaskType.Branch then
				SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickBranchTaskButton)
			elseif taskStarterType == GameEnum.TaskType.Guide then
				SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickGrowUpTaskButton)
			end

			TaskController.instance:foreceClearState()
			TaskController.instance:startAutoAction(taskStep)
			viewIns._tableview:ReloadData()
		end
	end)
end

function MainTaskView:_fillDiamondTask(cell, diamondTask, data)
	local bg = goutil.findChild(cell.gameObject, "bg")
	local selected = goutil.findChild(bg, "ImgC_Selected")
	local title = goutil.findChild(bg, "TxtC_Desc/TxtC_Title"):GetComponent("Text")
	local descText = goutil.findChild(bg, "TxtC_Desc"):GetComponent("Text")
	local lock = goutil.findChild(bg, "imgLock")
	local typeName = ""

	typeName = data.tabType == GameEnum.TaskViewTab.Daily and ConstString.Task[GameEnum.TaskType.Daily] or "周常"

	goutil.setActive(lock, false)

	if diamondTask.state == 1 then
		descText.text = string.format("<color=#96fa73>%s</color>", GameUtil.removeRichColor(diamondTask.describe))
		title.text = string.format("<color=#96fa73>[%s]%s</color>", typeName, GameUtil.removeRichColor(diamondTask.taskType))
	elseif diamondTask.state == 2 then
		descText.text = diamondTask.describe
		title.text = "[" .. typeName .. "]" .. diamondTask.taskType
	end

	selected:SetActive(false)
	Framework.ButtonAdapter.Get(bg):AddClickListener(function()
		if EscortModel.instance:IsPickupEscort() then
			FloatWordMgr.instance:show("护送期间不能进行<color=#ff00ff>[任务]</color>")

			return
		end

		SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickTaskButton)

		if data.diamondTask.state == 1 then
			UIStateManager.instance:push(ViewName.diamondtask, data.tabType)
		else
			if not DiamondTaskModel.instance:checkJumptoUnlock(data.diamondTask) then
				return
			end

			MainUIFacade.instance:setNeedCheckFunc(false)
			GotoMgr.gotoByString(data.diamondTask.jumpTo)
		end
	end)
end

function MainTaskView:_getTaskDesc(taskStep)
	local desc, lastDesc

	for i = 1, (taskStep.targets or nil) and #taskStep.targets do
		local target = taskStep.targets[i]

		lastDesc = target:getDesc()

		if not target:isCompeleted() then
			desc = lastDesc

			break
		end
	end

	desc = desc or lastDesc

	local forbidAutoCommit = taskStep:forbidAutoCommit()
	local hasCommitNpc = taskStep:getCommitNpcId() ~= 0

	if (forbidAutoCommit or hasCommitNpc) and taskStep:isPrepareCompeleted() then
		desc = string.format("<color=#96fa73>%s</color>", GameUtil.removeRichColor(desc))
	end

	if not TaskModel.instance:isTaskAccpeted(taskStep.task:getTaskId()) and not TaskModel.instance:shouldTaskTrigger(taskStep.task, true) then
		desc = string.format("<color=#fd961c>%s</color>", GameUtil.removeRichColor(taskStep.task:getUnAvailableTips()))
	end

	return desc
end

function MainTaskView:_getTaskTitle(taskStep, txt)
	local taskStarterType = taskStep.task.taskCo.taskStarterType
	local typeName = ConstString.Task[taskStarterType]
	local forbidAutoCommit = taskStep:forbidAutoCommit()
	local hasCommitNpc = taskStep:getCommitNpcId() ~= 0
	local name = TaskFacade.instance:getTaskShowName(taskStep.task.taskCo.taskId)
	local title = ""
	local outLine = txt:GetComponent(ComponentType.Outline)

	if (forbidAutoCommit or hasCommitNpc) and taskStep:isPrepareCompeleted() then
		title = string.format("<color=#96fa73><b>[</b>%s<b>]</b> %s</color>", typeName, GameUtil.removeRichColor(name))

		if outLine then
			outLine.enabled = false
		end
	else
		local color = ConstString.TaskColor[taskStarterType]

		title = string.format("<color=#%s><b>[</b>%s<b>]</b> %s</color>", color, typeName, name)

		if outLine then
			outLine.enabled = true
		end
	end

	txt.text = title
end

function MainTaskView:_OnTaskUpdate(taskId)
	self.rcdTaskId = taskId
	self._curViewDatas = {}

	self:_initTaskes()
	self:_sortTaskes()
	self._tableview:ReloadData()
	GlobalDispatcher:dispatch(GlobalNotify.TaskViewDataListUpdate, #self._curViewDatas)
end

function MainTaskView:_initTaskes()
	local currViewDatas = TaskFacade.instance:getCurrentTriggerTaskesShowedOnUI() or {}

	for i = 1, #currViewDatas do
		local taskType = currViewDatas[i].task:getTaskType()

		if taskType ~= GameEnum.TaskType.ColorfulEggs then
			local isUnLock = true

			if taskType == GameEnum.TaskType.Daily then
				local cfg = FuncOpenConfig.instance:getFunctionOpenById(DiamondTaskModel.dailyFuncId)

				if not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
					isUnLock = nil
				end
			end

			if isUnLock then
				local sortingOrder = 9

				if taskType == GameEnum.TaskType.Main then
					sortingOrder = 1
				elseif taskType == GameEnum.TaskType.Branch then
					sortingOrder = 4
				elseif taskType == GameEnum.TaskType.Guide then
					sortingOrder = 5
				elseif taskType == GameEnum.TaskType.Daily then
					sortingOrder = 3
				elseif taskType == GameEnum.TaskType.Festival then
					sortingOrder = 2
				end

				local data = {
					taskStep = currViewDatas[i],
					sortingOrder = sortingOrder
				}

				table.insert(self._curViewDatas, data)
			end
		end
	end
end

function MainTaskView:_initDiamondTaskes()
	if DiamondTaskModel.instance:isUnLock(GameEnum.TaskViewTab.Daily) then
		local dailyTaskes = DiamondTaskModel.instance:getTasksData(DiamondTaskModel.TaskPeriodType.Daily, false)

		for i = 1, #dailyTaskes do
			local data = {
				sortingOrder = 6,
				diamondTask = dailyTaskes[i],
				tabType = GameEnum.TaskViewTab.Daily
			}

			table.insert(self._curViewDatas, data)
		end
	end
end

function MainTaskView:_sortTaskes()
	table.sort(self._curViewDatas, function(x, y)
		if x == y then
			return false
		end

		if not x.taskStep and not x.diamondTask then
			return false
		end

		if not y.taskStep and not y.diamondTask then
			return false
		end

		local xCompeleted, yCompeleted

		xCompeleted = x.taskStep and x.taskStep:isCompeleted() or x.diamondTask.state == 1
		yCompeleted = y.taskStep and y.taskStep:isCompeleted() or y.diamondTask.state == 1

		if xCompeleted and not yCompeleted then
			return true
		end

		if not xCompeleted and yCompeleted then
			return false
		end

		if x.sortingOrder < y.sortingOrder then
			return true
		end

		if x.sortingOrder > y.sortingOrder then
			return false
		end

		local idX, idY

		idX = x.taskStep and x.taskStep:getTaskId() or x.diamondTask.taskId

		return idX < (y.taskStep and y.taskStep:getTaskId() or y.diamondTask.taskId)
	end)
end

function MainTaskView:_onReloadFinish()
	if self.rcdTaskId then
		GlobalDispatcher:dispatch(GlobalNotify.TaskViewDataUpdate, self.rcdTaskId)

		self.rcdTaskId = nil
	end
end

function MainTaskView:_OnClickEmptyTask()
	FloatWordMgr.instance:show(ConstString.NotRelease)
end

return MainTaskView
