-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/model/ThreeEliminationOperateMo.lua

module("logic.extensions.threeelimination.model.ThreeEliminationOperateMo", package.seeall)

local ThreeEliminationOperateMo = class("ThreeEliminationOperateMo")

function ThreeEliminationOperateMo:ctor()
	self._operatePos = nil
	self._remove_to_x = -1
	self._remove_to_y = -1
end

function ThreeEliminationOperateMo:initMO(pos, to_x, to_y, type)
	self._operatePos = pos
	self._remove_to_x = to_x
	self._remove_to_y = to_y
	self._type = type
	self._showEffect = true
end

function ThreeEliminationOperateMo:checkSamePos(mo)
	return self._operatePos.x == mo._operatePos.x and self._operatePos.y == mo._operatePos.y
end

return ThreeEliminationOperateMo
