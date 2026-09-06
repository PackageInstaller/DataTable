-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/model/ThreeEliminationCellMO.lua

module("logic.extensions.threeelimination.model.ThreeEliminationCellMO", package.seeall)

local ThreeEliminationCellMO = class("ThreeEliminationCellMO")

function ThreeEliminationCellMO:ctor()
	self._type = 0
	self._x = 0
	self._y = 0
end

function ThreeEliminationCellMO:initCell()
	return
end

return ThreeEliminationCellMO
