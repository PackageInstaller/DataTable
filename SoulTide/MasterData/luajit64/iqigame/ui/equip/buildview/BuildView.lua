-- chunkname: @IQIGame\\UI\\Equip\\BuildView\\BuildView.lua

local BuildView = {
	maxLv = 0,
	totalCoin = 0,
	curMaxLv = 0,
	cells = {},
	goAttCells = {}
}
local BuildItemCell = require("IQIGame.UI.Equip.BuildView.BuildItemCell")

function BuildView.New(go)
	local o = Clone(BuildView)

	o:Initialize(go)

	return o
end

function BuildView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go
	self.tfLvDesc = self.goLvDesc:GetComponent("Text")
	self.tfMoneyNum = self.goMoneyNum:GetComponent("Text")
	self.tfExpPre = self.goExpPre:GetComponent("Text")
	self.imgDeltaLv_100 = self.goDeltaLvBlock.transform:Find("Mould_Image_01"):GetComponent("Image")
	self.imgDeltaLv_10 = self.goDeltaLvBlock.transform:Find("Mould_Image_02"):GetComponent("Image")
	self.imgDeltaLv_1 = self.goDeltaLvBlock.transform:Find("Mould_Image_03"):GetComponent("Image")
	self.expBar = self.goExpProgress:GetComponent("Image")

	for i = 1, 4 do
		local go = self.goItemCellParent.transform:Find("Slot_mould_" .. i).gameObject

		self.cells[i] = BuildItemCell.New(go)
	end

	self.goAttCells[1] = self.goAttCell
	self.btnClear = self.goBtnClear:GetComponent("Button")
	self.btnUp = self.goBtnUp:GetComponent("Button")
	self.btnMax = self.goBtnMax:GetComponent("Button")

	function self.onClickBtnMaxDelegate()
		self:OnClickBtnMax()
	end

	function self.onClickBtnUpDelegate()
		self:OnClickBtnUp()
	end

	function self.onClickBtnClearDelegate()
		self:OnClickBtnClear()
	end

	self.goBtnUp.transform:Find("Text"):GetComponent("Text").text = EquipUIApi:GetString("goBtnUp")
	self.goBtnClear.transform:Find("Text"):GetComponent("Text").text = EquipUIApi:GetString("btnClearTxt")
	self.goBtnMax.transform:Find("Text"):GetComponent("Text").text = EquipUIApi:GetString("goBtnMaxTxt")
	self.progressSpeed = EquipUIApi:GetString("goExpProgressSpeed")
end

function BuildView:Refresh(itemData)
	self.goEffectUpLv:SetActive(false)
	self:ReRefresh(itemData)
end

function BuildView:ReRefresh(itemData)
	self.itemData = itemData
	self.cfgSoulPaintingData = self.itemData:GetCfg()
	self.maxLv = EquipModule.GetMaxLv(self.cfgSoulPaintingData.Quality)
	self.curMaxLv = EquipModule.GetCurMaxLv(self.cfgSoulPaintingData.Quality)

	for i, v in pairsCfg(CfgSoulPaintingQualityTable) do
		if v.PaintingId == self.cfgSoulPaintingData.Id and v.QualityLevel == self.itemData.equipData.star then
			self.cfgSoulPaintingQualityData = v

			break
		end
	end

	self:RefreshMisc()
	self:RefreshCells()
	self:RefreshOnExp(0)
	self:AddListeners()
end

function BuildView:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.startProgressAnim then
		if self.toChangeProgress_1 < self.progressDelta_1 then
			self.toChangeProgress_1 = self.toChangeProgress_1 + self.progressSpeed
			self.toChangeProgress_1 = math.min(self.toChangeProgress_1, self.progressDelta_1)

			self:SetProgress(self.toChangeProgress_1)
		end

		if self.toChangeProgress_1 == self.progressDelta_1 then
			self:SetProgress(0)

			if self.toChangeProgress_2 < self.progressDelta_2 then
				self.toChangeProgress_2 = self.toChangeProgress_2 + self.progressSpeed
				self.toChangeProgress_2 = math.min(self.toChangeProgress_2, self.progressDelta_2)

				self:SetProgress(self.toChangeProgress_2)
			end

			if self.toChangeProgress_2 == self.progressDelta_2 then
				self:StopProgressAnim()
			end
		end
	end
