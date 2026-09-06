-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/UnitCompBattleFlowCommon.lua

module("logicscene.scene.unit.component.battle.UnitCompBattleFlowCommon", package.seeall)

local UnitCompBattleFlowCommon = class("UnitCompBattleFlowCommon", UnitComponentBase)
local forbidBack = 0

function UnitCompBattleFlowCommon.setForbidBack(fBack)
	if fBack then
		forbidBack = forbidBack + 1
	elseif forbidBack > 0 then
		forbidBack = forbidBack - 1
	end
end

function UnitCompBattleFlowCommon.clearForbidBack()
	forbidBack = 0
end

function UnitCompBattleFlowCommon:onInit()
	self.attackEvt = nil
	self.battleScene = SceneMgr.instance:getScene(SceneType.Battle)
	self.unitFactory = self.battleScene.unitFactory
end

function UnitCompBattleFlowCommon:getUnit()
	return self._unit
end

function UnitCompBattleFlowCommon:pause(pause)
	self._isPause = pause
end

function UnitCompBattleFlowCommon:attack(skillId, skillExecuteState, isStrickBack, attackCount, skillTargets)
	if self._isPause then
		return
	end

	if BattleModel.instance.transformingCount > 0 then
		return
	end

	local skill = self._unit.skillList:getSkill(skillId)

	if not self:isSkillCanCast(skill) then
		return
	end

	self:selectTargets(skill, skillTargets)
	self:prepareUseSkill(skill)

	if self._unit:useSkill(skill, skillExecuteState, isStrickBack, attackCount) then
		return skill
	end
end

function UnitCompBattleFlowCommon:isSkillCanCast(skill)
	if not skill then
		return
	end

	if not self:isIdle(skill.unit, true) then
		return
	end

	local attrs = skill.unit.attrs

	if attrs:isCollisionLocking() then
		return
	end

	if attrs:isTransforming() then
		return
	end

	if attrs:isSkillLocking() then
		return
	end

	local targetCharacterResults = self.attackEvt.oneRoundCharacterResult.targetCharacterResults

	if targetCharacterResults then
		local cnt = #targetCharacterResults

		for i = 1, cnt do
			local result = targetCharacterResults[i]

			if result.target and result.isSkillEffected then
				local unit = self.unitFactory:getUnit(result.target.targetTeamId, result.target.targetCharacterId)

				if unit then
					if not self:isAttackable(unit) then
						return
					end
				else
					return
				end
			end
		end
	end

	return true
end

function UnitCompBattleFlowCommon:prepareUseSkill(skill)
	local targetCharacterResults = self.attackEvt.oneRoundCharacterResult.targetCharacterResults

	if not targetCharacterResults then
		return
	end

	local cnt = #targetCharacterResults

	for i = 1, cnt do
		local result = targetCharacterResults[i]
		local vigour, vigourCost = self:getAttackResumeVigours(skill, result, skill.resumeVigours, skill.costVigours)

		if vigour then
			skill.resumeVigours = vigour
		end

		if vigourCost then
			skill.costVigours = vigourCost
		end

		local beforeHurtData = self:generateBeforeHurtData(skill, result)

		if beforeHurtData then
			beforeHurtData.isHit = true
			skill.prepareHurtData = skill.prepareHurtData or {}

			table.insert(skill.prepareHurtData, beforeHurtData)
		end
	end
end

function UnitCompBattleFlowCommon:getAttackResumeVigours(skill, result, currV, costV)
	if result.target.targetTeamId == skill.unit.teamId and result.target.targetCharacterId == skill.unit.id and result.targetNum and result.targetNum.attackVigours then
		local attackVigours = result.targetNum.attackVigours
		local cnt = #attackVigours

		for i = 1, cnt do
			if attackVigours[i] > 0 then
				currV = currV or 0
				currV = currV + attackVigours[i]
				attackVigours[i] = 0
			elseif attackVigours[i] < 0 then
				costV = costV or 0
				costV = costV + attackVigours[i]
				attackVigours[i] = 0
			end
		end

		return currV, costV
	end
end

function UnitCompBattleFlowCommon:isSkillWithDraw()
	return self:isSkillWithDrawByUnit(self._unit)
end

function UnitCompBattleFlowCommon:isSkillWithDrawByUnit(unit)
	if unit.skillList then
		local skill = unit.skillList:getCurSkill()

		if not skill then
			return true
		end

		return skill:isSkillWithDraw()
	end

	return true
end

