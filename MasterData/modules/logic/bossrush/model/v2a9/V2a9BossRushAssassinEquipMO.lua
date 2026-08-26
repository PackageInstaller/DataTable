-- chunkname: @modules/logic/bossrush/model/v2a9/V2a9BossRushAssassinEquipMO.lua

module("modules.logic.bossrush.model.v2a9.V2a9BossRushAssassinEquipMO", package.seeall)

local V2a9BossRushAssassinEquipMO = class("V2a9BossRushAssassinEquipMO")

function V2a9BossRushAssassinEquipMO:init(index, itemType, isLock)
	self._index = index
	self._isLock = isLock

	self:setEquipItemType(itemType)
end

function V2a9BossRushAssassinEquipMO:setEquipItemType(itemType)
	self._itemType = itemType
end

function V2a9BossRushAssassinEquipMO:isEquip()
	return self._itemType and self._itemType ~= 0
end

function V2a9BossRushAssassinEquipMO:getItemType()
	return self._itemType
end

function V2a9BossRushAssassinEquipMO:getIndex()
	return self._index
end

function V2a9BossRushAssassinEquipMO:isLock()
	return self._isLock
end

return V2a9BossRushAssassinEquipMO
