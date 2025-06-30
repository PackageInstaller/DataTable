-- chunkname: @IQIGame\\UI\\Equip\\BreakView\\BreakView.lua

local BreakView = {
	cells = {},
	selectedItemDataDic = {},
	goMainAttCells = {},
	goEffectDesc1Cells = {}
}
local BreakItemCell = require("IQIGame.UI.Equip.BreakView.BreakItemCell")

function BreakView.New(go)
	local o = Clone(BreakView)

	o:Initialize(go)

	return o
end

function BreakView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go
	self.tfCoinNum = self.goCostBlock.transform:Find("Text"):GetComponent("Text")
	self.tfCostNum = self.goCostNumDesc:GetComponent("Text")
	self.tfStarTitle = self.goStarTitle:GetComponent("Text")
	self.starComp = self.goStar:GetComponent("SimpleStarComponent")
	self.goMainAttCells[1] = self.goMainAttCell
	self.goEffectDesc1Cells[1] = self.goEffectDesc1Cell
	self.scrollList = self.goScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	self.btnUp = self.goBtnUp:GetComponent("Button")
	self.togTab = self.goToggle:GetComponent("Toggle")
	self.togFilter = self.goToggleFilter:GetComponent("Toggle")

	function self.onClickToggleFilterDelegate(isOn)
		self:OnClickToggleFilter(isOn)
	end

	function self.onClickToggleTabDelegate(isOn)
		self:OnClickToggleTab(isOn)
	end

	function self.onClickBtnUpDelegate()
		self:OnClickBtnUp()
	end

	self.goCostBlock.transform:Find("Text"):GetComponent("Text").text = EquipUIApi:GetString("goCoinDesc", 2)
	self.goBtnUp.transform:Find("Text"):GetComponent("Text").text = EquipUIApi:GetString("goBtnUpStar")
	self.goTitle1:GetComponent("Text").text = EquipUIApi:GetString("goTitle1")
	self.goTitle2:GetComponent("Text").text = EquipUIApi:GetString("goTitle3")
	self.goToggle.transform:Find("goDown/Text_Name_02"):GetComponent("Text").text = EquipUIApi:GetString("goTittleItemTab")
	self.goToggle.transform:Find("goDown/Text_Name_01"):GetComponent("Text").text = EquipUIApi:GetString("goTittleAttTab")
	self.goToggle.transform:Find("goUp/Text_Name_02"):GetComponent("Text").text = EquipUIApi:GetString("goTittleAttTab")
	self.goToggle.transform:Find("goUp/Text_Name_01"):GetComponent("Text").text = EquipUIApi:GetString("goTittleItemTab")
	self.goToggleFilter.transform:Find("CheckToggle/Bg/Panel_Left/Text_1"):GetComponent("Text").text = EquipUIApi:GetString("goBtnFilterTitle2")
	self.spEquipId = CfgDiscreteDataTable[6520026].Data[1]
	self.spQuality = CfgDiscreteDataTable[6520026].Data[2]
end

function BreakView:Refresh(itemData)
	self.itemData = itemData
	self.cfgSoulPaintingData = self.itemData:GetCfg()
	self.selectedItemDataDic = {}

	for i, v in pairsCfg(CfgSoulPaintingQualityTable) do
		if v.PaintingId == self.cfgSoulPaintingData.Id and v.QualityLevel == self.itemData.equipData.star then
			self.cfgSoulPaintingQualityData = v

			break
		end
	end

	self:AddListeners()

	self.togTab.isOn = false
	self.togFilter.isOn = false
	self.togTab.isOn = true
	self.togFilter.isOn = true

	self:RefreshMisc()
end

function BreakView:OnHide()
	self:RemoveListeners()
end

function BreakView:OnDestroy()
	for i, v in pairs(self.cells) do
		v:OnDestroy()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function BreakView:AddListeners()
	self:RemoveListeners()
	self.btnUp.onClick:AddListener(self.onClickBtnUpDelegate)
	self.togTab.onValueChanged:AddListener(self.onClickToggleTabDelegate)
	self.togFilter.onValueChanged:AddListener(self.onClickToggleFilterDelegate)
end

function BreakView:RemoveListeners()
	self.btnUp.onClick:RemoveListener(self.onClickBtnUpDelegate)
	self.togTab.onValueChanged:RemoveListener(self.onClickToggleTabDelegate)
	self.togFilter.onValueChanged:RemoveListener(self.onClickToggleFilterDelegate)
