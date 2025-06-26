-- chunkname: @IQIGame\\UI\\Map\\MapChapterDetails\\ClassifitaionPanel.lua

local classifitaionItemCell = require("IQIGame.UI.Map.ItemCell.ClassifitaionItemCell")
local m = {
	LastIndex = 1,
	TabList = {},
	AllStageDatas = {},
	StageTypes = {},
	ItemList = {}
}

function m.New(view, mainView)
	local obj = Clone(m)

	obj:Init(view, mainView)

	return obj
end

function m:Init(view, mainView)
	self.View = view
	self.MainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickTab(isOn)
		self:OnClickTab(isOn)
	end

	function self.DelegateNotifyUpdateStage(dups)
		self:NotifyUpdateStage(dups)
	end

	table.insert(self.TabList, self.permanentTab)
	table.insert(self.TabList, self.limitedTimeTab)

	self.stageScrollList = self.StageScrollView:GetComponent("ScrollAreaListGroup")

	function self.stageScrollList.onRenderGroupPage(renderPage, groupIndex)
		self:UpdateTitles(renderPage, groupIndex)
	end

	function self.stageScrollList.onRenderGroupCell(renderCell, groupIndex, cellIndex)
		self:UpdateRewards(renderCell, groupIndex, cellIndex)
	end

	function self.stageScrollList.onSelectedCell(renderCell)
		self:OnSelectCell(renderCell)
	end

	self.AllStageDatas[Constant.MapStageType.MainLine] = {
		CfgWorldMapItemTable[MapModule.NormalStageID]
	}

	local lengths = {}

	for k, v in pairs(self.AllStageDatas) do
		table.insert(lengths, #v)
		table.insert(self.StageTypes, k)
	end

	self.stageScrollList:RefreshOnLua(lengths)
	self:AddListeners()
end

function m:AddListeners()
	for k, v in pairs(self.TabList) do
		v:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnClickTab)
	end

	EventDispatcher.AddEventListener(EventID.OnNotifyStage, self.DelegateNotifyUpdateStage)
end

function m:RemoveListeners()
	for k, v in pairs(self.TabList) do
		v:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnClickTab)
	end

	EventDispatcher.RemoveEventListener(EventID.OnNotifyStage, self.DelegateNotifyUpdateStage)
end

function m:SetData()
	if self.LastIndex == 2 then
		self.limitedTimeTab:GetComponent("Toggle").isOn = true
	else
		self.permanentTab:GetComponent("Toggle").isOn = true
	end

	self:ShowChangeTab(self.LastIndex)
end

function m:OnClickTab(isOn)
	if isOn then
		local currentTarget = self.MainView.UIController:GetCurrentTarget()

		for i = 1, #self.TabList do
			if self.TabList[i] == currentTarget then
				self:ShowChangeTab(i)

				return
			end
		end
	end
end

function m:ShowChangeTab(index)
	self.LastIndex = index
	self.AllStageDatas = {}
	self.StageTypes = {}

	local lengths = {}

	if index == 1 then
		self.AllStageDatas[Constant.MapStageType.MainLine] = MapModule.GetAllUnlockItem(Constant.MapStageType.MainLine, true)
		self.AllStageDatas[Constant.MapStageType.BranchLine] = MapModule.GetAllUnlockItem(Constant.MapStageType.BranchLine)

		table.sort(self.AllStageDatas[Constant.MapStageType.MainLine], function(a, b)
			return a.Id < b.Id
		end)
		table.sort(self.AllStageDatas[Constant.MapStageType.BranchLine], function(a, b)
			if a.RecommendLevel == b.RecommendLevel then
				return a.Id < b.Id
			end

			return a.RecommendLevel > b.RecommendLevel
		end)
	else
		self.AllStageDatas[Constant.MapStageType.Daily] = MapModule.GetDailyStages()
	end

	for k, v in pairs(self.AllStageDatas) do
		if #v == 0 then
			self.AllStageDatas[k] = nil
		end
	end

	for k, v in pairs(self.AllStageDatas) do
		table.insert(lengths, #v)
		table.insert(self.StageTypes, k)
	end

	if table.len(lengths) == 0 then
		self.stageScrollList:Refresh(0)
	else
		self.stageScrollList:RefreshOnLua(lengths)
	end
end

function m:UpdateTitles(renderPage, groupIndex)
	UGUIUtil.SetText(renderPage.prefabPage.transform:Find("Name").gameObject, ChapterStageMapUIApi:GetStageItemTypeText(self.StageTypes[groupIndex + 1]))

	local imgCom = renderPage.prefabPage.transform:Find("titleImg").gameObject:GetComponent("Image")

	AssetUtil.LoadImage(self, ChapterStageMapUIApi:GetStageTypeTitleImage(self.StageTypes[groupIndex + 1]), imgCom, function()
		imgCom:SetNativeSize()
	end)
end

function m:UpdateRewards(renderCell, groupIndex, cellIndex)
	local gameObjectInstanceId = renderCell.gameObject:GetInstanceID()
	local cfgData = self.AllStageDatas[self.StageTypes[groupIndex + 1]][cellIndex + 1]
	local itemCell = self.ItemList[gameObjectInstanceId]

	if itemCell == nil then
		itemCell = classifitaionItemCell.New(renderCell.gameObject)
		self.ItemList[gameObjectInstanceId] = itemCell
	end

	itemCell:SetData(cfgData, self.StageTypes[groupIndex + 1])
end

function m:OnSelectCell(renderCell)
	local gameObjectInstanceId = renderCell.gameObject:GetInstanceID()

	for k, v in pairs(self.ItemList) do
		if k == gameObjectInstanceId then
			v:Move()
		else
			v:ResetMove()
		end
	end
end

function m:NotifyUpdateStage(dups)
	return
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:ResetLastIndex()
	self.LastIndex = 1
end

function m:Dispose()
	self.LastIndex = nil

	self:RemoveListeners()

	for k, v in pairs(self.ItemList) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
