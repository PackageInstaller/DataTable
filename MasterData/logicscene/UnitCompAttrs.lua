-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/UnitCompAttrs.lua

module("logicscene.scene.unit.component.battle.UnitCompAttrs", package.seeall)

local UnitCompAttrs = class("UnitCompAttrs", UnitComponentBase)

function UnitCompAttrs:onInit()
	self._attributes = nil
	self._maxHp = 0
	self._curHp = 0
	self._birthX = 0
	self._birthY = 0
	self._birthZ = 0
	self._curVigour = 0
	self._maxVigour = 0
	self._name = nil
	self._otherName = nil
	self._level = 0
	self._fightingPower = 0
	self._originRaceId = 0
	self._originSkinId = 0
	self._currTempHp = 0
	self._isRepeling = 0
	self._isBacking = 0
	self._isUsingSkill = 0
	self._isHitflying = 0
	self._isHarding = 0
	self._isDodging = 0
	self._isBlocking = 0
	self._isImmunity = 0
	self._isDead = 0
	self._isPlayingAnim = 0
	self._isCollisionLocking = 0
	self._isSkillLocking = 0
	self._isFakingFmt = false
	self._isWaitingItemUsing = 0
	self._isCatchable = nil
	self._isItemUsing = 0
	self._isTransforming = 0
	self._isItemUsedLocking = 0
	self.deadAnimFinished = nil
	self._awakenLv = 0
	self._curShield = 0
	self._isCombineUnit = nil
	self._isCombinedSource = nil
	self._isBeingSummoned = false
	self._transPosition = false
	self._triggerTransPosition = false
	self._isOraclePet = false
	self._isInvisible = 0
	self._frozen = 0
	self._isTransrent = 0
	self._performingAttackRound = 0
	self._isUsingSpiritInvocation = false
end

function UnitCompAttrs:setPerformingAttackRound(performingAttackRound)
	self._performingAttackRound = performingAttackRound and self._performingAttackRound + 1 or self._performingAttackRound - 1
end

function UnitCompAttrs:isPerformingAttackRound()
	return self._performingAttackRound > 0
end

function UnitCompAttrs:setTransrent(isTransrent)
	self._isTransrent = isTransrent and self._isTransrent + 1 or self._isTransrent - 1
end

function UnitCompAttrs:isTransrent()
	return self._isTransrent > 0
end

function UnitCompAttrs:setFrozen(frozen)
	self._frozen = frozen and self._frozen + 1 or self._frozen - 1
end

function UnitCompAttrs:isFrozen()
	return self._frozen > 0
end

function UnitCompAttrs:setInvisible(isInvisible)
	self._isInvisible = isInvisible and self._isInvisible + 1 or self._isInvisible - 1
end

function UnitCompAttrs:isInvisible()
	return self._isInvisible > 0
end

function UnitCompAttrs:setTriggerTransPosition(triggerTransPosition)
	self._triggerTransPosition = triggerTransPosition
end

function UnitCompAttrs:isTriggerTransPosition()
	return self._triggerTransPosition
end

function UnitCompAttrs:setTransPosition(transPosition)
	self._transPosition = transPosition
end

function UnitCompAttrs:isTransPosition()
	return self._transPosition
end

function UnitCompAttrs:setBeingSummoned(isBeingSummoned)
	self._isBeingSummoned = isBeingSummoned
end

function UnitCompAttrs:isBeingSummoned()
	return self._isBeingSummoned
end

function UnitCompAttrs:setCombineUnit(isCombineUnit)
	self._isCombineUnit = isCombineUnit
end

function UnitCompAttrs:isCombineUnit()
	return self._isCombineUnit
end

function UnitCompAttrs:setCombinedSource(isCombinedSource)
	self._isCombinedSource = isCombinedSource
end

function UnitCompAttrs:isCombinedSource()
	return self._isCombinedSource
end

function UnitCompAttrs:setOriginSkinId(skinId)
	self._originSkinId = skinId
end

