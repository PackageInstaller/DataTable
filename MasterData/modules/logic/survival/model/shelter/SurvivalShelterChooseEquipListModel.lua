-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterChooseEquipListModel.lua

module("modules.logic.survival.model.shelter.SurvivalShelterChooseEquipListModel", package.seeall)

local SurvivalShelterChooseEquipListModel = class("SurvivalShelterChooseEquipListModel", ListScrollModel)

function SurvivalShelterChooseEquipListModel:setSelectEquip(equipId)
	self.selectEquipId = self.selectEquipId == equipId and 0 or equipId

	return true
end

function SurvivalShelterChooseEquipListModel:setSelectPos(pos)
	if self._selectPos == pos then
		return
	end

	self._selectPos = pos

	return true
end

function SurvivalShelterChooseEquipListModel:getSelectPos()
	return self._selectPos
end

function SurvivalShelterChooseEquipListModel:getSelectEquip()
	return self.selectEquipId
end

function SurvivalShelterChooseEquipListModel:clearSelectList()
	if self._equipList ~= nil then
		tabletool.clear(self._equipList)
	else
		self._equipList = {}
	end
end

function SurvivalShelterChooseEquipListModel:setNeedSelectEquipList(equipList)
	self.selectEquipId = nil
	self._pos2Id = nil
	self._selectPos = nil

	if equipList == nil then
		return
	end

	self:clearSelectList()

	for i = 1, #equipList do
		local mo = SurvivalBagItemMo.New()

		mo:init({
			id = equipList[i]
		})
		table.insert(self._equipList, mo)
	end
end

function SurvivalShelterChooseEquipListModel:getShowList()
	return self._equipList or {}
end

function SurvivalShelterChooseEquipListModel:setSelectIdToPos(id, pos)
	pos = pos ~= nil and pos or self._selectPos

	if pos == nil then
		return
	end

	if self._pos2Id == nil then
		self._pos2Id = {}
	end

	self._pos2Id[pos] = id

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSelectFinish)
end

function SurvivalShelterChooseEquipListModel:getAllSelectPosEquip()
	local list = {}

	if self._pos2Id then
		for _, equipId in pairs(self._pos2Id) do
			table.insert(list, equipId)
		end
	end

	return list
end

function SurvivalShelterChooseEquipListModel:getSelectIdByPos(posIndex)
	if posIndex == nil or self._pos2Id == nil then
		return nil
	end

	return self._pos2Id[posIndex]
end

function SurvivalShelterChooseEquipListModel:npcIdIsSelect(id)
	if self._pos2Id ~= nil then
		for i, v in pairs(self._pos2Id) do
			if id == v then
				return i
			end
		end
	end

	return nil
end

function SurvivalShelterChooseEquipListModel:filterEquip(filterList, equipMo)
	if not filterList or not next(filterList) then
		return true
	end

	local tag = lua_survival_equip.configDict[equipMo.id].tag
	local list = SurvivalConfig.instance:getSplitTag(tag)
	local dict = {}

	for _, v in ipairs(list) do
		dict[v] = true
	end

	for _, v in pairs(filterList) do
		if dict[v.type] then
			return true
		end
	end
end

function SurvivalShelterChooseEquipListModel.sort(a, b)
	return a.id < b.id
end

function SurvivalShelterChooseEquipListModel:refreshList(filterList)
	local list = {}

	if self._equipList then
		for i = 1, #self._equipList do
			local equipMo = self._equipList[i]

			if self:filterEquip(filterList, equipMo) then
				table.insert(list, equipMo)
			end
		end
	end

	if #list > 1 then
		SurvivalBagSortHelper.sortItems(list, SurvivalEnum.ItemSortType.ItemReward, true)
	end

	self:setList(list)
end

SurvivalShelterChooseEquipListModel.instance = SurvivalShelterChooseEquipListModel.New()

return SurvivalShelterChooseEquipListModel
