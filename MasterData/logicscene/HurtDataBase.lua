-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/HurtDataBase.lua

module("logicscene.scene.battle.skills.hurts.HurtDataBase", package.seeall)

local HurtDataBase = class("HurtDataBase")

function HurtDataBase:ctor()
	self.attacker = nil
	self.target = nil
	self.isHit = nil
	self.isImmunity = nil
	self.isBlock = nil
	self.isCritical = nil
	self.isSkillEffected = nil
	self.beforeHurtEvts = nil
	self.afterHurtEvts = nil
	self.damageEvts = nil
	self.vigourEvts = nil
	self.repeling = 0
	self.repelingDX = 0
	self.repelingDY = 0
	self.repelingDZ = 0
	self.repelingSpeed = 0
	self.isHard = nil
	self.hitfly = 0
	self._showDamageText = true
end

function HurtDataBase:generateFromCharactorResult(result)
	self.isHit = result.isHit
	self.isImmunity = result.isImmunity
	self.isBlock = result.isBlock
	self.isCritical = result.isCritical
	self.isSkillEffected = result.isSkillEffected

	self:generateFromResultNum(result.targetNum)
end

function HurtDataBase:generateFromPlayerResult(result)
	return
end

function HurtDataBase:generateFromResultNum(targetNum)
	self:generateDamageEvtsFromResultNum(targetNum)
	self:generateVigourEvtsFromResultNum(targetNum)
end

function HurtDataBase:generateDamageEvtsFromResultNum(targetNum)
	if targetNum.attackHps then
		self:generateDamageEvts(targetNum.attackHps)
	end
end

function HurtDataBase:generateDamageEvts(attackHps)
	if attackHps then
		local pool = HurtEvtsPool.instance
		local cnt = #attackHps

		for i = 1, cnt do
			self.damageEvts = self.damageEvts or {}

			table.insert(self.damageEvts, pool:getDamageEvt(attackHps[i], self._showDamageText, 0, 0, 0, self))
		end

		table.clear(attackHps)
	end
end

function HurtDataBase:generateVigourEvtsFromResultNum(targetNum)
	if targetNum.attackVigours then
		self:generateVigourEvts(targetNum.attackVigours)
	end
end

function HurtDataBase:generateVigourEvts(attackVigours)
	if attackVigours then
		local pool = HurtEvtsPool.instance
		local cnt = #attackVigours

		for i = 1, cnt do
			if attackVigours[i] ~= 0 then
				self.vigourEvts = self.vigourEvts or {}

				table.insert(self.vigourEvts, pool:getVigourEvt(attackVigours[i]))
			end
		end

		table.clear(attackVigours)
	end
end

function HurtDataBase:generateBeforeHurtEvtsFromResultNum(targetNum)
	local pool = HurtEvtsPool.instance
	local beforeBuffHps = targetNum.beforeBuffHps

	if beforeBuffHps then
		local cnt = #beforeBuffHps

		for i = 1, cnt do
			self.beforeHurtEvts = self.beforeHurtEvts or {}

			local evt = pool:getBuffDamageEvt(beforeBuffHps[i].sequenceId, beforeBuffHps[i].buffId, beforeBuffHps[i].power)

			table.insert(self.beforeHurtEvts, evt)
		end

		table.clear(beforeBuffHps)
	end

	local beforeBuffVigours = targetNum.beforeBuffVigours

	if beforeBuffVigours then
		local cnt = #beforeBuffVigours

		for i = 1, cnt do
			self.beforeHurtEvts = self.beforeHurtEvts or {}

			local evt = pool:getBuffViourEvt(beforeBuffVigours[i].sequenceId, beforeBuffVigours[i].buffId, beforeBuffVigours[i].power)

			table.insert(self.beforeHurtEvts, evt)
		end

		table.clear(beforeBuffVigours)
	end

	local beforeDisplayBuffs = targetNum.beforeDisplayBuffs

	if beforeDisplayBuffs then
		local cnt = #beforeDisplayBuffs

		for i = 1, cnt do
			self.beforeHurtEvts = self.beforeHurtEvts or {}

			local evt = pool:getBuffEvt(beforeDisplayBuffs[i].sequenceId, beforeDisplayBuffs[i].buffId, beforeDisplayBuffs[i].displayType)

			table.insert(self.beforeHurtEvts, evt)
		end

		table.clear(beforeDisplayBuffs)
	end

	self.beforeHurtEvts = self:generateResultObjectSummary(targetNum.resultObjectSummary, GameEnum.BattleOc.Beffore, self.beforeHurtEvts)
end

