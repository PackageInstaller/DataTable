-- chunkname: @IQIGame\\UI\\EvilErosionBuffTipsUI.lua

require("IQIGame.UIExternalApi.EvilErosionBuffTipsUIApi")

local EvilErosionBuffItem = require("IQIGame.UI.EvilErosion.EvilErosionBuffItem")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local EvilErosionBuffTipsUI = {
	BuffInfoItems = {}
}

EvilErosionBuffTipsUI = Base:Extend("EvilErosionBuffTipsUI", "IQIGame.Onigao.UI.EvilErosionBuffTipsUI", EvilErosionBuffTipsUI)

function EvilErosionBuffTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.BuffItemPool = UIObjectPool.New(5, function()
		return EvilErosionBuffItem.New(UnityEngine.Object.Instantiate(self.BuffInfoItemPrefab))
	end, function(cell)
		local view = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(view)
	end)
end

function EvilErosionBuffTipsUI:GetPreloadAssetPaths()
	return nil
end

function EvilErosionBuffTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EvilErosionBuffTipsUI:IsManualShowOnOpen(userData)
	return false
end

function EvilErosionBuffTipsUI:GetBGM(userData)
	return nil
end

function EvilErosionBuffTipsUI:OnOpen(userData)
	self:UpdateView(userData.speEffectCids, userData.srcTrans, userData.srcSide, userData.tipSide)
end

function EvilErosionBuffTipsUI:OnClose(userData)
	return
end

function EvilErosionBuffTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EvilErosionBuffTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EvilErosionBuffTipsUI:OnPause()
	return
end

function EvilErosionBuffTipsUI:OnResume()
	return
end

function EvilErosionBuffTipsUI:OnCover()
	return
end

function EvilErosionBuffTipsUI:OnReveal()
	return
end

function EvilErosionBuffTipsUI:OnRefocus(userData)
	return
end

function EvilErosionBuffTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EvilErosionBuffTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EvilErosionBuffTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EvilErosionBuffTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EvilErosionBuffTipsUI:OnDestroy()
	self:Clear()
	self.BuffItemPool:Dispose()
end

function EvilErosionBuffTipsUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EvilErosionBuffTipsUI:UpdateView(speEffectCids, srcTrans, srcSide, tipSide)
	self:Clear()

	for i = 1, #speEffectCids do
		local speEffectCid = speEffectCids[i]
		local item = self.BuffItemPool:Obtain()

		item.View.transform:SetParent(self.BuffItemContent.transform, false)
		item.View:SetActive(true)
		item:SetData(speEffectCid)
		table.insert(self.BuffInfoItems, item)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Content.transform)
	UIUtil.AdjustUIInScreen(self.UIController:GetComponent("Canvas"), srcTrans, self.Content.transform, Vector2.zero, srcSide, tipSide)
end

function EvilErosionBuffTipsUI:Clear()
	for i = 1, #self.BuffInfoItems do
		local item = self.BuffInfoItems[i]

		item.View.transform:SetParent(self.UIController.transform, false)
		item.View:SetActive(false)
		self.BuffItemPool:Release(item)
	end

	self.BuffInfoItems = {}
end

return EvilErosionBuffTipsUI
