-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtsPool.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtsPool", package.seeall)

local HurtEvtsPool = class("HurtEvtsPool")

function HurtEvtsPool:ctor()
	return
end

function HurtEvtsPool:clear()
	self._evts = nil
end

function HurtEvtsPool:recycleEvt(evt)
	self._evts = self._evts or {}

	local evtType = evt:getEvtType()
	local evts = self._evts[evtType]

	if not evts then
		evts = {}
		self._evts[evtType] = evts
	end

	table.insert(evts, evt)
end

function HurtEvtsPool:getAttrsEvt(sequenceId, attrs)
	local evt = self:_getEvt(HurtEvtType.EvtAttrs)

	evt.sequenceId = sequenceId
	evt.attrs = attrs

	return evt
end

function HurtEvtsPool:getBuffEvt(sequenceId, buffId, displayType)
	local evt = self:_getEvt(HurtEvtType.EvtBuff)

	evt.sequenceId = sequenceId
	evt.buffId = buffId
	evt.displayType = displayType

	return evt
end

function HurtEvtsPool:getBuffDamageEvt(sequenceId, buffId, damage)
	local evt = self:_getEvt(HurtEvtType.EvtBuffDamage)

	evt.sequenceId = sequenceId
	evt.buffId = buffId
	evt.damage = damage

	return evt
end

function HurtEvtsPool:getBuffViourEvt(sequenceId, buffId, vigour)
	local evt = self:_getEvt(HurtEvtType.EvtBuffVigour)

	evt.sequenceId = sequenceId
	evt.buffId = buffId
	evt.vigour = vigour

	return evt
end

function HurtEvtsPool:getTransPositionEvt(positionChange)
	local evt = self:_getEvt(HurtEvtType.TransPosition)

	evt.positionChange = positionChange
	evt.sequenceId = positionChange.sequenceId or 0

	return evt
end

function HurtEvtsPool:getDomainChangeEvt(domainChange)
	local evt = self:_getEvt(HurtEvtType.DomainChange)

	evt.domainChange = domainChange
	evt.sequenceId = domainChange.sequenceId or 0

	return evt
end

function HurtEvtsPool:getDamageEvt(damage, showDamageText, totalDamage, totalIndex, totalNum, hurtData)
	local evt = self:_getEvt(HurtEvtType.EvtDamage)

	evt.showDamageText = showDamageText
	evt.damage = damage
	evt.totalDamage = totalDamage
	evt.isLast = isLast
	evt.totalIndex = totalIndex
	evt.totalNum = totalNum
	evt.isCritical = hurtData.isCritical
	evt.attacker = hurtData.attacker

	local race, attackerType, raceId, curFaceId

	if not hurtData.isCritical and hurtData.attacker and hurtData.target then
		local attackerAttrs

		race, attackerType = hurtData.attacker.battleFlow:calculateRace(hurtData.attacker, hurtData.target, (hurtData.skill or nil) and hurtData.skill.unitAttrs)
	end

	if hurtData.attacker then
		raceId = hurtData.attacker.raceId
		curFaceId = hurtData.attacker.modelId
	end

	evt.race = race
	evt.attackerType = attackerType
	evt.attackerRaceId = raceId
	evt.curFaceId = curFaceId or 0

	return evt
end

function HurtEvtsPool:getMaxHpEvt(sequenceId, oldCurValue, oldMaxValue, newCurValue, newMaxValue)
	local evt = self:_getEvt(HurtEvtType.EvtMaxHp)

	evt.sequenceId = sequenceId
	evt.oldCurValue = oldCurValue
	evt.oldMaxValue = oldMaxValue
	evt.newCurValue = newCurValue
	evt.newMaxValue = newMaxValue

	return evt
end

function HurtEvtsPool:getPlayerPsychicSkillEvt(sequenceId, teamId, newView)
	local evt = self:_getEvt(HurtEvtType.EvtPsychicSkill)

	evt.sequenceId = sequenceId
	evt.teamId = teamId
	evt.newView = newView

	return evt
end

function HurtEvtsPool:getPlayerAwakenChangeSkillEvt(sequenceId, target, changeValue, curHadTriggerTimes, isAwakening)
	local evt = self:_getEvt(HurtEvtType.AwakenChangeSkill)

	evt.sequenceId = sequenceId
	evt.target = target
	evt.changeValue = changeValue
	evt.curHadTriggerTimes = curHadTriggerTimes
	evt.isAwakening = isAwakening

	return evt
end

function HurtEvtsPool:getSummonEvt(sequenceId, targetTeamId, targetCharacterId)
	local evt = self:_getEvt(HurtEvtType.EvtSummon)

	evt.sequenceId = sequenceId
	evt.teamId = targetTeamId
	evt.unitId = targetCharacterId

	return evt
end

function HurtEvtsPool:getTransformEvt(sequenceId, fromRaceId, curFaceId, curRaceId, curNormalSkillId, curUltimateSkillId, curAttributes, isPsychicTransform)
	local evt = self:_getEvt(HurtEvtType.EvtTransform)

	evt.sequenceId = sequenceId
	evt.fromRaceId = fromRaceId
	evt.curFaceId = curFaceId
	evt.curRaceId = curRaceId
	evt.curNormalSkillId = curNormalSkillId
	evt.curUltimateSkillId = curUltimateSkillId
	evt.curAttributes = curAttributes
	evt.isPsychicTransform = isPsychicTransform

	return evt
end

function HurtEvtsPool:getVigourEvt(vigour)
	local evt = self:_getEvt(HurtEvtType.EvtVigour)

	evt.vigour = vigour

	return evt
end

function HurtEvtsPool:getAttackerVigourEvt(vigour)
	local evt = self:_getEvt(HurtEvtType.AttackerVigour)

	evt.vigour = vigour

	return evt
