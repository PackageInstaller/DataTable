-- chunkname: @IQIGame\\UI\\UseNumberFishBagUI.lua

local UseNumberFishBagUI = {}

UseNumberFishBagUI = Base:Extend("UseNumberFishBagUI", "IQIGame.Onigao.UI.UseNumberFishBagUI", UseNumberFishBagUI)

function UseNumberFishBagUI:OnInit()
	self:Initialize()
end

function UseNumberFishBagUI:GetPreloadAssetPaths()
	return nil
end

function UseNumberFishBagUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function UseNumberFishBagUI:IsManualShowOnOpen(userData)
	return false
end

function UseNumberFishBagUI:GetBGM(userData)
	return nil
end

function UseNumberFishBagUI:OnOpen(userData)
	self:Refresh(userData)
end

function UseNumberFishBagUI:OnClose(userData)
	self:OnHide()
end

function UseNumberFishBagUI:OnAddListeners()
	return
end

function UseNumberFishBagUI:OnRemoveListeners()
	return
end

function UseNumberFishBagUI:OnPause()
	return
end

function UseNumberFishBagUI:OnResume()
	return
end

function UseNumberFishBagUI:OnCover()
	return
end

function UseNumberFishBagUI:OnReveal()
	return
end

function UseNumberFishBagUI:OnRefocus(userData)
	return
end

function UseNumberFishBagUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.bar ~= nil and self.bar.value == 0 then
		self.bar.value = 1
	end
end

function UseNumberFishBagUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function UseNumberFishBagUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function UseNumberFishBagUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function UseNumberFishBagUI:OnDestroy()
	return
end

function UseNumberFishBagUI:Initialize()
	self.bar = self.goBar:GetComponent("Slider")
	self.tfDesc = self.goDesc:GetComponent("Text")
	self.tfOwnNumDesc = self.goOwnNumDesc:GetComponent("Text")
	self.tfUseNumDesc = self.goUseNumDesc:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnReduce = self.goBtnReduce:GetComponent("Button")
	self.btnAdd = self.goBtnAdd:GetComponent("Button")
	self.btnUse = self.goBtnUse:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnReduceDelegate()
		self:OnClickBtnReduce()
	end

	function self.onClickBtnAddDelegate()
		self:OnClickBtnAdd()
	end

	function self.onClickBtnUseDelegate()
		self:OnClickBtnUse()
	end

	function self.onValueChangedDelegate(value)
		self:OnValueChanged(value)
	end

	self.goTitle:GetComponent("Text").text = UseNumberFishBagUIApi:GetString("goTitle")
	self.goBtnUse.transform:Find("Text"):GetComponent("Text").text = UseNumberFishBagUIApi:GetString("goBtnUse")
	self.maxLimitCount = CfgDiscreteDataTable[6507101].Data[1]
end

function UseNumberFishBagUI:Refresh(userData)
	self.itemData = userData
	self.cfgItemData = self.itemData:GetCfg()
	self.ownNum = WarehouseModule.GetItemNumByCfgID(self.cfgItemData.Id)
	self.userNum = 1
	self.ownCountDic = {}

	for i, v in pairs(self.cfgItemData.UseCostIDNum) do
		if i % 2 == 1 then
			self.ownCountDic[v] = WarehouseModule.GetItemNumByCfgID(v)
		end
	end

	self:RefreshMisc()
	self:RefreshBar()
end

function UseNumberFishBagUI:OnHide()
	return
end

function UseNumberFishBagUI:RefreshMisc()
	self.tfDesc.text = UseNumberFishBagUIApi:GetString("goDesc", self.cfgItemData.Name)
	self.tfOwnNumDesc.text = UseNumberFishBagUIApi:GetString("goOwnNumDesc", self.ownNum)

	local maxUseCount = math.min(self.ownNum, self.maxLimitCount)

	self.canUseCount = 1

	for i = 1, maxUseCount do
		if self:CheckUseCostNumEnough(i) then
			self.canUseCount = i
		else
			break
		end
	end

	self.bar.minValue = 0
	self.bar.maxValue = self.canUseCount
end

function UseNumberFishBagUI:RefreshBar()
	self.tfUseNumDesc.text = UseNumberFishBagUIApi:GetString("goUseNumDesc", self.userNum)
	self.bar.value = self.userNum
end

function UseNumberFishBagUI:CheckUseCostNumEnough(costNum)
	for i, v in pairs(self.cfgItemData.UseCostIDNum) do
		if i % 2 == 1 then
			local ownCount = self.ownCountDic[v]
			local targetCostCount = self.cfgItemData.UseCostIDNum[i + 1]

			if self.cfgItemData.Id == v then
				targetCostCount = targetCostCount + 1
			end

			if ownCount < targetCostCount * costNum then
				return false
			end
		end
	end

	return true
end

function UseNumberFishBagUI:OnAddListeners()
	self.goBtnClose1:GetComponent("Button").onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnReduce.onClick:AddListener(self.onClickBtnReduceDelegate)
	self.btnAdd.onClick:AddListener(self.onClickBtnAddDelegate)
	self.btnUse.onClick:AddListener(self.onClickBtnUseDelegate)
	self.bar.onValueChanged:AddListener(self.onValueChangedDelegate)
end

function UseNumberFishBagUI:OnRemoveListeners()
	self.goBtnClose1:GetComponent("Button").onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnReduce.onClick:RemoveListener(self.onClickBtnReduceDelegate)
	self.btnAdd.onClick:RemoveListener(self.onClickBtnAddDelegate)
	self.btnUse.onClick:RemoveListener(self.onClickBtnUseDelegate)
	self.bar.onValueChanged:RemoveListener(self.onValueChangedDelegate)
end

function UseNumberFishBagUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.UseNumberFishBagUI)
end

function UseNumberFishBagUI:OnClickBtnReduce()
	if self.userNum == 1 then
		return
	end

	self.userNum = self.userNum - 1

	self:RefreshBar()
end

function UseNumberFishBagUI:OnClickBtnAdd()
	if self.userNum >= self.canUseCount then
		return
	end

	if self.userNum == self.ownNum then
		return
	end

	if self:CheckUseCostNumEnough(self.userNum + 1) == false then
		return
	end

	self.userNum = self.userNum + 1

	self:RefreshBar()
end

function UseNumberFishBagUI:OnClickBtnUse()
	FishingModule.ExchangeFish(self.itemData, self.userNum)
	self:OnClickBtnClose()
end

function UseNumberFishBagUI:OnValueChanged(value)
	self.userNum = value

	if self.userNum >= self.canUseCount then
		self.userNum = self.canUseCount
	end

	if self:CheckUseCostNumEnough(self.userNum) == false then
		return
	end

	self:RefreshBar()
end

return UseNumberFishBagUI
