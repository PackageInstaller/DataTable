-- chunkname: @IQIGame\\UI\\EndlessMazeRuneSuitTipUI.lua

local EndlessMazeRuneSuitTipUI = Base:Extend("EndlessMazeRuneSuitTipUI", "IQIGame.Onigao.UI.EndlessMazeRuneSuitTipUI", {
	EffectItems = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local EndlessMazeRuneSuitEffectItem = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneSuitEffectItem")

function EndlessMazeRuneSuitTipUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.EffectItemPool = UIObjectPool.New(6, function()
		return EndlessMazeRuneSuitEffectItem.New(UnityEngine.Object.Instantiate(self.EffectItemPrefab))
	end, function(item)
		local v = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
end

function EndlessMazeRuneSuitTipUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeRuneSuitTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneSuitTipUI:IsManualShowOnOpen(userData)
	return false
end

function EndlessMazeRuneSuitTipUI:GetBGM(userData)
	return nil
end

function EndlessMazeRuneSuitTipUI:OnOpen(userData)
	self:UpdateView(userData.suitCid, userData.partNum, userData.srcTrans, userData.srcSide, userData.tipSide)
end

function EndlessMazeRuneSuitTipUI:OnClose(userData)
	return
end

function EndlessMazeRuneSuitTipUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneSuitTipUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneSuitTipUI:OnPause()
	return
end

function EndlessMazeRuneSuitTipUI:OnResume()
	return
end

function EndlessMazeRuneSuitTipUI:OnCover()
	return
end

function EndlessMazeRuneSuitTipUI:OnReveal()
	return
end

function EndlessMazeRuneSuitTipUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneSuitTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneSuitTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneSuitTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneSuitTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneSuitTipUI:OnDestroy()
	self:ClearEffectItems(true)
	self.EffectItemPool:Dispose()
end

function EndlessMazeRuneSuitTipUI:UpdateView(suitCid, partNum, srcTrans, srcSide, tipSide)
	local cfgRuneConstituteData = CfgRuneConstituteTable[suitCid]

	UGUIUtil.SetText(self.NameText, EndlessMazeRuneSuitTipUIApi:GetString("NameText", cfgRuneConstituteData.Name, partNum))
	UGUIUtil.SetText(self.DescText, cfgRuneConstituteData.Describe)
	self:ClearEffectItems()

	for i = 1, #cfgRuneConstituteData.RuneNum do
		local needNum = cfgRuneConstituteData.RuneNum[i]
		local activeBuff = cfgRuneConstituteData.Buff[i]
		local activeAttr = cfgRuneConstituteData.Attribute[i]
		local effectItem = self.EffectItemPool:Obtain()

		effectItem.View:SetActive(true)
		effectItem.View.transform:SetParent(self.EffectGrid.transform, false)
		effectItem:SetData(needNum, needNum <= partNum, activeBuff, activeAttr)
		table.insert(self.EffectItems, effectItem)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Content.transform)
	UIUtil.AdjustUIInScreen(self.UIController:GetComponent("Canvas"), srcTrans, self.Content.transform, Vector2.zero, srcSide, tipSide)
end

function EndlessMazeRuneSuitTipUI:ClearEffectItems(isDestroy)
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

function EndlessMazeRuneSuitTipUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return EndlessMazeRuneSuitTipUI
