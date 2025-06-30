-- chunkname: @IQIGame\\UI\\EndlessMazeEntryUI.lua

local EndlessMazeEntryUI = Base:Extend("EndlessMazeEntryUI", "IQIGame.Onigao.UI.EndlessMazeEntryUI", {
	MazeCells = {},
	abyssCids = {},
	endlessMazeEntryRenderPool = {}
})
local EndlessMazeEntryRenderCell = require("IQIGame.UI.Maze.EndlessMazeEntryRenderCell")

function EndlessMazeEntryUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnUpdateAbyss()
		self:OnUpdateAbyss()
	end

	function self.DelegateBtnTip()
		self:OnBtnTip()
	end

	self.MazeList:GetComponent("ScrollAreaListPage").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
	self.MazeList:GetComponent("ScrollAreaListPage").onPageReachedMainPos = function(page)
		self:OnPageReachedMain(page)
	end

	UGUIUtil.SetText(self.TitleText, EndlessMazeEntryUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.TipText, EndlessMazeEntryUIApi:GetString("TipText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, EndlessMazeEntryUIApi:GetString("ConfirmBtnText"))
end

function EndlessMazeEntryUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeEntryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeEntryUI:IsManualShowOnOpen(userData)
	return false
end

function EndlessMazeEntryUI:GetBGM(userData)
	return nil
end

function EndlessMazeEntryUI:OnOpen(userData)
	self:UpdateView()
end

function EndlessMazeEntryUI:OnClose(userData)
	return
end

function EndlessMazeEntryUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.DelegateBtnTip)
	EventDispatcher.AddEventListener(EventID.UpdateAbyss, self.DelegateOnUpdateAbyss)
end

function EndlessMazeEntryUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnTip)
	EventDispatcher.RemoveEventListener(EventID.UpdateAbyss, self.DelegateOnUpdateAbyss)
end

function EndlessMazeEntryUI:OnPause()
	return
end

function EndlessMazeEntryUI:OnResume()
	return
end

function EndlessMazeEntryUI:OnCover()
	return
end

function EndlessMazeEntryUI:OnReveal()
	return
end

function EndlessMazeEntryUI:OnRefocus(userData)
	return
end

function EndlessMazeEntryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeEntryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeEntryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeEntryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeEntryUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.endlessMazeEntryRenderPool) do
		v:Dispose()
	end
end

function EndlessMazeEntryUI:UpdateView()
	self:RefreshList()
end

function EndlessMazeEntryUI:ShowSelectPage()
	if self.selectCid == 0 or self.selectCid == nil then
		return
	end

	local cfgMazeInstanceData = CfgMazeInstanceTable[self.selectCid]

	UGUIUtil.SetText(self.NameText, cfgMazeInstanceData.Name)
	UGUIUtil.SetText(self.LeftCountText, EndlessMazeEntryUIApi:GetString("LeftCountText", WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ABYSS_COUNT)))
end

function EndlessMazeEntryUI:RefreshList()
	self.abyssCids = PlayerModule.PlayerInfo.abyssCids or {}

	local index = 0

	if PlayerModule.PlayerInfo.abyssCid ~= 0 then
		index = table.indexOf(self.abyssCids, PlayerModule.PlayerInfo.adyssCid)

		if index == -1 then
			index = 0
		end
	end

	self.MazeList:GetComponent("ScrollAreaListPage").startIndex = index

	self.MazeList:GetComponent("ScrollAreaListPage"):Refresh(#self.abyssCids)
end

function EndlessMazeEntryUI:OnClickConfirmBtn()
	if self.selectCid == 0 or self.selectCid == nil then
		return
	end

	UIModule.Open(Constant.UIControllerName.EndlessMazeDetailUI, Constant.UILayer.UI, {
		mazeCid = self.selectCid
	})
end

function EndlessMazeEntryUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EndlessMazeEntryUI:OnUpdateAbyss()
	self:UpdateView()
end

function EndlessMazeEntryUI:OnRenderCell(pageCell)
	local cid = self.abyssCids[pageCell.index + 1]
	local instanceID = pageCell.gameObject:GetInstanceID()
	local cell = self.endlessMazeEntryRenderPool[instanceID]

	if cell == nil then
		cell = EndlessMazeEntryRenderCell.New(pageCell.gameObject)
		self.endlessMazeEntryRenderPool[instanceID] = cell
	end

	cell:SetData(cid)
	cell:SetSelect(cid == self.selectCid)
end

function EndlessMazeEntryUI:OnPageReachedMain(page)
	self.selectCid = self.abyssCids[page.index + 1]

	for i, v in pairs(self.endlessMazeEntryRenderPool) do
		v:SetSelect(v.cid == self.selectCid)
	end

	self:ShowSelectPage()
end

function EndlessMazeEntryUI:OnBtnTip()
	UIModule.Open(Constant.UIControllerName.TextTipsUI, Constant.UILayer.UI, {
		EndlessMazeEntryUIApi:GetString("BtnTipDes")
	})
end

return EndlessMazeEntryUI
