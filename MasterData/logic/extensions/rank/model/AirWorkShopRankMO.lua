-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/model/AirWorkShopRankMO.lua

module("logic.extensions.rank.model.AirWorkShopRankMO", package.seeall)

local M = class("AirWorkShopRankMO", RankBaseMO)

function M:ctor()
	M.super.ctor(self)

	self._lv = nil
	self._score = nil
end

function M:updateData(rankId, data)
	M.super.updateData(self, rankId, data)

	local airWorkShopData = data.airRodeo

	self:setAirWorkShopData(airWorkShopData)
end

function M:setAirWorkShopData(airWorkShopData)
	if not airWorkShopData then
		return
	end

	self._lv = airWorkShopData.lv
	self._score = airWorkShopData.score
end

function M:getDan()
	return self._lv
end

function M:getScore()
	return self._score
end

function M:clear()
	M.super.clear(self)

	self._lv = nil
	self._score = nil
end

return M
