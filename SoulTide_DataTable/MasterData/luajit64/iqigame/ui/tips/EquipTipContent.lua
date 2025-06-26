-- chunkname: @IQIGame\\UI\\Tips\\EquipTipContent.lua

local EquipTipContent = {
	lastSortIndex = 30,
	tfAttBasePool = {},
	tfAttSecPool = {},
	tfSuitEffectPool = {}
}

function EquipTipContent.New(go)
	local o = Clone(EquipTipContent)

	o:Initialize(go)

	return o
end

function EquipTipContent:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(self.View, self)

	self.trfParent = go.transform
	self.rectTrfParent = go:GetComponent("RectTransform")
	self.tfDesc = self.goDesc:GetComponent("Text")
	self.tfAttBasePool[1] = self.goAttBase:GetComponent("Text")
	self.tfAttSecPool[1] = self.goAttSec:GetComponent("Text")
	self.tfSuitEffectPool[1] = self.goSuitEffect:GetComponent("Text")
	self.goAttBaseTitle.transform:Find("Text_Title"):GetComponent("Text").text = EquipTipApi:GetString("goAttBaseTitle")
	self.goAttSecTitle.transform:Find("Text_Title"):GetComponent("Text").text = EquipTipApi:GetString("goAttSecTitle")
	self.goSuitTitle.transform:Find("Text_Title"):GetComponent("Text").text = EquipTipApi:GetString("goSuitTitle")
end

function EquipTipContent:RefreshView(itemData)
	self.itemData = itemData
	self.cfgItemData = self.itemData:GetCfg()

	self:RefreshDatum()
	self:RefreshMisc()
	self:RefreshAttBase()
	self:RefreshAttSec()
	self:RefreshSuit()
end

function EquipTipContent:RefreshDatum()
	local suitId = self.cfgItemData.SoulPaintingSuitId

	if suitId ~= nil and suitId ~= 0 then
		self.cfgSuitData = CfgSoulPaintingSuitTable[suitId]
	else
		self.cfgSuitData = nil
	end

	self.lastSortIndex = 30
end

function EquipTipContent:RefreshMisc()
	self.tfDesc.text = EquipTipApi:GetString("goDesc", self.cfgItemData.Describe)
	self.rectTrfParent.anchoredPosition3D = Vector3.New(0, 0, 0)
end

function EquipTipContent:RefreshAttBase()
	local valuesDesc = {}

	for i, v in ipairs(self.cfgItemData.MainBility) do
		if v ~= 0 then
			local value = 0

			valuesDesc[#valuesDesc + 1] = EquipTipApi:GetString("goAtt1", v, value)
		end
	end

	local isDataOk = #valuesDesc > 0

	self.goAttBaseTitle:SetActive(isDataOk)

	for i, v in ipairs(self.tfAttBasePool) do
		v.gameObject:SetActive(i <= #valuesDesc)
	end

	if isDataOk then
		for i, v in ipairs(valuesDesc) do
			local tfComp = self:GetAttBaseText(i)

			tfComp.text = v
		end

		self:SetSiblingIndex(self.goAttBaseTitle.transform)

		for i, v in ipairs(self.tfAttBasePool) do
			self:SetSiblingIndex(v.transform)
		end
	end
end

function EquipTipContent:RefreshAttSec()
	local valuesDesc = {}

	for i, v in ipairs(self.cfgItemData.SecondBility) do
		if v ~= 0 then
			local value = AttributeModule.GetAttShowValue(v, self.cfgItemData.SecondBilityNum[i])

			valuesDesc[#valuesDesc + 1] = EquipTipApi:GetString("goAtt2", v, value)
		end
	end

	local isDataOk = #valuesDesc > 0

	self.goAttSecTitle:SetActive(isDataOk)

	for i, v in ipairs(self.tfAttSecPool) do
		v.gameObject:SetActive(i <= #valuesDesc)
	end

	if isDataOk then
		for i, v in ipairs(valuesDesc) do
			local tfComp = self:GetAttSecText(i)

			tfComp.text = v
		end

		self:SetSiblingIndex(self.goAttSecTitle.transform)

		for i, v in ipairs(self.tfAttSecPool) do
			self:SetSiblingIndex(v.transform)
		end
	end
end

function EquipTipContent:RefreshSuit()
	local isDataOk = self.cfgSuitData ~= nil

	self.goSuitTitle:SetActive(isDataOk)

	if isDataOk then
		local ids = {}

		for i, v in ipairs(self.tfSuitEffectPool) do
			v.gameObject:SetActive(i <= #ids)
		end

		for i, v in ipairs(ids) do
			local cfgPabilityData = CfgPabilityTable[v]
			local tfComp = self:GetSuitEffectText(i)

			tfComp.text = EquipTipApi:GetString("goSuitEffect", cfgPabilityData.Describe)
		end
	else
		for i, v in ipairs(self.tfSuitEffectPool) do
			v.gameObject:SetActive(false)
		end
	end

	self:SetSiblingIndex(self.goSuitTitle.transform)

	for i, v in ipairs(self.tfSuitEffectPool) do
		self:SetSiblingIndex(v.transform)
	end
end

function EquipTipContent:GetAttBaseText(index)
	local ret = self.tfAttBasePool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goAttBase):GetComponent("Text")
		self.tfAttBasePool[index] = ret

		ret.transform:SetParent(self.trfParent, false)
	end

	return ret
end

function EquipTipContent:GetAttSecText(index)
	local ret = self.tfAttSecPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goAttSec):GetComponent("Text")
		self.tfAttSecPool[index] = ret

		ret.transform:SetParent(self.trfParent, false)
	end

	return ret
end

function EquipTipContent:GetSuitEffectText(index)
	local ret = self.tfSuitEffectPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goSuitEffect):GetComponent("Text")

		ret.transform:SetParent(self.trfParent, false)

		self.tfSuitEffectPool[index] = ret
	end

	return ret
end

function EquipTipContent:SetSiblingIndex(transform)
	self.lastSortIndex = self.lastSortIndex + 1

	transform:SetSiblingIndex(self.lastSortIndex)
end

function EquipTipContent:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return EquipTipContent
