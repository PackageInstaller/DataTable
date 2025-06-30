-- chunkname: @IQIGame\\UI\\Equip\\MainView\\EquipIntensifyView.lua

local EquipIntensifyView = {
	equipCellList = {},
	intensityMaterialList = {},
	intensityEquipList = {},
	filteredIntensityItemList = {},
	filteredIntensityEquipList = {},
	filteredIntensityMaterialList = {},
	consumeItemCellList = {},
	consumeItemList = {},
	attributeCellList = {},
	suitScreenCellList = {}
}
local FilterEnum = {
	Suit = 1,
	PartIndex = 2
}
local FilterSort = require("IQIGame.UI.Common.FilterSort")
local EquipIntensifyListCellNew = require("IQIGame.UI.Equip.EquipIntensifyListCellNew")
local SuitScreenCellView = require("IQIGame.UI.Equip.SuitScreenCellView")
local FilterPopupListView = require("IQIGame/UI/Common/PopupListExtend/StrengthenPopupList")
local CommonScreenControllerView = require("IQIGame/UI/Common/Screen/CommonScreenControllerView")
local quickStrengthFilterText = {
	EquipApi:GetTextFilter(1),
	EquipApi:GetTextFilter(2),
	(EquipApi:GetTextFilter(3))
}
local quickStrengthFilter = {
	4,
	3,
	2
}

function EquipIntensifyView.New(go)
	local o = Clone(EquipIntensifyView)

	o:Initialize(go)

	return o
end

function EquipIntensifyView:Initialize(go)
	self.gameObject = go

	LuaCodeInterface.BindOutlet(go, self)
	self:InitComponent()
	self:InitDelegation()
	self:OnAddListeners()
end

function EquipIntensifyView:OnOpen(userData)
	if userData == nil then
		logError("没有传入待强化装备")

		return
	end

	self.currentIntensifyEquip = userData

	for i = 1, #self.attributeCellList do
		self.attributeCellList[i].attrIsNewUnlock = false
		self.attributeCellList[i].isUnlock = false

		LuaUtility.SetGameObjectShow(self.attributeCellList[i].effect, false)
	end

	self.screenController:SetScreenPopupData(CommonScreenModule.GetCommonEquipScreenData(false))
	self.screenController:SetSortPopupData(CommonSortingPopupListApi:GetEquipSortingData(), 1)
	self.screenController:SetSortOrderData(true)
	self:HideEquipBagPanel()
	self:OnWarehouseChange()
	self:RefreshEquipImage(self.currentIntensifyEquip)
	self:Show()
end

function EquipIntensifyView:OnClose(userData)
	self.effectCor = nil

	self:Hide()
end

local maxConsumeItemListCount = 8

function EquipIntensifyView:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.delegateOnWarehouseChange)
	EventDispatcher.AddEventListener(EventID.UpgradeEquipSucceedNew, self.delegateOnIntensifyEquipSuccess)
	self.intensifybutton.onClick:AddListener(self.delegateOnClickIntensifyButton)
	self.canelButton.onClick:AddListener(self.delegateOnClickCancelButton)
	self.oneKeyAddBtn.onClick:AddListener(self.OnClickOneKeyAddBtn)

	local len = #self.boxCellMap

	for index = 1, len do
		local box = self.boxCellMap[index].gameObject

		box:GetComponent("Button").onClick:AddListener(self.delegateOnClickShowBagBtn)
		box:GetComponent("Button").onLongClick:AddListener(self.DelegateOnLongClickConsumeItemBtnList[index])
		self.boxCellMap[index].reduceBtn:GetComponent("Button").onClick:AddListener(function()
			local num = self.consumeItemList[index].ItemCustomCount

			if num - 1 < 0 then
				return
			end

			for _, v in pairs(self.equipCellList) do
				if v.itemData == self.consumeItemList[index] then
					v:OnClickSub()

					break
				end
			end

			self:ComputeConsumeAndRefresh()
		end)
		self.boxCellMap[index].reduceBtn:GetComponent("LongButton").onLongDownClick:AddListener(function()
			local num = self.consumeItemList[index].ItemCustomCount

			if num - 1 < 0 then
				return
			end

			for _, v in pairs(self.equipCellList) do
				if v.itemData == self.consumeItemList[index] then
					v:OnClickSub()

					break
				end
			end

			self:ComputeConsumeAndRefresh()
		end)
	end

	self.CloseEquipBagButton:GetComponent("Button").onClick:AddListener(self.delegateOnClickHideBagBtn)