function UnitCompBattleFlowCommon:selectTargets(skill, skillTargets)
	if skillTargets then
		skill:setSkillTargets(skillTargets)

		return
	end

	local targetCharacterResults = self.attackEvt.oneRoundCharacterResult.targetCharacterResults

	if not targetCharacterResults then
		return
	end

	local cnt = #targetCharacterResults
	local attackTargets, notSkillEffectTargets

	for i = 1, cnt do
		local result = targetCharacterResults[i]

		if result.isSkillEffected or self:hasAfterHurtDataResult(result) then
			local unit = self.unitFactory:getUnit(result.target.targetTeamId, result.target.targetCharacterId)

			if result.isSkillEffected then
				attackTargets = attackTargets or {}

				table.insert(attackTargets, {
					unit = unit,
					result = result,
					records = {}
				})
			else
				notSkillEffectTargets = notSkillEffectTargets or {}

				table.insert(notSkillEffectTargets, {
					unit = unit,
					result = result,
					records = {}
				})
			end
		end
	end

	skill:setSkillTargets(attackTargets)
	skill:setNotSkillEffectTargets(notSkillEffectTargets)
end

function UnitCompBattleFlowCommon:onCollision(skill, index, cData)
	local skillsTargets = skill:getSkillTargets()

	if skillsTargets then
		if cData.targetType == 2 then
			skillsTargets = self:getFriendTargets(skill.unit, skillsTargets)
		elseif cData.targetType == 1 then
			skillsTargets = self:getEnemyTargets(skill.unit, skillsTargets)
		end

		if skillsTargets then
			local cnt = #skillsTargets

			for i = 1, cnt do
				local ccInfo = BattleAnimEvevts.onCollision(index, cData)
				local collision = CollisionFactory.createCollision(skill, ccInfo)

				if collision then
					collision:setTargets({
						skillsTargets[i]
					})

					if collision:isLastCollision() then
						local notSkillEffectTargets = skill:getNotSkillEffectTargets()

						collision:setNotSkillEffectTargets(notSkillEffectTargets)
						skill:setNotSkillEffectTargets(nil)
					end

					collision:setStartPos(ccInfo.posX, ccInfo.posY, ccInfo.posZ)
					collision:setDir(ccInfo.dirX, ccInfo.dirY, ccInfo.dirZ)
					collision:calculateAliveTimeAndDir()
					collision:createEffect()
					self.battleScene.collisions:add(collision)
				end
			end
		end
	elseif skill.isPsychicSkill then
		local isLast = index == cData.count

		if isLast then
			self:onSkillTargetsResult(skill, skill:getNotSkillEffectTargets())
			self:handleAllPlayerResult()
		end
	elseif skill.isAwakenSkill then
		local isLast = index == cData.count

		if isLast then
			self:onSkillTargetsResult(skill, skill:getNotSkillEffectTargets())
			self:handleAllPlayerResult()
		end
	elseif skill.isCarriedSkillId then
		local isLast = index == cData.count

		if isLast then
			self:onSkillTargetsResult(skill, skill:getNotSkillEffectTargets())
			self:handleAllPlayerResult()
		end
	elseif skill.isOracleSkillId then
		local isLast = index == cData.count

		if isLast then
			self:onSkillTargetsResult(skill, skill:getNotSkillEffectTargets())
			self:handleAllPlayerResult()
		end
	elseif skill.isSourceSkillId then
		local isLast = index == cData.count

		if isLast then
			self:onSkillTargetsResult(skill, skill:getNotSkillEffectTargets())
			self:handleAllPlayerResult()
		end
	elseif skill.isGenesisSkillId then
		local isLast = index == cData.count

		if isLast then
			self:onSkillTargetsResult(skill, skill:getNotSkillEffectTargets())
			self:handleAllPlayerResult()
		end
	end
end

function UnitCompBattleFlowCommon:getFriendTargets(unit, targets)
	if targets then
		local targetsFriend = {}
		local teamId = unit.teamId
		local cnt = #targets

		for i = 1, cnt do
			if targets[i].unit.teamId == teamId then
				table.insert(targetsFriend, targets[i])
			end
		end

		return targetsFriend
	end
end

function UnitCompBattleFlowCommon:getEnemyTargets(unit, targets)
	if targets then
		local targetsEnemy = {}
		local teamId = unit.teamId
		local cnt = #targets

		for i = 1, cnt do
			if targets[i].unit.teamId ~= teamId then
				table.insert(targetsEnemy, targets[i])
			end
		end

		return targetsEnemy
	end
end

