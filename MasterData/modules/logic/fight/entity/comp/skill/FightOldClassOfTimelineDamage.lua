-- chunkname: @modules/logic/fight/entity/comp/skill/FightOldClassOfTimelineDamage.lua

module("modules.logic.fight.entity.comp.skill.FightOldClassOfTimelineDamage", package.seeall)

local FightOldClassOfTimelineDamage = class("FightOldClassOfTimelineDamage", FightTimelineTrackItem)
local HittingEntity2Counter = {}

FightOldClassOfTimelineDamage.directCharacterHitEffectType = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true,
	[FightEnum.EffectType.NUODIKARANDOMATTACK] = true,
	[FightEnum.EffectType.NUODIKATEAMATTACK] = true,
	[FightEnum.EffectType.EZIOBIGSKILLDAMAGE] = true
}

local originHitEffectType = {
	[FightEnum.EffectType.ORIGINDAMAGE] = true,
	[FightEnum.EffectType.ORIGINCRIT] = true
}

FightOldClassOfTimelineDamage.originHitEffectType = originHitEffectType

local additionalHitEffectType = {
	[FightEnum.EffectType.ADDITIONALDAMAGE] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = true
}

function FightOldClassOfTimelineDamage:setContext(tlEventContext)
	self._context = tlEventContext
end

function FightOldClassOfTimelineDamage:onTrackStart(fightStepData, duration, paramsArr)
	self._paramsArr = paramsArr
	self.fightStepData = fightStepData
	self._duration = duration
	self._attacker = FightHelper.getEntity(fightStepData.fromId)
	self._defeAction = paramsArr[1]

	if not string.nilorempty(paramsArr[2]) then
		self._critAction = paramsArr[2] or paramsArr[1]
	end

	self._missAction = paramsArr[3]
	self._hasRatio = not string.nilorempty(paramsArr[4])
	self._ratio = tonumber(paramsArr[4]) or 0
	self._audioId = tonumber(paramsArr[5]) or 0
	self._isLastHit = paramsArr[6] == "1"

	local buffIds = FightStrUtil.instance:getSplitToNumberCache(paramsArr[7], "#")
	local behaviorTypeIds = FightStrUtil.instance:getSplitToNumberCache(paramsArr[8], "#")
	local effectTemplate = paramsArr[9]

	if not string.nilorempty(paramsArr[10]) then
		local arr = FightStrUtil.instance:getSplitToNumberCache(paramsArr[10], "#")

		self._act_on_index_entity = arr[2]
		self._act_on_entity_count = arr[1]
	else
		self._act_on_index_entity = nil
		self._act_on_entity_count = nil
	end

	local dontSkillEffectIdStr = paramsArr[11]

	self._floatTotalIndex = nil
	self._floatFixedPosArr = nil

	if not string.nilorempty(self._paramsArr[12]) then
		self._floatFixedPosArr = FightStrUtil.instance:getSplitString2Cache(self._paramsArr[12], true)
	end

	self._skinId2OffetPos = nil

	if not string.nilorempty(self._paramsArr[13]) then
		self._skinId2OffetPos = {}

		local arr = FightStrUtil.instance:getSplitCache(self._paramsArr[13], "|")

		for i, v in ipairs(arr) do
			local val = FightStrUtil.instance:getSplitCache(v, "#")
			local skinId = tonumber(val[1])
			local pos = FightStrUtil.instance:getSplitToNumberCache(val[2], ",")

			self._skinId2OffetPos[skinId] = {
				pos[1],
				pos[2]
			}
		end
	end

	self._forcePlayHitForOrigin = self._paramsArr[14] == "1"

	self:_buildSkillEffect(buffIds, behaviorTypeIds, effectTemplate)

	self._floatParams = {}
	self._defenders = {}
	self._hitActionDefenders = {}

	local invoke_list = {}

	invoke_list = self._act_on_index_entity and self:_directCharacterDataFilter() or self.fightStepData.actEffect

	self:_preProcessShieldData(fightStepData, self.fightStepData.actEffect)

	for _, actEffectData in ipairs(invoke_list) do
		if not self:needFilter(actEffectData) then
			local effectType = actEffectData.effectType
			local oneDefender = FightHelper.getEntity(actEffectData.targetId)

			if FightOldClassOfTimelineDamage.directCharacterHitEffectType[actEffectData.effectType] then
				if oneDefender then
					table.insert(self._defenders, oneDefender)

					if actEffectData.effectType == FightEnum.EffectType.SHIELDDEL then
						local effectShieldDel = FightWorkEffectShieldDel.New(fightStepData, actEffectData)

						effectShieldDel:start()
					elseif actEffectData.configEffect == FightEnum.DirectDamageType then
						self:_playDefHit(oneDefender, actEffectData)
					elseif dontSkillEffectIdStr == tostring(actEffectData.configEffect) then
						-- block empty
					else
						self:_playDefHit(oneDefender, actEffectData)
					end
				else
					logNormal("defender hit fail, entity not exist: " .. actEffectData.targetId)
				end
			end

			if self._isLastHit and originHitEffectType[actEffectData.effectType] and oneDefender then
				self:_playDefHit(oneDefender, actEffectData)
			end

			if self._isLastHit and (effectType == FightEnum.EffectType.GUARDCHANGE or effectType == FightEnum.EffectType.GUARDBREAK) then
				self._guardEffectList = self._guardEffectList or {}

				local class = FightStepBuilder.ActEffectWorkCls[effectType].New(self.fightStepData, actEffectData)

				class:start()
				table.insert(self._guardEffectList, class)
			end

			if self._isLastHit and additionalHitEffectType[actEffectData.effectType] and oneDefender then
				self:_playDefHit(oneDefender, actEffectData)
			end

			if effectType == FightEnum.EffectType.EZIOBIGSKILLORIGINDAMAGE then
				if self._isLastHit and oneDefender then
					self:_playDefHit(oneDefender, actEffectData)
				end

				self.hasEzioOriginDamage = true
			end
		end
	end

	if self._ratio > 0 then
		self:_statisticAndFloat()
	end

	self:_playSkillBuff(invoke_list)
	self:_playSkillBehavior()
	self:_trySetKillTimeScale(fightStepData, paramsArr)
