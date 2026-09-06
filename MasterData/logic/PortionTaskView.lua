-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/diamondtask/view/PortionTaskView.lua

module("logic.extensions.diamondtask.view.PortionTaskView", package.seeall)

local PortionTaskView = class("PortionTaskView")

function PortionTaskView:ctor(view)
	self._view = view
end

function PortionTaskView:buildUI(mainGO)
	self.mainGO = mainGO
	self._taskEmpty = goutil.findChild(self.mainGO, "TaskEmpty")

	self:_initMainTaskview()
	self:_initBranchTaskview()
end

function PortionTaskView:_initMainTaskview()
	self._mainTask = goutil.findChild(self.mainGO, "MainTask")
	self._taskBg = goutil.findChild(self.mainGO, "Bg")
	self._cityIcon = goutil.findChild(self.mainGO, "Bg/cityIcon")
	self._mainTaskStepName = goutil.findChildTextComponent(self.mainGO, "MainTask/DescNode/MainTaskDesc")
	self._mainStepDesc = goutil.findChildTextComponent(self.mainGO, "MainTask/DescNode/MainTaskDesc2")
	self._mainTaskTargetNode = goutil.findChildTextComponent(self.mainGO, "MainTask/DescNode/TargetNode")
	self._mainTaskTargets = goutil.findChildTextComponent(self.mainGO, "MainTask/DescNode/TargetNode/Target")
	self._mainTaskBonuesView = goutil.findChild(self.mainGO, "MainTask/BonuesNode/BonusView"):GetComponent("UITableviewForLua")
	self._mainTaskChapter = goutil.findChildTextComponent(self.mainGO, "MainTask/MainTaskNum")
	self._mainTaskChapterName = goutil.findChildTextComponent(self.mainGO, "MainTask/MainTaskTitle")
	self._mainTaskCityName = goutil.findChildTextComponent(self.mainGO, "MainTask/MainTaskCity")
	self._descNode = goutil.findChild(self.mainGO, "MainTask/DescNode")
	self._bonuesNode = goutil.findChild(self.mainGO, "MainTask/BonuesNode")
	self._bonuesItem = goutil.findChild(self.mainGO, "MainTask/BonuesNode/BonueItem")
	self._mainTaskBonus = goutil.findChildTextComponent(self.mainGO, "MainTask/BonuesNode/Bonus")

	self._bonuesItem:SetActive(false)

	local mainTaskGoto = goutil.findChild(self.mainGO, "MainTask/GotoButton")
	local mainTaskRecv = goutil.findChild(self.mainGO, "MainTask/RecvButton")
	local mainTaskCompelete = goutil.findChild(self.mainGO, "MainTask/CompeleteButton")
	local mainTaskGotoTxt = goutil.findChildTextComponent(self.mainGO, "MainTask/GotoButton/Text")
	local mainTaskRecvTxt = goutil.findChildTextComponent(self.mainGO, "MainTask/RecvButton/Text")
	local mainTaskCompeleteTxt = goutil.findChildTextComponent(self.mainGO, "MainTask/CompeleteButton/Text")

	mainTaskGotoTxt.text = lang("goto")
	mainTaskRecvTxt.text = lang("spriteladder_get")
	mainTaskCompeleteTxt.text = lang("finish")
	self._mainTaskGoto = Framework.ButtonAdapter.Get(mainTaskGoto)
	self._mainTaskRecv = Framework.ButtonAdapter.Get(mainTaskRecv)
	self._mainTaskCompelete = Framework.ButtonAdapter.Get(mainTaskCompelete)
end

function PortionTaskView:_initBranchTaskview()
	self._branchTask = goutil.findChild(self.mainGO, "BranchTask")
	self._branchItemItem = goutil.findChild(self.mainGO, "BranchTask/BranchItem")

	self._branchItemItem:SetActive(false)

	self._mainTaskBranchsView = goutil.findChild(self.mainGO, "BranchTask/ScrollView"):GetComponent("UITableviewForLua")
end

function PortionTaskView:onEnter()
	self._mainTaskGoto:AddClickListener(self._onclickMainTaskGoto, self)
	self._mainTaskRecv:AddClickListener(self._onclickMainTaskGoto, self)
	self._mainTaskCompelete:AddClickListener(self._onclickMainTaskGoto, self)
	self._mainTaskBonuesView:RegisterCallback(self._numBonueItemsInView, self._taskBonueCellSizeInView, self._taskIBonueCellAtIndex, self)
	self._mainTaskBranchsView:RegisterCallback(self._numBranchTaskesIInView, self._branchTaskeCellSizeInView, self._branchTaskeCellAtIndex, self)
