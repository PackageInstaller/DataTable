-- chunkname: @modules/logic/equip/model/EquipInfoBaseListModel.lua

module("modules.logic.equip.model.EquipInfoBaseListModel", package.seeall)

local EquipInfoBaseListModel = class("EquipInfoBaseListModel", ListScrollModel)

EquipInfoBaseListModel.SortBy = {
	Rare = 2,
	Level = 1
}
EquipInfoBaseListModel.levelAscend = false
EquipInfoBaseListModel.rareAscend = false

function EquipInfoBaseListModel:onInit()
	self.equipMoList = {}
	self.levelAscend = false
	self.rareAscend = false
	self.sortBy = EquipInfoBaseListModel.SortBy.Level
end

function EquipInfoBaseListModel:onOpen(viewParam)
	self:initEquipList()
end

function EquipInfoBaseListModel:initEquipList(filterMo)
	self.equipMoList = {}

	local isFilter = filterMo:isFiltering()

	for _, equipMo in ipairs(EquipModel.instance:getEquips()) do
		if EquipHelper.isNormalEquip(equipMo.config) then
			if isFilter then
				if filterMo:checkIsIncludeTag(equipMo.config) then
					table.insert(self.equipMoList, equipMo)
				end
			else
				table.insert(self.equipMoList, equipMo)
			end
		end
	end

	self:resortEquip()
end

function EquipInfoBaseListModel:refreshEquipList()
	self:setList(self.equipMoList)
end

function EquipInfoBaseListModel:isEmpty()
	if self.equipMoList then
		return #self.equipMoList == 0
	else
		return true
	end
end

function EquipInfoBaseListModel:resortEquip()
	EquipInfoBaseListModel.levelAscend = self.levelAscend
	EquipInfoBaseListModel.rareAscend = self.rareAscend

	if self.sortBy == EquipInfoBaseListModel.SortBy.Level then
		table.sort(self.equipMoList, self._sortByLevel)
	elseif self.sortBy == EquipInfoBaseListModel.SortBy.Rare then
		table.sort(self.equipMoList, self._sortByRare)
	else
		logError("not found sotBy : " .. tostring(self.sortBy))
		table.sort(self.equipMoList, self._sortByLevel)
	end
end

function EquipInfoBaseListModel:_changeSortByLevel()
	if self.sortBy == EquipInfoBaseListModel.SortBy.Level then
		self.levelAscend = not self.levelAscend
	else
		self.sortBy = EquipInfoBaseListModel.SortBy.Level
		self.levelAscend = false
	end
end

function EquipInfoBaseListModel:_changeSortByRare()
	if self.sortBy == EquipInfoBaseListModel.SortBy.Rare then
		self.rareAscend = not self.rareAscend
	else
		self.sortBy = EquipInfoBaseListModel.SortBy.Rare
		self.rareAscend = false
	end
end

function EquipInfoBaseListModel:changeSortByLevel()
	self:_changeSortByLevel()
	self:resortEquip()
	self:refreshEquipList()
end

function EquipInfoBaseListModel:changeSortByRare()
	self:_changeSortByRare()
	self:resortEquip()
	self:refreshEquipList()
end

function EquipInfoBaseListModel:isSortByLevel()
	return self.sortBy == EquipInfoBaseListModel.SortBy.Level
end

function EquipInfoBaseListModel:isSortByRare()
	return self.sortBy == EquipInfoBaseListModel.SortBy.Rare
end

function EquipInfoBaseListModel:getSortState()
	return self.levelAscend and 1 or -1, self.rareAscend and 1 or -1
end

function EquipInfoBaseListModel._sortByLevel(equipMoA, equipMoB)
	local sortResult, sorted = EquipHelper.typeSort(equipMoA.config, equipMoB.config)

	if sorted then
		return sortResult
	end

	if equipMoA.equipType == EquipEnum.ClientEquipType.TrialEquip ~= (equipMoB.equipType == EquipEnum.ClientEquipType.TrialEquip) then
		return equipMoA.equipType == EquipEnum.ClientEquipType.TrialEquip
	end

	if equipMoA.recommondIndex and equipMoB.recommondIndex and equipMoA.recommondIndex ~= equipMoB.recommondIndex then
		if equipMoA.recommondIndex < 0 or equipMoB.recommondIndex < 0 then
			return equipMoA.recommondIndex > 0
		end

		return equipMoA.recommondIndex < equipMoB.recommondIndex
	end

	if equipMoA.level ~= equipMoB.level then
		if EquipInfoBaseListModel.levelAscend then
			return equipMoA.level < equipMoB.level
		else
			return equipMoA.level > equipMoB.level
		end
	end

	if equipMoA.config.rare ~= equipMoB.config.rare then
		if EquipInfoBaseListModel.rareAscend then
			return equipMoA.config.rare < equipMoB.config.rare
		else
			return equipMoA.config.rare > equipMoB.config.rare
		end
	end

	if equipMoA.equipId ~= equipMoB.equipId then
		return equipMoA.equipId > equipMoB.equipId
	end

	return equipMoA.id < equipMoB.id
end

function EquipInfoBaseListModel._sortByRare(equipMoA, equipMoB)
	local sortResult, sorted = EquipHelper.typeSort(equipMoA.config, equipMoB.config)

	if sorted then
		return sortResult
	end

	if equipMoA.equipType == EquipEnum.ClientEquipType.TrialEquip ~= (equipMoB.equipType == EquipEnum.ClientEquipType.TrialEquip) then
		return equipMoA.equipType == EquipEnum.ClientEquipType.TrialEquip
	end

	if equipMoA.recommondIndex and equipMoB.recommondIndex and equipMoA.recommondIndex ~= equipMoB.recommondIndex then
		if equipMoA.recommondIndex < 0 or equipMoB.recommondIndex < 0 then
			return equipMoA.recommondIndex > 0
		end

		return equipMoA.recommondIndex < equipMoB.recommondIndex
	end

	if equipMoA.config.rare ~= equipMoB.config.rare then
		if EquipInfoBaseListModel.rareAscend then
			return equipMoA.config.rare < equipMoB.config.rare
		else
			return equipMoA.config.rare > equipMoB.config.rare
		end
	end

	if equipMoA.level ~= equipMoB.level then
		if EquipInfoBaseListModel.levelAscend then
			return equipMoA.level < equipMoB.level
		else
			return equipMoA.level > equipMoB.level
		end
	end

	if equipMoA.equipId ~= equipMoB.equipId then
		return equipMoA.equipId > equipMoB.equipId
	end

	return equipMoA.id < equipMoB.id
end

function EquipInfoBaseListModel:setCurrentSelectEquipMo(equipMo)
	self.currentSelectEquipMo = equipMo
end

function EquipInfoBaseListModel:getCurrentSelectEquipMo()
	return self.currentSelectEquipMo
end

function EquipInfoBaseListModel:isSelectedEquip(equipUid)
	return self.currentSelectEquipMo and self.currentSelectEquipMo.uid == equipUid
end

function EquipInfoBaseListModel:clearRecommend()
	if not EquipModel.instance:getEquips() then
		return
	end

	for _, equipMo in ipairs(EquipModel.instance:getEquips()) do
		equipMo:clearRecommend()
	end
end

function EquipInfoBaseListModel:clear()
	self:onInit()

	self.selectedEquipMo = nil

	self:clearRecommend()
end

return EquipInfoBaseListModel
