-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompSpineMover.lua

module("logicscene.scene.unit.component.UnitCompSpineMover", package.seeall)

local UnitCompSpineMover = class("UnitCompSpineMover", UnitComponentBase)
local cosAngle = math.cos(math.pi / 9)

function UnitCompSpineMover:ctor(unit)
	UnitCompSpineMover.super.ctor(self, unit)

	self._idleAnimState = UnitAnimState.Idle_Front
	self._walkAnimState = UnitAnimState.Walk_Front
	self._joysticOn = false
end

function UnitCompSpineMover:onInit()
	self._transform = self._unit.transform
	self._spine = self._unit.spine
	self._isIdling = true
end

function UnitCompSpineMover:playDefaultIdleAnim()
	self._isIdling = true

	self:_setIdleAnimState(UnitAnimState.Idle_Front)
	self:_playSpineAnim(self._idleAnimState, true)
end

function UnitCompSpineMover:joystickOn(isOn)
	self._joysticOn = isOn

	if not isOn then
		self:playIdleAnim()
	end
end

function UnitCompSpineMover:setAnimState(idleAnim, walkAnim)
	self:_setIdleAnimState(idleAnim)
	self:_setWalkAnimState(walkAnim)
end

function UnitCompSpineMover:_setIdleAnimState(animState)
	if not string.nilorempty(animState) then
		self._idleAnimState = animState
	end
end

function UnitCompSpineMover:_setWalkAnimState(animState)
	if not string.nilorempty(animState) then
		self._walkAnimState = animState
	end
end

function UnitCompSpineMover:getIdleAnimState()
	return self._idleAnimState
end

function UnitCompSpineMover:_onSpineLoaded()
	self._bornEffect = goutil.findChild(self._spine:getInst(), "hangPoints/fx_scene_renwuchuxian")

	self:unactiveBornEffect()
end

function UnitCompSpineMover:playBornEffect()
	goutil.setActive(self._bornEffect, true)
	settimer(2, self.unactiveBornEffect, self, false)
end

function UnitCompSpineMover:unactiveBornEffect()
	goutil.setActive(self._bornEffect, false)
end

function UnitCompSpineMover:playWalkAnim(dirX, dirY)
	self._isIdling = nil

	if dirX > 0 then
		self._spine:setDirection(UnitSpineDir.Right)
	elseif dirX < 0 then
		self._spine:setDirection(UnitSpineDir.Left)
	end

	if dirY > 0 then
		self:_setWalkAnimState(UnitAnimState.Walk_Back)
	elseif dirY < 0 then
		self:_setWalkAnimState(UnitAnimState.Walk_Front)
	end

	self:_playSpineAnim(self._walkAnimState, true)
end

function UnitCompSpineMover:playIdleAnim()
	self._isIdling = true

	if not self._joysticOn then
		if self._walkAnimState == UnitAnimState.Walk_Front then
			self:_setIdleAnimState(UnitAnimState.Idle_Front)
		else
			self:_setIdleAnimState(UnitAnimState.Idle_Back)
		end

		self:_playSpineAnim(self._idleAnimState, true)
	end
end

function UnitCompSpineMover:onUnitVisible(go)
	self:recordAllAnims(go)

	if self._isIdling then
		self:_playSpineAnim(self._idleAnimState, true)
	else
		self:_playSpineAnim(self._walkAnimState, true)
	end
end

function UnitCompSpineMover:onUnitInVisible(go)
	return
end

function UnitCompSpineMover:recordAllAnims(go)
	if not self._allAnims then
		local animNames = GoUtil.GetAllSpineAnimNames(go)

		if not animNames then
			return
		end

		self._allAnims = {}

		for i = 0, animNames.Length - 1 do
			if animNames[i] == UnitAnimState.Idle then
				self._allAnims[UnitAnimState.Idle] = true
			elseif animNames[i] == UnitAnimState.Idle_Front then
				self._allAnims[UnitAnimState.Idle_Front] = true
			elseif animNames[i] == UnitAnimState.Idle_Back then
				self._allAnims[UnitAnimState.Idle_Back] = true
			elseif animNames[i] == UnitAnimState.Walk then
				self._allAnims[UnitAnimState.Walk] = true
			elseif animNames[i] == UnitAnimState.Walk_Front then
				self._allAnims[UnitAnimState.Walk_Front] = true
			elseif animNames[i] == UnitAnimState.Walk_Back then
				self._allAnims[UnitAnimState.Walk_Back] = true
			else
				self._allAnims[animNames[i]] = true
			end
		end
	end
end

function UnitCompSpineMover:_playSpineAnim(anim, loop)
	if not self._allAnims then
		return
	end

	if self._allAnims[anim] then
		self._spine:play(anim, loop)
	else
		local isIdle = string.find(anim, "idle")

		if isIdle then
			if self._allAnims[UnitAnimState.Idle] then
				self._spine:play(UnitAnimState.Idle, loop)
			elseif self._allAnims[UnitAnimState.Idle_Front] then
				self._spine:play(UnitAnimState.Idle_Front, loop)
			elseif self._allAnims[UnitAnimState.Idle_Back] then
				self._spine:play(UnitAnimState.Idle_Back, loop)
			elseif self._allAnims[UnitAnimState.Idle_Side] then
				self._spine:play(UnitAnimState.Idle_Side, loop)
			end
		elseif self._allAnims[UnitAnimState.Walk] then
			self._spine:play(UnitAnimState.Walk, loop)
		elseif self._allAnims[UnitAnimState.Walk_Front] then
			self._spine:play(UnitAnimState.Walk_Front, loop)
		elseif self._allAnims[UnitAnimState.Walk_Back] then
			self._spine:play(UnitAnimState.Walk_Back, loop)
		elseif self._allAnims[UnitAnimState.Idle] then
			self._spine:play(UnitAnimState.Idle, loop)
		end
	end
end

return UnitCompSpineMover
