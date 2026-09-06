-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/model/SxGameOperateMo.lua

module("logic.extensions.sxgame.model.SxGameOperateMo", package.seeall)

local SxGameOperateMo = class("SxGameOperateMo")

function SxGameOperateMo:ctor()
	self._operatePos = nil
	self._remove_from_x = -1
	self._remove_from_y = -1
	self._remove_to_x = -1
	self._remove_to_y = -1
	self._special_remove = false
	self._special_type = 0
	self._special_effect = false
end

function SxGameOperateMo:initMO(pos, from_x, to_x, from_y, to_y, special, special_type, special_effect, type)
	self._operatePos = pos
	self._remove_from_x = from_x
	self._remove_from_y = from_y
	self._remove_to_x = to_x
	self._remove_to_y = to_y
	self._special_remove = special
	self._special_type = special_type
	self._special_effect = special_effect
	self._type = type
end

function SxGameOperateMo:checkSamePos(mo)
	return self._operatePos.x == mo._operatePos.x and self._operatePos.y == mo._operatePos.y
end

return SxGameOperateMo
