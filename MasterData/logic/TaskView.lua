-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskView.lua

module("logic.extensions.task.view.TaskView", package.seeall)

local TaskView = class("TaskView", ViewComponent)
local taskChatpterFinished = 1
local taskChatpterNotFinished = 2
local taskCellTypeChatpter = 1
local taskCellTypeTaskType = 2
local taskCellTypeTask = 3
local taskCellTypeFinishChatpter = 4

function TaskView:buildUI()
	self._close = self:getBtn("Close")

	self:_initTaskView()
	self:_initTaskStepDetails()
	self:_initTaskStepRewards()
end

function TaskView:destroyUI()
	self._close = nil
	self._taskView = nil
	self._chapterItem = nil
	self._taskItem = nil
	self._stepItem = nil
	self._taskStepView = nil
	self._taskStepBigIcon = nil
	self._taskStepItem = nil
	self._taskStepDesc = nil
	self._taskStepTargets = nil
	self._taskStepTargetNum = nil
	self._taskStepGoToButton = nil
	self._taskStepReviewButton = nil
	self._taskTargetNodes = nil
	self._taskRewardsView = nil
	self._taskRewardsItem = nil
	self._taskConfigs = nil
	self._currTaskConfigs = nil
	self._selectedTask = nil
	self._taskStepInfo = nil
	self._taskStepDescNode = nil
	self._currTaskTargets = nil
	self._totalTargetsNum = nil
end

function TaskView:onEnter()
	self._taskView:RegisterCallback(self._numTaskItemsInView, self._taskItemCellSizeInView, self._taskItemCellAtIndex, self)
	self._taskRewardsView:RegisterCallback(self._numTaskRewardItemsInView, self._taskRewardItemCellSizeInView, self._taskRewardItemCellAtIndex, self)
	self._taskStepView:RegisterCallback(self._numTaskStepItemsInView, self._taskStepItemCellSizeInView, self._taskStepItemCellAtIndex, self)
	self._taskView:SetOffsetWithoutRefresh(0)
	self:_buildAllTaskes()
	self:_reloadCurrTaskConfigs()
end

function TaskView:onExit()
	self._taskConfigs = nil
	self._currTaskConfigs = nil
	self._currTaskTargets = nil
	self._totalTargetsNum = nil
	self._selectedTask = nil

	self._taskView:Travel(self._clearTaskViewButtons, self, true)
	self._taskStepView:Travel(self._clearTaskStepViewButtons, self, true)
	self._taskRewardsView:Travel(self._clearTaskRewardViewButtons, self, true)
	self._taskView:UnRegisterAllCallbacks()
	self._taskStepView:UnRegisterAllCallbacks()
end

function TaskView:bindEvents()
	self._close:AddClickListener(self._onClickCloseButton, self)
	self._taskStepGoToButton:AddClickListener(self._onClickStepGoToButton, self)
	self._taskStepReviewButton:AddClickListener(self._onClickStepReviewButton, self)
end

function TaskView:unbindEvents()
	self._close:RemoveClickListener()
	self._taskStepGoToButton:RemoveClickListener()
	self._taskStepReviewButton:RemoveClickListener()
end

function TaskView:_initTaskView()
	self._taskView = self:getGo("TaskView"):GetComponent("UITableview")
	self._chapterItem = self:getGo("ItemChapter")
	self._taskItem = self:getGo("ItemTask")
	self._stepItem = self:getGo("ItemStep")

	self._chapterItem:SetActive(false)
	self._taskItem:SetActive(false)
	self._stepItem:SetActive(false)
end

