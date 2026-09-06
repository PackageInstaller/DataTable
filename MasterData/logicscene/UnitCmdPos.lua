-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/cmd/UnitCmdPos.lua

module("logicscene.scene.unit.cmd.UnitCmdPos", package.seeall)

local UnitCmdPos = class("UnitCmdPos", UnitCmdBase)

function UnitCmdPos:ctor(x, y, isTeleport)
	UnitCmdPos.super.ctor(self)

	self._x = x
	self._y = y
	self.underBridge = false
	self._isTeleport = isTeleport
end

function UnitCmdPos:cmdType()
	return UnitCmdType.Move
end

function UnitCmdPos:toAction()
	if self._isTeleport then
		return nil
	end

	if not GameUtil.isInFrustum(self._x, self._y) then
		return nil
	end

	return UnitActionOtherPlayerMove.New(self._x, self._y, nil, nil, true), self._handleBridge, self
end

function UnitCmdPos:runCmd(unit)
	unit.transform:setPos(self._x, self._y, nil, self._isTeleport)
	unit:setUnderBridge(self.underBridge)
end

function UnitCmdPos:_handleBridge(unit)
	unit:setUnderBridge(self.underBridge)
end

return UnitCmdPos
