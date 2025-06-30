-- chunkname: @IQIGame\\UI\\TaskSystem\\TaskSystemCell.lua

local TaskSystemCell = {
	AwardCellList = {}
}

function TaskSystemCell.New(go, mainView)
	local o = Clone(TaskSystemCell)

	o:Initialize(go, mainView)

	return o
end

function TaskSystemCell:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.previewAwardCellList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TaskSystemCell:InitComponent()
	self.gotoButton = self.Goto:GetComponent("Button")
	self.getButton = self.GetBtn:GetComponent("Button")
	self.getBtnButton = self.GetBtn:GetComponent("Button")
	self.progressText = self._ProgressText:GetComponent("Text")
	self.progressAllText = self._ProgressAllText:GetComponent("Text")
	self.progressIconImage = self.ProgressIcon:GetComponent("Image")
	self.awardScrollAreaList = self._AwardScrollAreaList:GetComponent("ScrollAreaList")

	function self.awardScrollAreaList.onRenderCell(gridCell)
		self:OnRenderGridCell(gridCell)
	end
end

function TaskSystemCell:InitDelegate()
	function self.OnClick_Goto()
		self:OnClickGoto()
	end

	function self.OnClick_Finish()
		self:OnClickFinish()
	end
end

function TaskSystemCell:AddListener()
	self.gotoButton.onClick:AddListener(self.OnClick_Goto)
	self.getButton.onClick:AddListener(self.OnClick_Finish)
end

function TaskSystemCell:RemoveListener()
	self.gotoButton.onClick:RemoveListener(self.OnClick_Goto)
	self.getButton.onClick:RemoveListener(self.OnClick_Finish)
end

function TaskSystemCell:OnClickGoto()
	JumpModule.Jump(self.data.BaseData.JumpType)
end

function TaskSystemCell:OnClickFinish()
	local cids = {}

	table.insert(cids, self.data.cid)
	TaskSystemModule.SubmitTask(cids)
end

function TaskSystemCell:Refresh(data)
	self.data = data
	self.progressText.text = data.schedule
	self.progressAllText.text = data.needSchedule
	self.progressIconImage.fillAmount = data.schedule / data.needSchedule

	LuaUtility.SetText(self.taskDescription, self.data.BaseData.Desc)

	if self.missionImg ~= nil then
		LuaUtility.SetImageColorWithGameObject(self.missionImg, 0, 0, 0, 1)
	end

	LuaUtility.SetGameObjectShow(self.ProgressdesIcon, self.data.BaseData.Schedule == 0)
	LuaUtility.SetGameObjectShow(self.ScheduleParent, true)
	LuaUtility.SetGameObjectShow(self.ScheduleEnd, false)
	LuaUtility.SetGameObjectShow(self.NoFinishbg, true)

	if data.status == Constant.TaskStatus.doing then
		if self.data.isAllowJump == false then
			LuaUtility.SetGameObjectShow(self.Goto, data.status == Constant.TaskStatus.doing)
			LuaUtility.SetGameObjectShow(self.GetBtn, false)
		else
			LuaUtility.SetGameObjectShow(self.Goto, false)

			self.getBtnButton.interactable = false

			LuaUtility.SetGameObjectShow(self.GetBtn, false)
		end
	end

	if data.status == Constant.TaskStatus.hasDone then
		LuaUtility.SetGameObjectShow(self.Goto, false)

		self.getBtnButton.interactable = true

		LuaUtility.SetGameObjectShow(self.GetBtn, true)
		LuaUtility.SetText(self.taskDescription, self.data.BaseData.Desc)

		if self.missionImg ~= nil then
			LuaUtility.SetImageColorWithGameObject(self.missionImg, 1, 1, 1, 1)
		end

		LuaUtility.SetGameObjectShow(self.NoFinishbg, false)
	end

	if data.status == Constant.TaskStatus.hadGot then
		LuaUtility.SetGameObjectShow(self.Goto, false)

		self.getBtnButton.interactable = false

		LuaUtility.SetGameObjectShow(self.GetBtn, false)
	end

	LuaUtility.SetGameObjectShow(self.Finish, data.status == Constant.TaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.IsFinishbg, data.status == Constant.TaskStatus.hadGot)
	self:RefreshPreviewAwardDataByScroll()
end

function TaskSystemCell:SetGameObjectWithColor(gameObject, colorFormat, text)
	if colorFormat then
		text = string.format(colorFormat, text)
	end

	LuaUtility.SetText(gameObject, text)
end

function TaskSystemCell:RefreshPreviewAwardDataByScroll()
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

function TaskSystemCell:OnRenderGridCell(gridCellData)
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

function TaskSystemCell:OnDestroy()
	self.sortPreviewAwardDataList = nil

	if self.previewAwardCellList ~= nil then
		for insID, _ in pairs(self.previewAwardCellList) do
			self.previewAwardCellList[insID]:Dispose()

			self.previewAwardCellList[insID] = nil
		end
	end

	self.previewAwardCellList = nil

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)
end

return TaskSystemCell
