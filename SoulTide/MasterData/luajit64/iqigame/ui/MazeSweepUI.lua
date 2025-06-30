-- chunkname: @IQIGame\\UI\\MazeSweepUI.lua

local MazeSweepUI = Base:Extend("MazeSweepUI", "IQIGame.Onigao.UI.MazeSweepUI", {
	MazeCid = 0,
	ItemCells = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function MazeSweepUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnGetSweepResult(result, mazeCid, count)
		self:OnGetSweepResult(result, mazeCid, count)
	end

	function self.DelegateOnClickSweepBtn()
		self:OnClickSweepBtn()
	end

	self.ItemCellPool = UIObjectPool.New(18, function()
		return ItemCell.New(UnityEngine.Object.Instantiate(self.ResultItemPrefab))
	end, function(cell)
		local v = cell.ViewGo

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	local cfgItemData = CfgItemTable[Constant.ItemID.ENERGY]

	self.CostIcon:GetComponent("Image").sprite = self.UIController:GetPreloadedAsset(UIGlobalApi.GetIconPath(cfgItemData.Icon))

	UGUIUtil.SetText(self.TitleText, MazeSweepUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.CloseBtn, MazeSweepUIApi:GetString("CloseBtnText"))
	UGUIUtil.SetTextInChildren(self.SweepBtn, MazeSweepUIApi:GetString("SweepBtnText"))
end

function MazeSweepUI:GetPreloadAssetPaths()
	local cfgItemData = CfgItemTable[Constant.ItemID.ENERGY]

	return {
		UIGlobalApi.GetIconPath(cfgItemData.Icon)
	}
end

function MazeSweepUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeSweepUI:IsManualShowOnOpen(userData)
	return false
end

function MazeSweepUI:GetBGM(userData)
	return nil
end

function MazeSweepUI:OnOpen(userData)
	self:UpdateView(userData.mopUpInfoList, userData.mazeCid)
end

function MazeSweepUI:OnClose(userData)
	return
end

function MazeSweepUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.SweepBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSweepBtn)
	EventDispatcher.AddEventListener(EventID.MazeSweepResult, self.DelegateOnGetSweepResult)
end

function MazeSweepUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.SweepBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSweepBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeSweepResult, self.DelegateOnGetSweepResult)
end

function MazeSweepUI:OnPause()
	return
end

function MazeSweepUI:OnResume()
	return
end

function MazeSweepUI:OnCover()
	return
end

function MazeSweepUI:OnReveal()
	return
end

function MazeSweepUI:OnRefocus(userData)
	return
end

function MazeSweepUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeSweepUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeSweepUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeSweepUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeSweepUI:OnDestroy()
	self:ClearItemCells(true)
	self.ItemCellPool:Dispose()
end

function MazeSweepUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function MazeSweepUI:UpdateView(mopUpInfoList, mazeCid)
	self.MazeCid = mazeCid
	self.CfgMazeInstanceData = CfgMazeInstanceTable[mazeCid]

	UGUIUtil.SetText(self.ResultText, MazeSweepUIApi:GetString("ResultText", #mopUpInfoList))

	local hasEnergy = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)

	UGUIUtil.SetText(self.CostNumText, tostring(hasEnergy))

	local itemShowPODList = {}

	for i = 1, #mopUpInfoList do
		local itemShowPODs = mopUpInfoList[i].rewards

		for j = 1, #itemShowPODs do
			table.insert(itemShowPODList, itemShowPODs[j])
		end
	end

	local sizeDelta = self.Bg.transform.sizeDelta

	sizeDelta.y = #itemShowPODList > 12 and 305 or 216
	self.Bg.transform.sizeDelta = sizeDelta

	self:ClearItemCells()

	local len = #itemShowPODList

	if len > 18 then
		len = 18
	end

	for i = 1, len do
		local itemCell = self.ItemCellPool:Obtain()

		itemCell.ViewGo:SetActive(true)
		itemCell.ViewGo.transform:SetParent(self.ResultGrid.transform, false)

		local itemShowPOD = itemShowPODList[i]

		itemCell:SetItemByCID(itemShowPOD.cid, itemShowPOD.num)
		table.insert(self.ItemCells, itemCell)
	end

	UIUtil.PlayDefaultAnim(self.UIController.gameObject)
end

function MazeSweepUI:ClearItemCells(isDestroy)
	for i = 1, #self.ItemCells do
		local cell = self.ItemCells[i]

		cell.ViewGo:SetActive(false)

		if not isDestroy then
			cell.ViewGo.transform:SetParent(self.UIController.transform, false)
		end

		self.ItemCellPool:Release(cell)
	end

	self.ItemCells = {}
end

function MazeSweepUI:OnGetSweepResult(mopUpInfoList, mazeCid)
	self:UpdateView(mopUpInfoList, mazeCid)
end

function MazeSweepUI:OnClickSweepBtn()
	local hasEnergy = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)

	if hasEnergy < self.CfgMazeInstanceData.Cost then
		NoticeModule.ShowNotice(21045026)

		return
	end

	UIModule.Open(Constant.UIControllerName.MazeSweepDetailConfirmUI, Constant.UILayer.UI, {
		mazeCid = self.MazeCid
	})
end

return MazeSweepUI
