-- chunkname: @IQIGame\\UI\\Equip\\EquipBaseInfoView.lua

local EquipBaseInfoView = {
	AdditionalAttributeCellList = {},
	suitCellList = {}
}
local EquipWearSuitView = require("IQIGame.UI.Equip.EquipWearSuitView")
local EquipAdditionalAttributeCell = require("IQIGame.UI.Equip.EquipAdditionalAttributeCell")

function EquipBaseInfoView.New(go, mainView)
	local o = Clone(EquipBaseInfoView)

	o:Initialize(go, mainView)

	return o
end

function EquipBaseInfoView:Initialize(go, mainView)
	self.gameObject = go

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.mainView = mainView
	self.suitDescCell = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddEventListener()
end

function EquipBaseInfoView:InitComponent()
	self.toggleSee = self.toggleSee:GetComponent("Toggle")
end

function EquipBaseInfoView:InitDelegate()
	function self.onToggleSeeClick(isOn)
		self:OnToggleSeeClick(isOn)
	end
end

function EquipBaseInfoView:AddEventListener()
	self.toggleSee.onValueChanged:AddListener(self.onToggleSeeClick)
end

function EquipBaseInfoView:RemoveEventListener()
	self.toggleSee.onValueChanged:RemoveListener(self.onToggleSeeClick)
end

function EquipBaseInfoView:OnDestroy()
	self:RemoveEventListener()

	for _, cell in pairs(self.suitCellList) do
		cell:OnDestroy()
	end

	self.suitCellList = {}

	for _, v in pairs(self.suitDescCell) do
		GameObject.Destroy(v)
	end

	self.suitDescCell = {}

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)

	self.gameObject = nil
	self.mainView = nil
end

function EquipBaseInfoView:Show()
	self.gameObject:SetActive(true)
end

function EquipBaseInfoView:Hide()
	self.gameObject:SetActive(false)
end

function EquipBaseInfoView:Refresh(equipData)
	self.equipData = equipData

	self:RefreshDesc(equipData)
	self:RefreshLockIcon(equipData.isLock)
	self:AttributeRefresh(equipData)
end

function EquipBaseInfoView:RefreshDesc(equipData)
	self.LevelText:GetComponent("Text").text = EquipApi:GetTextLv(equipData.lv)
	self.EquipNameText:GetComponent("Text").text = equipData:GetCfg().Name
	self.EquipDescText:GetComponent("Text").text = equipData:GetCfg().ItemTips

	self.EquippedTipsParent:SetActive(equipData.heroCid ~= 0)

	if equipData.heroCid ~= 0 then
		local headIconPath = SkinModule.GetHeroCurrentSkinImgPath(equipData.heroCid, Constant.SkinImageType.DetailsHeadIcon)

		AssetUtil.LoadImage_SetNativeSize(self, headIconPath, self.EquippedHeroHeadImg:GetComponent("Image"))
		UGUIUtil.SetText(self.EquippedTipsText, EquipApi:GetTextSuitYetEquip(equipData.heroCid))
	end
end

function EquipBaseInfoView:RefreshLockIcon(isLock)
	if self.LockedIcon then
		self.LockedIcon:SetActive(isLock)
	end

	if self.UnlockedIcon then
		self.UnlockedIcon:SetActive(not isLock)
	end
end

function EquipBaseInfoView:AttributeRefresh(equipData)
	if LuaUtility.StrIsNullOrEmpty(equipData.baseAttribute.Main[1].ImageUrl) then
		logError("装备属性 {0}，在 Attribute 配置表中未配置属性图片", equipData.baseAttribute.Main[1].id)
		self.MainAttributeIconImage.gameObject:SetActive(false)
	else
		AssetUtil.LoadImage(self, equipData.baseAttribute.Main[1].ImageUrl, self.MainAttributeIconImage:GetComponent("Image"))
		self.MainAttributeIconImage.gameObject:SetActive(true)
	end

	UGUIUtil.SetText(self.MainAttributeNameText, equipData.baseAttribute.Main[1].Name)
	UGUIUtil.SetText(self.MainAttributeValueText, CommonEquipTipsUIApi:GetMainAttributeText(equipData.baseAttribute.Main[1].AddAttNum))
	self:RefreshAdditionalAttribute(equipData.baseAttribute.Other)
	LuaUtility.SetText(self.textPart, EquipApi:GetPartName(equipData:GetEquipCfg().Place))

	self.suitId = equipData:GetEquipCfg().SuitId

	LuaUtility.SetGameObjectShow(self.EquipSuitAttParent, true)
	LuaUtility.SetGameObjectShow(self.AwakenParent, false)

	local cfgEquipData = CfgUtil.GetCfgEquipDataWithID(equipData.equipCid)
	local len = #cfgEquipData.SuitId
	local index = 1

	for i = 1, len do
		local id = cfgEquipData.SuitId[i]
		local isAwake = false
		local cfgEquipSuitArray = CfgUtil.GetCfgEquipSuitData(id, isAwake and Constant.Equip.SuitType.Awaken or Constant.Equip.SuitType.Normal)

		table.sort(cfgEquipSuitArray, function(a, b)
			return a.Id < b.Id
		end)

		if #cfgEquipSuitArray > 0 then
			local cell = self:_GetCell(index)

			cell:Refresh(cfgEquipSuitArray, id, EquipModule.GetHeroSuitCountWithSuitID(id), false)
			cell:Show()

			index = index + 1
		end
	end

	len = #self.suitCellList

	for i = index, len do
		self.suitCellList[i]:Hide()
	end

	local descCell = self:_GetDescCell(1)

	descCell.transform:SetSiblingIndex(LuaUtility.GetChildCount(self.SuitEffectContent.transform) - 1)
	LuaUtility.SetText(descCell.transform:Find("textDesc").gameObject, equipData:GetEquipCfg().EquipTips)
	LuaUtility.SetGameObjectShow(descCell, true)

	local len = #self.suitDescCell

	for i = 2, len do
		LuaUtility.SetGameObjectShow(self.suitDescCell[i], false)
	end
