-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipTupoOneKeyView.lua

module("logic.extensions.equipment.view.EquipTupoOneKeyView", package.seeall)

local EquipTupoOneKeyView = class("EquipTupoOneKeyView", ViewComponent)
local needEquipCountWithQuality = {
	[8] = 3,
	[9] = 2
}
local EQUIP_NOT_ENOUGH = 1
local EXP_NOT_ENOUGH = 2
local MAT_NOT_ENOUGH = 3
local COIN_NOT_ENOUGH = 4
local SELECT_NOT_ENOUGH = 5
local attrTxtType = {
	[GameEnum.RaceStr.Cao] = GameEnum.RaceType.Cao,
	[GameEnum.RaceStr.Shui] = GameEnum.RaceType.Shui,
	[GameEnum.RaceStr.Huo] = GameEnum.RaceType.Huo,
	[GameEnum.RaceStr.Guang] = GameEnum.RaceType.Guang,
	[GameEnum.RaceStr.An] = GameEnum.RaceType.An,
	[GameEnum.RaceStr.Kong] = GameEnum.RaceType.Kong,
	[GameEnum.RaceStr.Chuang] = GameEnum.RaceType.Chuang,
	[GameEnum.RaceStr.Yuan] = GameEnum.RaceType.Yuan
}

function EquipTupoOneKeyView:ctor()
	EquipTupoOneKeyView.super.ctor(self)
end

function EquipTupoOneKeyView:bindEvents()
	EquipTupoOneKeyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnAutoMaxLevel, self._onClickAutoMaxLevel, self)
	GameUtil.addClickHandler(self._btnSifter, self._onClickFilter, self)
end

function EquipTupoOneKeyView:unbindEvents()
	EquipTupoOneKeyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnAutoMaxLevel)
	GameUtil.rmClickHandler(self._btnSifter)
end

function EquipTupoOneKeyView:destroyUI()
	EquipTupoOneKeyView.super.destroyUI(self)
end

function EquipTupoOneKeyView:buildUI()
	EquipTupoOneKeyView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._empty = self:getGo("empty")
	self._btnSure = self:getGo("btnSure")
	self._btnAutoMaxLevel = self:getGo("btnAutoMaxLevel")
	self._txtNum = self:getTxt("txtNum")
	self._btnAutoMaxLevel = self:getGo("btnAutoMaxLevel")
	self._tagAuto = self:getGo("btnAutoMaxLevel/tagAuto")
	self._btnSifter = self:getGo("btnSifter")
end

function EquipTupoOneKeyView:onExit()
	EquipTupoOneKeyView.super.onExit(self)
end

function EquipTupoOneKeyView:onEnter()
	EquipTupoOneKeyView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EQM_BatchBreakoutRes, self._EQM_BatchBreakoutRes, self)
	self.addGEvent(self, GlobalNotify.EquipBatchBreakoutRaceTypeFilter, self._onFilterTypeChange, self)
	self.addGEvent(self, GlobalNotify.EquipBatchBreakoutJobTypeFilter, self._onFilterJobChange, self)

	self._resultList = {}
	self._goodConsume = EquipmentConfig.instance:getTupoGoodConsume()
	self._selectMap = {}
	self._isAutoMaxLevel = false
	self._costExp = 0
	self._costCoin = 0
	self._costMat = {}

	self:_calcResult()
	self:_autoSelect()
	self:_refreshView()
	GameUtil.SetActive(self._tagAuto, self._isAutoMaxLevel)
end