end

function EquipIntensifyView:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.delegateOnWarehouseChange)
	EventDispatcher.RemoveEventListener(EventID.UpgradeEquipSucceedNew, self.delegateOnIntensifyEquipSuccess)
	self.intensifybutton.onClick:RemoveListener(self.delegateOnClickIntensifyButton)
	self.canelButton.onClick:RemoveListener(self.delegateOnClickCancelButton)
	self.oneKeyAddBtn.onClick:RemoveListener(self.OnClickOneKeyAddBtn)

	local len = #self.boxCellMap

	for index = 1, len do
		local box = self.boxCellMap[index].gameObject

		box:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickShowBagBtn)
		box:GetComponent("Button").onLongClick:RemoveListener(self.DelegateOnLongClickConsumeItemBtnList[index])
	end

	self.CloseEquipBagButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickHideBagBtn)
end

function EquipIntensifyView:Hide()
	self.gameObject:SetActive(false)
end

function EquipIntensifyView:Show()
	self.gameObject:SetActive(true)
end

function EquipIntensifyView:RefreshEquipImage(equipData)
	if equipData == nil then
		self.EquipImgParent.gameObject:SetActive(false)

		return
	end

	self.EquipImgParent.gameObject:SetActive(true)

	local cfgEquip = equipData:GetEquipCfg()

	AssetUtil.LoadImage(self, EquipApi:GetEquipBigIconPath(equipData.cid), self.EquipImage:GetComponent("Image"))
	AssetUtil.LoadImage(self, EquipApi:GetEquipAttrQualityImagePath(cfgEquip.Place, cfgEquip.Quality), self.QualityImage:GetComponent("Image"))
	AssetUtil.LoadImage(self, EquipApi:GetEquipQualityBgPath(cfgEquip.Place), self.imageQualityBg:GetComponent("Image"))
	LuaUtility.SetText(self.textPartName, EquipApi:GetPartName(cfgEquip.Place))
	LuaUtility.SetText(self.EquipLevelNumText, "+ " .. equipData.lv)
	self:PlayQualityAnim(CfgItemTable[equipData.cid].Quality)
end

function EquipIntensifyView:PlayQualityAnim(quality)
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	local effectId = EquipApi:GetShowEffect(quality)

	if effectId == nil then
		logError("装备品质不正确:" .. quality .. " 无法找到该品质的特效!")

		return
	end

	self.effectID = GameEntry.Effect:PlayUIMountPointEffect(EquipApi:GetShowEffect(quality), 50000, 0, self.EffectParent, 0)
end

function EquipIntensifyView:HideEquipImage()
	self.EquipImgParent.gameObject:SetActive(false)
end

function EquipIntensifyView:Dispose()
	self.screenController:Dispose()

	for i, v in pairs(self.equipCellList) do
		v:OnDestroy()
	end

	for i, v in pairs(self.suitScreenCellList) do
		v:OnDestroy()
	end

	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	self.consumeGoldCell:Dispose()
	self:OnRemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function EquipIntensifyView:InitDelegation()
	function self.delegateOnWarehouseChange()
		self:OnWarehouseChange(true)
	end

	function self.delegateOnIntensifyEquipSuccess()
		self:OnIntensifyEquipSuccess()
	end

	function self.delegateOnClickIntensifyButton()
		self:OnClickIntensifyButton()
	end

	function self.delegateOnClickCancelButton()
		self:OnClickCancelButton()
	end

	function self.OnClickOneKeyAddBtn()
		self:OneKeyAddBtnClick()
	end

	function self.OnPreviewClickCallClicked()
		self:ComputeConsumeAndRefresh()
	end

	function self.delegateOnClickShowBagBtn()
		self:ShowEquipBagPanel()
	end

	function self.delegateOnClickHideBagBtn()
		self:HideEquipBagPanel()
	end

	self.DelegateOnLongClickConsumeItemBtnList = {}

	local len = #self.boxCellMap

	for index = 1, len do
		self.DelegateOnLongClickConsumeItemBtnList[index] = function()
			self:ShowConsumeItem(index)
		end
	end

	function self.onClickBoxReduceDelegate()
		return
	end
end

function EquipIntensifyView:__OnScreenConditionChange(isSortChange)
	self:RefreshIntensifyMaterialPanel()
end

