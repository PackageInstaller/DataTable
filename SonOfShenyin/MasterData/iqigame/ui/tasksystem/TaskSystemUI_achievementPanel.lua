-- chunkname: @IQIGame\\UI\\TaskSystem\\TaskSystemUI_achievementPanel.lua

local TaskSystemUI_achievementPanel = {}
local tabItemClass = require("IQIGame/UI/TaskSystem/TaskSystemUI_achievementPanel_TabItem")
local taskItemClass = require("IQIGame/UI/TaskSystem/TaskSystemUI_achievementPanel_TaskItem")
local tabIndexDefine = {
	{
		Constant.ExtendTaskType.AchievementRole,
		Constant.ExtendTaskType.AchievementEquip,
		Constant.ExtendTaskType.AchievementStory,
		Constant.ExtendTaskType.AchievementFight
	},
	{
		Constant.ExtendTaskType.AchievementRole
	},
	{
		Constant.ExtendTaskType.AchievementEquip
	},
	{
		Constant.ExtendTaskType.AchievementStory
	},
	{
		Constant.ExtendTaskType.AchievementFight
	}
}

function TaskSystemUI_achievementPanel.New(go, mainView)
	local o = Clone(TaskSystemUI_achievementPanel)

	o:Initialize(go, mainView)

	return o
end

function TaskSystemUI_achievementPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.tabItemViewArray = {}
	self.taskDataArray = {}
	self.taskCellList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TaskSystemUI_achievementPanel:InitComponent()
	self.toggleGroupTrans = self.ToggleGroup.transform

	local len = LuaUtility.GetChildCount(self.toggleGroupTrans)

	for i = 1, len do
		local trans = LuaUtility.GetChild(self.toggleGroupTrans, i - 1)
		local item = tabItemClass.New(trans.gameObject, self)

		item:Refresh(tabIndexDefine[i])
		table.insert(self.tabItemViewArray, item)
	end

	self.taskScroll = self.taskScrollArea:GetComponent("ScrollAreaList")

	function self.taskScroll.onRenderCell(gridCell)
		self:OnTaskRenderGridCell(gridCell)
	end
end

function TaskSystemUI_achievementPanel:InitDelegate()
	return
end

function TaskSystemUI_achievementPanel:AddListener()
	return
end

function TaskSystemUI_achievementPanel:RemoveListener()
	return
end

function TaskSystemUI_achievementPanel:OnTaskRenderGridCell(gridCellData)
	local data = self.taskDataArray[gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.taskCellList[insID]

	if not cell then
		cell = taskItemClass.New(gridCellData.gameObject, self)
		self.taskCellList[insID] = cell
	end

	cell:Refresh(data)

	gridCellData.gameObject.name = data.cid
	gridCellData.transform.parent.gameObject.name = "Index" .. gridCellData.index + 1
end

function TaskSystemUI_achievementPanel:Show(taskType)
	LuaUtility.SetGameObjectShow(self.gameObject, true)

	self.taskType = taskType

	self:OnOpen()
end

function TaskSystemUI_achievementPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)

	self.currentTypeTable = {}
end

function TaskSystemUI_achievementPanel:OnOpen()
	self.tabItemViewArray[1].ToggleGo:GetComponent("Toggle").isOn = true

	self.tabItemViewArray[1]:OnToggle(true)
end

function TaskSystemUI_achievementPanel:OnTabSelected(type)
	self.taskDataArray = {}
	self.currentTypeTable = type

	if #type == 1 then
		self.taskDataArray = TaskSystemModule.GetSortForTypeDataList(self.taskType, type[1], TaskSystemModule.sortType.Status_ID, true, true)
	else
		self.taskDataArray = TaskSystemModule.GetSortForTypeDataList(self.taskType, nil, TaskSystemModule.sortType.Status_ID, true, true)
	end

	self.taskScroll:Refresh(#self.taskDataArray)
end

function TaskSystemUI_achievementPanel:Refresh()
	return
end

function TaskSystemUI_achievementPanel:RefreshByServerNotify()
	self:OnTabSelected(self.currentTypeTable)
end

function TaskSystemUI_achievementPanel:OnDestroy()
	self:RemoveListener()

	for i = 1, #self.tabItemViewArray do
		self.tabItemViewArray[i]:OnDestroy()
	end

	self.taskScroll = nil
	self.tabItemViewArray = {}
	self.toggleGroupTrans = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return TaskSystemUI_achievementPanel
