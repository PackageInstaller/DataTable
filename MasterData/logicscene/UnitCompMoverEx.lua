-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompMoverEx.lua

module("logicscene.scene.unit.component.UnitCompMoverEx", package.seeall)

local UnitCompMoverEx = class("UnitCompMoverEx", UnitComponentBase)

function UnitCompMoverEx:ctor(unit)
	UnitCompMoverEx.super.ctor(self, unit)

	self._mainPlayerUnit = nil
	self._disable = nil
end

function UnitCompMoverEx:onDestroy()
	self._unit = nil
	self._mainPlayerUnit = nil
end

function UnitCompMoverEx:disable(dis)
	self._disable = dis
end

function UnitCompMoverEx:setMainPlayerUnit(mainPlayerUnit)
	if self._mainPlayerUnit then
		self._mainPlayerUnit:RemovePosChangedListener()
	end

	self._mainPlayerUnit = mainPlayerUnit

	if self._mainPlayerUnit then
		self._mainPlayerUnit:AddPosChangedListener(self._onUnitPosChange, self)
	end
end

function UnitCompMoverEx:_onUnitPosChange(dirX, dirY, posX, posY)
	if self._disable then
		return
	end

	self._unit.transform:setPosOnly(posX, posY)
end

function UnitCompMoverEx:setJoystickListener(dirX, dirY)
	if self._disable then
		self._mainPlayerUnit:SetSpeed(0)

		return
	end

	if self._mainPlayerUnit then
		if not dirX or not dirY then
			self._mainPlayerUnit:SetSpeed(0)
		else
			self._mainPlayerUnit:SetMoveDir(dirX, dirY)
			self._unit.spineMover:playWalkAnim(dirX, dirY, 0.1)
			self._mainPlayerUnit:SetSpeed(self._unit.transform:getMoveSpeed())
		end
	end
end

return UnitCompMoverEx
