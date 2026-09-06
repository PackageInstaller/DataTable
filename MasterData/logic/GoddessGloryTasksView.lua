-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddessGloryTasksView.lua

module("logic.extensions.goddessglory.view.GoddessGloryTasksView", package.seeall)

local GoddessGloryTasksView = class("GoddessGloryTasksView", ViewComponent)

function GoddessGloryTasksView:buildUI()
	GoddessGloryTasksView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._tableviewType = self:getGo("tabview"):GetComponent(ComponentType.UITableview)
	self._tableCellType = self:getGo("btnCell")

	self._tableCellType:SetActive(false)

	self._tableview = self:getGo("tableview"):GetComponent(ComponentType.UITableview)
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._reward = self:getGo("reward")
	self._rewardItem = self:getGo("reward/item")
	self._rewardNum = self:getTxt("reward/txtNum")
end

function GoddessGloryTasksView:bindEvents()
	GoddessGloryTasksView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTips, self)
	self._tableviewType:RegisterCallback(self._numTaskTypesInView, nil, self._taskTypeCellAtIndex, self)
	self._tableview:RegisterCallback(self._numTasksInView, nil, self._taskCellAtIndex, self)
end

function GoddessGloryTasksView:unbindEvents()
	GoddessGloryTasksView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
	self._tableviewType:UnRegisterAllCallbacks()
end

function GoddessGloryTasksView:onEnter()
	GoddessGloryTasksView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnGoddeddGloryGainWeeklyTaskPrize, self._onGoddeddGloryGainWeeklyTaskPrize, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGoddeddGloryGainTaskPrize, self._onGoddeddGloryGainTaskPrize, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._onMatChange, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGoddeddGloryTasks, self._onGoddeddGloryTasks, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGoddeddGloryWeeklyTasks, self._onGoddeddGloryWeeklyTasks, self)

	local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()

	self._challengeMO = GoddessGloryModel.instance:getGoddessGlory(challengeId)
	self._curStageId = 0
	self._challengeId = challengeId

	self._tableviewType:SetOffsetWithoutRefresh(0)

	self._stagesData = {}

	if self._challengeMO then
		for k, v in pairs(self._challengeMO.stages) do
			table.insert(self._stagesData, v)
		end

		table.sort(self._stagesData, function(x, y)
			return x.stageId < y.stageId
		end)
	end

	if self._stagesData and self._stagesData[1] then
		self:_selectStage(self._stagesData[1].stageId)
	else
		self:_selectStage(0)
	end

	self:_updateRewardsNode()
end

function GoddessGloryTasksView:onExit()
	GoddessGloryTasksView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGoddeddGloryGainWeeklyTaskPrize, self._onGoddeddGloryGainWeeklyTaskPrize, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGoddeddGloryWeeklyTasks, self._onGoddeddGloryWeeklyTasks, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._onMatChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGoddeddGloryTasks, self._onGoddeddGloryTasks, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGoddeddGloryGainTaskPrize, self._onGoddeddGloryGainTaskPrize, self)

	self._challengeMO = nil
	self._stagesData = nil
	self._curStageId = nil
	self._challengeId = nil
	self._tasksDataList = nil

	MaterialMgr.clearIcon(self._rewardItem)
	self._tableviewType:Travel(function(cell)
		local btn = Framework.ButtonAdapter.Get(cell.gameObject)

		btn:RemoveClickListener()
	end, nil)
	self._tableview:Travel(function(cell)
		local btnReceive = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnReceive")
		local btnGoto = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGoto")
		local items = goutil.findChild(cell.gameObject, "items")

		btnReceive:RemoveClickListener()
		btnGoto:RemoveClickListener()

		local nodeCnt = items.transform.childCount

		for i = 1, nodeCnt do
			local go = items.transform:GetChild(i - 1).gameObject

			MaterialMgr.resetAll(go)
		end
	end, nil)
end