end

local FilterEffectType = {
	[FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE] = true,
	[FightEnum.EffectType.DEADLYPOISONORIGINCRIT] = true,
	[FightEnum.EffectType.NONE] = true
}

FightOldClassOfTimelineDamage.nuoDiKaLostLife = 60212

function FightOldClassOfTimelineDamage:needFilter(actEffectData)
	if not actEffectData then
		return true
	end

	local effectType = actEffectData.effectType

	if effectType == FightEnum.EffectType.SHIELD and FilterEffectType[actEffectData.effectNum1] then
		return true
	end

	if actEffectData.configEffect == FightOldClassOfTimelineDamage.nuoDiKaLostLife then
		return true
	end
end

function FightOldClassOfTimelineDamage:onTrackEnd()
	if self._defenders and #self._defenders > 0 then
		self:_onDelayActionFinish()
	end
end

function FightOldClassOfTimelineDamage:_preProcessShieldData(fightStepData, invoke_list)
	if fightStepData.hasProcessShield then
		return
	end

	fightStepData.hasProcessShield = true

	local oldShieldDict = {}

	for i, actEffectData in ipairs(invoke_list) do
		if actEffectData.effectType == FightEnum.EffectType.SHIELD then
			local oneDefender = FightHelper.getEntity(actEffectData.targetId)

			if oneDefender then
				local oldShield = oldShieldDict[actEffectData.targetId]

				if not oldShield then
					local defenderMO = oneDefender:getMO()

					oldShield = defenderMO and defenderMO.shieldValue or 0
					oldShieldDict[actEffectData.targetId] = oldShield
				end

				actEffectData.diffValue = math.abs(actEffectData.effectNum - oldShield)
				actEffectData.sign = oldShield < actEffectData.effectNum and 1 or -1

				local nextMO = invoke_list[i + 1]

				if nextMO and nextMO.effectType == FightEnum.EffectType.SHIELDBROCKEN then
					nextMO = invoke_list[i + 2]
				end

				if nextMO and nextMO.targetId == actEffectData.targetId and originHitEffectType[nextMO.effectType] then
					actEffectData.isShieldOriginDamage = true
					nextMO.shieldOriginEffectNum = nextMO.effectNum + actEffectData.diffValue
				end

				if nextMO and nextMO.targetId == actEffectData.targetId and additionalHitEffectType[nextMO.effectType] then
					actEffectData.isShieldAdditionalDamage = true
					nextMO.shieldAdditionalEffectNum = nextMO.effectNum + actEffectData.diffValue
				end

				oldShieldDict[actEffectData.targetId] = actEffectData.effectNum
			end
		end

		if actEffectData.effectType == FightEnum.EffectType.SHIELDDEL then
			oldShieldDict[actEffectData.targetId] = 0
		end

		if actEffectData.effectType == FightEnum.EffectType.SHIELDVALUECHANGE then
			oldShieldDict[actEffectData.targetId] = actEffectData.effectNum
		end
	end
end

function FightOldClassOfTimelineDamage:_buildSkillEffect(buffIds, behaviorTypeIds, effectTemplate)
	self._buffIdDict = {}
	self._behaviorTypeDict = {}

	if string.nilorempty(effectTemplate) then
		for _, buffId in ipairs(buffIds) do
			self._buffIdDict[buffId] = true
		end

		for _, behaviorType in ipairs(behaviorTypeIds) do
			self._behaviorTypeDict[behaviorType] = true
		end
	else
		local skillEffectIds = FightStrUtil.instance:getSplitToNumberCache(effectTemplate, "#")

		for _, skillEffectId in ipairs(skillEffectIds) do
			local skillEffectCO = lua_skill_effect.configDict[skillEffectId]

			if skillEffectCO then
				for i = 1, FightEnum.MaxBehavior do
					local behavior = skillEffectCO["behavior" .. i]
					local sp = FightStrUtil.instance:getSplitToNumberCache(behavior, "#")
					local behaviorType = sp[1]

					if sp and #sp > 0 and behaviorType == 1 then
						local buffId = sp[2]

						self._buffIdDict[buffId] = true
					end

					if sp and #sp > 0 then
						self._behaviorTypeDict[behaviorType] = true
					end
				end
			else
				logError("技能调用效果不存在" .. skillEffectId)
			end
		end
	end