function EquipIntensifyView:InitComponent()
	self.screenController = CommonScreenControllerView.New(self.screenControllerView, function(_isSortChange)
		self:__OnScreenConditionChange(_isSortChange)
	end)
	self.intensifyContentScroll = self.MaterialWarehouseContent:GetComponent("ScrollAreaList")

	function self.intensifyContentScroll.onRenderCell(gridCell)
		self:OnRenderGridCell(gridCell)
	end

	self.mainAttributeQualityBgImage = self.mainAttBg:GetComponent("Image")
	self.mainAttributeIconImage = self.mainAttIcon:GetComponent("Image")
	self.mainAttributeName = self.mainAttNameText:GetComponent("Text")
	self.mainAttributeValueText = self.mainAttNumText:GetComponent("Text")
	self.mainAttributeAddValueText = self.previewNumText:GetComponent("Text")
	self.expProgress = self.expPresentImg:GetComponent("Image")
	self.previewExpProgress = self.expPreviewImg:GetComponent("Image")
	self.curExpText = self.presentExpNumText:GetComponent("Text")
	self.allExpText = self.limitExpNumText:GetComponent("Text")
	self.addExpText = self.previewExpText:GetComponent("Text")
	self.previewLevelText = self.PreviewLevelText:GetComponent("Text")
	self.maxStateText = self.MaxState:GetComponent("Text")
	self.intensifybutton = self.strengthBtn:GetComponent("Button")
	self.strengthText:GetComponent("Text").text = EquipApi:GetTextIntensify()
	self.oneKeyAddBtn = self.quickAddBtn:GetComponent("Button")
	self.quickAddText:GetComponent("Text").text = EquipApi:GetTextOneKeyAdd()
	self.canelButton = self.clearBtn:GetComponent("Button")
	self.consumeGoldCell = CommonConsumeGold.New(self.costParent)

	self.consumeGoldCell:InitIconImg(CfgDiscreteDataTable[13].Data[1])

	self.boxCellMap = {}

	local boxGridCount = LuaUtility.GetChildCount(self.boxGird.transform)

	for i = 1, boxGridCount do
		self.boxCellMap[i] = {}
		self.boxCellMap[i].gameObject = self.boxGird.transform:Find("box" .. i).gameObject

		LuaCodeInterface.BindOutlet(self.boxCellMap[i].gameObject, self.boxCellMap[i])
	end

	for i = 1, boxGridCount do
		local gameObject = UnityEngine.Object.Instantiate(self.CommonSlotUI, self.boxCellMap[i].itemCellRoot.transform)
		local itemCell = ItemCell.New(gameObject, false, false)

		itemCell:Show()
		self:AddConsumeScrollViewItem(itemCell)
	end

	self.FilterPopupList = FilterPopupListView.New(self.FilterPopup, function(_index)
		self:OnStrengthFilterChange(_index)
	end)

	self.FilterPopupList:SetData(quickStrengthFilterText, 1, false)

	self.quickStrengthFilterNum = quickStrengthFilter[1]
end

