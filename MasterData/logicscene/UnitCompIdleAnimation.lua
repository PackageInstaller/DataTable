-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/animation/UnitCompIdleAnimation.lua

module("logicscene.scene.unit.component.animation.UnitCompIdleAnimation", package.seeall)

local UnitCompIdleAnimation = class("UnitCompIdleAnimation", UnitComponentBase)

function UnitCompIdleAnimation:ctor(unit)
	UnitCompIdleAnimation.super.ctor(self, unit)
	self._unit.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
end

function UnitCompIdleAnimation:onDestroy()
	self._unit.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)

	if self._animationPlayer then
		local animationPlayer = self._animationPlayer

		self._animationPlayer = nil

		animationPlayer:Stop()
	end

	UnitCompIdleAnimation.super.onDestroy(self)
end

function UnitCompIdleAnimation:onMountLoadedFinish(mount)
	self:stopAnimation()
end

function UnitCompIdleAnimation:onUnitVisible(go)
	return
end

function UnitCompIdleAnimation:onPlayerBodyLoaded()
	self:stopAnimation()

	self._timeCount = 0
	self._isPlayerBodyLoaded = true

	local avatarMo = self._unit.spine:getAvatarMo()
	local suits = DressConfig.instance:getAllSuitCfgs()

	self._suitAnimation = nil
	self._isWaiting = false

	for i = 1, #suits do
		if avatarMo:isDressSuit(suits[i].include) then
			self._suitAnimation = suits[i].animation

			break
		end
	end
end

function UnitCompIdleAnimation:update(deltaTime)
	if self:_canPlayAnimation() and not self._isWaiting then
		self._timeCount = self._timeCount + deltaTime

		if self._timeCount >= 3 then
			self._isWaiting = true

			self._unit.scene.idleAnimations:waitingPlayAnimation(self._unit)
		end
	end
end

function UnitCompIdleAnimation:_visiblePendants(visible)
	local avatar = self._unit.spine:getAvatar()

	if avatar then
		for k, v in pairs(AvatarPendantType) do
			if v ~= AvatarPendantType.Hair then
				avatar.pendantsCtrl:setVisibleByType(v, visible)
			end
		end
	end
end

function UnitCompIdleAnimation:startPlayAnimation()
	if self:_canPlayAnimation() and self._isWaiting then
		self._isWaiting = false

		self:_visiblePendants(false)

		self._animationPlayer = AvatarAnimationPlayer.playWithUnit(self._unit, "storyconfig/animations/charactors/" .. self._suitAnimation .. ".txt", self._onAnimPlayFinish, self._onAnimPlayStart, self)
	end
end

function UnitCompIdleAnimation:_canPlayAnimation()
	if self._unit.scene and self._unit.scene.idleAnimations and self._isPlayerBodyLoaded and self._unit:isVisible() and self._unit.spine:getAnimState() == MainPlayerAnimState.Idle and not self._animationPlayer and not string.nilorempty(self._suitAnimation) then
		return true
	end
end

function UnitCompIdleAnimation:setActive(active)
	if not active then
		self:_forceStopAnimation()
	end
end

function UnitCompIdleAnimation:onUnitInVisible(go)
	self:_forceStopAnimation()

	self._isPlayerBodyLoaded = false
	self._suitAnimation = nil
	self._ingAutoResumeIdleAnim = nil
end

function UnitCompIdleAnimation:_forceStopAnimation()
	if self._unit.scene and self._unit.scene.idleAnimations then
		self._unit.scene.idleAnimations:stopPlayAnimation(self._unit)
		self._unit.scene.idleAnimations:stopWaitingPlayAnimation(self._unit)
	end

	self:_visiblePendants(true)

	self._timeCount = 0
	self._isWaiting = false

	self:stopAnimation()
end

function UnitCompIdleAnimation:isPlayingIdleAnim()
	return self._animationPlayer ~= nil
end

function UnitCompIdleAnimation:_onAnimPlayFinish()
	if not self._animationPlayer then
		return
	end

	self:_resumeMount()
	self:_visiblePendants(true)

	self._animationPlayer = nil
	self._timeCount = 0
	self._isWaiting = false

	if not self._ingAutoResumeIdleAnim then
		self._unit.spine:play(MainPlayerAnimState.Idle)
	end

	self._ingAutoResumeIdleAnim = nil

	if self._unit.scene.idleAnimations then
		self._unit.scene.idleAnimations:onPlayAnimationFinish(self._unit)
	end
end

function UnitCompIdleAnimation:stopAnimation()
	if self._animationPlayer then
		self._animationPlayer:Stop()

		self._animationPlayer = nil
	end
end

function UnitCompIdleAnimation:_onUnitPosChanged()
	self._ingAutoResumeIdleAnim = true

	self:_resumeMount()
	self:_forceStopAnimation()

	self._ingAutoResumeIdleAnim = nil
end

function UnitCompIdleAnimation:_resumeMount()
	if self._animationPlayer then
		GlobalDispatcher:dispatch(GlobalNotify.OnPlayerVariables, self._unit.id)
	end
end

return UnitCompIdleAnimation
