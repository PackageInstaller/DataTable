-- chunkname: @IQIGame\\UI\\HorizontalRPGMazeSweepDetailConfirmUI.lua

local HorizontalRPGMazeSweepDetailConfirmUI = {
	RPGBoss = 0,
	Count = 0,
	HaveFree = false,
	CanEnter = false
}

HorizontalRPGMazeSweepDetailConfirmUI = Base:Extend("HorizontalRPGMazeSweepDetailConfirmUI", "IQIGame.Onigao.UI.HorizontalRPGMazeSweepDetailConfirmUI", HorizontalRPGMazeSweepDetailConfirmUI)

function HorizontalRPGMazeSweepDetailConfirmUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickReduceBtn()
		self:OnClickReduceBtn()
	end

	function self.DelegateOnClickAddBtn()
		self:OnClickAddBtn()
	end

	function self.DelegateOnClickMaxBtn()
		self:OnClickMaxBtn()
	end

	function self.DelegateOnInputValueChanged(text)
		self:OnInputValueChanged(text)
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end
end

function HorizontalRPGMazeSweepDetailConfirmUI:GetPreloadAssetPaths()
	return nil
end

function HorizontalRPGMazeSweepDetailConfirmUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRPGMazeSweepDetailConfirmUI:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRPGMazeSweepDetailConfirmUI:GetBGM(userData)
	return nil
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnOpen(userData)
	self.RPGBoss = userData.RPGBoss
	self.HaveFree = userData.HaveFree

	self:UpdateView()
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnClose(userData)
	return
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ReduceBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReduceBtn)
	self.AddBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAddBtn)
	self.MaxBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMaxBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CountInput:GetComponent(typeof(IQIGame.Onigao.Game.UI.InputField)).onValueChanged:AddListener(self.DelegateOnInputValueChanged)
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ReduceBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReduceBtn)
	self.AddBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAddBtn)
	self.MaxBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMaxBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CountInput:GetComponent(typeof(IQIGame.Onigao.Game.UI.InputField)).onValueChanged:RemoveListener(self.DelegateOnInputValueChanged)
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnPause()
	return
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnResume()
	return
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnCover()
	return
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnReveal()
	return
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnRefocus(userData)
	return
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function HorizontalRPGMazeSweepDetailConfirmUI:UpdateView()
	local path = UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.HorizontalRPG_Points].Icon)

	AssetUtil.LoadImage(self, path, self.CostIcon:GetComponent("Image"))
	self:SetCount(1)
end

function HorizontalRPGMazeSweepDetailConfirmUI:SetCount(count)
	if count < 1 then
		count = 1
	end

	local hasEnergy = HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.tickets or 0
	local availableCount = math.floor(hasEnergy / self.RPGBoss.ChallengeBossCostTickets)

	if self.HaveFree then
		availableCount = availableCount + 1
	end

	if availableCount < count then
		count = availableCount
	end

	self.Count = count
	self.CountInput:GetComponent(typeof(IQIGame.Onigao.Game.UI.InputField)).text = self.Count

	local num = self.Count

	if self.HaveFree then
		num = num - 1
	end

	local cost = self.RPGBoss.ChallengeBossCostTickets * num

	if cost < 0 then
		cost = 0
	end

	UGUIUtil.SetText(self.CostNumText, string.format("%s/%s", cost, HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.tickets))

	self.ReduceBtn:GetComponent("Button").interactable = self.Count > 1
	self.AddBtn:GetComponent("Button").interactable = availableCount > self.Count
	self.MaxBtn:GetComponent("Button").interactable = availableCount > self.Count
	self.CanEnter = self.Count > 0 and cost <= HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.tickets
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnClickReduceBtn()
	self:SetCount(self.Count - 1)
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnClickAddBtn()
	self:SetCount(self.Count + 1)
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnClickMaxBtn()
	local hasEnergy = HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.tickets or 0
	local availableCount = math.floor(hasEnergy / self.RPGBoss.ChallengeBossCostTickets)

	if self.HaveFree then
		availableCount = availableCount + 1
	end

	self:SetCount(availableCount)
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnInputValueChanged(text)
	local num = tonumber(text)

	if num == nil then
		num = 0
	end

	self:SetCount(num)
end

function HorizontalRPGMazeSweepDetailConfirmUI:OnClickConfirmBtn()
	if not self.CanEnter then
		NoticeModule.ShowNotice(21042058)
	end

	HorizontalRPGModule.QuickChallenge(self.RPGBoss.Id, self.Count)
	UIModule.CloseSelf(self)
end

return HorizontalRPGMazeSweepDetailConfirmUI