end

function FightOldClassOfTimelineDamage:_playDefHit(oneDefender, actEffectData)
	FightDataHelper.playEffectData(actEffectData)

	local attackerMO = self._attacker:getMO()
	local defenderMO = oneDefender:getMO()

	self:com_sendFightEvent(FightEvent.PlayTimelineHit, self.fightStepData, defenderMO, attackerMO)

	local attackerCO = attackerMO and attackerMO:getCO()
	local defenderCO = defenderMO and defenderMO:getCO()

	if attackerCO then
		if not attackerCO.career then
			local career1 = 0

			if defenderCO then
				if not defenderCO.career then
					local career2 = 0
					local version = FightModel.instance:getVersion()

					if version >= 2 and attackerMO and defenderMO then
						career1 = attackerMO.career
						career2 = defenderMO.career
					end

					local restrain = FightConfig.instance:getRestrain(career1, career2) or 1000

					if attackerMO and FightBuffHelper.restrainAll(attackerMO.id) then
						restrain = 1100
					end

					local attactBuffComp = self._attacker.buff
					local isRestrain = ((attactBuffComp and attactBuffComp:haveBuffId(72540006) or nil) and ((career2 == 1 or career2 == 2 or career2 == 3 or career2 == 4) and 1100 or 1000)) > 1000

					if actEffectData.hurtInfo then
						isRestrain = actEffectData.hurtInfo.careerRestraint
					end

					local fixedPos

					if self._floatFixedPosArr then
						if self._floatTotalIndex then
							self._floatTotalIndex = self._floatTotalIndex + 1 or 1
						end

						fixedPos = self._floatFixedPosArr[self._floatTotalIndex] or self._floatFixedPosArr[#self._floatFixedPosArr]
					end

					local nuoDiKaDamage = (actEffectData.effectType == FightEnum.EffectType.NUODIKARANDOMATTACK or actEffectData.effectType == FightEnum.EffectType.NUODIKATEAMATTACK) and actEffectData.effectNum1 == FightEnum.EffectType.DAMAGE
					local nuoDiKaCrit = (actEffectData.effectType == FightEnum.EffectType.NUODIKARANDOMATTACK or actEffectData.effectType == FightEnum.EffectType.NUODIKATEAMATTACK) and actEffectData.effectNum1 == FightEnum.EffectType.CRIT

					if actEffectData.effectType == FightEnum.EffectType.DAMAGE or nuoDiKaDamage then
						local showFloat = true

						if self.ezioDamage == actEffectData.configEffect then
							showFloat = false
							FightDataHelper.tempMgr.aiJiAoFakeHpOffset = {}
						end

						local numAbs = self:_calcNum(actEffectData.clientId, actEffectData.targetId, actEffectData.effectNum, self._ratio)
						local decreaseHp = numAbs

						if oneDefender.nameUI then
							if nuoDiKaDamage then
								local shield = oneDefender.nameUI._curShield

								if shield and shield > 0 then
									if decreaseHp <= shield then
										shield = shield - decreaseHp

										oneDefender.nameUI:setShield(shield)
										FightController.instance:dispatchEvent(FightEvent.SetFakeNuoDiKaDamageShield, defenderMO.id, shield)

										decreaseHp = 0
									else
										shield = 0

										oneDefender.nameUI:setShield(0)
										FightController.instance:dispatchEvent(FightEvent.SetFakeNuoDiKaDamageShield, defenderMO.id, shield)

										decreaseHp = decreaseHp - shield
									end
								end
							end

							oneDefender.nameUI:addHp(-decreaseHp)
						end

						if isRestrain then
							if not FightEnum.FloatType.restrain then
								local floatType = FightEnum.FloatType.damage

								if oneDefender:isMySide() then
									if not -numAbs then
										local floatNum = numAbs

										if showFloat then
											table.insert(self._floatParams, {
												actEffectData.targetId,
												floatType,
												floatNum,
												actEffectData.effectNum1 == 1
											})
										end

										if numAbs ~= 0 then
											self:_checkPlayAction(oneDefender, self._defeAction, actEffectData)
										end

										self:_playHitAudio(oneDefender, false)
										self:_playHitVoice(oneDefender)
										FightController.instance:dispatchEvent(FightEvent.OnHpChange, oneDefender, -decreaseHp)
										FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, self.fightStepData, actEffectData, oneDefender, floatNum, self._isLastHit, fixedPos)
									end
								end
							end
						end
					elseif actEffectData.effectType == FightEnum.EffectType.CRIT or nuoDiKaCrit then
						local showFloat = true

						if self.ezioDamage == actEffectData.configEffect then
							showFloat = false
							FightDataHelper.tempMgr.aiJiAoFakeHpOffset = {}
						end

						local numAbs = self:_calcNum(actEffectData.clientId, actEffectData.targetId, actEffectData.effectNum, self._ratio)
						local decreaseHp = numAbs

						if oneDefender.nameUI then
							if nuoDiKaCrit then
								local shield = oneDefender.nameUI._curShield

								if shield and shield > 0 then
									if decreaseHp <= shield then
										shield = shield - decreaseHp

										oneDefender.nameUI:setShield(shield)
										FightController.instance:dispatchEvent(FightEvent.SetFakeNuoDiKaDamageShield, defenderMO.id, shield)

										decreaseHp = 0
									else
										shield = 0

										oneDefender.nameUI:setShield(0)
										FightController.instance:dispatchEvent(FightEvent.SetFakeNuoDiKaDamageShield, defenderMO.id, shield)

										decreaseHp = decreaseHp - shield
									end
								end
							end

							oneDefender.nameUI:addHp(-decreaseHp)
						end

						if isRestrain then
							if not FightEnum.FloatType.crit_restrain then
								local floatType = FightEnum.FloatType.crit_damage

								if oneDefender:isMySide() then
									if not -numAbs then
										local floatNum = numAbs

										if showFloat then
											table.insert(self._floatParams, {
												actEffectData.targetId,
												floatType,
												floatNum,
												actEffectData.effectNum1 == 1
											})
										end

										if numAbs ~= 0 then
											self:_checkPlayAction(oneDefender, self._critAction, actEffectData)
										end

										self:_playHitAudio(oneDefender, true)
										self:_playHitVoice(oneDefender)
										FightController.instance:dispatchEvent(FightEvent.OnHpChange, oneDefender, -decreaseHp)
										FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, self.fightStepData, actEffectData, oneDefender, floatNum, self._isLastHit, fixedPos)
									end
								end
							end
						end
					elseif actEffectData.effectType == FightEnum.EffectType.MISS then
						if self._ratio > 0 then
							self:_checkPlayAction(oneDefender, self._missAction, actEffectData)
							FightFloatMgr.instance:float(actEffectData.targetId, FightEnum.FloatType.buff, luaLang("fight_float_miss"), FightEnum.BuffFloatEffectType.Good, false)
						end
					elseif actEffectData.effectType == FightEnum.EffectType.EZIOBIGSKILLDAMAGE then
						self.ezioDamage = actEffectData.configEffect

						local numAbs = self:_calcNum(actEffectData.clientId, actEffectData.targetId, actEffectData.effectNum, self._ratio)

						FightWorkEzioBigSkillDamage1000.fakeDecreaseHp(oneDefender.id, numAbs)
						self:com_sendFightEvent(FightEvent.AiJiAoFakeDecreaseHp, oneDefender.id)

						if isRestrain then
							if not FightEnum.FloatType.restrain then
								if oneDefender:isMySide() then
									if not -numAbs then
										local floatNum = numAbs

										table.insert(self._floatParams, {
											actEffectData.targetId,
											(actEffectData.effectNum1 == 3 or nil) and (isRestrain and FightEnum.FloatType.crit_restrain or FightEnum.FloatType.crit_damage),
											floatNum,
											true
										})

										if numAbs ~= 0 then
											self:_checkPlayAction(oneDefender, self._defeAction, actEffectData)
										end

										self:_playHitAudio(oneDefender, false)
										self:_playHitVoice(oneDefender)
									end
								end
							end
						end
					elseif actEffectData.effectType == FightEnum.EffectType.EZIOBIGSKILLORIGINDAMAGE then
						self.ezioDamage = actEffectData.configEffect

						local numAbs = actEffectData.effectNum

						FightWorkEzioBigSkillDamage1000.fakeDecreaseHp(oneDefender.id, numAbs)
						self:com_sendFightEvent(FightEvent.AiJiAoFakeDecreaseHp, oneDefender.id)

						if actEffectData.effectNum1 == 131 then
							if not FightEnum.FloatType.crit_damage_origin then
								local floatType = FightEnum.FloatType.damage_origin

								if oneDefender:isMySide() then
									if not -numAbs then
										local floatNum = numAbs

										table.insert(self._floatParams, {
											actEffectData.targetId,
											floatType,
											floatNum,
											false
										})

										if numAbs ~= 0 then
											self:_checkPlayAction(oneDefender, self._defeAction, actEffectData)
										end

										self:_playHitAudio(oneDefender, false)
										self:_playHitVoice(oneDefender)
									end
								end
							end
						end
					elseif actEffectData.effectType == FightEnum.EffectType.SHIELD then
						local numAbs = self:_calcNum(actEffectData.clientId, actEffectData.targetId, actEffectData.diffValue or 0, self._ratio)

						if oneDefender:isMySide() then
							if not -numAbs then
								local floatNum = numAbs

								if oneDefender.nameUI then
									oneDefender.nameUI:setShield(oneDefender.nameUI._curShield + numAbs * actEffectData.sign)
								end

								if actEffectData.sign == -1 then
									if not actEffectData.isShieldOriginDamage and not actEffectData.isShieldAdditionalDamage then
										if isRestrain then
											if not FightEnum.FloatType.shield_restrain then
												do
													local floatType = FightEnum.FloatType.shield_damage

													table.insert(self._floatParams, {
														actEffectData.targetId,
														floatType,
														floatNum,
														actEffectData.buffActId == 1
													})
												end

												local playHit = not not FightHelper.checkShieldHit(actEffectData)

												if actEffectData.effectNum1 == FightEnum.EffectType.ORIGINDAMAGE and not self._forcePlayHitForOrigin then
													playHit = false
												end

												if actEffectData.effectNum1 == FightEnum.EffectType.ORIGINCRIT and not self._forcePlayHitForOrigin then
													playHit = false
												end

												if numAbs ~= 0 and playHit then
													self:_checkPlayAction(oneDefender, self._defeAction, actEffectData)
												end

												if playHit then
													self:_playHitAudio(oneDefender, false)
													self:_playHitVoice(oneDefender)
												end
											end
										end
									end
								end

								FightController.instance:dispatchEvent(FightEvent.OnShieldChange, oneDefender, numAbs * actEffectData.sign)
								FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, self.fightStepData, actEffectData, oneDefender, floatNum, self._isLastHit, fixedPos)
							end
						end
					elseif originHitEffectType[actEffectData.effectType] then
						local numAbs = actEffectData.effectNum
						local isCrit = actEffectData.effectType == FightEnum.EffectType.ORIGINCRIT

						if numAbs > 0 and oneDefender.nameUI then
							oneDefender.nameUI:addHp(-numAbs)
						end

						if isCrit then
							if not FightEnum.FloatType.crit_damage_origin then
								local floatType = FightEnum.FloatType.damage_origin

								if oneDefender:isMySide() then
									if not -numAbs then
										local floatNum = numAbs

										if not actEffectData.shieldOriginEffectNum then
											if numAbs > 0 then
												table.insert(self._floatParams, {
													actEffectData.targetId,
													floatType,
													floatNum,
													actEffectData.effectNum1 == 1
												})
											end
										end

										if oneDefender:isMySide() then
											if not -actEffectData.shieldOriginEffectNum then
												do
													local tempNum = actEffectData.shieldOriginEffectNum

													table.insert(self._floatParams, {
														actEffectData.targetId,
														floatType,
														tempNum,
														actEffectData.effectNum1 == 1
													})
												end

												if numAbs > 0 then
													FightController.instance:dispatchEvent(FightEvent.OnHpChange, oneDefender, -numAbs)
													FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, self.fightStepData, actEffectData, oneDefender, floatNum, self._isLastHit, fixedPos)
												end

												if self._forcePlayHitForOrigin then
													self:_checkPlayAction(oneDefender, self._defeAction, actEffectData)
													self:_playHitAudio(oneDefender, false)
													self:_playHitVoice(oneDefender)
												end
											end
										end
									end
								end
							end
						end
					elseif additionalHitEffectType[actEffectData.effectType] then
						local numAbs = actEffectData.effectNum
						local isCrit = actEffectData.effectType == FightEnum.EffectType.ADDITIONALDAMAGECRIT

						if numAbs > 0 and oneDefender.nameUI then
							oneDefender.nameUI:addHp(-numAbs)
						end

						if isCrit then
							if not FightEnum.FloatType.crit_additional_damage then
								local floatType = FightEnum.FloatType.additional_damage

								if oneDefender:isMySide() then
									if not -numAbs then
										local floatNum = numAbs

										if not actEffectData.shieldAdditionalEffectNum then
											if numAbs > 0 then
												table.insert(self._floatParams, {
													actEffectData.targetId,
													floatType,
													floatNum,
													actEffectData.effectNum1 == 1
												})
											end
										end

										if oneDefender:isMySide() then
											if not -actEffectData.shieldAdditionalEffectNum then
												do
													local tempNum = actEffectData.shieldAdditionalEffectNum

													table.insert(self._floatParams, {
														actEffectData.targetId,
														floatType,
														tempNum,
														actEffectData.effectNum1 == 1
													})
												end

												if numAbs > 0 then
													FightController.instance:dispatchEvent(FightEvent.OnHpChange, oneDefender, -numAbs)
													FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, self.fightStepData, actEffectData, oneDefender, floatNum, self._isLastHit, fixedPos)
												end
											end
										end
									end
								end
							end
						end
					end

					FightDataHelper.playEffectData(actEffectData)
				end
			end
		end
	end