function UnitCompBattleFlowCommon:generateBeforeHurtData(skill, result)
	if self:hasBeforeHurtDataResult(result) then
		local unit = self.unitFactory:getUnit(result.target.targetTeamId, result.target.targetCharacterId)

		if unit then
			local hurtData = HurtDataPrepareSkill.New()

			hurtData.target = unit
			hurtData.attacker = skill.unit
			hurtData.skill = skill

			hurtData:generateFromCharactorResult(result)

			return hurtData
		end
	end
end

function UnitCompBattleFlowCommon:hasBeforeHurtDataResult(result)
	if result and result.target and result.targetNum then
		if result.targetNum.beforeBuffHps and #result.targetNum.beforeBuffHps > 0 or result.targetNum.beforeBuffVigours and #result.targetNum.beforeBuffVigours > 0 or result.targetNum.beforeDisplayBuffs and #result.targetNum.beforeDisplayBuffs > 0 then
			return true
		end

		result = result.targetNum

		if result.resultObjectSummary then
			local pbMsg = result.resultObjectSummary

			if pbMsg._fields ~= nil and _G.next(pbMsg._fields) ~= nil then
				for k, v in pairs(pbMsg._fields) do
					local name = k.name
					local list = pbMsg[name]

					if list then
						local cnt = #list

						for i = 1, cnt do
							if list[i].oc == GameEnum.BattleOc.Beffore then
								return true
							end
						end
					end
				end
			end
		end
	end
end

function UnitCompBattleFlowCommon:hasAfterHurtDataResult(result)
	if result and result.target and result.targetNum then
		if result.targetNum.afterBuffHps and #result.targetNum.afterBuffHps > 0 or result.targetNum.afterBuffVigours and #result.targetNum.afterBuffVigours > 0 or result.targetNum.afterDisplayBuffs and #result.targetNum.afterDisplayBuffs > 0 or result.targetNum.attackHps and #result.targetNum.attackHps > 0 or result.targetNum.attackVigours and #result.targetNum.attackVigours > 0 then
			return true
		end

		result = result.targetNum

		if result.resultObjectSummary then
			local pbMsg = result.resultObjectSummary

			if pbMsg._fields ~= nil and _G.next(pbMsg._fields) ~= nil then
				for k, v in pairs(pbMsg._fields) do
					local name = k.name
					local list = pbMsg[name]

					if list then
						local cnt = #list

						for i = 1, cnt do
							if list[i].oc == GameEnum.BattleOc.After then
								return true
							end
						end
					end
				end
			end
		end
	end
end

function UnitCompBattleFlowCommon:generateAfterHurtData(skill, result)
	if self:hasAfterHurtDataResult(result) then
		local unit = self.unitFactory:getUnit(result.target.targetTeamId, result.target.targetCharacterId)

		if unit then
			local hurtData = HurtDataCore.New()

			hurtData.target = unit
			hurtData.attacker = skill.unit

			hurtData:generateFromCharactorResult(result)

			return hurtData
		end
	end
end

function UnitCompBattleFlowCommon:getEnermyCharactors(targetCharacterResults)
	if not targetCharacterResults then
		return
	end

	local cnt = #targetCharacterResults
	local allUnits
	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)
	local unitFactory = battleScene.unitFactory

	for i = 1, cnt do
		local result = targetCharacterResults[i]

		if result.target.targetTeamId ~= self._unit.teamId then
			local unit = unitFactory:getUnit(result.target.targetTeamId, result.target.targetCharacterId)

			allUnits = allUnits or {}

			table.insert(allUnits, unit)
		end
	end

	if not allUnits then
		for i = 1, cnt do
			local result = targetCharacterResults[i]
			local unit = unitFactory:getUnit(result.target.targetTeamId, result.target.targetCharacterId)

			allUnits = allUnits or {}

			table.insert(allUnits, unit)
		end
	end

	return allUnits
end

function UnitCompBattleFlowCommon:collisionHurt(collision)
	local isLast = collision:isLastCollision()
	local targetData = collision:getTarget()
	local skill = collision.skill
	local result = targetData.result
	local hurtData = HurtDataCollision.New()

	hurtData.attacker = skill.unit
	hurtData.target = targetData.unit
	hurtData.skill = skill
	hurtData.collision = collision
	hurtData.targetData = targetData

	hurtData:generateFromCharactorResult(result)

	hurtData.repeling = collision.collisionCo.repel

	if hurtData.repeling > 0 then
		hurtData.repelingSpeed = collision.collisionCo.repelSpeed

		local repelDirX, repelDirY, repelDirZ = collision:getRepelingDir(targetData.unit)

		hurtData.repelingDX = repelDirX
		hurtData.repelingDY = repelDirY
		hurtData.repelingDZ = repelDirZ
	end

	hurtData.hitfly = collision.collisionCo.hitfly
	hurtData.isHard = collision.collisionCo.isHard
	hurtData.donotResult = not isLast

	hurtData:handleData()
	collision:onHurtTarget()

	if isLast then
		self:onCollisionNotSkillEffectHurt(collision)
		self:handleAllPlayerResult()
	end

	collision.skill.unit:notifyBulletHitFinished(collision.collisionCo.index)
