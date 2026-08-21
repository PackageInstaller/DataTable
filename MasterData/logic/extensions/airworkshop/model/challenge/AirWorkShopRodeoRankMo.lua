-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/challenge/AirWorkShopRodeoRankMo.lua

module("logic.extensions.airworkshop.model.challenge.AirWorkShopRodeoRankMo", package.seeall)

local M = class("AirWorkShopRodeoRankMo")

function M:ctor()
	return
end

function M:updateFromServer(_RankEntryNO, week, part)
	self._week = week
	self._part = part
	self._userId = _RankEntryNO.userId
	self._rank = _RankEntryNO.rank
	self._nickname = _RankEntryNO.nickname
	self._playerLv = _RankEntryNO.playerLv
	self._portrait = _RankEntryNO.portrait
	self._displayCard = {}

	for _, value in pairs(_RankEntryNO.displayCard or {}) do
		table.insert(self._displayCard, value)
	end

	self._airStudio = _RankEntryNO.airRodeo
end

function M:getWeek()
	return self._week
end

function M:getPart()
	return self._part
end

function M:getUserId()
	return self._userId
end

function M:getRank()
	return self._rank
end

function M:getNickName()
	return self._nickname
end

function M:getPlayerLv()
	return self._playerLv or 1
end

function M:getPortrait()
	return self._portrait
end

function M:getDisplayCardIds()
	return self._displayCard or {}
end

function M:getAirStudioData()
	return self._airStudio or {}
end

function M:getAirLv()
	local detail = self:getAirStudioData()
	local lv = detail.lv or 1

	return lv
end

function M:getAirScore()
	local detail = self:getAirStudioData()
	local lv = detail.score or 0

	return lv
end

return M