function EquipIntensifyView:OnRenderGridCell(gridCellData)
	local data = self.filteredIntensityItemList[gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.equipCellList[insID]

	data.insID = insID

	if cell == nil then
		cell = EquipIntensifyListCellNew.New(gridCellData.gameObject, self)
		self.equipCellList[insID] = cell
	end

	cell:Refresh(data)

	local index = gridCellData.index + 1

	gridCellData.gameObject.name = "Item" .. index
end

function EquipIntensifyView:OnSelectedFilterPanelGridCell(gridCellData)
	local data = self.SuitFilterItemList[gridCellData.index + 1]

	self.suitScreenSelectData = data

	self.Filter:SetFilter(FilterEnum.Suit, function(item)
		return item.equipData:GetEquipCfg().SuitId[1] == data.SuitID
	end)
	self:RefreshIntensifyMaterialPanel()
	self:ResetEquipFilterCellSelectedState()
	self.suitScreenCellList[gridCellData.gameObject:GetInstanceID()]:IsChooseItem(true)
end

function EquipIntensifyView:OnRenderFilterPanelGridCell(gridCellData)
	local data = self.SuitFilterItemList[gridCellData.index + 1]
	local instanceID = gridCellData.gameObject:GetInstanceID()
	local cell = self.suitScreenCellList[instanceID]

	data.insID = instanceID

	if cell == nil then
		cell = SuitScreenCellView.New(gridCellData.gameObject)
		self.suitScreenCellList[instanceID] = cell
	end

	cell:Refresh(data, EquipModule.ToEquipDataList(self.intensityEquipList))

	gridCellData.gameObject.name = data.Name
end

function EquipIntensifyView:ResetEquipFilterCellSelectedState()
	for k, v in pairs(self.suitScreenCellList) do
		v:IsChooseItem(false)
	end
end

function EquipIntensifyView:OnClickUnfilterButton()
	self.Filter:SetFilter(FilterEnum.Suit, function(item)
		return true
	end)
	self:RefreshIntensifyMaterialPanel()
	self:ResetEquipFilterCellSelectedState()
end

function EquipIntensifyView:OnClickSortingOrderButton()
	self.Sorter:SwitchSortingOrder()
	self:RefreshIntensifyMaterialPanel()
end

function EquipIntensifyView:OnClickSortingTypeButton(index, isOn)
	self.Sorter:SetSortFunctionList(EquipModule.GetSortingFuncList(index).SortingFunc)
	self:RefreshIntensifyMaterialPanel()
end

function EquipIntensifyView:RefreshAll(showEffect)
	self:RefreshIntensifyMaterialPanel()
	self:ComputeConsumeAndRefresh(showEffect)
	LuaUtility.SetGameObjectShow(self.filterRoot, not self.currentIntensifyEquip.isMaxLv)
	LuaUtility.SetGameObjectShow(self.strengthBoxGirdParent, not self.currentIntensifyEquip.isMaxLv)
	LuaUtility.SetGameObjectShow(self.bottomBtnParent, not self.currentIntensifyEquip.isMaxLv)
	LuaUtility.SetGameObjectShow(self.maxLevelRoot, self.currentIntensifyEquip.isMaxLv)
	self:RefreshEquipImage(self.currentIntensifyEquip)
	self.FilterPopupList:ShowNormal()
end

function EquipIntensifyView:ComputeConsumeAndRefresh(showEffect)
	local materialList = self.filteredIntensityMaterialList

	table.sort(materialList, function(a, b)
		return a:GetCfg().Quality > b:GetCfg().Quality
	end)

	self.consumeItemList = self:ComputeConsumeItemList(self.consumeItemList, materialList)

	local equipList = self.filteredIntensityEquipList

	table.sort(equipList, function(a, b)
		return a:GetCfg().Quality < b:GetCfg().Quality
	end)

	self.consumeItemList = self:ComputeConsumeItemList(self.consumeItemList, equipList)

	self:SetQuickAddShow(#self.consumeItemList == 0)

	local previewAddExp, previewLv, normalAddExp = self:ComputePreview(self.consumeItemList)

	self:RefreshConsumePanel(self.consumeItemList, normalAddExp)
	self:RefreshAttributePanel(previewAddExp, previewLv, showEffect)
	self:RefreshOperationPanel(previewAddExp)
end

function EquipIntensifyView:ComputeConsumeItemList(consumeItemList, itemDataList)
	for i, itemData in pairs(itemDataList) do
		if itemData.ItemCustomCount and itemData.ItemCustomCount > 0 then
			if table.indexOf(consumeItemList, itemData) == -1 then
				table.insert(consumeItemList, itemData)
			end
		else
			table.removeElement(consumeItemList, itemData)
		end
	end

	return consumeItemList
end

function EquipIntensifyView:RefreshIntensifyMaterialPanel()
	local filteredMaterialList = {}

	ForPairs(self.intensityMaterialList, function(k, _materialItem)
		table.insert(filteredMaterialList, _materialItem)
	end)
	WarehouseModule.SortItems(filteredMaterialList, 3, self.screenController.ascending)

	local filteredEquipList = {}

	ForPairs(self.intensityEquipList, function(_, _equipItem)
		local equipData = _equipItem.equipData

		if not CommonScreenModule.ScreenCheck(equipData, self.screenController.screenData) then
			return
		end

		table.insert(filteredEquipList, _equipItem)
	end)
	WarehouseModule.SortEquips(filteredEquipList, self.screenController.sortIndex, self.screenController.ascending)

	self.filteredIntensityEquipList = filteredEquipList
	self.filteredIntensityMaterialList = filteredMaterialList
	self.filteredIntensityItemList = table.merge(filteredMaterialList, filteredEquipList)

	self.intensifyContentScroll:Refresh(#self.filteredIntensityItemList)
end

function EquipIntensifyView:OnWarehouseChange(showEffect)
	self:ResetItemCount()

	self.intensityMaterialList, self.intensityEquipList = EquipModule.GetEquipIntensifyMaterial(self.currentIntensifyEquip.id)

	for i, itemData in pairs(self.intensityMaterialList) do
		if itemData.ItemCustomCount == nil then
			itemData.ItemCustomCount = 0
		end
	end

	for i, itemData in pairs(self.intensityEquipList) do
		if itemData.equipData.ItemCustomCount == nil then
			itemData.equipData.ItemCustomCount = 0
		end
	end

	self:RefreshAll(showEffect)
end

function EquipIntensifyView:RefreshAttributePanel(previewAddExp, previewLv, showEffect)
	self:RefreshLevel(previewLv)
	self:RefreshExp(previewAddExp)
	self:RefreshAttribute(previewLv, showEffect)
end

function EquipIntensifyView:RefreshLevel(previewLv)
	LuaUtility.SetText(self.levelNumText, "+" .. self.currentIntensifyEquip.lv)

	local previewAddLv = previewLv - self.currentIntensifyEquip.lv

	self.previewLevelText.text = string.format("+%d", previewAddLv)

	self.previewLevelParent.gameObject:SetActive(previewAddLv > 0)
end

function EquipIntensifyView:RefreshExp(previewAddExp)
	local equipCfg = self.currentIntensifyEquip:GetCfg()
	local currentLevelUpExp = EquipModule.GetEquipCurrentLevelUpExp(equipCfg.Quality, equipCfg.Part, self.currentIntensifyEquip.lv)

	self.expProgress.fillAmount = self.currentIntensifyEquip.exp / currentLevelUpExp
	self.curExpText.text = self.currentIntensifyEquip.exp
	self.allExpText.text = currentLevelUpExp

	self.maxStateText.gameObject:SetActive(self.currentIntensifyEquip.isMaxLv)
	self.allExpText.gameObject:SetActive(not self.currentIntensifyEquip.isMaxLv)

	self.previewExpProgress.fillAmount = (self.currentIntensifyEquip.exp + previewAddExp) / currentLevelUpExp

	self.addExpText.gameObject:SetActive(previewAddExp > 0)

	self.addExpText.text = EquipApi:GetTextAddDescribe(previewAddExp)
end

function EquipIntensifyView:RefreshAttribute(previewLv, showEffect)
	self:RefreshPrimaryAttribute(previewLv, showEffect)
	self:RefreshSecondaryAttribute(previewLv, showEffect)
end

function EquipIntensifyView:RefreshPrimaryAttribute(previewLv, showEffect)
	self.mainAttributeName.text = self.currentIntensifyEquip.baseAttribute.Main[1].Name

	AssetUtil.LoadImage(self, self.currentIntensifyEquip.baseAttribute.Main[1].ImageUrl, self.mainAttributeIconImage)

	self.mainAttributeValueText.text = EquipApi:GetTextAddDescribe(self.currentIntensifyEquip.baseAttribute.Main[1].AddAttNum)

	local curValue = self.currentIntensifyEquip.baseAttribute.Main[1].originalValue
	local attrConfig = CfgEquipAttrTable[self.currentIntensifyEquip.baseAttribute.Main[1].equipAttrID]
	local previewValue = curValue + (previewLv - self.currentIntensifyEquip.lv) * attrConfig.MasterAttrGrowing

	if showEffect and self.lastMainAttrNum ~= curValue then
		self:PlayStrengthMainAttrEffect()
	end

	self.lastMainAttrNum = curValue

	if curValue ~= previewValue then
		LuaUtility.SetGameObjectShow(self.previewNumParent, true)
		UGUIUtil.SetText(self.previewNumText, EquipApi:FormatAttrValue(self.currentIntensifyEquip.baseAttribute.Main[1].config.IsPer, previewValue))
	else
		LuaUtility.SetGameObjectShow(self.previewNumParent, false)
	end
end

function EquipIntensifyView:RefreshSecondaryAttribute(previewLv, showEffect)
	local attributeDataLength = #self.currentIntensifyEquip.baseAttribute.Other
	local attributeCellLength = table.len(self.attributeCellList)
	local length = attributeCellLength < attributeDataLength and attributeDataLength or attributeCellLength

	for i = 1, length do
		if i <= attributeDataLength then
			if self.attributeCellList[i] == nil then
				local itemObj = UnityEngine.Object.Instantiate(self.attItemPrefab.gameObject)

				itemObj.name = i

				itemObj.transform:SetParent(self.secondAttGrid.transform, false)

				self.attributeCellList[i] = {
					obj = itemObj,
					userTable = {}
				}

				local userTable = self.attributeCellList[i].userTable

				LuaCodeInterface.BindOutlet(self.attributeCellList[i].obj, userTable)

				self.attributeCellList[i].attributeImage = userTable.QualityIconImage
				self.attributeCellList[i].attributeName = userTable.NameText:GetComponent("Text")
				self.attributeCellList[i].attributeNumber = userTable.ValueText:GetComponent("Text")
				self.attributeCellList[i].unLockText = userTable.UnlockConditionText:GetComponent("Text")
				self.attributeCellList[i].lockableState = userTable.lockableState
				self.attributeCellList[i].effect = userTable.Effect
				self.attributeCellList[i].intervalText = userTable.intervalText
				self.attributeCellList[i].tag = userTable.tag
				self.attributeCellList[i].icon = userTable.icon:GetComponent("Image")
				self.attributeCellList[i].colorChange = self.attributeCellList[i].obj:GetComponent("GraphicColorChange")
			end

			LuaUtility.SetGameObjectShow(self.attributeCellList[i].attributeImage, false)
			self.attributeCellList[i].obj:SetActive(true)

			local qualityPath, qualityValue, value

			if self.currentIntensifyEquip.baseAttribute.Other[i].OldAddAttNum == 0 then
				qualityValue = 0
				self.attributeCellList[i].unLockText.text = EquipApi:GetUnLockLvDescribute(self.currentIntensifyEquip:GetEquipCfg().CountCondition[i])

				self.attributeCellList[i].colorChange:EnablePreset(0)
			else
				qualityValue = EquipModule.GetQualityByAttribute(self.currentIntensifyEquip.baseAttribute.Other[i].id, self.currentIntensifyEquip.baseAttribute.Other[i].OldAddAttNum)
				value = EquipApi:GetTextAddDescribe(self.currentIntensifyEquip.baseAttribute.Other[i].AddAttNum)
				self.attributeCellList[i].attributeNumber.text = value

				self.attributeCellList[i].colorChange:EnablePreset(1)
			end

			local attrInerval = CfgEquipAttrTable[self.currentIntensifyEquip.baseAttribute.Other[i].onlyId].AttrShowRange
			local attrCfg = CfgAttributeTable[self.currentIntensifyEquip.baseAttribute.Other[i].id]

			UGUIUtil.SetText(self.attributeCellList[i].intervalText, string.format("(%s-%s)", EquipApi:FormatAttrValue(attrCfg.IsPer, attrInerval[1]), EquipApi:FormatAttrValue(attrCfg.IsPer, attrInerval[2])))
			LuaUtility.LoadImage(self, UIGlobalApi.IconPath .. attrCfg.ImageUrl, self.attributeCellList[i].icon)

			self.attributeCellList[i].attributeName.text = self.currentIntensifyEquip.baseAttribute.Other[i].Name

			self.attributeCellList[i].attributeNumber.gameObject:SetActive(self.currentIntensifyEquip.baseAttribute.Other[i].OldAddAttNum > 0)
			self.attributeCellList[i].unLockText.gameObject:SetActive(self.currentIntensifyEquip.baseAttribute.Other[i].OldAddAttNum == 0)
			LuaUtility.SetGameObjectShow(self.attributeCellList[i].intervalText, self.currentIntensifyEquip.baseAttribute.Other[i].OldAddAttNum == 0)
		elseif self.attributeCellList[i] ~= nil then
			self.attributeCellList[i].obj:SetActive(false)
		end
	end

	for i, v in pairs(self.currentIntensifyEquip.baseAttribute.Other) do
		self.attributeCellList[i].isUnlock = self.currentIntensifyEquip.lv >= self.currentIntensifyEquip:GetEquipCfg().CountCondition[i]

		if self.attributeCellList[i].attrIsNewUnlock == true and showEffect and self.attributeCellList[i].isUnlock == false then
			LuaUtility.SetGameObjectShow(self.attributeCellList[i].effect, true)

			self.attributeCellList[i].attrIsNewUnlock = false
		end

		self.attributeCellList[i].attrIsNewUnlock = previewLv >= self.currentIntensifyEquip:GetEquipCfg().CountCondition[i]

		local showNew = previewLv >= self.currentIntensifyEquip:GetEquipCfg().CountCondition[i] and not self.currentIntensifyEquip.isMaxLv and self.currentIntensifyEquip.lv < self.currentIntensifyEquip:GetEquipCfg().CountCondition[i]

		LuaUtility.SetGameObjectShow(self.attributeCellList[i].lockableState, showNew)
		LuaUtility.SetGameObjectShow(self.attributeCellList[i].tag, showNew)

		if showNew then
			LuaUtility.SetGameObjectShow(self.attributeCellList[i].unLockText.gameObject, false)
			LuaUtility.SetGameObjectShow(self.attributeCellList[i].attributeNumber.gameObject, false)
			self.attributeCellList[i].colorChange:EnablePreset(1)
		end
	end
end

function EquipIntensifyView:MaterialBoxMap()
	return {
		self.box1,
		self.box2,
		self.box3,
		self.box4,
		self.box5,
		self.box6,
		self.box7,
		self.box8
	}
end

function EquipIntensifyView:ComputePreview(consumeItemList)
	local normalAddExp = 0
	local previewAddExp = 0

	for i, itemData in pairs(consumeItemList) do
		local exp = 0
		local tempExp = 0

		if itemData.equipData then
			local equipCfg = itemData.equipData:GetCfg()

			tempExp = EquipModule.GetEquipOfferExp(equipCfg.Quality, equipCfg.Part, itemData.equipData.lv)
			exp = UserInfoModule.GetTalentAttr(Constant.TalentAttrType.EQUIP_UPGRADE_EXP_ADDITION, tempExp, true)
		else
			tempExp = itemData:GetCfg().ActionParams[1] * itemData.ItemCustomCount
			exp = UserInfoModule.GetTalentAttr(Constant.TalentAttrType.EQUIP_UPGRADE_EXP_ADDITION, tempExp, true)
		end

		normalAddExp = normalAddExp + tempExp
		previewAddExp = previewAddExp + exp
	end

	local equipCfg = self.currentIntensifyEquip:GetEquipCfg()
	local cumExpList = EquipModule.GetLevelCumulativeExpList(equipCfg.Quality, equipCfg.Place)
	local previewLv = 0
	local previewTotalExp = cumExpList[self.currentIntensifyEquip.lv] + self.currentIntensifyEquip.exp + previewAddExp

	for level = self.currentIntensifyEquip.lv, #cumExpList do
		if previewTotalExp >= cumExpList[level] then
			previewLv = level
		else
			break
		end
	end

	return previewAddExp, previewLv, normalAddExp
end

function EquipIntensifyView:RefreshConsumePanel(consumeItemList, previewAddExp)
	self:ResetConsumeItemScrollView()

	for index, itemData in pairs(consumeItemList) do
		local itemCell = self.consumeItemCellList[index]

		itemCell:SetItem(itemData)

		if itemData.equipData ~= nil then
			itemCell:SetItemAddLvShow(itemData.equipData.lv)
		else
			itemCell:SetNum(itemData.ItemCustomCount)
			itemCell:SetCostAllNumberShow(itemData.ItemCustomCount, itemData.num)
		end

		LuaUtility.SetGameObjectShow(self.boxCellMap[index].reduceBtn, itemData.ItemCustomCount > 0)
		itemCell.ViewGo:SetActive(true)
	end

	local needMoney = UserInfoModule.GetTalentAttr(Constant.TalentAttrType.EQUIP_UPGRADE_GOLD_COST, CfgDiscreteDataTable[24].Data[1] / 100 * previewAddExp, true)
	local costNumText = self.bottomBtnParent.transform:Find("costParent/costNumText"):GetComponent("Text")

	if costNumText then
		costNumText.text = tostring(needMoney)
	end
end

function EquipIntensifyView:ShowConsumeItem(index)
	local itemCell = self.consumeItemCellList[index]

	itemCell:OnClick()
end

function EquipIntensifyView:IsIntensifyExpOverflow()
	local expSum = EquipModule.SumIntensifyOfferExp(self.consumeItemList)
	local equipCfg = self.currentIntensifyEquip:GetEquipCfg()
	local cumExpList = EquipModule.GetLevelCumulativeExpList(equipCfg.Quality, equipCfg.Place)
	local upperByEquipLevel = cumExpList[#cumExpList] - (self.currentIntensifyEquip.exp + cumExpList[self.currentIntensifyEquip.lv])

	return upperByEquipLevel < expSum
end

function EquipIntensifyView:IsConsumeItemListFull()
	return #self.consumeItemList >= maxConsumeItemListCount
end

function EquipIntensifyView:ResetConsumeItemScrollView()
	for index, itemCell in pairs(self.consumeItemCellList) do
		itemCell.ViewGo:SetActive(false)
		LuaUtility.SetGameObjectShow(self.boxCellMap[index].reduceBtn, false)
	end
end

function EquipIntensifyView:AddConsumeScrollViewItem(gameObject)
	table.insert(self.consumeItemCellList, gameObject)
end

function EquipIntensifyView:RefreshOperationPanel(previewAddExp)
	self.canelButton.gameObject:SetActive(previewAddExp > 0)
end

function EquipIntensifyView:OnIntensifyEquipSuccess()
	self:PlayStrengthEffect()
	self:HideEquipBagPanel()
end

function EquipIntensifyView:OnClickIntensifyButton()
	if self.currentIntensifyEquip.isMaxLv then
		NoticeModule.ShowNotice(20015)

		return
	end

	if #self.consumeItemList == 0 then
		NoticeModule.ShowNotice(20003)

		return
	end

	local expSum = EquipModule.SumIntensifyOfferExp(self.consumeItemList)

	if not EquipModule.IsCurrencyEnough(expSum) then
		NoticeModule.ShowCurrencyNotEnoughTips(Constant.ItemCid.GOLD)

		return
	end

	CoroutineUtility.StartCoroutine(function()
		if EquipModule.HasHighValueEquip(self.consumeItemList) then
			local isClicked = false
			local isCancel = false

			NoticeModule.ShowNotice(20036, function()
				isClicked = true
			end, function()
				isClicked = true
				isCancel = true
			end)
			CoroutineUtility.Yield(WaitUntil(function()
				return isClicked == true
			end))

			if isCancel then
				return
			end
		end

		local equipCfg = self.currentIntensifyEquip:GetEquipCfg()
		local cumExpList = EquipModule.GetLevelCumulativeExpList(equipCfg.Quality, equipCfg.Place)
		local upperByEquipLevel = cumExpList[#cumExpList] - (self.currentIntensifyEquip.exp + cumExpList[self.currentIntensifyEquip.lv])
		local items = {}

		for i, itemData in pairs(self.consumeItemList) do
			items[itemData.id] = itemData.ItemCustomCount
		end

		EquipModule.IntensifyEquipFunc(self.currentIntensifyEquip.id, items)
	end)
end

function EquipIntensifyView:OnClickCancelButton()
	self:ResetItemCount()
	self:RefreshAll()
end

function EquipIntensifyView:OneKeyAddBtnClick()
	if self.currentIntensifyEquip.isMaxLv then
		NoticeModule.ShowNotice(20005)

		return
	end

	self:ResetItemCount()
	EquipModule.OneKeyAddIntensityItem(self.currentIntensifyEquip, self.filteredIntensityEquipList, self.filteredIntensityMaterialList, self.quickStrengthFilterNum)
	self:RefreshAll()
end

function EquipIntensifyView:ResetItemCount()
	for i, item in pairs(self.consumeItemList) do
		item.ItemCustomCount = 0
	end

	self.consumeItemList = {}
end

function EquipIntensifyView:ShowEquipBagPanel()
	self.screenController:SetScreenPopupData(CommonScreenModule.GetCommonEquipScreenData(false))
	self.screenController:SetSortPopupData(CommonSortingPopupListApi:GetEquipSortingData(), 1)
	self.screenController:SetSortOrderData(true)
	self.EquipBagPanel:SetActive(true)
	LuaUtility.SetGameObjectShow(self.FunTabs, false)
end

function EquipIntensifyView:HideEquipBagPanel()
	self.EquipBagPanel:SetActive(false)
	LuaUtility.SetGameObjectShow(self.FunTabs, true)
end

function EquipIntensifyView:PlayStrengthEffect()
	self.effectCor = coroutine.start(function()
		LuaUtility.SetGameObjectShow(self.strengthEffect, true)
		coroutine.wait(1)
		LuaUtility.SetGameObjectShow(self.strengthEffect, false)

		self.effectCor = nil
	end)
end

function EquipIntensifyView:PlayStrengthMainAttrEffect()
	self.attrEffectCor = coroutine.start(function()
		LuaUtility.SetGameObjectShow(self.MainAttrEffect, true)
		coroutine.wait(1)
		LuaUtility.SetGameObjectShow(self.MainAttrEffect, false)

		self.attrEffectCor = nil
	end)
end

function EquipIntensifyView:OnStrengthFilterChange(index)
	self.quickStrengthFilterNum = quickStrengthFilter[index]
end

function EquipIntensifyView:SetQuickAddShow(show)
	LuaUtility.SetGameObjectShow(self.quickAddBtn, show)
	LuaUtility.SetGameObjectShow(self.clearBtn, not show)
end

return EquipIntensifyView
