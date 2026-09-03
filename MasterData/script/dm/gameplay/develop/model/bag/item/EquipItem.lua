-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/bag/item/EquipItem.lua

require("dm.gameplay.develop.model.bag.item.Item")

EquipItem = class("EquipItem", Item, _M)

function EquipItem:initialize(id, data)
	super.initialize({})

	self._item = {
		id = id,
		type = ItemPages.kEquip,
		subType = ItemTypes.K_EQUIP_NEW
	}

	self:synchronize(data)

	if HeroEquipType.kStarItem == self._heroEquip:getPosition() then
		self._item.subType = ItemTypes.K_EQUIP_NEW_ITEM
	end
end

function EquipItem:synchronize(data)
	self._heroEquip = data
end

function EquipItem:getId()
	return self._item.id
end

function EquipItem:getConfigId()
	return self._item.id
end

function EquipItem:getName()
	return self._heroEquip:getName()
end

function EquipItem:getDesc()
	return self._heroEquip:getDesc()
end

function EquipItem:getEquipData()
	return self._heroEquip
end

function EquipItem:getType()
	return self._item.type
end

function EquipItem:getSubType()
	return self._item.subType
end

function EquipItem:getQuality()
	return self._heroEquip:getRarity() - 8
end

function EquipItem:getSort()
	return self._heroEquip:getSort()
end

function EquipItem:getTypeSort()
	return self._heroEquip:getTypeSort()
end

function EquipItem:getIsVisible()
	return true
end

function EquipItem:getRedVisible()
	return false
end

function EquipItem:getIsShine()
	return false
end

function EquipItem:getLevel()
	return self._heroEquip:getLevel()
end

function EquipItem:isExistResource()
	return false
end

function EquipItem:getPosition()
	return self._heroEquip:getPosition()
end
