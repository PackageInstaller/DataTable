-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/bag/item/TsouItem.lua

require("dm.gameplay.develop.model.bag.item.Item")

TsouItem = class("TsouItem", Item, _M)

function TsouItem:initialize(id, data)
	super.initialize({})

	self._item = {
		id = id,
		type = ItemPages.kTsoul,
		subType = ItemTypes.K_SOUL
	}

	self:synchronize(data)
end

function TsouItem:synchronize(data)
	self._tsoul = data
end

function TsouItem:getId()
	return self._tsoul:getId()
end

function TsouItem:getConfigId()
	return self._tsoul:getConfigId()
end

function TsouItem:getName()
	return self._tsoul:getName()
end

function TsouItem:getDesc()
	return self._tsoul:getDesc()
end

function TsouItem:getTSoulData()
	return self._tsoul
end

function TsouItem:getType()
	return self._item.type
end

function TsouItem:getSubType()
	return self._item.subType
end

function TsouItem:getQuality()
	return self._tsoul:getRarity()
end

function TsouItem:getSort()
	return self._tsoul:getSort()
end

function TsouItem:getTypeSort()
	return self._tsoul:getSort()
end

function TsouItem:getIsVisible()
	return true
end

function TsouItem:getRedVisible()
	return false
end

function TsouItem:getIsShine()
	return false
end

function TsouItem:getLevel()
	return self._tsoul:getLevel()
end

function TsouItem:isExistResource()
	return false
end

function TsouItem:getPosition()
	return self._tsoul:getPosition()
end

function TsouItem:getHeroId()
	return self._tsoul:getHeroId()
end

function TsouItem:getLock()
	return self._tsoul:getLock()
end
