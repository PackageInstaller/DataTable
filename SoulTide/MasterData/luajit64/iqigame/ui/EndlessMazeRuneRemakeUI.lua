-- chunkname: @IQIGame\\UI\\EndlessMazeRuneRemakeUI.lua

local EndlessMazeRuneRemakeUI = {
	MaxRemakeCount = 0,
	AddPrice = 0,
	RemakeLeftCount = 0,
	RuneCells = {},
	SuitItems = {}
}

EndlessMazeRuneRemakeUI = Base:Extend("EndlessMazeRuneRemakeUI", "IQIGame.Onigao.UI.EndlessMazeRuneRemakeUI", EndlessMazeRuneRemakeUI)

local EndlessMazeNamedRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeNamedRuneCell")
local EndlessMazeRuneTipController = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneTipController")
local EndlessMazeRuneSuitItem = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneSuitItem")

function EndlessMazeRuneRemakeUI:OnInit()
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

	function self.DelegateOnClickRemakeBtn()
		self:OnClickRemakeBtn()
	end

	function self.DelegateOnRemakeSuccess()
		self:OnRemakeSuccess()
	end

	function self.DelegateOnUpdateRune()
		self:OnUpdateRune()
	end

	local runeCellScrollList = self.RuneCellGrid:GetComponent("ScrollAreaList")

	runeCellScrollList.defaultSelectedToggle = -1

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

	self.CenterCellController = EndlessMazeNamedRuneCell.New(self.CenterCell, false)
	self.EndlessMazeRuneTipController = EndlessMazeRuneTipController.New(self.TipView)

	local cfgItemData = CfgItemTable[Constant.ItemID.CRYSTAL]
	local costItemIconPath = UIGlobalApi.GetIconPath(cfgItemData.Icon)

	self.CostItemIcon:GetComponent("Image").sprite = LuaCodeInterface.ToSprite(self.UIController:GetPreloadedAsset(costItemIconPath))

	UGUIUtil.SetText(self.TitleText, EndlessMazeRuneRemakeUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.FilterBtn, EndlessMazeRuneRemakeUIApi:GetString("FilterBtnText"))
	UGUIUtil.SetTextInChildren(self.RemakeBtn, EndlessMazeRuneRemakeUIApi:GetString("RemakeBtnText"))
	UGUIUtil.SetText(self.TipText, EndlessMazeRuneRemakeUIApi:GetString("TipText"))
	UGUIUtil.SetText(self.RuneSuitLabel, EndlessMazeRuneRemakeUIApi:GetString("RuneSuitLabel"))
end

function EndlessMazeRuneRemakeUI:GetPreloadAssetPaths()
	local cfgItemData = CfgItemTable[Constant.ItemID.CRYSTAL]
	local costItemIconPath = UIGlobalApi.GetIconPath(cfgItemData.Icon)

	return {
		costItemIconPath
	}
end

function EndlessMazeRuneRemakeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneRemakeUI:IsManualShowOnOpen(userData)
	return false
end

function EndlessMazeRuneRemakeUI:GetBGM(userData)
	return nil
end

function EndlessMazeRuneRemakeUI:OnOpen(userData)
	self.MaxRemakeCount = userData.count
	self.RemakeLeftCount = userData.count
	self.AddPrice = userData.addPrice

	self:UpdateView()
end

function EndlessMazeRuneRemakeUI:OnClose(userData)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_REMAKE_RUNE, {
		id = 0
	})
end

function EndlessMazeRuneRemakeUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.FilterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFilterBtn)
	self.ClearFilterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClearFilterBtn)
	self.RemakeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRemakeBtn)
	EventDispatcher.AddEventListener(EventID.MazeRemakeRuneSuccess, self.DelegateOnRemakeSuccess)
	EventDispatcher.AddEventListener(EventID.MazeUpdateRune, self.DelegateOnUpdateRune)
end

function EndlessMazeRuneRemakeUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.FilterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFilterBtn)
	self.ClearFilterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClearFilterBtn)
	self.RemakeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRemakeBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeRemakeRuneSuccess, self.DelegateOnRemakeSuccess)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateRune, self.DelegateOnUpdateRune)
end

function EndlessMazeRuneRemakeUI:OnPause()
	return
end

function EndlessMazeRuneRemakeUI:OnResume()
	return
end

function EndlessMazeRuneRemakeUI:OnCover()
	return
end

function EndlessMazeRuneRemakeUI:OnReveal()
	return
end

function EndlessMazeRuneRemakeUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneRemakeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneRemakeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneRemakeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneRemakeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneRemakeUI:OnDestroy()
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

function EndlessMazeRuneRemakeUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EndlessMazeRuneRemakeUI:UpdateView()
	self.RuneDataList = self:GetFilteredData(MazeDataModule.PlayerInfo.Runes)

	self.ClearFilterBtn:SetActive(self.FilterPattern ~= nil)
	UGUIUtil.SetText(self.RuneNumText, EndlessMazeRuneRemakeUIApi:GetString("RuneNumText", #self.RuneDataList, #MazeDataModule.PlayerInfo.Runes, self.FilterPattern ~= nil))
	self.CenterCellController:SetData(nil)
	self.EndlessMazeRuneTipController:Hide()
	self:RefreshResource(0)

	local runeCellScrollList = self.RuneCellGrid:GetComponent("ScrollAreaList")

	runeCellScrollList:Refresh(#self.RuneDataList)

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
end

function EndlessMazeRuneRemakeUI:RefreshResource(costCristalNum)
	UGUIUtil.SetText(self.CostItemNumText, EndlessMazeRuneRemakeUIApi:GetString("CostItemNumText", costCristalNum, MazeDataModule.GetItemNumByCfgID(Constant.ItemID.CRYSTAL)))
	UGUIUtil.SetText(self.RemakeCountText, EndlessMazeRuneRemakeUIApi:GetString("RemakeCountText", self.RemakeLeftCount))
end

function EndlessMazeRuneRemakeUI:OnRenderRuneCell(cell)
	local mazeRunePOD = self.RuneDataList[cell.index + 1]
	local runeCell = self.RuneCells[cell.gameObject]

	if runeCell == nil then
		runeCell = EndlessMazeNamedRuneCell.New(cell.gameObject, false)
		self.RuneCells[cell.gameObject] = runeCell
	end

	runeCell:SetData(mazeRunePOD)
end

function EndlessMazeRuneRemakeUI:OnSelectRuneCell(cell)
	local runeCell = self.RuneCells[cell.gameObject]
	local mazeRunePOD = runeCell.RuneCell.MazeRunePOD

	self.CenterCellController:SetData(mazeRunePOD)

	local price = self:GetPrice(mazeRunePOD.CID)

	self:RefreshResource(price)
	self.EndlessMazeRuneTipController:Show(mazeRunePOD)
end

function EndlessMazeRuneRemakeUI:GetPrice(runeCid)
	local cfgRuneData = CfgRuneTable[runeCid]
	local priceIndex = self.MaxRemakeCount - self.RemakeLeftCount + 1

	if priceIndex > #cfgRuneData.RecastPrice then
		priceIndex = #cfgRuneData.RecastPrice
	end

	local price = cfgRuneData.RecastPrice[priceIndex] + self.AddPrice

	if price < 0 then
		price = 0
	end

	return price
end

function EndlessMazeRuneRemakeUI:OnRenderSuitCell(cell)
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

function EndlessMazeRuneRemakeUI:OnSelectedSuitCell(cell)
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

function EndlessMazeRuneRemakeUI:GetFilteredData(dataList)
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

function EndlessMazeRuneRemakeUI:AnyTagInTable(tags, pool)
	for i = 1, #tags do
		if table.indexOf(pool, tags[i]) ~= -1 then
			return true
		end
	end

	return false
end

function EndlessMazeRuneRemakeUI:OnClickFilterBtn()
	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneFilterUI, Constant.UILayer.UI, {
		isCleared = self.FilterPattern == nil,
		onConfirm = self.DelegateOnFiltered
	})
end

function EndlessMazeRuneRemakeUI:OnFiltered(filterPattern)
	if filterPattern:IsEmpty() then
		self.FilterPattern = nil
	else
		self.FilterPattern = filterPattern
	end

	self:UpdateView()
end

function EndlessMazeRuneRemakeUI:OnClickClearFilterBtn()
	self.FilterPattern = nil

	self:UpdateView()
end

function EndlessMazeRuneRemakeUI:OnClickRemakeBtn()
	local mazeRunePOD = self.CenterCellController.RuneCell.MazeRunePOD

	if mazeRunePOD == nil then
		NoticeModule.ShowNotice(21050002)

		return
	end

	local price = self:GetPrice(mazeRunePOD.CID)

	if price > MazeDataModule.GetItemNumByCfgID(Constant.ItemID.CRYSTAL) then
		NoticeModule.ShowNotice(21050003)

		return
	end

	if self.RemakeLeftCount <= 0 then
		NoticeModule.ShowNotice(70000003)

		return
	end

	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_REMAKE_RUNE, {
		id = mazeRunePOD.CID
	})
end

function EndlessMazeRuneRemakeUI:OnRemakeSuccess()
	self.RemakeLeftCount = self.RemakeLeftCount - 1

	local price = 0

	if self.CenterCellController.MazeRunePOD ~= nil then
		price = self:GetPrice(self.CenterCellController.MazeRunePOD.CID)
	end

	self:RefreshResource(price)
end

function EndlessMazeRuneRemakeUI:OnUpdateRune()
	self:UpdateView()
end

return EndlessMazeRuneRemakeUI
