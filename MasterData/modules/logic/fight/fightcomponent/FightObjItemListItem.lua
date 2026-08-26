-- chunkname: @modules/logic/fight/fightcomponent/FightObjItemListItem.lua

module("modules.logic.fight.fightcomponent.FightObjItemListItem", package.seeall)

local FightObjItemListItem = class("FightObjItemListItem", FightBaseClass)

function FightObjItemListItem:onConstructor(gameObject, class, parentObject)
	self.dataList = {}
	self.modelGameObject = gameObject
	self.objClass = class
	self.parentObject = parentObject or self.modelGameObject.transform.parent.gameObject

	gohelper.setActive(self.modelGameObject, false)
end

function FightObjItemListItem:setDataList(dataList)
	local oldCount = #self.dataList

	for i = oldCount, 1, -1 do
		self:removeIndex(i)
	end

	local newCount = #dataList

	for i = 1, newCount do
		self:addIndex(i, dataList[i])
	end
end

function FightObjItemListItem:addIndex(index, data)
	local item = self:newItem()

	table.insert(self.dataList, index, data)
	table.insert(self, index, item)

	if item.onRefreshItemData then
		item:onRefreshItemData(data)
	end

	return item
end

function FightObjItemListItem:removeIndex(index)
	local item = self[index]

	if item then
		table.remove(self.dataList, index)
		table.remove(self, index)
		item:disposeSelf()
	end
end

function FightObjItemListItem:getIndex(item)
	for i, v in ipairs(self) do
		if v == item then
			return i
		end
	end

	logError("获取下标失败")

	return 0
end

function FightObjItemListItem:addHead(data)
	return self:addIndex(1, data)
end

function FightObjItemListItem:addLast(data)
	return self:addIndex(#self + 1, data)
end

function FightObjItemListItem:getHead()
	return self[1]
end

function FightObjItemListItem:getLast()
	return self[#self]
end

function FightObjItemListItem:removeHead()
	return self:removeIndex(1)
end

function FightObjItemListItem:removeLast()
	return self:removeIndex(#self)
end

function FightObjItemListItem:removeItem(item)
	local index = self:getIndex(item)

	if index == 0 then
		logError("删除失败，未找到该item")

		return
	end

	return self:removeIndex(index)
end

function FightObjItemListItem:swap(index1, index2)
	self[index1] = self[index2]
	self[index2] = self[index1]
	self.dataList[index1] = self.dataList[index2]
	self.dataList[index2] = self.dataList[index1]
end

function FightObjItemListItem:newItem()
	local gameObject = gohelper.clone(self.modelGameObject, self.parentObject)

	gohelper.setActive(gameObject, true)

	local item = self:newClass(self.objClass, gameObject)

	item.GAMEOBJECT = gameObject
	item.ITEM_LIST_MGR = self
	item.getSelfIndex = FightObjItemListItem.getSelfIndex
	item.getPreItem = FightObjItemListItem.getPreItem
	item.getNextItem = FightObjItemListItem.getNextItem
	item.removeSelf = FightObjItemListItem.removeSelf

	return item
end

function FightObjItemListItem.getSelfIndex(item)
	local parentRoot = item.PARENT_ROOT_OBJECT

	return parentRoot:getIndex(item)
end

function FightObjItemListItem.getPreItem(item)
	local index = item:getSelfIndex()

	return item.ITEM_LIST_MGR[index - 1]
end

function FightObjItemListItem.getNextItem(item)
	local index = item:getSelfIndex()

	return item.ITEM_LIST_MGR[index + 1]
end

function FightObjItemListItem.removeSelf(item)
	local parentRoot = item.PARENT_ROOT_OBJECT

	return parentRoot:removeItem(item)
end

function FightObjItemListItem:onDestructor()
	return
end

return FightObjItemListItem
