-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonRewardItemMO.lua

module("logic.extensions.season.model.SeasonRewardItemMO", package.seeall)

local M = class("SeasonRewardItemMO")

function M:ctor(code, num, isVip)
	self._code = code
	self._num = num or 1
	self._isVip = isVip
end

function M:getCode()
	return self._code
end

function M:getNum()
	return self._num
end

function M:isVip()
	return self._isVip
end

function M:setLv(lv)
	self._lv = lv
end

function M:getLv()
	return self._lv
end

return M
