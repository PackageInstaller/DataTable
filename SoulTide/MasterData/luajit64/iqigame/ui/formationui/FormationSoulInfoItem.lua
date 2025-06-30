-- chunkname: @IQIGame\\UI\\FormationUI\\FormationSoulInfoItem.lua

local m = {
	showJewelry = false,
	FormationIndex = 0,
	AttrItems = {}
}
local FormationSoulCellAttrItem = require("IQIGame.UI.FormationUI.FormationSoulCellAttrItem")
local FormationJewelryCell = require("IQIGame.UI.FormationUI.FormationJewelryCell")

function m.GetOpenPreloadAssetPaths()
	return
end

function m.New(view, showJewelry)
	local obj = Clone(m)

	obj:Init(view, showJewelry)

	return obj
end

function m:Init(view, showJewelry)
	self.View = view

	if showJewelry ~= nil then
		self.showJewelry = showJewelry
	end

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSoulInfoBtn()
		self:OnClickSoulInfoBtn()
	end

	function self.DelegateOnSoulPrefabUpdate()
		self:OnSoulPrefabUpdate()
	end

	function self.DelegateOnSoulDataChange(soulCid)
		self:OnSoulDataChange(soulCid)
	end

	local showAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #showAttrIds do
		local item = FormationSoulCellAttrItem.New(UnityEngine.Object.Instantiate(self.AttrItemPrefab))

		item.View.transform:SetParent(self.AttrGrid.transform, false)

		self.AttrItems[i] = item
	end

	self.JewelryCell = FormationJewelryCell.New(self.JewelryView, self.showJewelry)

	UGUIUtil.SetText(self.PowerLabel, FormationUIApi:GetString("SoulInfoPowerLabel"))
	UGUIUtil.SetTextInChildren(self.EmptyView, FormationUIApi:GetString("SoulInfoEmptyLabel"))
	UGUIUtil.SetTextInChildren(self.SoulInfoBtn, FormationUIApi:GetString("SoulInfoInfoBtnText"))
	self.SkillGroupView:SetActive(not showJewelry)

	self.JewelryItemCell = ItemCell.New(self.JewelryItem.transform:GetChild(0).gameObject, false, false)
end

function m:AddListeners()
	self.SoulInfoBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSoulInfoBtn)
	EventDispatcher.AddEventListener(EventID.SoulPrefabUpdate, self.DelegateOnSoulPrefabUpdate)
	EventDispatcher.AddEventListener(EventID.SoulDataChange, self.DelegateOnSoulDataChange)
end

function m:RemoveListeners()
	self.SoulInfoBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSoulInfoBtn)
	EventDispatcher.RemoveEventListener(EventID.SoulPrefabUpdate, self.DelegateOnSoulPrefabUpdate)
	EventDispatcher.RemoveEventListener(EventID.SoulDataChange, self.DelegateOnSoulDataChange)
end

function m:SetData(soulData, soulPrefabData, formationIndex)
	self.SoulData = soulData
	self.SoulPrefabData = soulPrefabData
	self.FormationIndex = formationIndex

	self.NormalView:SetActive(soulData ~= nil)
	self.EmptyView:SetActive(soulData == nil)

	local originalAttrs

	if soulData ~= nil then
		originalAttrs = soulData.atts
	end

	local finalAttrs

	if soulPrefabData ~= nil then
		finalAttrs = soulPrefabData.attrs
	end

	self:RefreshAttrs(finalAttrs, originalAttrs)

	if soulData == nil then
		return
	end

	local cfgSoulData = soulData:GetCfgSoul()
	local cfgSoulResData = soulData:GetCfgSoulRes2D()
	local power

	if self.SoulPrefabData ~= nil then
		power = self.SoulPrefabData.power
	end

	local skillGroupCid

	if self.SoulPrefabData ~= nil then
		skillGroupCid = self.SoulPrefabData.skillGroupId
	end

	self:RefreshMisc(cfgSoulData, cfgSoulResData, soulData:GetCfgSoulQuality().Quality, soulData.lv, power, skillGroupCid)
	self.JewelryCell:SetData(soulData, soulPrefabData, formationIndex)
	self:RefreshJewelryBlock()
end

