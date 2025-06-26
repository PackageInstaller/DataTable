-- chunkname: @IQIGame\\UI\\MazeSweepDetailConfirmUI.lua

local MazeSweepDetailConfirmUI = Base:Extend("MazeSweepDetailConfirmUI", "IQIGame.Onigao.UI.MazeSweepDetailConfirmUI", {
	Count = 0,
	MazeCid = 0
})

function MazeSweepDetailConfirmUI:OnInit()
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

	local cfgItemData = CfgItemTable[Constant.ItemID.ENERGY]

	self.CostIcon:GetComponent("Image").sprite = self.UIController:GetPreloadedAsset(UIGlobalApi.GetIconPath(cfgItemData.Icon))

	UGUIUtil.SetText(self.TitleText, MazeSweepDetailConfirmUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.SweepCountLabel, MazeSweepDetailConfirmUIApi:GetString("SweepCountLabel"))
	UGUIUtil.SetTextInChildren(self.MaxBtn, MazeSweepDetailConfirmUIApi:GetString("MaxBtnText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, MazeSweepDetailConfirmUIApi:GetString("ConfirmBtnText"))
end

function MazeSweepDetailConfirmUI:GetPreloadAssetPaths()
	local cfgItemData = CfgItemTable[Constant.ItemID.ENERGY]

	return {
		UIGlobalApi.GetIconPath(cfgItemData.Icon)
	}
end

function MazeSweepDetailConfirmUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeSweepDetailConfirmUI:IsManualShowOnOpen(userData)
	return false
end

function MazeSweepDetailConfirmUI:GetBGM(userData)
	return nil
end

function MazeSweepDetailConfirmUI:OnOpen(userData)
	self:UpdateView(userData.mazeCid)
end

function MazeSweepDetailConfirmUI:OnClose(userData)
	return
end

function MazeSweepDetailConfirmUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ReduceBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReduceBtn)
	self.AddBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAddBtn)
	self.MaxBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMaxBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CountInput:GetComponent(typeof(IQIGame.Onigao.Game.UI.InputField)).onValueChanged:AddListener(self.DelegateOnInputValueChanged)
end

function MazeSweepDetailConfirmUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ReduceBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReduceBtn)
	self.AddBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAddBtn)
	self.MaxBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMaxBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CountInput:GetComponent(typeof(IQIGame.Onigao.Game.UI.InputField)).onValueChanged:RemoveListener(self.DelegateOnInputValueChanged)
end

function MazeSweepDetailConfirmUI:OnPause()
	return
end

function MazeSweepDetailConfirmUI:OnResume()
	return
end

function MazeSweepDetailConfirmUI:OnCover()
	return
end

function MazeSweepDetailConfirmUI:OnReveal()
	return
end

function MazeSweepDetailConfirmUI:OnRefocus(userData)
	return
end

function MazeSweepDetailConfirmUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeSweepDetailConfirmUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeSweepDetailConfirmUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeSweepDetailConfirmUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeSweepDetailConfirmUI:OnDestroy()
	return
end

function MazeSweepDetailConfirmUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function MazeSweepDetailConfirmUI:UpdateView(mazeCid)
	self.MazeCid = mazeCid
	self.CfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]

	self:SetCount(1)
end

function MazeSweepDetailConfirmUI:SetCount(count)
	if count < 1 then
		count = 1
	end

	local hasEnergy = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)
	local availableCount = math.floor(hasEnergy / self.CfgMazeInstanceData.Cost)
	local leftNum, totalNum = PlayerModule.GetMazeLeftCount(self.MazeCid)

	availableCount = math.min(availableCount, leftNum)

	if availableCount < count then
		count = availableCount
	end

	self.Count = count
	self.CountInput:GetComponent(typeof(IQIGame.Onigao.Game.UI.InputField)).text = self.Count

	UGUIUtil.SetText(self.CostNumText, MazeSweepDetailConfirmUIApi:GetString("CostNumText", self.CfgMazeInstanceData.Cost * self.Count, hasEnergy))

	self.ReduceBtn:GetComponent("Button").interactable = self.Count > 1
	self.AddBtn:GetComponent("Button").interactable = availableCount > self.Count
	self.MaxBtn:GetComponent("Button").interactable = availableCount > self.Count
end

function MazeSweepDetailConfirmUI:OnClickReduceBtn()
	self:SetCount(self.Count - 1)
end

function MazeSweepDetailConfirmUI:OnClickAddBtn()
	self:SetCount(self.Count + 1)
end

function MazeSweepDetailConfirmUI:OnClickMaxBtn()
	local hasEnergy = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)
	local availableCount = math.floor(hasEnergy / self.CfgMazeInstanceData.Cost)
	local leftNum, totalNum = PlayerModule.GetMazeLeftCount(self.MazeCid)

	availableCount = math.min(availableCount, leftNum)

	self:SetCount(availableCount)
end

function MazeSweepDetailConfirmUI:OnInputValueChanged(text)
	local num = tonumber(text)

	if num == nil then
		num = 0
	end

	self:SetCount(num)
end

function MazeSweepDetailConfirmUI:OnClickConfirmBtn()
	MazeModule.Sweep(self.MazeCid, self.Count, 0)
	UIModule.CloseSelf(self)
end

return MazeSweepDetailConfirmUI