end

function FightOldClassOfTimelineDamage:_statisticAndFloat()
	local targetFloatDict = {}

	for _, param in ipairs(self._floatParams) do
		local targetId = param[1]
		local floatType = param[2]
		local num = param[3]
		local isAssassinate = param[4]
		local targetDict = targetFloatDict[targetId]

		if not targetDict then
			targetDict = {
				list = {}
			}
			targetFloatDict[targetId] = targetDict
		end

		if not targetDict[floatType] then
			local tb = {
				floatType = floatType,
				num = num,
				isAssassinate = isAssassinate
			}

			table.insert(targetDict.list, tb)

			targetDict[floatType] = tb
		else
			local oldValue = targetDict[floatType]

			oldValue.num = oldValue.num + num

			if isAssassinate then
				oldValue.isAssassinate = true
			end
		end
	end

	local entity_index = 0

	for targetId, targetDict in pairs(targetFloatDict) do
		local transferDic = {}

		for floatType, tb in pairs(targetDict) do
			local num = tb.num

			if num and num ~= 0 then
				local finallyFloatType = floatType

				if floatType == FightEnum.FloatType.shield_damage then
					finallyFloatType = targetDict[FightEnum.FloatType.damage] and FightEnum.FloatType.damage or FightEnum.FloatType.crit_damage
				elseif floatType == FightEnum.FloatType.shield_restrain then
					finallyFloatType = targetDict[FightEnum.FloatType.restrain] and FightEnum.FloatType.restrain or FightEnum.FloatType.crit_restrain
				elseif floatType == FightEnum.FloatType.shield_berestrain then
					finallyFloatType = targetDict[FightEnum.FloatType.berestrain] and FightEnum.FloatType.berestrain or FightEnum.FloatType.crit_berestrain
				end

				if finallyFloatType ~= floatType then
					targetDict[floatType] = 0
					tb.num = 0

					if targetDict[finallyFloatType] then
						local existNum = targetDict[finallyFloatType]

						existNum.num = existNum.num + num
					elseif not transferDic[finallyFloatType] then
						local newTb = {
							floatType = finallyFloatType,
							num = num
						}

						table.insert(targetDict.list, newTb)

						transferDic[finallyFloatType] = newTb
					else
						local existNum = transferDic[finallyFloatType]

						existNum.num = existNum.num + num
					end
				end
			end
		end

		entity_index = entity_index + 1

		table.sort(targetDict.list, FightOldClassOfTimelineDamage._sortByFloatType)

		for _, tb in pairs(targetDict.list) do
			local floatType = tb.floatType
			local num = tb.num
			local isAssassinate = tb.isAssassinate

			if num ~= 0 then
				local param

				if self._floatFixedPosArr then
					param = {}

					if entity_index >= #self._floatFixedPosArr then
						entity_index = #self._floatFixedPosArr
					end

					param.pos_x = self._floatFixedPosArr[entity_index][1]
					param.pos_y = self._floatFixedPosArr[entity_index][2]
				end

				local oneDefender = FightHelper.getEntity(targetId)

				if self._skinId2OffetPos then
					local entityMO = oneDefender:getMO()

					if entityMO then
						local offsetData = self._skinId2OffetPos[entityMO.skin]

						if offsetData then
							param = param or {}
							param.offset_x = offsetData[1]
							param.offset_y = offsetData[2]
						end
					end
				end

				FightFloatMgr.instance:float(targetId, floatType, num, param, isAssassinate)
				FightController.instance:dispatchEvent(FightEvent.OnDamageTotal, self.fightStepData, oneDefender, num, self._isLastHit)
			end
		end
	end
