-- chunkname: @IQIGame\\UI\\UseNumberUI.lua

local UseNumberUI = Base:Extend("UseNumberUI", "IQIGame.Onigao.UI.UseNumberUI", {})
local ItemInfoCell = require("IQIGame.UI.Tips.ItemInfoCell")

function UseNumberUI:OnInit()
	self:Initialize()
end

function UseNumberUI:GetPreloadAssetPaths()
	return nil
end

function UseNumberUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function UseNumberUI:OnOpen(userData)
	self:Refresh(userData)
end

function UseNumberUI:OnClose(userData)
	self:OnHide()
end

function UseNumberUI:OnPause()
	return
end

function UseNumberUI:OnResume()
	return
end

function UseNumberUI:OnCover()
	return
end

function UseNumberUI:OnReveal()
	return
end

function UseNumberUI:OnRefocus(userData)
	return
end

function UseNumberUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.bar ~= nil and self.bar.value == 0 then
		self.bar.value = 1
	end
end

function UseNumberUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function UseNumberUI:Initialize()
	self.bar = self.goBar:GetComponent("Slider")
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

	function self.onClickBtnMaxDelegate()
		self:OnClickBtnMax()
	end

	function self.onClickBtnMinDelegate()
		self:OnClickBtnMin()
	end

	function self.onInputValueChangedDelegate(value)
		self:InputOnValueChanged(value)
	end

	self.inputComponent = self.NumInput:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.goBtnUse.transform:Find("Text"):GetComponent("Text").text = UseNumberUIApi:GetBtnUseTxt()
	self.maxLimitCount = 999999999
	self.infoCell = ItemInfoCell.New(self.Com_ItemName)
	self.ItemDescTitle:GetComponent("Text").text = ItemTipsApi:GetDescTitle()
end

function UseNumberUI:Refresh(userData)
	self.itemData = userData
	self.cfgItemData = self.itemData:GetCfg()
	self.isFragments = self.cfgItemData.ItemTypes == Constant.ItemType.Equip or self.cfgItemData.ItemTypes == Constant.ItemType.HeroDebris and self.cfgItemData.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.HeroDebris].Hero

	self:CompositeNeedNum()

	self.ownNum = WarehouseModule.GetItemNumByid(self.itemData.id)
	self.userNum = self.isFragments and 0 or 1
	self.maxLimitCount = self.cfgItemData.MaxUse > 0 and self.cfgItemData.MaxUse or self.ownNum
	self.canUseCount = self.ownNum
	self.ownCountDic = {}

	self.infoCell:RefreshView(self.itemData)
	self:RefreshMisc()
	self:RefreshBar()
end

function UseNumberUI:OnHide()
	return
end

function UseNumberUI:OnDestroy()
	self.infoCell:OnDestroy()
end

function UseNumberUI:RefreshMisc()
	self.ItemDesc:GetComponent("Text").text = ItemTipsApi:GetDesc(self.cfgItemData.ItemTips)
	self.UseLimitText:GetComponent("Text").text = ItemTipsApi:GetUseLimitText(self.maxLimitCount)
end

function UseNumberUI:RefreshBar()
	self.inputComponent.enabled = not self.isFragments

	if self.isFragments then
		self.inputComponent.contentType = IQIGame.Onigao.Game.UI.InputField.ContentType.IntegerNumber
		self.inputComponent.text = self.userNum .. "/" .. self.compositeNum
	else
		self.inputComponent.contentType = IQIGame.Onigao.Game.UI.InputField.ContentType.Standard
		self.inputComponent.text = self.userNum
	end
end

function UseNumberUI:CheckUseCostNumEnough(costNum)
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

function UseNumberUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnReduce.onClick:AddListener(self.onClickBtnReduceDelegate)
	self.btnAdd.onClick:AddListener(self.onClickBtnAddDelegate)
	self.btnUse.onClick:AddListener(self.onClickBtnUseDelegate)
	self.goBtnMax:GetComponent("Button").onClick:AddListener(self.onClickBtnMaxDelegate)
	self.goBtnMin:GetComponent("Button").onClick:AddListener(self.onClickBtnMinDelegate)
	self.inputComponent.onEndEdit:AddListener(self.onInputValueChangedDelegate)
