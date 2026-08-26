-- chunkname: @modules/logic/turnback/model/TurnbackPickEquipListModel.lua

module("modules.logic.turnback.model.TurnbackPickEquipListModel", package.seeall)

local TurnbackPickEquipListModel = class("TurnbackPickEquipListModel", MixScrollModel)

local function sortFunc(a, b)
	local aHas = 0
	local bHas = 0

	if EquipModel.instance:isLimitAndAlreadyHas(a.id) then
		aHas = 1
	end

	if EquipModel.instance:isLimitAndAlreadyHas(b.id) then
		bHas = 1
	end

	if aHas ~= bHas then
		return aHas < bHas
	end

	return a.id > b.id
end

function TurnbackPickEquipListModel:onInit()
	self._selectIdList = {}
	self._selectIdMap = {}
	self._pickChoiceMap = {}
	self.maxSelectCount = nil
	self._lastUnLock = nil
	self._lastUnlockEpisodeId = nil
	self._allPass = false
	self._arrcount = 0
end

function TurnbackPickEquipListModel:reInit()
	self:onInit()
end

function TurnbackPickEquipListModel:initData(effectArr, maxSelectCount)
	self:onInit()
	self:initList(effectArr)

	self.maxSelectCount = maxSelectCount or 1
end

function TurnbackPickEquipListModel:initList(effectArr)
	if not effectArr then
		return
	end

	local moList = {}

	self._arrcount = #effectArr

	local allLimit = true

	self._swapItemCo = string.splitToNumber(effectArr[1], "#")

	for index, value in ipairs(effectArr) do
		local mo = {}
		local temp = string.splitToNumber(value, "#")
		local type = temp[1]
		local id = temp[2]
		local num = temp[3]

		if type == MaterialEnum.MaterialType.Equip then
			mo.type = type
			mo.id = id
			mo.num = num
			mo.index = index - 2
			mo.config = EquipConfig.instance:getEquipCo(id)

			if not EquipModel.instance:isLimitAndAlreadyHas(id) then
				allLimit = false
			end

			table.insert(moList, mo)
		end
	end

	self._allLimit = allLimit

	table.sort(moList, sortFunc)
	self:setList(moList)
end

function TurnbackPickEquipListModel:setSelectId(equipId)
	if not self._selectIdList then
		return
	end

	if self._selectIdMap[equipId] then
		self._selectIdMap[equipId] = nil

		tabletool.removeValue(self._selectIdList, equipId)
	else
		self._selectIdMap[equipId] = true

		table.insert(self._selectIdList, equipId)
	end
end

function TurnbackPickEquipListModel:clearAllSelect()
	self._selectIdMap = {}
	self._selectIdList = {}
end

function TurnbackPickEquipListModel:getSelectIds()
	return self._selectIdList
end

function TurnbackPickEquipListModel:getSelectCount()
	if self._selectIdList then
		return #self._selectIdList
	end

	return 0
end

function TurnbackPickEquipListModel:isEquipIdSelected(equipId)
	if self._selectIdMap then
		return self._selectIdMap[equipId] ~= nil
	end

	return false
end

function TurnbackPickEquipListModel:getMaxSelectCount()
	return self.maxSelectCount
end

function TurnbackPickEquipListModel:checkAllLimit()
	return self._allLimit
end

function TurnbackPickEquipListModel:getSwapItemCo()
	return self._swapItemCo
end

TurnbackPickEquipListModel.instance = TurnbackPickEquipListModel.New()

return TurnbackPickEquipListModel
