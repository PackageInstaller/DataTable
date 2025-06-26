-- chunkname: @IQIGame\\UI\\Mission\\NormalTask\\NormalTaskView.lua

local NormalTaskView = {
	tabCellDic = {},
	taskCellPool = {},
	groupDatum = {}
}
local NormalTaskTabCell = require("IQIGame.UI.Mission.NormalTask.NormalTaskTabCell")
local NormalTaskCell = require("IQIGame.UI.Mission.NormalTask.NormalTaskCell")

function NormalTaskView.New(view)
	local obj = Clone(NormalTaskView)

	obj:Init(view)

	return obj
end

function NormalTaskView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tabList = self.goTabList:GetComponent("ScrollAreaList")

	function self.tabList.onRenderCell(cell)
		self:OnRenderTab(cell)
	end

	function self.tabList.onSelectedCell(cell)
		self:OnSelectedTab(cell)
	end

	self.taskList = self.goTaskList:GetComponent("ScrollAreaList")

	function self.taskList.onRenderCell(cell)
		self:OnRenderTaskCell(cell)
	end

	self.btnEasyGet = self.goBtnEasyGet:GetComponent("Button")

	function self.onClickBtnEasyGetDelegate()
		self:OnClickBtnEasyGet()
	end

	self.goBtnEasyGet.transform:Find("Text"):GetComponent("Text").text = MissionUIApi:GetString("goEasyGetTxt")

	self:InitDatum()
end

function NormalTaskView:Open()
	self.View:SetActive(true)
	self:RefreshTabList()
	self:AddListener()
	self:RefreshGray()
end

function NormalTaskView:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function NormalTaskView:OnHide()
	self:RemoveListener()

	for i, v in pairs(self.taskCellPool) do
		v:OnHide()
	end

	for i, v in pairs(self.tabCellDic) do
		v:OnHide()
	end
end

function NormalTaskView:OnDestroy()
	for i, v in pairs(self.taskCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.tabCellDic) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function NormalTaskView:AddListener()
	self:RemoveListener()
	self.btnEasyGet.onClick:AddListener(self.onClickBtnEasyGetDelegate)
end

function NormalTaskView:RemoveListener()
	self.btnEasyGet.onClick:RemoveListener(self.onClickBtnEasyGetDelegate)
end

function NormalTaskView:OnClickBtnEasyGet()
	local cids = {}

	for m, n in pairs(self.groupDatum) do
		local childCids = MissionModule.GetAllNormalCanGetRewardTaskCids(n)

		for i, v in pairs(childCids) do
			cids[#cids + 1] = v
		end
	end

	if #cids > 0 then
		TaskModule.SendCommitTaskMsgBatch(cids)
	else
		NoticeModule.ShowNotice(21040136)
	end
end

function NormalTaskView:OnUpdateTask()
	self.curTabDatum = MissionModule.GetNormalShowTaskDatum(self.curGroupType)

	self.taskList:RenderCellsDynamic(#self.curTabDatum)
	self.tabList:RenderCells()
	self:RefreshGray()
end

function NormalTaskView:OnRenderTab(cell)
	local luaIndex = cell.index + 1
	local groupType = self.groupDatum[luaIndex]
	local tabCell = self.tabCellDic[groupType]

	if tabCell == nil then
		tabCell = NormalTaskTabCell.New(cell.gameObject)
		self.tabCellDic[groupType] = tabCell
	end

	tabCell:Refresh(groupType)
end

function NormalTaskView:OnSelectedTab(cell)
	local luaIndex = cell.index + 1
	local groupType = self.groupDatum[luaIndex]

	self.curGroupType = groupType
	self.curTabDatum = MissionModule.GetNormalShowTaskDatum(self.curGroupType)

	self.taskList:Refresh(#self.curTabDatum)
end

function NormalTaskView:OnRenderTaskCell(cell)
	local luaIndex = cell.index + 1
	local data = self.curTabDatum[luaIndex]
	local insID = cell.gameObject:GetInstanceID()
	local taskCell = self.taskCellPool[insID]

	if taskCell == nil then
		taskCell = NormalTaskCell.New(cell.gameObject)
		self.taskCellPool[insID] = taskCell
	end

	taskCell:Refresh(data)
end

function NormalTaskView:InitDatum()
	local temp = {}

	for i, v in pairsCfg(CfgMainQuestTable) do
		if v.Type == TaskModule.TaskType.NORMAL_TASK then
			temp[v.TypeParam[1]] = v.TypeParam[1]
		end
	end

	for i, v in pairs(temp) do
		self.groupDatum[#self.groupDatum + 1] = v
	end

	table.sort(self.groupDatum, function(a, b)
		return a < b
	end)
end

function NormalTaskView:RefreshTabList()
	self.tabList.defaultSelectedToggle = 0

	self.tabList:Refresh(#self.groupDatum)
end

function NormalTaskView:RefreshGray()
	local cids = {}

	for m, n in pairs(self.groupDatum) do
		local childCids = MissionModule.GetAllNormalCanGetRewardTaskCids(n)

		for i, v in pairs(childCids) do
			cids[#cids + 1] = v
		end
	end

	local grayComp = self.goBtnEasyGet:GetComponent("GrayComponent")

	grayComp:SetGray(#cids == 0)
end

return NormalTaskView
