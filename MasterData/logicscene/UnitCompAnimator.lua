-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/animation/UnitCompAnimator.lua

module("logicscene.scene.unit.component.animation.UnitCompAnimator", package.seeall)

local UnitCompAnimator = class("UnitCompAnimator", UnitComponentBase)

function UnitCompAnimator:ctor(unit)
	UnitCompAnimator.super.ctor(self, unit)

	self._url = nil
	self._skeletonLoader = PrefabLoader.Get(unit.go)
	self._animator = nil
	self.go = nil
	self._defaultAnimState = "idle"
	self._curAnimState = nil
	self._isLoop = true
	self._playSpeed = 1

	if unit:getTag() ~= UnitTag.Npc then
		Framework.TransformUtil.SetLocalRotation(unit.go.transform, -20, 0, 0)
	end
end

function UnitCompAnimator:setPlaySpeed(playSpeed)
	if self._playSpeed == playSpeed then
		return
	end

	self._playSpeed = playSpeed

	self:_updatePlaySpeed()
end

function UnitCompAnimator:getPlaySpeed()
	return self._playSpeed
end

function UnitCompAnimator:_updatePlaySpeed()
	return
end

function UnitCompAnimator:setDefaultAnimState(animState)
	self._defaultAnimState = animState
end

function UnitCompAnimator:getSkeletonAnimation()
	return
end

function UnitCompAnimator:setBody(url)
	if self._url == url then
		return
	end

	self:clear()

	if not url then
		return
	end

	self._url = url

	self._skeletonLoader:load(url, self._onBodyLoaded, self, true)
end

function UnitCompAnimator:getInst()
	return self._skeletonLoader:getInst()
end

function UnitCompAnimator:getAnimator()
	return self._animator
end

function UnitCompAnimator:_onBodyLoaded(loader)
	self.go = self._skeletonLoader:getInst()
	self.go.name = self._unit.go.name

	self:InitAnimator(self.go)
	self:setupRootAndLayer()
	self.dispatch(self, UnitNotify.SpineLoaded, self)
end

function UnitCompAnimator:InitAnimator(skeletonGO)
	if skeletonGO then
		self._animator = skeletonGO:GetComponent(typeof(UnityEngine.Animator))
	end
end

function UnitCompAnimator:setupRootAndLayer()
	local parent = self._unit.mountRoot:getAvatarRoot()

	goutil.addChildToParent(self.go, parent)

	self.go.layer = parent.layer
end

function UnitCompAnimator:play(animState, isLoop, isForceRestart)
	if self._animator then
		self._curAnimState = animState

		if animState == MainPlayerAnimState.Idle then
			self._animator:SetBool(AnimatorHash.animWalk, false)
		elseif animState == MainPlayerAnimState.Move then
			self._animator:SetBool(AnimatorHash.animWalk, true)
		elseif animState == MainPlayerAnimState.Greet then
			self._animator:SetTrigger(AnimatorHash.animGreet)
		end
	end
end

function UnitCompAnimator:fixedCrossTo(animState, time)
	if self._animator then
		self._curAnimState = animState

		self._animator:CrossFadeInFixedTime(animState, time)
	end
end

function UnitCompAnimator:getAnimState()
	local state

	return (self._animator or nil) and self._curAnimState or self._defaultAnimState
end

function UnitCompAnimator:setGameObject(go)
	self.go = go

	if self.go then
		self:InitAnimator(self.go)
		self:setupRootAndLayer()
	else
		self._animator = nil
		self._url = nil
	end
end

function UnitCompAnimator:clear()
	if self._skeletonLoader then
		self._skeletonLoader:clear()
	end

	self._url = nil
	self._animator = nil
end

function UnitCompAnimator:onDestroy()
	if self._skeletonLoader then
		self._skeletonLoader:clear()
	end

	self._skeletonLoader = nil
	self._animator = nil
	self._url = nil
end

function UnitCompAnimator:onUnitVisible(go)
	self:setGameObject(go)
end

function UnitCompAnimator:onUnitInVisible(go)
	self:setGameObject()
end

return UnitCompAnimator