end

function EquipBaseInfoView:_GetCell(index)
	local cell = self.suitCellList[index]

	if not cell then
		local gameObject = GameObject.Instantiate(self.SuitAttributeGroupItemPrefab, self.SuitEffectContent.transform)

		cell = EquipWearSuitView.New(gameObject)
		self.suitCellList[index] = cell
	end

	return cell
end

function EquipBaseInfoView:_GetDescCell(index)
	local cell = self.suitDescCell[index]

	if not cell then
		cell = GameObject.Instantiate(self.SuitDescPrefab, self.SuitEffectContent.transform)
		self.suitDescCell[index] = cell
	end

	return cell
end

function EquipBaseInfoView:RefreshSuitInfo(equipData, suitTable)
	local suitGroupList = {}

	for i, suit in pairs(suitTable) do
		if table.indexOf(equipData:GetEquipCfg().SuitId, i) ~= -1 then
			table.insert(suitGroupList, suit)
		end
	end

	self:CreateSuitItem(suitGroupList)
end

function EquipBaseInfoView:CreateSuitItem(suitGroupList)
	for index, suit in pairs(suitGroupList) do
		local gameObject = UnityEngine.Object.Instantiate(self.SuitAttributeGroupItemPrefab, self.SuitEffectContent.transform)
		local cell = EquipWearSuitView.New(gameObject)

		cell:Refresh(suit, true)
		self:AddSuitGroupScrollViewItem(cell)
		gameObject:SetActive(true)
	end
end

function EquipBaseInfoView:ResetSuitGroupScrollView()
	for _, cell in pairs(self.suitCellList) do
		local gameObject = cell.gameObject

		cell:OnDestroy()
		gameObject.transform:SetParent(nil)
		GameObject.Destroy(gameObject)
	end

	self.suitCellList = {}
end

function EquipBaseInfoView:AddSuitGroupScrollViewItem(cell)
	table.insert(self.suitCellList, cell)
end

local maxAdditionalAttributeCount = 4

function EquipBaseInfoView:RefreshAdditionalAttribute(attributeList)
	self:ResetAdditionalAttributeScrollView()

	if attributeList ~= nil then
		for index, attribute in pairs(attributeList) do
			local gameObject = UnityEngine.Object.Instantiate(self.attItemPrefab, self.AdditionalAttributeContent.transform)
			local cell = EquipAdditionalAttributeCell.New(gameObject)

			cell:Refresh(self.equipData, attribute, index)
			self:AddAdditionalAttributeScrollViewItem(cell)
			gameObject:SetActive(true)
		end

		for index = #attributeList + 1, maxAdditionalAttributeCount do
			local gameObject = UnityEngine.Object.Instantiate(self.EmptyAttItemPrefab, self.AdditionalAttributeContent.transform)
			local cell = EquipAdditionalAttributeCell.New(gameObject)

			self:AddAdditionalAttributeScrollViewItem(cell)
			gameObject:SetActive(true)
		end
	end
end

function EquipBaseInfoView:ResetAdditionalAttributeScrollView()
	for _, cell in pairs(self.AdditionalAttributeCellList) do
		local gameObject = cell.gameObject

		cell:OnDestroy()
		gameObject.transform:SetParent(nil)
		GameObject.Destroy(gameObject)
	end

	self.AdditionalAttributeCellList = {}
end

function EquipBaseInfoView:AddAdditionalAttributeScrollViewItem(cell)
	table.insert(self.AdditionalAttributeCellList, cell)
end

function EquipBaseInfoView:OnToggleSeeClick(isOn)
	EventDispatcher.Dispatch(EventID.EquipWareHouseShowAwakenEvent, isOn, self.suitId)
end

return EquipBaseInfoView
