-- chunkname: @IQIGame\\UI\\MoneyPanelInfoUI.lua

local MoneyPanelInfoUI = Base:Extend("MoneyPanelInfoUI", "IQIGame.Onigao.UI.MoneyPanelInfoUI", {})

function MoneyPanelInfoUI:OnInit()
	self.timerCD = Timer.New(function()
		self:ShowEnergyCd()
	end, 1, -1)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateChangeValue(id)
		self:OnChangeValue(id)
	end

	function self.delegatePlayerInfoChanged()
		self:OnPlayerInfoChanged()
	end
end

function MoneyPanelInfoUI:GetPreloadAssetPaths()
	return nil
end

function MoneyPanelInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MoneyPanelInfoUI:IsManualShowOnOpen(userData)
	return false
end

function MoneyPanelInfoUI:GetBGM(userData)
	return nil
end

function MoneyPanelInfoUI:OnOpen(userData)
	self.itemID = userData[1]
	self.refTrans = userData[2]

	self:UpDateView()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Content.transform)
	UIUtil.AdjustUIInScreen(self.UIController:GetComponent("Canvas"), self.refTrans, self.Content.transform, nil, UGUISide.BottomLeft, UGUISide.TopLeft)
end

function MoneyPanelInfoUI:OnClose(userData)
	self.timerCD:Stop()
end

function MoneyPanelInfoUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, self.delegateChangeValue)
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
end

function MoneyPanelInfoUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, self.delegateChangeValue)
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
end

function MoneyPanelInfoUI:OnPause()
	return
end

function MoneyPanelInfoUI:OnResume()
	return
end

function MoneyPanelInfoUI:OnCover()
	return
end

function MoneyPanelInfoUI:OnReveal()
	return
end

function MoneyPanelInfoUI:OnRefocus(userData)
	return
end

function MoneyPanelInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MoneyPanelInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MoneyPanelInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MoneyPanelInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MoneyPanelInfoUI:OnDestroy()
	if self.timerCD then
		self.timerCD:Stop()
	end

	self.timerCD = nil
end

function MoneyPanelInfoUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.MoneyPanelInfoUI)
end

function MoneyPanelInfoUI:UpDateView()
	if self.itemID then
		UGUIUtil.SetText(self.TextTitle, CfgItemTable[self.itemID].Name)
		UGUIUtil.SetText(self.TextInfo, CfgItemTable[self.itemID].Describe)

		if self.itemID == Constant.ItemID.ENERGY then
			self.TimeView:SetActive(true)
			self.TimeMaxView:SetActive(true)

			self.maxFullCD, self.isFull = self:GetMaxFullCD()

			self:ShowEnergyCd()
			self.timerCD:Start()
		else
			self.TimeView:SetActive(false)
			self.TimeMaxView:SetActive(false)
			self.timerCD:Stop()
		end
	end
end

function MoneyPanelInfoUI:ShowEnergyCd()
	local cd = PlayerModule.PlayerInfo.nextRecoveryEnergyTime - PlayerModule.GetServerTime()

	if cd >= 0 then
		UGUIUtil.SetText(self.TextTime, MoneyPanelInfoUIApi:GetString("TextEnergyCd", GetFormatTime(cd), self.isFull))
	end

	local maxCD = self.maxFullCD + cd

	if maxCD >= 0 then
		UGUIUtil.SetText(self.TextMaxTime, MoneyPanelInfoUIApi:GetString("TextMaxEnergyCd", GetFormatTime(maxCD), self.isFull))
	end
end

function MoneyPanelInfoUI:GetMaxFullCD()
	local delay = 0
	local maxEnergy = -1
	local energyRecovery

	for i, v in pairsCfg(CfgPlayerLevelTable) do
		if v.Level == PlayerModule.PlayerInfo.baseInfo.pLv then
			maxEnergy = v.EnergyMax
			energyRecovery = v.EnergyRecovery

			break
		end
	end

	if maxEnergy == -1 then
		local tempLv = -1

		for i, v in pairsCfg(CfgPlayerLevelTable) do
			if tempLv < v.Level then
				tempLv = v.Level
				maxEnergy = v.EnergyMax
				energyRecovery = v.EnergyRecovery
			end
		end
	end

	local currentEnergy = PlayerModule.GetNumAttrValue(Constant.ItemID.ENERGY)

	if currentEnergy < maxEnergy and energyRecovery ~= nil then
		local desEnergy = maxEnergy - currentEnergy - 1

		delay = desEnergy * energyRecovery * 60
	end

	local isFullEnergy = maxEnergy <= currentEnergy

	return delay, isFullEnergy
end

function MoneyPanelInfoUI:OnChangeValue(id)
	if id == Constant.ItemID.ENERGY then
		self.maxFullCD, self.isFull = self:GetMaxFullCD()
	end
end

function MoneyPanelInfoUI:OnPlayerInfoChanged()
	self.maxFullCD, self.isFull = self:GetMaxFullCD()
end

return MoneyPanelInfoUI
