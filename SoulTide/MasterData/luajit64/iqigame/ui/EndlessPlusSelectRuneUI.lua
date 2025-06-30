-- chunkname: @IQIGame\\UI\\EndlessPlusSelectRuneUI.lua

require("IQIGame.UIExternalApi.EndlessPlusSelectRuneUIApi")

local EndlessPlusMazeRuneCell = require("IQIGame.UI.EndlessPlusMaze.EndlessPlusMazeRuneCell")
local EndlessMazeRuneTipController = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneTipController")
local EndlessMazeRuneSuitItem = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneSuitItem")
local EndlessPlusSelectRuneUI = {
	IsViewMode = false,
	MAX_SELECT_NUM = 6,
	RuneCells = {},
	SuitItems = {}
}

EndlessPlusSelectRuneUI = Base:Extend("EndlessPlusSelectRuneUI", "IQIGame.Onigao.UI.EndlessPlusSelectRuneUI", EndlessPlusSelectRuneUI)

function EndlessPlusSelectRuneUI:OnInit()
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

	function self.DelegateOnClickEquipToggle(cfgRuneData, isOn, cell)
		self:OnClickEquipToggle(cfgRuneData, isOn, cell)
	end

	function self.DelegateOnFilterEquippedToggleValueChanged(isOn)
		self:OnFilterEquippedToggleValueChanged(isOn)
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
	self.FilterEquippedToggle:GetComponent("ToggleHelperComponent").text = EndlessPlusSelectRuneUIApi:GetString("FilterEquippedToggleText")

	UGUIUtil.SetText(self.TitleText, EndlessPlusSelectRuneUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.RuneSuitLabel, EndlessPlusSelectRuneUIApi:GetString("RuneSuitLabel"))
	UGUIUtil.SetTextInChildren(self.FilterBtn, EndlessPlusSelectRuneUIApi:GetString("FilterBtnText"))
end

function EndlessPlusSelectRuneUI:GetPreloadAssetPaths()
	return nil
end

function EndlessPlusSelectRuneUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessPlusSelectRuneUI:IsManualShowOnOpen(userData)
	return false
end

function EndlessPlusSelectRuneUI:GetBGM(userData)
	return nil
end

function EndlessPlusSelectRuneUI:OnOpen(userData)
	self.EndlessMazeRuneTipController:Hide()

	local isViewMode, defaultSelects, onConfirm

	if userData ~= nil then
		isViewMode = userData.viewMode
		defaultSelects = userData.defaultSelects
		onConfirm = userData.onConfirm
	end

	self:UpdateView(isViewMode, defaultSelects, onConfirm)
end

function EndlessPlusSelectRuneUI:OnClose(userData)
	return
end

function EndlessPlusSelectRuneUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.FilterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFilterBtn)
	self.ClearFilterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClearFilterBtn)
	self.FilterEquippedToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnFilterEquippedToggleValueChanged)
end

function EndlessPlusSelectRuneUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.FilterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFilterBtn)
	self.ClearFilterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClearFilterBtn)
	self.FilterEquippedToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnFilterEquippedToggleValueChanged)
end

function EndlessPlusSelectRuneUI:OnPause()
	return
end

function EndlessPlusSelectRuneUI:OnResume()
	return
end

function EndlessPlusSelectRuneUI:OnCover()
	return
end

function EndlessPlusSelectRuneUI:OnReveal()
	return
end

function EndlessPlusSelectRuneUI:OnRefocus(userData)
	return
end

function EndlessPlusSelectRuneUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessPlusSelectRuneUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessPlusSelectRuneUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessPlusSelectRuneUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessPlusSelectRuneUI:OnDestroy()
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

function EndlessPlusSelectRuneUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)

	if not self.IsViewMode and self.OnConfirmCallback ~= nil then
		self.OnConfirmCallback(self.EquippedRuneList)
	end

	self.EquippedRuneList = nil
end

function EndlessPlusSelectRuneUI:UpdateView(isViewMode, defaultSelects, onConfirm)
	self.IsViewMode = isViewMode or false
	self.EquippedRuneList = defaultSelects or {}
	self.OnConfirmCallback = onConfirm

	local toggle = self.FilterEquippedToggle:GetComponent("Toggle")

	if toggle.isOn then
		toggle.isOn = false
	else
		self:Refresh()
	end
end

function EndlessPlusSelectRuneUI:Refresh()
	self:RefreshSuit()
	self:RefreshRightPanel()
	self.FilterEquippedToggle:SetActive(not self.IsViewMode)
end

function EndlessPlusSelectRuneUI:RefreshSuit()
	self.SuitDataList = {}

	local cidList, numList = EndlessPlusMazeModule.GetSortedRuneSuitLists(self.EquippedRuneList)
	local legendCidList = EndlessPlusMazeModule.GetLegendRuneSuitCidList(cidList, numList)

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
end

