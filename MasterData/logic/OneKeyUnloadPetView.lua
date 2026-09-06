-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/onekeyunloadpet/view/OneKeyUnloadPetView.lua

module("logic.extensions.onekeyunloadpet.view.OneKeyUnloadPetView", package.seeall)

local OneKeyUnloadPetView = class("OneKeyUnloadPetView", ViewComponent)
local TabIndexs_Equipment = 1
local TabIndexs_StarGodPlus = 2
local TabIndexs_HolyStripe = 3
local TabIndexList = {
	[TabIndexs_Equipment] = TabIndexs_Equipment,
	[TabIndexs_StarGodPlus] = TabIndexs_StarGodPlus,
	[TabIndexs_HolyStripe] = TabIndexs_HolyStripe
}
local SlotCounts = {
	[TabIndexs_Equipment] = 4,
	[TabIndexs_StarGodPlus] = 4,
	[TabIndexs_HolyStripe] = 5
}
local TabCellTypes_Nor_1 = "tabCell_Nor_1"
local TabCellTypes_Nor_2 = "tabCell_Nor_2"
local TabCellTypes_Eq_Atla = "tabCell_eq_atla"
local TabCellTypes_Eq_Job = "tabCell_eq_job"
local TabCellTypes_Star_Attr = "tabCell_star_attr"
local CondDataLists = {
	[TabIndexs_Equipment] = {
		{
			sifterName = "品质",
			sifterKey = "eqQualityConds",
			tabNames = {
				"白色",
				"绿色",
				"蓝色",
				"蓝+1",
				"紫色",
				"紫+1",
				"紫+2",
				"橙",
				"橙+1",
				"橙+2"
			},
			sifterConds = {
				1,
				2,
				3,
				4,
				5,
				6,
				7,
				8,
				9,
				10
			},
			iconStateKeys = {},
			tabCellType = TabCellTypes_Nor_2
		},
		{
			sifterName = "属性",
			sifterKey = "eqAttrTypeConds",
			tabNames = {
				"火",
				"草",
				"水",
				"光",
				"暗",
				"空",
				"创",
				"无"
			},
			sifterConds = {
				"火",
				"草",
				"水",
				"光",
				"暗",
				"空",
				"创",
				"无"
			},
			iconStateKeys = {
				"火",
				"草",
				"水",
				"光",
				"暗",
				"空",
				"创",
				""
			},
			tabCellType = TabCellTypes_Eq_Atla
		},
		{
			sifterName = "职业",
			sifterKey = "eqJobTypeConds",
			tabNames = {
				"魔法",
				"肉盾",
				"疾速",
				"治疗",
				"平衡",
				"利爪"
			},
			sifterConds = {
				"魔法",
				"肉盾",
				"疾速",
				"治疗",
				"平衡",
				"利爪"
			},
			iconStateKeys = {
				GameEnum.JobZhDefine.Mofa,
				GameEnum.JobZhDefine.Dun,
				GameEnum.JobZhDefine.JiSu,
				GameEnum.JobZhDefine.ZhiLiao,
				GameEnum.JobZhDefine.Pingheng,
				GameEnum.JobZhDefine.LiZhua
			},
			tabCellType = TabCellTypes_Eq_Job
		}
	},
	[TabIndexs_StarGodPlus] = {
		{
			sifterName = "品质",
			sifterKey = "sgQualityConds",
			tabNames = {
				"蓝色",
				"紫色",
				"金色"
			},
			sifterConds = {
				2,
				3,
				4
			},
			iconStateKeys = {},
			tabCellType = TabCellTypes_Nor_1
		},
		{
			sifterName = "星神类型",
			sifterKey = "sgTypeConds",
			tabNames = {
				"攻击",
				"防御",
				"生命",
				"暴击",
				"防暴",
				"命中",
				"闪避",
				"破击",
				"格挡",
				"气势"
			},
			sifterConds = {
				"攻击",
				"防御",
				"生命",
				"暴击",
				"防暴",
				"命中",
				"闪避",
				"破击",
				"格挡",
				"气势"
			},
			iconStateKeys = {
				GameEnum.AttrType.AttackPhysical,
				GameEnum.AttrType.DefensePhysical,
				GameEnum.AttrType.Hp,
				GameEnum.AttrType.CriticalRate,
				GameEnum.AttrType.AntiCriticalRate,
				GameEnum.AttrType.HitRate,
				GameEnum.AttrType.DodgeRate,
				GameEnum.AttrType.StrikeRate,
				GameEnum.AttrType.BlockRate,
				GameEnum.AttrType.OriginalVigour
			},
			tabCellType = TabCellTypes_Star_Attr
		}
	},
	[TabIndexs_HolyStripe] = {
		{
			sifterName = "品质",
			sifterKey = "hsQualityConds",
			tabNames = {
				"绿色",
				"蓝色",
				"紫色",
				"橙色",
				"红色"
			},
			sifterConds = {
				1,
				2,
				3,
				4,
				5
			},
			iconStateKeys = {},
			tabCellType = TabCellTypes_Nor_1
		},
		{
			sifterName = "灵纹类型",
			sifterKey = "hsTypeConds",
			tabNames = {
				"噬电之纹",
				"破刃刻印",
				"亘古鸣雷",
				"御尘之纹",
				"血誓刻印",
				"圣痕裂风",
				"沉石之纹",
				"固结刻印",
				"千载岩磐",
				"落影之纹",
				"复引刻印",
				"冥刻暗咒",
				"折戟御势",
				"渴血萃势",
				"坚如磐石",
				"攻守并蓄"
			},
			sifterConds = {
				"噬电之纹",
				"破刃刻印",
				"亘古鸣雷",
				"御尘之纹",
				"血誓刻印",
				"圣痕裂风",
				"沉石之纹",
				"固结刻印",
				"千载岩磐",
				"落影之纹",
				"复引刻印",
				"冥刻暗咒",
				"折戟御势",
				"渴血萃势",
				"坚如磐石",
				"攻守并蓄"
			},
			iconStateKeys = {},
			tabCellType = TabCellTypes_Nor_2
		}
	}
}