function m:SetShowDataByFormationSoulPrefabPOD(soulPrefab)
	self.NormalView:SetActive(soulPrefab ~= nil)
	self.EmptyView:SetActive(soulPrefab == nil)

	local finalAttrs

	if soulPrefab ~= nil then
		finalAttrs = soulPrefab.attr
	end

	self:RefreshAttrs(finalAttrs, nil)

	if soulPrefab == nil then
		return
	end

	local cfgSoulData = CfgSoulTable[soulPrefab.soulCid]
	local cfgDressData = CfgDressTable[soulPrefab.dress2DCid]
	local cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]
	local cfgSoulQualityData = CfgSoulQualityTable[soulPrefab.qualityId]

	self:RefreshMisc(cfgSoulData, cfgSoulResData, cfgSoulQualityData.Quality, soulPrefab.lv, soulPrefab.power, soulPrefab.skillGroupId)
	self.SoulInfoBtn:SetActive(false)
end

function m:RefreshAttrs(finalAttrs, originalAttrs)
	local showAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #showAttrIds do
		local item = self.AttrItems[i]
		local attrId = showAttrIds[i]
		local originalAttrValue

		if originalAttrs ~= nil then
			originalAttrValue = originalAttrs[attrId]
		end

		local finalAttrValue

		if finalAttrs == nil then
			finalAttrValue = originalAttrValue
		else
			finalAttrValue = finalAttrs[attrId]
		end

		item:SetData(attrId, finalAttrValue, originalAttrValue)
	end
end

function m:RefreshMisc(cfgSoulData, cfgSoulResData, qualityLevel, level, power, skillGroupCid)
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgSoulResData.SoulFormationImage), self.SoulPortraitImage:GetComponent("Image"))
	self.SoulStar:GetComponent("SimpleStarComponent"):UpdateView(5, qualityLevel)
	UGUIUtil.SetText(self.SoulNameText, cfgSoulData.EnglishName)
	UGUIUtil.SetText(self.LevelText, FormationUIApi:GetString("SoulInfoLevelText", level))
	self.PowerView:SetActive(self.SoulPrefabData ~= nil)

	if power ~= nil then
		UGUIUtil.SetText(self.PowerText, power)
	end

	if skillGroupCid == nil then
		skillGroupCid = cfgSoulData.DefaultSkill[1]
	end

	local cfgSkillGroupData = CfgSkillGroupTable[skillGroupCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgSkillGroupData.Icon), self.SkillGroupIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.SkillGroupText, FormationUIApi:GetString("SkillGroupIndexText", cfgSkillGroupData.GroupQuality))
end

function m:OnClickSoulInfoBtn()
	local formationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)
	local isInFormation = false

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if soulPrefabData.soulCid == self.SoulData.soulCid then
			isInFormation = true

			break
		end
	end

	local switchList

	if isInFormation then
		switchList = {}

		local soulIndexMap = {}

		for prefabId, prefabIndex in pairs(formationPOD.formation) do
			local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

			if soulPrefabData.soulCid ~= nil then
				table.insert(switchList, SoulModule.GetSoulData(soulPrefabData.soulCid))

				soulIndexMap[soulPrefabData.soulCid] = prefabIndex
			end
		end

		table.sort(switchList, function(soulData1, soulData2)
			return soulIndexMap[soulData1.soulCid] < soulIndexMap[soulData2.soulCid]
		end)
	else
		switchList = {
			self.SoulData
		}
	end

	UIModule.Open(Constant.UIControllerName.SoulUI, Constant.UILayer.UI, {
		[UIParam.soulUI.soulData] = self.SoulData,
		[UIParam.soulUI.switchList] = switchList
	})
end

function m:OnClose()
	return
end

function m:OnSoulPrefabUpdate()
	self:SetData(self.SoulData, self.SoulPrefabData, self.FormationIndex)
end

function m:OnSoulDataChange(soulCid)
	self:SetData(self.SoulData, self.SoulPrefabData, self.FormationIndex)
end

function m:RefreshJewelryBlock()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.JEWELRY)

	self.JewelryItem:SetActive(false)

	if result and self.SoulPrefabData then
		local itemID, speed = self.SoulPrefabData:GetEquipJewelryAndSpeed()

		if itemID then
			self.JewelryItem:SetActive(true)

			local itemData = WarehouseModule.GetItemDataById(itemID)

			self.JewelryItemCell:SetItem(itemData)
		end
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.AttrItems do
		local item = self.AttrItems[i]

		item:Dispose()
	end

	self.JewelryCell:Dispose()
	self.JewelryItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
