-- chunkname: @IQIGame\\UI\\UpgradeTipsUI.lua

local UpgradeTipsUI = Base:Extend("UpgradeTipsUI", "IQIGame.Onigao.UI.UpgradeTipsUI", {
	AttrItemsTable = {},
	AttrPoos = {}
})

function UpgradeTipsUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)
	LuaCodeInterface.BindOutlet(self.UpgradeTipsDataView, self)

	function self.DelegateCloseBtn()
		UIModule.Close(Constant.UIControllerName.UpgradeTipsUI)
	end

	self.CloseBtn = self.CloseBtn:GetComponent("Button")
	self.HistoryLevelTextComponent = self.HistoryLevelText:GetComponent("Text")
	self.CurLevelTextComponent = self.CurLevelText:GetComponent("Text")
end

function UpgradeTipsUI:GetPreloadAssetPaths()
	return nil
end

function UpgradeTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function UpgradeTipsUI:IsManualShowOnOpen(userData)
	return false
end

function UpgradeTipsUI:GetBGM(userData)
	return nil
end

function UpgradeTipsUI:OnOpen(userData)
	self.CloseBtn.interactable = false

	self:SetUpgradeData(userData)
end

function UpgradeTipsUI:OnClose(userData)
	return
end

function UpgradeTipsUI:OnAddListeners()
	self.CloseBtn.onClick:AddListener(self.DelegateCloseBtn)
end

function UpgradeTipsUI:OnRemoveListeners()
	self.CloseBtn.onClick:RemoveListener(self.DelegateCloseBtn)
end

function UpgradeTipsUI:OnPause()
	return
end

function UpgradeTipsUI:OnResume()
	return
end

function UpgradeTipsUI:OnCover()
	return
end

function UpgradeTipsUI:OnReveal()
	return
end

function UpgradeTipsUI:OnRefocus(userData)
	return
end

function UpgradeTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function UpgradeTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function UpgradeTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function UpgradeTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function UpgradeTipsUI:SetUpgradeData(_data)
	local data = _data

	self.HistoryLevelTextComponent.text = data.historyLv
	self.CurLevelTextComponent.text = data.curLv

	for i = 1, #self.AttrItemsTable do
		LuaUtility.SetGameObjectShow(self.AttrItemsTable[i].View, false)
	end

	for i = 1, LuaUtility.GetChildCount(self.EffectParent.transform) do
		LuaUtility.SetGameObjectShow(LuaUtility.GetChild(self.EffectParent.transform, i - 1).gameObject, false)
	end

	local index = 1
	local effctIndex = 1

	CoroutineUtility.StartCoroutine(function()
		CoroutineUtility.Yield(CustomWaitForSeconds(1.2))

		for k, v in pairs(data.curAttr) do
			if data.curAttr[k].value == data.historyAttr[k].value then
				break
			end

			if RoleDevelopmentModule.GetAttrCfg(k) and RoleDevelopmentModule.GetAttrCfg(k).Show then
				local attrItem = self.AttrItemsTable[index]

				if attrItem == nil then
					local attrItemObj = UnityEngine.Object.Instantiate(self.AttributeItem)
					local luaTable = {}

					attrItem = LuaCodeInterface.BindOutlet(attrItemObj, luaTable)
					self.AttrItemsTable[index] = attrItem
				end

				UGUIUtil.SetText(attrItem.AttName, RoleDevelopmentModule.GetAttrCfg(k).Name)
				UGUIUtil.SetText(attrItem.CurText, v.value)
				UGUIUtil.SetText(attrItem.HistroryText, data.historyAttr[k].value)
				AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(RoleDevelopmentModule.GetAttrCfg(k).ImageUrl), attrItem.AttImg:GetComponent("Image"))
				attrItem.View.transform:SetParent(self.AttributeGrid.transform, false)
				LuaUtility.SetGameObjectShow(attrItem.View, true)

				index = index + 1

				CoroutineUtility.Yield(CustomWaitForSeconds(0.2))
			end
		end

		self.CloseBtn.interactable = true
	end)
end

function UpgradeTipsUI:OnDestroy()
	for i = 1, #self.AttrItemsTable do
		UnityEngine.Object.Destroy(self.AttrItemsTable[i].View)

		self.AttrItemsTable[i] = nil
	end

	AssetUtil.UnloadAsset(self)
end

return UpgradeTipsUI