end

function UnitCompBattleFlowCommon:handleAllPlayerResult()
	if self.attackEvt and self.attackEvt.oneRoundCharacterResult then
		local targetPlayerResults = self.attackEvt.oneRoundCharacterResult.targetPlayerResults
		local targetCharacterResults = self.attackEvt.oneRoundCharacterResult.targetCharacterResults

		if targetPlayerResults then
			for i = 1, #targetPlayerResults do
				self:handlePlayerResult(targetPlayerResults[i], self:getEnermyCharactors(targetCharacterResults))
			end

			table.clear(self.attackEvt.oneRoundCharacterResult.targetPlayerResults)
		end
	end
end

function UnitCompBattleFlowCommon:onCollisionNotSkillEffectHurt(collision)
	local skill = collision.skill
	local skillsTargets = collision:getNotSkillEffectTargets()

	if skillsTargets then
		local cnt = #skillsTargets

		for i = 1, cnt do
			local targetData = skillsTargets[i]
			local result = targetData.result
			local hurtData = HurtDataCollision.New()

			hurtData.attacker = skill.unit
			hurtData.target = targetData.unit
			hurtData.collision = collision
			hurtData.targetData = targetData

			hurtData:generateFromCharactorResult(result)
			hurtData:handleData()
		end
	end
end

function UnitCompBattleFlowCommon:onSkillTargetsResult(skill, skillsTargets)
	if skillsTargets then
		local cnt = #skillsTargets

		for i = 1, cnt do
			local targetData = skillsTargets[i]
			local hurtData = self:generateAfterHurtData(skill, targetData.result)

			if hurtData then
				hurtData:handleData()
			end
		end
	end
end

function UnitCompBattleFlowCommon:isAttackable(unit)
	local attrs = unit.attrs

	if attrs:isCollisionLocking() then
		return
	end

	if attrs:isSkillLocking() then
		return
	end

	if attrs:isRepeling() then
		return
	end

	if attrs:isBacking() then
		return
	end

	if attrs:isUsingSkill() and not self:isSkillWithDrawByUnit(unit) then
		return
	end

	if attrs:isHitflying() then
		return
	end

	if attrs:isHadring() then
		return
	end

	if attrs:isDodging() then
		return
	end

	if attrs:isBlocking() then
		return
	end

	if attrs:isImmunity() then
		return
	end

	if attrs:isPlayingAnim() then
		return
	end

	if attrs:isTransforming() then
		return
	end

	return true
end

function UnitCompBattleFlowCommon:isRepelable(unit)
	local attrs = unit.attrs

	if attrs:isUsingSkill() then
		return
	end

	if attrs:isPlayingAnim() then
		return
	end

	return true
end

function UnitCompBattleFlowCommon:isHitflyable(unit)
	local attrs = unit.attrs

	if attrs:isUsingSkill() then
		return
	end

	if attrs:isPlayingAnim() then
		return
	end

	return true
end

function UnitCompBattleFlowCommon:isHardable(unit)
	local attrs = unit.attrs

	if attrs:isRepeling() then
		return
	end

	if attrs:isUsingSkill() and not self:isSkillWithDrawByUnit(unit) then
		return
	end

	if attrs:isHitflying() then
		return
	end

	if attrs:isPlayingAnim() then
		return
	end

	return true
end

function UnitCompBattleFlowCommon:isMoveable(unit)
	local attrs = unit.attrs

	if attrs:isDead() then
		return
	end

	if attrs:isRepeling() then
		return
	end

	if attrs:isUsingSkill() then
		return
	end

	if attrs:isHitflying() then
		return
	end

	if attrs:isHadring() then
		return
	end

	if attrs:isDodging() then
		return
	end

	if attrs:isBlocking() then
		return
	end

	if attrs:isImmunity() then
		return
	end

	if attrs:isFakingFmt() then
		return
	end

	if attrs:isPlayingAnim() then
		return
	end

	return true
end

