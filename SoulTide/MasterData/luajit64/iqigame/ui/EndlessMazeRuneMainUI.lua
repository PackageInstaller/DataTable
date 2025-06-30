-- chunkname: @IQIGame\\UI\\EndlessMazeRuneMainUI.lua

local EndlessMazeRuneMainUI = Base:Extend("EndlessMazeRuneMainUI", "IQIGame.Onigao.UI.EndlessMazeRuneMainUI", {
	RuneCells = {},
	SuitItems = {}
})
local EndlessMazeNamedRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeNamedRuneCell")
local EndlessMazeRuneTipController = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneTipController")
local EndlessMazeRuneSuitItem = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneSuitItem")

function EndlessMazeRuneMainUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickFilterBtn()
		self:OnClickFilterBtn()
	end

	function self.DelegateOnFiltered(filterPattern)
		self:OnFiltered(filterPattern)
	end

	function self.DelegateOnClickClearFilterBtn()
		self:OnClickClearFilterBtn()
	end

	local runeCellScrollList = self.RuneCellGrid:GetComponent("ScrollAreaList")

	runeCellScrollList.defaultSelectedToggle = 0

	function runeCellScrollList.onRenderCell(cell)
		self:OnRenderRuneCell(cell)
	end

	function runeCellScrollList.onSelectedCell(cell)
		self:OnSelectRuneCell(cell)
	end

	local suitItemScrollList = self.SuitItemGrid:GetComponent("ScrollAreaList")

	function suitItemScrollList.onRenderCell(cell)
		self:OnRenderSuitCell(cell)
	end

	function suitItemScrollList.onSelectedCell(cell)
		self:OnSelectedSuitCell(cell)
	end

	self.EndlessMazeRuneTipController = EndlessMazeRuneTipController.New(self.TipView)

	UGUIUtil.SetText(self.TitleText, EndlessMazeRuneMainUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.RuneSuitLabel, EndlessMazeRuneMainUIApi:GetString("RuneSuitLabel"))
	UGUIUtil.SetTextInChildren(self.FilterBtn, EndlessMazeRuneMainUIApi:GetString("FilterBtnText"))
end

function EndlessMazeRuneMainUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeRuneMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneMainUI:OnOpen(userData)
	self.EndlessMazeRuneTipController:Hide()
	self:UpdateView()
end

function EndlessMazeRuneMainUI:OnClose(userData)
	return
end

function EndlessMazeRuneMainUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.FilterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFilterBtn)
	self.ClearFilterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClearFilterBtn)
end

function EndlessMazeRuneMainUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.FilterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFilterBtn)
	self.ClearFilterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClearFilterBtn)
end

function EndlessMazeRuneMainUI:OnPause()
	return
end

function EndlessMazeRuneMainUI:OnResume()
	return
end

function EndlessMazeRuneMainUI:OnCover()
	return
end

function EndlessMazeRuneMainUI:OnReveal()
	return
end

function EndlessMazeRuneMainUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneMainUI:OnDestroy()
	self.EndlessMazeRuneTipController:Dispose()

	for gameObject, runeCell in pairs(self.RuneCells) do
		runeCell:Dispose()
	end

	self.RuneCells = nil

	for gameObject, suiItem in pairs(self.SuitItems) do
		suiItem:Dispose()
	end

	self.SuitItems = nil
end

function EndlessMazeRuneMainUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EndlessMazeRuneMainUI:OnRenderRuneCell(cell)
	local mazeRunePOD = self.RuneDataList[cell.index + 1]
	local runeCell = self.RuneCells[cell.gameObject]

	if runeCell == nil then
		runeCell = EndlessMazeNamedRuneCell.New(cell.gameObject, false)
		self.RuneCells[cell.gameObject] = runeCell
	end

	runeCell:SetData(mazeRunePOD)
end

function EndlessMazeRuneMainUI:OnSelectRuneCell(cell)
	local runeCell = self.RuneCells[cell.gameObject]

	self.EndlessMazeRuneTipController:Show(runeCell.RuneCell.MazeRunePOD)
end

function EndlessMazeRuneMainUI:OnRenderSuitCell(cell)
	local suitItem = self.SuitItems[cell.gameObject]

	if suitItem == nil then
		suitItem = EndlessMazeRuneSuitItem.New(cell.gameObject)
		self.SuitItems[cell.gameObject] = suitItem
	end

	local data = self.SuitDataList[cell.index + 1]

	if data ~= nil then
		local num

		if data.type == 1 then
			num = data.num
		else
			num = #data.list
		end

		suitItem:SetData(data.type, data.cid, num)
	end
