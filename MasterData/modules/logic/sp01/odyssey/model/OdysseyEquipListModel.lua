-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyEquipListModel.lua

module("modules.logic.sp01.odyssey.model.OdysseyEquipListModel", package.seeall)

local OdysseyEquipListModel = class("OdysseyEquipListModel", ListScrollModel)

function OdysseyEquipListModel:onInit()
	self:reInit()
end

function OdysseyEquipListModel:reInit()
	self._filterTag = nil
	self._itemType = nil
end

function OdysseyEquipListModel:copyListFromEquipModel(itemType, filterType, bagType, keepOrder)
	itemType = itemType or OdysseyEnum.ItemType.Equip

	local equipMoList = OdysseyItemModel.instance:getItemMoList()
	local curEquipMoListCount = self:getCount()
	local curInfoMo = OdysseyHeroGroupModel.instance:getCurHeroGroup()
	local isEquip = itemType == OdysseyEnum.ItemType.Equip
	local filterMoList = {}
	local itemMoCount = 0

	if equipMoList and next(equipMoList) then
		for _, mo in ipairs(equipMoList) do
			if mo.config.type == itemType and (filterType == nil or filterType == mo.config.suitId) then
				table.insert(filterMoList, mo)

				itemMoCount = itemMoCount + 1
			end
		end
	end

	if curEquipMoListCount > 0 and itemType == self._itemType and filterType == self._filterType and keepOrder and itemMoCount == curEquipMoListCount then
		local curItemMoList = self:getList()

		logNormal("奥德赛下半活动 道具列表延时排序")

		for _, mo in ipairs(curItemMoList) do
			mo.isEquip = bagType == OdysseyEnum.BagType.FightPrepare and isEquip and curInfoMo:isEquipUse(mo.uid)
		end

		self:onModelUpdate()
	else
		logNormal("奥德赛下半活动 道具列表立刻排序")

		local tempMoList = {}

		if filterMoList and next(filterMoList) then
			for _, mo in ipairs(filterMoList) do
				local listMo = OdysseyItemListMo.New()
				local isUse = bagType == OdysseyEnum.BagType.FightPrepare and isEquip and curInfoMo:isEquipUse(mo.uid)

				listMo:init(mo, bagType, isUse)
				table.insert(tempMoList, listMo)
			end
		end

		table.sort(tempMoList, self.sortMoList)
		self:clear()
		self:addList(tempMoList)
	end

	self._itemType = itemType
	self._filterType = filterType
end

function OdysseyEquipListModel.sortMoList(listMoA, listMoB)
	local moA = listMoA.itemMo
	local moB = listMoB.itemMo

	if listMoA.isEquip ~= listMoB.isEquip then
		return listMoA.isEquip == true
	end

	if moA.id == moB.id then
		return moA.uid > moB.uid
	end

	local configA = moA.config
	local configB = moB.config

	if moA.config.rare == moB.config.rare then
		return moA.id > moB.id
	end

	return configA.rare > configB.rare
end

function OdysseyEquipListModel:clearSelect()
	local view = self._scrollViews[1]

	if view then
		local mo = view:getFirstSelect()

		if mo then
			view:selectCell(mo.id, false)
		end
	end
end

function OdysseyEquipListModel:getSelectMo()
	local view = self._scrollViews[1]

	if view then
		return (view:getFirstSelect())
	end

	return nil
end

function OdysseyEquipListModel:setSelect(equipUid)
	local view = self._scrollViews[1]

	if view then
		for _, mo in ipairs(self._list) do
			if mo.itemMo.uid == equipUid then
				view:selectCell(mo.id, true)
				OdysseyController.instance:dispatchEvent(OdysseyEvent.OnEquipItemSelect, mo)

				break
			end
		end
	end
end

function OdysseyEquipListModel:getFirstMo()
	return self:getByIndex(1)
end

OdysseyEquipListModel.instance = OdysseyEquipListModel.New()

return OdysseyEquipListModel