end

function BuildView:OnHide()
	self:RemoveListeners()
	self:StopProgressAnim()
end

function BuildView:OnDestroy()
	for i, v in pairs(self.cells) do
		v:OnDestroy()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function BuildView:AddListeners()
	self:RemoveListeners()
	self.btnUp.onClick:AddListener(self.onClickBtnUpDelegate)
	self.btnClear.onClick:AddListener(self.onClickBtnClearDelegate)
	self.btnMax.onClick:AddListener(self.onClickBtnMaxDelegate)
end

function BuildView:RemoveListeners()
	self.btnUp.onClick:RemoveListener(self.onClickBtnUpDelegate)
	self.btnClear.onClick:RemoveListener(self.onClickBtnClearDelegate)
	self.btnMax.onClick:RemoveListener(self.onClickBtnMaxDelegate)
end

function BuildView:OnClickBtnUp()
	local selected = false

	for i, v in pairs(self.cells) do
		if v.selectedNum > 0 then
			selected = true

			break
		end
	end

	if selected == false then
		NoticeModule.ShowNoticeNoCallback(21041027)

		return
	end

	if self.totalCoin > WarehouseModule.GetItemNumByCfgID(1) then
		NoticeModule.ShowNoticeNoCallback(21041028)

		return
	end

	self.lastEquipLv = self.itemData.equipData.lv
	self.lastTotalAddExp = 0

	local ids = {}
	local counts = {}

	for i, v in pairs(self.cells) do
		if v.selectedNum > 0 then
			ids[#ids + 1] = v.cfgItemData.Id
			counts[#counts + 1] = v.selectedNum
			self.lastTotalAddExp = self.lastTotalAddExp + v.selectedNum * v.exp
		end
	end

	EquipModule.ReqUpEquip(self.itemData.id, ids, counts)
end

function BuildView:OnClickItemCell(cell, isAdd)
	local addExp = 0

	for i, v in pairs(self.cells) do
		addExp = addExp + v.selectedNum * v.exp
	end

	self:StopProgressAnim()
	self:RefreshOnExp(addExp)
end

function BuildView:OnEquipUpSuccess()
	if self.progressDelta_1 > 0 then
		self.goEffectUpLv:SetActive(false)
		self.goEffectUpLv:SetActive(true)
	end

	if self.progressDelta_1 > 0 or self.progressDelta_2 > 0 then
		self:StartProgressAnim()
	end

	self.needProgressAnim = true

	self:ReRefresh(self.itemData)

	self.needProgressAnim = false
end

function BuildView:OnClickBtnClear()
	self:Refresh(self.itemData)
end

function BuildView:OnClickBtnMax()
	if self.canUpLv >= self.curMaxLv then
		if EquipModule.CheckReachedMaxLv(self.canUpLv, self.cfgSoulPaintingData.Quality) then
			NoticeModule.ShowNoticeNoCallback(21053006)
		else
			NoticeModule.ShowNoticeNoCallback(21041042)
		end

		return
	end

	for i = 4, 1, -1 do
		local cell = self.cells[i]

		for i = 1, cell.realOwnNum do
			if self.canUpLv >= self.curMaxLv then
				break
			end

			local ret = cell:DoClickBtnAdd()

			if not ret then
				break
			end
		end
	end
end

function BuildView:RefreshMisc()
	self.goCard.transform:SetParent(self.goCardPoint.transform, false)
	self.goBtnClear:SetActive(self.maxLv ~= self.itemData.equipData.lv)
	self.goBtnMax:SetActive(self.maxLv ~= self.itemData.equipData.lv)
	self.goBtnUp:SetActive(self.maxLv ~= self.itemData.equipData.lv)
end

function BuildView:RefreshOnExp(addExp)
	self.totalCoin = 0

	local isPreview = false

	for i, v in pairs(self.cells) do
		self.totalCoin = self.totalCoin + v.coin * v.selectedNum

		if v.selectedNum > 0 then
			isPreview = true
		end
	end

	self.goBg:SetActive(isPreview)

	self.canUpLv = EquipModule.GetCanUpLv(self.cfgSoulPaintingData, self.itemData.equipData.lv, self.curMaxLv, addExp + self.itemData.equipData.exp)

	local deltaLv = self.canUpLv - self.itemData.equipData.lv

	deltaLv = math.max(0, deltaLv)
	self.tfMoneyNum.text = EquipUIApi:GetString("goCoinNum", self.totalCoin, WarehouseModule.GetItemNumByCfgID(Constant.ItemID.MONEY))
	self.tfLvDesc.text = EquipUIApi:GetString("goLvDesc", self.itemData.equipData.lv + deltaLv, self.maxLv, deltaLv)

	self.goDeltaLvBlock:SetActive(deltaLv ~= 0)

	if deltaLv ~= 0 then
		self.imgDeltaLv_100.gameObject:SetActive(deltaLv >= 100)
		self.imgDeltaLv_10.gameObject:SetActive(deltaLv >= 10)
		self.imgDeltaLv_1.gameObject:SetActive(deltaLv >= 1)

		if deltaLv >= 100 then
			local num100 = math.floor(deltaLv / 100)

			AssetUtil.LoadImage(self, EquipUIApi:GetString("goDeltaLvImgPath", num100), self.imgDeltaLv_100)

			local num10 = math.floor((deltaLv - num100 * 100) / 10)

			AssetUtil.LoadImage(self, EquipUIApi:GetString("goDeltaLvImgPath", num10), self.imgDeltaLv_10)

			local num = deltaLv - num100 * 100 - num10 * 10

			AssetUtil.LoadImage(self, EquipUIApi:GetString("goDeltaLvImgPath", num), self.imgDeltaLv_1)
		elseif deltaLv >= 10 then
			local num10 = math.floor(deltaLv / 10)

			AssetUtil.LoadImage(self, EquipUIApi:GetString("goDeltaLvImgPath", num10), self.imgDeltaLv_10)

			local num = deltaLv - num10 * 10

			AssetUtil.LoadImage(self, EquipUIApi:GetString("goDeltaLvImgPath", num), self.imgDeltaLv_1)
		elseif deltaLv >= 1 then
			local num = deltaLv

			AssetUtil.LoadImage(self, EquipUIApi:GetString("goDeltaLvImgPath", num), self.imgDeltaLv_1)
		end
	end

	self:RefreshPreviewBar(addExp, self.canUpLv)
	self:RefreshAtt(self.canUpLv)
end

function BuildView:RefreshPreviewBar(addExp, canUpLv)
	local totalExp = self.itemData.equipData.exp + addExp

	if self.itemData.equipData.lv ~= 1 then
		for i = 1, self.itemData.equipData.lv - 1 do
			totalExp = totalExp + CfgSoulPaintingLvTable[i].BaseNeedExp * self.cfgSoulPaintingData.ExpGrowthRate
		end
	end

	local nextLv = canUpLv + 1
	local isMaxLv = EquipModule.CheckReachedMaxLv(canUpLv, self.cfgSoulPaintingData.Quality)

	if isMaxLv then
		nextLv = canUpLv
	end

	local needExp = CfgSoulPaintingLvTable[canUpLv].BaseNeedExp * self.cfgSoulPaintingData.ExpGrowthRate
	local preExp = 0

	if canUpLv ~= 1 then
		for i = 1, canUpLv - 1 do
			preExp = preExp + CfgSoulPaintingLvTable[i].BaseNeedExp * self.cfgSoulPaintingData.ExpGrowthRate
		end
	end

	local curExp = totalExp - preExp

	if isMaxLv then
		curExp = 0
	end

	self.previewCurExp = curExp
	self.previewNeedExp = needExp
	self.tfExpPre.text = EquipUIApi:GetString("goExpPre", self.previewCurExp, self.previewNeedExp)

	self.goExpPre:SetActive(self.itemData.equipData.lv < self.curMaxLv)

	if not self.needProgressAnim then
		self.progressDelta_1 = 0
		self.progressDelta_2 = self.previewCurExp / self.previewNeedExp
		self.progressDelta_2 = math.min(self.progressDelta_2, 1)

		if canUpLv > self.itemData.equipData.lv then
			self.progressDelta_1 = 1
		end

		self:SetProgress(self.previewCurExp / self.previewNeedExp)
	end
end

function BuildView:RefreshAtt(canUpLv)
	local ids = {}
	local curValues = {}
	local nextValues = {}
	local names = {}
	local mainId2ValueDic = EquipModule.GetMainAbilityValue(self.cfgSoulPaintingQualityData, self.itemData.equipData.lv)
	local mainId2ValueDicNext = EquipModule.GetMainAbilityValue(self.cfgSoulPaintingQualityData, canUpLv)
	local sortTable = {}

	for i, v in ipairs(self.cfgSoulPaintingQualityData.MainBility) do
		sortTable[i] = v
	end

	table.sort(sortTable, function(a, b)
		return a < b
	end)

	for i, v in ipairs(sortTable) do
		local curValue = mainId2ValueDic[v]
		local nextValue = mainId2ValueDicNext[v]
		local curValueShow = AttributeModule.GetAttShowValue(v, curValue)
		local nextValueShow = AttributeModule.GetAttShowValue(v, nextValue - curValue)

		curValues[#curValues + 1] = curValueShow

		if nextValueShow > 0 then
			ids[#ids + 1] = v
			nextValues[#nextValues + 1] = nextValueShow
		end

		names[#names + 1] = EquipUIApi:GetString("goAttName", v, true)
	end

	for i, v in ipairs(self.goAttCells) do
		v:SetActive(i <= #nextValues)
	end

	for i, v in ipairs(nextValues) do
		local trans = self:GetGoAttCell(i).transform

		trans:Find("Sort_01/Text_01"):GetComponent("Text").text = names[i]
		trans:Find("Text_02"):GetComponent("Text").text = EquipUIApi:GetString("attValueBuildNow", curValues[i])
		trans:Find("Sort_02/Text_01"):GetComponent("Text").text = EquipUIApi:GetString("attValueBuildNext", v)

		local path = SoulUIApi:GetString("soulAttIconPath", ids[i])

		AssetUtil.LoadImage(self, path, trans:Find("Sort_01/Icon_01"):GetComponent("Image"))
	end
end

function BuildView:RefreshCells()
	local fieldData = CfgDiscreteDataTable[6507086].Data

	for i = 1, 4 do
		local dataArr = {}
		local starIndex = (i - 1) * 3 + 1
		local endIndex = starIndex + 2

		for i = starIndex, endIndex do
			dataArr[#dataArr + 1] = fieldData[i]
		end

		self.cells[i]:Refresh(i, dataArr, self)
	end
end

function BuildView:GetGoAttCell(index)
	local ret = self.goAttCells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goAttCell)
		self.goAttCells[index] = ret

		ret.transform:SetParent(self.goAttCell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function BuildView:SetActive(vs)
	if vs == false then
		self:OnHide()
	end

	self.goView:SetActive(vs)
end

function BuildView:GetReachNextLvCostItemCount(itemExp)
	local deltaExp = self.previewNeedExp - self.previewCurExp
	local count = math.ceil(deltaExp / itemExp)

	return count
end

function BuildView:StartProgressAnim()
	self.startProgressAnim = true
	self.toChangeProgress_1 = 0
	self.toChangeProgress_2 = 0
end

function BuildView:StopProgressAnim()
	self.startProgressAnim = false
end

function BuildView:SetProgress(progress)
	self.expBar.fillAmount = progress
end

return BuildView
