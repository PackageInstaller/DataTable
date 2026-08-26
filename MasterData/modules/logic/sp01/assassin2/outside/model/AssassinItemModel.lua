-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinItemModel.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinItemModel", package.seeall)

local AssassinItemModel = class("AssassinItemModel", BaseModel)

function AssassinItemModel:onInit()
	self:clear()
end

function AssassinItemModel:reInit()
	return
end

function AssassinItemModel:clear()
	AssassinItemModel.super.clear(self)

	self._itemTypeDict = {}
end

function AssassinItemModel:updateAllInfo(itemInfoList)
	self:clear()

	for _, itemInfo in ipairs(itemInfoList) do
		local itemId = itemInfo.itemId
		local itemType = AssassinConfig.instance:getAssassinItemType(itemId)
		local repeatedMo = self._itemTypeDict[itemType]

		if repeatedMo then
			local repeatedId = repeatedMo:getId()

			logError(string.format("AssassinItemModel:updateAllInfo error, item type repeated, itemType:%s, item1:%s, item2:%s", itemType, repeatedId, itemId))
		elseif itemType then
			local itemMo = AssassinItemMO.New(itemInfo)

			self._itemTypeDict[itemType] = itemMo

			self:addAtLast(itemMo)
		end
	end
end

function AssassinItemModel:unlockNewItems(itemInfoList)
	for _, itemInfo in ipairs(itemInfoList) do
		local itemId = itemInfo.itemId
		local itemType = AssassinConfig.instance:getAssassinItemType(itemId)
		local repeatedMo = self._itemTypeDict[itemType]

		if repeatedMo then
			self:remove(repeatedMo)

			self._itemTypeDict[itemType] = nil
		end

		local itemMo = AssassinItemMO.New(itemInfo)

		self._itemTypeDict[itemType] = itemMo

		self:addAtLast(itemMo)
	end
end

function AssassinItemModel:getAssassinItemMoList()
	return self:getList()
end

function AssassinItemModel:getAssassinItemMo(itemId, nilError)
	local assassinItemMo = self:getById(itemId)

	if not assassinItemMo and nilError then
		logError(string.format("AssassinItemModel:getAssassinItemMo error, not find assassinHeroMo, itemId:%s", itemId))
	end

	return assassinItemMo
end

function AssassinItemModel:getAssassinItemCount(itemId)
	local itemMo = self:getAssassinItemMo(itemId)

	return itemMo and itemMo:getCount() or 0
end

function AssassinItemModel:getItemIdByItemType(itemType)
	local itemMo = self._itemTypeDict[itemType]

	return itemMo and itemMo:getId()
end

AssassinItemModel.instance = AssassinItemModel.New()

return AssassinItemModel
