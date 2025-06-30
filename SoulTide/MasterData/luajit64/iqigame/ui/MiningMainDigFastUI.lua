-- chunkname: @IQIGame\\UI\\MiningMainDigFastUI.lua

local MiningMainDigFastUI = {
	maxCount = 0,
	onceCost = 0,
	count = 0
}

MiningMainDigFastUI = Base:Extend("MiningMainDigFastUI", "IQIGame.Onigao.UI.MiningMainDigFastUI", MiningMainDigFastUI)

function MiningMainDigFastUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnClickBtnReduce()
		self:OnClickBtnReduce()
	end

	function self.DelegateOnClickBtnAdd()
		self:OnClickBtnAdd()
	end

	function self.DelegateOnClickBtnMax()
		self:OnClickBtnMax()
	end

	function self.DelegateOnClickBtnMin()
		self:OnClickBtnMin()
	end

	function self.DelegateOnClickBtnCancel()
		self:OnClickBtnCancel()
	end

	function self.DelegateOnClickBtnAutoLand()
		self:OnClickBtnAutoLand()
	end

	function self.DelegateOnClickBtnAutoMining()
		self:OnClickBtnAutoMining()
	end
end

function MiningMainDigFastUI:GetPreloadAssetPaths()
	return nil
end

function MiningMainDigFastUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MiningMainDigFastUI:IsManualShowOnOpen(userData)
	return false
end

function MiningMainDigFastUI:GetBGM(userData)
	return nil
end

function MiningMainDigFastUI:OnOpen(userData)
	self:UpdateView()
end

function MiningMainDigFastUI:OnClose(userData)
	return
end

function MiningMainDigFastUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnReduce:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnReduce)
	self.BtnAdd:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnAdd)
	self.BtnMax:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnMax)
	self.BtnMin:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnMin)
	self.BtnCancel:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnCancel)
	self.BtnAutoLand:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnAutoLand)
	self.BtnAutoMining:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnAutoMining)
end

function MiningMainDigFastUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnReduce:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnReduce)
	self.BtnAdd:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnAdd)
	self.BtnMax:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnMax)
	self.BtnMin:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnMin)
	self.BtnCancel:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnCancel)
	self.BtnAutoLand:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnAutoLand)
	self.BtnAutoMining:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnAutoMining)
end

function MiningMainDigFastUI:OnPause()
	return
end

function MiningMainDigFastUI:OnResume()
	return
end

function MiningMainDigFastUI:OnCover()
	return
end

function MiningMainDigFastUI:OnReveal()
	return
end

function MiningMainDigFastUI:OnRefocus(userData)
	return
end

function MiningMainDigFastUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MiningMainDigFastUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MiningMainDigFastUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MiningMainDigFastUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MiningMainDigFastUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function MiningMainDigFastUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function MiningMainDigFastUI:UpdateView()
	local cfgLayer = CfgMiningLayerTable[MiningModule.miningLayerPOD.floor]

	self.maxCount = #MiningModule.miningPlantDataTab
	self.onceCost = 0

	for i = 1, #cfgLayer.Cost, 2 do
		local id = cfgLayer.Cost[i]
		local need = cfgLayer.Cost[i + 1]
		local have = WarehouseModule.GetItemNumByCfgID(id)
		local num = math.floor(have / need)

		self.maxCount = math.min(self.maxCount, num)
		self.onceCost = need
	end

	if self.maxCount > 0 then
		self.count = 1
	end

	self:RefreshNum()
end

function MiningMainDigFastUI:RefreshNum()
	UGUIUtil.SetText(self.TextNum, self.count)
	UGUIUtil.SetText(self.TextCost, self.count * self.onceCost)
end

function MiningMainDigFastUI:OnClickBtnReduce()
	if self.count > 0 then
		self.count = self.count - 1

		self:RefreshNum()
	end
end

function MiningMainDigFastUI:OnClickBtnAdd()
	if self.count < self.maxCount then
		self.count = self.count + 1

		self:RefreshNum()
	end
end

function MiningMainDigFastUI:OnClickBtnMax()
	self.count = self.maxCount

	self:RefreshNum()
end

function MiningMainDigFastUI:OnClickBtnMin()
	if self.maxCount > 0 then
		self.count = 1
	else
		self.count = 0
	end

	self:RefreshNum()
end

function MiningMainDigFastUI:OnClickBtnCancel()
	self:OnClickBtnClose()
end

function MiningMainDigFastUI:OnClickBtnAutoLand()
	if self.count > 0 then
		local plantCount = 0

		for i, v in pairs(MiningModule.miningPlantDataTab) do
			if v.miningGridPOD.state == 0 then
				plantCount = plantCount + 1
			end
		end

		if plantCount == 0 then
			NoticeModule.ShowNotice(21042049)

			return
		end

		MiningModule.AutoExcavate(self.count, 0)
		self:OnClickBtnClose()
	end
end

function MiningMainDigFastUI:OnClickBtnAutoMining()
	if self.count > 0 then
		local plantCount = 0

		for i, v in pairs(MiningModule.miningPlantDataTab) do
			if v.miningGridPOD.state == 0 then
				plantCount = plantCount + 1
			elseif v.miningGridPOD.state == 1 and v:GetCfgElementData().Type >= 2 and v:GetCfgElementData().Type <= 5 then
				plantCount = plantCount + 1
			end
		end

		if plantCount == 0 then
			NoticeModule.ShowNotice(21042049)

			return
		end

		MiningModule.AutoExcavate(self.count, 1)
		self:OnClickBtnClose()
	end
end

return MiningMainDigFastUI