end

function PortionTaskView:_changeBtnState(taskStep, gotoBtn, compeleteBtn, recvBtn)
	if taskStep:isCompeleted() then
		gotoBtn.gameObject:SetActive(false)

		if taskStep:hasStepBonus() then
			recvBtn.gameObject:SetActive(true)
			compeleteBtn.gameObject:SetActive(false)
		else
			recvBtn.gameObject:SetActive(false)
			compeleteBtn.gameObject:SetActive(true)
		end
	else
		gotoBtn.gameObject:SetActive(true)
		compeleteBtn.gameObject:SetActive(false)
		recvBtn.gameObject:SetActive(false)
	end
end

function PortionTaskView:onExit()
	self._currBranchTaskes = nil
	self._currTaskType = nil
	self._mainTaskBonues = nil
	self._currMainTask = nil

	self._mainTaskGoto:RemoveClickListener()
	self._mainTaskRecv:RemoveClickListener()
	self._mainTaskCompelete:RemoveClickListener()
	self._mainTaskBranchsView:Travel(self._clearBranchTaskBranchsView, self, true)
	self._mainTaskBonuesView:Travel(self._clearMainBonusView, self, true)
	self._mainTaskBonuesView:UnRegisterAllCallbacks()
	self._mainTaskBranchsView:UnRegisterAllCallbacks()

	local img = Framework.ImageBigBG.Get(self._cityIcon)

	if img then
		img:ClearImage()
	end
end

function PortionTaskView:showTask(taskType)
	self._currTaskType = taskType

	if taskType == GameEnum.TaskType.Main then
		self:_showMainTask()
	else
		self:_showBranchTask()
	end
end

function PortionTaskView:setActive(active)
	self.mainGO:SetActive(active)
end

function PortionTaskView:_showMainTask()
	self._currBranchTaskes = nil

	self._mainTask:SetActive(true)
	self._branchTask:SetActive(false)
	self._mainTaskGoto.gameObject:SetActive(true)

	local taskes = TaskModel.instance:getCurrentTriggerTaskesByType(self._currTaskType)

	if taskes and #taskes > 0 then
		self._currMainTask = taskes[1]

		self:_fillMainTask(self._currMainTask)
	else
		self._currMainTask = nil

		self:_onMainTaskEmpty()
	end
end

function PortionTaskView:_onMainTaskEmpty()
	self._descNode:SetActive(false)
	self._taskBg:SetActive(false)
	self._bonuesNode:SetActive(false)
	self._taskEmpty:SetActive(true)
	self._mainTaskCompelete.gameObject:SetActive(false)
	self._mainTaskRecv.gameObject:SetActive(false)
	self._mainTaskGoto.gameObject:SetActive(false)
	self._mainTaskChapter.gameObject:SetActive(false)
	self._mainTaskChapterName.gameObject:SetActive(false)
	self._mainTaskCityName.gameObject:SetActive(false)
end

function PortionTaskView:_fillMainTask(taskStep)
	self._taskBg:SetActive(true)
	self._descNode:SetActive(true)
	self._taskEmpty:SetActive(false)
	self._mainTaskChapter.gameObject:SetActive(true)
	self._mainTaskChapterName.gameObject:SetActive(true)
	self._mainTaskCityName.gameObject:SetActive(true)

	local chapterId = taskStep.task.taskCo.chapterId
	local chapter = TaskConfig.instance:getChapterCo(chapterId)
	local chapterTitle

	self._mainTaskChapter.text = chapterId == 1 and lang("ui_story_xuzhang") or string.format("第%s章", GameUtil.getChineseNumber(chapterId - 1))
	self._mainTaskChapterName.text = chapter.name
	self._mainTaskBonus.text = "任务奖励"
	self._mainTaskStepName.text = taskStep.task.taskCo.name
	self._mainStepDesc.text = taskStep:getStepDesc()

	self:_fillMainTaskTargets(taskStep)
	self:_fillMainBonus(taskStep)
	self:_changeBtnState(taskStep, self._mainTaskGoto, self._mainTaskCompelete, self._mainTaskRecv)

	self._mainTaskCityName.text = chapter.sceneName

	GameUtil.SetActive(self._cityIcon, false)

	if not string.nilorempty(chapter.iconName) then
		GameUtil.SetActive(self._cityIcon, true)
		uGuiUtil.setSpriteToImage(self._cityIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getTaskUrl(chapter.iconName))
	end
