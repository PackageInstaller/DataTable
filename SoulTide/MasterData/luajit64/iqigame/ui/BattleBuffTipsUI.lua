-- chunkname: @IQIGame\\UI\\BattleBuffTipsUI.lua

local BattleBuffTipsUI = Base:Extend("BattleBuffTipsUI", "IQIGame.Onigao.UI.BattleBuffTipsUI", {
	HostTroopType = 0,
	BattleUnitId = 0,
	BuffInfoItems = {}
})
local BattleBuffTipItem = require("IQIGame.UI.BattleBuffTips.BattleBuffTipItem")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function BattleBuffTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnBattleUnitAddBuff(unitId, addBuffs, troopType, newBuff, addStackBuffs)
		self:OnBattleUnitUpdateBuff(unitId)
	end

	function self.DelegateOnBattleUnitRemoveBuff(unitId, buffCid, troopType)
		self:OnBattleUnitUpdateBuff(unitId)
	end

	self.ObjectPool = UIObjectPool.New(20, function()
		return BattleBuffTipItem.New(UnityEngine.Object.Instantiate(self.BuffInfoItemPrefab))
	end, function(cell)
		local view = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(view)
	end)
end

function BattleBuffTipsUI:GetPreloadAssetPaths()
	return nil
end

function BattleBuffTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BattleBuffTipsUI:OnOpen(userData)
	if userData == nil then
		return
	end

	self.BattleUnitId = userData.battleUnitId
	self.TriggerPositionL = userData.positionL
	self.TriggerPositionR = userData.positionR
	self.HostTroopType = userData.hostTroopType

	self:UpdateView(BattleModule.UnitBuffs[self.BattleUnitId])
end

function BattleBuffTipsUI:OnClose(userData)
	return
end

function BattleBuffTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function BattleBuffTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function BattleBuffTipsUI:OnPause()
	return
end

function BattleBuffTipsUI:OnResume()
	return
end

function BattleBuffTipsUI:OnCover()
	return
end

function BattleBuffTipsUI:OnReveal()
	return
end

function BattleBuffTipsUI:OnRefocus(userData)
	return
end

function BattleBuffTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.TriggerPositionL == nil then
		return
	end

	local w = self.Content.transform.rect.w
	local h = self.Content.transform.rect.h

	self.Content.transform.position = self.TriggerPositionL

	local anchoredPosition3DL = self.Content.transform.anchoredPosition3D

	self.Content.transform.position = self.TriggerPositionR

	local anchoredPosition3DR = self.Content.transform.anchoredPosition3D
	local anchoredPosition3D

	if anchoredPosition3DL.x - w + self.UIController.transform.rect.w / 2 >= 0 then
		anchoredPosition3D = anchoredPosition3DL
		anchoredPosition3D.x = anchoredPosition3DL.x - w / 2
	else
		anchoredPosition3D = anchoredPosition3DR
		anchoredPosition3D.x = anchoredPosition3DR.x + w / 2
	end

	if anchoredPosition3D.y < self.UIController.transform.rect.h * 0.1 then
		anchoredPosition3D.y = anchoredPosition3D.y + h / 2
	else
		anchoredPosition3D.y = anchoredPosition3D.y - h / 2
	end

	anchoredPosition3D.z = 0
	self.Content.transform.anchoredPosition3D = anchoredPosition3D
end

function BattleBuffTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleBuffTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleBuffTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleBuffTipsUI:OnDestroy()
	self:Clear(true)
	self.ObjectPool:Dispose()
end

function BattleBuffTipsUI:UpdateView(buffs)
	self.Buffs = {}

	if buffs ~= nil then
		for i = 1, #buffs do
			local cfgBuffData = CfgBuffTable[buffs[i].CID]

			if cfgBuffData.IsVisible and cfgBuffData.Icon ~= "" then
				table.insert(self.Buffs, buffs[i])
			end
		end
	end

	table.sort(self.Buffs, function(buffPOD1, buffPOD2)
		local cfgBuffData1 = CfgBuffTable[buffPOD1.CID]
		local cfgBuffData2 = CfgBuffTable[buffPOD2.CID]
		local lv1Priority1, lv1Priority2

		if self.HostTroopType == Constant.BattleTroopType.Attack then
			lv1Priority1 = cfgBuffData1.DebuffType == Constant.DebuffType.Debuff and 2 or 1
			lv1Priority2 = cfgBuffData2.DebuffType == Constant.DebuffType.Debuff and 2 or 1
		else
			lv1Priority1 = cfgBuffData1.DebuffType == Constant.DebuffType.Buff and 2 or 1
			lv1Priority2 = cfgBuffData2.DebuffType == Constant.DebuffType.Buff and 2 or 1
		end

		if lv1Priority1 == lv1Priority2 then
			if cfgBuffData1.VisiblePriority == cfgBuffData2.VisiblePriority then
				return cfgBuffData1.Id < cfgBuffData2.Id
			end

			return cfgBuffData1.VisiblePriority > cfgBuffData2.VisiblePriority
		end

		return lv1Priority2 < lv1Priority1
	end)
	self:Clear()

	for i = 1, #self.Buffs do
		local buffPOD = self.Buffs[i]
		local battleBuffTipInfoUI = self.ObjectPool:Obtain()

		battleBuffTipInfoUI.View.transform:SetParent(self.BuffItemContent.transform, false)
		battleBuffTipInfoUI.View:SetActive(true)
		battleBuffTipInfoUI:SetData(buffPOD, self.HostTroopType)
		table.insert(self.BuffInfoItems, battleBuffTipInfoUI)
	end
end

function BattleBuffTipsUI:Clear(isDestroy)
	for i = 1, #self.BuffInfoItems do
		local battleBuffTipInfoUI = self.BuffInfoItems[i]

		if not isDestroy then
			battleBuffTipInfoUI.View.transform:SetParent(self.UIController.transform, false)
		end

		battleBuffTipInfoUI.View:SetActive(false)
		self.ObjectPool:Release(battleBuffTipInfoUI)
	end

	self.BuffInfoItems = {}
end

function BattleBuffTipsUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function BattleBuffTipsUI:OnBattleUnitUpdateBuff(battleUnitId)
	if self.BattleUnitId == battleUnitId then
		self:UpdateView(BattleModule.UnitBuffs[self.BattleUnitId])
	end
end

function BattleBuffTipsUI:AdjustPosition(position)
	return
end

return BattleBuffTipsUI