function UnitCompAttrs:getOriginSkinId()
	return self._originSkinId
end

function UnitCompAttrs:getOriginRaceId()
	if self._originRaceId == 0 then
		self._originRaceId = self._originSkinId

		local skinId = self._originSkinId

		if skinId > 0 then
			local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

			if cfg then
				self._originRaceId = cfg.raceId
			end
		end
	end

	return self._originRaceId
end

function UnitCompAttrs:setFightingPower(fightingPower)
	self._fightingPower = fightingPower
end

function UnitCompAttrs:getFightingPower()
	return self._fightingPower
end

function UnitCompAttrs:setAttributes(attributes)
	self._attributes = attributes

	self._unit.unitUI:setAttrs(attributes)
end

function UnitCompAttrs:getAttributes()
	return self._attributes
end

function UnitCompAttrs:setBirthPoint(x, y, z)
	self._birthX = x
	self._birthY = y
	self._birthZ = z
end

function UnitCompAttrs:getBirthPoint()
	return self._birthX, self._birthY, self._birthZ
end

function UnitCompAttrs:setMaxHp(maxHp)
	self._maxHp = maxHp

	self._unit.unitUI:onHpChange(self._currTempHp, self._maxHp)
end

function UnitCompAttrs:getMaxHp()
	return self._maxHp
end

function UnitCompAttrs:setAwakenLv(awakenLv)
	self._awakenLv = awakenLv
end

function UnitCompAttrs:getAwakenLv()
	return self._awakenLv
end

function UnitCompAttrs:setCurHp(curHp)
	if curHp < 0 then
		curHp = 0
	end

	if curHp > self._maxHp then
		curHp = self._maxHp
	end

	self._curHp = curHp
end

function UnitCompAttrs:addCurHp(hpChange)
	local curHp = hpChange + self._curHp

	self:setCurHp(curHp)
end

function UnitCompAttrs:getCurHp()
	return self._curHp
end

function UnitCompAttrs:addCurTempHp(hpChange)
	local curHp = hpChange + self._currTempHp

	self:setCurTempHp(curHp)
end

function UnitCompAttrs:setCurTempHp(curHp)
	if curHp < 0 then
		curHp = 0
	end

	if curHp > self._maxHp then
		curHp = self._maxHp
	end

	self._currTempHp = curHp

	self._unit.unitUI:onHpChange(self._currTempHp, self._maxHp)
end

function UnitCompAttrs:getCurTempHp()
	return self._currTempHp
end

function UnitCompAttrs:setCurVigour(curVigour)
	if curVigour < 0 then
		curVigour = 0
	end

	self._curVigour = curVigour

	self._unit.unitUI:onVigourChange(self._curVigour, self._maxVigour)
end

function UnitCompAttrs:getCurVigour()
	return self._curVigour
end

function UnitCompAttrs:setMaxVigour(maxVigour)
	self._maxVigour = maxVigour

	self._unit.unitUI:onVigourChange(self._curVigour, self._maxVigour)
end

function UnitCompAttrs:getMaxVigour()
	return self._maxVigour
end

function UnitCompAttrs:addCurVigour(vigourChange)
	local curVigour = vigourChange + self._curVigour

	self:setCurVigour(curVigour)
end

function UnitCompAttrs:addCurShield(shieldChange)
	local curShield = shieldChange + self._curShield

	self:setCurShield(curShield)
end

function UnitCompAttrs:setCurShield(curShield)
	if curShield < 0 then
		curShield = 0
	end

	self._curShield = curShield
end

function UnitCompAttrs:getCurShield()
	return self._curShield
end

function UnitCompAttrs:setName(name)
	self._name = name

	self._unit.unitUI:setName(name)
end

function UnitCompAttrs:getName()
	return self._name
end

function UnitCompAttrs:setOtherName(name)
	self._otherName = name

	self._unit.unitUI:setName(name)
end

function UnitCompAttrs:getOtherName()
	return self._otherName
end

function UnitCompAttrs:setLevel(level)
	self._level = level

	self._unit.unitUI:setLevel(level)
