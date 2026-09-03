-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/bag/item/Item.lua

require("dm.gameplay.develop.model.bag.item.AbstractItem")

Item = class("Item", AbstractItem, _M)

Item:has("_prototype", {
	is = "r"
})

function Item:initialize(itemPrototype)
	super.initialize(self)

	self._prototype = itemPrototype
end

function Item:synchronize(itemData, id)
	return
end

function Item:getId()
	return self._prototype:getId()
end

function Item:getConfigId()
	return self._prototype:getId()
end

function Item:getName()
	return self._prototype:getName()
end

function Item:getBattleSoulExp()
	return self._prototype:getBattleSoulExp()
end

function Item:getItemEXP()
	return self._prototype:getItemExp()
end

function Item:getType()
	return self._prototype:getType()
end

function Item:getTargetId()
	return self._prototype:getTargetId()
end

function Item:getTargetType()
	return self._prototype:getTargetType()
end

function Item:getTargetNum()
	return self._prototype:getTargetNum()
end

function Item:getSubType()
	return self._prototype:getSubType()
end

function Item:getUseLevel()
	return self._prototype:getUseLevel()
end

function Item:getUseVipLevel()
	return self._prototype:getUseVipLevel()
end

function Item:getQuality()
	return self._prototype:getQuality()
end

function Item:getDesc()
	return self._prototype:getDesc()
end

function Item:getFunctionDesc()
	return self._prototype:getFunctionDesc()
end

function Item:getUrl()
	return self._prototype:getUrl()
end

function Item:getIcon()
	return self._prototype:getIcon()
end

function Item:getSellNumber()
	return self._prototype:getSellNumber()
end

function Item:getMaxNumber()
	return self._prototype:getMaxNumber()
end

function Item:getRewardId()
	return self._prototype:getRewardId()
end

function Item:getReward()
	return self._prototype:getReward()
end

function Item:getSort()
	return self._prototype:getSort()
end

function Item:getTypeSort()
	return self._prototype:getTypeSort()
end

function Item:canBatchUse()
	return self._prototype:canBatchUse()
end

function Item:getCustomData()
	return self._prototype:getCustomData()
end

function Item:getFragmentID()
	return self._prototype:getFragmentID()
end

function Item:getSoulExp()
	return self._prototype:getSoulExp()
end

function Item:getIsVisible()
	return self._prototype:getIsVisible()
end

function Item:getRedVisible()
	return self._prototype:getRedVisible()
end

function Item:getIsShine()
	return self._prototype:getIsShine()
end

function Item:getIsShineInBag()
	return self._prototype:getIsShineInBag()
end

function Item:getRarity()
	return self._prototype:getQuality() + 9
end

function Item:isExistResource()
	local res = self._prototype:getResource()

	if res and #res > 0 then
		return true
	end

	return false
end

function Item:getCanLock()
	return self._prototype:getCanLock()
end
