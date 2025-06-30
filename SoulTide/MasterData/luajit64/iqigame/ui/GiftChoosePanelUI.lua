-- chunkname: @IQIGame\\UI\\GiftChoosePanelUI.lua

local GiftChoosePanelUI = Base:Extend("GiftChoosePanelUI", "IQIGame.Onigao.UI.GiftChoosePanelUI", {
	GiftCells = {}
})
local OptionalGiftItemCell = require("IQIGame.UI.GiftChoosePanel.OptionalGiftItemCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function GiftChoosePanelUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickCell()
		self:OnClickCell()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickReduceUseNumBtn()
		self:OnClickReduceUseNumBtn()
	end

	function self.DelegateOnClickAddUseNumBtn()
		self:OnClickAddUseNumBtn()
	end

	function self.DelegateOnSliderValueChanged(value)
		self:OnSliderValueChanged(value)
	end

	self.GiftCellPool = UIObjectPool.New(10, function()
		return OptionalGiftItemCell.New(UnityEngine.Object.Instantiate(self.CellPrefab), function(cell)
			self:OnClickCell(cell)
		end)
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	local layoutElement = self.ScrollContent:GetComponent("LayoutElement")

	layoutElement.minWidth = self.ScrollContent.transform.parent.rect.w

	UGUIUtil.SetTextInChildren(self.ConfirmBtn, GiftChoosePanelUIApi:GetString("ConfirmBtnText"))
end

function GiftChoosePanelUI:GetPreloadAssetPaths()
	return nil
end

function GiftChoosePanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GiftChoosePanelUI:IsManualShowOnOpen(userData)
	return false
end

function GiftChoosePanelUI:GetBGM(userData)
	return nil
end

function GiftChoosePanelUI:OnOpen(userData)
	self:UpdateView(userData.itemData)
end

function GiftChoosePanelUI:OnClose(userData)
	return
end

function GiftChoosePanelUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.ReduceUseNumBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReduceUseNumBtn)
	self.AddUseNumBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAddUseNumBtn)

	local slider = self.UseNumSlider:GetComponent(typeof(UnityEngine.UI.Slider))

	slider.onValueChanged:AddListener(self.DelegateOnSliderValueChanged)
end

function GiftChoosePanelUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.ReduceUseNumBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReduceUseNumBtn)
	self.AddUseNumBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAddUseNumBtn)

	local slider = self.UseNumSlider:GetComponent(typeof(UnityEngine.UI.Slider))

	slider.onValueChanged:RemoveListener(self.DelegateOnSliderValueChanged)
end

function GiftChoosePanelUI:OnPause()
	return
end

function GiftChoosePanelUI:OnResume()
	return
end

function GiftChoosePanelUI:OnCover()
	return
end

function GiftChoosePanelUI:OnReveal()
	return
end

function GiftChoosePanelUI:OnRefocus(userData)
	return
end

function GiftChoosePanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GiftChoosePanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GiftChoosePanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GiftChoosePanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GiftChoosePanelUI:OnDestroy()
	self:ClearAllCells(true)
	self.GiftCellPool:Dispose()
end

function GiftChoosePanelUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function GiftChoosePanelUI:UpdateView(itemData)
	self.ItemData = itemData

	local cfgItemData = itemData:GetCfg()

	self:ClearAllCells()

	local soulIdResMap = {}

	for cid, cfgDressData in pairsCfg(CfgDressTable) do
		if cfgDressData.Type == Constant.DressType.Portrait and cfgDressData.InitialDress ~= 0 then
			soulIdResMap[cfgDressData.SoulID] = cfgDressData.SoulResID
		end
	end

	local cfgOptionalGiftPackData = CfgOptionalGiftPackTable[cfgItemData.OptionalGiftPack]

	for i = 1, #cfgOptionalGiftPackData.Reward do
		if cfgOptionalGiftPackData.Reward[i] ~= 0 then
			local cell = self.GiftCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.ScrollContent.transform, false)
			cell:SetData(cfgOptionalGiftPackData.Reward[i], cfgOptionalGiftPackData.Num[i], soulIdResMap)
			table.insert(self.GiftCells, cell)
		end
	end

	UGUIUtil.SetText(self.ChooseNumText, GiftChoosePanelUIApi:GetString("ChooseNumText", cfgOptionalGiftPackData.ChoicesNum))
	self.UseNumView:SetActive(cfgItemData.UseType == 2 and self.ItemData.num > 1)

	if cfgItemData.UseType == 2 and self.ItemData.num > 1 then
		self:SetUseNum(1, 0, self.ItemData.num > 999 and 999 or self.ItemData.num)
	end
