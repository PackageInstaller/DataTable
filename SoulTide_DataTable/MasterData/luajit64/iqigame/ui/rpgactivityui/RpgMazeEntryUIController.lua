-- chunkname: @IQIGame\\UI\\RPGActivityUI\\RpgMazeEntryUIController.lua

local RpgMazeEntryMazeCell = require("IQIGame.UI.RpgMaze.RpgMazeEntryMazeCell")
local RpgBossTicketCell = require("IQIGame.UI.ExploreHall.RpgBossTicketCell")
local RpgMazeEntryUIController = {
	MazeCells = {},
	CurrencyControllers = {}
}

function RpgMazeEntryUIController.New(uiController)
	local obj = Clone(RpgMazeEntryUIController)

	obj:__Init(uiController)

	return obj
end

function RpgMazeEntryUIController:__Init(uiController)
	self.UIController = uiController
end

function RpgMazeEntryUIController:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function RpgMazeEntryUIController:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	self.TicketCell = RpgBossTicketCell.New(self.TicketGo)

	local scrollAreaList = self.ScrollAreaList:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectCell(cell)
	end

	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	self:AddCurrencyCell(cfgRPGMazeControlData.ScoreItem)
	UGUIUtil.SetText(self.TitleText, RpgMazeEntryUIApi:GetString("TitleText", RpgMazeModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetTextInChildren(self.ShopBtn, RpgMazeEntryUIApi:GetString("ShopBtnText", RpgMazeModule.DailyDupPOD.common.openCount))
end

function RpgMazeEntryUIController:GetPreloadAssetPaths()
	return {
		AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")
	}
end

function RpgMazeEntryUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RpgMazeEntryUIController:IsManualShowOnOpen(userData)
	return false
end

function RpgMazeEntryUIController:GetBGM(userData)
	return nil
end

function RpgMazeEntryUIController:OnOpen(userData)
	self:UpdateView()
end

function RpgMazeEntryUIController:OnClose(userData)
	return
end

function RpgMazeEntryUIController:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
end

function RpgMazeEntryUIController:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
end

function RpgMazeEntryUIController:OnPause()
	return
end

function RpgMazeEntryUIController:OnResume()
	return
end

function RpgMazeEntryUIController:OnCover()
	return
end

function RpgMazeEntryUIController:OnReveal()
	return
end

function RpgMazeEntryUIController:OnRefocus(userData)
	return
end

function RpgMazeEntryUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RpgMazeEntryUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RpgMazeEntryUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RpgMazeEntryUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RpgMazeEntryUIController:OnDestroy()
	self.TicketCell:Dispose()

	for gameObject, mazeCell in pairs(self.MazeCells) do
		mazeCell:Dispose()
	end

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function RpgMazeEntryUIController:UpdateView()
	self.TicketCell:Refresh()

	self.CfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	local scrollAreaList = self.ScrollAreaList:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.CfgRPGMazeControlData.MazeInstances)
end

function RpgMazeEntryUIController:OnRenderCell(cell)
	local mazeCell = self.MazeCells[cell.gameObject]

	if mazeCell == nil then
		mazeCell = RpgMazeEntryMazeCell.New(cell.gameObject)
		self.MazeCells[cell.gameObject] = mazeCell
	end

	mazeCell:SetData(self.CfgRPGMazeControlData.MazeInstances[cell.index + 1], self.CfgRPGMazeControlData.BossList[cell.index + 1])
end

function RpgMazeEntryUIController:OnSelectCell(cell)
	local mazeCell = self.MazeCells[cell.gameObject]

	if not mazeCell.IsUnlock then
		return
	end

	if RpgMazeModule.DailyDupPOD == nil or RpgMazeModule.DailyDupPOD.common.status ~= 1 then
		NoticeModule.ShowNotice(21057003)

		return
	end

	UIModule.Open(Constant.UIControllerName.RpgMazeDetailUI, Constant.UILayer.UI, {
		mazeCid = mazeCell.MazeInstanceCid
	})
end

function RpgMazeEntryUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function RpgMazeEntryUIController:OnClickShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.RpgMaze, RpgMazeModule.GetMallCidList())
end

function RpgMazeEntryUIController:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(self.CurrencyCom.transform, false)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

return RpgMazeEntryUIController