end

function EndlessMazeRuneMainUI:OnSelectedSuitCell(cell)
	local data = self.SuitDataList[cell.index + 1]

	if data.type == 1 then
		UIModule.Open(Constant.UIControllerName.EndlessMazeRuneSuitTipUI, Constant.UILayer.Tooltip, {
			suitCid = data.cid,
			partNum = data.num,
			srcTrans = cell.gameObject.transform,
			srcSide = UGUISide.TopRight,
			tipSide = UGUISide.BottomLeft
		})
	else
		UIModule.Open(Constant.UIControllerName.EndlessMazeRuneLegendSuitTipUI, Constant.UILayer.Tooltip, {
			list = data.list,
			srcTrans = cell.gameObject.transform,
			srcSide = UGUISide.TopRight,
			tipSide = UGUISide.BottomLeft
		})
	end
end

function EndlessMazeRuneMainUI:UpdateView()
	self.SuitDataList = {}

	local cidList, numList = MazeModule.GetEndlessMazeRuneSuitData()
	local legendCidList = MazeModule.GetEndlessMazeLegendRuneSuitData(cidList, numList)

	if #legendCidList > 0 then
		table.insert(self.SuitDataList, {
			type = 2,
			list = legendCidList
		})
	end

	for i = 1, #cidList do
		table.insert(self.SuitDataList, {
			type = 1,
			cid = cidList[i],
			num = numList[i]
		})
	end

	local suitItemScrollList = self.SuitItemGrid:GetComponent("ScrollAreaList")

	suitItemScrollList:Refresh(#self.SuitDataList)
	self:RefreshRightPanel()
end

function EndlessMazeRuneMainUI:RefreshRightPanel()
	self.RuneDataList = self:GetFilteredData(MazeDataModule.PlayerInfo.Runes)

	self.ClearFilterBtn:SetActive(self.FilterPattern ~= nil)
	UGUIUtil.SetText(self.RuneNumText, EndlessMazeRuneMainUIApi:GetString("RuneNumText", #self.RuneDataList, #MazeDataModule.PlayerInfo.Runes, self.FilterPattern ~= nil))

	local runeCellScrollList = self.RuneCellGrid:GetComponent("ScrollAreaList")

	runeCellScrollList:Refresh(#self.RuneDataList)
end

function EndlessMazeRuneMainUI:GetFilteredData(dataList)
	local result = {}

	for i = 1, #dataList do
		local mazeRunePOD = dataList[i]
		local cfgRuneData = CfgRuneTable[mazeRunePOD.CID]

		if self.FilterPattern == nil or (#self.FilterPattern.Qualities == 0 or table.indexOf(self.FilterPattern.Qualities, cfgRuneData.Quality) ~= -1) and (#self.FilterPattern.Effects == 0 or self:AnyTagInTable(cfgRuneData.Tag, self.FilterPattern.Effects)) then
			table.insert(result, mazeRunePOD)
		end
	end

	table.sort(result, function(mazeRunePOD1, mazeRunePOD2)
		local cfgRuneData1 = CfgRuneTable[mazeRunePOD1.CID]
		local cfgRuneData2 = CfgRuneTable[mazeRunePOD2.CID]

		if cfgRuneData1.Quality == cfgRuneData2.Quality then
			return cfgRuneData1.Feature < cfgRuneData2.Feature
		end

		return cfgRuneData1.Quality > cfgRuneData2.Quality
	end)

	return result
end

function EndlessMazeRuneMainUI:AnyTagInTable(tags, pool)
	for i = 1, #tags do
		if table.indexOf(pool, tags[i]) ~= -1 then
			return true
		end
	end

	return false
end

function EndlessMazeRuneMainUI:OnClickFilterBtn()
	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneFilterUI, Constant.UILayer.UI, {
		isCleared = self.FilterPattern == nil,
		onConfirm = self.DelegateOnFiltered
	})
end

function EndlessMazeRuneMainUI:OnFiltered(filterPattern)
	if filterPattern:IsEmpty() then
		self.FilterPattern = nil
	else
		self.FilterPattern = filterPattern
	end

	self:RefreshRightPanel()
end

function EndlessMazeRuneMainUI:OnClickClearFilterBtn()
	self.FilterPattern = nil

	self:RefreshRightPanel()
end

return EndlessMazeRuneMainUI
