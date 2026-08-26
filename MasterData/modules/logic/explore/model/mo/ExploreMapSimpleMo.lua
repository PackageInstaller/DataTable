-- chunkname: @modules/logic/explore/model/mo/ExploreMapSimpleMo.lua

module("modules.logic.explore.model.mo.ExploreMapSimpleMo", package.seeall)

local ExploreMapSimpleMo = pureTable("ExploreMapSimpleMo")

function ExploreMapSimpleMo:ctor()
	self.bonusNum = 0
	self.goldCoin = 0
	self.purpleCoin = 0
	self.bonusNumTotal = 0
	self.goldCoinTotal = 0
	self.purpleCoinTotal = 0
	self.bonusIds = {}
end

function ExploreMapSimpleMo:init(msg)
	self.bonusNum = msg.bonusNum
	self.goldCoin = msg.goldCoin
	self.purpleCoin = msg.purpleCoin
	self.bonusNumTotal = msg.bonusNumTotal
	self.goldCoinTotal = msg.goldCoinTotal
	self.purpleCoinTotal = msg.purpleCoinTotal
	self.bonusIds = {}

	for _, id in pairs(msg.bonusIds) do
		self.bonusIds[id] = true
	end
end

function ExploreMapSimpleMo:onGetCoin(coinType, nowCount)
	if coinType == ExploreEnum.CoinType.Bonus then
		self.bonusNum = nowCount
	elseif coinType == ExploreEnum.CoinType.GoldCoin then
		self.goldCoin = nowCount
	elseif coinType == ExploreEnum.CoinType.PurpleCoin then
		self.purpleCoin = nowCount
	end
end

return ExploreMapSimpleMo
