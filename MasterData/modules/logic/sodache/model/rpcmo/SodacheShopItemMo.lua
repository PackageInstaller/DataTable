-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheShopItemMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheShopItemMo", package.seeall)

local SodacheShopItemMo = pureTable("SodacheShopItemMo")

function SodacheShopItemMo:init(data)
	self.id = data.id
	self.count = data.count
	self.buyCount = data.buyCount
	self.goodCo = lua_sodache_goods.configDict[self.id]

	if not self.goodCo then
		logError("商品不存在" .. self.id)

		return
	end

	local params = self.goodCo and string.splitToNumber(self.goodCo.cost, ":") or {}

	self.price = params[2] or 0

	local dict = GameUtil.splitString2(self.goodCo.relatedId, true, "&", ":") or {}

	self.items = {}

	for i, v in ipairs(dict) do
		table.insert(self.items, SodacheCardMo.Create(v[1] or 0, v[2] or 0))
	end

	if #self.items == 1 then
		self.itemType = GameUtil.getTbValue(self.items, 1, "serverMo", "itemCo", "type")
		self.itemSubType = GameUtil.getTbValue(self.items, 1, "serverMo", "itemCo", "subType")
	end
end

return SodacheShopItemMo