end

local FloatOrder = {
	[FightEnum.FloatType.additional_damage] = 10,
	[FightEnum.FloatType.crit_additional_damage] = 11,
	[FightEnum.FloatType.damage_origin] = 12,
	[FightEnum.FloatType.crit_damage_origin] = 13
}

function FightOldClassOfTimelineDamage._sortByFloatType(tb1, tb2)
	if not FloatOrder[tb1.floatType] then
		local order1 = 100

		if not FloatOrder[tb2.floatType] then
			local order2 = 100

			if order1 ~= order2 then
				return order2 < order1
			end

			return tb1.num > tb2.num
		end
	end
end

function FightOldClassOfTimelineDamage:_playHitAudio(entity, isCrit)
	if self._audioId > 0 then
		FightAudioMgr.instance:playHit(self._audioId, entity:getMO().skin, isCrit)
	elseif self._ratio > 0 and self.fightStepData.atkAudioId and self.fightStepData.atkAudioId > 0 then
		FightAudioMgr.instance:playHitByAtkAudioId(self.fightStepData.atkAudioId, entity:getMO().skin, isCrit)
	end
end

function FightOldClassOfTimelineDamage:_playHitVoice(entity)
	if self._isLastHit then
		local isMySide = entity:isMySide()
		local customAudioLang = GameConfig:GetCurVoiceShortcut()
		local entityMO = entity:getMO()
		local heroId = entityMO and entityMO.modelId

		if isMySide and heroId then
			local charVoiceLangId, langStr, usingDefaultLang = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)
			local charVoiceLang = LangSettings.shortcutTab[charVoiceLangId]

			if not string.nilorempty(charVoiceLang) and not usingDefaultLang then
				customAudioLang = charVoiceLang
			end
		end

		FightAudioMgr.instance:playHitVoice(heroId, customAudioLang)
	end
