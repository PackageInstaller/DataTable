-- chunkname: @IQIGame\\UI\\EquipCompose\\ComposeInfoView.lua

local ComposeInfoView = {
	goMainAttCells = {},
	goEffectDesc1Cells = {},
	goEffectDesc2Cells = {},
	goEffectDesc2CellTitles = {}
}

function ComposeInfoView.New(go)
	local o = Clone(ComposeInfoView)

	o:Initialize(go)

	return o
end

function ComposeInfoView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go
	self.tfSpecialName = self.goSpecialName:GetComponent("Text")
	self.tfEquipName = self.goEquipName:GetComponent("Text")
	self.tfEquipDesc = self.goEquipDesc:GetComponent("Text")
	self.imgSoulHead = self.goSoulHead:GetComponent("Image")
	self.goMainAttCells[1] = self.goMainAttCell
	self.goEffectDesc1Cells[1] = self.goEffectDesc1Cell
	self.goEffectDesc2Cells[1] = self.goEffectDesc2Cell
	self.goEffectDesc2CellTitles[1] = self.goEffectDesc2CellTitle
	self.goTitle1:GetComponent("Text").text = EquipUIApi:GetString("goTitle1")
	self.goTitle2:GetComponent("Text").text = EquipUIApi:GetString("goTitle2")
	self.goTitle3:GetComponent("Text").text = EquipUIApi:GetString("goTitle3")
	self.goTitle4:GetComponent("Text").text = EquipUIApi:GetString("goEquipDescTitle")
	self.goSpecialDesc:GetComponent("Text").text = EquipUIApi:GetString("goSpecialDesc")
end

function ComposeInfoView:Refresh(itemData)
	self.itemData = itemData
	self.cfgSoulPaintingData = self.itemData:GetCfg()

	for i, v in pairsCfg(CfgSoulPaintingQualityTable) do
		if v.PaintingId == self.cfgSoulPaintingData.Id and v.QualityLevel == self.itemData.equipData.star then
			self.cfgSoulPaintingQualityData = v

			break
		end
	end

	self:RefreshMisc()
	self:RefreshMainAtt()
	self:RefreshEffectDesc1()
	self:RefreshEffectDesc2()
	self:RefreshEquipDesc()
end

function ComposeInfoView:OnHide()
	return
end

function ComposeInfoView:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function ComposeInfoView:RefreshMisc()
	self.tfEquipName.text = EquipUIApi:GetString("goEquipName", self.cfgSoulPaintingData.Name)

	self.goSpecialName.transform.parent.gameObject:SetActive(self.cfgSoulPaintingData.ExclusiveSoul ~= 0)

	if self.cfgSoulPaintingData.ExclusiveSoul ~= 0 then
		self.tfSpecialName.text = EquipUIApi:GetString("goSpecialName", CfgSoulTable[self.cfgSoulPaintingData.ExclusiveSoul].Name)
	end

	self.goSoulHead:SetActive(self.itemData.equipData ~= nil and self.itemData.equipData.isWore)

	if self.itemData.equipData ~= nil and self.itemData.equipData.isWore then
		local soulId = SoulPrefabModule.GetPrefab(self.itemData.equipData.soulPrefabIds[1]).soulCid

		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(SoulModule.soulDataDic[soulId]:GetCfgSoulRes2D().SoulFormationImage), self.imgSoulHead)
	end
end

