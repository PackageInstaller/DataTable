-- chunkname: @IQIGame\\UI\\TaskSystem\\TaskTrunkView.lua

local TaskTrunkView = {
	awardCellList = {}
}

function TaskTrunkView.New(go, mainView)
	local o = Clone(TaskTrunkView)

	o:Initialize(go, mainView)

	return o
end

function TaskTrunkView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self:Delegation()

	self.mainView = mainView
	self.getButton = self.GetBtn:GetComponent("Button")
	self.mainIconButton = self.mainIconBtn:GetComponent("Button")

	self.getButton.onClick:AddListener(self.OnAllGetBtnClicked)
	self.mainIconButton.onClick:AddListener(self.OnGotoClicked)
end

function TaskTrunkView:Delegation()
	function self.OnGotoClicked(_self, go)
		self:OnClickGoto(_self, go)
	end

	function self.OnAllGetBtnClicked(_self, go)
		self:OnClickAllGetBtn(_self, go)
	end
end

function TaskTrunkView:InitStaticText()
	return
end

function TaskTrunkView:OnClickGoto()
	if self.Data then
		JumpModule.Jump(self.Data.BaseData.JumpType)
	else
		local taskDataList = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Main, Constant.ExtendTaskType.Main_Main)
		local cfgTaskData = taskDataList[#taskDataList]

		JumpModule.Jump(cfgTaskData.JumpType)
	end
end

function TaskTrunkView:OnClickAllGetBtn()
	local cids = {}

	table.insert(cids, self.Data.cid)
	TaskSystemModule.SubmitTask(cids)
	self.GetBtn:SetActive(false)
end

function TaskTrunkView:ResetStatus()
	LuaUtility.SetGameObjectShow(self.GetBtn, false)
	LuaUtility.SetGameObjectShow(self.mainIconBtn, false)
	LuaUtility.SetGameObjectShow(self.AwardImg, false)
	LuaUtility.SetGameObjectShow(self.ReceivedState, false)
	LuaUtility.SetGameObjectShow(self.endState, false)
	LuaUtility.SetGameObjectShow(self.normalState, true)
	LuaUtility.SetGameObjectShow(self.ContentScroll, true)
end

function TaskTrunkView:Refresh()
	self:ResetStatus()

	local taskDataList = TaskSystemModule.GetSortForTypeDataList(Constant.MainTaskType.Main, Constant.ExtendTaskType.Main_Main)
	local cfgTaskData

	if #taskDataList <= 0 then
		self.Data = nil
	else
		self.Data = taskDataList[1]
		cfgTaskData = TaskSystemModule.GetCfgTaskDataWithID(self.Data.cid)
	end

	if self.Data then
		LuaUtility.SetImageFillAmount(self.trunkProgressIcon, self.Data.schedule / self.Data.needSchedule)
		LuaUtility.SetText(self.textCurrentProgress, self.Data.schedule)
		LuaUtility.SetText(self.textMaxProgress, "/" .. self.Data.needSchedule)
		self:RefreshAwardData(self.Data.BaseData.ActionParam)
		LuaUtility.SetGameObjectShow(self.GetBtn, self.Data.status == Constant.TaskStatus.hasDone)
		LuaUtility.SetGameObjectShow(self.mainIconBtn, self.Data.status == Constant.TaskStatus.doing)
		LuaUtility.SetGameObjectShow(self.AwardImg, self.Data.status == Constant.TaskStatus.hasDone)
		LuaUtility.SetText(self.textAwardDescription, cfgTaskData.Desc)
		LuaUtility.SetText(self.textTitle, cfgTaskData.Name)
		LuaUtility.SetText(self.textTitleEnglish, cfgTaskData.EngName)
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(cfgTaskData.ChapterNum), self.imageTitleNumber:GetComponent("Image"))

		local backGroundPath = TaskUIApi:GetForWardPath(cfgTaskData.TrunkPath)

		LuaUtility.LoadImage(self, backGroundPath, self.mainIcon:GetComponent("Image"))
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(cfgTaskData.ChapterText), self.ChpaterImage:GetComponent("Image"))
	else
		LuaUtility.SetGameObjectShow(self.ReceivedState, true)
		LuaUtility.SetGameObjectShow(self.endState, true)
		LuaUtility.SetGameObjectShow(self.normalState, false)
		LuaUtility.SetGameObjectShow(self.ContentScroll, false)
	end
end

function TaskTrunkView:GetShowAwardBtnState()
	return self.data ~= nil and self.data.status == 2
end

function TaskTrunkView:RefreshAwardData(ActionParam)
	local itemData = LuaUtility.ActionParamToItemDataTable(ActionParam)
	local itemCell = ItemCell.New(self.awardItem)

	itemCell:SetItem(itemData[1], itemData[1]:GetNum())
end

function TaskTrunkView:OnDestroy()
	self.getButton.onClick:RemoveListener(self.OnAllGetBtnClicked)
	self.mainIconButton.onClick:RemoveListener(self.OnGotoClicked)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)
end

return TaskTrunkView