end

function FightOldClassOfTimelineDamage:_calcNum(actEffectDataId, targetId, effectNum, ratio)
	if self._hasRatio then
		self._context.floatNum = self._context.floatNum or {}
		self._context.floatNum[targetId] = self._context.floatNum[targetId] or {}
		self._context.floatNum[targetId][actEffectDataId] = self._context.floatNum[targetId][actEffectDataId] or {}

		local numTable = self._context.floatNum[targetId][actEffectDataId]

		if not numTable.ratio then
			local preRatio = 0

			if not numTable.total then
				local preTotal = 0
				local nowRatio = ratio + preRatio

				nowRatio = nowRatio < 1 and nowRatio or 1

				local num = math.floor(nowRatio * effectNum + 0.5) - preTotal

				numTable.ratio = ratio + preRatio
				numTable.total = preTotal + num

				return num
			end
		end
	else
		return 0
	end
end

function FightOldClassOfTimelineDamage:_checkPlayAction(entity, action, actEffectData)
	if string.nilorempty(action) then
		return
	end

	local curState = entity.spine:getAnimState()
	local tar_is_dead

	for i, v in ipairs(self.fightStepData.actEffect) do
		if v.effectType == FightEnum.EffectType.DEAD and v.targetId == entity.id then
			tar_is_dead = true
		end
	end

	if self._isLastHit then
		if tar_is_dead and self.fightStepData.actId == entity.deadBySkillId and self:_canPlayDead(actEffectData) then
			if entity:getSide() ~= self._attacker:getSide() then
				FightController.instance:dispatchEvent(FightEvent.OnSkillLastHit, entity.id, self.fightStepData)
			end
		elseif curState ~= SpineAnimState.freeze then
			self:_playAction(entity, action)
		end
	elseif tar_is_dead and self.fightStepData.actId == entity.deadBySkillId then
		if curState ~= SpineAnimState.freeze and curState ~= SpineAnimState.die then
			self:_playAction(entity, action)
		end
	elseif curState ~= SpineAnimState.freeze then
		self:_playAction(entity, action)
	end
