-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormationChooseSoul\\PlaceGameFormationSoulInfoItem.lua

local m = {
	formationIndex = 0,
	attrItems = {}
}

require("IQIGame.UIExternalApi.PlaceGameFormationChooseSoulUIApi")

local PlaceGameFormationAttrCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormation.PlaceGameFormationAttrCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegatePlaceGameSoulPrefabUpdate(id)
		self:OnSoulPrefabUpdate(id)
	end

	function self.DelegatePlaceGameSoulDataChange(soulCid)
		self:OnSoulDataChange(soulCid)
	end

	local showAttrIds = PlaceGamePlayerFormationUIApi:GetString("FightAttSort")

	for i = 1, #showAttrIds do
		local item = PlaceGameFormationAttrCell.New(UnityEngine.Object.Instantiate(self.AttrItemPrefab))

		item.View.transform:SetParent(self.AttrGrid.transform, false)

		self.attrItems[i] = item
	end

	self:AddListener()
end

function m:AddListener()
	EventDispatcher.AddEventListener(EventID.PlaceGameSoulPrefabUpdate, self.DelegatePlaceGameSoulPrefabUpdate)
	EventDispatcher.AddEventListener(EventID.PlaceGameSoulDataChange, self.DelegatePlaceGameSoulDataChange)
end

function m:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.PlaceGameSoulPrefabUpdate, self.DelegatePlaceGameSoulPrefabUpdate)
	EventDispatcher.RemoveEventListener(EventID.PlaceGameSoulDataChange, self.DelegatePlaceGameSoulDataChange)
end

function m:OnSoulPrefabUpdate(id)
	self:SetData(self.soulData, self.soulPrefabData, self.formationIndex)
end

function m:OnSoulDataChange(soulCid)
	self:SetData(self.soulData, self.soulPrefabData, self.formationIndex)
end

function m:SetData(soulData, soulPrefabData, formationIndex)
	self.soulData = soulData
	self.soulPrefabData = soulPrefabData
	self.formationIndex = formationIndex

	self.NormalView:SetActive(soulData ~= nil)
	self.EmptyView:SetActive(soulData == nil)

	local originalAttrs = {}

	if soulData ~= nil then
		local cfgSoulLevelData = soulData:GetCfgPlaceGameSoulLevelData()

		for i = 1, #cfgSoulLevelData.AttType do
			local attType = cfgSoulLevelData.AttType[i]
			local value = cfgSoulLevelData.AttValue[i]

			originalAttrs[attType] = value
		end
	end

	local finalAttrs

	if soulPrefabData ~= nil then
		finalAttrs = soulPrefabData.placeGameSoulPrefabPOD.attr
	end

	self:RefreshAttrs(finalAttrs, originalAttrs)

	if soulData == nil then
		return
	end

	local cfgSoulData = soulData:GetCfgSoulData()
	local cfgSoulResData = CfgSoulResTable[soulData:GetCfgPlaceGameSoulData().SoulResID]
	local power

	if self.soulPrefabData ~= nil then
		power = self.soulPrefabData.placeGameSoulPrefabPOD.power
	end

	local skillGroupCid = self.soulData:GetCfgPlaceGameSoulData().DefaultSkill

	self:RefreshMisc(cfgSoulData, cfgSoulResData, soulData.placeGameSoulPOD.level, power, skillGroupCid)
end

function m:RefreshMisc(cfgSoulData, cfgSoulResData, level, power, skillGroupCid)
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgSoulResData.SoulFormationImage), self.SoulPortraitImage:GetComponent("Image"))
	UGUIUtil.SetText(self.SoulNameText, cfgSoulData.EnglishName)
	UGUIUtil.SetText(self.LevelText, PlaceGameFormationChooseSoulUIApi:GetString("SoulInfoLevelText", level))
	self.PowerView:SetActive(power ~= nil)

	if power ~= nil then
		UGUIUtil.SetText(self.PowerText, power)
	end

	if skillGroupCid == nil then
		skillGroupCid = cfgSoulData.DefaultSkill[1]
	end

	local cfgSkillGroupData = CfgSkillGroupTable[skillGroupCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgSkillGroupData.Icon), self.SkillGroupIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.SkillGroupText, PlaceGamePlayerFormationUIApi:GetString("SkillGroupIndexText", cfgSkillGroupData.GroupQuality))
end

function m:RefreshAttrs(finalAttrs, originalAttrs)
	local showAttrIds = PlaceGamePlayerFormationUIApi:GetString("FightAttSort")

	for i = 1, #showAttrIds do
		local item = self.attrItems[i]
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

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.attrItems) do
		v:Dispose()
	end

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
