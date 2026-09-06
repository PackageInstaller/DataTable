-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/UnitCompBuffList.lua

module("logicscene.scene.unit.component.battle.UnitCompBuffList", package.seeall)

local UnitCompBuffList = class("UnitCompBuffList", UnitComponentBase)

UnitCompBuffList.RepelingId = "RepelingId"
UnitCompBuffList.HardId = "HardId"
UnitCompBuffList.HitFlyId = "HitFlyId"
UnitCompBuffList.BackId = "BackId"
UnitCompBuffList.DodgeId = "DodgeId"
UnitCompBuffList.BlockId = "BlockId"
UnitCompBuffList.ImmunityId = "ImmunityId"
UnitCompBuffList.DeadId = "DeadId"
UnitCompBuffList.AnimationId = "AnimationId"
UnitCompBuffList.ItemUsableId = "ItemUsableId"
UnitCompBuffList.ItemUseSuccessId = "ItemUseSuccessId"
UnitCompBuffList.ItemUseFailedId = "ItemUseFailedId"
UnitCompBuffList.WaitingItemUsingId = "WaitingItemUsingId"
UnitCompBuffList.SkillLockingId = "SkillLockingId"
UnitCompBuffList.TransformId = "TransformId"
UnitCompBuffList.ViourMaxId = "ViourMaxId"
UnitCompBuffList.UseUtlSkill = "UseUtlSkill"
UnitCompBuffList.StrickBack = "StrickBack"
UnitCompBuffList.Summoned = "Summoned"
UnitCompBuffList.CatchPerformId = "CatchPerformId"
UnitCompBuffList.StartAttackId = "StartAttackId"
UnitCompBuffList.BirthId = "BirthId"
UnitCompBuffList.TriggerTransPosition = "TriggerTransPosition"
UnitCompBuffList.TransPosition = "TransPosition"
UnitCompBuffList.DomainChange = "DomainChange"
UnitCompBuffList.HeavenAwakenSummoned = "HeavenAwakenSummoned"

function UnitCompBuffList:ctor(unit)
	UnitCompBuffList.super.ctor(self, unit)

	self._buffs = {}
	self._validBuffs = {}
	self._buffsCache = {}
	self._isVisible = true
	self._buffsStorage = nil
end

function UnitCompBuffList:storageBuffs()
	local buffs = self._buffs

	for k, v in pairs(buffs) do
		if not v:isCustomBuff() and not v:autoRemoveOnDead() then
			self:storageBuffId(v:getBuffId(), v.layerNum)
		end
	end
end

function UnitCompBuffList:storageBuffId(buffId, layerNum)
	if checknumber(buffId) == 0 then
		return
	end

	self._buffsStorage = self._buffsStorage or {}

	if layerNum then
		self._buffsStorage[buffId] = layerNum
	else
		layerNum = self._buffsStorage[buffId] or 0
		self._buffsStorage[buffId] = layerNum + 1
	end
end

function UnitCompBuffList:removeStorageBuffId(buffId)
	if checknumber(buffId) == 0 then
		return
	end

	if self._buffsStorage then
		local v = checknumber(self._buffsStorage[buffId])

		v = v - 1

		if v <= 0 then
			self._buffsStorage[buffId] = nil
		else
			self._buffsStorage[buffId] = v
		end
	end
end

function UnitCompBuffList:resumeBuffsFromStorage()
	if self._buffsStorage then
		for k, v in pairs(self._buffsStorage) do
			local buff = self:addBuff(k)

			if buff then
				buff.layerNum = v

				buff:updateLayerNum()
			end
		end

		self._buffsStorage = nil
	end
end

function UnitCompBuffList:update(deltaTime)
	local cnt = self:_copyToCache()

	for i = 1, cnt do
		local buff = self._buffsCache[i]

		if self._validBuffs[buff] then
			if not buff.isRunning then
				buff:onBuffBegin()
			end

			buff:update(deltaTime)

			if buff:isDone() then
				self:_removeBuff(buff)
			end
		end
	end
end

function UnitCompBuffList:pause(pause)
	self._isPause = pause

	local cnt = #self._buffs

	if pause then
		for i = 1, cnt do
			self._buffs[i]:pause()
		end
	else
		for i = 1, cnt do
			self._buffs[i]:resume()
		end
	end
end

function UnitCompBuffList:setVisible(visible)
	self._isVisible = visible

	local cnt = #self._buffs

	for i = 1, cnt do
		self._buffs[i]:setVisible(visible)
	end
end

function UnitCompBuffList:onDestroy()
	return
end