end

function FightOldClassOfTimelineDamage:_playAction(entity, action)
	if not entity then
		return
	end

	if not entity.buff then
		return
	end

	if entity.buff and entity.buff:haveBuffId(2112031) then
		return
	end

	action = FightHelper.processEntityActionName(entity, action, self.fightStepData)

	if entity.spine then
		entity.spine:play(action, false, true, true)
		entity.spine:addAnimEventCallback(self._onAnimEvent, self, {
			entity,
			action
		})
	end

	table.insert(self._hitActionDefenders, entity)

	HittingEntity2Counter[entity.id] = HittingEntity2Counter[entity.id] or HittingEntity2Counter[entity.id] + 1
end

function FightOldClassOfTimelineDamage:_onAnimEvent(actionName, eventName, eventArgs, param)
	local entity = param[1]
	local action = param[2]

	if eventName == SpineAnimEvent.ActionComplete and actionName == action then
		entity.spine:removeAnimEventCallback(self._onAnimEvent, self)
		entity:resetAnimState()
	end
end

function FightOldClassOfTimelineDamage:_onDelayActionFinish()
	if self._hitActionDefenders then
		for _, defender in ipairs(self._hitActionDefenders) do
			defender.spine:removeAnimEventCallback(self._onAnimEvent, self)

			if not HittingEntity2Counter[defender.id] then
				HittingEntity2Counter[defender.id] = HittingEntity2Counter[defender.id] - 1

				if HittingEntity2Counter[defender.id] == 0 then
					defender:resetAnimState()
				end
			end
		end

		self._hitActionDefenders = nil
	end
end

function FightOldClassOfTimelineDamage:_playSkillBuff(invoke_list)
	if GameUtil.tabletool_dictIsEmpty(self._buffIdDict) then
		return
	end

	for _, actEffectData in ipairs(invoke_list) do
		local oneDefender = FightHelper.getEntity(actEffectData.targetId)

		if oneDefender and FightEnum.BuffEffectType[actEffectData.effectType] and self._buffIdDict and self._buffIdDict[actEffectData.buff.buffId] then
			FightSkillBuffMgr.instance:playSkillBuff(self.fightStepData, actEffectData)
		end
	end
end

function FightOldClassOfTimelineDamage:_playSkillBehavior()
	if not self._behaviorTypeDict then
		return
	end

	FightSkillBehaviorMgr.instance:playSkillBehavior(self.fightStepData, self._behaviorTypeDict, true)
end

function FightOldClassOfTimelineDamage:_trySetKillTimeScale(fightStepData, param)
	self._context.hitCount = (self._context.hitCount or 0) + 1

	local isFinal = param[7] == "1"

	if not isFinal then
		return
	end

	local entity = FightHelper.getEntity(fightStepData.fromId)
	local entityMO = entity:getMO()

	if not entityMO then
		return
	end

	if entityMO.side ~= FightEnum.EntitySide.MySide or not entityMO:isCharacter() then
		return
	end

	local skillId = fightStepData.actId

	if not FightCardDataHelper.isBigSkill(skillId) then
		return
	end

	local isKill = false

	for _, actEffectData in ipairs(self.fightStepData.actEffect) do
		if actEffectData.effectType == FightEnum.EffectType.DEAD then
			isKill = true

			break
		end
	end

	if not isKill then
		return
	end

	if self._context.hitCount and self._context.hitCount > 1 then
		TaskDispatcher.runDelay(self._revertKillTimeScale, self, 0.2)
	else
		TaskDispatcher.runDelay(self._revertKillTimeScale, self, 0.2)
	end
end