function EndlessPlusSelectRuneUI:RefreshRightPanel()
	self.RuneDataList = self:GetFilteredData(EndlessPlusMazeModule.DailyDupPOD.abyssPlusPOD.runes)

	self.ClearFilterBtn:SetActive(self.FilterPattern ~= nil)

	local toggle = self.FilterEquippedToggle:GetComponent("Toggle")

	if not self.IsViewMode and toggle.isOn then
		local newList = {}

		for i = 1, #self.RuneDataList do
			local cfgRuneData = self.RuneDataList[i]
			local index = -1

			for j = 1, #self.EquippedRuneList do
				local runeCid = self.EquippedRuneList[j]

				if runeCid == cfgRuneData.Id then
					index = j

					break
				end
			end

			if index ~= -1 then
				local index2 = table.indexOf(newList, cfgRuneData)

				if index2 == -1 then
					table.insert(newList, cfgRuneData)
				end
			end
		end

		self.RuneDataList = newList
	end

	UGUIUtil.SetText(self.RuneNumText, EndlessPlusSelectRuneUIApi:GetString("RuneNumText", #self.RuneDataList, #EndlessPlusMazeModule.DailyDupPOD.abyssPlusPOD.runes, self.FilterPattern ~= nil or toggle.isOn))

	local runeCellScrollList = self.RuneCellGrid:GetComponent("ScrollAreaList")

	runeCellScrollList:Refresh(#self.RuneDataList)
end

function EndlessPlusSelectRuneUI:GetFilteredData(dataList)
	local result = {}

	for i = 1, #dataList do
		local runeCid = dataList[i]
		local cfgRuneData = CfgRuneTable[runeCid]

		if self.FilterPattern == nil or (#self.FilterPattern.Qualities == 0 or table.indexOf(self.FilterPattern.Qualities, cfgRuneData.Quality) ~= -1) and (#self.FilterPattern.Effects == 0 or self:AnyTagInTable(cfgRuneData.Tag, self.FilterPattern.Effects)) then
			table.insert(result, cfgRuneData)
		end
	end

	table.sort(result, function(cfgRuneData1, cfgRuneData2)
		if cfgRuneData1.Quality == cfgRuneData2.Quality then
			return cfgRuneData1.Feature < cfgRuneData2.Feature
		end

		return cfgRuneData1.Quality > cfgRuneData2.Quality
	end)

	return result
end

function EndlessPlusSelectRuneUI:AnyTagInTable(tags, pool)
	for i = 1, #tags do
		if table.indexOf(pool, tags[i]) ~= -1 then
			return true
		end
	end

	return false
end

function EndlessPlusSelectRuneUI:OnRenderRuneCell(cell)
	local cfgRuneData = self.RuneDataList[cell.index + 1]
	local runeCell = self.RuneCells[cell.gameObject]

	if runeCell == nil then
		runeCell = EndlessPlusMazeRuneCell.New(cell.gameObject, self.DelegateOnClickEquipToggle)
		self.RuneCells[cell.gameObject] = runeCell
	end

	runeCell:SetData(cfgRuneData, self.IsViewMode, table.indexOf(self.EquippedRuneList, cfgRuneData.Id) ~= -1)
end

function EndlessPlusSelectRuneUI:OnSelectRuneCell(cell)
	local runeCell = self.RuneCells[cell.gameObject]

	self.EndlessMazeRuneTipController:ShowByCfgData(runeCell.CfgRuneData)
end

function EndlessPlusSelectRuneUI:OnRenderSuitCell(cell)
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

function EndlessPlusSelectRuneUI:OnSelectedSuitCell(cell)
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

function EndlessPlusSelectRuneUI:OnClickFilterBtn()
	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneFilterUI, Constant.UILayer.UI, {
		isCleared = self.FilterPattern == nil,
		onConfirm = self.DelegateOnFiltered
	})
end

function EndlessPlusSelectRuneUI:OnFiltered(filterPattern)
	if filterPattern:IsEmpty() then
		self.FilterPattern = nil
	else
		self.FilterPattern = filterPattern
	end

	self:RefreshRightPanel()
end

function EndlessPlusSelectRuneUI:OnClickClearFilterBtn()
	self.FilterPattern = nil

	self:RefreshRightPanel()
end

function EndlessPlusSelectRuneUI:OnClickEquipToggle(cfgRuneData, isOn, cell)
	if isOn then
		if #self.EquippedRuneList >= EndlessPlusSelectRuneUI.MAX_SELECT_NUM then
			NoticeModule.ShowNotice(21045064)
			cell:SetToggleNoCallback(false)

			return
		end

		table.insert(self.EquippedRuneList, cfgRuneData.Id)
	else
		local index = table.indexOf(self.EquippedRuneList, cfgRuneData.Id)

		if index == -1 then
			logError("卸下刻印错误：刻印不在佩戴列表内")

			return
		end

		table.remove(self.EquippedRuneList, index)
	end

	self:RefreshSuit()
end

function EndlessPlusSelectRuneUI:OnFilterEquippedToggleValueChanged(isOn)
	self:Refresh()
end

return EndlessPlusSelectRuneUI
