-- chunkname: @IQIGame\\UI\\Equip\\Recast\\RecastView.lua

local RecastView = {
	recastEquipCellPool = {},
	itemCellPool = {}
}

function RecastView.New(view)
	local obj = Clone(RecastView)

	obj:Init(view)

	return obj
end

function RecastView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.goRecastEquip:SetActive(false)
	self.goItemCell:SetActive(false)

	self.tfCount = self.goCount:GetComponent("Text")
	self.tfMoneyCost = self.goMoneyCost:GetComponent("Text")
	self.imgMoney = self.goMoneyIcon:GetComponent("Image")
	self.btnReset = self.goBtnReset:GetComponent("Button")

	function self.onClickBtnResetDelegate()
		self:OnClickBtnReset()
	end

	function self.onDecomposeSuccessDelegate(isRecast)
		self:OnDecomposeSuccess(isRecast)
	end

	self.goTitle1:GetComponent("Text").text = EquipUIApi:GetString("recastViewTitle1")
	self.goTitle2:GetComponent("Text").text = EquipUIApi:GetString("recastViewTitle2")
	self.goTitle3:GetComponent("Text").text = EquipUIApi:GetString("recastViewTitle3")
	self.goBtnReset.transform:Find("Text"):GetComponent("Text").text = EquipUIApi:GetString("recastViewBtnResetTxt")
end

function RecastView:Refresh(itemData)
	self.itemData = itemData

	self:RefreshMisc()
	self:RefreshRecastEquipBlock()
	self:RefreshRecastItemBlock()
	self:RefreshCostBlock()
	self:OnAddListeners()
end

function RecastView:OnHide()
	self:OnRemoveListeners()
end