end

function PortionTaskView:_fillMainTaskTargets(taskStep)
	local cnt = 0

	if taskStep.targets then
		cnt = #taskStep.targets
	end

	if cnt == 0 then
		self._mainTaskTargetNode.gameObject:SetActive(false)

		return
	end

	local targetsDesc = {}

	for i = 1, cnt do
		local target = taskStep.targets[i]
		local targetNum = target:getTargetNum()

		if target:isCompeleted() then
			table.insert(targetsDesc, "<color=#DA2EFF>·" .. target:getDesc() .. "(" .. targetNum .. "/" .. targetNum .. ")" .. "</color>")
		else
			table.insert(targetsDesc, "<color=#7F84A3>·" .. target:getDesc() .. "(" .. target:getProgress() .. "/" .. targetNum .. ")" .. "</color>")
		end

		if i ~= cnt then
			table.insert(targetsDesc, "\n")
		end
	end

	self._mainTaskTargetNode.gameObject:SetActive(true)

	self._mainTaskTargets.text = "<color=#da2eff>" .. table.concat(targetsDesc) .. "</color>"
end

function PortionTaskView:_fillMainBonus(taskStep)
	local rwd, bonusType = taskStep.task:getBonus()

	self._mainTaskBonues = TaskFacade.instance:parseTaskBonus(rwd, bonusType)

	self._mainTaskBonuesView:SetOffsetWithoutRefresh(0)
	self._mainTaskBonuesView:ReloadData()
end

function PortionTaskView:_fillTaskStepBonus(taskStep, layout, showLast)
	local rwd, bonusType = taskStep.task:getBonus()
	local items = TaskFacade.instance:parseTaskBonus(rwd, bonusType)

	self:_fillTaskStepBonusWithItems(items, layout)
end

function PortionTaskView:_fillTaskStepBonusWithItems(items, layout)
	local itemCnt = 0

	if items then
		itemCnt = #items
	end

	local nodeCnt = layout.transform.childCount

	while nodeCnt < itemCnt do
		local go = UnityEngine.GameObject.New()

		go.transform:SetParent(layout.transform)
		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)

		nodeCnt = nodeCnt + 1
	end

	local num = 1

	for i = 1, itemCnt do
		local go = layout.transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local itemGo = MaterialMgr.setCellByCfg(items[i], go)

		num = num + 1
	end

	for i = num, nodeCnt do
		local go = layout.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
		go:SetActive(false)
	end

	layout:Layout()
end

function PortionTaskView:_showBranchTask()
	self._currMainTask = nil
	self._mainTaskBonues = nil
	self._currBranchTaskes = TaskModel.instance:getCurrentTriggerTaskesByType(self._currTaskType)

	self._mainTask:SetActive(false)
	self._branchTask:SetActive(true)
	self._mainTaskBranchsView:SetOffsetWithoutRefresh(0)
	self._mainTaskBranchsView:ReloadData()
	self._taskBg:SetActive(false)

	if not self._currBranchTaskes or #self._currBranchTaskes == 0 then
		self._taskEmpty:SetActive(true)
	else
		self._taskEmpty:SetActive(false)
	end
end

function PortionTaskView:_numBonueItemsInView()
	if self._mainTaskBonues then
		return #self._mainTaskBonues
	end

	return 0
end

function PortionTaskView:_taskBonueCellSizeInView()
	return 98, 98
end

function PortionTaskView:_taskIBonueCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._bonuesItem)

	local itemGo = MaterialMgr.setCellByCfg(self._mainTaskBonues[idx + 1], cell)

	return cell
end

function PortionTaskView:_numBranchTaskesIInView()
	if not self._currBranchTaskes then
		return 0
	end

	return #self._currBranchTaskes
end

function PortionTaskView:_branchTaskeCellSizeInView()
	return 1031, 157
end