function ComposeInfoView:RefreshMainAtt()
	self.layIndex = 1

	self.goTitle1.transform.parent.parent:SetSiblingIndex(self.layIndex)

	local mainId2ValueDic = EquipModule.GetMainAbilityValue(self.cfgSoulPaintingQualityData, self.itemData.equipData.lv)
	local mainShowList = {}
	local sortTable = {}

	for i, v in ipairs(self.cfgSoulPaintingQualityData.MainBility) do
		sortTable[i] = v
	end

	table.sort(sortTable, function(a, b)
		return a < b
	end)

	for i, v in ipairs(sortTable) do
		local showValue = EquipUIApi:GetString("curMainAttValue", AttributeModule.GetAttShowValue(v, mainId2ValueDic[v]))
		local name = EquipUIApi:GetString("goAttName", v, true)

		mainShowList[#mainShowList + 1] = {
			v,
			showValue,
			name
		}
	end

	for i, v in ipairs(self.goMainAttCells) do
		v:SetActive(i <= #mainShowList)
	end

	for i, v in ipairs(mainShowList) do
		local trans = self:GetGoMainAttCell(i).transform

		trans:Find("Text_01"):GetComponent("Text").text = v[3]
		trans:Find("Text_02"):GetComponent("Text").text = v[2]
		self.layIndex = self.layIndex + 1

		trans:SetSiblingIndex(self.layIndex)
	end
end

function ComposeInfoView:RefreshEffectDesc1()
	self.layIndex = 50

	self.goTitle2.transform.parent.parent:SetSiblingIndex(self.layIndex)

	local ids = {}

	if #self.cfgSoulPaintingData.PabilityID[1] > 0 then
		ids[#ids + 1] = self.cfgSoulPaintingData.PabilityID[1][self.itemData.equipData.star]
	end

	if #self.cfgSoulPaintingData.PabilityID[2] > 0 then
		ids[#ids + 1] = self.cfgSoulPaintingData.PabilityID[2][self.itemData.equipData.star]
	end

	for i, v in ipairs(self.goEffectDesc1Cells) do
		v:SetActive(i <= #ids)
	end

	if #ids == 0 then
		self.goTitle2.transform.parent.parent.gameObject:SetActive(false)
	else
		self.goTitle2.transform.parent.parent.gameObject:SetActive(true)

		for i, v in ipairs(ids) do
			local trans = self:GetGoEffectDesc1Cell(i).transform

			trans:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goEffectDesc1", CfgPabilityTable[v].Describe)
			self.layIndex = self.layIndex + 1

			trans:SetSiblingIndex(self.layIndex)
		end
	end
end

function ComposeInfoView:RefreshEffectDesc2()
	self.layIndex = 100

	self.goTitle3.transform.parent.parent:SetSiblingIndex(self.layIndex)

	local ids = {}

	if #self.cfgSoulPaintingData.PabilityID[3] > 0 then
		ids[#ids + 1] = self.cfgSoulPaintingData.PabilityID[3][self.itemData.equipData.star]
	end

	if #self.cfgSoulPaintingData.PabilityID[4] > 0 then
		ids[#ids + 1] = self.cfgSoulPaintingData.PabilityID[4][self.itemData.equipData.star]
	end

	for i, v in ipairs(self.goEffectDesc2Cells) do
		v:SetActive(i <= #ids)
		self.goEffectDesc2CellTitles[i]:SetActive(i <= #ids)
	end

	if #ids == 0 then
		self.goTitle3.transform.parent.parent.gameObject:SetActive(false)
	else
		self.goTitle3.transform.parent.parent.gameObject:SetActive(true)

		for i, v in ipairs(ids) do
			local trans2 = self:GetGoEffectDesc2CellTitle(i).transform

			trans2:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goEffectDesc2Title", i)
			trans2:Find("Text_02"):GetComponent("Text").text = EquipUIApi:GetString("goEffectDesc2Name", CfgPabilityTable[v].Name)
			self.layIndex = self.layIndex + 1

			trans2:SetSiblingIndex(self.layIndex)

			local trans = self:GetGoEffectDesc2Cell(i).transform

			trans:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goEffectDesc2", CfgPabilityTable[v].Describe)
			self.layIndex = self.layIndex + 1

			trans:SetSiblingIndex(self.layIndex)
		end
	end
end

function ComposeInfoView:RefreshEquipDesc()
	self.layIndex = 150

	self.goTitle4.transform.parent.parent:SetSiblingIndex(self.layIndex)

	self.tfEquipDesc.text = EquipUIApi:GetString("goEquipDesc", self.cfgSoulPaintingData.Describe)
	self.layIndex = self.layIndex + 1

	self.goEquipDesc.transform:SetSiblingIndex(self.layIndex)
end

function ComposeInfoView:GetGoMainAttCell(index)
	local ret = self.goMainAttCells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goMainAttCell)
		self.goMainAttCells[index] = ret

		ret.transform:SetParent(self.goMainAttCell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function ComposeInfoView:GetGoEffectDesc1Cell(index)
	local ret = self.goEffectDesc1Cells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectDesc1Cell)
		self.goEffectDesc1Cells[index] = ret

		ret.transform:SetParent(self.goEffectDesc1Cell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function ComposeInfoView:GetGoEffectDesc2Cell(index)
	local ret = self.goEffectDesc2Cells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectDesc2Cell)
		self.goEffectDesc2Cells[index] = ret

		ret.transform:SetParent(self.goEffectDesc2Cell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function ComposeInfoView:GetGoEffectDesc2CellTitle(index)
	local ret = self.goEffectDesc2CellTitles[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectDesc2CellTitle)
		self.goEffectDesc2CellTitles[index] = ret

		ret.transform:SetParent(self.goEffectDesc2CellTitle.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

return ComposeInfoView
