-- chunkname: @IQIGame\\UI\\CelebrationGiftUI.lua

local CelebrationGiftUI = {
	openCelebrationGifts = {},
	celebrationGiftViews = {},
	celebrationGiftToggleCellPool = {}
}

CelebrationGiftUI = Base:Extend("CelebrationGiftUI", "IQIGame.Onigao.UI.CelebrationGiftUI", CelebrationGiftUI)

require("IQIGame.UIExternalApi.CelebrationGiftUIApi")

local CelebrationGiftToggleCell = require("IQIGame.UI.CelebrationGift.CelebrationGiftToggleCell")
local CelebrationGiftView = require("IQIGame.UI.CelebrationGift.CelebrationGiftView")

function CelebrationGiftUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnBtnClose()
	end

	function self.DelegatePlayerInfoChanged()
		self:OnPlayerInfoChange()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectCell(cell)
	end
	self.celebrationGiftViews = {}

	for i, v in pairs(self.openCelebrationGifts) do
		local path = UIGlobalApi.GetPrefabRoot(CfgGiftBoxTable[v].GiftBoxPrefab)

		log("CelebrationGiftUI path = " .. path)

		local viewPrefab = self.UIController:GetPreloadedAsset(path)
		local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

		viewInstance.transform:SetParent(self.ViewRoot.transform, false)
		UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)

		local giftView = CelebrationGiftView.New(viewInstance)

		giftView:SetData(v)
		giftView:Close()

		self.celebrationGiftViews[v] = giftView
	end
end

function CelebrationGiftUI:GetPreloadAssetPaths()
	self.openCelebrationGifts = CelebrationGiftModule.GetOpenGiftBox()

	local paths = {}

	for i, v in pairs(self.openCelebrationGifts) do
		local path = UIGlobalApi.GetPrefabRoot(CfgGiftBoxTable[v].GiftBoxPrefab)

		table.insert(paths, path)
	end

	return paths
end

function CelebrationGiftUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CelebrationGiftUI:IsManualShowOnOpen(userData)
	return false
end

function CelebrationGiftUI:GetBGM(userData)
	return nil
end

function CelebrationGiftUI:OnOpen(userData)
	self:UpdateView()
end

function CelebrationGiftUI:OnClose(userData)
	for i, v in pairs(self.celebrationGiftViews) do
		v:Close()
	end
end

function CelebrationGiftUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, self.DelegatePlayerInfoChanged)
end

function CelebrationGiftUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, self.DelegatePlayerInfoChanged)
end

function CelebrationGiftUI:OnPause()
	return
end

function CelebrationGiftUI:OnResume()
	return
end

function CelebrationGiftUI:OnCover()
	return
end

function CelebrationGiftUI:OnReveal()
	return
end

function CelebrationGiftUI:OnRefocus(userData)
	return
end

function CelebrationGiftUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CelebrationGiftUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CelebrationGiftUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CelebrationGiftUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CelebrationGiftUI:OnDestroy()
	for i, v in pairs(self.celebrationGiftToggleCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.celebrationGiftViews) do
		v:Dispose()
	end
end

function CelebrationGiftUI:OnPlayerInfoChange()
	local result = CelebrationGiftModule.IsOpen()

	if result then
		self.openCelebrationGifts = CelebrationGiftModule.GetOpenGiftBox()

		if self.selectCelebrationGiftID ~= nil and table.indexOf(self.openCelebrationGifts, self.selectCelebrationGiftID) == -1 then
			self.selectCelebrationGiftID = nil
		end

		self:UpdateView()
	else
		self:OnBtnClose()
	end
end

function CelebrationGiftUI:UpdateView()
	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.openCelebrationGifts)
	self:RefreshView()
end

function CelebrationGiftUI:RefreshView()
	for i, v in pairs(self.celebrationGiftViews) do
		if v.cid == self.selectCelebrationGiftID then
			v:Open()
		else
			v:Close()
		end
	end
end

function CelebrationGiftUI:OnRenderCell(cell)
	local celebrationGiftID = self.openCelebrationGifts[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local celebrationGiftToggleCell = self.celebrationGiftToggleCellPool[instanceID]

	if celebrationGiftToggleCell == nil then
		celebrationGiftToggleCell = CelebrationGiftToggleCell.New(cell.gameObject)
		self.celebrationGiftToggleCellPool[instanceID] = celebrationGiftToggleCell
	end

	celebrationGiftToggleCell:SetData(celebrationGiftID)

	if self.selectCelebrationGiftID == nil then
		self.selectCelebrationGiftID = celebrationGiftID
	end

	celebrationGiftToggleCell:SetSelect(self.selectCelebrationGiftID == celebrationGiftID)
end

function CelebrationGiftUI:OnSelectCell(cell)
	self.selectCelebrationGiftID = self.openCelebrationGifts[cell.index + 1]

	for i, v in pairs(self.celebrationGiftToggleCellPool) do
		v:SetSelect(v.cid == self.selectCelebrationGiftID)
	end

	self:RefreshView()
end

function CelebrationGiftUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

return CelebrationGiftUI