function OneKeyUnloadPetView:_initCondDataLists()
	return
end

function OneKeyUnloadPetView:buildUI()
	OneKeyUnloadPetView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnCloseMask = goutil.findChild(self.mainGO, "btnCloseMask")
	self._btnTips = goutil.findChild(self.mainGO, "btnTips")
	self._matCol = goutil.findChild(self.mainGO, "matCol")
	self._matPet = goutil.findChild(self.mainGO, "matCol/pet")
	self._matPetImgAdd = goutil.findChild(self.mainGO, "matCol/pet/imgAdd")
	self._matPetCon = goutil.findChild(self.mainGO, "matCol/pet/mask/con")
	self._matEmpty = goutil.findChild(self.mainGO, "matCol/empty")
	self._matScrView = goutil.findChild(self.mainGO, "matCol/scrView")
	self._matScrCell = goutil.findChild(self.mainGO, "matCol/scrCell")
	self._matScrollList = ScrollerList.create(self._matScrView, self._matScrCell, GameUtil.handler(self._updateMatCell, self), GameUtil.handler(self._clearMatCell, self))
	self._txtNumInPet = goutil.findChildTextComponent(self.mainGO, "petCol/txtNum")
	self._btnSureInPet = goutil.findChild(self.mainGO, "petCol/btnSure")
	self._emptyInPet = goutil.findChild(self.mainGO, "petCol/empty")

	local petScrView = goutil.findChild(self.mainGO, "petCol/scrView")
	local petScrCell = goutil.findChild(self.mainGO, "petCol/scrCell")

	self._petScrollList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._btnShowAll = goutil.findChild(self.mainGO, "topCol/btnShowAll")
	self._btnSifter = goutil.findChild(self.mainGO, "topCol/btnSifter")
	self._sifterCol = goutil.findChild(self.mainGO, "topCol/sifterCol")
	self._tabCellTypes = goutil.findChild(self.mainGO, "topCol/sifterCol/tabCellTypes")
	self._sifterView = goutil.findChild(self.mainGO, "topCol/sifterCol/sifterView")
	self._typeView = goutil.findChild(self.mainGO, "topCol/sifterCol/sifterView/typeView")
	self._typeCell = goutil.findChild(self.mainGO, "topCol/sifterCol/typeCell")

	local tabView = goutil.findChild(self.mainGO, "tabView")

	self._tabGoList = GameUtil.getChildren(tabView)

	GameUtil.SetActive(self._sifterView, false)
	GameUtil.SetActive(self._typeCell, false)
	GameUtil.SetActive(self._tabCellTypes, false)

	self._sifterViewCustomInput = UICustomInput.Get(self._sifterView)