end

function HurtEvtsPool:getBtlItemChangeEvt(playerTeam, sequenceId, curItemView)
	local evt = self:_getEvt(HurtEvtType.BtlItemChange)

	evt.playerTeam = playerTeam
	evt.sequenceId = sequenceId
	evt.curItemView = curItemView

	return evt
end

function HurtEvtsPool:getBtlEnergyChangeEvt(playerTeam, sequenceId, oldBtlItemEnergy, newBtlItemEnergy)
	local evt = self:_getEvt(HurtEvtType.BtlItemEnergyChange)

	evt.sequenceId = sequenceId
	evt.playerTeam = playerTeam
	evt.oldBtlItemEnergy = oldBtlItemEnergy
	evt.newBtlItemEnergy = newBtlItemEnergy

	return evt
end

function HurtEvtsPool:getShieldChangeEvt(sequenceId, changeValue, isAttack, isShow)
	local evt = self:_getEvt(HurtEvtType.ShieldChange)

	evt.sequenceId = sequenceId
	evt.changeValue = changeValue
	evt.isAttack = isAttack
	evt.isShow = isShow

	return evt
end

function HurtEvtsPool:getDoppelgangerChangeEvt(sequenceId, targetTeamId, targetCharacterId)
	local evt = self:_getEvt(HurtEvtType.EvtDoppelgangerChange)

	evt.sequenceId = sequenceId
	evt.teamId = targetTeamId
	evt.unitId = targetCharacterId

	return evt
end

function HurtEvtsPool:getCarriedEvt(sequenceId, fromRaceId, target, carriedPet)
	local evt = self:_getEvt(HurtEvtType.EvtCarriedChange)

	evt.target = target
	evt.sequenceId = sequenceId
	evt.fromRaceId = fromRaceId
	evt.carriedPet = carriedPet
	evt.curFaceId = carriedPet.curFaceId
	evt.curRaceId = carriedPet.raceId

	return evt
end

function HurtEvtsPool:getHeavenAwakenSummonEvt(sequenceId, targetTeamId, targetCharacterId)
	local evt = self:_getEvt(HurtEvtType.EvtHeavenAwakenSummon)

	evt.sequenceId = sequenceId
	evt.teamId = targetTeamId
	evt.unitId = targetCharacterId

	return evt
end

function HurtEvtsPool:getGenesisSkillEvt(sequenceId, teamId, newView)
	local evt = self:_getEvt(HurtEvtType.EvtGenesisSkill)

	evt.sequenceId = sequenceId
	evt.teamId = teamId
	evt.newView = newView

	return evt
end

function HurtEvtsPool:getSpiritInvocationSkillEvt(sequenceId, teamId, newView)
	local evt = self:_getEvt(HurtEvtType.EvtSpiritInvocationSkill)

	evt.sequenceId = sequenceId
	evt.teamId = teamId
	evt.newView = newView

	return evt
end

function HurtEvtsPool:_createEvt(evtType)
	if evtType == HurtEvtType.EvtAttrs then
		return HurtEvtAttrs.New()
	elseif evtType == HurtEvtType.EvtBuff then
		return HurtEvtBuff.New()
	elseif evtType == HurtEvtType.EvtBuffDamage then
		return HurtEvtBuffDamage.New()
	elseif evtType == HurtEvtType.EvtDamage then
		return HurtEvtDamage.New()
	elseif evtType == HurtEvtType.EvtMaxHp then
		return HurtEvtMaxHp.New()
	elseif evtType == HurtEvtType.EvtPsychicSkill then
		return HurtEvtPsychicSkill.New()
	elseif evtType == HurtEvtType.EvtSummon then
		return HurtEvtSummon.New()
	elseif evtType == HurtEvtType.EvtTransform then
		return HurtEvtTransform.New()
	elseif evtType == HurtEvtType.EvtVigour then
		return HurtEvtVigour.New()
	elseif evtType == HurtEvtType.EvtBuffVigour then
		return HurtEvtBuffVigour.New()
	elseif evtType == HurtEvtType.AttackerVigour then
		return HurtEvtAttackerVigour.New()
	elseif evtType == HurtEvtType.BtlItemChange then
		return HurtEvtBtlItemChange.New()
	elseif evtType == HurtEvtType.BtlItemEnergyChange then
		return HurtEvtBtlEnergyChange.New()
	elseif evtType == HurtEvtType.ShieldChange then
		return HurtEvtShieldChange.New()
	elseif evtType == HurtEvtType.TransPosition then
		return HurtEvtTransPosition.New()
	elseif evtType == HurtEvtType.DomainChange then
		return HurtEvtDomainChange.New()
	elseif evtType == HurtEvtType.AwakenChangeSkill then
		return HurtAwakeChangeSkill.New()
	elseif evtType == HurtEvtType.EvtDoppelgangerChange then
		return HurtEvtDoppelgangerChange.New()
	elseif evtType == HurtEvtType.EvtCarriedChange then
		return HurtEvtCarriedChange.New()
	elseif evtType == HurtEvtType.EvtHeavenAwakenSummon then
		return HurtEvtHeavenAwakenSummon.New()
	elseif evtType == HurtEvtType.EvtGenesisSkill then
		return HurtEvtGenesisSkill.New()
	elseif evtType == HurtEvtType.EvtSpiritInvocationSkill then
		return HurtEvtSpiritInvocationSkill.New()
	end
end

function HurtEvtsPool:_getEvt(evtType)
	if self._evts then
		local evts = self._evts[evtType]

		if evts and #evts > 0 then
			local evt = evts[1]

			table.remove(evts, 1)

			return evt
		end
	end

	return self:_createEvt(evtType)
end

HurtEvtsPool.instance = HurtEvtsPool.New()

return HurtEvtsPool