function HurtDataBase:generateAfterHurtEvtsFromResultNum(targetNum)
	local pool = HurtEvtsPool.instance
	local afterBuffHps = targetNum.afterBuffHps

	if afterBuffHps then
		local cnt = #afterBuffHps

		for i = 1, cnt do
			self.afterHurtEvts = self.afterHurtEvts or {}

			local evt = pool:getBuffDamageEvt(afterBuffHps[i].sequenceId, afterBuffHps[i].buffId, afterBuffHps[i].power)

			table.insert(self.afterHurtEvts, evt)
		end

		table.clear(afterBuffHps)
	end

	local afterBuffVigours = targetNum.afterBuffVigours

	if afterBuffVigours then
		local cnt = #afterBuffVigours

		for i = 1, cnt do
			self.afterHurtEvts = self.afterHurtEvts or {}

			local evt = pool:getBuffViourEvt(afterBuffVigours[i].sequenceId, afterBuffVigours[i].buffId, afterBuffVigours[i].power)

			table.insert(self.afterHurtEvts, evt)
		end

		table.clear(afterBuffVigours)
	end

	local afterDisplayBuffs = targetNum.afterDisplayBuffs

	if afterDisplayBuffs then
		local cnt = #afterDisplayBuffs

		for i = 1, cnt do
			self.afterHurtEvts = self.afterHurtEvts or {}

			local evt = pool:getBuffEvt(afterDisplayBuffs[i].sequenceId, afterDisplayBuffs[i].buffId, afterDisplayBuffs[i].displayType)

			table.insert(self.afterHurtEvts, evt)
		end

		table.clear(afterDisplayBuffs)
	end

	self.afterHurtEvts = self:generateResultObjectSummary(targetNum.resultObjectSummary, GameEnum.BattleOc.After, self.afterHurtEvts)
end

