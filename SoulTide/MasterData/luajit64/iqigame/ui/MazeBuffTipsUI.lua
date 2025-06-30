-- chunkname: @IQIGame\\UI\\MazeBuffTipsUI.lua

local MazeBuffTipsUI = Base:Extend("MazeBuffTipsUI", "IQIGame.Onigao.UI.MazeBuffTipsUI", {
	BuffItems = {}
})
local MazeBuffTipInfoUI = require("IQIGame.UI.MazeBuffTips.MazeBuffTipInfoUI")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function MazeBuffTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.UIObjectPool = UIObjectPool.New(10, function()
		return MazeBuffTipInfoUI.New(UnityEngine.Object.Instantiate(self.BuffInfoItemPrefab))
	end, function(item)
		local tempItem = item
		local view = tempItem.View

		tempItem:Dispose()
		UnityEngine.Object.Destroy(view)
	end)
end

function MazeBuffTipsUI:GetPreloadAssetPaths()
	return nil
end

function MazeBuffTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeBuffTipsUI:OnOpen(userData)
	self:UpdateView(userData.buffs, userData.tipTrans)
end

function MazeBuffTipsUI:OnClose(userData)
	return
end

function MazeBuffTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function MazeBuffTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function MazeBuffTipsUI:OnPause()
	return
end

function MazeBuffTipsUI:OnResume()
	return
end

function MazeBuffTipsUI:OnCover()
	return
end

function MazeBuffTipsUI:OnReveal()
	return
end

function MazeBuffTipsUI:OnRefocus(userData)
	return
end

function MazeBuffTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeBuffTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeBuffTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeBuffTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeBuffTipsUI:OnDestroy()
	self:ClearBuffItems(true)
	self.UIObjectPool:Dispose()
end

function MazeBuffTipsUI:UpdateView(buffs, tipTrans)
	self.Buffs = {}

	for i = 1, #buffs do
		local cfgBuffData = CfgBuffTable[buffs[i].CID]

		if cfgBuffData.IsVisible then
			table.insert(self.Buffs, buffs[i])
		end
	end

	self:ClearBuffItems()

	for i = 1, #self.Buffs do
		local buffPOD = self.Buffs[i]
		local buffItem = self.UIObjectPool:Obtain()

		buffItem.View:SetActive(true)
		buffItem.View.transform:SetParent(self.BuffItemContent.transform, false)
		buffItem:SetData(buffPOD)

		self.BuffItems[i] = buffItem
	end

	local transform = self.Content.transform

	transform.anchorMax = tipTrans.anchorMax
	transform.anchorMin = tipTrans.anchorMin
	transform.pivot = tipTrans.pivot
	transform.position = tipTrans.position
end

function MazeBuffTipsUI:ClearBuffItems(destroy)
	for i = 1, #self.BuffItems do
		local buffItem = self.BuffItems[i]

		buffItem.View:SetActive(false)

		if not destroy then
			buffItem.View.transform:SetParent(self.UIController.transform, false)
		end

		self.UIObjectPool:Release(buffItem)
	end

	self.BuffItems = {}
end

function MazeBuffTipsUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.MazeBuffTipsUI)
end

return MazeBuffTipsUI