end

function OneKeyUnloadPetView:bindEvents()
	OneKeyUnloadPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCloseMask, self.close, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnSifter, self._onClickSifter, self)
	GameUtil.addClickHandler(self._btnShowAll, self._onClickShowAll, self)
	GameUtil.addClickHandler(self._btnSureInPet, self._onClickBtnSureInPet, self)
	self._sifterViewCustomInput:AddListener(function(target, hover)
		if not hover then
			self:_onClickSifter()
		end
	end, self)
end

function OneKeyUnloadPetView:unbindEvents()
	OneKeyUnloadPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCloseMask)
	GameUtil.rmClickHandler(self._btnTips)
	GameUtil.rmClickHandler(self._btnSifter)
	GameUtil.rmClickHandler(self._btnShowAll)
	GameUtil.rmClickHandler(self._btnSureInPet)
	self._sifterViewCustomInput:RemoveListener()
end

function OneKeyUnloadPetView:onEnter()
	OneKeyUnloadPetView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._curTabIndex = self._curTabIndex or 1

	self.addGEvent(self, GlobalNotify.PET_EQUIP_CHANGES, self._onUpdate, self)
	self.addGEvent(self, StargodplusController.PM_LoadAllFillerRes, self._onUpdate, self)
	self.addGEvent(self, StarGodPlusAgent.PM_OneKeyUnloadRes, self._onUpdate, self)
	self.addGEvent(self, HolyStripeController.PM_HolyStripeLoadAllRes, self._onUpdate, self)
	self.addGEvent(self, HolyStripeController.PM_HolyStripeReplaceQuenchingDataRes, self._onUpdate, self)
	self.addGEvent(self, HolyStripeController.PM_HolyStripeUnloadAllRes, self._onUpdate, self)
	self:_onUpdate()
end

function OneKeyUnloadPetView:onExit()
	OneKeyUnloadPetView.super.onExit(self)
	self:_onClear()
end

function OneKeyUnloadPetView:_successUnload()
	FloatWordMgr.instance:show("卸下成功")
	self:_onUpdate()
end

function OneKeyUnloadPetView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function OneKeyUnloadPetView:_onClear()
	self:_onClearTabColUI()
	self:_onClearMatColUI()
	self:_onClearPetColUI()
	self:_onClearSifterColUI()
end

