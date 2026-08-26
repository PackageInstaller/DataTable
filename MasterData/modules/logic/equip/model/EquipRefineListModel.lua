-- chunkname: @modules/logic/equip/model/EquipRefineListModel.lua

module("modules.logic.equip.model.EquipRefineListModel", package.seeall)

local EquipRefineListModel = class("EquipRefineListModel", ListScrollModel)

EquipRefineListModel.SelectStatusEnum = {
	Selected = 2,
	OutMaxRefineLv = 1,
	Success = 0
}

function EquipRefineListModel:onInit()
	self.selectedEquipMoList = {}
	self.selectedEquipUidDict = {}
end

function EquipRefineListModel:reInit()
	self.selectedEquipMoList = {}
	self.selectedEquipUidDict = {}
end

function EquipRefineListModel:initData(equipMo)
	self.targetEquipMo = equipMo
	self.targetEquipRefineLv = equipMo.refineLv

	local co = self.targetEquipMo.config

	if not string.nilorempty(co.useSpRefine) then
		self.useSpRefineList = string.splitToNumber(co.useSpRefine, "#")
	end

	self.data = {}

	local equipMoList = EquipModel.instance:getEquips()

	for i, equipMo in ipairs(equipMoList) do
		if self:canAddToData(equipMo) then
			table.insert(self.data, equipMo)
		end
	end
end

function EquipRefineListModel:canAddToData(equipMo)
	if equipMo.equipId == EquipConfig.instance:getEquipUniversalId() then
		return true
	end

	if equipMo.equipId == self.targetEquipMo.equipId and equipMo.uid ~= self.targetEquipMo.uid and equipMo.config.isExpEquip ~= 1 then
		return true
	end

	if self.useSpRefineList and tabletool.indexOf(self.useSpRefineList, equipMo.equipId) then
		return true
	end

	return false
end

function EquipRefineListModel:sortData()
	table.sort(self.data, EquipHelper.sortRefineList)
end

function EquipRefineListModel:refreshData()
	self:setList(self.data)
end

function EquipRefineListModel:getDataCount()
	return GameUtil.getTabLen(self.data)
end

function EquipRefineListModel:selectEquip(equipMo)
	if self.selectedEquipUidDict[equipMo.uid] then
		return EquipRefineListModel.SelectStatusEnum.Selected
	end

	local aimRefineLv = self:getAddRefineLv() + self.targetEquipRefineLv

	if aimRefineLv >= EquipConfig.instance:getEquipRefineLvMax() then
		return EquipRefineListModel.SelectStatusEnum.OutMaxRefineLv
	end

	self.selectedEquipUidDict[equipMo.uid] = true

	table.insert(self.selectedEquipMoList, equipMo)
	self:setSelectedEquipMoList()
	EquipController.instance:dispatchEvent(EquipEvent.OnRefineSelectedEquipChange)

	return EquipRefineListModel.SelectStatusEnum.Success
end

function EquipRefineListModel:deselectEquip(equipMo)
	self.selectedEquipUidDict[equipMo.uid] = nil

	local equipMoList = {}

	for _, tempEquipMo in ipairs(self.selectedEquipMoList) do
		if tempEquipMo.uid ~= equipMo.uid then
			table.insert(equipMoList, tempEquipMo)
		end
	end

	self.selectedEquipMoList = equipMoList

	self:setSelectedEquipMoList()
	EquipController.instance:dispatchEvent(EquipEvent.OnRefineSelectedEquipChange)
end

function EquipRefineListModel:clearSelectedEquipList()
	self.selectedEquipMoList = {}
	self.selectedEquipUidDict = {}

	EquipRefineSelectedListModel.instance:updateList()
end

function EquipRefineListModel:setSelectedEquipMoList()
	EquipRefineSelectedListModel.instance:updateList(self.selectedEquipMoList)
end

function EquipRefineListModel:getSelectedEquipMoList()
	return self.selectedEquipMoList
end

function EquipRefineListModel:getSelectedEquipUidList()
	local equipUidList = {}

	for _, equipMo in ipairs(self.selectedEquipMoList) do
		table.insert(equipUidList, equipMo.uid)
	end

	return equipUidList
end

function EquipRefineListModel:getAddRefineLv()
	local refineLv = 0

	for _, equipMo in ipairs(self.selectedEquipMoList) do
		refineLv = refineLv + equipMo.refineLv
	end

	return refineLv
end

function EquipRefineListModel:isSelected(equipMo)
	if not equipMo then
		return false
	end

	return self.selectedEquipUidDict[equipMo.uid]
end

function EquipRefineListModel:clearData()
	self:clear()

	self.selectedEquipMoList = {}
	self.selectedEquipUidDict = {}
	self.useSpRefineList = nil
end

EquipRefineListModel.instance = EquipRefineListModel.New()

return EquipRefineListModel
