-- chunkname: @IQIGame\\UI\\LotteryMultiPickUpUI.lua

require("IQIGame.UIExternalApi.LotteryMultiPickUpUIApi")

local LotteryMultiPickUpCell = require("IQIGame.UI.Lottery.LotteryMultiPickUpCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local LotteryMultiPickUpUI = {
	PickUpCellMap = {},
	SelectedCells = {}
}

LotteryMultiPickUpUI = Base:Extend("LotteryMultiPickUpUI", "IQIGame.Onigao.UI.LotteryMultiPickUpUI", LotteryMultiPickUpUI)

function LotteryMultiPickUpUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	local scrollAreaList = self.ScrollAreaList:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderScrollListCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectScrollListCell(cell)
	end

	self.SelectedCellPool = UIObjectPool.New(5, function()
		return LotteryMultiPickUpCell.New(UnityEngine.Object.Instantiate(self.CellPrefab), true)
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	UGUIUtil.SetText(self.TitleText, LotteryMultiPickUpUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, LotteryMultiPickUpUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetText(self.TipText, LotteryMultiPickUpUIApi:GetString("TipText"))
end

function LotteryMultiPickUpUI:GetPreloadAssetPaths()
	return nil
end

function LotteryMultiPickUpUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LotteryMultiPickUpUI:IsManualShowOnOpen(userData)
	return false
end

function LotteryMultiPickUpUI:GetBGM(userData)
	return nil
end

function LotteryMultiPickUpUI:OnOpen(userData)
	self.OnChangeCallback = userData.onChange

	self:UpdateView(userData.cfgLotteryShowData)
end

function LotteryMultiPickUpUI:OnClose(userData)
	return
end

function LotteryMultiPickUpUI:OnAddListeners()
	self.CloseBtn2:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function LotteryMultiPickUpUI:OnRemoveListeners()
	self.CloseBtn2:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function LotteryMultiPickUpUI:OnPause()
	return
end

function LotteryMultiPickUpUI:OnResume()
	return
end

function LotteryMultiPickUpUI:OnCover()
	return
end

function LotteryMultiPickUpUI:OnReveal()
	return
end

function LotteryMultiPickUpUI:OnRefocus(userData)
	return
end

function LotteryMultiPickUpUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LotteryMultiPickUpUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LotteryMultiPickUpUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LotteryMultiPickUpUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LotteryMultiPickUpUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for instanceId, cell in pairs(self.PickUpCellMap) do
		cell:Dispose()
	end

	self:ClearSelectedCells()
	self.SelectedCellPool:Dispose()
end

function LotteryMultiPickUpUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function LotteryMultiPickUpUI:UpdateView(cfgLotteryShowData)
	self.CfgLotteryShowData = cfgLotteryShowData

	local availableList, selectedList = self:GetSortedList()

	self.PickUpDataList = availableList
	self.SelectedIndexCfgDataMap = selectedList

	local scrollAreaList = self.ScrollAreaList:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.PickUpDataList)
	self:ClearSelectedCells()

	for i = 1, self.CfgLotteryShowData.ChoiceNum do
		local cell = self.SelectedCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.ChosenGrid.transform, false)
		table.insert(self.SelectedCells, cell)
	end

	self:RefreshSelectedCells()
end

function LotteryMultiPickUpUI:RefreshSelectedCells()
	for i = 1, #self.SelectedCells do
		local cell = self.SelectedCells[i]

		cell:SetData(self.SelectedIndexCfgDataMap[i], i)
	end
end

function LotteryMultiPickUpUI:GetSortedList()
	local pickUpDataList = LotteryModule.GetAvailablePickUps(self.CfgLotteryShowData)
	local selectedPickUps = LotteryModule.GetSelectedPickUps(self.CfgLotteryShowData, pickUpDataList)

	table.sort(pickUpDataList, function(cfgData1, cfgData2)
		local selectIndex1 = table.indexOf(selectedPickUps, cfgData1)
		local selectIndex2 = table.indexOf(selectedPickUps, cfgData2)

		selectIndex1 = selectIndex1 == -1 and Constant.Number.IntMaxValue or selectIndex1
		selectIndex2 = selectIndex2 == -1 and Constant.Number.IntMaxValue or selectIndex2

		if selectIndex1 == selectIndex2 then
			return cfgData1.Id < cfgData2.Id
		end

		return selectIndex1 < selectIndex2
	end)

	return pickUpDataList, selectedPickUps
end

function LotteryMultiPickUpUI:OnRenderScrollListCell(cell)
	local puCell = self.PickUpCellMap[cell.gameObject:GetInstanceID()]

	if puCell == nil then
		puCell = LotteryMultiPickUpCell.New(cell.gameObject)
		self.PickUpCellMap[cell.gameObject:GetInstanceID()] = puCell
	end

	local cfgData = self.PickUpDataList[cell.index + 1]
	local index = -1

	for k, v in pairs(self.SelectedIndexCfgDataMap) do
		if v == cfgData then
			index = k

			break
		end
	end

	puCell:SetData(cfgData, index)
end

function LotteryMultiPickUpUI:OnSelectScrollListCell(cell)
	local puCell = self.PickUpCellMap[cell.gameObject:GetInstanceID()]
	local selectedIndex = -1

	for k, v in pairs(self.SelectedIndexCfgDataMap) do
		if v == puCell.CfgLotteryPackUpData then
			selectedIndex = k

			break
		end
	end

	local isSelected = selectedIndex ~= -1
	local firstEmptyIndex

	if not isSelected then
		for i = 1, self.CfgLotteryShowData.ChoiceNum do
			local data = self.SelectedIndexCfgDataMap[i]

			if data == nil then
				firstEmptyIndex = i

				break
			end
		end
	end

	if isSelected then
		self.SelectedIndexCfgDataMap[selectedIndex] = nil
		selectedIndex = -1
	else
		if firstEmptyIndex == nil then
			NoticeModule.ShowNotice(21049006)

			return
		end

		selectedIndex = firstEmptyIndex
		self.SelectedIndexCfgDataMap[firstEmptyIndex] = puCell.CfgLotteryPackUpData
	end

	selectedIndex = isSelected and -1 or firstEmptyIndex

	puCell:SetData(puCell.CfgLotteryPackUpData, selectedIndex)
	self:RefreshSelectedCells()
end

function LotteryMultiPickUpUI:ClearSelectedCells()
	for i = 1, #self.SelectedCells do
		local cell = self.SelectedCells[i]

		cell.View.transform:SetParent(self.UIController.transform, false)
		cell.View:SetActive(false)
		self.SelectedCellPool:Release(cell)
	end

	self.SelectedCells = {}
end

function LotteryMultiPickUpUI:OnClickConfirmBtn()
	local pickUpCids = {}
	local selectNum = 0

	for index, cfgLotteryPackUpData in pairs(self.SelectedIndexCfgDataMap) do
		table.insert(pickUpCids, cfgLotteryPackUpData.Id)

		selectNum = selectNum + 1
	end

	if selectNum < self.CfgLotteryShowData.ChoiceNum then
		NoticeModule.ShowNotice(21049005)

		return
	end

	UIModule.CloseSelf(self)

	local savedPUMap = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.LotteryPackUpCids)

	savedPUMap = savedPUMap or {}
	savedPUMap[tostring(self.CfgLotteryShowData.Id)] = pickUpCids

	PlayerPrefsUtil.SetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.LotteryPackUpCids, savedPUMap)
	self.OnChangeCallback(self.SelectedIndexCfgDataMap)
end

return LotteryMultiPickUpUI