function UnitCompBuffList:addBuff(buffId)
	local buffCo = BattleConfig.instance:getBuffCo(buffId)

	if self._unit.attrs:isDead() and buffCo and (not buffCo.disable_dead_rm or buffCo.disable_dead_rm ~= 0) then
		self:storageBuffId(buffId)

		return
	end

	if self._unit.battleFlow:shouldAddBuff(self._unit, buffId) then
		local buff = self:getBuff(buffId)

		if not buff then
			if buffCo then
				buff = BuffFactory.createBuff(buffCo, self._unit)

				table.insert(self._buffs, buff)

				self._validBuffs[buff] = true

				buff:setVisible(self._isVisible)
				buff:onBuffBegin()
			end
		else
			buff:addLayerNum()
		end

		return buff
	end
end

function UnitCompBuffList:getServerBuffs()
	local cnt = #self._buffs
	local buffs

	for i = 1, cnt do
		if not self._buffs[i]:isCustomBuff() and self._buffs[i]:isNeedShowOnUI() then
			buffs = buffs or {}

			table.insert(buffs, self._buffs[i])
		end
	end

	return buffs
end

function UnitCompBuffList:removeBuffById(buffId)
	local cnt = #self._buffs

	for i = 1, cnt do
		if self._buffs[i]:getBuffId() == buffId then
			self:_removeBuff(self._buffs[i])

			break
		end
	end

	self:removeStorageBuffId(buffId)
end

function UnitCompBuffList:removeAllServerBuff()
	local cnt = #self._buffs
	local buffs

	for i = cnt, 1, -1 do
		local buff = self._buffs[i]

		if buff and not buff:isCustomBuff() then
			buff:removeLayerNum()

			if buff.layerNum <= 0 then
				if buff.isRunning then
					buff:onBuffEnd()
				end

				table.remove(self._buffs, i)

				self._validBuffs[buff] = nil
			end
		end
	end
end

function UnitCompBuffList:removeAll(force)
	local cnt = #self._buffs
	local i = 1

	while i <= cnt do
		local buff = self._buffs[i]

		if force or buff:autoRemoveOnDead() then
			if buff.isRunning then
				buff:onBuffEnd()
			end

			table.remove(self._buffs, i)

			self._validBuffs[buff] = nil
			cnt = cnt - 1
		else
			i = i + 1
		end
	end
end

function UnitCompBuffList:getBuff(buffId)
	local cnt = #self._buffs

	for i = 1, cnt do
		if self._buffs[i]:getBuffId() == buffId then
			return self._buffs[i]
		end
	end
end

function UnitCompBuffList:onBuffToggle(buffId)
	local buff = self:getBuff(buffId)

	if buff then
		buff:toggle()
	end
end

function UnitCompBuffList:_copyToCache()
	local cnt = #self._buffs

	for i = 1, cnt do
		self._buffsCache[i] = self._buffs[i]
	end

	return cnt
end

function UnitCompBuffList:getBuffs()
	return self._buffs
end

function UnitCompBuffList:_removeBuff(buff)
	local cnt = #self._buffs

	for i = 1, cnt do
		if self._buffs[i] == buff then
			buff:removeLayerNum()

			if buff.layerNum <= 0 then
				if buff.isRunning then
					buff:onBuffEnd()
				end

				table.remove(self._buffs, i)

				self._validBuffs[buff] = nil
			end

			break
		end
	end
end

function UnitCompBuffList:onDomainChange(skillId, skillLevel)
	self:removeBuffById(UnitCompBuffList.DomainChange)

	local buff = BuffDomainChange.New(nil, self._unit, skillId, skillLevel)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onTriggerTransPosition(skillId, targetTeamId, changes)
	self:removeBuffById(UnitCompBuffList.TriggerTransPosition)

	local buff = BuffTriggerTransPosition.New(nil, self._unit, skillId, targetTeamId, changes)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onTransPosition(newX, newY)
	self:removeBuffById(UnitCompBuffList.TransPosition)

	local buff = BuffTransPosition.New(nil, self._unit, newX, newY)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onTransPositionList(posArr)
	self:removeBuffById(UnitCompBuffList.TransPosition)

	local buff = BuffTransPositionContinuous.New(nil, self._unit, posArr)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onRepeling(repeling, repelingSpeed, repelingDX, repelingDY, repelingDZ, playHit)
	self:removeBuffById(UnitCompBuffList.RepelingId)

	local buff = BuffRepeling.New(nil, self._unit, playHit)

	buff:setRepelDir(repelingDX, repelingDY, repelingDZ)
	buff:setRepelSpd(repelingSpeed)
	buff:setRepelDist(repeling)
	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onHitFly(hitfly)
	self:removeBuffById(UnitCompBuffList.HitFlyId)

	local buff = BuffHitfly.New(nil, self._unit, hitfly)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onBack()
	self:removeBuffById(UnitCompBuffList.BackId)

	local buff = BuffBackBirthPoint.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onDead()
	self:storageBuffs()
	self:removeAll(false)

	local buff = BuffDead.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onRelive()
	self:removeBuffById(UnitCompBuffList.DeadId)
	self._unit.spine:resetCurAnimState()

	local inst = self._unit.spine:getSkeletonAnimation()

	if not goutil.isNil(inst) then
		inst:ClearState()
		GoUtil.PlaySpineAnim(inst.gameObject, "idle", true, true)
		inst:Update(0)
		inst:LateUpdate()
	end

	self:resumeBuffsFromStorage()
