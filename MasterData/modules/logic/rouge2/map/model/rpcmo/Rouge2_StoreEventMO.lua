-- chunkname: @modules/logic/rouge2/map/model/rpcmo/Rouge2_StoreEventMO.lua

module("modules.logic.rouge2.map.model.rpcmo.Rouge2_StoreEventMO", package.seeall)

local Rouge2_StoreEventMO = class("Rouge2_StoreEventMO", Rouge2_BaseEventMO)

function Rouge2_StoreEventMO:init(eventCo, data)
	Rouge2_StoreEventMO.super.init(self, eventCo, data)

	if self.jsonData.posGoodMap then
		self.posGoodsList = {}

		for index, mo in pairs(self.jsonData.posGoodMap) do
			self.posGoodsList[tonumber(index)] = mo
		end
	end

	self.refreshNum = self.jsonData.refreshNum
	self.refreshNeedCoin = self.jsonData.refreshNeedCoin
	self.stealNum = self.jsonData.stealNum
	self.stealFail = self.jsonData.stealFail
	self.stealEpisodeId = self.jsonData.stealEpisodeId
	self.enterStealFight = self.jsonData.enterStealFight
	self.stealFightWin = self.jsonData.stealFightWin

	self:initGoodsStateMap()
	self:initStoreState()
end

function Rouge2_StoreEventMO:update(eventCo, data)
	Rouge2_StoreEventMO.super.update(self, eventCo, data)

	if self.jsonData.posGoodMap then
		self.posGoodsList = {}

		for index, mo in pairs(self.jsonData.posGoodMap) do
			self.posGoodsList[tonumber(index)] = mo
		end
	end

	self.refreshNum = self.jsonData.refreshNum
	self.refreshNeedCoin = self.jsonData.refreshNeedCoin
	self.preStealNum = self.stealNum or self.jsonData.stealNum
	self.stealNum = self.jsonData.stealNum
	self.stealSucc = self.preStealNum ~= self.stealNum
	self.stealFail = self.jsonData.stealFail
	self.stealEpisodeId = self.jsonData.stealEpisodeId
	self.enterStealFight = self.jsonData.enterStealFight
	self.stealFightWin = self.jsonData.stealFightWin

	self:initGoodsStateMap()
	self:initStoreState()
end

function Rouge2_StoreEventMO:initGoodsStateMap()
	self.goodsStateMap = {}

	if self.jsonData.boughtGoodsPosSet then
		for _, goodsPos in ipairs(self.jsonData.boughtGoodsPosSet) do
			self.goodsStateMap[goodsPos] = Rouge2_MapEnum.GoodsState.Sell
		end
	end

	if self.jsonData.stealGoodsPosSet then
		for _, goodsPos in ipairs(self.jsonData.stealGoodsPosSet) do
			self.goodsStateMap[goodsPos] = Rouge2_MapEnum.GoodsState.StealSucc
		end
	end
end

function Rouge2_StoreEventMO:checkIsSellOut(index)
	local state = self:getGoodsState(index)

	return state == Rouge2_MapEnum.GoodsState.CanBuy
end

function Rouge2_StoreEventMO:getGoodsState(index)
	if not self.posGoodsList or not self.posGoodsList[index] then
		return Rouge2_MapEnum.GoodsState.None
	end

	return self.goodsStateMap[index] or Rouge2_MapEnum.GoodsState.CanBuy
end

function Rouge2_StoreEventMO:initStoreState()
	self.storeState = Rouge2_MapEnum.StoreState.Normal

	if self.stealFightWin and self.stealFightWin ~= 0 then
		if self.stealFightWin == 1 then
			self.storeState = Rouge2_MapEnum.StoreState.FightSucc or Rouge2_MapEnum.StoreState.FightFail
		end
	elseif self.enterStealFight == true then
		self.storeState = Rouge2_MapEnum.StoreState.EnterFight
	elseif self.stealFail == true then
		self.storeState = Rouge2_MapEnum.StoreState.StealFail
	elseif self.stealSucc == true then
		self.storeState = Rouge2_MapEnum.StoreState.StealSucc
	end
end

function Rouge2_StoreEventMO:getStoreState()
	return self.storeState
end

function Rouge2_StoreEventMO:getStealEpisodeId()
	return self.stealEpisodeId
end

function Rouge2_StoreEventMO:__tostring()
	return Rouge2_StoreEventMO.super.__tostring(self)
end

return Rouge2_StoreEventMO
