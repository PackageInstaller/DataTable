-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/cutepet/UnitCompCutePetMover.lua

module("logicscene.scene.unit.component.cutepet.UnitCompCutePetMover", package.seeall)

local UnitCompCutePetMover = class("UnitCompCutePetMover", UnitComponentBase)

function UnitCompCutePetMover:ctor(unit)
	UnitCompCutePetMover.super.ctor(self, unit)

	self._animIdleStateList = {
		UnitAnimState.Touch,
		UnitAnimState.Eat,
		UnitAnimState.Idle
	}
	self._joysticOn = false
	self._lastDirX = 0
	self._lastDirY = 0
	self._tinyMoveCount = 0
end

function UnitCompCutePetMover:onInit()
	self._transform = self._unit.transform
	self._spine = self._unit.spine
	self._isIdling = true
end

function UnitCompCutePetMover:playDefaultIdleAnim()
	self._isIdling = true

	self:_playAnimatorAnim(UnitAnimState.Idle, true)
end

function UnitCompCutePetMover:joystickOn(isOn)
	self._joysticOn = isOn

	if not isOn then
		self:playIdleAnim()
	end
end

function UnitCompCutePetMover:isJoystickOn()
	return self._joysticOn
end

function UnitCompCutePetMover:setAnimState(idleAnim, walkAnim)
	return
end

function UnitCompCutePetMover:getIdleAnimState()
	return self._idleAnimState
end

function UnitCompCutePetMover:_onSpineLoaded()
	self._bornEffect = goutil.findChild(self._spine:getInst(), "hangPoints/fx_scene_renwuchuxian")

	self:unactiveBornEffect()
end

function UnitCompCutePetMover:playBornEffect()
	goutil.setActive(self._bornEffect, true)
	settimer(2, self.unactiveBornEffect, self, false)
end

function UnitCompCutePetMover:unactiveBornEffect()
	goutil.setActive(self._bornEffect, false)
end

function UnitCompCutePetMover:playWalkAnim(dirX, dirY, rotateSpd)
	self._isIdling = nil

	local y = GameUtil.getRotationYByDir(dirX, dirY)

	if y then
		self._unit.transform:setLocalRotationY(y, nil, rotateSpd)
	end

	self:_playAnimatorAnim(UnitAnimState.Walk2, true)
end

function UnitCompCutePetMover:playIdleAnim()
	self._isIdling = true

	if not self._joysticOn then
		self:_playAnimatorAnim(UnitAnimState.Idle, true)

		local randomNum = math.random(1, #self._animIdleStateList)

		self:_playAnimatorAnim(self._animIdleStateList[randomNum], true)
	end
end

function UnitCompCutePetMover:forceIdleAnim()
	self._isIdling = true

	self._unit:setVisible(false)
	self._unit:setVisible(true)
end

function UnitCompCutePetMover:onUnitVisible(go)
	if self._isIdling then
		self:_playAnimatorAnim(UnitAnimState.Idle, true)
	else
		self:_playAnimatorAnim(UnitAnimState.Walk2, true)
	end
end

function UnitCompCutePetMover:onUnitInVisible(go)
	return
end

function UnitCompCutePetMover:_playAnimatorAnim(anim, loop)
	self._spine:play(anim, loop)
end

function UnitCompCutePetMover:setActive(visible)
	if visible then
		if self._isIdling then
			self:_playAnimatorAnim(UnitAnimState.Idle, true)
		else
			self:_playAnimatorAnim(UnitAnimState.Walk2, true)
		end
	end
end

return UnitCompCutePetMover