end

function BreakView:OnClickBtnUp()
	local selectedCount = 0

	for i, v in pairs(self.selectedItemDataDic) do
		selectedCount = selectedCount + 1
	end

	if selectedCount < self.cfgSoulPaintingQualityData.CostPainting then
		NoticeModule.ShowNoticeNoCallback(21041025)

		return
	end

	if #self.cfgSoulPaintingQualityData.Cost >= 2 and WarehouseModule.GetItemNumByCfgID(1) < self.cfgSoulPaintingQualityData.Cost[2] then
		NoticeModule.ShowNoticeNoCallback(21041026)

		return
	end

	local ids = {}

	for i, v in pairs(self.selectedItemDataDic) do
		ids[#ids + 1] = v.id
	end

	if #ids > 0 then
		EquipModule.ReqBreakEquip(self.itemData.id, ids, self.itemData.equipData.lv)
	end
end

function BreakView:OnClickToggleTab(isOn)
	self.goAttTab:SetActive(isOn)
	self.goItemTab:SetActive(not isOn)
	self:RefreshToggleFilterVisible()
end

function BreakView:OnClickToggleFilter(isOn)
	self:RefreshCells(isOn)
end

function BreakView:OnRenderGridCell(grid)
	local luaIndex = grid.index + 1
	local itemData = self.itemDatum[luaIndex]
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.cells[insID]

	if cell == nil then
		cell = BreakItemCell.New(grid.gameObject)
		self.cells[insID] = cell
	end

	cell:Refresh(itemData)
	cell:SetCheckVisible(self.selectedItemDataDic[itemData.id] ~= nil)
end

function BreakView:OnSelectedGridCell(grid)
	local luaIndex = grid.index + 1
	local itemData = self.itemDatum[luaIndex]
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.cells[insID]
	local selectedCount = 0

	for i, v in pairs(self.selectedItemDataDic) do
		selectedCount = selectedCount + 1
	end

	if self.selectedItemDataDic[itemData.id] == nil then
		if selectedCount < self.cfgSoulPaintingQualityData.CostPainting then
			if itemData.equipData.lock then
				NoticeModule.ShowNoticeNoCallback(21053003)

				return
			end

			if itemData.equipData.isWore then
				NoticeModule.ShowNoticeNoCallback(21053002)

				return
			end

			if itemData.equipData.star ~= 1 then
				NoticeModule.ShowNoticeNoCallback(21053005)

				return
			end

			selectedCount = selectedCount + 1
			self.selectedItemDataDic[itemData.id] = itemData

			cell:SetCheckVisible(true)

			if itemData.equipData.lv > 1 then
				NoticeModule.ShowNoticeNoCallback(21053001)
			end
		end
	else
		self.selectedItemDataDic[itemData.id] = nil

		cell:SetCheckVisible(false)

		selectedCount = selectedCount - 1
	end

	self:RefreshOnStar(selectedCount)
end

function BreakView:RefreshMisc()
	self.goCard.transform:SetParent(self.goCardPoint.transform, false)
	self:RefreshToggleFilterVisible()
end

function BreakView:RefreshCells(needFilter)
	self.itemDatum = {}

	local spItemDatas = {}
	local allItems = WarehouseModule.GetItemsByType(Constant.ItemType.Equip)

	for i, v in pairs(allItems) do
		if (v.cid == self.itemData.cid or v.cid == self.spEquipId) and v.id ~= self.itemData.id then
			if needFilter then
				if v.equipData.lock == false and v.equipData.isWore == false and v.equipData.star == 1 then
					if v.cid ~= self.spEquipId then
						self.itemDatum[#self.itemDatum + 1] = v
					elseif self.itemData:GetCfg().Quality >= self.spQuality then
						spItemDatas[#spItemDatas + 1] = v
					end
				end
			elseif v.cid ~= self.spEquipId then
				self.itemDatum[#self.itemDatum + 1] = v
			elseif self.itemData:GetCfg().Quality >= self.spQuality then
				spItemDatas[#spItemDatas + 1] = v
			end
		end
	end

	table.sort(self.itemDatum, function(a, b)
		return a.equipData.lv > b.equipData.lv
	end)

	for i, v in ipairs(spItemDatas) do
		self.itemDatum[#self.itemDatum + 1] = v
	end

	self:SelectDefaultCost()
end

function BreakView:SelectDefaultCost()
	local selectedCount = 0

	self.selectedItemDataDic = {}

	for i, v in ipairs(self.itemDatum) do
		if v.equipData.lock == false and v.equipData.isWore == false and v.equipData.star == 1 and v.equipData.lv == 1 and selectedCount < self.cfgSoulPaintingQualityData.CostPainting then
			selectedCount = selectedCount + 1
			self.selectedItemDataDic[v.id] = v
		end
	end

	self.scrollList:Refresh(#self.itemDatum)
	self:RefreshOnStar(selectedCount)
end

function BreakView:RefreshOnStar(costCount)
	self.goCostBlock:SetActive(true)

	local curStar = self.itemData.equipData.star
	local maxStart = self.cfgSoulPaintingData.StarLimit
	local canUpStar = self.itemData.equipData.star

	if curStar ~= maxStart then
		local needCount = self.cfgSoulPaintingQualityData.CostPainting

		self.tfCostNum.text = EquipUIApi:GetString("goCostNum", costCount, needCount)

		if #self.cfgSoulPaintingQualityData.Cost >= 2 then
			self.tfCoinNum.text = EquipUIApi:GetString("goCoinNum", self.cfgSoulPaintingQualityData.Cost[2], WarehouseModule.GetItemNumByCfgID(self.cfgSoulPaintingQualityData.Cost[1]))
		end

		if needCount <= costCount then
			canUpStar = canUpStar + 1
		end

		if maxStart < canUpStar then
			canUpStar = maxStart
		end

		self.starComp:UpdateView(maxStart, canUpStar)
		self:RefreshAtt(canUpStar)
		self.goCostBlock:SetActive(#self.cfgSoulPaintingQualityData.Cost >= 2)
	else
		self.starComp:UpdateView(maxStart, maxStart)
		self:RefreshAtt(maxStart)
	end

	self.goStarBlue:SetActive(canUpStar > self.itemData.equipData.star)

	if canUpStar > self.itemData.equipData.star then
		for i = 1, 5 do
			local goStar = self.goStarBlue.transform:Find("Star_0" .. i).gameObject
			local show = i > self.itemData.equipData.star and i <= canUpStar

			goStar:SetActive(show)
		end
	end

	local vs = curStar ~= maxStart

	self.goBtnUp:SetActive(vs)
	self.goCostNumDesc:SetActive(vs)

	self.tfStarTitle.text = EquipUIApi:GetString("goStarTitle", not vs)

	self:RefreshToggleFilterVisible()
end

function BreakView:RefreshAtt(canUpStar)
	local cfgData, cfgDataNow

	for i, v in pairsCfg(CfgSoulPaintingQualityTable) do
		if v.PaintingId == self.cfgSoulPaintingData.Id then
			if v.QualityLevel == canUpStar then
				cfgData = v
			end

			if v.QualityLevel == self.itemData.equipData.star then
				cfgDataNow = v
			end

			if cfgData ~= nil and cfgDataNow ~= nil then
				break
			end
		end
	end

	local isPreview = true
	local selectedCount = 0

	for i, v in pairs(self.selectedItemDataDic) do
		selectedCount = selectedCount + 1
	end

	if selectedCount == 0 or selectedCount < self.cfgSoulPaintingQualityData.CostPainting then
		isPreview = false
	end

	self:RefreshMainAtt(canUpStar, cfgData, cfgDataNow, isPreview)
	self:RefreshEffectDesc1(canUpStar, isPreview)
end

function BreakView:RefreshMainAtt(canUpStar, cfgData, cfgDataNow, isPreview)
	self.layIndex = 1

	self.goTitle1.transform.parent.parent:SetSiblingIndex(self.layIndex)

	local mainId2ValueDic = EquipModule.GetMainAbilityValue(cfgData, self.itemData.equipData.lv)
	local mainId2ValueDicNow = EquipModule.GetMainAbilityValue(cfgDataNow, self.itemData.equipData.lv)
	local mainShowList = {}
	local sortTable = {}

	for i, v in ipairs(cfgData.MainBility) do
		sortTable[i] = v
	end

	table.sort(sortTable, function(a, b)
		return a < b
	end)

	for i, v in ipairs(sortTable) do
		local showValueNow = EquipUIApi:GetString("curMainAttValue", AttributeModule.GetAttShowValue(v, mainId2ValueDicNow[v]), false)
		local valueDelta = AttributeModule.GetAttShowValue(v, mainId2ValueDic[v] - mainId2ValueDicNow[v])
		local showDeltaValue = EquipUIApi:GetString("curMainAttValue", valueDelta, true)
		local name = EquipUIApi:GetString("goAttName", v, true)

		mainShowList[#mainShowList + 1] = {
			v,
			showValueNow,
			name,
			showDeltaValue
		}
	end

	for i, v in ipairs(self.goMainAttCells) do
		v:SetActive(i <= #mainShowList)
	end

	for i, v in ipairs(mainShowList) do
		local trans = self:GetGoMainAttCell(i).transform

		trans:Find("Sort_02").gameObject:SetActive(isPreview)

		trans:Find("Sort_01/Text_01"):GetComponent("Text").text = v[3]
		trans:Find("Sort_01/Text_02"):GetComponent("Text").text = v[2]
		trans:Find("Sort_02/Text_02"):GetComponent("Text").text = v[4]

		local path = SoulUIApi:GetString("soulAttIconPath", v[1])

		AssetUtil.LoadImage(self, path, trans:Find("Sort_01/Icon_01"):GetComponent("Image"))

		self.layIndex = self.layIndex + 1

		trans:SetSiblingIndex(self.layIndex)
	end
end

function BreakView:RefreshEffectDesc1(canUpStar, isPreview)
	self.layIndex = 50

	self.goTitle2.transform.parent.parent.parent:SetSiblingIndex(self.layIndex)

	local idsTarget = {}
	local ids = {}

	if #self.cfgSoulPaintingData.PabilityID[3] > 0 then
		ids[#ids + 1] = self.cfgSoulPaintingData.PabilityID[3][self.itemData.equipData.star]
		idsTarget[#idsTarget + 1] = self.cfgSoulPaintingData.PabilityID[3][canUpStar]
	end

	if #self.cfgSoulPaintingData.PabilityID[4] > 0 then
		ids[#ids + 1] = self.cfgSoulPaintingData.PabilityID[4][self.itemData.equipData.star]
		idsTarget[#idsTarget + 1] = self.cfgSoulPaintingData.PabilityID[4][canUpStar]
	end

	local secShowList = {}
	local tempIds

	if isPreview then
		tempIds = idsTarget
	else
		tempIds = ids
	end

	for i, v in ipairs(tempIds) do
		local desc = EquipUIApi:GetString("goEffectDesc1", CfgPabilityTable[v].Describe, isPreview)
		local name = EquipUIApi:GetString("pabilityName", CfgPabilityTable[v].Name, isPreview)

		secShowList[#secShowList + 1] = {
			i,
			desc,
			name
		}
	end

	table.sort(secShowList, function(a, b)
		return a[1] < b[1]
	end)

	for i, v in ipairs(self.goEffectDesc1Cells) do
		v:SetActive(i <= #secShowList)
	end

	self.goTitle2.transform.parent.parent.parent.gameObject:SetActive(#secShowList ~= 0)

	for i, v in ipairs(secShowList) do
		local trans = self:GetGoEffectDesc1Cell(i).transform

		trans:Find("Mould_Title_03/Text_01"):GetComponent("Text").text = v[3]
		trans:Find("Mould_03/Text_02"):GetComponent("Text").text = UIGlobalApi.GetTextWithoutKeywordTag(v[2])

		trans:Find("Mould_Title_03/Image_01").gameObject:SetActive(isPreview)

		self.layIndex = self.layIndex + 1

		trans:SetSiblingIndex(self.layIndex)
	end
end

function BreakView:RefreshToggleFilterVisible()
	local curStar = self.itemData.equipData.star
	local maxStart = self.cfgSoulPaintingData.StarLimit

	self.goToggleFilter:SetActive(curStar ~= maxStart and self.goItemTab.activeSelf)
end

function BreakView:GetGoMainAttCell(index)
	local ret = self.goMainAttCells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goMainAttCell)
		self.goMainAttCells[index] = ret

		ret.transform:SetParent(self.goMainAttCell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function BreakView:GetGoEffectDesc1Cell(index)
	local ret = self.goEffectDesc1Cells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectDesc1Cell)
		self.goEffectDesc1Cells[index] = ret

		ret.transform:SetParent(self.goEffectDesc1Cell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function BreakView:SetActive(vs)
	if vs == false then
		self:OnHide()
	end

	self.goView:SetActive(vs)
end

return BreakView