function RecastView:OnDestroy()
	for i, v in pairs(self.recastEquipCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function RecastView:OnAddListeners()
	self:OnRemoveListeners()
	self.btnReset.onClick:AddListener(self.onClickBtnResetDelegate)
	EventDispatcher.AddEventListener(EventID.EquipDecomposeSuccess, self.onDecomposeSuccessDelegate)
end

function RecastView:OnRemoveListeners()
	self.btnReset.onClick:RemoveListener(self.onClickBtnResetDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipDecomposeSuccess, self.onDecomposeSuccessDelegate)
end

function RecastView:OnClickBtnReset()
	if self.itemData.equipData.lv == 1 and self.itemData.equipData.star == 1 then
		NoticeModule.ShowNotice(21041032)

		return
	end

	if self.itemData.equipData.isWore then
		NoticeModule.ShowNotice(21041031)

		return
	end

	if self.itemData.equipData.lock then
		NoticeModule.ShowNotice(21041030)

		return
	end

	local cfgData = self.itemData:GetCfg()
	local moneyId = cfgData.RecyclingCost[1]
	local cost = cfgData.RecyclingCost[2]

	if cost > WarehouseModule.GetItemNumByCfgID(moneyId) then
		if moneyId == Constant.ItemID.TREASURE then
			NoticeModule.MoneyDeficitTip(1, cost - WarehouseModule.GetItemNumByCfgID(moneyId))
		else
			NoticeModule.ShowNotice(21053012)
		end

		return
	end

	SoulPrefabModule.ReqDecompose({
		self.itemData.id
	}, true)
end

function RecastView:OnDecomposeSuccess(isRecast)
	UIModule.Close(Constant.UIControllerName.EquipUI)
end

function RecastView:RefreshMisc()
	self.goCard.transform:SetParent(self.goCardPoint.transform, false)
end

function RecastView:RefreshRecastEquipBlock()
	for i, v in pairs(self.recastEquipCellPool) do
		v.goView.transform.parent.gameObject:SetActive(false)
	end

	local cardCount = 1

	for i, v in pairsCfg(CfgSoulPaintingQualityTable) do
		if v.PaintingId == self.itemData.cid then
			for k = 1, self.itemData.equipData.star - 1 do
				if k == v.QualityLevel then
					cardCount = cardCount + v.CostPainting
				end
			end
		end
	end

	for i = 1, cardCount do
		local cell = self:GetRecastEquipCell(i)
		local itemData = ItemData.CreateByCIDAndNumber(self.itemData.cid, 1)

		cell:Refresh(itemData)
	end

	self.tfCount.text = EquipUIApi:GetString("recastViewRecastEquipCount", cardCount)
end

function RecastView:RefreshRecastItemBlock()
	local totalExp = 0
	local totalCoin = 0
	local itemDataList = {
		self.itemData
	}

	for i, v in pairs(itemDataList) do
		local cfgData = v:GetCfg()
		local singleExp = 0

		singleExp = singleExp + v.equipData.exp

		for m = 1, v.equipData.lv - 1 do
			singleExp = singleExp + CfgSoulPaintingLvTable[m].BaseNeedExp * cfgData.ExpGrowthRate
		end

		singleExp = singleExp * cfgData.RecyclingExpRate[2]
		totalExp = totalExp + singleExp

		for s = 1, v.equipData.star - 1 do
			for m, n in pairsCfg(CfgSoulPaintingQualityTable) do
				if n.PaintingId == cfgData.Id and n.QualityLevel == s and #n.Cost > 1 then
					totalCoin = totalCoin + n.Cost[2] * cfgData.RecyclingExpRate[2]
				end
			end
		end

		totalCoin = totalCoin + v.equipData.upCostGold * cfgData.RecyclingExpRate[2]
	end

	local expId = CfgDiscreteDataTable[6507091].Data[1]
	local expId2 = CfgDiscreteDataTable[6507091].Data[2]
	local expId3 = CfgDiscreteDataTable[6507091].Data[3]
	local expId4 = CfgDiscreteDataTable[6507091].Data[4]
	local id2CountDic = {
		[expId] = 0,
		[expId2] = 0,
		[expId3] = 0,
		[expId4] = 0,
		totalCoin
	}
	local dataList = CfgDiscreteDataTable[6507086].Data
	local id2ExpDic = {}

	for i, v in ipairs(dataList) do
		if i % 3 == 1 then
			id2ExpDic[v] = dataList[i + 1]
		end
	end

	if totalExp >= id2ExpDic[expId] then
		id2CountDic[expId] = math.floor(totalExp / id2ExpDic[expId])
	end

	totalExp = totalExp - id2CountDic[expId] * id2ExpDic[expId]

	if totalExp >= id2ExpDic[expId2] then
		id2CountDic[expId2] = math.floor(totalExp / id2ExpDic[expId2])
	end

	totalExp = totalExp - id2CountDic[expId2] * id2ExpDic[expId2]

	if totalExp >= id2ExpDic[expId3] then
		id2CountDic[expId3] = math.floor(totalExp / id2ExpDic[expId3])
	end

	totalExp = totalExp - id2CountDic[expId3] * id2ExpDic[expId3]
	id2CountDic[expId4] = math.ceil(totalExp / id2ExpDic[expId4])

	local sortTable = {}

	for i, v in pairs(id2CountDic) do
		if v > 0 then
			sortTable[#sortTable + 1] = {
				i,
				v
			}
		end
	end

	table.sort(sortTable, function(a, b)
		return a[1] < b[1]
	end)
	self:RefreshItemCells(sortTable)
end

function RecastView:RefreshCostBlock()
	local cfgData = self.itemData:GetCfg()
	local moneyId = cfgData.RecyclingCost[1]
	local cost = cfgData.RecyclingCost[2]

	self.tfMoneyCost.text = EquipUIApi:GetString("recastViewMoneyCost", cost, WarehouseModule.GetItemNumByCfgID(moneyId))

	local path = UIGlobalApi.IconPath .. CfgItemTable[cfgData.RecyclingCost[1]].Icon

	AssetUtil.LoadImage(self, path, self.imgMoney)
end

function RecastView:RefreshItemCells(idCountTable)
	for i, v in pairs(self.itemCellPool) do
		v.ViewGo:SetActive(false)
	end

	for i, v in ipairs(idCountTable) do
		local cell = self:GetRecastItemCell(i)

		cell:SetItemByCID(v[1], v[2])
	end
end

function RecastView:GetRecastItemCell(index)
	local ret = self.itemCellPool[index]

	if ret == nil then
		local go = UnityEngine.Object.Instantiate(self.goItemCell)

		go.transform:SetParent(self.goItemCell.transform.parent, false)

		ret = ItemCell.PackageOrReuseView(self, go)
		self.itemCellPool[index] = ret
	end

	ret.ViewGo:SetActive(true)

	return ret
end

function RecastView:GetRecastEquipCell(index)
	local ret = self.recastEquipCellPool[index]

	if ret == nil then
		local go = UnityEngine.Object.Instantiate(self.goRecastEquip)

		go.transform:SetParent(self.goRecastEquip.transform.parent, false)

		ret = EquipCell.New(go.transform:GetChild(0).gameObject, false)
		self.recastEquipCellPool[index] = ret
	end

	ret.goView.transform.parent.gameObject:SetActive(true)

	return ret
end

function RecastView:SetActive(vs)
	if vs == false then
		self:OnHide()
	end

	self.View:SetActive(vs)
end

return RecastView