function UnitCompBattleFlowCommon:isIdle(unit, isTriggerSkill)
	local attrs = unit.attrs

	if attrs:isRepeling() then
		return
	end

	if attrs:isBacking() then
		return
	end

	if attrs:isUsingSkill() then
		return
	end

	if attrs:isHitflying() then
		return
	end

	if attrs:isHadring() then
		return
	end

	if attrs:isDodging() then
		return
	end

	if attrs:isBlocking() then
		return
	end

	if attrs:isImmunity() then
		return
	end

	if not isTriggerSkill and attrs:isDead() then
		return
	end

	if attrs:isPlayingAnim() then
		return
	end

	return true
end

function UnitCompBattleFlowCommon:isBackable(unit)
	if forbidBack > 0 then
		return
	end

	if goutil.isNil(unit.go) then
		return
	end

	if not self:isIdle(unit) then
		return
	end

	local attrs = unit.attrs

	if attrs:isFakingFmt() then
		return
	end

	local attrs = unit.attrs

	if attrs:isCombinedSource() then
		return
	end

	if attrs:isTriggerTransPosition() or attrs:isTransPosition() then
		return
	end

	local birthX, birthY, birthZ = attrs:getBirthPoint()
	local posX, posY, posZ = Framework.TransformUtil.GetPos(unit.go.transform, nil, nil, nil)

	if math.abs(posX - birthX) < 0.001 and math.abs(posY - birthY) < 0.001 and math.abs(posZ - birthZ) < 0.001 then
		return
	end

	return true
end

function UnitCompBattleFlowCommon:handlePlayerResult(result, allUnits)
	local hurtData = HurtDataPlayerResult.New()

	hurtData.allUnits = allUnits

	hurtData:generateFromPlayerResult(result)
	hurtData:handleData()
end

function UnitCompBattleFlowCommon:handleCharactorResult(result)
	local hurtData = HurtDataCore.New()

	hurtData.target = self._unit

	hurtData:generateBeforeHurtEvtsFromResultNum(result.targetNum)
	hurtData:generateFromCharactorResult(result)
	hurtData:handleData()
end

function UnitCompBattleFlowCommon.handleCharactorResults(results)
	if not results then
		return
	end

	local cnt = #results
	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)

	for i = 1, cnt do
		local result = results[i]
		local target = result.target

		if target then
			local teamId = result.target.targetTeamId
			local targetCharacterId = result.target.targetCharacterId
			local unit = battleScene.unitFactory:getUnit(teamId, targetCharacterId)

			if unit then
				unit.battleFlow:handleCharactorResult(result)
			end
		end
	end
end

function UnitCompBattleFlowCommon.handlePlayerResults(targetPlayerResults)
	if not targetPlayerResults then
		return
	end

	local cnt = #targetPlayerResults
	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)

	for i = 1, cnt do
		local result = targetPlayerResults[i]

		if result.targetNum and result.targetNum.resultObjectSummary and (result.targetNum.resultObjectSummary.domainChange or result.targetNum.resultObjectSummary.psychicSkillFightViewUpdate or result.targetNum.resultObjectSummary.genesisSkillFightViewUpdate or result.targetNum.resultObjectSummary.spiritInvocationSkillFightViewUpdate) then
			UnitCompBattleFlowCommon:handlePlayerResult(result)
		end
	end
end

function UnitCompBattleFlowCommon:shouldAddBuff(unit, buffId)
	return true
end

function UnitCompBattleFlowCommon:calculateRace(attacker, target, attackerAttrs)
	local enemyType = self:getRace(target)
	local attackerType = 0

	if attacker then
		attackerType = self:getRace(attacker, attackerAttrs)
	end

	if attackerType == 0 or enemyType == 0 then
		return
	end

	local raceCo = BattleConfig.instance:getPetRace()

	return raceCo[attackerType]["attr" .. enemyType], attackerType
end

function UnitCompBattleFlowCommon:getRace(unit, attrs)
	local raceType = 0

	if not attrs then
		::label_38_0::

		local attributes = unit.attrs:getAttributes()

		for k, v in ipairs(attributes) do
			if raceType < GameEnum.Races[v] then
				raceType = GameEnum.Races[v]
			end
		end

		return raceType
	end
end

function UnitCompBattleFlowCommon:onUseItem(itemId, result)
	local hurtData = HurtDataUseItem.New()

	hurtData.target = self._unit
	hurtData.itemId = itemId

	hurtData:generateFromCharactorResult(result)
	hurtData:handleData()
end

return UnitCompBattleFlowCommon
