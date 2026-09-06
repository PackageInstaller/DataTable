-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/animation/UnitCompAnimatorMover.lua

module("logicscene.scene.unit.component.animation.UnitCompAnimatorMover", package.seeall)

local UnitCompAnimatorMover = class("UnitCompAnimatorMover", UnitComponentBase)

function UnitCompAnimatorMover:ctor(unit)
	UnitCompAnimatorMover.super.ctor(self, unit)

	self._joysticOn = false
	self._lastDirX = 0
	self._lastDirY = 0
	self._tinyMoveCount = 0
end

function UnitCompAnimatorMover:onInit()
	self._transform = self._unit.transform
	self._spine = self._unit.spine
	self._isIdling = true
end

function UnitCompAnimatorMover:playDefaultIdleAnim()
	self._isIdling = true

	self:_playAnimatorAnim(MainPlayerAnimState.Idle, true)
end

function UnitCompAnimatorMover:joystickOn(isOn)
	self._joysticOn = isOn

	if not isOn then
		self:playIdleAnim()
	end
end

function UnitCompAnimatorMover:isJoystickOn()
	return self._joysticOn
end

function UnitCompAnimatorMover:setAnimState(idleAnim, walkAnim)
	return
end

function UnitCompAnimatorMover:getIdleAnimState()
	return self._idleAnimState
end

function UnitCompAnimatorMover:_onSpineLoaded()
	self._bornEffect = goutil.findChild(self._spine:getInst(), "hangPoints/fx_scene_renwuchuxian")

	self:unactiveBornEffect()
end

function UnitCompAnimatorMover:playBornEffect()
	goutil.setActive(self._bornEffect, true)
	settimer(2, self.unactiveBornEffect, self, false)
end

function UnitCompAnimatorMover:unactiveBornEffect()
	goutil.setActive(self._bornEffect, false)
end

function UnitCompAnimatorMover:playWalkAnim(dirX, dirY, rotateSpd)
	self._isIdling = nil

	local y = GameUtil.getRotationYByDir(dirX, dirY)

	if y then
		self._unit.transform:setLocalRotationY(y, nil, rotateSpd)
	end

	self:_playAnimatorAnim(MainPlayerAnimState.Move, true)
end

function UnitCompAnimatorMover:playIdleAnim()
	self._isIdling = true

	if not self._joysticOn then
		self:_playAnimatorAnim(MainPlayerAnimState.Idle, true)
	end
end

function UnitCompAnimatorMover:forceIdleAnim()
	self._isIdling = true

	self._unit:setVisible(false)
	self._unit:setVisible(true)
end

function UnitCompAnimatorMover:onUnitVisible(go)
	if self._isIdling then
		self:_playAnimatorAnim(MainPlayerAnimState.Idle, true)
	else
		self:_playAnimatorAnim(MainPlayerAnimState.Move, true)
	end
end

function UnitCompAnimatorMover:onUnitInVisible(go)
	return
end

function UnitCompAnimatorMover:_playAnimatorAnim(anim, loop)
	self._spine:play(anim, loop)
end

function UnitCompAnimatorMover:setActive(visible)
	if visible then
		if self._isIdling then
			self:_playAnimatorAnim(MainPlayerAnimState.Idle, true)
		else
			self:_playAnimatorAnim(MainPlayerAnimState.Move, true)
		end
	end
end

return UnitCompAnimatorMover
