-- chunkname: @IQIGame\\UI\\TaskSystem\\TaskSystemUI_achievementPanel_TaskItem.lua

local TaskSystemUI_achievementPanel_TaskItem = {}

function TaskSystemUI_achievementPanel_TaskItem.New(go, mainView)
	local o = Clone(TaskSystemUI_achievementPanel_TaskItem)

	o:Initialize(go, mainView)

	return o
end

function TaskSystemUI_achievementPanel_TaskItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.previewAwardCellList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TaskSystemUI_achievementPanel_TaskItem:InitComponent()
	self.awardScrollAreaList = self._AwardScroll:GetComponent("ScrollAreaList")

	function self.awardScrollAreaList.onRenderCell(gridCell)
		self:OnRenderGridCell(gridCell)
	end
end

function TaskSystemUI_achievementPanel_TaskItem:InitDelegate()
	function self.OnClick_Goto()
		self:OnClickGoto()
	end

	function self.OnClick_Finish()
		self:OnClickFinish()
	end
end

function TaskSystemUI_achievementPanel_TaskItem:AddListener()
	self.Goto:GetComponent("Button").onClick:AddListener(self.OnClick_Goto)
	self.GetBtn:GetComponent("Button").onClick:AddListener(self.OnClick_Finish)
end

function TaskSystemUI_achievementPanel_TaskItem:RemoveListener()
	return
end

function TaskSystemUI_achievementPanel_TaskItem:OnClickGoto()
	JumpModule.Jump(self.data.BaseData.JumpType)
end

function TaskSystemUI_achievementPanel_TaskItem:GetAllClaimableTaskIds()
	local claimableTaskIds = {}

	if self.mainView and self.mainView.taskDataArray then
		for _, task in ipairs(self.mainView.taskDataArray) do
			if task.status == Constant.TaskStatus.hasDone then
				table.insert(claimableTaskIds, task.cid)
			end
		end
	end

	return claimableTaskIds
end

function TaskSystemUI_achievementPanel_TaskItem:OnClickFinish()
	local allClaimableTaskIds = self:GetAllClaimableTaskIds()

	if #allClaimableTaskIds > 0 then
		TaskSystemModule.SubmitTask(allClaimableTaskIds)
	end
end

function TaskSystemUI_achievementPanel_TaskItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function TaskSystemUI_achievementPanel_TaskItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function TaskSystemUI_achievementPanel_TaskItem:Refresh(Data)
	self.data = Data

	local cfgTask = CfgUtil.GetTaskCfgWithID(self.data.cid)

	LuaUtility.SetText(self.TaskDes, cfgTask.Desc)
	LuaUtility.SetText(self.ProgressCur, self.data.schedule)
	LuaUtility.SetText(self.ProgressAll, cfgTask.NeedSchedule)
	LuaUtility.SetGameObjectShow(self.Goto, self.data.status == Constant.TaskStatus.doing and self.data.BaseData.JumpType ~= 0)
	LuaUtility.SetGameObjectShow(self.GetBtn, self.data.status == Constant.TaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.NoFinishbg, self.data.status == Constant.TaskStatus.doing)
	LuaUtility.SetGameObjectShow(self.Finish, self.data.status == Constant.TaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.IsFinishbg, self.data.status == Constant.TaskStatus.hadGot)
	self:RefreshPreviewAwardDataByScroll()
end

function TaskSystemUI_achievementPanel_TaskItem:OnRenderGridCell(gridCellData)
	local data = self.sortPreviewAwardDataList[gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.previewAwardCellList[insID]

	if cell == nil then
		cell = ExtendItemCellOne.New(gridCellData.gameObject)
		self.previewAwardCellList[insID] = cell
	end

	cell:SetAwardData(data.ItemData, data.ActionParam[2])

	gridCellData.gameObject.name = "Item" .. gridCellData.index + 1
end

function TaskSystemUI_achievementPanel_TaskItem:RefreshPreviewAwardDataByScroll()
	local actionParam = UIUtil.GetConfigArr(self.data.BaseData.ActionParam)
	local actionParamLength = #actionParam

	self.sortPreviewAwardDataList = {}

	for i = 1, actionParamLength do
		self.sortPreviewAwardDataList[i] = {
			ActionParam = actionParam[i],
			ItemData = ItemData.CreateByCIDAndNumber(actionParam[i][1], actionParam[i][2])
		}
	end

	table.sort(self.sortPreviewAwardDataList, function(a, b)
		local acfg = a.ItemData:GetCfg()
		local bcfg = b.ItemData:GetCfg()

		if acfg.Quality ~= bcfg.Quality then
			return acfg.Quality > bcfg.Quality
		end

		return acfg.Id < bcfg.Id
	end)
	self.awardScrollAreaList:Refresh(actionParamLength)

	self.awardScrollAreaList.enableDrag = actionParamLength >= 3 and true or false
end

function TaskSystemUI_achievementPanel_TaskItem:OnDestroy()
	self.awardScrollAreaList = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return TaskSystemUI_achievementPanel_TaskItem
