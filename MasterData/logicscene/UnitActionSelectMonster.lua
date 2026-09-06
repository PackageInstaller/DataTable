-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionSelectMonster.lua

module("logicscene.scene.unit.action.UnitActionSelectMonster", package.seeall)

local UnitActionSelectMonster = class("UnitActionSelectMonster", UnitActionGotoUnit)

function UnitActionSelectMonster:ctor(mstInsId)
	local scene = SceneMgr.instance:getCurScene()
	local unitMst = scene.unitFactory:getUnit(UnitTag.Monster, mstInsId)

	UnitActionSelectMonster.super.ctor(self, unitMst)

	self._mstInsId = mstInsId
end

function UnitActionSelectMonster:update(deltaTime)
	UnitActionSelectMonster.super.update(self, deltaTime)

	if self:isDone() and not self._toUnit.isDestroyed then
		self._unit:faceToUnit(self._toUnit)
		GlobalDispatcher:dispatch(GlobalNotify.SelectMonster, self._mstInsId)
	end
end

return UnitActionSelectMonster
