-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/EliminateSelectChessMenListModel.lua

module("modules.logic.versionactivity2_2.eliminate.model.EliminateSelectChessMenListModel", package.seeall)

local EliminateSelectChessMenListModel = class("EliminateSelectChessMenListModel", MultiSortListScrollModel)

function EliminateSelectChessMenListModel:onInit()
	self:reInit()
end

function EliminateSelectChessMenListModel:reInit()
	self._initList = {}
	self._addList = {}
	self._presetList = {}
	self._selectedChessMen = nil
	self._quickEdit = nil
end

function EliminateSelectChessMenListModel:setQuickEdit(value)
	self._quickEdit = value
end

function EliminateSelectChessMenListModel:getQuickEdit()
	return self._quickEdit
end

function EliminateSelectChessMenListModel:getAddIds()
	local list = {}

	for i = 1, self._addMaxCount do
		local mo = self._addList[i]

		if mo then
			table.insert(list, mo.config.id)
		end
	end

	return list
end

function EliminateSelectChessMenListModel:isInAddList(mo)
	for i = 1, self._addMaxCount do
		if self._addList[i] == mo then
			return true
		end
	end
end

function EliminateSelectChessMenListModel:getAddChessMen(index)
	return self._addList[index]
end

function EliminateSelectChessMenListModel:getAddMaxCount()
	return self._addMaxCount
end

function EliminateSelectChessMenListModel:getAutoList()
	if #self._presetList > 0 then
		return self._presetList
	end

	local list = {}

	for i = 1, self._addMaxCount do
		local mo = self._initList[i]

		if mo and EliminateTeamSelectionModel.instance:hasChessPieceOrPreset(mo.config.id) then
			table.insert(list, mo.config.id)
		else
			break
		end
	end

	return list
end

function EliminateSelectChessMenListModel:canAddChessMen(mo)
	for i = 1, self._addMaxCount do
		if self._addList[i] == nil then
			return true
		end
	end
end

function EliminateSelectChessMenListModel:addSelectedChessMen(mo)
	tabletool.removeValue(self._initList, mo)

	for i = 1, self._addMaxCount do
		if self._addList[i] == nil then
			self._addList[i] = mo

			break
		end
	end

	self:_changeChessMen()
end

function EliminateSelectChessMenListModel:_removeListValue(list, value)
	for k, v in pairs(list) do
		if v == value then
			list[k] = nil

			break
		end
	end
end

function EliminateSelectChessMenListModel:removeSelectedChessMen(mo)
	self:_removeListValue(self._addList, mo)
	table.insert(self._initList, mo)
	self:_changeChessMen()
end

function EliminateSelectChessMenListModel:_changeChessMen()
	self:updateList()
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.ChangeChessMen)
end

function EliminateSelectChessMenListModel:setSelectedChessMen(mo)
	self._selectedChessMen = mo

	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.SelectChessMen)
end

function EliminateSelectChessMenListModel:getSelectedChessMen()
	return self._selectedChessMen
end

function EliminateSelectChessMenListModel._sortRare(a, b, ascending, instance)
	local aValue = a.config.level
	local bValue = b.config.level

	if aValue ~= bValue then
		if ascending then
			return aValue < bValue
		else
			return bValue < aValue
		end
	end
end

function EliminateSelectChessMenListModel._sortPower(a, b, ascending, instance)
	local aValue = a.config.defaultPower
	local bValue = b.config.defaultPower

	if aValue ~= bValue then
		if ascending then
			return aValue < bValue
		else
			return bValue < aValue
		end
	end
end

function EliminateSelectChessMenListModel._sortResource(a, b, ascending, instance)
	local aValue = a.costValue
	local bValue = b.costValue

	if aValue ~= bValue then
		if ascending then
			return aValue < bValue
		else
			return bValue < aValue
		end
	end
end

function EliminateSelectChessMenListModel._sortDefault(a, b, instance)
	return a.config.id < b.config.id
end

function EliminateSelectChessMenListModel._sortFirst(a, b, instance)
	local aValue = EliminateTeamSelectionModel.instance:hasChessPieceOrPreset(a.config.id)
	local bValue = EliminateTeamSelectionModel.instance:hasChessPieceOrPreset(b.config.id)

	if aValue ~= bValue then
		return aValue
	end
end

function EliminateSelectChessMenListModel:initList()
	self:initSort()
	self:addSortType(EliminateMapEnum.SortType.Rare, EliminateSelectChessMenListModel._sortRare)
	self:addSortType(EliminateMapEnum.SortType.Power, EliminateSelectChessMenListModel._sortPower)
	self:addSortType(EliminateMapEnum.SortType.Resource, EliminateSelectChessMenListModel._sortResource)
	self:addOtherSort(EliminateSelectChessMenListModel._sortFirst, EliminateSelectChessMenListModel._sortDefault)
	self:setCurSortType(EliminateMapEnum.SortType.Rare)

	self._addMaxCount = EliminateOutsideModel.instance:getUnlockSlotNum()
	self._initList = tabletool.copy(EliminateConfig.instance:getSoldierChessList())
	self._addList = {}
	self._presetList = {}

	self:_initPresetList()
	self:_initPrevSelectedChecss()
	self:_cleanList()
	self:updateList()
end

function EliminateSelectChessMenListModel:_cleanList()
	local map = {}

	for _, v in pairs(self._addList) do
		map[v.id] = true
	end

	local len = #self._initList

	for i = len, 1, -1 do
		local mo = self._initList[i]

		if map[mo.id] then
			table.remove(self._initList, i)
		end
	end
end

function EliminateSelectChessMenListModel:_initPrevSelectedChecss()
	if EliminateTeamSelectionModel.instance:isPreset() then
		return
	end

	local str = EliminateMapController.getPrefsString(EliminateMapEnum.PrefsKey.ChessSelected, "")
	local list = string.split(str, ",")

	for _, v in ipairs(list) do
		local paramList = string.split(v, "_")
		local index = tonumber(paramList[1])
		local id = tonumber(paramList[2])

		if index and id then
			local mo = EliminateConfig.instance:getSoldierChessById(id)

			if mo then
				self._addList[index] = mo
			end
		end
	end
end

function EliminateSelectChessMenListModel:serializeAddList()
	local str

	for i = 1, self._addMaxCount do
		local mo = self._addList[i]

		if mo then
			local oneStr = string.format("%d_%d", i, mo.id)

			str = string.nilorempty(str) and oneStr or str .. "," .. oneStr
		end
	end

	return str
end

function EliminateSelectChessMenListModel:_initPresetList()
	if not EliminateTeamSelectionModel.instance:isPreset() then
		return
	end

	local len = #self._initList

	for i = len, 1, -1 do
		local mo = self._initList[i]

		if mo and EliminateTeamSelectionModel.instance:isPresetSoldier(mo.id) then
			table.insert(self._presetList, mo.id)
			table.insert(self._addList, mo)
			table.remove(self._initList, i)
		end
	end
end

function EliminateSelectChessMenListModel:updateList()
	self:setSortList(self._initList)
end

function EliminateSelectChessMenListModel:clearList()
	self:clear()
	self:reInit()
end

EliminateSelectChessMenListModel.instance = EliminateSelectChessMenListModel.New()

return EliminateSelectChessMenListModel
