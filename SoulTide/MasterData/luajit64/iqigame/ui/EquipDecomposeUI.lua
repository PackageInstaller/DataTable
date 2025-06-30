-- chunkname: @IQIGame\\UI\\EquipDecomposeUI.lua

local EquipDecomposeUI = Base:Extend("EquipDecomposeUI", "IQIGame.Onigao.UI.EquipDecomposeUI", {
	cells = {}
})

function EquipDecomposeUI:OnInit()
	self:Initialize()
end

function EquipDecomposeUI:GetPreloadAssetPaths()
	return nil
end

function EquipDecomposeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EquipDecomposeUI:OnOpen(userData)
	self:Refresh(userData)
end

function EquipDecomposeUI:OnClose(userData)
	self:OnHide()
end

function EquipDecomposeUI:OnPause()
	return
end

function EquipDecomposeUI:OnResume()
	return
end

function EquipDecomposeUI:OnCover()
	return
end

function EquipDecomposeUI:OnReveal()
	return
end

function EquipDecomposeUI:OnRefocus(userData)
	return
end

function EquipDecomposeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EquipDecomposeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipDecomposeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipDecomposeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipDecomposeUI:Initialize()
	self.btnCancel = self.goBtnCancel:GetComponent("Button")
	self.btnSure = self.goBtnSure:GetComponent("Button")

	function self.onClickBtnCancelDelegate()
		self:OnClickBtnCancel()
	end

	function self.onClickBtnSureDelegate()
		self:OnClickBtnSure()
	end

	self.cells[1] = ItemCell.PackageOrReuseView(self, self.goGridParent.transform:GetChild(0).gameObject)

	function self.onDecomposeSuccessDelegate()
		self:OnDecomposeSuccess()
	end

	self.goBtnSure.transform:Find("Text"):GetComponent("Text").text = EquipDecomposeUIApi:GetString("goBtnSure")
	self.goBtnCancel.transform:Find("Text"):GetComponent("Text").text = EquipDecomposeUIApi:GetString("goBtnCancel")
	self.goTitle:GetComponent("Text").text = EquipDecomposeUIApi:GetString("goTitle")

	UGUIUtil.SetText(self.goDesc1, EquipDecomposeUIApi:GetString("goDesc1"))
	UGUIUtil.SetText(self.goDesc3, EquipDecomposeUIApi:GetString("goDesc3"))
end

function EquipDecomposeUI:Refresh(userData)
	self.itemDataList = userData

	self:RefreshPreview()
end

function EquipDecomposeUI:OnHide()
	return
end

function EquipDecomposeUI:OnDestroy()
	for i, v in pairs(self.cells) do
		v:Dispose()
	end
end

function EquipDecomposeUI:RefreshPreview()
	local recyclingId2CountDic = {}
	local totalExp = 0
	local totalCoin = 0
	local existBest = false

	for i, v in pairs(self.itemDataList) do
		local cfgData = v:GetCfg()

		if cfgData.Star > 3 then
			existBest = true
		end

		local costCardCount = 0

		for j, k in pairsCfg(CfgSoulPaintingQualityTable) do
			if k.PaintingId == v.cid then
				for m = 1, v.equipData.star - 1 do
					if m == k.QualityLevel then
						costCardCount = costCardCount + k.CostPainting
					end
				end
			end
		end

		for j, k in ipairs(cfgData.Recycling) do
			if j % 2 ~= 0 then
				if recyclingId2CountDic[k] == nil then
					recyclingId2CountDic[k] = cfgData.Recycling[j + 1] * (1 + costCardCount)
				else
					recyclingId2CountDic[k] = recyclingId2CountDic[k] + cfgData.Recycling[j + 1] * (1 + costCardCount)
				end
			end
		end

		local singleExp = 0

		singleExp = singleExp + v.equipData.exp

		for m = 1, v.equipData.lv - 1 do
			singleExp = singleExp + CfgSoulPaintingLvTable[m].BaseNeedExp * cfgData.ExpGrowthRate
		end

		singleExp = singleExp * cfgData.RecyclingExpRate[1]
		totalExp = totalExp + singleExp

		for s = 1, v.equipData.star - 1 do
			for m, n in pairsCfg(CfgSoulPaintingQualityTable) do
				if n.PaintingId == cfgData.Id and n.QualityLevel == s and #n.Cost > 1 then
					totalCoin = totalCoin + n.Cost[2] * cfgData.RecyclingExpRate[1]
				end
			end
		end

		totalCoin = totalCoin + v.equipData.upCostGold * cfgData.RecyclingExpRate[1]
	end

	self.goDesc3.transform.parent.gameObject:SetActive(existBest)

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

	for i, v in pairs(recyclingId2CountDic) do
		if id2CountDic[i] ~= nil then
			id2CountDic[i] = id2CountDic[i] + v
		else
			id2CountDic[i] = v
		end
	end

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
	self:RefreshCells(sortTable)
end

function EquipDecomposeUI:RefreshCells(idCountTable)
	for i, v in pairs(self.cells) do
		v.ViewGo:SetActive(false)
	end

	for i, v in ipairs(idCountTable) do
		local cell = self:GetCell(i)

		cell:SetItemByCID(v[1], v[2])
	end
end

function EquipDecomposeUI:GetCell(index)
	local ret = self.cells[index]

	if ret == nil then
		local go = UnityEngine.Object.Instantiate(self.cells[1].ViewGo)

		go.transform:SetParent(self.goGridParent.transform, false)

		ret = ItemCell.PackageOrReuseView(self, go)
		self.cells[index] = ret
	end

	return ret
end

function EquipDecomposeUI:OnAddListeners()
	self.btnCancel.onClick:AddListener(self.onClickBtnCancelDelegate)
	self.btnSure.onClick:AddListener(self.onClickBtnSureDelegate)
	EventDispatcher.AddEventListener(EventID.EquipDecomposeSuccess, self.onDecomposeSuccessDelegate)
end

function EquipDecomposeUI:OnRemoveListeners()
	self.btnCancel.onClick:RemoveListener(self.onClickBtnCancelDelegate)
	self.btnSure.onClick:RemoveListener(self.onClickBtnSureDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipDecomposeSuccess, self.onDecomposeSuccessDelegate)
end

function EquipDecomposeUI:OnClickBtnCancel()
	UIModule.Close(Constant.UIControllerName.EquipDecomposeUI)
end

function EquipDecomposeUI:OnClickBtnSure()
	local ids = {}

	for i, v in pairs(self.itemDataList) do
		ids[#ids + 1] = v.id
	end

	SoulPrefabModule.ReqDecompose(ids, false)
end

function EquipDecomposeUI:OnDecomposeSuccess()
	self:OnClickBtnCancel()
end

return EquipDecomposeUI
