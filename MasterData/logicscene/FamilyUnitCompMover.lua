-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/family/FamilyUnitCompMover.lua

module("logicscene.scene.unit.component.family.FamilyUnitCompMover", package.seeall)

local FamilyUnitCompMover = class("FamilyUnitCompMover", UnitComponentBase)

function FamilyUnitCompMover:ctor(unit)
	FamilyUnitCompMover.super.ctor(self, unit)

	self._mainPlayerUnit = nil
	self._disable = nil
end

function FamilyUnitCompMover:onDestroy()
	self._unit = nil
	self._mainPlayerUnit = nil
end

function FamilyUnitCompMover:disable(dis)
	self._disable = dis
end

function FamilyUnitCompMover:setMainPlayerUnit(wholeScene)
	self._mainPlayerUnit = GameUtil.AddLuaOnce(self._unit.go, FamilySceneUnitMainPlayer)

	if self._mainPlayerUnit then
		self._mainPlayerUnit:AddPosChangedListener(self._onUnitPosChange, self)
		self._mainPlayerUnit:setWholeScene(wholeScene)
	end
end

function FamilyUnitCompMover:_onUnitPosChange(dirX, dirY, posX, posY)
	if self._disable then
		return
	end

	self._unit.transform:setPosOnly(posX, 0, posY)
end

function FamilyUnitCompMover:setJoystickListener(dirX, dirY)
	if self._disable then
		self._mainPlayerUnit:SetSpeed(0)

		return
	end

	if self._mainPlayerUnit then
		if not dirX or not dirY then
			self._mainPlayerUnit:SetSpeed(0)
		else
			self._mainPlayerUnit:SetMoveDir(dirX, 0, dirY)
			self._unit.spineMover:playWalkAnim(dirX, dirY, 0.1)
			self._mainPlayerUnit:SetSpeed(self._unit.transform:getMoveSpeed() * FamilyScene.PlayerSpeed)
		end
	end
end

return FamilyUnitCompMover
