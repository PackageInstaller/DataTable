-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheBagMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheBagMo", package.seeall)

local SodacheBagMo = pureTable("SodacheBagMo")

function SodacheBagMo:init(data)
	self.type = data.type
	self.items, self.itemsMap = GameUtil.rpcInfosToListAndMap(data.items, SodacheItemMo, "uid")
	self._countDict = {}
	self._cardTypeDict = {}
	self.bagDirty = true
end

function SodacheBagMo:updateBag(data)
	for i, v in ipairs(data.updates) do
		local mo = self.itemsMap[v.uid]

		if not mo then
			mo = SodacheItemMo.New()

			mo:init(v)

			self.itemsMap[mo.uid] = mo

			table.insert(self.items, mo)
		else
			if mo.configId == SodacheEnum.CurrencyId.Coin then
				local coinChange = v.count - mo.count

				if coinChange > 0 then
					self.coinChange = v.count - mo.count
				end
			end

			mo:init(v)
		end
	end

	for i, v in ipairs(data.deletes) do
		local mo = self.itemsMap[v]

		if mo then
			tabletool.removeValue(self.items, mo)

			self.itemsMap[v] = nil
		else
			logError("没有对应道具，删除失败。uid:" .. v)
		end
	end

	self.bagDirty = true
end

function SodacheBagMo:getItemQuantity(itemId)
	self:initCache()

	return self._countDict[itemId] or 0
end

function SodacheBagMo:getItemsByCardType(cardType)
	self:initCache()

	return self._cardTypeDict[cardType] or {}
end

function SodacheBagMo:initCache()
	if not self.bagDirty then
		return
	end

	self._countDict = {}
	self._cardTypeDict = {}
	self.bagDirty = false

	for k, v in pairs(self.items) do
		self._countDict[v.configId] = self._countDict[v.configId] or 0
		self._countDict[v.configId] = self._countDict[v.configId] + v.count

		if v.itemType == SodacheEnum.ItemType.Card then
			self._cardTypeDict[v.itemCo.type] = self._cardTypeDict[v.itemCo.type] or {}

			table.insert(self._cardTypeDict[v.itemCo.type], v)
		end
	end
end

function SodacheBagMo:clearCoinChange()
	self.coinChange = nil
end

return SodacheBagMo