function FightOldClassOfTimelineDamage:_directCharacterDataFilter()
	local invoke_list = {}
	local filterDic = {}

	for k, v in pairs(FightOldClassOfTimelineDamage.directCharacterHitEffectType) do
		filterDic[k] = v
	end

	for k, v in pairs(originHitEffectType) do
		filterDic[k] = v
	end

	for k, v in pairs(additionalHitEffectType) do
		filterDic[k] = v
	end

	local effect_list = FightHelper.filterActEffect(self.fightStepData.actEffect, filterDic)
	local numerator, denominator = LuaUtil.float2Fraction(self._ratio)
	local data_len = #effect_list
	local act_on_index, act_on_target_id

	if effect_list[self._act_on_index_entity] then
		act_on_target_id = effect_list[self._act_on_index_entity][1].targetId
		act_on_index = self._act_on_index_entity
	elseif data_len > 0 then
		act_on_target_id = effect_list[data_len][1].targetId
		act_on_index = data_len
	end

	if self._act_on_entity_count ~= data_len and act_on_index == data_len then
		numerator, denominator = LuaUtil.divisionOperation2Fraction(self._ratio, self._act_on_entity_count - data_len + 1)
		self._ratio = self._ratio / (self._act_on_entity_count - data_len + 1)
	end

	for i, v in ipairs(self.fightStepData.actEffect) do
		if v.targetId == act_on_target_id then
			table.insert(invoke_list, v)
		end
	end

	for i = #invoke_list, 1, -1 do
		local actEffectData = invoke_list[i]

		if not actEffectData then
			logError("找不到数据")
		end

		if self:_detectInvokeActEffect(actEffectData.clientId, actEffectData.targetId, numerator, denominator) then
			-- block empty
		elseif not FightOldClassOfTimelineDamage.directCharacterHitEffectType[actEffectData.effectType] then
			table.remove(invoke_list, i)
		end
	end

	return invoke_list
end

function FightOldClassOfTimelineDamage:_detectInvokeActEffect(actEffectDataId, targetId, numerator, denominator)
	if self._hasRatio then
		self._context.ratio_fraction = self._context.ratio_fraction or {}
		self._context.ratio_fraction[targetId] = self._context.ratio_fraction[targetId] or self._context.ratio_fraction[targetId] or {}

		if not self._context.ratio_fraction[targetId][actEffectDataId] then
			self._context.ratio_fraction[targetId][actEffectDataId] = self._context.ratio_fraction[targetId][actEffectDataId] or {}
			self._context.ratio_fraction[targetId][actEffectDataId].numerator = 0
			self._context.ratio_fraction[targetId][actEffectDataId].denominator = 1
		end

		local final_numerator, final_denominator = LuaUtil.fractionAddition(self._context.ratio_fraction[targetId][actEffectDataId].numerator, self._context.ratio_fraction[targetId][actEffectDataId].denominator, numerator, denominator)

		self._context.ratio_fraction[targetId][actEffectDataId].numerator = final_numerator
		self._context.ratio_fraction[targetId][actEffectDataId].denominator = final_denominator

		return final_denominator <= final_numerator
	end

	return true
end

function FightOldClassOfTimelineDamage:_canPlayDead(actEffectData)
	if self._context.ratio_fraction and self._context.ratio_fraction[actEffectData.targetId] and self._context.ratio_fraction[actEffectData.targetId][actEffectData.clientId] then
		return self._context.ratio_fraction[actEffectData.targetId][actEffectData.clientId].numerator >= self._context.ratio_fraction[actEffectData.targetId][actEffectData.clientId].denominator
	end

	return true
end

function FightOldClassOfTimelineDamage:_revertKillTimeScale()
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.FightKillEnemy, 1)
end

function FightOldClassOfTimelineDamage:onDestructor()
	self:_onDelayActionFinish()

	if self._guardEffectList then
		for i, v in ipairs(self._guardEffectList) do
			v:disposeSelf()
		end

		self._guardEffectList = nil
	end

	self:_revertKillTimeScale()
	TaskDispatcher.cancelTask(self._revertKillTimeScale, self)

	self._defenders = nil
	self._attacker = nil

	self:showEzioOriginFloat()
end

function FightOldClassOfTimelineDamage:showEzioOriginFloat()
	if self.ezioDamage and not self._isLastHit and self.hasEzioOriginDamage then
		for i, actEffectData in ipairs(self.fightStepData.actEffect) do
			if actEffectData.effectType == FightEnum.EffectType.EZIOBIGSKILLORIGINDAMAGE and not actEffectData:isDone() then
				local entityId = actEffectData.targetId

				FightDataHelper.playEffectData(actEffectData)

				local numAbs = actEffectData.effectNum

				if actEffectData.effectNum1 == 131 then
					if not FightEnum.FloatType.crit_damage_origin then
						local floatType = FightEnum.FloatType.damage_origin
						local oneDefender = FightHelper.getEntity(entityId)

						if oneDefender then
							if oneDefender:isMySide() then
								if not -numAbs then
									local floatNum = numAbs

									FightFloatMgr.instance:float(actEffectData.targetId, floatType, floatNum, nil, false)
								end
							end
						end
					end
				end
			end
		end
	end
end

return FightOldClassOfTimelineDamage