end

function UnitCompAttrs:getLevel()
	return self._level
end

function UnitCompAttrs:setRepeling(isRepeling)
	self._isRepeling = isRepeling and self._isRepeling + 1 or self._isRepeling - 1
end

function UnitCompAttrs:isRepeling()
	return self._isRepeling > 0
end

function UnitCompAttrs:setBacking(isBacking)
	self._isBacking = isBacking and self._isBacking + 1 or self._isBacking - 1
end

function UnitCompAttrs:isBacking()
	return self._isBacking > 0
end

function UnitCompAttrs:setHitflying(isHitflying)
	self._isHitflying = isHitflying and self._isHitflying + 1 or self._isHitflying - 1
end

function UnitCompAttrs:isHitflying()
	return self._isHitflying > 0
end

function UnitCompAttrs:setUsingSkill(isUsingSkill)
	self._isUsingSkill = isUsingSkill and self._isUsingSkill + 1 or self._isUsingSkill - 1
end

function UnitCompAttrs:isUsingSkill()
	return self._isUsingSkill > 0
end

function UnitCompAttrs:setHadring(isHadring)
	self._isHarding = isHadring and self._isHarding + 1 or self._isHarding - 1
end

function UnitCompAttrs:isHadring()
	return self._isHarding > 0
end

function UnitCompAttrs:setDodging(isDodging)
	self._isDodging = isDodging and self._isDodging + 1 or self._isDodging - 1
end

function UnitCompAttrs:isDodging()
	return self._isDodging > 0
end

function UnitCompAttrs:setBlocking(isBlocking)
	self._isBlocking = isBlocking and self._isBlocking + 1 or self._isBlocking - 1
end

function UnitCompAttrs:isBlocking()
	return self._isBlocking > 0
end

function UnitCompAttrs:setImmunity(isImmunity)
	self._isImmunity = isImmunity and self._isImmunity + 1 or self._isImmunity - 1
end

function UnitCompAttrs:isImmunity()
	return self._isImmunity > 0
end

function UnitCompAttrs:setDead(isDead)
	self._isDead = isDead and self._isDead + 1 or self._isDead - 1
end

function UnitCompAttrs:isDead()
	return self._isDead > 0
end

function UnitCompAttrs:setAnimation(isPlayingAnim)
	self._isPlayingAnim = isPlayingAnim and self._isPlayingAnim + 1 or self._isPlayingAnim - 1
end

function UnitCompAttrs:isPlayingAnim()
	return self._isPlayingAnim > 0
end

function UnitCompAttrs:setCollisionLocking(isCollisionLocking)
	self._isCollisionLocking = isCollisionLocking and self._isCollisionLocking + 1 or self._isCollisionLocking - 1
end

function UnitCompAttrs:isCollisionLocking()
	return self._isCollisionLocking > 0
end

function UnitCompAttrs:setSkillLocking(isSkillLocking)
	if isSkillLocking then
		self._isSkillLocking = self._isSkillLocking + 1
	elseif self._isSkillLocking > 0 then
		self._isSkillLocking = self._isSkillLocking - 1
	end
end

function UnitCompAttrs:isSkillLocking()
	return self._isSkillLocking > 0
end

function UnitCompAttrs:setFakingFmt(isFakingFmt)
	self._isFakingFmt = isFakingFmt
end

function UnitCompAttrs:isFakingFmt()
	return self._isFakingFmt
end

function UnitCompAttrs:setCatchable(isCatchable)
	self._isCatchable = isCatchable
end

function UnitCompAttrs:isCatchable()
	return self._isCatchable
end

function UnitCompAttrs:setItemUsing(isItemUsing)
	self._isItemUsing = isItemUsing and self._isItemUsing + 1 or self._isItemUsing - 1
end

function UnitCompAttrs:isItemUsing()
	return self._isItemUsing > 0
end

