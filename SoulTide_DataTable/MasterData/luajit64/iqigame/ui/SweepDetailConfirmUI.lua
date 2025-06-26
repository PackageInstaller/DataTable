-- chunkname: @IQIGame\\UI\\SweepDetailConfirmUI.lua

local SweepDetailConfirmUI = {
	MaxCount = 1000,
	CostEnergy = 0,
	Count = 0
}

SweepDetailConfirmUI = Base:Extend("SweepDetailConfirmUI", "IQIGame.Onigao.UI.SweepDetailConfirmUI", SweepDetailConfirmUI)

require("IQIGame.UIExternalApi.SweepDetailConfirmUIApi")

function SweepDetailConfirmUI:OnInit()
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

	UGUIUtil.SetText(self.TitleText, SweepDetailConfirmUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.SweepCountLabel, SweepDetailConfirmUIApi:GetString("SweepCountLabel"))
	UGUIUtil.SetTextInChildren(self.MaxBtn, SweepDetailConfirmUIApi:GetString("MaxBtnText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, SweepDetailConfirmUIApi:GetString("ConfirmBtnText"))
end

function SweepDetailConfirmUI:GetPreloadAssetPaths()
	return nil
end

function SweepDetailConfirmUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SweepDetailConfirmUI:IsManualShowOnOpen(userData)
	return false
end

function SweepDetailConfirmUI:GetBGM(userData)
	return nil
end

function SweepDetailConfirmUI:OnOpen(userData)
	self.CostEnergy = userData.CostEnergy
	self.CallBack = userData.CallBack
	self.ItemID = userData.NeedItem

	if userData.MaxCount and userData.MaxCount > 0 then
		self.MaxCount = userData.MaxCount
	end

	if self.ItemID == nil then
		self.ItemID = Constant.ItemID.ENERGY
	end

	self:UpdateView()
end

function SweepDetailConfirmUI:OnClose(userData)
	self.CallBack = nil
end

function SweepDetailConfirmUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ReduceBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReduceBtn)
	self.AddBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAddBtn)
	self.MaxBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMaxBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CountInput:GetComponent(typeof(IQIGame.Onigao.Game.UI.InputField)).onValueChanged:AddListener(self.DelegateOnInputValueChanged)
end

function SweepDetailConfirmUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ReduceBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReduceBtn)
	self.AddBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAddBtn)
	self.MaxBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMaxBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CountInput:GetComponent(typeof(IQIGame.Onigao.Game.UI.InputField)).onValueChanged:RemoveListener(self.DelegateOnInputValueChanged)
end

function SweepDetailConfirmUI:OnPause()
	return
end

function SweepDetailConfirmUI:OnResume()
	return
end

function SweepDetailConfirmUI:OnCover()
	return
end

function SweepDetailConfirmUI:OnReveal()
	return
end

function SweepDetailConfirmUI:OnRefocus(userData)
	return
end

function SweepDetailConfirmUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SweepDetailConfirmUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SweepDetailConfirmUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SweepDetailConfirmUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SweepDetailConfirmUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function SweepDetailConfirmUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function SweepDetailConfirmUI:UpdateView()
	local cfgItemData = CfgItemTable[self.ItemID]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.CostIcon:GetComponent("Image"))
	self:SetCount(1)
end

function SweepDetailConfirmUI:SetCount(count)
	if count < 1 then
		count = 1
	end

	local hasEnergy = WarehouseModule.GetItemNumByCfgID(self.ItemID)
	local availableCount = math.floor(hasEnergy / self.CostEnergy)

	availableCount = math.min(availableCount, self.MaxCount)

	if availableCount < count then
		count = availableCount
	end

	self.Count = count
	self.CountInput:GetComponent(typeof(IQIGame.Onigao.Game.UI.InputField)).text = self.Count

	UGUIUtil.SetText(self.CostNumText, SweepDetailConfirmUIApi:GetString("CostNumText", self.CostEnergy * self.Count, hasEnergy))

	self.ReduceBtn:GetComponent("Button").interactable = self.Count > 1
	self.AddBtn:GetComponent("Button").interactable = availableCount > self.Count
	self.MaxBtn:GetComponent("Button").interactable = availableCount > self.Count
end

function SweepDetailConfirmUI:OnClickReduceBtn()
	self:SetCount(self.Count - 1)
end

function SweepDetailConfirmUI:OnClickAddBtn()
	self:SetCount(self.Count + 1)
end

function SweepDetailConfirmUI:OnClickMaxBtn()
	local hasEnergy = WarehouseModule.GetItemNumByCfgID(self.ItemID)
	local availableCount = math.floor(hasEnergy / self.CostEnergy)

	availableCount = math.min(availableCount, self.MaxCount)

	self:SetCount(availableCount)
end

function SweepDetailConfirmUI:OnInputValueChanged(text)
	local num = tonumber(text)

	if num == nil then
		num = 0
	end

	self:SetCount(num)
end

function SweepDetailConfirmUI:OnClickConfirmBtn()
	if self.CallBack then
		self.CallBack(self.Count)
	end

	UIModule.CloseSelf(self)
end

return SweepDetailConfirmUI