function OneKeyUnloadPetView:_onUpdateData()
	self._petIdListsInShow = {}
	self._matMoLists = {}
	self._matMoIndexsDicsByPetId = {}
	self._selectPetIdLists = {}
	self._curShowPetIds = {}
	self._sifterCondsMap = {}

	for tabIndex = 0, #TabIndexList do
		self._petIdListsInShow[tabIndex] = {}
		self._selectPetIdLists[tabIndex] = {}
		self._matMoIndexsDicsByPetId[tabIndex] = {}
		self._curShowPetIds[tabIndex] = 0
		self._sifterCondsMap[tabIndex] = {}

		if not CondDataLists[tabIndex] then
			local condDataList = {}

			for _, condData in ipairs(condDataList) do
				self._sifterCondsMap[tabIndex][condData.sifterKey] = {}
			end
		end
	end

	local equipMoList = {}
	local equipMap = {}
	local starGodMoList = {}
	local starGodMap = {}
	local holyStripeMoList = {}
	local holyStripeMap = {}
	local pets = BagPetsController.instance:getBagAndBorrowPets()

	for _, petMo in pairs(pets) do
		if petMo:isExist() then
			local petId = petMo:getPetId()

			equipMap[petId] = {}
			starGodMap[petId] = {}
			holyStripeMap[petId] = {}

			local equipIdList = PetEquipModel.instance:getUnloadListInEquips(petMo)

			for _, equipId in ipairs(equipIdList) do
				local data = MaterialMgr.getModel(MatType.Equipment, equipId)

				if data and data:isWearEquip() and not data:isEquipArtifact() then
					local mo = {}

					mo.petId = petId
					mo.data = data

					table.insert(equipMoList, mo)
					table.insert(equipMap[petId], #equipMoList)
				end
			end

			local slotDatas = petMo:getStarGodPlusSlots()

			for _, slotData in ipairs(slotDatas) do
				local data = MaterialMgr.getModel(MatType.StarGodPlus, slotData.fillerId)

				if data then
					local mo = {}

					mo.petId = petId
					mo.data = data

					table.insert(starGodMoList, mo)
					table.insert(starGodMap[petId], #starGodMoList)
				end
			end

			for k, v in pairs(petMo.holyStripes) do
				local data = MaterialMgr.getModel(MatType.HolyStripe, checknumber(v.id))

				if data then
					local mo = {}

					mo.petId = petId
					mo.data = data

					table.insert(holyStripeMoList, mo)
					table.insert(holyStripeMap[petId], #holyStripeMoList)
				end
			end
		end
	end

	self._matMoLists[TabIndexs_Equipment] = equipMoList
	self._matMoIndexsDicsByPetId[TabIndexs_Equipment] = equipMap
	self._matMoLists[TabIndexs_StarGodPlus] = starGodMoList
	self._matMoIndexsDicsByPetId[TabIndexs_StarGodPlus] = starGodMap
	self._matMoLists[TabIndexs_HolyStripe] = holyStripeMoList
	self._matMoIndexsDicsByPetId[TabIndexs_HolyStripe] = holyStripeMap
end

function OneKeyUnloadPetView:_onUpdateUI()
	self:_onUpdateSifterCondData()
	self:_onUpdateTabColUI()
	self:_onUpdateMatColUI()
	self:_onUpdatePetColUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateSifterColUI()
end

function OneKeyUnloadPetView:_onUpdateSifterCondData()
	local tabIndex = self._curTabIndex

	table.clear(self._petIdListsInShow[tabIndex])

	for petId, matMoIndexs in pairs(self._matMoIndexsDicsByPetId[tabIndex]) do
		local isNotEmpty = #matMoIndexs > 0
		local isHaveFit = false

		for _, moIndex in ipairs(matMoIndexs) do
			if tabIndex == TabIndexs_Equipment then
				isHaveFit = self:_isFitMoInEquipment(tabIndex, moIndex)
			elseif tabIndex == TabIndexs_StarGodPlus then
				isHaveFit = self:_isFitMoInStarGodPlus(tabIndex, moIndex)
			elseif tabIndex == TabIndexs_HolyStripe then
				isHaveFit = self:_isFitMoInHolyStripe(tabIndex, moIndex)
			end

			if isHaveFit then
				break
			end
		end

		if isNotEmpty and isHaveFit then
			table.insert(self._petIdListsInShow[tabIndex], petId)
		end
	end
end

function OneKeyUnloadPetView:_isFitMoInEquipment(tabIndex, moIndex)
	local isFit = false
	local mo = self:_getMatMo(tabIndex, moIndex)

	if mo then
		isFit = true

		local data = mo.data
		local eqQualityConds = self:_getSifterConds(tabIndex, "eqQualityConds")
		local eqAttrTypeConds = self:_getSifterConds(tabIndex, "eqAttrTypeConds")
		local eqJobTypeConds = self:_getSifterConds(tabIndex, "eqJobTypeConds")

		if isFit and #eqQualityConds > 0 then
			isFit = false

			for _, cond in ipairs(eqQualityConds) do
				if cond >= data.quality then
					isFit = true

					break
				end
			end
		end

		if isFit and #eqJobTypeConds > 0 then
			isFit = false

			for _, eqJobTypeCond in ipairs(eqJobTypeConds) do
				local jobTypeList = data.jobTypeList

				if jobTypeList and table.indexof(jobTypeList, eqJobTypeCond) ~= false then
					isFit = true

					break
				end
			end
		end

		if isFit and #eqAttrTypeConds > 0 then
			isFit = table.indexof(eqAttrTypeConds, data.attrType) ~= false
		end
	end

	return isFit
end

function OneKeyUnloadPetView:_isFitMoInStarGodPlus(tabIndex, moIndex)
	local isFit = false
	local mo = self:_getMatMo(tabIndex, moIndex)

	if mo then
		isFit = true

		local data = mo.data
		local sgQualityConds = self:_getSifterConds(tabIndex, "sgQualityConds")
		local sgTypeConds = self:_getSifterConds(tabIndex, "sgTypeConds")

		if isFit and #sgQualityConds > 0 then
			isFit = false

			local quality = data:getQuality()

			for _, cond in ipairs(sgQualityConds) do
				if quality <= cond then
					isFit = true

					break
				end
			end
		end

		if isFit and #sgTypeConds > 0 then
			local sgType = data:getEquipType()
			local typeName = GameEnum.StarGodPlusEquipTypeName[sgType]

			isFit = table.indexof(sgTypeConds, typeName) ~= false
		end
	end

	return isFit
end

function OneKeyUnloadPetView:_isFitMoInHolyStripe(tabIndex, moIndex)
	local isFit = false
	local mo = self:_getMatMo(tabIndex, moIndex)

	if mo then
		isFit = true

		local data = mo.data
		local hsQualityConds = self:_getSifterConds(tabIndex, "hsQualityConds")
		local hsTypeConds = self:_getSifterConds(tabIndex, "hsTypeConds")

		if isFit and #hsQualityConds > 0 then
			isFit = false

			local quality = data:getQuality()

			for _, cond in ipairs(hsQualityConds) do
				if quality <= cond then
					isFit = true

					break
				end
			end
		end

		if isFit and #hsTypeConds > 0 then
			local name = data:getName()

			isFit = table.indexof(hsTypeConds, name) ~= false
		end
	end

	return isFit
end

function OneKeyUnloadPetView:_getMatMo(tabIndex, moIndex)
	return self._matMoLists[tabIndex][moIndex]
end

function OneKeyUnloadPetView:_getMoIndexListByPetId(tabIndex, petId)
	local map = self._matMoIndexsDicsByPetId[tabIndex]

	return map[petId] or {}
end

function OneKeyUnloadPetView:_addPetToSelect(tabIndex, petId, isAdd)
	if isAdd then
		if self:_isInSelectListThePet(tabIndex, petId) then
			printError(string.format("petId已存在选择列表中( tabIndex=%s, petId=%s, isAdd=%s )", tabIndex, petId, isAdd))
		elseif self:_isLimitMaxSelectPetCount(tabIndex) then
			FloatWordMgr.instance:show("已达本次操作最大上限")
		else
			table.insert(self._selectPetIdLists[tabIndex], petId)
		end
	else
		table.removebyvalue(self._selectPetIdLists[tabIndex], petId)
	end
end

function OneKeyUnloadPetView:_isInSelectListThePet(tabIndex, petId)
	return table.indexof(self._selectPetIdLists[tabIndex], petId) ~= false
end

function OneKeyUnloadPetView:_getCurSelectPetCount(tabIndex)
	return #self._selectPetIdLists[tabIndex]
end

function OneKeyUnloadPetView:_getMaxSelectPetCount()
	return 5
end

function OneKeyUnloadPetView:_isLimitMaxSelectPetCount(tabIndex)
	local cur = self:_getCurSelectPetCount(tabIndex)
	local max = self:_getMaxSelectPetCount()

	return max <= cur
end

function OneKeyUnloadPetView:_setSifterCond(tabIndex, sifterKey, value, isAdd)
	local isHaveAdd = self:_isSifterCondHaveAdd(tabIndex, sifterKey, value)

	if isAdd then
		if isHaveAdd then
			printError("对应值已添加，不要重复添加")

			return
		end

		table.insert(self._sifterCondsMap[tabIndex][sifterKey], value)
	else
		if not isHaveAdd then
			printError("对应值不存在，不要试图删减不存在的值")

			return
		end

		table.removebyvalue(self._sifterCondsMap[tabIndex][sifterKey], value, true)
	end
end

function OneKeyUnloadPetView:_getSifterConds(tabIndex, sifterKey)
	return self._sifterCondsMap[tabIndex][sifterKey] or {}
end

function OneKeyUnloadPetView:_isSifterCondHaveAdd(tabIndex, sifterKey, value)
	local conds = self:_getSifterConds(tabIndex, sifterKey)

	return table.indexof(conds, value) ~= false
end

function OneKeyUnloadPetView:_clearSifterCondsByTab(tabIndex)
	for sifterKey, conds in pairs(self._sifterCondsMap[tabIndex]) do
		table.clear(conds)
	end
end

function OneKeyUnloadPetView:_onUpdateTabColUI()
	for tabIndex, mainGo in ipairs(self._tabGoList) do
		self:_updateTabCell(mainGo, tabIndex)
	end
end

function OneKeyUnloadPetView:_onClearTabColUI()
	for tabIndex, tabGo in ipairs(self._tabGoList) do
		self:_clearTabCell(tabGo)
	end
end

function OneKeyUnloadPetView:_updateTabCell(mainGo, tabIndex)
	if tabIndex > #TabIndexList then
		GameUtil.SetActive(mainGo, false)
		self:_clearTabCell(mainGo)

		return
	end

	local isSelected = self._curTabIndex == tabIndex

	GameUtil.SetActive(mainGo, true)
	GameUtil.setUIGroupIdx(mainGo, isSelected and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickTabCell, self, tabIndex), self)
end

function OneKeyUnloadPetView:_clearTabCell(mainGo)
	GameUtil.rmClickHandler(mainGo)
end

function OneKeyUnloadPetView:_clickTabCell(tabIndex)
	self._curTabIndex = tabIndex

	self:_onUpdateUI()
end

function OneKeyUnloadPetView:_onUpdateMatColUI()
	local tabIndex = self._curTabIndex
	local petId = self._curShowPetIds[tabIndex]

	if petId > 0 then
		local petMo = BagPetsController.instance:getPet(petId)
		local skinId = petMo.curFaceId

		MaterialMgr.setIcon(self._matPetCon, MatType.Pet, skinId, nil, nil)
		GameUtil.addClickHandler(self._matPet, function()
			CommonTipsMgr.instance:showPetTips(petMo)
		end, self)
		GameUtil.SetActive(self._matPetImgAdd, false)
	else
		MaterialMgr.clearIcon(self._matPetCon)
		GameUtil.rmClickHandler(self._matPet)
		GameUtil.SetActive(self._matPetImgAdd, true)
	end

	if not self._matMoIndexsDicsByPetId[tabIndex][petId] then
		local moIndexList = {}
		local isEmpty = #moIndexList <= 0

		if not SlotCounts[tabIndex] then
			local slotCount = 0

			for i = 1, slotCount do
				if moIndexList[i] == nil then
					moIndexList[i] = 0
				end
			end

			self._matScrollList:reloadData(moIndexList)
			GameUtil.SetActive(self._matEmpty, isEmpty)
			GameUtil.SetActive(self._matScrView, not isEmpty)
		end
	end
end

function OneKeyUnloadPetView:_onClearMatColUI()
	self._matScrollList:dispose()
end

function OneKeyUnloadPetView:_updateMatCell(view, cell, moIndex, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local empty = goutil.findChild(mainGo, "empty")
	local matMo = self:_getMatMo(self._curTabIndex, moIndex)

	if matMo then
		local data = matMo.data
		local proxy = MaterialMgr.setCellByMo(data, item)

		proxy.binder:setNumStr("")
		GameUtil.SetActive(empty, false)
	else
		MaterialMgr.resetAll(item)
		GameUtil.SetActive(empty, true)
	end
end

function OneKeyUnloadPetView:_clearMatCell(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(item)
end

function OneKeyUnloadPetView:_onUpdatePlaneUI()
	local cur = self:_getCurSelectPetCount(self._curTabIndex)
	local max = self:_getMaxSelectPetCount()

	self._txtNumInPet.text = string.format("%s/%s", cur, max)

	GameUtil.SetGray(self._btnSureInPet, cur == 0)
end

function OneKeyUnloadPetView:_onUpdatePetColUI()
	if not self._petIdListsInShow[self._curTabIndex] then
		local petIdList = {}

		self._petScrollList:reloadData(petIdList)
		GameUtil.SetActive(self._emptyInPet, #petIdList <= 0)
	end
end

function OneKeyUnloadPetView:_onClearPetColUI()
	self._petScrollList:dispose()
end

function OneKeyUnloadPetView:_updatePetCell(view, cell, petId, tag)
	local tabIndex = self._curTabIndex
	local isSelected = self:_isInSelectListThePet(tabIndex, petId)
	local isShow = self._curShowPetIds[tabIndex] == petId
	local petMo = BagPetsController.instance:getPet(petId)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")
	local imgSelect = goutil.findChild(mainGo, "pet/imgSelect")
	local imgShow = goutil.findChild(mainGo, "pet/imgShow")

	if petMo then
		local skinId = petMo.curFaceId

		MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)
		GameUtil.addClickHandler(pet, GameUtil.handler(self._clickPetCell, self, petId), self)
	else
		MaterialMgr.clearIcon(con)
		GameUtil.rmClickHandler(pet)
	end

	GameUtil.SetActive(imgSelect, isSelected)
	GameUtil.SetActive(imgShow, isShow)
end

function OneKeyUnloadPetView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
end

function OneKeyUnloadPetView:_clickPetCell(petId)
	local tabIndex = self._curTabIndex
	local isSelected = self:_isInSelectListThePet(tabIndex, petId)

	if isSelected then
		self:_addPetToSelect(tabIndex, petId, false)
	else
		self:_addPetToSelect(tabIndex, petId, true)
	end

	self._curShowPetIds[tabIndex] = petId

	self:_onUpdateMatColUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePetColUI()
end

function OneKeyUnloadPetView:_onUpdateSifterColUI()
	local tabIndex = self._curTabIndex

	if not CondDataLists[tabIndex] then
		local condDataList = {}

		for typeIdx = 1, self._typeView.transform.childCount do
			local typeCellGo = self._typeView.transform:GetChild(typeIdx - 1).gameObject
			local tabView = goutil.findChild(typeCellGo, "tabView")

			for tabIdx = 1, tabView.transform.childCount do
				local tabCellGo = tabView.transform:GetChild(tabIdx - 1).gameObject

				GameUtil.SetActive(tabCellGo, false)
			end

			GameUtil.SetActive(typeCellGo, false)
		end

		for typeIdx = 1, #condDataList do
			local typeCellGo = typeIdx <= self._typeView.transform.childCount and self._typeView.transform:GetChild(typeIdx - 1).gameObject or goutil.cloneAndSetParent(self._typeCell, self._typeView.transform, "typeCell_" .. typeIdx)

			GameUtil.SetActive(typeCellGo, true)

			local condData = condDataList[typeIdx]
			local txtTitle = goutil.findChildTextComponent(typeCellGo, "txtTitle/txt")
			local tabView = goutil.findChild(typeCellGo, "tabView")
			local m_tabCell = goutil.findChild(self._tabCellTypes, condData.tabCellType)
			local gridLayoutGroup = tabView:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))

			txtTitle.text = condData.sifterName
			gridLayoutGroup.cellSize = Vector2.New(GameUtil.getWidth(m_tabCell), GameUtil.getHeight(m_tabCell))

			local tabCount = #condData.tabNames

			for tabIdx = 1, tabCount do
				local tabCellName = string.format("%s_%s", m_tabCell.name, tabIdx)
				local tabCellGo = goutil.findChild(tabView.transform, tabCellName)

				if goutil.isNil(tabCellGo) then
					tabCellGo = goutil.cloneAndSetParent(m_tabCell, tabView.transform, string.format("%s_%s", m_tabCell.name, tabIdx))
				end

				GameUtil.SetActive(tabCellGo, true)

				local tabCellType = condData.tabCellType
				local tabName = condData.tabNames[tabIdx]
				local sifterCond = condData.sifterConds[tabIdx]
				local iconStateKey = condData.iconStateKeys[tabIdx]
				local sifterKey = condData.sifterKey
				local isSelected = self:_isSifterCondHaveAdd(tabIndex, sifterKey, sifterCond)

				GameUtil.setUIGroupIdx(tabCellGo, isSelected and 1 or 0)

				if tabCellType == TabCellTypes_Nor_1 or tabCellType == TabCellTypes_Nor_2 then
					local txtTab = goutil.findChildTextComponent(tabCellGo, "txtTab")

					txtTab.text = tabName
				elseif tabCellType == TabCellTypes_Eq_Atla then
					local txtTab = goutil.findChildTextComponent(tabCellGo, "txtTab")
					local iconAtlas = goutil.findChild(tabCellGo, "iconAtlas")

					txtTab.text = tabName

					local state = (GameEnum.Races[iconStateKey] or 1) - 1

					GameUtil.setUIImageSpriteIdx(iconAtlas, state)
					GameUtil.SetActive(iconAtlas, not string.nilorempty(iconStateKey))
				elseif tabCellType == TabCellTypes_Eq_Job then
					local txtTab = goutil.findChildTextComponent(tabCellGo, "txtTab")
					local iconJob = goutil.findChild(tabCellGo, "iconJob")

					txtTab.text = tabName

					local state = (GameEnum.JobZh[iconStateKey] or 1) - 1

					GameUtil.setUIImageSpriteIdx(iconJob, state)
					GameUtil.setUIImageColorIdx(iconJob, isSelected and 1 or 0)
					GameUtil.SetActive(iconJob, not string.nilorempty(iconStateKey))
				elseif tabCellType == TabCellTypes_Star_Attr then
					local txtTab = goutil.findChildTextComponent(tabCellGo, "txtTab")
					local iconAttrs = goutil.findChild(tabCellGo, "iconAttrs")

					txtTab.text = tabName

					GameUtil.setUIImageSpriteIdx(iconAttrs, iconStateKey - 1)
					GameUtil.setUIImageColorIdx(iconAttrs, isSelected and 1 or 0)
					GameUtil.SetActive(iconAttrs, not string.nilorempty(iconStateKey))
				end

				GameUtil.addClickHandler(tabCellGo, function()
					local istabSelected = self:_isSifterCondHaveAdd(tabIndex, sifterKey, sifterCond)
					local isAdd = not istabSelected

					self:_setSifterCond(tabIndex, sifterKey, sifterCond, isAdd)
					self:_onUpdateUI()
				end)
			end

			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(tabView:GetComponent(goutil.Type_RectTransform))
		end
	end
end

function OneKeyUnloadPetView:_onClearSifterColUI()
	return
end

function OneKeyUnloadPetView:_onClickSifter()
	GameUtil.SetActive(self._sifterView, not GameUtil.GetActive(self._sifterView))
end

function OneKeyUnloadPetView:_onClickShowAll()
	self:_clearSifterCondsByTab(self._curTabIndex)
	self:_onUpdateUI()
end

function OneKeyUnloadPetView:_onClickBtnSureInPet()
	if not self._selectPetIdLists[self._curTabIndex] then
		if #self._selectPetIdLists[self._curTabIndex] <= 0 then
			FloatWordMgr.instance:show("未选择精灵")

			return
		end

		local tabIndex = self._curTabIndex

		if tabIndex == TabIndexs_Equipment then
			PetEquipController.instance:CSOneKeyUnloadEquipReq(self._selectPetIdLists[self._curTabIndex])
		elseif tabIndex == TabIndexs_StarGodPlus then
			StarGodPlusAgent.instance:sendPM_OneKeyUnloadReq(self._selectPetIdLists[self._curTabIndex])
		elseif tabIndex == TabIndexs_HolyStripe then
			HolyStripeAgent.instance:sendPM_HolyStripeUnloadAllReq(self._selectPetIdLists[self._curTabIndex])
		end
	end
end

function OneKeyUnloadPetView:_onClickBtnTips()
	TipsFacade.instance:openRulesView("OneClickRemoval_rule")
end

return OneKeyUnloadPetView
