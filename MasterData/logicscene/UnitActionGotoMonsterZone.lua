-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionGotoMonsterZone.lua

module("logicscene.scene.unit.action.UnitActionGotoMonsterZone", package.seeall)

local UnitActionGotoMonsterZone = class("UnitActionGotoMonsterZone", UnitActionPathTo)

function UnitActionGotoMonsterZone:ctor(zoneId)
	local scene = SceneMgr.instance:getCurScene()

	self._wholeScene = scene.stage.wholeScene
	self._zoneId = zoneId

	local x, y = self._wholeScene:GetMonsterZonePos(self._zoneId, nil, nil)

	UnitActionGotoMonsterZone.super.ctor(self, x, y)
end

function UnitActionGotoMonsterZone:start(unit)
	UnitActionPathTo.super.start(self, unit)

	local px, py = self._unit.transform:getPos()

	if self._wholeScene:IsInMonsterZone(self._zoneId, px, py) then
		self._isDone = true
	else
		self:_startFindPath()
	end
end

return UnitActionGotoMonsterZone
