-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkMapNewsMO.lua

module("logic.extensions.airworkshop.model.def.AirWorkMapNewsMO", package.seeall)

local M = class("AirWorkMapNewsMO")

function M:updateFromServer(airMapNews)
	self._id = airMapNews.id
	self._type = airMapNews.type
	self._unRead = airMapNews.unRead
	self._time = airMapNews.time
	self._win = airMapNews.win
	self._cover = airMapNews.cover
	self._playerInfo = {
		userId = airMapNews.player.userId,
		createLv = airMapNews.player.createLv,
		portrait = airMapNews.player.portrait,
		nickname = airMapNews.player.nickname,
		playerLv = airMapNews.player.playerLv
	}
	self._msg = nil

	if airMapNews:HasField("msg") then
		self._msg = airMapNews.msg
	end

	self._hero = {}

	for _, NewsHeroNO in ipairs(airMapNews.hero or {}) do
		table.insert(self._hero, {
			heroId = NewsHeroNO.heroId,
			lv = NewsHeroNO.lv
		})
	end
end

function M:getId()
	return self._id
end

function M:getType()
	return self._type
end

function M:getTime()
	return tonumber(self._time) or 0
end

function M:getWin()
	return self._win
end

function M:getCover()
	return self._cover
end

function M:getUnRead()
	return self._unRead
end

function M:setUnRead(unRead)
	self._unRead = unRead
end

function M:getPlayerInfo()
	return self._playerInfo
end

function M:getMsg()
	return self._msg
end

function M:getHeroList()
	return self._hero
end

return M
