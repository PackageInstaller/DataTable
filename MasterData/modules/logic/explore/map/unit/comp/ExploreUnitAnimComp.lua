-- chunkname: @modules/logic/explore/map/unit/comp/ExploreUnitAnimComp.lua

module("modules.logic.explore.map.unit.comp.ExploreUnitAnimComp", package.seeall)

local ExploreUnitAnimComp = class("ExploreUnitAnimComp", LuaCompBase)

function ExploreUnitAnimComp:ctor(unit)
	self.unit = unit
	self._curAnim = nil
	self._curAnimHash = nil
	self._checkTime = 0
	self._playTime = 0
	self._showEffect = true
end

function ExploreUnitAnimComp:setup(go)
	self.animator = go:GetComponent(typeof(UnityEngine.Animator))

	if self.animator then
		self._goName = self.animator.runtimeAnimatorController.name
		self.animator.keepAnimatorStateOnDisable = true
	else
		self._goName = nil
	end

	if self._curAnim then
		self:playAnim(self._curAnim)
	else
		self:playIdleAnim()
	end
end

function ExploreUnitAnimComp:playIdleAnim()
	self:playAnim(self.unit:getIdleAnim(), true)
end

function ExploreUnitAnimComp:onUpdate()
	if not self.animator then
		return
	end

	if self:isIdleAnim() then
		return
	end

	if self.unit:needUpdateHeroPos() then
		local hero = ExploreController.instance:getMap():getHero()

		hero:setPos(hero:getPos())
	end

	local info = self.animator:GetCurrentAnimatorStateInfo(0)

	if self._curAnim == ExploreAnimEnum.AnimName.exit and info.normalizedTime >= 1 then
		self:onAnimPlayEnd(ExploreAnimEnum.AnimName.exit, nil)
	elseif self._curAnimHash ~= info.shortNameHash then
		self:onAnimPlayEnd(self._curAnim, ExploreAnimEnum.AnimHashToName[info.shortNameHash])
	end
end

function ExploreUnitAnimComp:onAnimPlayEnd(fromAnim, toAnim)
	self:_setCurAnimName(toAnim)
	self.unit:onAnimEnd(fromAnim, toAnim)
end

function ExploreUnitAnimComp:isIdleAnim(animName)
	animName = animName or self._curAnim

	return ExploreAnimEnum.LoopAnims[animName] or animName == nil
end

function ExploreUnitAnimComp:haveAnim(animName)
	if animName == nil then
		return false
	end

	if not self._goName then
		return false
	end

	return ExploreConfig.instance:getAnimLength(self._goName, animName)
end

function ExploreUnitAnimComp:playAnim(animName, noPlayOnceEffect)
	if not self.animator then
		self:_setCurAnimName(animName, noPlayOnceEffect)

		if ExploreAnimEnum.NextAnimName[animName] and ExploreAnimEnum.NextAnimName[animName] ~= animName then
			self.unit:onAnimEnd(animName, ExploreAnimEnum.NextAnimName[animName])
			self:playAnim(ExploreAnimEnum.NextAnimName[animName], noPlayOnceEffect)
		elseif not self:isIdleAnim(animName) then
			self.unit:onAnimEnd(animName, nil)
		end

		return
	end

	local noAnim

	if not self:haveAnim(animName) and ExploreAnimEnum.NextAnimName[animName] and ExploreAnimEnum.NextAnimName[animName] ~= animName then
		noAnim = animName
		animName = ExploreAnimEnum.NextAnimName[animName]
	end

	local preAnim = self._curAnim
	local preAnimHash = self._curAnimHash

	self:_setCurAnimName(animName, noPlayOnceEffect)

	local time = 0
	local info = self.animator:GetCurrentAnimatorStateInfo(0)

	if info.shortNameHash ~= preAnimHash then
		preAnimHash = info.shortNameHash
		preAnim = ExploreAnimEnum.AnimHashToName[info.shortNameHash]
	end

	if preAnimHash == self._curAnimHash then
		time = info.normalizedTime
	elseif self.unit:isPairAnim(preAnim, self._curAnim) then
		local len1 = ExploreConfig.instance:getAnimLength(self._goName, preAnim)
		local len2 = ExploreConfig.instance:getAnimLength(self._goName, self._curAnim)

		if len1 and len2 then
			time = len1 == len2 and 1 - info.normalizedTime or 1 - (len1 * info.normalizedTime - (len1 - len2)) / len2
			time = math.max(0, time)
		end
	end

	if self:haveAnim(animName) then
		self.animator:Play(animName, 0, time)
		self.animator:Update(0)
	end

	if noAnim then
		self.unit:onAnimEnd(noAnim, animName)
	end
end

function ExploreUnitAnimComp:setShowEffect(showEffect)
	self._showEffect = showEffect
end

function ExploreUnitAnimComp:_setCurAnimName(animName, noPlayOnceEffect)
	self._curAnim = animName
	self._curAnimHash = ExploreAnimEnum.AnimNameToHash[animName]

	if self.unit.animEffectComp and self._showEffect then
		self.unit.animEffectComp:playAnim(animName, noPlayOnceEffect)
	end
end

function ExploreUnitAnimComp:clear()
	if not self:isIdleAnim() then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitAnimEnd, self.unit.id, self._curAnim)
	end

	self._curAnim = nil
	self.animator = nil
end

function ExploreUnitAnimComp:onDestroy()
	self:clear()
end

return ExploreUnitAnimComp
