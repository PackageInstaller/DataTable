-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormationChooseEquip\\PlaceGameEquipDetailView.lua

local m = {
	soulCid = 0,
	goMainAttCells = {},
	goEffectDesc1Cells = {},
	goEffectDesc2Cells = {},
	goEffectDesc2CellTitles = {}
}

require("IQIGame.UIExternalApi.PlaceGamePlayerUpdateUIApi")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = ItemCell.New(self.goItemCell, false)
	self.goMainAttCells[1] = self.goMainAttCell
	self.goEffectDesc1Cells[1] = self.goEffectDesc1Cell
	self.goEffectDesc2Cells[1] = self.goEffectDesc2Cell
	self.goEffectDesc2CellTitles[1] = self.goEffectDesc2CellTitle

	self.goEffectDesc2CellTitle:SetActive(false)
	self.goSuitView:SetActive(false)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:Refresh(itemData, itemDataCompare, soulCid)
	self.itemData = itemData
	self.itemDataCompare = itemDataCompare
	self.soulCid = soulCid

	self:RefreshMisc()
	self:RefreshMainAtt()
	self:RefreshEffectDesc1()
	self:RefreshEffectDesc2()
	self:RefreshDescription()
end

function m:RefreshMisc()
	UGUIUtil.SetText(self.goEquipName, EquipUIApi:GetString("goEquipName", self.itemData:GetCfg().Name))
	self.itemCell:SetItemByCID(self.itemData.cid, 1)
	self.itemCell:ShowLV(self.itemData.placeGameEquipData.placeGameEquipPOD.level, true)

	local soulName = ""

	if self.soulCid ~= 0 then
		local cfgSoulData = CfgSoulTable[self.soulCid]

		soulName = cfgSoulData.Name
	end

	UGUIUtil.SetText(self.goSoulName, EquipUIApi:GetString("goSoulName", soulName))
	AssetUtil.LoadImage(self, EquipUIApi:GetString("goBgQualityPath", self.itemData:GetCfg().Quality), self.goBgQuality:GetComponent("Image"))
end

function m:RefreshMainAtt()
	self.layIndex = 1

	local mainShowList = self:GetMainAttShowList(self.itemData)
	local mainAttId2ValueDicCompare = self:GetMainAttShowList(self.itemDataCompare)

	for i, v in ipairs(self.goMainAttCells) do
		v:SetActive(i <= #mainShowList)
	end

	for i, v in ipairs(mainShowList) do
		local trans = self:GetGoMainAttCell(i).transform

		AssetUtil.LoadImage(self, PlaceGamePlayerUpdateUIApi:GetString("AttIconPath", v.id), trans:Find("Icon"):GetComponent("Image"))

		trans:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goAttName", v.id, true)
		trans:Find("Text_02"):GetComponent("Text").text = AttributeModule.GetAttShowValue(v.id, v.value)

		trans:Find("Image_Up").gameObject:SetActive(false)
		trans:Find("Image_Down").gameObject:SetActive(false)

		self.layIndex = self.layIndex + 1

		trans:SetSiblingIndex(self.layIndex)
	end
end

function m:RefreshEffectDesc1()
	self.layIndex = 50

	self.goTitle2.transform.parent:SetSiblingIndex(self.layIndex)

	local ids = self.itemData.placeGameEquipData.placeGameEquipPOD.pAbilityIDEffect1 or {}

	for i, v in ipairs(self.goEffectDesc1Cells) do
		v:SetActive(i <= #ids)
	end

	if #ids == 0 then
		self.goTitle2.transform.parent.gameObject:SetActive(false)
	else
		self.goTitle2.transform.parent.gameObject:SetActive(true)

		for i, v in ipairs(ids) do
			local trans = self:GetGoEffectDesc1Cell(i).transform

			trans:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goEffectDesc1", UIGlobalApi.GetTextWithoutKeywordTag(CfgPabilityTable[v].Describe))
			self.layIndex = self.layIndex + 1

			trans:SetSiblingIndex(self.layIndex)
		end
	end
end

function m:RefreshEffectDesc2()
	self.layIndex = 100

	self.goTitle3.transform.parent:SetSiblingIndex(self.layIndex)

	local ids = self.itemData.placeGameEquipData.placeGameEquipPOD.pAbilityIDEffect2 or {}

	for i, v in ipairs(self.goEffectDesc2Cells) do
		v:SetActive(i <= #ids)
		self.goEffectDesc2CellTitles[i]:SetActive(i <= #ids)
	end

	if #ids == 0 then
		self.goTitle3.transform.parent.gameObject:SetActive(false)
	else
		self.goTitle3.transform.parent.gameObject:SetActive(true)

		for i, v in ipairs(ids) do
			local trans2 = self:GetGoEffectDesc2CellTitle(i).transform

			trans2:Find("Text_02"):GetComponent("Text").text = EquipUIApi:GetString("goEffectDesc2Name", CfgPabilityTable[v].Name)
			self.layIndex = self.layIndex + 1

			trans2:SetSiblingIndex(self.layIndex)

			local trans = self:GetGoEffectDesc2Cell(i).transform

			trans:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goEffectDesc2", UIGlobalApi.GetTextWithoutKeywordTag(CfgPabilityTable[v].Describe))
			self.layIndex = self.layIndex + 1

			trans:SetSiblingIndex(self.layIndex)
		end
	end
end

function m:RefreshDescription()
	self.layIndex = 150

	self.goTitle5.transform.parent:SetSiblingIndex(self.layIndex)

	local describe = self.itemData:GetCfg().Describe

	if describe == nil or describe == "" then
		self.goTitle5.transform.parent.gameObject:SetActive(false)
		self.goDescriptionCell:SetActive(false)
	else
		self.goTitle5.transform.parent.gameObject:SetActive(true)
		self.goDescriptionCell:SetActive(true)
		UGUIUtil.SetTextInChildren(self.goDescriptionCell, describe)

		self.layIndex = self.layIndex + 1

		self.goDescriptionCell.transform:SetSiblingIndex(self.layIndex)
	end
end

function m:GetMainAttShowList(itemData)
	local mainShowList = {}

	if itemData and itemData.placeGameEquipData and itemData.placeGameEquipData.placeGameEquipPOD then
		mainShowList = itemData.placeGameEquipData.placeGameEquipPOD.property or {}
	end

	if #mainShowList > 1 then
		table.sort(mainShowList, function(a, b)
			return a.id < b.id
		end)
	end

	return mainShowList
end

function m:GetGoMainAttCell(index)
	local ret = self.goMainAttCells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goMainAttCell)
		self.goMainAttCells[index] = ret

		ret.transform:SetParent(self.goMainAttCell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function m:GetGoEffectDesc1Cell(index)
	local ret = self.goEffectDesc1Cells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectDesc1Cell)
		self.goEffectDesc1Cells[index] = ret

		ret.transform:SetParent(self.goEffectDesc1Cell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function m:GetGoEffectDesc2Cell(index)
	local ret = self.goEffectDesc2Cells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectDesc2Cell)
		self.goEffectDesc2Cells[index] = ret

		ret.transform:SetParent(self.goEffectDesc2Cell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function m:GetGoEffectDesc2CellTitle(index)
	local ret = self.goEffectDesc2CellTitles[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectDesc2CellTitle)
		self.goEffectDesc2CellTitles[index] = ret

		ret.transform:SetParent(self.goEffectDesc2CellTitle.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function m:Dispose()
	self.itemCell:Dispose()

	self.itemCell = nil

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
