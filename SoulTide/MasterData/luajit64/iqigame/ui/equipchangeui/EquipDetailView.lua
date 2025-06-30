-- chunkname: @IQIGame\\UI\\EquipChangeUI\\EquipDetailView.lua

local EquipDetailView = {
	SoulCid = 0,
	goMainAttCells = {},
	goEffectDesc1Cells = {},
	goEffectDesc2Cells = {},
	goEffectDesc2CellTitles = {},
	SuitItems = {}
}
local EquipDetailViewSuitItem = require("IQIGame.UI.EquipChangeUI.EquipDetailViewSuitItem")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function EquipDetailView.New(go)
	local o = Clone(EquipDetailView)

	o:Initialize(go)

	return o
end

function EquipDetailView:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.tfEquipName = self.goEquipName:GetComponent("Text")
	self.tfSoulName = self.goSoulName:GetComponent("Text")
	self.imgBgQuality = self.goBgQuality:GetComponent("Image")
	self.itemCell = ItemCell.PackageOrReuseView(self, self.goItemCell, false)
	self.goMainAttCells[1] = self.goMainAttCell
	self.goEffectDesc1Cells[1] = self.goEffectDesc1Cell
	self.goEffectDesc2Cells[1] = self.goEffectDesc2Cell
	self.goEffectDesc2CellTitles[1] = self.goEffectDesc2CellTitle

	UGUIUtil.SetText(self.goTitle1, EquipUIApi:GetString("goTitle1"))
	UGUIUtil.SetText(self.goTitle2, EquipUIApi:GetString("goTitle2"))
	UGUIUtil.SetText(self.goTitle3, EquipUIApi:GetString("goTitle3"))
	UGUIUtil.SetText(self.goSuitTitle, EquipUIApi:GetString("goSuitTitle"))

	self.SuitItemPool = UIObjectPool.New(3, function()
		local item = EquipDetailViewSuitItem.New(UnityEngine.Object.Instantiate(self.goSuitEffectItemPrefab))

		return item
	end, function(item)
		local v = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
end

function EquipDetailView:Refresh(itemData, itemDataCompare, soulCid, wearingEquipCids)
	self.itemData = itemData
	self.itemDataCompare = itemDataCompare
	self.SoulCid = soulCid
	self.cfgSoulPaintingData = self.itemData:GetCfg()
	self.cfgSoulPaintingQualityData = nil
	self.cfgSoulPaintingQualityDataCompare = nil
	self.wearingEquipCids = wearingEquipCids

	for i, v in pairsCfg(CfgSoulPaintingQualityTable) do
		if v.PaintingId == self.cfgSoulPaintingData.Id and v.QualityLevel == self.itemData.equipData.star then
			self.cfgSoulPaintingQualityData = v

			break
		end
	end

	if self.itemDataCompare ~= nil then
		local cfgSoulPaintingDataCompare = self.itemDataCompare:GetCfg()

		for i, v in pairsCfg(CfgSoulPaintingQualityTable) do
			if v.PaintingId == cfgSoulPaintingDataCompare.Id and v.QualityLevel == self.itemDataCompare.equipData.star then
				self.cfgSoulPaintingQualityDataCompare = v

				break
			end
		end
	end

	self:RefreshMisc()
	self:RefreshMainAtt()
	self:RefreshEffectDesc1()
	self:RefreshEffectDesc2()
	self:RefreshSuit()
end

function EquipDetailView:OnHide()
	return
end

function EquipDetailView:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.itemCell:Dispose()
	self:ClearSuitItems(true)
	self.SuitItemPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function EquipDetailView:RefreshMisc()
	local equipShowInfo = EquipModule.GetEquipShowInfo(self.cfgSoulPaintingData.Id)

	self.tfEquipName.text = EquipUIApi:GetString("goEquipName", equipShowInfo.Name)

	self.itemCell:SetItemByCID(self.itemData.cid, 1)

	local soulName = ""

	if self.SoulCid ~= 0 then
		local cfgSoulData = CfgSoulTable[self.SoulCid]

		soulName = cfgSoulData.Name
	end

	self.tfSoulName.text = EquipUIApi:GetString("goSoulName", soulName)

	AssetUtil.LoadImage(self, EquipUIApi:GetString("goBgQualityPath", self.cfgSoulPaintingData.Quality), self.imgBgQuality)
end

function EquipDetailView:RefreshMainAtt()
	self.layIndex = 1

	local mainShowList = self:GetMainAttShowList(self.cfgSoulPaintingQualityData, self.itemData)
	local mainAttId2ValueDicCompare = self:GetMainAttId2ValueDic(self.cfgSoulPaintingQualityDataCompare, self.itemDataCompare)

	for i, v in ipairs(self.goMainAttCells) do
		v:SetActive(i <= #mainShowList)
	end

	for i, v in ipairs(mainShowList) do
		local trans = self:GetGoMainAttCell(i).transform

		AssetUtil.LoadImage(self, SoulUIApi:GetString("soulAttIconPath", v[1]), trans:Find("Icon"):GetComponent("Image"))

		trans:Find("Text_01"):GetComponent("Text").text = v[3]
		trans:Find("Text_02"):GetComponent("Text").text = v[2]

		if mainAttId2ValueDicCompare[v[1]] ~= nil then
			trans:Find("Image_Up").gameObject:SetActive(v[4] > mainAttId2ValueDicCompare[v[1]])
			trans:Find("Image_Down").gameObject:SetActive(v[4] < mainAttId2ValueDicCompare[v[1]])
		else
			trans:Find("Image_Up").gameObject:SetActive(false)
			trans:Find("Image_Down").gameObject:SetActive(false)
		end

		self.layIndex = self.layIndex + 1

		trans:SetSiblingIndex(self.layIndex)
	end
end

function EquipDetailView:RefreshEffectDesc1()
	self.layIndex = 50

	self.goTitle2.transform.parent:SetSiblingIndex(self.layIndex)

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
		self.goTitle2.transform.parent.gameObject:SetActive(false)
	else
		self.goTitle2.transform.parent.gameObject:SetActive(true)

		for i, v in ipairs(ids) do
			local trans = self:GetGoEffectDesc1Cell(i).transform

			trans:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goEffectDesc1", CfgPabilityTable[v].Describe)
			self.layIndex = self.layIndex + 1

			trans:SetSiblingIndex(self.layIndex)
		end
	end
end

function EquipDetailView:RefreshEffectDesc2()
	self.layIndex = 100

	self.goTitle3.transform.parent:SetSiblingIndex(self.layIndex)

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

function EquipDetailView:RefreshSuit()
	self:ClearSuitItems()

	local cfgItemData = self.itemData:GetCfg()

	self.goSuitView:SetActive(cfgItemData.SoulPaintingSuitId ~= 0)

	if cfgItemData.SoulPaintingSuitId == 0 then
		return
	end

	self.layIndex = self.layIndex + 1

	self.goSuitView.transform:SetSiblingIndex(self.layIndex)

	local cfgSoulPaintingSuitData = CfgSoulPaintingSuitTable[cfgItemData.SoulPaintingSuitId]
	local hasNum = 0

	if self.wearingEquipCids ~= nil then
		for i = 1, #self.wearingEquipCids do
			local wearingEquipCid = self.wearingEquipCids[i]

			if table.indexOf(cfgSoulPaintingSuitData.NeedSoulPainting, wearingEquipCid) ~= -1 then
				hasNum = hasNum + 1
			end
		end
	end

	for i = 1, #cfgSoulPaintingSuitData.Num do
		local needNum = cfgSoulPaintingSuitData.Num[i]

		if needNum > 0 then
			local suitItem = self.SuitItemPool:Obtain()

			suitItem.View:SetActive(true)
			suitItem.View.transform:SetParent(self.goSuitEffectGrid.transform, false)
			suitItem:SetData(cfgSoulPaintingSuitData.PabilityID[i], hasNum, needNum)
			table.insert(self.SuitItems, suitItem)
		end
	end
end

function EquipDetailView:ClearSuitItems(isDestroy)
	for i = 1, #self.SuitItems do
		local suitItem = self.SuitItems[i]

		suitItem.View:SetActive(false)

		if not isDestroy then
			suitItem.View.transform:SetParent(self.View.transform, false)
		end

		self.SuitItemPool:Release(suitItem)
	end

	self.SuitItems = {}
end

function EquipDetailView:GetMainAttShowList(cfgSoulPaintingQualityData, itemData)
	local mainShowList = {}

	if itemData == nil then
		return mainShowList
	end

	local mainId2ValueDic = EquipModule.GetMainAbilityValue(cfgSoulPaintingQualityData, itemData.equipData.lv)

	for i, v in pairs(mainId2ValueDic) do
		local realValue = AttributeModule.GetAttShowValue(i, v)
		local showValue = EquipUIApi:GetString("curMainAttValue", realValue)
		local name = EquipUIApi:GetString("goAttName", i, true)

		mainShowList[#mainShowList + 1] = {
			i,
			showValue,
			name,
			realValue
		}
	end

	table.sort(mainShowList, function(a, b)
		return a[1] < b[1]
	end)

	return mainShowList
end

function EquipDetailView:GetMainAttId2ValueDic(cfgSoulPaintingQualityData, itemData)
	local id2ValueDic = {}

	if itemData == nil then
		return id2ValueDic
	end

	local mainId2ValueDic = EquipModule.GetMainAbilityValue(cfgSoulPaintingQualityData, itemData.equipData.lv)

	for i, v in pairs(mainId2ValueDic) do
		local realValue = AttributeModule.GetAttShowValue(i, v)

		id2ValueDic[i] = realValue
	end

	return id2ValueDic
end

function EquipDetailView:GetGoMainAttCell(index)
	local ret = self.goMainAttCells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goMainAttCell)
		self.goMainAttCells[index] = ret

		ret.transform:SetParent(self.goMainAttCell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function EquipDetailView:GetGoEffectDesc1Cell(index)
	local ret = self.goEffectDesc1Cells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectDesc1Cell)
		self.goEffectDesc1Cells[index] = ret

		ret.transform:SetParent(self.goEffectDesc1Cell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function EquipDetailView:GetGoEffectDesc2Cell(index)
	local ret = self.goEffectDesc2Cells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectDesc2Cell)
		self.goEffectDesc2Cells[index] = ret

		ret.transform:SetParent(self.goEffectDesc2Cell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function EquipDetailView:GetGoEffectDesc2CellTitle(index)
	local ret = self.goEffectDesc2CellTitles[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectDesc2CellTitle)
		self.goEffectDesc2CellTitles[index] = ret

		ret.transform:SetParent(self.goEffectDesc2CellTitle.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

return EquipDetailView
