-- chunkname: @IQIGame\\UI\\ActiveWeekend\\NewPlayerGrowUp\\GrowUpView.lua

local GrowUpView = {
	tabLeftCellPool = {},
	taskCellPool = {},
	progressCellPool = {}
}
local TabLeftCell = require("IQIGame.UI.ActiveWeekend.NewPlayerGrowUp.TabLeftCell")
local TaskCell = require("IQIGame.UI.ActiveWeekend.NewPlayerGrowUp.TaskCell")
local ProgressCell = require("IQIGame.UI.ActiveWeekend.NewPlayerGrowUp.ProgressCell")

function GrowUpView.New(view)
	local obj = Clone(GrowUpView)

	obj:Init(view)

	return obj
end

function GrowUpView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfProgressDesc = self.goProgressDesc:GetComponent("Text")
	self.imgBarBg = self.goBarBg:GetComponent("Image")
	self.imgBarProgress = self.goBarProgress:GetComponent("Image")
	self.tabLeftList = self.goTabLeftList:GetComponent("ScrollAreaList")

	function self.tabLeftList.onSelectedCell(grid)
		self:OnSelectedTabLeft(grid)
	end

	function self.tabLeftList.onRenderCell(grid)
		self:OnRenderTabLeft(grid)
	end

	self.taskList = self.goTaskList:GetComponent("ScrollAreaList")

	function self.taskList.onSelectedCell(grid)
		self:OnSelectedTaskCell(grid)
	end

	function self.taskList.onRenderCell(grid)
		self:OnRenderTaskCell(grid)
	end

	self.progressCellPool[1] = ProgressCell.New(self.goProgressCell)
end

function GrowUpView:Open(weekIndex)
	self.weekIndex = weekIndex

	self.View:SetActive(true)
	self:OnAddListeners()
	self:RefreshTabLeft()
	self:RefreshProgress()
end

function GrowUpView:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function GrowUpView:OnHide()
	self:OnRemoveListeners()

	for i, v in pairs(self.progressCellPool) do
		v:OnHide()
	end

	for i, v in pairs(self.tabLeftCellPool) do
		v:OnHide()
	end

	for i, v in pairs(self.taskCellPool) do
		v:OnHide()
	end
end

function GrowUpView:OnDestroy()
	for i, v in pairs(self.progressCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.tabLeftCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.taskCellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function GrowUpView:OnAddListeners()
	self:OnRemoveListeners()
end

function GrowUpView:OnRemoveListeners()
	return
end

function GrowUpView:OnRenderTabLeft(grid)
	local luaIndex = grid.index + 1
	local cell = self.tabLeftCellPool[luaIndex]

	if cell == nil then
		cell = TabLeftCell.New(grid.gameObject)
		self.tabLeftCellPool[luaIndex] = cell
	end

	cell:Refresh(luaIndex, self.weekIndex)

	local disable = ActiveWeekendModule.CheckTabLeftToggleCanClick(self.weekIndex, luaIndex)

	grid.gameObject:GetComponent("Toggle").interactable = disable

	grid.gameObject:GetComponent("GrayComponent"):SetGray(not disable)
end

function GrowUpView:OnSelectedTabLeft(grid)
	local luaIndex = grid.index + 1

	self.curDayIndex = luaIndex

	self:RefreshTaskList()
end

function GrowUpView:OnRenderTaskCell(grid)
	local luaIndex = grid.index + 1
	local cell = self.taskCellPool[luaIndex]
	local data = self.taskDatum[luaIndex]

	if cell == nil then
		cell = TaskCell.New(grid.gameObject)
		self.taskCellPool[luaIndex] = cell
	end

	cell:Refresh(data)
end

function GrowUpView:OnSelectedTaskCell(grid)
	return
end

function GrowUpView:OnTaskCommitResponse()
	self.tabLeftList:RenderCells()
	self:RefreshTaskList()
	self:RefreshProgress()
end

function GrowUpView:RefreshTabLeft()
	self.tabLeftList.defaultSelectedToggle = 0

	self.tabLeftList:Refresh(7)
end

function GrowUpView:RefreshTaskList()
	self.taskDatum = ActiveWeekendModule.GetGrowDayTaskDatum(self.weekIndex, self.curDayIndex)

	self.taskList:Refresh(#self.taskDatum)
end

function GrowUpView:RefreshProgress()
	local datum = ActiveWeekendModule.GetGrowScoreTaskDatum()
	local curScore = 0
	local totalScore = 0

	for i, v in ipairs(self.progressCellPool) do
		v:Close()
	end

	for i, v in ipairs(datum) do
		local cell = self.progressCellPool[i]

		if cell == nil then
			local go = UnityEngine.Object.Instantiate(self.goProgressCell)

			go.transform:SetParent(self.goProgressCell.transform.parent, false)

			cell = ProgressCell.New(go)
			self.progressCellPool[i] = cell
		end

		if curScore < v.CurrentNum then
			curScore = v.CurrentNum
		end

		totalScore = v.TargetNum

		cell:Open(v, curScore)
	end

	self.tfProgressDesc.text = ActiveWeekendUIApi:GetString("growUpViewProgressScoreDesc", curScore, totalScore)
	self.imgBarBg.fillAmount = 0.1 * #datum
	self.imgBarProgress.fillAmount = 0.1 * #datum * curScore / totalScore
end

return GrowUpView
