-- chunkname: @IQIGame\\UI\\TaskSystem\\TaskDayCell.lua

TaskDayCell = {}

function TaskDayCell.New(go, mainView)
	local o = Clone(TaskDayCell)

	o:Initialize(go, mainView)

	return o
end

function TaskDayCell:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.previewAwardCellList = {}

	self:InitDelegation()
	self:InitComponent()
	self:AddListener()
end

function TaskDayCell:InitComponent()
	self.gotoButton = self.Goto:GetComponent("Button")
	self.getButton = self.GetBtn:GetComponent("Button")
	self.taskDesText = self.TaskDes:GetComponent("Text")
	self.progressText = self._ProgressText:GetComponent("Text")
	self.progressAllText = self._ProgressAllText:GetComponent("Text")
	self.progressIconImage = self.ProgressIcon:GetComponent("Image")
	self.getBtnButton = self.GetBtn:GetComponent("Button")
	self.awardScrollAreaList = self._AwardScroll:GetComponent("ScrollAreaList")

	function self.awardScrollAreaList.onRenderCell(gridCell)
		self:OnRenderGridCell(gridCell)
	end
end

function TaskDayCell:InitDelegation()
	function self.OnGotoClicked(_self, go)
		self:OnClickGoto(_self, go)
	end

	function self.OnFinishClicked(_self, go)
		self:OnClickFinish(_self, go)
	end
end

function TaskDayCell:AddListener()
	self.gotoButton.onClick:AddListener(self.OnGotoClicked)
	self.getButton.onClick:AddListener(self.OnFinishClicked)
end

function TaskDayCell:RemoveListener()
	self.gotoButton.onClick:RemoveListener(self.OnGotoClicked)
	self.getButton.onClick:RemoveListener(self.OnFinishClicked)
end

function TaskDayCell:OnDestroy()
	self:RemoveListener()
end

function TaskDayCell:OnClickGoto()
	JumpModule.Jump(self.data.BaseData.JumpType)
end

function TaskDayCell:OnClickFinish()
	TaskSystemModule.SubmitTask({
		self.data.cid
	})
end

function TaskDayCell:Refresh(data)
	self.data = data

	UGUIUtil.SetText(self.TaskDes, data.BaseData.Desc)
	LuaUtility.SetImageColorWithGameObject(self.missionImg, 0, 0, 0, 1)
	LuaUtility.SetGameObjectShow(self.NoFinishbg, true)

	self.progressText.text = data.schedule
	self.progressAllText.text = data.needSchedule
	self.progressIconImage.fillAmount = data.schedule / data.needSchedule

	local activeAwardNum = self.data.BaseData.ActionParam[2]

	UGUIUtil.SetText(self.ActivePointNum, activeAwardNum)
	LuaUtility.SetGameObjectShow(self.ProgressdesIcon, self.data.BaseData.Schedule == 0)
	LuaUtility.SetGameObjectShow(self.ScheduleParent, true)
	LuaUtility.SetGameObjectShow(self.ScheduleEnd, false)

	if data.status == Constant.TaskStatus.doing then
		if self.data.isAllowJump == false then
			LuaUtility.SetGameObjectShow(self.Goto, true)
			LuaUtility.SetGameObjectShow(self.GetBtn, false)
		else
			self.Goto:SetActive(false)

			self.getBtnButton.interactable = false
		end
	end

	if data.status == Constant.TaskStatus.hasDone then
		self.Goto:SetActive(false)

		self.getBtnButton.interactable = true

		self.GetBtn:SetActive(true)
		UGUIUtil.SetText(self.TaskDes, data.BaseData.Desc)
		LuaUtility.SetImageColorWithGameObject(self.missionImg, 1, 1, 1, 1)
		LuaUtility.SetGameObjectShow(self.NoFinishbg, false)
	end

	if data.status == Constant.TaskStatus.hadGot then
		self.Goto:SetActive(false)
		self.GetBtn:SetActive(false)
	end

	self.Finish:SetActive(data.status == 2)
	self.IsFinishbg:SetActive(data.status == 3)
	self:RefreshPreviewAwardData()
end

function TaskDayCell:RefreshPreviewAwardData()
	local actionParam = UIUtil.GetConfigArr(self.data.BaseData.ActionParam)
	local actionParamLength = #actionParam

	self.sortPreviewAwardDataList = {}

	for i = 1, actionParamLength do
		self.sortPreviewAwardDataList[i] = {
			ActionParam = actionParam[i],
			ItemData = ItemData.CreateByCIDAndNumber(actionParam[i][1], actionParam[i][2])
		}
	end

	self.awardScrollAreaList:Refresh(actionParamLength)

	self.awardScrollAreaList.enableDrag = actionParamLength >= 3 and true or false
end

function TaskDayCell:OnRenderGridCell(gridCellData)
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

function TaskDayCell:OnDestroy()
	self.gotoButton.onClick:RemoveListener(self.OnGotoClicked)
	self.getButton.onClick:RemoveListener(self.OnFinishClicked)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.previewAwardCellList = nil

	AssetUtil.UnloadAsset(self)
end

return TaskDayCell
