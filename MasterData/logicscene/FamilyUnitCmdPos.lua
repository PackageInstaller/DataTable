-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/cmd/FamilyUnitCmdPos.lua

module("logicscene.scene.unit.cmd.FamilyUnitCmdPos", package.seeall)

local FamilyUnitCmdPos = class("FamilyUnitCmdPos", UnitCmdBase)

function FamilyUnitCmdPos:ctor(x, z, startX, startZ, isTeleport)
	UnitCmdPos.super.ctor(self)

	self._x = x
	self._z = z
	self._startX = x
	self._startZ = z
	self.underBridge = false
	self._isTeleport = isTeleport
end

function FamilyUnitCmdPos:cmdType()
	return UnitCmdType.Move
end

function FamilyUnitCmdPos:toAction()
	return UnitActionFamilyOtherPlayerMove.New(self._x, self._z, self._startX, self._startZ), self._handleBridge, self
end

function FamilyUnitCmdPos:runCmd(unit)
	unit.transform:setPos(self._x, 0, self._z, self._isTeleport)
	unit:setUnderBridge(self.underBridge)
end

function FamilyUnitCmdPos:_handleBridge(unit)
	unit:setUnderBridge(self.underBridge)
end

return FamilyUnitCmdPos
