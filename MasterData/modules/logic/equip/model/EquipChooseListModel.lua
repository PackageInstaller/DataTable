-- chunkname: @modules/logic/equip/model/EquipChooseListModel.lua

module("modules.logic.equip.model.EquipChooseListModel", package.seeall)

local EquipChooseListModel = class("EquipChooseListModel", ListScrollModel)

function EquipChooseListModel:onInit()
	self._chooseEquipDic = {}
	self._chooseEquipList = {}
	self._maxCount = EquipEnum.StrengthenMaxCount
end

function EquipChooseListModel:reInit()
	self:onInit()
end

function EquipChooseListModel:initEquipMo(targetMO, resetSort)
	self._targetMO = targetMO
	self._config = self._targetMO.config

	if resetSort then
		self:resetSortStatus()
	end
end

function EquipChooseListModel:updateStrengthenList()
	self:initEquipList()
	self:_onChooseChange()
end

function EquipChooseListModel:updateStrengthenListAndRefresh()
	self:updateStrengthenList()
	self:setEquipList()
end

function EquipChooseListModel:initEquipList(filterMo, keepNum)
	self.filterMo = filterMo
	self._equipList = {}

	self:getEquipList(self._equipList, keepNum)
	self:filterEquip()
	self:filterStrengthen(self._equipList)
end

function EquipChooseListModel:filterEquip()
	if not self.filterMo then
		return
	end

	local equipList = {}

	for _, equipMo in ipairs(self._equipList) do
		if equipMo.config and self.filterMo:checkIsIncludeTag(equipMo.config) then
			table.insert(equipList, equipMo)
		end
	end

	self._equipList = equipList
end

function EquipChooseListModel:getEquipList(equipList, keepNum, maxRare)
	local list = EquipModel.instance:getEquips()

	for i, v in ipairs(list) do
		v._chooseNum = v._chooseNum or 0

		if not keepNum then
			v._chooseNum = 0
		end

		local co = v.config

		if co and v.id ~= self._targetMO.id and not EquipHelper.isSpRefineEquip(co) and v.equipId ~= EquipConfig.instance:getEquipUniversalId() then
			if maxRare then
				if maxRare > co.rare then
					table.insert(equipList, v)
				end
			else
				table.insert(equipList, v)
			end
		end
	end
end

function EquipChooseListModel:setEquipList()
	self:setList(self._equipList)
end

function EquipChooseListModel:resetSelectedEquip()
	self._chooseEquipDic = {}
	self._chooseEquipList = {}

	self:_onChooseChange()
end

function EquipChooseListModel:getChooseNum()
	local num = 0

	if not self._chooseEquipList then
		return num
	end

	for i, v in ipairs(self._chooseEquipList) do
		num = num + v._chooseNum
	end

	return num
end