end

function GiftChoosePanelUI:ClearAllCells(isDestroy)
	for i = 1, #self.GiftCells do
		local cell = self.GiftCells[i]

		cell.View:SetActive(false)

		if not isDestroy then
			cell.View.transform:SetParent(self.UIController.transform, false)
		end

		self.GiftCellPool:Release(cell)
	end

	self.GiftCells = {}
end

function GiftChoosePanelUI:OnClickCell(cell)
	local cfgItemData = self.ItemData:GetCfg()
	local cfgOptionalGiftPackData = CfgOptionalGiftPackTable[cfgItemData.OptionalGiftPack]
	local selectNum = 0

	for i = 1, #self.GiftCells do
		local lCell = self.GiftCells[i]

		if lCell.IsSelect then
			selectNum = selectNum + 1
		end
	end

	if cell.IsSelect then
		cell:SetSelect(false)

		selectNum = selectNum - 1
	else
		if selectNum >= cfgOptionalGiftPackData.ChoicesNum then
			NoticeModule.ShowNotice(21045016)

			return
		end

		cell:SetSelect(true)

		selectNum = selectNum + 1
	end

	UGUIUtil.SetText(self.ChooseNumText, GiftChoosePanelUIApi:GetString("ChooseNumText", cfgOptionalGiftPackData.ChoicesNum - selectNum))
end

function GiftChoosePanelUI:OnClickConfirmBtn()
	local cfgItemData = self.ItemData:GetCfg()
	local cfgOptionalGiftPackData = CfgOptionalGiftPackTable[cfgItemData.OptionalGiftPack]
	local selectIndexes = {}

	for i = 1, #self.GiftCells do
		local lCell = self.GiftCells[i]

		if lCell.IsSelect then
			table.insert(selectIndexes, i)
		end
	end

	if #selectIndexes < cfgOptionalGiftPackData.ChoicesNum then
		NoticeModule.ShowNotice(21045017)

		return
	end

	local useNum = 1

	if cfgItemData.UseType == 2 and self.ItemData.num > 1 then
		local slider = self.UseNumSlider:GetComponent(typeof(UnityEngine.UI.Slider))

		useNum = math.floor(slider.value)
	end

	if useNum == nil or useNum < 1 then
		logError("使用礼包错误，使用数量[" .. tostring(useNum) .. "]不合法。")

		return
	end

	UIModule.CloseSelf(self)
	ItemModule.SendChooseGift(self.ItemData.id, selectIndexes, useNum)
end

function GiftChoosePanelUI:OnClickReduceUseNumBtn()
	local slider = self.UseNumSlider:GetComponent(typeof(UnityEngine.UI.Slider))
	local num = slider.value

	num = num - 1

	if num < 1 then
		num = 1
	end

	self:SetUseNum(num)
end

function GiftChoosePanelUI:OnClickAddUseNumBtn()
	local slider = self.UseNumSlider:GetComponent(typeof(UnityEngine.UI.Slider))
	local num = slider.value

	num = num + 1

	if num > self.ItemData.num then
		num = self.ItemData.num
	end

	self:SetUseNum(num)
end

function GiftChoosePanelUI:OnSliderValueChanged(value)
	local num = value

	if num < 1 then
		num = 1
	end

	self:SetUseNum(num)
end

function GiftChoosePanelUI:SetUseNum(num, pMinNum, pMaxNum)
	local slider = self.UseNumSlider:GetComponent(typeof(UnityEngine.UI.Slider))

	if slider.value ~= num then
		slider.value = num
	end

	local lMinNum = pMinNum or slider.minValue

	slider.minValue = lMinNum

	local lMaxNum = pMaxNum or slider.maxValue

	slider.maxValue = lMaxNum

	UGUIUtil.SetText(self.UseNumText, GiftChoosePanelUIApi:GetString("UseNumText", num, lMaxNum))
end

return GiftChoosePanelUI