function PortionTaskView:_branchTaskeCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._branchItemItem)

	local taskStep = self._currBranchTaskes[idx + 1]
	local imgDouble = goutil.findChild(cell.gameObject, "ImgDouble")
	local taskName = goutil.findChildTextComponent(cell.gameObject, "TaskName")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "TxtDesc")
	local txtInstruction = goutil.findChildTextComponent(cell.gameObject, "TxtInstruction")
	local progress = goutil.findChildTextComponent(cell.gameObject, "Progress")

	imgDouble:SetActive(false)

	taskName.text = taskStep:getStepName()
	txtDesc.text = taskStep:getStepDesc()

	local tgts = taskStep.targets
	local tgt, lastTgt

	for i = 1, (tgts or nil) and #tgts do
		local target = taskStep.targets[i]

		lastTgt = target

		if not target:isCompeleted() then
			tgt = target

			break
		end
	end

	tgt = tgt or lastTgt

	if tgt then
		txtInstruction.text = tgt:getDesc()
		progress.text = tgt:getProgress() .. "/" .. tgt:getTargetNum()
	else
		progress.text = ""
		txtInstruction.text = ""
	end

	self:_fillBranchCellState(cell, taskStep)
	self:_fillBranchBonus(cell, taskStep)

	return cell
end

function PortionTaskView:_fillBranchCellState(cell, taskStep)
	local imgFinished = goutil.findChild(cell.gameObject, "ImgFinished")
	local reveive = goutil.findChild(cell.gameObject, "Reveive")
	local gotoBtn = goutil.findChild(cell.gameObject, "Goto")
	local compeleteBtn = goutil.findChild(cell.gameObject, "Compelete")

	goutil.findChild(cell, "Goto/Text"):GetComponent("Text").text = lang("jump_to")
	goutil.findChild(cell, "Reveive/Text"):GetComponent("Text").text = lang("spriteladder_get")
	goutil.findChild(cell, "Compelete/Text"):GetComponent("Text").text = lang("finish")

	if taskStep:isCompeleted() then
		imgFinished:SetActive(false)
		reveive:SetActive(true)
		gotoBtn:SetActive(false)

		local btnAdapter = Framework.ButtonAdapter.Get(reveive)

		btnAdapter:AddClickListener(function()
			UIStateManager.instance:clear(true)
			TaskController.instance:foreceClearState()
			TaskController.instance:startAutoAction(taskStep)
		end)

		local btnCmopAdapter = Framework.ButtonAdapter.Get(compeleteBtn)

		btnCmopAdapter:AddClickListener(function()
			UIStateManager.instance:clear(true)
			TaskController.instance:foreceClearState()
			TaskController.instance:startAutoAction(taskStep)
		end)
	else
		imgFinished:SetActive(false)
		reveive:SetActive(false)
		gotoBtn:SetActive(true)

		local btnAdapter = Framework.ButtonAdapter.Get(gotoBtn)

		btnAdapter:AddClickListener(function()
			UIStateManager.instance:clear(true)
			TaskController.instance:foreceClearState()
			TaskController.instance:startAutoAction(taskStep)
		end)
	end

	self:_changeBtnState(taskStep, gotoBtn, compeleteBtn, reveive)

	return cell
end

function PortionTaskView:_fillBranchBonus(cell, taskStep)
	local layout = goutil.findChild(cell.gameObject, "Items"):GetComponent("UILayoutSingleLine")

	self:_fillTaskStepBonus(taskStep, layout, true)
end

function PortionTaskView:_clearBranchTaskBranchsView(cell)
	local buttonReveive = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Reveive")
	local buttonGoto = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Goto")
	local buttonCompelete = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Compelete")
	local layout = goutil.findChild(cell.gameObject, "Items")

	buttonReveive:RemoveClickListener()
	buttonGoto:RemoveClickListener()
	buttonCompelete:RemoveClickListener()

	local nodeCnt = layout.transform.childCount

	for i = 1, nodeCnt do
		local go = layout.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
	end
end

function PortionTaskView:_clearMainBonusView(cell)
	MaterialMgr.resetAll(cell)
end

function PortionTaskView:_onclickMainTaskGoto()
	if self._currMainTask then
		local taskStep = self._currMainTask

		UIStateManager.instance:clear(true)
		TaskController.instance:foreceClearState()
		TaskController.instance:startAutoAction(taskStep)
	end
end

return PortionTaskView