function EquipChooseListModel:getChooseEquipsNum()
	return (self._chooseEquipList or nil) and (#self._chooseEquipList or 0)
end

function EquipChooseListModel:_selectEquip(equipMO)
	if equipMO._chooseNum >= equipMO.count then
		return EquipEnum.ChooseEquipStatus.BeyondEquipHadNum
	end

	if equipMO._chooseNum <= 0 and self:getChooseEquipsNum() >= self._maxCount then
		return EquipEnum.ChooseEquipStatus.BeyondMaxSelectEquip
	end

	local addexp = self:calcStrengthen()

	addexp = addexp or 0

	local currentLv = EquipConfig.instance:getStrengthenToLv(self._config.rare, self._targetMO.level, self._targetMO.exp + addexp)

	if currentLv >= EquipConfig.instance:getCurrentBreakLevelMaxLevel(self._targetMO) then
		return EquipEnum.ChooseEquipStatus.BeyondMaxStrengthenExperience
	end

	if equipMO._chooseNum == 0 then
		table.insert(self._chooseEquipList, equipMO)
	end

	equipMO._chooseNum = equipMO._chooseNum + 1
	self._chooseEquipDic[equipMO.id] = true

	return EquipEnum.ChooseEquipStatus.Success
end

function EquipChooseListModel:selectEquip(equipMO)
	if self.isLock then
		return EquipEnum.ChooseEquipStatus.Lock
	end

	local status = self:_selectEquip(equipMO)

	if status == EquipEnum.ChooseEquipStatus.Success then
		self:_onChooseChange()
	end

	return status
end

function EquipChooseListModel:deselectEquip(equipMO)
	if self.isLock then
		return EquipEnum.ChooseEquipStatus.Lock
	end

	if not equipMO._chooseNum or equipMO._chooseNum <= 0 then
		return EquipEnum.ChooseEquipStatus.ReduceNotSelectedEquip
	end

	equipMO._chooseNum = equipMO._chooseNum - 1

	if equipMO._chooseNum == 0 then
		for i, v in ipairs(self._chooseEquipList) do
			if v.id == equipMO.id then
				equipMO._isBreak = false
				equipMO._canBreak = nil

				table.remove(self._chooseEquipList, i)

				break
			end
		end
	end

	self._chooseEquipDic[equipMO.id] = equipMO._chooseNum > 0

	self:_onChooseChange()

	return EquipEnum.ChooseEquipStatus.Success
end

function EquipChooseListModel:calcStrengthen()
	local addExp = 0

	if not self._targetMO then
		return addExp
	end

	for i, v in ipairs(self._chooseEquipList) do
		for j = 1, v._chooseNum do
			addExp = addExp + EquipConfig.instance:getIncrementalExp(v)
		end
	end

	return addExp
end

function EquipChooseListModel:_onChooseChange()
	EquipSelectedListModel.instance:updateList(self._chooseEquipList)
	EquipController.instance:dispatchEvent(EquipEvent.onChooseChange)
end

function EquipChooseListModel:getChooseEquipList()
	return self._chooseEquipList
end

function EquipChooseListModel:isChoose(equipMO)
	return self._chooseEquipDic[equipMO.id]
end

function EquipChooseListModel:canBreak(equipMO)
	return EquipConfig.instance:canBreak(self._targetMO, equipMO)
end

function EquipChooseListModel._sortNormalEquip(a, b)
	if a.config.rare ~= b.config.rare then
		return a.config.rare < b.config.rare
	else
		return a.id < b.id
	end
end

function EquipChooseListModel._sortExpEquip(a, b)
	local rareA = a.config.rare
	local rareB = b.config.rare

	if rareA ~= rareB then
		return rareA < rareB
	else
		return a.config.id < b.config.id
	end
end

function EquipChooseListModel:canFastAdd(equipMo)
	if equipMo.isLock then
		return false
	end

	if self.equipUidToHeroMo and self.equipUidToHeroMo[equipMo.uid] then
		return false
	end

	if equipMo.level > 1 or equipMo.refineLv > 1 then
		return false
	end

	return true
end

function EquipChooseListModel:onlyAddExpEquip(expEquipList, needExp)
	self._chooseEquipDic = {}
	self._chooseEquipList = {}

	for index, equipMO in ipairs(expEquipList) do
		if index > EquipEnum.StrengthenMaxCount then
			break
		end

		local oneExp = EquipConfig.instance:getOneLevelEquipProduceExp(equipMO.equipId)
		local exp = equipMO.count * oneExp

		if needExp <= exp then
			local minNeedCount = Mathf.Ceil(needExp / oneExp)

			self:addEquipMo(equipMO, minNeedCount)

			break
		end

		needExp = needExp - exp

		self:addEquipMo(equipMO, equipMO.count)
	end
end

function EquipChooseListModel:onlyAddNormalEquip(normalEquipList, needExp)
	local addExp = 0

	self._chooseEquipDic = {}
	self._chooseEquipList = {}

	for index, equipMO in ipairs(normalEquipList) do
		if index > EquipEnum.StrengthenMaxCount then
			break
		end

		local exp = EquipConfig.instance:getOneLevelEquipProduceExp(equipMO.config.rare)

		addExp = addExp + exp

		self:addEquipMo(equipMO, 1)

		if needExp <= addExp then
			break
		end
	end
end

function EquipChooseListModel:mixtureExpAndNormalEquip(expEquipList, normalEquipList, needExp)
	self._chooseEquipDic = {}
	self._chooseEquipList = {}

	local firstExpEquipMo = expEquipList[1]
	local firstExpEquipExp = EquipConfig.instance:getOneLevelEquipProduceExp(firstExpEquipMo.equipId)

	if needExp <= firstExpEquipExp then
		self:addEquipMo(firstExpEquipMo, 1)

		return
	end

	needExp = needExp - firstExpEquipExp

	local frameCount = 0
	local maxFrameCount = EquipEnum.StrengthenMaxCount - 1

	for _, equipMO in ipairs(normalEquipList) do
		local exp = EquipConfig.instance:getOneLevelEquipProduceExp(equipMO.config.rare)

		self:addEquipMo(equipMO, 1)

		frameCount = frameCount + 1
		needExp = needExp - exp

		if maxFrameCount <= frameCount or needExp <= 0 then
			break
		end
	end

	local expIndex = 0

	if needExp > 0 then
		needExp = needExp + firstExpEquipExp

		for _, equipMo in ipairs(expEquipList) do
			local oneExp = EquipConfig.instance:getOneLevelEquipProduceExp(equipMo.equipId)

			frameCount = frameCount + 1
			expIndex = expIndex + 1

			local exp = equipMo.count * oneExp

			if needExp <= exp then
				self:addEquipMo(equipMo, Mathf.Ceil(needExp / oneExp), expIndex)

				break
			end

			self:addEquipMo(equipMo, equipMo.count, expIndex)

			needExp = needExp - exp

			if frameCount >= EquipEnum.StrengthenMaxCount then
				break
			end
		end
	else
		self:addEquipMo(firstExpEquipMo, 1, 1)
	end
end

function EquipChooseListModel:addEquipMo(equipMo, count, insertIndex)
	equipMo._chooseNum = count
	self._chooseEquipDic[equipMo.id] = true

	if not tabletool.indexOf(self._chooseEquipList, equipMo) then
		if insertIndex then
			table.insert(self._chooseEquipList, insertIndex, equipMo)
		else
			table.insert(self._chooseEquipList, equipMo)
		end
	end
end

function EquipChooseListModel:fastAddEquip()
	local needExp = EquipConfig.instance:getNeedExpToMaxLevel(self._targetMO)

	if needExp <= 0 then
		GameFacade.showToast(ToastEnum.MaxLevEquips)

		return
	end

	self._chooseEquipDic = {}
	self._chooseEquipList = {}

	local equipList = {}

	self:getEquipList(equipList, false, self:getFilterRare())

	local expEquipList = {}
	local normalEquipList = {}
	local isEmpty = true

	for _, equipMo in ipairs(equipList) do
		if EquipHelper.isExpEquip(equipMo.config) then
			table.insert(expEquipList, equipMo)

			isEmpty = false
		elseif EquipHelper.isNormalEquip(equipMo.config) and self:canFastAdd(equipMo) then
			table.insert(normalEquipList, equipMo)

			isEmpty = false
		end
	end

	if isEmpty then
		self:refreshEquip()
		GameFacade.showToast(ToastEnum.NoFastEquips)

		return
	end

	local expEquipCount = #expEquipList
	local normalEquipCount = #normalEquipList

	if expEquipCount ~= 0 then
		table.sort(expEquipList, EquipChooseListModel._sortExpEquip)
	end

	if normalEquipCount ~= 0 then
		table.sort(normalEquipList, EquipChooseListModel._sortNormalEquip)
	end

	if normalEquipCount == 0 then
		self:onlyAddExpEquip(expEquipList, needExp)
	elseif expEquipCount == 0 then
		self:onlyAddNormalEquip(normalEquipList, needExp)
	else
		self:mixtureExpAndNormalEquip(expEquipList, normalEquipList, needExp)
	end

	self:refreshEquip()
end

function EquipChooseListModel:refreshEquip()
	EquipController.instance:dispatchEvent(EquipEvent.onChooseEquip)
	self:_onChooseChange()
	self:setList(self._equipList)

	local showEffectTab = {}

	for _, v in ipairs(self._chooseEquipList) do
		table.insert(showEffectTab, v.uid)
	end

	EquipController.instance:dispatchEvent(EquipEvent.onAddEquipToPlayEffect, showEffectTab)
end

function EquipChooseListModel._sortNormal(a, b)
	local self = EquipChooseListModel.instance
	local result = self:sortChoose(a, b)

	if result == nil then
		result = self:sortSame(a, b)
	end

	if result == nil then
		result = self:sortQuality(a, b)
	end

	if result == nil then
		result = self:sortExp(a, b)
	end

	if result == nil then
		result = self:sortLevel(a, b)
	end

	if result == nil then
		result = self:sortId(a, b)
	end

	return result
end

function EquipChooseListModel._sortMaxLevel(a, b)
	local self = EquipChooseListModel.instance
	local result = self:sortChoose(a, b)

	if result == nil then
		result = self:sortLevel(a, b)
	end

	if result == nil then
		result = self:sortId(a, b)
	end

	return result
end

function EquipChooseListModel._sortMaxBreak(a, b)
	local self = EquipChooseListModel.instance
	local result = self:sortChoose(a, b)

	if result == nil then
		result = self:sortQuality(a, b)
	end

	if result == nil then
		result = self:sortExp(a, b)
	end

	if result == nil then
		result = self:sortLevel(a, b)
	end

	if result == nil then
		result = self:sortId(a, b)
	end

	return result
end

function EquipChooseListModel:filterStrengthen(equipList)
	if self._btnTag == 1 then
		table.sort(equipList, EquipHelper.sortByLevelFuncChooseListModel)
	else
		table.sort(equipList, EquipHelper.sortByQualityFuncChooseListModel)
	end
end

function EquipChooseListModel:sortId(a, b)
	local valueA = a.config.id
	local valueB = b.config.id

	if valueA == valueB then
		return false
	end

	return valueA < valueB
end

function EquipChooseListModel:sortLevel(a, b)
	local valueA = a.level
	local valueB = b.level

	if valueA == valueB then
		return nil
	end

	if self._levelAscend then
		return valueA < valueB
	else
		return valueB < valueA
	end
end

function EquipChooseListModel:sortExp(a, b)
	local valueA = a.config.isExpEquip
	local valueB = b.config.isExpEquip

	if valueA == valueB then
		return nil
	end

	return valueB < valueA
end

function EquipChooseListModel:sortQuality(a, b)
	local qualityA = a.config.rare
	local qualityB = b.config.rare

	if qualityA == qualityB then
		return nil
	end

	if self._qualityAscend then
		return qualityA < qualityB
	else
		return qualityB < qualityA
	end
end

function EquipChooseListModel:sortSame(a, b)
	local sameA = a.config.id == self._config.id
	local sameB = b.config.id == self._config.id

	if sameA and sameB then
		return nil
	end

	if sameA then
		return true
	end

	if sameB then
		return false
	end
end

function EquipChooseListModel:sortChoose(a, b)
	local chooseA = self._chooseEquipDic[a.id]
	local chooseB = self._chooseEquipDic[b.id]

	if chooseA and chooseB then
		return nil
	end

	if chooseA then
		return true
	end

	if chooseB then
		return false
	end
end

function EquipChooseListModel:getBtnTag()
	return self._btnTag
end

function EquipChooseListModel:getRankState()
	return self._levelAscend and 1 or -1, self._qualityAscend and 1 or -1
end

function EquipChooseListModel:sordByLevel()
	self:resetQualitySortStatus()

	if self._btnTag == 1 then
		self._levelAscend = not self._levelAscend
	else
		self._btnTag = 1
	end

	self:filterStrengthen(self._equipList)
	self:setList(self._equipList)
end

function EquipChooseListModel:sordByQuality()
	self:resetLevelSortStatus()

	if self._btnTag == 2 then
		self._qualityAscend = not self._qualityAscend
	else
		self._btnTag = 2
	end

	self:filterStrengthen(self._equipList)
	self:setList(self._equipList)
end

function EquipChooseListModel:clearEquipList()
	local list = EquipModel.instance:getEquips()

	for i, v in ipairs(list) do
		v._canBreak = nil
		v._isBreak = nil
	end

	self._equipList = {}
	self._chooseEquipDic = {}
	self._chooseEquipList = {}
	self._targetMO = nil
end

function EquipChooseListModel:equipInTeam(uid)
	if not self._allInTeamEquips then
		self._allInTeamEquips = {}

		local groupMO = HeroGroupModel.instance:getCurGroupMO()

		if groupMO then
			local equips = groupMO:getAllPosEquips()

			for pos, v in pairs(equips) do
				for _, uid in pairs(v.equipUid) do
					local groupList = self._allInTeamEquips[uid]

					if not groupList then
						groupList = {}
						self._allInTeamEquips[uid] = groupList
					end

					table.insert(groupList, {
						1,
						pos + 1
					})
				end
			end
		end
	end

	return self._allInTeamEquips[uid]
end

function EquipChooseListModel:clearTeamInfo()
	self._allInTeamEquips = nil
end

function EquipChooseListModel:openEquipView()
	self.equipUidToHeroMo = {}
	self.equipUidToInGroup = {}

	local groupMO = HeroGroupModel.instance:getMainGroupMo()
	local groupAllEquips = groupMO:getAllPosEquips()
	local heroUidList = groupMO.heroList

	for index, heroGroupEquipMO in pairs(groupAllEquips) do
		self.equipUidToHeroMo[heroGroupEquipMO.equipUid[1]] = HeroModel.instance:getById(heroUidList[index + 1])
		self.equipUidToInGroup[heroGroupEquipMO.equipUid[1]] = true
	end

	self:resetSortStatus()
end

function EquipChooseListModel:getHeroMoByEquipUid(equipUid)
	return self.equipUidToHeroMo and self.equipUidToHeroMo[equipUid]
end

function EquipChooseListModel:isInGroup(equipUid)
	return self.equipUidToInGroup and self.equipUidToInGroup[equipUid]
end

function EquipChooseListModel:resetSortStatus()
	self._btnTag = 1

	self:resetLevelSortStatus()
	self:resetQualitySortStatus()
end

function EquipChooseListModel:resetLevelSortStatus()
	self._levelAscend = false
end

function EquipChooseListModel:resetQualitySortStatus()
	self._qualityAscend = false
end

function EquipChooseListModel:getFilterRare()
	self.filterRare = self.filterRare or EquipConfig.instance:getMinFilterRare()

	logNormal("EquipChooseListModel : get filter rare : " .. tostring(self.filterRare))

	return self.filterRare
end

function EquipChooseListModel:setFilterRare(rare)
	logNormal("EquipChooseListModel : set filter rare : " .. tostring(rare))

	self.filterRare = rare
end

function EquipChooseListModel:setIsLock(isLock)
	self.isLock = isLock
end

function EquipChooseListModel:clear()
	self.equipUidToHeroMo = {}
	self.equipUidToInGroup = {}
end

EquipChooseListModel.instance = EquipChooseListModel.New()

return EquipChooseListModel
