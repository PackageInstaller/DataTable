-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinItemMO.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinItemMO", package.seeall)

local AssassinItemMO = class("AssassinItemMO")

function AssassinItemMO:ctor(itemData)
	self.id = itemData.itemId
	self.count = itemData.count
end

function AssassinItemMO:getId()
	return self.id
end

function AssassinItemMO:getCount()
	return self.count
end

function AssassinItemMO:addCount(count)
	self.count = self.count + count
end

function AssassinItemMO:subCount(count)
	if count > self.count then
		logError(string.format("AssassinItemMO:subCount error, count not enough, itemId:%s, curCount:%s, subCount:%s", self.id, self.count, count))

		self.count = 0
	else
		self.count = self.count - count
	end
end

function AssassinItemMO:isNew()
	local cacheKey = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.NewAssassinItem, self.id)

	return (AssassinOutsideModel.instance:getCacheKeyData(cacheKey))
end

return AssassinItemMO
