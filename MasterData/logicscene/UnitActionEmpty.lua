-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionEmpty.lua

module("logicscene.scene.unit.action.UnitActionEmpty", package.seeall)

local UnitActionEmpty = class("UnitActionEmpty", UnitActionBase)

function UnitActionEmpty:ctor(duration)
	UnitActionEmpty.super.ctor(self)

	self._duration = duration
end

function UnitActionEmpty:update(deltaTime)
	self._elapsed = self._elapsed + deltaTime
end

function UnitActionEmpty:reverse()
	return UnitActionEmpty.New(self._duration)
end

return UnitActionEmpty
