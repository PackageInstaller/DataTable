-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionAnimator.lua

module("logicscene.scene.unit.action.UnitActionAnimator", package.seeall)

local UnitActionAnimator = class("UnitActionAnimator", UnitActionBase)

function UnitActionAnimator:ctor(unit)
	UnitActionAnimator.super.ctor(self, unit)
end

function UnitActionAnimator:start(unit)
	UnitActionAnimator.super.start(self, unit)
end

function UnitActionAnimator:update(deltaTime)
	UnitActionAnimator.super.update(self, deltaTime)
end

function UnitActionAnimator:isDone()
	return nil
end

return UnitActionAnimator
