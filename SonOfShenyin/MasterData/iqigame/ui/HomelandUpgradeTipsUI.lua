-- chunkname: @IQIGame\\UI\\HomelandUpgradeTipsUI.lua

local HomelandUpgradeTipsUI = {
	AttrItemsTable = {},
	AttrPoos = {}
}

HomelandUpgradeTipsUI = Base:Extend("HomelandUpgradeTipsUI", "IQIGame.Onigao.UI.HomelandUpgradeTipsUI", HomelandUpgradeTipsUI)

function HomelandUpgradeTipsUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)
	LuaCodeInterface.BindOutlet(self.UpgradeTipsDataView, self)

	function self.DelegateCloseBtn()
		UIModule.Close(Constant.UIControllerName.HomelandUpgradeTipsUI)
	end

	self.CloseBtn = self.CloseBtn:GetComponent("Button")
	self.HistoryLevelTextComponent = self.HistoryLevelText:GetComponent("Text")
	self.CurLevelTextComponent = self.CurLevelText:GetComponent("Text")
end

function HomelandUpgradeTipsUI:GetPreloadAssetPaths()
	return nil
end

function HomelandUpgradeTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomelandUpgradeTipsUI:IsManualShowOnOpen(userData)
	return false
end

function HomelandUpgradeTipsUI:GetBGM(userData)
	return nil
end

function HomelandUpgradeTipsUI:OnOpen(userData)
	self.CloseBtn.interactable = false

	self:__RefreshShow()
end

function HomelandUpgradeTipsUI:OnClose(userData)
	return
end

function HomelandUpgradeTipsUI:__OnInitEventDelegateFunc()
	return
end

function HomelandUpgradeTipsUI:OnAddListeners()
	self.CloseBtn.onClick:AddListener(self.DelegateCloseBtn)
end

function HomelandUpgradeTipsUI:OnRemoveListeners()
	self.CloseBtn.onClick:RemoveListener(self.DelegateCloseBtn)
end

function HomelandUpgradeTipsUI:OnPause()
	return
end

function HomelandUpgradeTipsUI:OnResume()
	return
end

function HomelandUpgradeTipsUI:OnCover()
	return
end

function HomelandUpgradeTipsUI:OnReveal()
	return
end

function HomelandUpgradeTipsUI:OnRefocus(userData)
	return
end

function HomelandUpgradeTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomelandUpgradeTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomelandUpgradeTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomelandUpgradeTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomelandUpgradeTipsUI:OnDestroy()
	ForPairs(self.AttrItemsTable, function(k, v)
		LuaCodeInterface.ClearOutlet(v.View, v)
	end)
	LuaCodeInterface.ClearOutlet(self.UpgradeTipsDataView, self)
	LuaCodeInterface.ClearOutlet(self.View, self)
end

function HomelandUpgradeTipsUI:__RefreshShow()
	local data = {}

	data.curLv = HomeModule.GetHomeLevel()
	data.historyLv = data.curLv - 1
	self.HistoryLevelTextComponent.text = data.historyLv
	self.CurLevelTextComponent.text = data.curLv

	for i = 1, #self.AttrItemsTable do
		LuaUtility.SetGameObjectShow(self.AttrItemsTable[i].View, false)
	end

	for i = 1, LuaUtility.GetChildCount(self.EffectParent.transform) do
		local child = LuaUtility.GetChild(self.EffectParent.transform, i - 1)

		LuaUtility.SetGameObjectShow(child.gameObject, false)
	end

	local index = 1

	CoroutineUtility.StartCoroutine(function()
		CoroutineUtility.Yield(CustomWaitForSeconds(1.2))

		local historyCfg = HomeModule.GetHomeLevelConfig(data.historyLv)
		local curCfg = HomeModule.GetHomeLevelConfig(data.curLv)
		local openRoomText = HomeLandApi:GetLvUpgradeOpenRoomText(curCfg.UnlockRoom)

		index = self:__ShowAttrItem(index, openRoomText)

		if curCfg.UnlickTaskQuality ~= historyCfg.UnlickTaskQuality then
			local unlockTaskQualityText = HomeLandApi:GetLvUpgradeUnlockTaskQualityText(curCfg.UnlickTaskQuality)

			index = self:__ShowAttrItem(index, unlockTaskQualityText)
		end

		if curCfg.TaskCountLimt ~= historyCfg.TaskCountLimt then
			local taskLimitText = HomeLandApi:GetLvUpgradeTaskCountLimitText(curCfg.TaskCountLimt)

			index = self:__ShowAttrItem(index, taskLimitText)
		end

		self.CloseBtn.interactable = true
	end)
end

function HomelandUpgradeTipsUI:__ShowAttrItem(index, content)
	if LuaUtility.StrIsNullOrEmpty(content) then
		return index
	end

	local attrItem = self.AttrItemsTable[index]

	if attrItem == nil then
		local attrItemObj = UnityEngine.Object.Instantiate(self.AttributeItem)
		local luaTable = {}

		attrItem = LuaCodeInterface.BindOutlet(attrItemObj, luaTable)

		attrItem.View.transform:SetParent(self.AttributeGrid.transform, false)

		self.AttrItemsTable[index] = attrItem
	end

	LuaUtility.SetGameObjectShow(attrItem.View, true)
	UGUIUtil.SetText(attrItem.CurText, content)
	LuaUtility.SetGameObjectShow(LuaUtility.GetChild(self.EffectParent.transform, index - 1).gameObject, true)
	CoroutineUtility.Yield(CustomWaitForSeconds(0.2))

	index = index + 1

	return index
end

return HomelandUpgradeTipsUI
