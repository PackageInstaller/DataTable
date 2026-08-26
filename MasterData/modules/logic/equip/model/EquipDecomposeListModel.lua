-- chunkname: @modules/logic/equip/model/EquipDecomposeListModel.lua

module("modules.logic.equip.model.EquipDecomposeListModel", package.seeall)

local EquipDecomposeListModel = class("EquipDecomposeListModel", ListScrollModel)

function EquipDecomposeListModel:onInit()
	return
end

function EquipDecomposeListModel:reInit()
	return
end

EquipDecomposeListModel.SortTag = {
	Rare = 2,
	Level = 1
}
EquipDecomposeListModel.DefaultFilterRare = 4

function EquipDecomposeListModel:checkEquipCanDecompose(equipMo)
	if not equipMo then
		return false
	end

	if equipMo.level > 1 then
		return false
	end

	local equipCo = equipMo.config

	if not EquipHelper.isNormalEquip(equipCo) then
		return false
	end

	if equipCo.rare >= EquipDecomposeListModel.DefaultFilterRare then
		return false
	end

	if not self.filterMo then
		return true
	end

	return self.filterMo:checkIsIncludeTag(equipMo.config)
end

function EquipDecomposeListModel:getSortTag()
	return self.sortTag
end

function EquipDecomposeListModel:getSortIsAscend(sortTag)
	if sortTag == EquipDecomposeListModel.SortTag.Level then
		return self.levelAscend
	else
		return self.rareAscend
	end
end

function EquipDecomposeListModel:isEmpty()
	return #self.equipList == 0
end

function EquipDecomposeListModel:getEquipData()
	if self.equipList then
		tabletool.clear(self.equipList)
	else
		self.equipList = {}
	end

	for _, equipMo in ipairs(EquipModel.instance:getEquips()) do
		if self:checkEquipCanDecompose(equipMo) then
			table.insert(self.equipList, equipMo)
		end
	end
end

function EquipDecomposeListModel:initEquipData()
	self.selectedEquipDict = {}
	self.selectedEquipCount = 0
	self.sortTag = EquipDecomposeListModel.SortTag.Rare

	self:resetLevelSortStatus()
	self:resetRareSortStatus()
	self:getEquipData()
	self:sortEquipList()
end

function EquipDecomposeListModel:updateEquipData(filterMo)
	self:clearSelectEquip()

	self.filterMo = filterMo

	self:getEquipData()
	self:sortEquipList()
end

function EquipDecomposeListModel:resetLevelSortStatus()
	self.levelAscend = false
end

function EquipDecomposeListModel:resetRareSortStatus()
	self.rareAscend = false
end

function EquipDecomposeListModel:changeLevelSortStatus()
	self.sortTag = EquipDecomposeListModel.SortTag.Level
	self.levelAscend = not self.levelAscend

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSortStatusChange)
end

function EquipDecomposeListModel:changeRareStatus()
	self.sortTag = EquipDecomposeListModel.SortTag.Rare
	self.rareAscend = not self.rareAscend

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSortStatusChange)
end

function EquipDecomposeListModel:sortEquipList()
	if self.sortTag == EquipDecomposeListModel.SortTag.Level then
		table.sort(self.equipList, EquipDecomposeListModel.sortByLv)
	else
		table.sort(self.equipList, EquipDecomposeListModel.sortByRare)
	end
end

function EquipDecomposeListModel.sortByLv(equipMoA, equipMoB)
	if equipMoA.level ~= equipMoB.level then
		if EquipDecomposeListModel.instance.levelAscend then
			return equipMoA.level < equipMoB.level
		else
			return equipMoA.level > equipMoB.level
		end
	end

	local configA, configB = equipMoA.config, equipMoB.config

	if configA.rare ~= configB.rare then
		if EquipDecomposeListModel.instance.rareAscend then
			return configA.rare < configB.rare
		else
			return configA.rare > configB.rare
		end
	end

	if configA.id ~= configB.id then
		return configA.id < configB.id
	end

	return equipMoA.id < equipMoB.id
end

function EquipDecomposeListModel.sortByRare(equipMoA, equipMoB)
	local configA, configB = equipMoA.config, equipMoB.config

	if configA.rare ~= configB.rare then
		if EquipDecomposeListModel.instance.rareAscend then
			return configA.rare < configB.rare
		else
			return configA.rare > configB.rare
		end
	end

	if equipMoA.level ~= equipMoB.level then
		if EquipDecomposeListModel.instance.levelAscend then
			return equipMoA.level < equipMoB.level
		else
			return equipMoA.level > equipMoB.level
		end
	end

	if configA.id ~= configB.id then
		return configA.id < configB.id
	end

	return equipMoA.id < equipMoB.id
end

function EquipDecomposeListModel:refreshEquip()
	self:setList(self.equipList)
end

function EquipDecomposeListModel:getSelectCount()
	return self.selectedEquipCount
end

function EquipDecomposeListModel:isSelect(equipUid)
	return self.selectedEquipDict[equipUid]
end

function EquipDecomposeListModel:selectEquipMo(equipMo)
	if self.selectedEquipCount >= EquipEnum.DecomposeMaxCount then
		return
	end

	if self.selectedEquipDict[equipMo.id] then
		return
	end

	self.selectedEquipDict[equipMo.id] = true
	self.selectedEquipCount = self.selectedEquipCount + 1

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSelectEquipChange)
end

function EquipDecomposeListModel:desSelectEquipMo(equipMo)
	if not self.selectedEquipDict[equipMo.id] then
		return
	end

	self.selectedEquipDict[equipMo.id] = nil
	self.selectedEquipCount = self.selectedEquipCount - 1

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSelectEquipChange)
end

function EquipDecomposeListModel:getDecomposeEquipCount()
	local exp = self:getAddExp()

	return math.floor(exp / 100)
end

function EquipDecomposeListModel:getAddExp()
	local addExp = 0

	if self.selectedEquipDict then
		for uid, _ in pairs(self.selectedEquipDict) do
			local equipMo = EquipModel.instance:getEquip(tostring(uid))

			addExp = addExp + EquipConfig.instance:getIncrementalExp(equipMo)
		end
	end

	return addExp
end

function EquipDecomposeListModel:fastAddEquip()
	tabletool.clear(self.selectedEquipDict)

	self.selectedEquipCount = 0

	for _, equipMo in ipairs(self.equipList) do
		if not equipMo.isLock then
			local config = equipMo.config

			if config.rare <= self.filterRare then
				self.selectedEquipCount = self.selectedEquipCount + 1
				self.selectedEquipDict[equipMo.id] = true
			end

			if self.selectedEquipCount >= EquipEnum.DecomposeMaxCount then
				break
			end
		end
	end

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSelectEquipChange)
end

function EquipDecomposeListModel:setFilterRare(filterRare)
	self.filterRare = filterRare
end

function EquipDecomposeListModel:clearSelectEquip()
	tabletool.clear(self.selectedEquipDict)

	self.selectedEquipCount = 0

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSelectEquipChange)
end

function EquipDecomposeListModel:clear()
	tabletool.clear(self.equipList)
	EquipDecomposeListModel.super.clear(self)
end

EquipDecomposeListModel.instance = EquipDecomposeListModel.New()

return EquipDecomposeListModel
