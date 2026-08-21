-- chunkname: @IQIGame\\UI\\EndlessMazeRuneLegendSuitTipUI.lua

local EndlessMazeRuneLegendSuitTipUI = {
	EffectItems = {}
}

EndlessMazeRuneLegendSuitTipUI = Base:Extend("EndlessMazeRuneLegendSuitTipUI", "IQIGame.Onigao.UI.EndlessMazeRuneLegendSuitTipUI", EndlessMazeRuneLegendSuitTipUI)

require("IQIGame.UIExternalApi.EndlessMazeRuneLegendSuitTipUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local EndlessMazeRuneLegendSuitEffectItem = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneLegendSuitEffectItem")

function EndlessMazeRuneLegendSuitTipUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.EffectItemPool = UIObjectPool.New(6, function()
		return EndlessMazeRuneLegendSuitEffectItem.New(UnityEngine.Object.Instantiate(self.EffectItemPrefab))
	end, function(item)
		local v = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
end

function EndlessMazeRuneLegendSuitTipUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeRuneLegendSuitTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneLegendSuitTipUI:IsManualShowOnOpen(userData)
	return false
end

function EndlessMazeRuneLegendSuitTipUI:GetBGM(userData)
	return nil
end

function EndlessMazeRuneLegendSuitTipUI:OnOpen(userData)
	self:UpdateView(userData.list, userData.srcTrans, userData.srcSide, userData.tipSide)
end

function EndlessMazeRuneLegendSuitTipUI:OnClose(userData)
	return
end

function EndlessMazeRuneLegendSuitTipUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneLegendSuitTipUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneLegendSuitTipUI:OnPause()
	return
end

function EndlessMazeRuneLegendSuitTipUI:OnResume()
	return
end

function EndlessMazeRuneLegendSuitTipUI:OnCover()
	return
end

function EndlessMazeRuneLegendSuitTipUI:OnReveal()
	return
end

function EndlessMazeRuneLegendSuitTipUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneLegendSuitTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneLegendSuitTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneLegendSuitTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneLegendSuitTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneLegendSuitTipUI:OnDestroy()
	self:ClearEffectItems(true)
	self.EffectItemPool:Dispose()
end

function EndlessMazeRuneLegendSuitTipUI:UpdateView(list, srcTrans, srcSide, tipSide)
	UGUIUtil.SetText(self.NameText, EndlessMazeRuneLegendSuitTipUIApi:GetString("NameText", #list))
	self:ClearEffectItems()

	for i = 1, #list do
		local effectItem = self.EffectItemPool:Obtain()

		effectItem.View:SetActive(true)
		effectItem.View.transform:SetParent(self.EffectGrid.transform, false)
		effectItem:SetData(i, list[i])
		table.insert(self.EffectItems, effectItem)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Content.transform)
	UIUtil.AdjustUIInScreen(self.UIController:GetComponent("Canvas"), srcTrans, self.Content.transform, Vector2.zero, srcSide, tipSide)
end

function EndlessMazeRuneLegendSuitTipUI:ClearEffectItems(isDestroy)
	for i = 1, #self.EffectItems do
		local item = self.EffectItems[i]

		item.View:SetActive(false)

		if not isDestroy then
			item.View.transform:SetParent(self.UIController.transform, false)
		end

		self.EffectItemPool:Release(item)
	end

	self.EffectItems = {}
end

function EndlessMazeRuneLegendSuitTipUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return EndlessMazeRuneLegendSuitTipUI
