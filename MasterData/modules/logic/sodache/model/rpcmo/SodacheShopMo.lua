-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheShopMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheShopMo", package.seeall)

local SodacheShopMo = pureTable("SodacheShopMo")

function SodacheShopMo:init(data)
	self.id = data.id
	self.items, self.itemsMap = GameUtil.rpcInfosToListAndMap(data.items, SodacheShopItemMo, "id", self.itemsMap)
	self.itemsByItemTypes = {}

	for i, v in ipairs(self.items) do
		local type = v.itemType
		local subType = v.itemSubType

		if type then
			self.itemsByItemTypes[type] = self.itemsByItemTypes[type] or {
				dict = {}
			}
			self.itemsByItemTypes[type].dict[subType] = self.itemsByItemTypes[type].dict[subType] or {}

			table.insert(self.itemsByItemTypes[type].dict[subType], v)
		end
	end

	for k, v in pairs(self.itemsByItemTypes) do
		local dict = v.dict

		v.dict = nil

		for subType, list in pairs(dict) do
			table.insert(v, list)
		end

		table.sort(v, SodacheShopMo.sortShopItems)
	end

	self.shopCo = lua_sodache_shop.configDict[self.id]
end

function SodacheShopMo.sortShopItems(a, b)
	local typeA = a[1].itemSubType
	local typeB = b[1].itemSubType

	return typeA < typeB
end

function SodacheShopMo:getShopType()
	return self.shopCo and self.shopCo.type
end

return SodacheShopMo