function TaskView:_initTaskStepDetails()
	self._taskStepInfo = self:getGo("TaskStepInfo")
	self._taskStepView = self:getGo("TaskStepInfo/TaskStep"):GetComponent("UITableview")
	self._taskStepBigIcon = self:getGo("TaskStepInfo/RawImage"):GetComponent("RawImage")
	self._taskStepItem = self:getGo("TaskStepInfo/TaskStepItem")
	self._taskStepDescNode = self:getGo("TaskStepInfo/TaskStepItem/DescNode/")
	self._taskStepDesc = self:getGo("TaskStepInfo/TaskStepItem/DescNode/Desc"):GetComponent("Text")
	self._taskStepTargets = self:getGo("TaskStepInfo/TaskStepItem/Targets")
	self._taskStepTargetNum = self:getGo("TaskStepInfo/TaskStepItem/Targets/TargetNum"):GetComponent("Text")
	self._taskStepGoToButton = self:getBtn("TaskStepInfo/GoToButton")
	self._gotoBtnText = self:getGo("TaskStepInfo/GoToButton/Text"):GetComponent("Text")
	self._taskStepReviewButton = self:getBtn("TaskStepInfo/ReviewButton")
	self._taskTargetNodes = {}

	local stepDescTitle = self:getGo("TaskStepInfo/TaskStepItem/DescNode/DescTitle"):GetComponent("Text")
	local stepTargetTitle = self:getGo("TaskStepInfo/TaskStepItem/Targets/TargetTitle"):GetComponent("Text")
	local taskStepTargetNode = self:getGo("TaskStepInfo/TaskStepItem/Targets/TargetNode")

	stepDescTitle.text = lang("task_desc")
	stepTargetTitle.text = lang("task_target")
	self._taskTargetNodes[1] = taskStepTargetNode

	self._taskStepItem:SetActive(false)
end

function TaskView:_initTaskStepRewards()
	self._taskRewardsView = self:getGo("TaskStepInfo/Rewards/ScrollView"):GetComponent("UITableview")
	self._taskRewardsItem = self:getGo("TaskStepInfo/Rewards/ItemIcon")

	self._taskRewardsItem:SetActive(false)
end

