-- chunkname: @IQIGame\\UI\\DreamlandRewardListUI.lua

local DreamlandRewardListUI = {
	RewardCells = {}
}

DreamlandRewardListUI = Base:Extend("DreamlandRewardListUI", "IQIGame.Onigao.UI.DreamlandRewardListUI", DreamlandRewardListUI)

require("IQIGame.UIExternalApi.DreamlandRewardListUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local DreamlandSpeRewardCell = require("IQIGame.UI.Dreamland.DreamlandSpeRewardCell")

function DreamlandRewardListUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickFSCloseBtn()
		self:OnClickFSCloseBtn()
	end

	self.RewardCellPool = UIObjectPool.New(5, function()
		local cell = DreamlandSpeRewardCell.New(UnityEngine.Object.Instantiate(self.RewardCellPrefab))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	UGUIUtil.SetText(self.TitleText, DreamlandRewardListUIApi:GetString("TitleText"))
end

function DreamlandRewardListUI:GetPreloadAssetPaths()
	return nil
end

function DreamlandRewardListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DreamlandRewardListUI:IsManualShowOnOpen(userData)
	return false
end

function DreamlandRewardListUI:GetBGM(userData)
	return nil
end

function DreamlandRewardListUI:OnOpen(userData)
	self:UpdateView()
end

function DreamlandRewardListUI:OnClose(userData)
	return
end

function DreamlandRewardListUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.FSCloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFSCloseBtn)
end

function DreamlandRewardListUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.FSCloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFSCloseBtn)
end

function DreamlandRewardListUI:OnPause()
	return
end

function DreamlandRewardListUI:OnResume()
	return
end

function DreamlandRewardListUI:OnCover()
	return
end

function DreamlandRewardListUI:OnReveal()
	return
end

function DreamlandRewardListUI:OnRefocus(userData)
	return
end

function DreamlandRewardListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DreamlandRewardListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DreamlandRewardListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DreamlandRewardListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DreamlandRewardListUI:OnDestroy()
	self:ClearRewardCells()
	self.RewardCellPool:Dispose()
end

function DreamlandRewardListUI:UpdateView()
	local cfgDreamMapListData = CfgDreamMapListTable[DreamlandModule.MapData.mapId]

	self:ClearRewardCells()

	for i = 1, #cfgDreamMapListData.SPRewardList do
		local speRewardCid = cfgDreamMapListData.SPRewardList[i]
		local cfgDreamMapSPRewardDataData = CfgDreamMapSPRewardDataTable[speRewardCid]
		local cell = self.RewardCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.RewardGrid.transform, false)
		cell:SetData(cfgDreamMapSPRewardDataData)
		table.insert(self.RewardCells, cell)
	end
end

function DreamlandRewardListUI:ClearRewardCells()
	for i = 1, #self.RewardCells do
		local cell = self.RewardCells[i]

		cell.View:SetActive(false)
		self.RewardCellPool:Release(cell)
	end

	self.RewardCells = {}
end

function DreamlandRewardListUI:OnClickCloseBtn()
	self:Close()
end

function DreamlandRewardListUI:OnClickFSCloseBtn()
	self:Close()
end

function DreamlandRewardListUI:Close()
	UIModule.CloseSelf(self)
end

return DreamlandRewardListUI
