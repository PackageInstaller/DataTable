-- chunkname: @modules/logic/explore/model/ExploreBackpackModel.lua

module("modules.logic.explore.model.ExploreBackpackModel", package.seeall)

local ExploreBackpackModel = class("ExploreBackpackModel", ListScrollModel)

function ExploreBackpackModel:onInit()
	self:clearData()
end

function ExploreBackpackModel:reInit()
	self:clearData()
end

function ExploreBackpackModel:clearData()
	self.stackableDic = {}

	self:clear()
end

function ExploreBackpackModel:refresh()
	self:clear()

	local itemList = BackpackModel.instance:getBackpackList()

	BackpackModel.instance:setBackpackItemList(itemList)

	local items = {}

	for _, v in pairs(BackpackModel.instance:getBackpackItemList()) do
		if v.subType == 15 then
			table.insert(items, v)
		end
	end

	self:setList(items)

	return items
end

function ExploreBackpackModel:updateItems(exploreItems, clearAll)
	if clearAll or not self.stackableDic then
		self:clear()

		self.stackableDic = {}
	end

	local haveRune = false
	local itemList = self:getList()

	for i, v in ipairs(exploreItems) do
		local mo = self:getById(v.uid)
		local isStackable = ExploreConfig.instance:isStackableItem(v.itemId)

		if isStackable then
			mo = self.stackableDic[v.itemId]
		end

		if not mo then
			if v.quantity > 0 then
				local itemMo = ExploreBackpackItemMO.New()

				itemMo:init(v)

				itemMo.quantity = v.quantity

				table.insert(itemList, itemMo)

				self.stackableDic[itemMo.itemId] = itemMo
			end
		else
			if isStackable then
				mo:updateStackable(v)
			else
				mo.quantity = v.quantity
				mo.status = v.status
			end

			if mo.quantity == 0 then
				self:removeItem(mo)
			end

			if mo.itemEffect == ExploreEnum.ItemEffect.Active then
				haveRune = true
			end
		end

		ExploreSimpleModel.instance:setShowBag()
	end

	local map = ExploreController.instance:getMap()

	if haveRune and map then
		map:checkAllRuneTrigger()
	end

	self:setList(itemList)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnItemChange, self._mo)
end

function ExploreBackpackModel:getItemMoByEffect(effect)
	local itemList = self:getList()

	for i, v in ipairs(itemList) do
		if v.itemEffect == effect then
			return v
		end
	end
end

function ExploreBackpackModel:addItem(type, id, num)
	self:addAtLast({
		type = type,
		id = id,
		num = num
	})
	ExploreController.instance:dispatchEvent(ExploreEvent.OnItemChange, self._mo)
end

function ExploreBackpackModel:removeItem(mo)
	self.stackableDic[mo.itemId] = nil

	self:remove(mo)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnItemChange, self._mo)
end

function ExploreBackpackModel:getItem(itemId)
	local itemList = self:getList()

	for i, v in ipairs(itemList) do
		if v.itemId == itemId then
			return v
		end
	end
end

ExploreBackpackModel.instance = ExploreBackpackModel.New()

return ExploreBackpackModel
