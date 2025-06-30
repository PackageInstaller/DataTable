-- chunkname: @IQIGame\\UI\\ActiveRookie\\RookieTask\\RookieTaskView.lua

local RookieTaskView = {
	taskCellPool = {}
}
local RookieTaskCell = require("IQIGame.UI.ActiveRookie.RookieTask.RookieTaskCell")

function RookieTaskView.New(go)
	local o = Clone(RookieTaskView)

	o:Initialize(go)

	return o
end

function RookieTaskView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go
	self.taskList = self.goList:GetComponent("ScrollAreaList")

	function self.taskList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end
end

function RookieTaskView:Open(index)
	self.index = index

	self.goView:SetActive(true)
	self:RefreshTaskList()
	self:AddListener()
end

function RookieTaskView:Close()
	self:OnHide()
	self.goView:SetActive(false)
end

function RookieTaskView:OnHide()
	self:RemoveListener()

	for i, v in pairs(self.taskCellPool) do
		v:OnHide()
	end
end

function RookieTaskView:OnDestroy()
	for i, v in pairs(self.taskCellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function RookieTaskView:AddListener()
	return
end

function RookieTaskView:RemoveListener()
	return
end

function RookieTaskView:OnTaskUpdate(id)
	self:RefreshTaskList()
end

function RookieTaskView:OnRenderCell(cell)
	local luaIndex = cell.index + 1
	local data = self.taskDatum[luaIndex]
	local insID = cell.gameObject:GetInstanceID()
	local taskCell = self.taskCellPool[insID]

	if taskCell == nil then
		taskCell = RookieTaskCell.New(cell.gameObject)
		self.taskCellPool[insID] = taskCell
	end

	taskCell:Refresh(data)
end

function RookieTaskView:RefreshTaskList()
	self.taskDatum = ActiveModule.GetRookieTaskDatum(TaskModule.TaskType.ROOKIE_TASK, self.index)

	self.taskList:Refresh(#self.taskDatum)
end

return RookieTaskView