function TaskView:_getAllTaskConfigs()
	local taskConfigs = TaskConfig.instance:getAllTaskCoes()
	local cnt = #taskConfigs
	local accepted = {}
	local finished = {}
	local unaccepted = {}

	for i = 1, cnt do
		local taskCo = taskConfigs[i]

		if TaskModel.instance:isTaskNeedShowedOnUIByTaskCo(taskCo) then
			if TaskModel.instance:isTaskFinished(taskCo.taskId) then
				finished[#finished + 1] = taskCo
			elseif TaskModel.instance:isTaskAccpeted(taskCo.taskId) then
				accepted[#accepted + 1] = taskCo
			elseif not TaskModel.instance:isTaskNeedTrigger(taskCo) or TaskModel.instance:isTaskAccpetable(taskCo.taskId) then
				unaccepted[#unaccepted + 1] = taskCo
			end
		end
	end

	return accepted, unaccepted, finished
end

function TaskView:_sortTaskConfigs(accepted, unaccepted, finished)
	table.sort(accepted, function(first, second)
		if first == second then
			return
		end

		return first.taskId < second.taskId
	end)
	table.sort(unaccepted, function(first, second)
		if first == second then
			return
		end

		return first.taskId < second.taskId
	end)
	table.sort(finished, function(first, second)
		if first == second then
			return
		end

		return first.taskId < second.taskId
	end)
end

function TaskView:_buildAllTaskes()
	local accepted, unaccepted, finished = self:_getAllTaskConfigs()

	self:_sortTaskConfigs(accepted, unaccepted, finished)

	self._taskConfigs = {}

	local taskes = {}
	local cnt = #accepted

	for i = 1, cnt do
		local tType = accepted[i].taskStarterType

		taskes[tType] = taskes[tType] or {
			tType = tType
		}
		taskes[tType].taskes = taskes[tType].taskes or {}
		taskes[tType].taskes[#taskes[tType].taskes + 1] = accepted[i]

		if tType == GameEnum.TaskType.Main then
			taskes[tType].unfolding = true
		end
	end

	cnt = #unaccepted

	for i = 1, #unaccepted do
		local tType = unaccepted[i].taskStarterType

		taskes[tType] = taskes[tType] or {
			tType = tType
		}
		taskes[tType].taskes = taskes[tType].taskes or {}
		taskes[tType].taskes[#taskes[tType].taskes + 1] = unaccepted[i]

		if tType == GameEnum.TaskType.Main then
			taskes[tType].unfolding = true
		end
	end

	self._taskConfigs[taskChatpterNotFinished] = {
		unfolding = true,
		taskeTypes = taskes
	}

	if self._taskConfigs[taskChatpterNotFinished].taskeTypes[1] and self._taskConfigs[taskChatpterNotFinished].taskeTypes[1].taskes[1] then
		self:_selectTask(self._taskConfigs[taskChatpterNotFinished].taskeTypes[1].taskes[1])
	end

	taskes = {}
	cnt = #finished

	for i = 1, #finished do
		local tType = finished[i].taskStarterType

		taskes[tType] = taskes[tType] or {
			tType = tType
		}
		taskes[tType].taskes = taskes[tType].taskes or {}
		taskes[tType].taskes[#taskes[tType].taskes + 1] = finished[i]
	end

	self._taskConfigs[taskChatpterFinished] = {
		taskeTypes = taskes
	}
end

function TaskView:_reloadCurrTaskConfigs()
	self._currTaskConfigs = {}

	local cellsNum = 1

	cellsNum = self:_reloadCurrTaskByChatperType(cellsNum, taskCellTypeChatpter, self._taskConfigs[taskChatpterNotFinished])

	self:_reloadCurrTaskByChatperType(cellsNum, taskCellTypeFinishChatpter, self._taskConfigs[taskChatpterFinished])
	self._taskView:ReloadData()
end

function TaskView:_reloadCurrTaskByChatperType(cellsNum, cType, chapter)
	self._currTaskConfigs[cellsNum] = {
		cType = cType,
		chapter = chapter
	}
	cellsNum = cellsNum + 1

	if chapter.unfolding then
		for l = 1, GameEnum.TaskType.Count do
			local taskeType = chapter.taskeTypes[l]

			if taskeType then
				self._currTaskConfigs[cellsNum] = {
					cType = taskCellTypeTaskType,
					typeConfig = taskeType
				}
				cellsNum = cellsNum + 1

				if taskeType.unfolding then
					local cnt = #taskeType.taskes

					for i = 1, cnt do
						local taskCfg = taskeType.taskes[i]

						self._currTaskConfigs[cellsNum] = {
							cType = taskCellTypeTask,
							taskCfg = taskCfg
						}
						cellsNum = cellsNum + 1
					end
				end
			end
		end
	end

	return cellsNum
end

function TaskView:_onClickCloseButton()
	self:close()
end

function TaskView:_onClickStepGoToButton()
	if self._selectedTask then
		if TaskModel.instance.isTesting then
			TaskController.instance:startTestTask(self._selectedTask.taskId)
		else
			TaskController.instance:startAutoActionByTaskId(self._selectedTask.taskId)
		end

		self:close()
	end
end

function TaskView:_onClickStepReviewButton()
	self:close()
end

function TaskView:_numTaskItemsInView()
	if self._currTaskConfigs then
		return #self._currTaskConfigs
	end

	return 0
end

function TaskView:_taskItemCellSizeInView(view, idx)
	local iIdx = idx + 1
	local cellConfig = self._currTaskConfigs[iIdx]

	if cellConfig.cType == taskCellTypeChatpter then
		return 256, 60
	elseif cellConfig.cType == taskCellTypeTaskType then
		return 256, 50
	elseif cellConfig.cType == taskCellTypeTask then
		return 256, 60
	elseif cellConfig.cType == taskCellTypeFinishChatpter then
		return 256, 60
	end

	return 256, 32
end

function TaskView:_taskItemCellAtIndex(view, idx)
	local cellConfig = self._currTaskConfigs[idx + 1]

	if cellConfig.cType == taskCellTypeChatpter then
		return self:_fillTaskChapterCell(view, cellConfig)
	elseif cellConfig.cType == taskCellTypeTaskType then
		return self:_fillTaskTypeCell(view, cellConfig)
	elseif cellConfig.cType == taskCellTypeTask then
		return self:_fillTaskCell(view, cellConfig)
	elseif cellConfig.cType == taskCellTypeFinishChatpter then
		return self:_fillTaskFinishChapterCell(view, cellConfig)
	end
end

function TaskView:_fillTaskChapterCell(view, cellConfig)
	local cell = view:DequeueCellByTag(100)

	if not cell then
		cell = view:AddChild(self._chapterItem)
		cell.tag = 100
	end

	local button = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Button")
	local arrow = goutil.findChild(cell, "Arrow")
	local name = goutil.findChild(cell, "Name"):GetComponent("Text")
	local selected = goutil.findChild(cell, "Selected")
	local change = goutil.findChild(cell, "Button"):GetComponent("UIImageSpriteChange")

	change:SetState(1)

	if cellConfig.chapter.unfolding then
		Framework.TransformUtil.SetLocalRotation(arrow.transform, 0, 0, -180)
	else
		Framework.TransformUtil.SetLocalRotation(arrow.transform, 0, 0, -90)
	end

	name.text = lang("task_chapter")

	selected:SetActive(cellConfig.chapter.unfolding)
	button:AddClickListener(function()
		if cellConfig.chapter.unfolding then
			cellConfig.chapter.unfolding = nil
		else
			cellConfig.chapter.unfolding = true
		end

		self:_reloadCurrTaskConfigs()
	end, self)

	return cell
end

function TaskView:_fillTaskFinishChapterCell(view, cellConfig)
	local cell = view:DequeueCellByTag(100)

	if not cell then
		cell = view:AddChild(self._chapterItem)
		cell.tag = 100
	end

	local button = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Button")
	local name = goutil.findChild(cell, "Name"):GetComponent("Text")
	local selected = goutil.findChild(cell, "Selected")
	local change = goutil.findChild(cell, "Button"):GetComponent("UIImageSpriteChange")

	change:SetState(0)

	name.text = lang("task_over")

	selected:SetActive(cellConfig.chapter.unfolding)
	button:AddClickListener(function()
		if cellConfig.chapter.unfolding then
			cellConfig.chapter.unfolding = nil
		else
			cellConfig.chapter.unfolding = true
		end

		self:_reloadCurrTaskConfigs()
	end, self)

	return cell
end

function TaskView:_fillTaskTypeCell(view, cellConfig)
	local cell = view:DequeueCellByTag(101)

	if not cell then
		cell = view:AddChild(self._taskItem)
		cell.tag = 101
	end

	local button = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Button")
	local selected = goutil.findChild(cell, "Selected")
	local bg = goutil.findChild(cell, "BG")
	local name = goutil.findChild(cell, "TaskName"):GetComponent("Text")
	local change = goutil.findChild(cell, "Button"):GetComponent("UIImageSpriteChange")

	if TaskModel.instance:isTaskFinished(cellConfig.typeConfig.taskes[1].taskId) then
		change:SetState(0)
	else
		change:SetState(1)
	end

	if cellConfig.typeConfig.unfolding then
		goutil.setHeight(bg.transform, (#cellConfig.typeConfig.taskes - 1) * 60 + 75)
	else
		goutil.setHeight(bg.transform, 0)
	end

	name.text = TaskConst.getTaskTypeName(cellConfig.typeConfig.tType)

	selected:SetActive(cellConfig.typeConfig.unfolding)
	button:AddClickListener(function()
		if cellConfig.typeConfig.unfolding then
			cellConfig.typeConfig.unfolding = nil
		else
			cellConfig.typeConfig.unfolding = true
		end

		self:_reloadCurrTaskConfigs()
	end, self)

	return cell
end

function TaskView:_fillTaskCell(view, cellConfig)
	local cell = view:DequeueCellByTag(102)

	if not cell then
		cell = view:AddChild(self._stepItem)
		cell.tag = 102
	end

	cell.transform:SetAsLastSibling()

	local button = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Button")
	local selected = goutil.findChild(cell, "Selected")
	local name = goutil.findChild(cell, "Name"):GetComponent("Text")
	local finished = goutil.findChild(cell, "Finished")
	local isFinished = TaskModel.instance:isTaskFinished(cellConfig.taskCfg.taskId)

	name.text = cellConfig.taskCfg.name

	finished:SetActive(isFinished)
	selected:SetActive(cellConfig.taskCfg == self._selectedTask)

	local taskView = self

	button:AddClickListener(function()
		taskView:_selectTask(cellConfig.taskCfg)
	end, taskView)

	return cell
end

function TaskView:_selectTask(taskCfg)
	if self._selectedTask ~= taskCfg then
		self._selectedTask = taskCfg

		self._taskView:Refresh()
	end

	self._taskStepInfo:SetActive(taskCfg ~= nil)
	self._taskStepView:SetOffsetWithoutRefresh(0)
	self._taskStepView:ReloadData()
	self._taskRewardsView:SetOffsetWithoutRefresh(0)
	self._taskRewardsView:ReloadData()
end

function TaskView:_numTaskStepItemsInView()
	if self._selectedTask then
		return 1
	end

	return 0
end

function TaskView:_taskStepItemCellSizeInView(view, idx)
	local selectTask = self._selectedTask
	local taskStep = TaskModel.instance:getCurrStepOfTask(selectTask.taskId)
	local isFinished = TaskModel.instance:isTaskFinished(selectTask.taskId)

	if not taskStep then
		if not isFinished then
			local task = TaskFactory.createTask(selectTask.taskId)

			taskStep = TaskStepFactory.createTaskStep(task:firstStepId(), task)
		else
			local task = TaskFactory.createTask(selectTask.taskId)

			taskStep = TaskStepFactory.createTaskStep(task:lastStepId(), task)

			taskStep:setState(TaskConst.TSTEP_S_FINISHED)
		end
	end

	self:_getTaskTargets(taskStep)
	self:_updateStepDesc(taskStep, isFinished)
	self:_updateStepTargetProgress(taskStep, isFinished)
	self:_updateStepTargets(taskStep, isFinished)
	self:_updateStepReward(taskStep, isFinished)
	self:_updateButtonText(taskStep, isFinished)

	return 100, self:_calculateStepCellSize(taskStep)
end

function TaskView:_getTaskTargets(taskStep)
	local currTaskTargets = TaskFacade.instance:getAllTaskTargets(taskStep:getTaskId())
	local targetNum = #currTaskTargets

	self._currTaskTargets = {}
	self._totalTargetsNum = targetNum

	for i = 1, targetNum do
		local target = currTaskTargets[i]

		if target.valid then
			table.insert(self._currTaskTargets, target)
		end
	end
end

function TaskView:_updateButtonText(taskStep, isFinished)
	local state = taskStep:getState()
	local txt = lang("goto")

	if state == TaskConst.TSTEP_S_COMPELETED then
		txt = lang("finish")
	elseif state == TaskConst.TSTEP_S_FINISHED then
		txt = lang("task_review")
	end

	self._taskStepGoToButton.gameObject:SetActive(state ~= TaskConst.TSTEP_S_FINISHED)

	self._gotoBtnText.text = txt
end

function TaskView:_updateStepReward(taskStep, isFinished)
	local rwdStr = taskStep:getTaskBonus()

	self._curRewards = {}
	self._curRewards.finished = isFinished

	local items = string.split(rwdStr, "#")

	for i = 1, #items do
		local item = string.split(items[i], ":")

		if item[2] and item[3] then
			table.insert(self._curRewards, {
				tostring(item[2]),
				tostring(item[3])
			})
		end
	end
end

function TaskView:_updateStepDesc(taskStep, isFinished)
	local desc = taskStep:getStepDesc()

	if desc and desc ~= 0 then
		self._taskStepDescNode:SetActive(true)

		self._taskStepDesc.text = "<color=#511212>" .. desc .. "</color>"
	else
		self._taskStepDescNode:SetActive(false)
	end
end

function TaskView:_updateStepTargetProgress(taskStep, isFinished)
	local taskTargets = self._currTaskTargets

	if taskTargets then
		self._taskStepTargets:SetActive(true)

		local targetNum = #taskTargets
		local compTargetNum = 0

		for i = 1, targetNum do
			local target = taskTargets[i]

			if target.valid and target:isCompeleted() then
				compTargetNum = compTargetNum + 1
			end
		end

		self._taskStepTargetNum.text = compTargetNum < self._totalTargetsNum and "<color=#FF0000>" .. "(" .. compTargetNum .. "/" .. self._totalTargetsNum .. ")" .. "</color>" or "<color=#FF0000>" .. "(" .. compTargetNum .. "/" .. self._totalTargetsNum .. ")" .. "</color>"
	else
		self._taskStepTargets:SetActive(false)
	end
end

function TaskView:_updateStepTargets(taskStep, isFinished)
	local taskTargets = self._currTaskTargets

	if not taskTargets then
		return
	end

	local targetNum = #taskTargets
	local nodeNum = #self._taskTargetNodes

	while nodeNum < targetNum do
		nodeNum = nodeNum + 1
		self._taskTargetNodes[nodeNum] = UGUIToolHelper.CloneChild(self._taskTargetNodes[1])
	end

	local cnt = 1

	for i = 1, targetNum do
		local node = self._taskTargetNodes[i]

		node:SetActive(true)

		local desc = goutil.findChild(node, "Desc"):GetComponent("Text")
		local finished = goutil.findChild(node, "Finished")
		local itemIcon = goutil.findChild(node, "ItemIcon")
		local target = taskTargets[i]
		local targetNum = target:getTargetNum()

		if target:isCompeleted() then
			finished:SetActive(true)

			desc.text = "<color=#008E4A>·" .. target:getDesc() .. "(" .. targetNum .. "/" .. targetNum .. ")" .. "</color>"

			Framework.TransformUtil.SetLocalPos(finished.transform, desc.preferredWidth + 20, 6, 0)
		else
			finished:SetActive(false)

			desc.text = "<color=#511212>·" .. target:getDesc() .. "(" .. target:getProgress() .. "/" .. targetNum .. ")" .. "</color>"
		end

		local itemId = target:getItemId()

		if itemId and itemId > 0 then
			itemIcon:SetActive(true)

			local cfg = ItemConfig.instance:getCfgById(itemId)

			if cfg then
				uGuiUtil.setSpriteToImage(goutil.findChild(itemIcon, "Icon"), uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.icon))
			end

			local itemNum = goutil.findChild(itemIcon, "Num"):GetComponent("Text")

			itemNum.text = tostring(target:getTargetNum())
		else
			itemIcon:SetActive(false)
		end

		cnt = cnt + 1
	end

	for i = cnt, nodeNum do
		local node = self._taskTargetNodes[i]

		node:SetActive(false)
	end
end

function TaskView:_calculateStepCellSize(taskStep)
	local posY = 0

	if self._taskStepDescNode.activeSelf then
		local descHeight = self._taskStepDesc.preferredHeight
		local lx, ly, lz = Framework.TransformUtil.GetLocalPos(self._taskStepDesc.transform, nil, nil, nil)

		posY = ly - descHeight - 50
	end

	if self._taskStepTargets.activeSelf then
		Framework.TransformUtil.SetLocalPos(self._taskStepTargets.transform, 0, posY, 0)

		posY = posY - 60

		local taskTargets = self._currTaskTargets
		local targetNum = #taskTargets
		local nodePos = -60

		for i = 1, targetNum do
			local node = self._taskTargetNodes[i]

			Framework.TransformUtil.SetLocalPos(node.transform, 3, nodePos, 0)

			local target = taskTargets[i]
			local itemId = target:getItemId()

			if itemId and itemId > 0 then
				posY = posY - 100
				nodePos = nodePos - 100
			else
				posY = posY - 30
				nodePos = nodePos - 30
			end
		end

		return math.abs(posY - 5)
	else
		return math.abs(posY - 5)
	end
end

function TaskView:_taskStepItemCellAtIndex(view, idx)
	return self._taskStepItem:GetComponent("UITableviewCell")
end

function TaskView:_numTaskRewardItemsInView()
	return #self._curRewards
end

function TaskView:_taskRewardItemCellSizeInView(view, idx)
	return 74, 74
end

function TaskView:_taskRewardItemCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._taskRewardsItem)

	local info = self._curRewards[idx + 1]
	local icon = goutil.findChild(cell, "Icon")
	local iconBgImg = goutil.findChild(cell, "ItemIcon"):GetComponent("Image")
	local iconImg = goutil.findChild(cell, "Icon"):GetComponent("Image")
	local num = goutil.findChild(cell, "Num"):GetComponent("Text")
	local cfg = ItemConfig.instance:getCfgById(checknumber(info[1]))

	num.text = checknumber(info[2])

	if cfg then
		uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.icon))
	end

	if self._curRewards.finished then
		iconImg.color = Color.black
		iconBgImg.color = Color.black
	else
		iconImg.color = Color.white
		iconBgImg.color = Color.white
	end

	return cell
end

function TaskView:_clearTaskViewButtons(cell)
	local button = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Button")

	button:RemoveClickListener()
end

function TaskView:_clearTaskStepViewButtons(cell)
	return
end

function TaskView:_clearTaskRewardViewButtons(cell)
	return
end

return TaskView
