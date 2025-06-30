-- chunkname: @IQIGame\\UI\\HomeLandVisit\\HomeLandVisitHistoryItem.lua

HomeLandVisitHistoryItem = {}

function HomeLandVisitHistoryItem.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.SUB_UI_MAP_VisitHistoryCell == nil then
		ui.SUB_UI_MAP_VisitHistoryCell = {}
	end

	local subUIMap = ui.SUB_UI_MAP_VisitHistoryCell
	local queueRender

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		queueRender = HomeLandVisitHistoryItem:__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = queueRender
	else
		queueRender = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return queueRender
end

function HomeLandVisitHistoryItem:__New(itemCellView)
	local itemCell = Clone(HomeLandVisitHistoryItem)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandVisitHistoryItem:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function HomeLandVisitHistoryItem.DisposeIn(ui)
	if ui.SUB_UI_MAP_VisitHistoryCell == nil then
		return
	end

	for i, itemCell in pairs(ui.SUB_UI_MAP_VisitHistoryCell) do
		itemCell:Dispose()
	end

	ui.SUB_UI_MAP_VisitHistoryCell = nil
end

function HomeLandVisitHistoryItem:AddListener()
	return
end

function HomeLandVisitHistoryItem:RemoveListener()
	return
end

function HomeLandVisitHistoryItem:SetDate(cfgBuildingID, data)
	self.cfgBuildingID = cfgBuildingID
	self.helpLogPOD = data

	if self.helpLogPOD then
		UGUIUtil.SetText(self.Text1, getDateText(self.helpLogPOD.createTime))
		UGUIUtil.SetText(self.Text2, getTimeText(self.helpLogPOD.createTime))
		UGUIUtil.SetText(self.Text3, self.helpLogPOD.name)
		UGUIUtil.SetText(self.Text4, HomeLandVisitUIApi:GetString("TextVisitHistoryMsg", self.cfgBuildingID, self.helpLogPOD.target, self.helpLogPOD.entryCid, self.helpLogPOD.entryVal))
	end
end

function HomeLandVisitHistoryItem:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return HomeLandVisitHistoryItem