function EquipTupoOneKeyView:_calcResult()
	self._haveMatExp = 0

	for i, v in ipairs(EquipmentConfig.instance:GetStrengtheningMaterial()) do
		local matNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, v.matId)
		local totalMatExp = matNum * v.matExp

		self._haveMatExp = self._haveMatExp + totalMatExp
	end

	self._resultList = {}
	self._costEquipMap = {}

	local allMoList = PetEquipModel.instance:GetAllInfoMoList()
	local equipList = {}
	local unEquipMap = {}
	local coinCount = MaterialModel.instance:getMaterialsNumber(MatType.Coin, 1)
	local resultId = 1

	for i, v in ipairs(allMoList) do
		if not v:isEquipArtifact() and v:GetEquipExclRaceId() == 0 and v.quality >= 8 and v:isAttributesEquip() and v.beforeNum > 0 and v.afterNum > 0 then
			if v:isWearEquip() then
				local planList = EquipmentConfig.instance:GetEquipLevelInfos(v.attrPlan)
				local maxLvCfg = planList[#planList]

				if maxLvCfg.exp - v.haveAllExp <= self._haveMatExp and coinCount >= (maxLvCfg.exp - v.haveAllExp) * v.expCoinRatio then
					table.insert(equipList, v)
				end

				local configId = v:getDefineId()

				unEquipMap[configId] = unEquipMap[configId] or {}
			else
				local configId = v:getDefineId()

				unEquipMap[configId] = unEquipMap[configId] or {}

				table.insert(unEquipMap[configId], v)
			end
		end
	end

	for configId, moList in pairs(unEquipMap) do
		table.sort(moList, function(a, b)
			if a.haveAllExp ~= b.haveAllExp then
				return a.haveAllExp >= b.haveAllExp
			else
				return a.onlyId < b.onlyId
			end
		end)
	end

	for i, v in ipairs(equipList) do
		local configId = v:getDefineId()
		local needEquipCount = needEquipCountWithQuality[v.quality]

		if checknumber(needEquipCount) > 0 then
			local costList = {}

			self._costEquipMap[configId] = self._costEquipMap[configId] or {}

			if unEquipMap[configId] and needEquipCount <= #unEquipMap[configId] then
				for j = 1, needEquipCount do
					local costMo = table.remove(unEquipMap[configId])

					table.insert(costList, costMo)

					self._costEquipMap[configId] = self._costEquipMap[configId] or {}

					table.insert(self._costEquipMap[configId], costMo)
				end

				if #unEquipMap[configId] <= 0 then
					unEquipMap[configId] = nil
				end
			elseif unEquipMap[configId] and needEquipCount <= #unEquipMap[configId] + #self._costEquipMap[configId] or needEquipCount <= #self._costEquipMap[configId] then
				for j, costMo in ipairs((not unEquipMap[configId] or nil) and {}) do
					table.insert(self._costEquipMap[configId], costMo)
				end

				unEquipMap[configId] = nil

				for j = 1, needEquipCount do
					table.insert(costList, self._costEquipMap[configId][j])
				end
			end

			local planList = EquipmentConfig.instance:GetEquipLevelInfos(v.attrPlan)
			local maxLvCfg = planList[#planList]

			if needEquipCount <= #costList then
				if v.quality == 8 then
					local resultInfo = {}

					resultInfo.resultId = resultId
					resultInfo.mainEquip = v
					resultInfo.costMoList = costList
					resultInfo.result = self:getTupoRightEquip(v)
					resultInfo.costExp = maxLvCfg.exp - v.haveAllExp
					resultInfo.costCoin = (maxLvCfg.exp - v.haveAllExp) * v.expCoinRatio
					resultId = resultId + 1

					table.insert(self._resultList, resultInfo)
				elseif v.quality == 9 then
					local matType, matId, matNum = MaterialMgr.getMatParams(self._goodConsume[v.wearPos])
					local haveCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

					if checknumber(haveCount) >= checknumber(matNum) then
						local resultInfo = {}

						resultInfo.resultId = resultId
						resultInfo.mainEquip = v
						resultInfo.costMoList = costList
						resultInfo.result = self:getTupoRightEquip(v)
						resultInfo.costItem = self._goodConsume[v.wearPos]
						resultInfo.costExp = maxLvCfg.exp - v.haveAllExp
						resultInfo.costCoin = (maxLvCfg.exp - v.haveAllExp) * v.expCoinRatio
						resultId = resultId + 1

						table.insert(self._resultList, resultInfo)
					end
				end
			end
		end
	end

	for configId, moList in pairs(unEquipMap) do
		local mainEquip = table.remove(moList, 1)

		while mainEquip ~= nil do
			local needEquipCount = needEquipCountWithQuality[mainEquip.quality]
			local costList = {}
			local maxMoveCount = needEquipCount < #moList and needEquipCount or #moList

			for j = 1, maxMoveCount do
				local costMo = table.remove(moList)

				table.insert(costList, costMo)

				self._costEquipMap[configId] = self._costEquipMap[configId] or {}

				table.insert(self._costEquipMap[configId], costMo)
			end

			local isCanTupo = true
			local planList = EquipmentConfig.instance:GetEquipLevelInfos(mainEquip.attrPlan)
			local maxLvCfg = planList[#planList]

			if maxLvCfg.exp - mainEquip.haveAllExp >= self._haveMatExp or coinCount < (maxLvCfg.exp - mainEquip.haveAllExp) * mainEquip.expCoinRatio then
				isCanTupo = false
			end

			if isCanTupo == true then
				if mainEquip.quality == 8 then
					if maxMoveCount == needEquipCount then
						local resultInfo = {}

						resultInfo.resultId = resultId
						resultInfo.mainEquip = mainEquip
						resultInfo.costMoList = costList
						resultInfo.result = self:getTupoRightEquip(mainEquip)
						resultInfo.costExp = maxLvCfg.exp - mainEquip.haveAllExp
						resultInfo.costCoin = (maxLvCfg.exp - mainEquip.haveAllExp) * mainEquip.expCoinRatio
						resultId = resultId + 1

						table.insert(self._resultList, resultInfo)
					else
						isCanTupo = false
					end
				elseif mainEquip.quality == 9 then
					local matType, matId, matNum = MaterialMgr.getMatParams(self._goodConsume[mainEquip.wearPos])
					local haveCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

					if maxMoveCount == needEquipCount and checknumber(haveCount) >= checknumber(matNum) then
						local resultInfo = {}

						resultInfo.resultId = resultId
						resultInfo.mainEquip = mainEquip
						resultInfo.costMoList = costList
						resultInfo.result = self:getTupoRightEquip(mainEquip)
						resultInfo.costItem = self._goodConsume[mainEquip.wearPos]
						resultInfo.costExp = maxLvCfg.exp - mainEquip.haveAllExp
						resultInfo.costCoin = (maxLvCfg.exp - mainEquip.haveAllExp) * mainEquip.expCoinRatio
						resultId = resultId + 1

						table.insert(self._resultList, resultInfo)
					else
						isCanTupo = false
					end
				end
			end

			if not isCanTupo then
				self._costEquipMap[configId] = self._costEquipMap[configId] or {}

				table.insert(self._costEquipMap[configId], mainEquip)
			end

			mainEquip = #moList > 0 and table.remove(moList, 1) or nil
		end
	end

	ArraySort.sortOn(self._resultList, {
		function(info)
			return info.mainEquip.equipPetId
		end,
		function(info)
			return attrTxtType[info.mainEquip.attrType]
		end,
		function(info)
			return info.mainEquip.quality
		end,
		function(info)
			return info.mainEquip.baseId
		end,
		function(info)
			return info.mainEquip.haveAllExp
		end,
		function(info)
			return info.mainEquip.onlyId
		end
	}, {
		ArraySort.DESCENDING,
		ArraySort.NONE,
		ArraySort.NONE,
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.NONE
	})

	for i, v in ipairs(self._resultList) do
		v.resultId = i
	end
end

function EquipTupoOneKeyView:_refreshView()
	local maxNum = checknumber(EquipmentConfig.instance:getCommonValue("MAX_BATCH_BREAKOUT_COUNT"))
	local selectCount = 0

	for i, v in pairs(self._selectMap) do
		if v == true then
			selectCount = selectCount + 1
		end
	end

	self._txtNum.text = langPara("本次操作：%s/%s", selectCount, maxNum)

	GameUtil.SetActive(self._empty, #self._resultList <= 0)

	local showList = {}

	for i, v in ipairs(self._resultList) do
		local isFilter = not (self._filterType and not self._filterType[v.mainEquip.attrType])

		if self._filterJob then
			local isFind = false

			for j, job in ipairs(v.mainEquip.jobTypeList) do
				for q, filterJob in ipairs(self._filterJob) do
					if filterJob == job then
						isFind = true

						break
					end
				end

				if isFind == true then
					break
				end
			end

			if not isFind then
				isFilter = false
			end
		end

		if isFilter == true then
			table.insert(showList, v)
		end
	end

	self._tableList:reloadData(showList)
end

function EquipTupoOneKeyView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local mainEuqip = goutil.findChild(go, "mainEquip")
	local mainEquipCon = goutil.findChild(mainEuqip, "con")
	local mainEquipExpSlider = goutil.findChildComponent(mainEuqip, "qhBarSli", ComponentType.Slider)
	local petIconGo = goutil.findChild(mainEuqip, "petIconGo")
	local petIconCon = goutil.findChild(petIconGo, "icon")
	local resultEquip = goutil.findChild(go, "resultEuqip")
	local resultCon = goutil.findChild(resultEquip, "resultCon")
	local resultPetIconGo = goutil.findChild(resultEquip, "petIconGo")
	local resultPetIconCon = goutil.findChild(resultPetIconGo, "icon")
	local btnSelect = goutil.findChild(go, "btnSelect")
	local selectTag = goutil.findChild(btnSelect, "selectTag")
	local txtCostLack = goutil.findChildTextComponent(go, "txtCostLack")
	local costConList = {}

	for i = 1, 3 do
		local costGo = goutil.findChild(go, "costCon" .. i)

		table.insert(costConList, costGo)
	end

	local mainMo = data.mainEquip

	MaterialMgr.setCellByData(MatType.Equipment, mainMo, mainEquipCon)

	local nowEquipInfo, nextEquipInfo = PetEquipModel.instance:GetEquipNowNextAttrList(mainMo)

	mainEquipExpSlider.value = nextEquipInfo == nil and 1 or mainMo.haveAllExp / (nextEquipInfo.levelExp - nowEquipInfo.levelExp)

	GameUtil.SetActive(petIconGo, checknumber(mainMo.equipPetId) > 0)
	GameUtil.SetActive(resultPetIconGo, checknumber(mainMo.equipPetId) > 0)

	if mainMo:isWearEquip() then
		local petMo = BagPetsController.instance:getPet(mainMo.equipPetId)

		MaterialMgr.setIcon(petIconCon, MatType.Pet, petMo.raceId)
		MaterialMgr.setIcon(resultPetIconCon, MatType.Pet, petMo.raceId)
	end

	MaterialMgr.setCellByData(MatType.Equipment, data.result, resultCon)

	for i, v in ipairs(data.costMoList) do
		MaterialMgr.setCellByData(MatType.Equipment, v, costConList[i])
	end

	if data.costItem and costConList[#data.costMoList + 1] then
		MaterialMgr.setCellByCfg(data.costItem, costConList[#data.costMoList + 1])
	end

	GameUtil.SetActive(selectTag, self._selectMap[data.resultId])

	if self._selectMap[data.resultId] == true then
		txtCostLack.text = ""
	else
		local canSelectResult, type = self:_isCanSelect(data.resultId)

		txtCostLack.text = canSelectResult == false and (type == EQUIP_NOT_ENOUGH and "装备不足" or type == EXP_NOT_ENOUGH and "经验材料不足" or type == MAT_NOT_ENOUGH and "突破材料不足" or type == COIN_NOT_ENOUGH and "金币不足" or "") or ""
	end

	GameUtil.rmClickHandler(btnSelect)
	GameUtil.addClickHandler(btnSelect, function()
		self:_onClickSelect(data.resultId)
	end)
end

function EquipTupoOneKeyView:_clearCell(cell)
	local go = cell.gameObject
	local mainEuqip = goutil.findChild(go, "mainEquip")
	local mainEquipCon = goutil.findChild(mainEuqip, "con")
	local petIconGo = goutil.findChild(mainEuqip, "petIconGo")
	local petIconCon = goutil.findChild(petIconGo, "icon")

	for i = 1, 3 do
		local costGo = goutil.findChild(go, "costCon" .. i)

		MaterialMgr.resetAll(costGo)
	end

	local resultCon = goutil.findChild(go, "resultCon")
	local btnSelect = goutil.findChild(go, "btnSelect")

	MaterialMgr.resetAll(resultCon)
	MaterialMgr.resetAll(mainEquipCon)
	MaterialMgr.resetAll(petIconCon)
	GameUtil.rmClickHandler(btnSelect)
end

function EquipTupoOneKeyView:_autoSelect()
	local maxNum = checknumber(EquipmentConfig.instance:getCommonValue("MAX_BATCH_BREAKOUT_COUNT"))
	local curSelectCount = 0

	for i, v in ipairs(self._resultList) do
		if self:_selectResult(v.resultId) == true then
			curSelectCount = curSelectCount + 1
		end

		if maxNum <= curSelectCount then
			break
		end
	end
end

function EquipTupoOneKeyView:_isCanSelect(resultId)
	local resultInfo = self._resultList[resultId]
	local mainEquip = resultInfo.mainEquip
	local configId = mainEquip:getDefineId()

	if #self._costEquipMap[configId] < #resultInfo.costMoList then
		return false, EQUIP_NOT_ENOUGH
	end

	if self._haveMatExp - self._costExp < resultInfo.costExp then
		return false, EXP_NOT_ENOUGH
	end

	if not MaterialModel.instance:IsEnough(MatType.Coin, 1, self._costCoin + resultInfo.costCoin) then
		return false, COIN_NOT_ENOUGH
	end

	if not string.nilorempty(resultInfo.costItem) then
		local matType, matId, matNum = MaterialMgr.getMatParams(resultInfo.costItem)
		local matKey = string.format("%s:%s", matType, matId)

		if not self._costMat[matKey] then
			if not MaterialModel.instance:IsEnough(matType, matId, matNum + self._costMat[matKey]) then
				return false, MAT_NOT_ENOUGH
			end
		end
	end

	local maxNum = checknumber(EquipmentConfig.instance:getCommonValue("MAX_BATCH_BREAKOUT_COUNT"))
	local selectCount = 0

	for i, v in pairs(self._selectMap) do
		if v == true then
			selectCount = selectCount + 1
		end
	end

	if maxNum <= selectCount then
		return false, SELECT_NOT_ENOUGH
	end

	return true, nil
end

function EquipTupoOneKeyView:_selectResult(resultId)
	local resultInfo = self._resultList[resultId]
	local mainEquip = resultInfo.mainEquip
	local configId = mainEquip:getDefineId()
	local needMoCount = #resultInfo.costMoList

	if not self:_isCanSelect(resultId) then
		return false
	end

	for i = 1, needMoCount do
		resultInfo.costMoList[i] = table.remove(self._costEquipMap[configId])
	end

	self._costExp = self._costExp + resultInfo.costExp
	self._costCoin = self._costCoin + resultInfo.costCoin

	if resultInfo.costItem then
		local matType, matId, matNum = MaterialMgr.getMatParams(resultInfo.costItem)
		local matKey = string.format("%s:%s", matType, matId)

		self._costMat[matKey] = checknumber(self._costMat[matKey]) + matNum
	end

	self._selectMap[resultId] = true

	return true
end

function EquipTupoOneKeyView:_cancelResult(resultId)
	if not self._selectMap[resultId] then
		return false
	end

	local resultInfo = self._resultList[resultId]
	local mainEquip = resultInfo.mainEquip
	local configId = mainEquip:getDefineId()

	for i, v in ipairs(resultInfo.costMoList) do
		table.insert(self._costEquipMap[configId], v)
	end

	self._costExp = self._costExp - resultInfo.costExp
	self._costCoin = self._costCoin - resultInfo.costCoin

	if resultInfo.costItem then
		local matType, matId, matNum = MaterialMgr.getMatParams(resultInfo.costItem)
		local matKey = string.format("%s:%s", matType, matId)

		self._costMat[matKey] = checknumber(self._costMat[matKey]) - matNum
	end

	self._selectMap[resultId] = nil
end

function EquipTupoOneKeyView:_resetAllResult()
	for k, v in pairs(self._selectMap) do
		if v == true then
			self:_cancelResult(k)
		end
	end

	self._selectMap = {}
end

function EquipTupoOneKeyView:_onFilterTypeChange(typeList)
	self._filterType = typeList

	self:_resetAllResult()
	self:_refreshView()
end

function EquipTupoOneKeyView:_onFilterJobChange(jobTypeList)
	self._filterJob = jobTypeList

	self:_resetAllResult()
	self:_refreshView()
end

function EquipTupoOneKeyView:_onClickFilter()
	UIStateManager.instance:open(ViewName.EquipOneKeyFilterView, {
		typeList = self._filterType,
		jobList = self._filterJob,
		itemGo = self._btnSifter
	})
end

function EquipTupoOneKeyView:getTupoRightEquip(infoMo)
	if infoMo == nil then
		return nil
	end

	local tupoList

	if infoMo:isEquipArtifact() then
		tupoList = EquipmentConfig.instance:GetTupoGropCfgs(infoMo.wearPos, infoMo.sqSkinId)
	else
		local jobStr = table.concat(infoMo.jobTypeList, ",")

		tupoList = EquipmentConfig.instance:GetTupoGropCfgs(infoMo.wearPos, jobStr)
	end

	local baseId = 0
	local isSameAttr = true

	for _, cfg in pairs(tupoList or {}) do
		if cfg and cfg.beforeNum == infoMo.afterNum and (isSameAttr and infoMo.attrType == cfg.attr or isSameAttr == false and string.nilorempty(cfg.attr)) then
			baseId = cfg.baseId

			break
		end
	end

	if baseId <= 0 then
		return nil
	end

	local tempMo = PetEquipModel.instance:GetTemporaryEquip(baseId, 0, infoMo)

	tempMo.equipPetId = infoMo.equipPetId

	return tempMo
end

function EquipTupoOneKeyView:_onClickSelect(resultId)
	if self._selectMap[resultId] == true then
		self:_cancelResult(resultId)
		self:_refreshView()
	else
		local canSelectResult, type = self:_isCanSelect(resultId)

		if canSelectResult == false then
			if type == EQUIP_NOT_ENOUGH then
				FloatWordMgr.instance:show(lang("装备不足"))
			elseif type == EXP_NOT_ENOUGH then
				FloatWordMgr.instance:show(lang("经验材料不足"))
			elseif type == COIN_NOT_ENOUGH then
				FloatWordMgr.instance:show(lang("金币不足"))
			elseif type == MAT_NOT_ENOUGH then
				FloatWordMgr.instance:show(lang("突破材料不足"))
			elseif type == SELECT_NOT_ENOUGH then
				FloatWordMgr.instance:show(lang("已达可选数量限制"))
			end
		else
			self:_selectResult(resultId)
			self:_refreshView()
		end
	end
end

function EquipTupoOneKeyView:_onClickSure()
	if PasswordLockController.instance:checkNeedOpenVerifyView() then
		return
	end

	local selectList = {}
	local sttMatList = EquipmentConfig.instance:GetStrengtheningMaterial()
	local costExpMatNum = {}
	local isEnoughMatNum = true

	for i, v in pairs(self._selectMap) do
		if v == true then
			local selectInfo = {}

			selectInfo.resultInfo = self._resultList[i]

			local curUseItem = {}
			local needExp = selectInfo.resultInfo.costExp

			for j, matInfo in ipairs(sttMatList) do
				local hasMatNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, matInfo.matId)
				local needCount = math.ceil(needExp / matInfo.matExp)
				local count = hasMatNum - checknumber(costExpMatNum[matInfo.matId])

				if count < needCount then
					needExp = needExp - count * matInfo.matExp
					costExpMatNum[matInfo.matId] = checknumber(costExpMatNum[matInfo.matId]) + count
					curUseItem[matInfo.matId] = checknumber(curUseItem[matInfo.matId]) + count
				else
					needExp = 0
					costExpMatNum[matInfo.matId] = checknumber(costExpMatNum[matInfo.matId]) + needCount
					curUseItem[matInfo.matId] = checknumber(curUseItem[matInfo.matId]) + needCount
				end

				if needExp == 0 then
					break
				end
			end

			if needExp > 0 then
				isEnoughMatNum = false

				break
			end

			selectInfo.useItem = curUseItem
			selectInfo.useCoin = selectInfo.resultInfo.costCoin

			table.insert(selectList, selectInfo)
		end
	end

	if isEnoughMatNum == false then
		FloatWordMgr.instance:show(lang("道具不足，未能全部进化，请再次提交选项"))
	end

	local costCoin = self._costCoin

	if self._isAutoMaxLevel == true and isEnoughMatNum == true then
		for i, v in ipairs(selectList) do
			if v.resultInfo.result.quality >= 10 then
				local planList = EquipmentConfig.instance:GetEquipLevelInfos(v.resultInfo.result.attrPlan)

				if planList == nil then
					return 0
				end

				local lastIndex = 0

				while planList[lastIndex] do
					lastIndex = lastIndex + 1
				end

				lastIndex = lastIndex - 1

				if lastIndex < 0 or planList[lastIndex] == nil then
					return 0
				end

				local needExp = planList[lastIndex].exp
				local coinCount = MaterialModel.instance:getMaterialsNumber(MatType.Coin, 1) - costCoin
				local curUseItem = {}
				local curUseCoin = 0

				for j, matInfo in ipairs(sttMatList) do
					local hasMatNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, matInfo.matId)
					local count = hasMatNum - checknumber(costExpMatNum[matInfo.matId])
					local needCount = math.ceil(needExp / matInfo.matExp)
					local coinCanUseCount = math.floor(coinCount / (matInfo.matExp * v.resultInfo.result.expCoinRatio))

					count = math.min(count, needCount)

					local useCount = math.min(count, coinCanUseCount)

					needExp = needExp - useCount * matInfo.matExp
					costExpMatNum[matInfo.matId] = checknumber(costExpMatNum[matInfo.matId]) + useCount
					curUseItem[matInfo.matId] = checknumber(curUseItem[matInfo.matId]) + useCount

					local useCoin = 0

					useCoin = needExp >= 0 and useCount * matInfo.matExp * v.resultInfo.result.expCoinRatio or useCount * matInfo.matExp + needExp * v.resultInfo.result.expCoinRatio
					coinCount = coinCount - useCoin
					curUseCoin = curUseCoin + useCoin

					if needExp == 0 then
						break
					end
				end

				v.isMaxLevel = true
				v.useItem = v.useItem or {}

				for id, num in pairs(curUseItem) do
					v.useItem[id] = checknumber(v.useItem[id]) + num
				end

				v.useCoin = v.useCoin + curUseCoin
				costCoin = costCoin + curUseCoin

				if needExp > 0 then
					isEnoughMatNum = false
				end
			end
		end
	end

	if isEnoughMatNum == false then
		FloatWordMgr.instance:show(lang("道具不足，未能升至满级"))
	end

	if #selectList > 0 then
		UIStateManager.instance:push(ViewName.EquipTupoOneKeyConfirmView, selectList)
	else
		FloatWordMgr.instance:show(lang("无可操作对象"))
	end
end

function EquipTupoOneKeyView:_onClickAutoMaxLevel()
	self._isAutoMaxLevel = not self._isAutoMaxLevel

	GameUtil.SetActive(self._tagAuto, self._isAutoMaxLevel)
end

function EquipTupoOneKeyView:_EQM_BatchBreakoutRes()
	self._resultList = {}
	self._selectMap = {}
	self._costExp = 0
	self._costCoin = 0
	self._costMat = {}

	self:_calcResult()
	self:_autoSelect()
	self:_refreshView()
end

return EquipTupoOneKeyView
