-- chunkname: @IQIGame\\UI\\PlayerLvUpUI.lua

local PlayerLvUpUI = {}

PlayerLvUpUI = Base:Extend("PlayerLvUpUI", "IQIGame.Onigao.UI.PlayerLvUpUI", PlayerLvUpUI)

function PlayerLvUpUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end
end

function PlayerLvUpUI:GetPreloadAssetPaths()
	return nil
end

function PlayerLvUpUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlayerLvUpUI:IsManualShowOnOpen(userData)
	return false
end

function PlayerLvUpUI:GetBGM(userData)
	return nil
end

function PlayerLvUpUI:OnOpen(userData)
	self:ShowInfo(userData)
end

function PlayerLvUpUI:OnClose(userData)
	return
end

function PlayerLvUpUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function PlayerLvUpUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function PlayerLvUpUI:OnPause()
	return
end

function PlayerLvUpUI:OnResume()
	return
end

function PlayerLvUpUI:OnCover()
	return
end

function PlayerLvUpUI:OnReveal()
	return
end

function PlayerLvUpUI:OnRefocus(userData)
	return
end

function PlayerLvUpUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlayerLvUpUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlayerLvUpUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlayerLvUpUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlayerLvUpUI:OnDestroy()
	return
end

function PlayerLvUpUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)
end

function PlayerLvUpUI:ShowInfo(lvUpData)
	local playerMaxLv = self:GetPlayerMaxLv()

	UGUIUtil.SetText(self.LvText, lvUpData.lv)
	UGUIUtil.SetText(self.LastLastLvText, lvUpData.lv - 2 <= 0 and "" or lvUpData.lv - 2)
	UGUIUtil.SetText(self.LastLvText, lvUpData.lv - 1 <= 0 and "" or lvUpData.lv - 1)
	UGUIUtil.SetText(self.NextLvText, playerMaxLv <= lvUpData.lv + 1 and "" or lvUpData.lv + 1)

	local count = 0

	for k, v in pairs(lvUpData.items) do
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[v.cid].Icon), self.ExtraImg:GetComponent("Image"))
		UGUIUtil.SetText(self.ExtraNum, v.num)

		count = count + 1
	end

	local isGetReward = count > 0
	local lastLv = lvUpData.lv - 1
	local lastEnergy = CfgPlayerLevelTable[lastLv].EnergyMax
	local newEnergy = CfgPlayerLevelTable[lvUpData.lv].EnergyMax
	local isChange = lastEnergy ~= newEnergy

	if isChange then
		UGUIUtil.SetText(self.LastCountText, lastEnergy)
		UGUIUtil.SetText(self.NewCountText, newEnergy)
	end

	self.UpLimitParent:SetActive(isChange)
	self.ExtraItemParent:SetActive(isGetReward)
	self.RewardParent:SetActive(true)
end

function PlayerLvUpUI:GetPlayerMaxLv()
	local maxLv = 0

	for k, v in pairsCfg(CfgPlayerLevelTable) do
		maxLv = maxLv < v.Id and v.Id or maxLv
	end

	return maxLv
end

return PlayerLvUpUI