function HurtDataBase:generateResultObjectSummary(resultObjectSummary, oc, evtList)
	if not resultObjectSummary then
		return evtList
	end

	local pool = HurtEvtsPool.instance
	local attrTransformList = resultObjectSummary.attrTransform

	if attrTransformList then
		local cnt = #attrTransformList
		local i = 1

		while i <= cnt do
			if attrTransformList[i].oc == oc then
				evtList = evtList or {}

				local evt = pool:getAttrsEvt(attrTransformList[i].sequenceId, attrTransformList[i].curAttributes)

				table.insert(evtList, evt)
				table.remove(attrTransformList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local psychicSkillFightViewUpdateList = resultObjectSummary.psychicSkillFightViewUpdate

	if psychicSkillFightViewUpdateList then
		local cnt = #psychicSkillFightViewUpdateList
		local i = 1

		while i <= cnt do
			if psychicSkillFightViewUpdateList[i].oc == oc then
				evtList = evtList or {}

				local evt = pool:getPlayerPsychicSkillEvt(psychicSkillFightViewUpdateList[i].sequenceId, self.target.teamId, psychicSkillFightViewUpdateList[i].newView)

				table.insert(evtList, evt)
				table.remove(psychicSkillFightViewUpdateList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local awakenChangeList = resultObjectSummary.awakenChange

	if awakenChangeList then
		local cnt = #awakenChangeList
		local i = 1

		while i <= cnt do
			if awakenChangeList[i].oc == oc then
				evtList = evtList or {}

				local evt = pool:getPlayerAwakenChangeSkillEvt(awakenChangeList[i].sequenceId, self.target, awakenChangeList[i].changeValue, awakenChangeList[i].curHadTriggerTimes, awakenChangeList[i].isAwakening)

				table.insert(evtList, evt)
				table.remove(awakenChangeList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local summonList = resultObjectSummary.summon

	if summonList then
		local cnt = #summonList
		local i = 1

		while i <= cnt do
			if summonList[i].oc == oc then
				evtList = evtList or {}

				local evt = pool:getSummonEvt(summonList[i].sequenceId, summonList[i].target.targetTeamId, summonList[i].target.targetCharacterId)

				table.insert(evtList, evt)
				table.remove(summonList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local transformList = resultObjectSummary.transform

	if transformList then
		local cnt = #transformList
		local i = 1

		while i <= cnt do
			if transformList[i].oc == oc then
				evtList = evtList or {}

				local evt = pool:getTransformEvt(transformList[i].sequenceId, self.target.raceId, transformList[i].curFaceId, transformList[i].curRaceId, transformList[i].curNormalSkillId, transformList[i].curUltimateSkillId, transformList[i].curAttributes, transformList[i].isPsychicTransform)

				table.insert(evtList, evt)
				table.remove(transformList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local valueUpdateList = resultObjectSummary.maxHpUpdate

	if valueUpdateList then
		local cnt = #valueUpdateList
		local i = 1

		while i <= cnt do
			if valueUpdateList[i].oc == oc then
				evtList = evtList or {}

				local evt = pool:getMaxHpEvt(valueUpdateList[i].sequenceId, valueUpdateList[i].oldCurValue, valueUpdateList[i].oldMaxValue, valueUpdateList[i].newCurValue, valueUpdateList[i].newMaxValue)

				table.insert(evtList, evt)
				table.remove(valueUpdateList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local shieldChangeList = resultObjectSummary.shieldChange

	if shieldChangeList then
		local cnt = #shieldChangeList
		local i = 1

		while i <= cnt do
			local shieldChange = shieldChangeList[i]

			if shieldChange.oc == oc then
				evtList = evtList or {}

				local evt = pool:getShieldChangeEvt(shieldChange.sequenceId, shieldChange.changeValue, shieldChange.isAttack, shieldChange.isShow)

				table.insert(evtList, evt)
				table.remove(shieldChangeList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local positionChangeList = resultObjectSummary.positionChange

	if positionChangeList then
		local cnt = #positionChangeList
		local i = 1

		while i <= cnt do
			local positionChange = positionChangeList[i]

			if positionChange.oc == oc then
				evtList = evtList or {}

				local evt = pool:getTransPositionEvt(positionChange)

				table.insert(evtList, evt)
				table.remove(positionChangeList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local domainChanges = resultObjectSummary.domainChange

	if domainChanges then
		local cnt = #domainChanges
		local i = 1

		while i <= cnt do
			local domainChange = domainChanges[i]

			if domainChange.oc == oc then
				evtList = evtList or {}

				local evt = pool:getDomainChangeEvt(domainChange)

				table.insert(evtList, evt)
				table.remove(domainChanges, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local doppelgangerChangeList = resultObjectSummary.doppelgangerChange

	if doppelgangerChangeList then
		local cnt = #doppelgangerChangeList
		local i = 1

		while i <= cnt do
			if doppelgangerChangeList[i].oc == oc then
				evtList = evtList or {}

				local targetCount = #doppelgangerChangeList[i].targets
				local j = 1

				while j <= targetCount do
					local evt = pool:getDoppelgangerChangeEvt(doppelgangerChangeList[i].sequenceId, doppelgangerChangeList[i].targets[j].targetTeamId, doppelgangerChangeList[i].targets[j].targetCharacterId)

					table.insert(evtList, evt)

					j = j + 1
				end

				table.remove(doppelgangerChangeList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local carriedChangeList = resultObjectSummary.carriedChange

	if carriedChangeList then
		local cnt = #carriedChangeList
		local i = 1

		while i <= cnt do
			local carriedChange = carriedChangeList[i]

			if carriedChange.oc == oc then
				evtList = evtList or {}

				local evt = pool:getCarriedEvt(carriedChange.sequenceId, self.target.raceId, carriedChange.target, carriedChange.carriedPet)

				table.insert(evtList, evt)
				table.remove(carriedChangeList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local heavenAwakenSummonChange = resultObjectSummary.heavenAwakenSummonChange

	if heavenAwakenSummonChange then
		local cnt = #heavenAwakenSummonChange
		local i = 1

		while i <= cnt do
			local summonChange = heavenAwakenSummonChange[i]

			if summonChange.oc == oc then
				evtList = evtList or {}

				local evt = pool:getHeavenAwakenSummonEvt(summonChange.sequenceId, summonChange.target.targetTeamId, summonChange.target.targetCharacterId)

				table.insert(evtList, evt)
				table.remove(heavenAwakenSummonChange, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local genesisSkillFightViewUpdate = resultObjectSummary.genesisSkillFightViewUpdate

	if genesisSkillFightViewUpdate then
		local cnt = #genesisSkillFightViewUpdate
		local i = 1

		while i <= cnt do
			if genesisSkillFightViewUpdate[i].oc == oc then
				evtList = evtList or {}

				local evt = pool:getGenesisSkillEvt(genesisSkillFightViewUpdate[i].sequenceId, self.target.teamId, genesisSkillFightViewUpdate[i].newView)

				table.insert(evtList, evt)
				table.remove(genesisSkillFightViewUpdate, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local spiritInvocationSkillFightViewUpdate = resultObjectSummary.spiritInvocationSkillFightViewUpdate

	if spiritInvocationSkillFightViewUpdate then
		local cnt = #spiritInvocationSkillFightViewUpdate
		local i = 1

		while i <= cnt do
			if spiritInvocationSkillFightViewUpdate[i].oc == oc then
				evtList = evtList or {}

				local evt = pool:getSpiritInvocationSkillEvt(spiritInvocationSkillFightViewUpdate[i].sequenceId, self.target.teamId, spiritInvocationSkillFightViewUpdate[i].newView)

				table.insert(evtList, evt)
				table.remove(spiritInvocationSkillFightViewUpdate, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	return evtList
end

function HurtDataBase:handleData()
	self:_handleHurtEvtsBefore()
	self:_handleDamageEvts()
	self:_handleVigourEvts()
	self:_handleHurtEvtsAfter()

	if self.isSkillEffected then
		if self.isHit then
			if self.isImmunity then
				self:_onImmunity()
			else
				self:_onTarget()
			end

			if self.isBlock then
				self:_onBlock()
			end
		elseif self.collision then
			if self.collision:isLastCollision() then
				self:_onDodge()
			end
		else
			self:_onDodge()
		end

		self:_handleSound()
		self:_handleHurtEffect()
	end

	self:_generateRecords()
	GlobalDispatcher:dispatch(GlobalNotify.BattleHurtData, self)
end

function HurtDataBase:_onTarget()
	self:_handleControls()
end

function HurtDataBase:_handleHurtEvtsBefore()
	if self.beforeHurtEvts then
		table.sort(self.beforeHurtEvts, HurtDataBase._sortHurtEvts)

		local cnt = #self.beforeHurtEvts

		for i = 1, cnt do
			self.beforeHurtEvts[i]:handleEvt(self)
		end
	end
end

function HurtDataBase:_handleDamageEvts()
	if self.damageEvts then
		local cnt = #self.damageEvts

		for i = 1, cnt do
			local damage = self.damageEvts[i]

			damage:handleEvt(self)
		end
	end
end

function HurtDataBase:_handleVigourEvts()
	if self.vigourEvts then
		local cnt = #self.vigourEvts

		for i = 1, cnt do
			local vigour = self.vigourEvts[i]

			vigour:handleEvt(self)
		end
	end
end

function HurtDataBase:_handleHurtEvtsAfter()
	if self.afterHurtEvts then
		table.sort(self.afterHurtEvts, HurtDataBase._sortHurtEvts)

		local cnt = #self.afterHurtEvts

		for i = 1, cnt do
			self.afterHurtEvts[i]:handleEvt(self)
		end
	end
end

function HurtDataBase._sortHurtEvts(x, y)
	if x == y then
		return false
	end

	if (x.sequenceId or 0) < (y.sequenceId or 0) then
		return true
	end

	if (y.sequenceId or 0) < (x.sequenceId or 0) then
		return false
	end

	return false
end

function HurtDataBase:pushHurtEvtRecord(evt)
	local record = evt:getDesc(self)

	if record then
		self:_pushtRecord(record)
	end
end

function HurtDataBase:_pushtRecord(record)
	if record then
		self._battleInfos = self._battleInfos or {}

		table.insert(self._battleInfos, record)
	end
end

function HurtDataBase:_onDodge()
	self.target:onDodge()
end

function HurtDataBase:_onImmunity()
	if self._showDamageText then
		self.target:onImmunity()
	end
end

function HurtDataBase:_onBlock()
	if self._showDamageText then
		self.target:onBlock()
	end
end

function HurtDataBase:_handleControls()
	if self.repeling ~= 0 and self.target.battleFlow:isRepelable(self.target) then
		self.target:onRepeling(self.repeling, self.repelingSpeed, self.repelingDX, self.repelingDY, self.repelingDZ)
	end

	if self.hitfly ~= 0 and self.target.battleFlow:isHitflyable(self.target) then
		self.target:onHitFly(self.hitfly)
	end

	if self.isHard and self.target.battleFlow:isHardable(self.target) then
		self.target:onHard()
	end
end

function HurtDataBase:_handleSound()
	return
end

function HurtDataBase:_handleHurtEffect()
	return
end

function HurtDataBase:_generateRecords()
	if not self._showDamageText or not self.isSkillEffected then
		return
	end

	local petCo = CharacterConfig.instance:getPetCo(self.target.raceId)
	local targetName = petCo.name
	local targetColor = self:getColorByTeamId(self.target.teamId)

	if self.isHit then
		if self.isImmunity then
			local record = string.format(lang("battlerecord_immunity"), targetColor, targetName)

			self:_pushtRecord(record)
		end

		if self.isCritical then
			local record = string.format(lang("battlerecord_critical"), targetColor, targetName)

			self:_pushtRecord(record)
		end
	else
		local record = string.format(lang("battlerecord_dodge"), targetColor, targetName)

		self:_pushtRecord(record)
	end
end

function HurtDataBase:getColorByTeamId(teamId)
	local leftTeamId = BattleModel.instance:getLeftTeamId()

	if teamId == leftTeamId then
		return "28c3ff"
	end

	return "ff2828"
end

return HurtDataBase