function UnitCompAttrs:setWaitingItemUsing(isWaitingItemUsing)
	self._isWaitingItemUsing = isWaitingItemUsing and self._isWaitingItemUsing + 1 or self._isWaitingItemUsing - 1
end

function UnitCompAttrs:isWaitingItemUsing()
	return self._isWaitingItemUsing > 0
end

function UnitCompAttrs:setItemUsedLocking(isItemUsedLocking)
	self._isItemUsedLocking = isItemUsedLocking and self._isItemUsedLocking + 1 or self._isItemUsedLocking - 1
end

function UnitCompAttrs:isItemUsedLocking()
	return self._isItemUsedLocking > 0
end

function UnitCompAttrs:setIsTransforming(isTransforming)
	if isTransforming then
		self._isTransforming = self._isTransforming + 1
	elseif self._isTransforming > 0 then
		self._isTransforming = self._isTransforming - 1
	end
end

function UnitCompAttrs:isTransforming()
	return self._isTransforming > 0
end

function UnitCompAttrs:setSummonedCharacter(isSummonedCharacter)
	self._isSummonedCharacter = isSummonedCharacter
end

function UnitCompAttrs:isSummonedCharacter()
	return self._isSummonedCharacter
end

function UnitCompAttrs:setHaveBeenSummoned(isHaveBeenSummoned)
	self._isHaveBeenSummoned = isHaveBeenSummoned
end

function UnitCompAttrs:isHaveBeenSummoned()
	return self._isHaveBeenSummoned
end

function UnitCompAttrs:setIsOraclePet(isOraclePet)
	self._isOraclePet = isOraclePet
end

function UnitCompAttrs:IsOraclePet()
	return self._isOraclePet
end

function UnitCompAttrs:setIsDoppelganger(isDoppelganger)
	self._isDoppelganger = isDoppelganger
end

function UnitCompAttrs:isDoppelganger()
	return self._isDoppelganger
end

function UnitCompAttrs:setHaveBeenDoppelgangerCreated(isHaveBeenDoppelgangerCreated)
	self._isHaveBeenDoppelgangerCreated = isHaveBeenDoppelgangerCreated
end

function UnitCompAttrs:isFakePet()
	return self:IsOraclePet() or self:isDoppelganger()
end

function UnitCompAttrs:isHaveBeenDoppelgangerCreated()
	return self._isHaveBeenDoppelgangerCreated
end

function UnitCompAttrs:checkDoppelgangerVisible()
	if not self._isDoppelganger then
		return true
	else
		return self._isHaveBeenDoppelgangerCreated
	end
end

function UnitCompAttrs:setTJSummonedCharacter(isHeavenAwakenSummonedCharacter)
	self._isHeavenAwakenSummonedCharacter = isHeavenAwakenSummonedCharacter
end

function UnitCompAttrs:isTJSummonedCharacter()
	return self._isHeavenAwakenSummonedCharacter
end

function UnitCompAttrs:setHaveBeenTJSummoned(isHaveBeenTJSummoned)
	self._isHaveBeenTJSummoned = isHaveBeenTJSummoned
end

function UnitCompAttrs:isHaveBeenTJSummoned()
	return self._isHaveBeenTJSummoned
end

function UnitCompAttrs:setBeingTJSummoned(isBeingSummoned)
	self._isBeingHeavenAwakenSummoned = isBeingSummoned
end

function UnitCompAttrs:isBeingTJSummoned()
	return self._isBeingHeavenAwakenSummoned
end

function UnitCompAttrs:setUsingSpiritInvocation(isUsingSpiritInvocation)
	self._isUsingSpiritInvocation = isUsingSpiritInvocation
end

function UnitCompAttrs:isUsingSpiritInvocation()
	return self._isUsingSpiritInvocation
end

function UnitCompAttrs:setIsSpiritInvocationPet(isSpiritInvocationPet)
	self._isSpiritInvocationPet = isSpiritInvocationPet
end

function UnitCompAttrs:isSpiritInvocationPet()
	return self._isSpiritInvocationPet
end

return UnitCompAttrs