function GoddessGloryTasksView:_selectStage(stageId)
	if self._curStageId == stageId then
		return
	end

	self._curStageId = stageId

	self._tableviewType:ReloadData()
	self._tableview:SetOffsetWithoutRefresh(0)
	self:_refreshTaskView(self._curStageId > #self._stagesData)
end

function GoddessGloryTasksView:_refreshTaskView(isWeekly)
	self._tasksDataList = nil

	if not isWeekly then
		local stageMo = GoddessGloryModel.instance:getGoddessGloryStage(self._challengeId, self._curStageId)

		if not stageMo.tasks then
			GoddessGloryController.instance:requestGoddessGloryTaskInfo(self._challengeId, self._curStageId)
		else
			self._tasksDataList = table.values(stageMo.tasks)

			table.sort(self._tasksDataList, function(x, y)
				if x == y then
					return false
				end

				local xGained = x:hasGainPrize(x.taskId)
				local yGained = y:hasGainPrize(y.taskId)

				if xGained and not yGained then
					return false
				end

				if not xGained and yGained then
					return true
				end

				local taskCoX = GoddessGloryConfig.instance:getTaskCo(x.taskPlanId, x.type, x.taskId)
				local taskCoY = GoddessGloryConfig.instance:getTaskCo(y.taskPlanId, y.type, y.taskId)
				local xCanGained = x.progress >= taskCoX.maxProgress
				local yCanGained = y.progress >= taskCoY.maxProgress

				if xCanGained and not yCanGained then
					return true
				end

				if not xCanGained and yCanGained then
					return false
				end

				return x.type < y.type
			end)
			self:_autoRequestTaskInfos()
		end
	elseif self._challengeMO.weeklyTasks then
		self._tasksDataList = table.values(self._challengeMO.weeklyTasks)

		table.sort(self._tasksDataList, function(x, y)
			if x == y then
				return false
			end

			local xGained = x:hasGainPrize(x.taskId)
			local yGained = y:hasGainPrize(y.taskId)

			if xGained and not yGained then
				return false
			end

			if not xGained and yGained then
				return true
			end

			local taskCoX = GoddessGloryConfig.instance:getWeeklyTaskCo(x.challengeId, x.type, x.taskId)
			local taskCoY = GoddessGloryConfig.instance:getWeeklyTaskCo(y.challengeId, y.type, y.taskId)
			local xCanGained = x.progress >= taskCoX.maxProgress
			local yCanGained = y.progress >= taskCoY.maxProgress

			if xCanGained and not yCanGained then
				return true
			end

			if not xCanGained and yCanGained then
				return false
			end

			return x.type < y.type
		end)
	else
		GoddessGloryController.instance:requestGoddessGloryGetWeeklyTasks(self._challengeId)
	end

	self._tableview:ReloadData()
end

function GoddessGloryTasksView:_updateRewardsNode()
	local item = GoddessGloryModel.instance:getItemMatType()
	local mats = string.split(item, ":")
	local matType = checknumber(mats[1])
	local matId = checknumber(mats[2])

	MaterialMgr.setIcon(self._rewardItem, matType, matId)

	self._rewardNum.text = tostring(MaterialModel.instance:getMaterialsNumber(matType, matId))
end

function GoddessGloryTasksView:_onClickClose()
	self:close()
end

function GoddessGloryTasksView:_onClickTips()
	TipsFacade.instance:openRulesView(GoddessGloryModel.instance:getTipsKey())
end

function GoddessGloryTasksView:_onGoddeddGloryTasks(challengeId, stageId)
	if challengeId == self._challengeId and stageId == self._curStageId then
		self:_refreshTaskView(false)

		return
	end

	self._tableviewType:Refresh()
	self:_autoRequestTaskInfos()
end

function GoddessGloryTasksView:_onGoddeddGloryWeeklyTasks(challengeId)
	if challengeId ~= self._challengeId then
		return
	end

	self._tableviewType:Refresh()

	if self._curStageId > #self._stagesData then
		self:_refreshTaskView(true)
	end
end

function GoddessGloryTasksView:_onGoddeddGloryGainTaskPrize(challengeId, stageId)
	if challengeId == self._challengeId and stageId == self._curStageId then
		self:_refreshTaskView(false)
	end
end

function GoddessGloryTasksView:_onGoddeddGloryGainWeeklyTaskPrize(challengeId)
	if challengeId == self._challengeId and self._curStageId > #self._stagesData then
		self:_refreshTaskView(true)
	end
end

function GoddessGloryTasksView:_autoRequestTaskInfos()
	if not self._stagesData then
		return
	end

	local redPointId = GoddessGloryModel.instance:getTaskRedPointId()

	if not RedPointModel.instance:isActive(redPointId) then
		return
	end

	for i = 1, #self._stagesData do
		local stageData = self._stagesData[i]
		local stageMo = GoddessGloryModel.instance:getGoddessGloryStage(self._challengeId, stageData.stageId)

		if not stageMo.tasks then
			local timeStart = GameUtil.string2time(stageData.startTime)
			local nowTime = ServerTime.now()

			if timeStart < nowTime then
				GoddessGloryController.instance:requestGoddessGloryTaskInfo(self._challengeId, stageData.stageId)

				return
			end
		end
	end

	if not self._challengeMO.weeklyTasks then
		GoddessGloryController.instance:requestGoddessGloryGetWeeklyTasks(self._challengeId)
	end
end

function GoddessGloryTasksView:_onMatChange()
	self:_updateRewardsNode()
end

function GoddessGloryTasksView:_numTaskTypesInView(view)
	if not self._stagesData then
		return 0
	end

	return #self._stagesData + 1
end

function GoddessGloryTasksView:_taskTypeCellAtIndex(view, idx)
	local cell = self._tableviewType:DequeueCell()

	cell = cell or self._tableviewType:AddChild(self._tableCellType)

	local stageData = self._stagesData[idx + 1]

	if not stageData then
		self:_fillWeeklyTasks(cell)
	else
		self:_fillStageTasks(cell, stageData)
	end

	return cell
end

function GoddessGloryTasksView:_fillStageTasks(cell, stageData)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local redPoint = goutil.findChild(cell.gameObject, "redPoint")
	local imgBg = cell:GetComponent(ComponentType.UIImageSpriteChange)
	local txtStage = goutil.findChildTextComponent(cell.gameObject, "Text")
	local txtColor = txtStage:GetComponent(ComponentType.UITextColorChange)

	btn:RemoveClickListener()

	local state = stageData.stageId ~= self._curStageId and 0 or 1

	txtStage.text = stageData.stageName

	imgBg:SetState(state)
	txtColor:SetState(state)
	redPoint:SetActive(stageData.stageId ~= self._curStageId and stageData:hasTaskCompeleted())
	btn:AddClickListener(function()
		local timeStart = GameUtil.string2time(stageData.startTime)
		local nowTime = ServerTime.now()

		if nowTime < timeStart then
			FloatWordMgr.instance:show("当前试炼尚未开启")

			return
		end

		self:_selectStage(stageData.stageId)
	end)
end

function GoddessGloryTasksView:_fillWeeklyTasks(cell)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local redPoint = goutil.findChild(cell.gameObject, "redPoint")
	local imgBg = cell:GetComponent(ComponentType.UIImageSpriteChange)
	local txtStage = goutil.findChildTextComponent(cell.gameObject, "Text")
	local txtColor = txtStage:GetComponent(ComponentType.UITextColorChange)

	btn:RemoveClickListener()

	local state = self._curStageId <= #self._stagesData and 0 or 1

	txtStage.text = "每周任务"

	imgBg:SetState(state)
	txtColor:SetState(state)
	redPoint:SetActive(state == 0 and self._challengeMO:hasTaskCompeleted())
	btn:AddClickListener(function()
		self:_selectStage(#self._stagesData + 1)
	end)
end

function GoddessGloryTasksView:_numTasksInView(view)
	if not self._tasksDataList then
		return 0
	end

	return #self._tasksDataList
end

function GoddessGloryTasksView:_taskCellAtIndex(view, idx)
	local cell = self._tableview:DequeueCell()

	cell = cell or self._tableview:AddChild(self._tableCell)

	local taskCo
	local taskData = self._tasksDataList[idx + 1]
	local isWeekly = self._curStageId > #self._stagesData

	taskCo = isWeekly and GoddessGloryConfig.instance:getWeeklyTaskCo(taskData.challengeId, taskData.type, taskData.taskId) or GoddessGloryConfig.instance:getTaskCo(taskData.taskPlanId, taskData.type, taskData.taskId)

	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")

	txtName.text = taskCo.name
	txtDesc.text = taskCo.desc

	self:_fillTaskStatus(cell, taskData, taskCo, isWeekly)
	self:_fillTaskRewards(cell, taskData, taskCo)

	return cell
end

function GoddessGloryTasksView:_fillTaskStatus(cell, taskData, taskCo, isWeekly)
	local btnReceive = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnReceive")
	local btnGoto = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGoto")
	local receive = goutil.findChild(cell.gameObject, "receive")
	local txtProgress = goutil.findChildTextComponent(cell.gameObject, "txtProgress")

	btnReceive:RemoveClickListener()
	btnGoto:RemoveClickListener()

	if taskData:hasGainPrize(taskData.taskId) then
		btnGoto.gameObject:SetActive(false)
		btnReceive.gameObject:SetActive(false)
		receive:SetActive(true)
		txtProgress.gameObject:SetActive(false)
	else
		receive:SetActive(false)
		txtProgress.gameObject:SetActive(true)

		local currProgress = taskData.progress
		local maxProgress = taskCo.maxProgress

		if maxProgress < currProgress then
			currProgress = maxProgress
		end

		if currProgress >= 100000 then
			currProgress = StringUtil.numberToString(currProgress)
		end

		if maxProgress >= 100000 then
			maxProgress = StringUtil.numberToString(maxProgress)
		end

		txtProgress.text = currProgress .. "/" .. maxProgress

		if taskData.progress < taskCo.maxProgress then
			btnGoto.gameObject:SetActive(true)
			btnReceive.gameObject:SetActive(false)
			btnGoto:AddClickListener(function()
				if isWeekly then
					self:close()
				else
					GoddessGloryController.instance:enterStage(self._challengeId, self._curStageId)
				end
			end)
		else
			btnGoto.gameObject:SetActive(false)
			btnReceive.gameObject:SetActive(true)
			btnReceive:AddClickListener(function()
				if isWeekly then
					GoddessGloryController.instance:requestGoddessGloryGainWeeklyPrize(self._challengeId, taskData.type, taskData.taskId)
				else
					GoddessGloryController.instance:requestGoddessGloryGainPrize(self._challengeId, self._curStageId, taskData.type, taskData.taskId)
				end
			end)
		end
	end
end

function GoddessGloryTasksView:_fillTaskRewards(cell, taskData, taskCo)
	local items = goutil.findChildComponent(cell.gameObject, "items", ComponentType.UILayoutSingleLine)
	local awards = string.split(taskCo.prize, "#")
	local childCount = items.transform.childCount
	local itemNum = #awards

	while childCount < itemNum do
		UGUIToolHelper.AddChild(items.gameObject, items.transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	for i = 1, itemNum do
		local data = awards[i]
		local go = items.transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		MaterialMgr.resetAll(go)
		MaterialMgr.setCellByCfg(data, go)
	end

	for i = itemNum + 1, childCount do
		local go = items.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	items:Layout()
end

return GoddessGloryTasksView