end

function UnitCompBuffList:onHard()
	self:removeBuffById(UnitCompBuffList.HardId)

	local buff = BuffHard.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onDodge()
	self:removeBuffById(UnitCompBuffList.DodgeId)

	local buff = BuffDodge.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onImmunity()
	self:removeBuffById(UnitCompBuffList.ImmunityId)

	local buff = BuffImmunity.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onBlock()
	self:removeBuffById(UnitCompBuffList.BlockId)

	local buff = BuffBlock.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onAnimation(animation)
	self:removeBuffById(UnitCompBuffList.AnimationId)

	local buff = BuffAnimation.New(nil, self._unit)

	buff.animation = animation

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onItemUsable(itemId)
	self:removeBuffById(UnitCompBuffList.ItemUsableId)

	local buff = BuffItemUsable.New(nil, self._unit, itemId)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:stopItemUsable()
	self:removeBuffById(UnitCompBuffList.ItemUsableId)
end

function UnitCompBuffList:onItemUseSuccess(itemId)
	self:removeBuffById(UnitCompBuffList.ItemUseSuccessId)

	local buff = BuffItemUseSuccess.New(nil, self._unit, itemId)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onItemUseFailed()
	self:removeBuffById(UnitCompBuffList.ItemUseFailedId)

	local buff = BuffItemUseFailed.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:onBuffBegin()
end

function UnitCompBuffList:onWaitingItemUsing(itemId)
	self:removeBuffById(UnitCompBuffList.WaitingItemUsingId)

	local buff = BuffWaitingItemUsing.New(nil, self._unit, itemId)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:onBuffBegin()
end

function UnitCompBuffList:stopWaitingItemUsing(itemId)
	self:removeBuffById(UnitCompBuffList.WaitingItemUsingId)
end

function UnitCompBuffList:onSkillLocking(skill)
	self:removeBuffById(UnitCompBuffList.SkillLockingId)

	local buff = BuffSkillLocking.New(nil, self._unit, skill)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:removeSkillLocking()
	self:removeBuffById(UnitCompBuffList.SkillLockingId)
end

function UnitCompBuffList:onTransform(modelId, effId)
	self:removeBuffById(UnitCompBuffList.TransformId)

	local buff = BuffTransform.New(nil, self._unit, modelId, effId)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onVigourMax()
	self:removeBuffById(UnitCompBuffList.ViourMaxId)

	local buff = BuffVigourMax.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:removeVigourMax()
	self:removeBuffById(UnitCompBuffList.ViourMaxId)
end

function UnitCompBuffList:onUseUtlSkill()
	self:removeBuffById(UnitCompBuffList.UseUtlSkill)

	local buff = BuffUseUtlSkill.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:removeUseUtlSkill()
	self:removeBuffById(UnitCompBuffList.UseUtlSkill)
end

function UnitCompBuffList:onStrickBack()
	self:removeBuffById(UnitCompBuffList.StrickBack)

	local buff = BuffStrickBack.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:removeStrickBack()
	self:removeBuffById(UnitCompBuffList.StrickBack)
end

function UnitCompBuffList:onSummoned()
	self:removeBuffById(UnitCompBuffList.Summoned)

	local buff = BuffSummoned.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onTJSummoned()
	self:removeBuffById(UnitCompBuffList.HeavenAwakenSummoned)

	local buff = BuffHeavenAwakenSummoned.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onDoppelgangered()
	self:onSummoned()
end

function UnitCompBuffList:onCatchPerformed(itemId, success)
	self:removeBuffById(UnitCompBuffList.CatchPerformId)

	local buff = BuffCatchPerform.New(nil, self._unit, itemId, success)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onStartAttack()
	self:removeBuffById(UnitCompBuffList.StartAttackId)

	local buff = BuffStartAttack.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

function UnitCompBuffList:onBirth()
	self:removeBuffById(UnitCompBuffList.BirthId)

	local buff = BuffBirth.New(nil, self._unit)

	table.insert(self._buffs, buff)

	self._validBuffs[buff] = true

	buff:setVisible(self._isVisible)
	buff:onBuffBegin()
end

return UnitCompBuffList
