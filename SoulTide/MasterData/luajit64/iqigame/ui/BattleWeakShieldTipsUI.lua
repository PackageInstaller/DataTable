-- chunkname: @IQIGame\\UI\\BattleWeakShieldTipsUI.lua

local BattleWeakShieldTipsUI = Base:Extend("BattleWeakShieldTipsUI", "IQIGame.Onigao.UI.BattleWeakShieldTipsUI", {
	WeakShieldTipItems = {}
})

require("IQIGame.UIExternalApi.BattleWeakShieldTipsUIApi")

local BattleWeakShieldTipItem = require("IQIGame.UI.BattleWeakShieldTips.BattleWeakShieldTipItem")

function BattleWeakShieldTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	for i = 1, Constant.BattleDamageType.ElementTypeNum do
		local itemGo = UnityEngine.Object.Instantiate(self.WeakItemPrefab)

		itemGo.transform:SetParent(self.WeakGrid.transform, false)

		local cell = BattleWeakShieldTipItem.New(itemGo, i)

		self.WeakShieldTipItems[i] = cell
	end

	UGUIUtil.SetText(self.TitleText, BattleWeakShieldTipsUIApi:GetString("TitleText"))
end

function BattleWeakShieldTipsUI:GetPreloadAssetPaths()
	return nil
end

function BattleWeakShieldTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BattleWeakShieldTipsUI:IsManualShowOnOpen(userData)
	return false
end

function BattleWeakShieldTipsUI:GetBGM(userData)
	return nil
end

function BattleWeakShieldTipsUI:OnOpen(userData)
	if userData == nil then
		return
	end

	self:UpdateView(userData.unitId, userData.monsterCid)
end

function BattleWeakShieldTipsUI:OnClose(userData)
	return
end

function BattleWeakShieldTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function BattleWeakShieldTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function BattleWeakShieldTipsUI:OnPause()
	return
end

function BattleWeakShieldTipsUI:OnResume()
	return
end

function BattleWeakShieldTipsUI:OnCover()
	return
end

function BattleWeakShieldTipsUI:OnReveal()
	return
end

function BattleWeakShieldTipsUI:OnRefocus(userData)
	return
end

function BattleWeakShieldTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BattleWeakShieldTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleWeakShieldTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleWeakShieldTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleWeakShieldTipsUI:OnDestroy()
	return
end

function BattleWeakShieldTipsUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function BattleWeakShieldTipsUI:UpdateView(unitId, monsterCid)
	local shieldTypes = {}

	if unitId ~= nil then
		local battleUnitData = BattleModule.GetBattleUnitData(unitId)

		for i = 0, battleUnitData.WeakTypes.Length - 1 do
			shieldTypes[i + 1] = battleUnitData.WeakTypes[i]
		end
	else
		local cfgMonsterData = CfgMonsterTable[monsterCid]

		for i = 1, #cfgMonsterData.WeakType do
			shieldTypes[i] = cfgMonsterData.WeakType[i]
		end
	end

	for i = 1, #self.WeakShieldTipItems do
		local item = self.WeakShieldTipItems[i]

		item:SetEnabled(table.indexOf(shieldTypes, i) ~= -1)
	end
end

return BattleWeakShieldTipsUI
