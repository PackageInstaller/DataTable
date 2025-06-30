-- chunkname: @IQIGame\\UI\\Chapter\\TowerChapter\\TowerChapterView.lua

local TowerUI = Base:Extend("TowerUI", "IQIGame.Onigao.UI.TowerUI", {
	Obj = {},
	towerIconDict = {}
})
local TowerIconPanel = require("IQIGame.UI.Tower.TowerIconPanel")
local TowerDetailPanel = require("IQIGame.UI.Tower.TowerDetailPanel")

function TowerUI.New(obj)
	local tbl = Clone(TowerUI)

	tbl:OnInit(obj)

	return tbl
end

function TowerUI:OnInit(obj)
	self.gameObject = obj

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.towerDetailPanel = TowerDetailPanel.New(self.TowerDetailPanelObject)

	self.towerDetailPanel:OnClose()
	TowerIconPanel:OnInit(self.TowerIconPanelObject)
	TowerIconPanel:OnClose()
	self:InitTowerIcon()

	function self.delegateRefresh()
		self:Refresh()
	end

	function self.delegateOnCloseBtnClick()
		self:OnCloseBtnClick()
	end

	self:OnAddListeners()
end

function TowerUI:OnDestroy()
	logDebug("TowerUI:OnDestroy()")
	self:OnRemoveListeners()
	self:DestroyAllTowerIcon()
	self.towerDetailPanel:OnDestroy()

	self.TowerIconPanelObject = nil
	self.TowerDetailPanelObject = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function TowerUI:OnOpen(userData)
	self:OpenTowerIcon()
end

function TowerUI:Refresh(userData)
	logDebug("TowerUI:Refresh()")
	self:RefreshTowerIcon()
end

function TowerUI:InitTowerIcon()
	self.towerIconDict = {}

	for index, tower in pairs(CfgTowerChapterTable) do
		local towerIconPanel = TowerIconPanel.New(self.TowerIconPanelObject, self.TowerMapImage.transform, tower.Id)

		self.towerIconDict[tower.Id] = towerIconPanel
	end
end

function TowerUI:OpenTowerIcon()
	for _, towerIcon in pairs(self.towerIconDict) do
		towerIcon:OnOpen()
	end
end

function TowerUI:CloseTowerIcon()
	for _, towerIcon in pairs(self.towerIconDict) do
		towerIcon:OnClose()
	end
end

function TowerUI:RefreshTowerIcon()
	logDebug("TowerUI:ResetTowerIcon")

	for towerID, towerIconPanel in pairs(self.towerIconDict) do
		towerIconPanel:Refresh()
	end
end

function TowerUI:Show()
	self.gameObject:SetActive(true)
	self:OnOpen()
end

function TowerUI:Hide()
	self.gameObject:SetActive(false)
end

function TowerUI:DestroyAllTowerIcon()
	logDebug("TowerUI:DestroyTowerIcon()")

	for _, towerIconPanel in pairs(self.towerIconDict) do
		towerIconPanel:Dispose()

		towerIconPanel = {}
	end

	self.towerIconDict = {}
end

function TowerUI:OnClose(userData)
	logDebug("TowerUI:OnClose()")
	self:CloseTowerIcon()
	self.towerDetailPanel:OnClose()
end

function TowerUI:GetPreloadAssetPaths()
	return nil
end

function TowerUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TowerUI:OnPause()
	return
end

function TowerUI:OnResume()
	return
end

function TowerUI:OnCover()
	return
end

function TowerUI:OnReveal()
	return
end

function TowerUI:OnRefocus(userData)
	return
end

function TowerUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TowerUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TowerUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TowerUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TowerUI:LoadCommonSlotPrefab()
	return
end

function TowerUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.RefreshTowerCfg, self.delegateRefresh)
end

function TowerUI:Refresh()
	self:RefreshTowerIcon()
end

function TowerUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.RefreshTowerCfg, self.delegateRefresh)
end

return TowerUI
