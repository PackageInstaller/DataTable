-- chunkname: @modules/logic/rouge/map/model/rpcmo/RougeStoreEventMO.lua

module("modules.logic.rouge.map.model.rpcmo.RougeStoreEventMO", package.seeall)

local RougeStoreEventMO = class("RougeStoreEventMO", RougeBaseEventMO)

function RougeStoreEventMO:init(eventCo, data)
	RougeStoreEventMO.super.init(self, eventCo, data)

	self.boughtPosList = self.jsonData.boughtGoodsPosSet

	if self.jsonData.posGoodMap then
		self.posGoodsList = {}

		for index, mo in pairs(self.jsonData.posGoodMap) do
			self.posGoodsList[tonumber(index)] = mo
		end
	end

	self.refreshNum = self.jsonData.refreshNum
	self.refreshNeedCoin = self.jsonData.refreshNeedCoin
end

function RougeStoreEventMO:update(eventCo, data)
	RougeStoreEventMO.super.update(self, eventCo, data)

	self.boughtPosList = self.jsonData.boughtGoodsPosSet

	if self.jsonData.posGoodMap then
		self.posGoodsList = {}

		for index, mo in pairs(self.jsonData.posGoodMap) do
			self.posGoodsList[tonumber(index)] = mo
		end
	end

	self.refreshNum = self.jsonData.refreshNum
	self.refreshNeedCoin = self.jsonData.refreshNeedCoin
end

function RougeStoreEventMO:checkIsSellOut(index)
	return tabletool.indexOf(self.boughtPosList, index)
end

function RougeStoreEventMO:__tostring()
	return RougeStoreEventMO.super.__tostring(self)
end

return RougeStoreEventMO
