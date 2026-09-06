-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionPlayAnim.lua

module("logicscene.scene.unit.action.UnitActionPlayAnim", package.seeall)

local UnitActionPlayAnim = class("UnitActionPlayAnim", UnitActionBase)

function UnitActionPlayAnim:ctor(animName, duration)
	UnitActionPlayAnim.super.ctor(self)

	self._animName = x
	self._duration = duration
end

function UnitActionPlayAnim:start(unit)
	UnitActionPlayAnim.super.start(self, unit)
	self._unit.spine:play(self._animName, true)
end

function UnitActionPlayAnim:reverse()
	return UnitActionPlayAnim.New(self._animName, self._duration)
end

return UnitActionPlayAnim
