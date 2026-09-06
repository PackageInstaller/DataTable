-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/HurtDataPlayerResult.lua

module("logicscene.scene.battle.skills.hurts.HurtDataPlayerResult", package.seeall)

local HurtDataPlayerResult = class("HurtDataPlayerResult", HurtDataBase)

function HurtDataPlayerResult:generateFromCharactorResult(result)
	return
end

function HurtDataPlayerResult:generateFromResultNum(targetNum)
	self.beforeHurtEvts = self:generateResultObjectSummary(targetNum.resultObjectSummary, GameEnum.BattleOc.Beffore, self.beforeHurtEvts)
	self.afterHurtEvts = self:generateResultObjectSummary(targetNum.resultObjectSummary, GameEnum.BattleOc.After, self.afterHurtEvts)
end

function HurtDataPlayerResult:generateFromPlayerResult(result)
	self.isHit = true
	self.isSkillEffected = result.isSkillEffected
	self.playerTeam = result.target.targetTeamId

	self:generateFromResultNum(result.targetNum)
end

function HurtDataPlayerResult:generateResultObjectSummary(resultObjectSummary, oc, evtList)
	local evtList
	local pool = HurtEvtsPool.instance
	local btlItemChangeList = resultObjectSummary.btlItemChange

	if btlItemChangeList then
		local cnt = #btlItemChangeList
		local i = 1

		while i <= cnt do
			if btlItemChangeList[i].oc == oc then
				evtList = evtList or {}

				local evt = pool:getBtlItemChangeEvt(self.playerTeam, btlItemChangeList[i].sequenceId, btlItemChangeList[i].curItemView)

				table.insert(evtList, evt)
				table.remove(btlItemChangeList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local playerBtlItemEnergyChangeList = resultObjectSummary.playerBtlItemEnergyChange

	if playerBtlItemEnergyChangeList then
		local cnt = #playerBtlItemEnergyChangeList
		local i = 1

		while i <= cnt do
			local energyChange = playerBtlItemEnergyChangeList[i]

			if energyChange.oc == oc then
				evtList = evtList or {}

				local evt = pool:getBtlEnergyChangeEvt(self.playerTeam, playerBtlItemEnergyChangeList[i].sequenceId, playerBtlItemEnergyChangeList[i].oldBtlItemEnergy, playerBtlItemEnergyChangeList[i].newBtlItemEnergy)

				table.insert(evtList, evt)
				table.remove(playerBtlItemEnergyChangeList, i)

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

	local psychicSkillFightViewUpdateList = resultObjectSummary.psychicSkillFightViewUpdate

	if psychicSkillFightViewUpdateList then
		local cnt = #psychicSkillFightViewUpdateList
		local i = 1

		while i <= cnt do
			if psychicSkillFightViewUpdateList[i].oc == oc then
				evtList = evtList or {}

				local evt = pool:getPlayerPsychicSkillEvt(psychicSkillFightViewUpdateList[i].sequenceId, self.playerTeam, psychicSkillFightViewUpdateList[i].newView)

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

	local genesisSkillFightViewUpdateList = resultObjectSummary.genesisSkillFightViewUpdate

	if genesisSkillFightViewUpdateList then
		local cnt = #genesisSkillFightViewUpdateList
		local i = 1

		while i <= cnt do
			if genesisSkillFightViewUpdateList[i].oc == oc then
				evtList = evtList or {}

				local evt = pool:getGenesisSkillEvt(genesisSkillFightViewUpdateList[i].sequenceId, self.playerTeam, genesisSkillFightViewUpdateList[i].newView)

				table.insert(evtList, evt)
				table.remove(genesisSkillFightViewUpdateList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	local spiritInvocationSkillFightViewUpdateList = resultObjectSummary.spiritInvocationSkillFightViewUpdate

	if spiritInvocationSkillFightViewUpdateList then
		local cnt = #spiritInvocationSkillFightViewUpdateList
		local i = 1

		while i <= cnt do
			if spiritInvocationSkillFightViewUpdateList[i].oc == oc then
				evtList = evtList or {}

				local evt = pool:getSpiritInvocationSkillEvt(spiritInvocationSkillFightViewUpdateList[i].sequenceId, self.playerTeam, spiritInvocationSkillFightViewUpdateList[i].newView)

				table.insert(evtList, evt)
				table.remove(spiritInvocationSkillFightViewUpdateList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	return evtList
end

return HurtDataPlayerResult
