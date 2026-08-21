-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/model/TradingOrderMo.lua

module("logic.extensions.trading.model.TradingOrderMo", package.seeall)

local M = class("TradingOrderMo")

function M:initByCo(co)
	self._id = co.id
	self._type = co.type
	self._quality = co.quality
	self._cost = co.cost
	self._openLevel = co.openLevel
	self._reward = co.reward
end

function M:getQuality()
	return self._quality
end

function M:getCost()
	return self._cost
end

function M:getOpenLevel()
	return self._openLevel
end

function M:getReward()
	return self._reward
end

return M