end

function UseNumberUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnReduce.onClick:RemoveListener(self.onClickBtnReduceDelegate)
	self.btnAdd.onClick:RemoveListener(self.onClickBtnAddDelegate)
	self.btnUse.onClick:RemoveListener(self.onClickBtnUseDelegate)
	self.goBtnMax:GetComponent("Button").onClick:RemoveListener(self.onClickBtnMaxDelegate)
	self.goBtnMin:GetComponent("Button").onClick:RemoveListener(self.onClickBtnMinDelegate)
	self.inputComponent.onEndEdit:RemoveListener(self.onInputValueChangedDelegate)
end

function UseNumberUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.UseNumberUI)
end

function UseNumberUI:OnClickBtnReduce()
	if self.isFragments then
		if self.userNum == 0 then
			return
		end

		self.userNum = self.userNum - self.compositeNum
	else
		if self.userNum == 1 then
			return
		end

		self.userNum = self.userNum - 1
	end

	self:RefreshBar()
end

function UseNumberUI:OnClickBtnAdd()
	if self.canUseCount > self.maxLimitCount then
		if self.userNum >= self.maxLimitCount then
			return
		end
	elseif self.userNum >= self.canUseCount then
		return
	end

	if self.userNum == self.ownNum then
		return
	end

	if self.isFragments then
		if self.userNum >= self.maxLimitCount then
			return
		end

		if self.userNum >= math.floor(self.canUseCount / self.compositeNum) * self.compositeNum then
			return
		end

		self.userNum = self.userNum + self.compositeNum
	else
		self.userNum = self.userNum + 1
	end

	self:RefreshBar()
end

function UseNumberUI:OnClickBtnMax()
	if self.canUseCount > self.maxLimitCount then
		self.userNum = self.maxLimitCount
	elseif self.isFragments then
		self.userNum = math.floor(self.canUseCount / self.compositeNum) * self.compositeNum
	else
		self.userNum = self.canUseCount
	end

	self:RefreshBar()
end

function UseNumberUI:OnClickBtnMin()
	if self.isFragments then
		self.userNum = 0
	else
		self.userNum = 1
	end

	self:RefreshBar()
end

function UseNumberUI:OnClickBtnUse()
	if self.cfgItemData.ItemTypes == Constant.ItemType.Gift and self.cfgItemData.ItemSubTypes ~= Constant.ItemSubType[Constant.ItemType.Gift].Random and self.cfgItemData.ItemSubTypes ~= Constant.ItemSubType[Constant.ItemType.Gift].NonSelection then
		UIModule.Open(Constant.UIControllerName.UseSelectItemUI, Constant.UILayer.Tooltip, {
			itemData = self.itemData,
			useNum = self.userNum
		})
	else
		if self.userNum <= 0 then
			NoticeModule.ShowNotice(20003)

			return
		end

		if self.isFragments then
			local tab = {}

			tab[self.cfgItemData.CombinationId[1]] = self.userNum / self.compositeNum

			ItemModule.CompositeItem(tab)
		else
			local useItemPods = {}

			useItemPods.selectIndex = 0
			useItemPods.id = self.itemData.id
			useItemPods.num = self.userNum

			ItemModule.UseItem({
				useItemPods
			})
		end
	end

	self:OnClickBtnClose()
end

function UseNumberUI:InputOnValueChanged(value)
	local inputNum

	if value == "" or value == nil then
		inputNum = self.userNum
	else
		inputNum = tonumber(value)
	end

	local tempNum

	if self.canUseCount > self.maxLimitCount then
		tempNum = self.maxLimitCount
	else
		tempNum = self.canUseCount
	end

	if tempNum <= inputNum then
		inputNum = tempNum
	elseif inputNum <= 1 then
		inputNum = 1
	end

	self.userNum = inputNum

	self:RefreshBar()
end

function UseNumberUI:CompositeNeedNum()
	self.compositeNum = 0

	if self.isFragments then
		self.compositeNum = CfgCombinationTable[self.cfgItemData.CombinationId[1]].Combination[2]
	end
end

return UseNumberUI
