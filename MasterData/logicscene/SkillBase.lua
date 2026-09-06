-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/skills/SkillBase.lua

module("logicscene.scene.battle.skills.skills.SkillBase", package.seeall)

local SkillBase = class("SkillBase")

function SkillBase:ctor(skillId, unit)
	self.skillCo = BattleConfig.instance:getSkillCo(skillId, unit.modelId)

	if not self.skillCo then
		printError("技能ID不存在：" .. skillId, "_mid:", unit.modelId)
	end

	self.unit = unit
	self._isPlaying = nil
	self._skillTime = 0
	self._skillTimeCount = 0
	self._isPause = nil
	self._skillTargets = nil
	self._notSkillEffectTargets = nil
	self._skillAnimStarted = nil
	self.prepareHurtData = nil
	self._isWithDraw = nil
	self._isCollisionEnd = nil
	self.resumeVigours = nil
	self.resumeRecords = nil
	self.costVigours = nil
	self.unitAttrs = nil
	self.damgeCollsionCnt = nil
	self.damageCollisionTotalCnt = 0
	self._isShowDamageHud = nil
	self._countCollisions = nil

	self:_prepareSkillsType()
end

function SkillBase:_prepareSkillsType()
	if self.skillCo then
		local skillList = self.unit.skillList

		if skillList.ultimateSkillId == self.skillCo.id or self.skillCo.type == GameEnum.SkillType.Utl then
			self.isUtlSkill = true
		elseif skillList.normalSkillId == self.skillCo.id then
			self.isNormalSkill = true
		elseif skillList.passiveSkillId == self.skillCo.id then
			self.isPassiveSkillId = true
		elseif skillList.heroSkillId == self.skillCo.id then
			self.isHeroSkillId = true
		elseif skillList.summonSkillId == self.skillCo.id then
			self.isSummonSkillId = true
		elseif skillList.doppelgangerSkillId == self.skillCo.id then
			self.isDoppelgangerSkillId = true
		elseif skillList.psychicedNormalSkillId == self.skillCo.id then
			self.isPsychicedNormalSkill = true
		elseif skillList.psychicedUltimateSkillId == self.skillCo.id then
			self.isPsychicedUltimateSkill = true
		elseif skillList.psychicSkillId == self.skillCo.id then
			self.isPsychicSkill = true

			self:setSupportEmptyTargets(true)
		elseif skillList.awakenSkillId == self.skillCo.id then
			self.isAwakenSkill = true

			self:setSupportEmptyTargets(true)
		elseif skillList.carriedSkillId == self.skillCo.id then
			self.isCarriedSkillId = true

			self:setSupportEmptyTargets(true)
		elseif skillList.oracleSkillId == self.skillCo.id then
			self.isOracleSkillId = true

			self:setSupportEmptyTargets(true)
		elseif skillList.sourceSkillId == self.skillCo.id then
			self.isSourceSkillId = true

			self:setSupportEmptyTargets(true)
		elseif skillList.heavenAwakenSkillId == self.skillCo.id then
			self.isHeavenAwakenSkillId = true
		elseif skillList.genesisSkillId == self.skillCo.id then
			self.isGenesisSkillId = true

			self:setSupportEmptyTargets(true)
		end
	end
end

function SkillBase:useSkill(skillExecuteState, isStrickBack, attackCount)
	if self._isPlaying then
		self:breakSkill()
	end

	self._isPauseOnTranTransforming = nil
	self._isPauseOnUsingSpiritInvocation = nil
	self._isShowDamageHud = nil
	self.isStrickBack = isStrickBack
	self._skillExecuteState = skillExecuteState
	self._skillTime = 0
	self._countCollisions = nil
	self._skillTimeCount = 0
	self._isPause = nil
	self._skillResourceReady = nil
	self._isPlaying = true
	self._skillAnimStarted = nil
	self._isWithDraw = nil
	self._isCollisionEnd = nil
	self._isPlaying = true
	self._attackCount = attackCount
	self._playingTake = self:_getAnimationPath(self._attackTarget, attackCount)

	if self:_hasTake() then
		self:_preLoadSkillResources()
	else
		self:_onSkillStart()
	end

	return true
end

function SkillBase:skillType()
	return self.skillCo.funtionType
end

function SkillBase:isCombineSkill()
	return self.skillCo.type == GameEnum.SkillType.Combine
end

function SkillBase:setSupportEmptyTargets(support)
	self._supportEmptyTargets = support
end

function SkillBase:breakSkill()
	self:_onSkillEnd()
end

function SkillBase:pause()
	if self._isPlaying then
		self._isPause = true

		self.unit.skillPlayer:pauseAnimation()
	end
end

function SkillBase:isPause()
	return self._isPause
end

function SkillBase:resume()
	if self._isPlaying then
		self._isPause = nil

		self.unit.skillPlayer:resumeAnimation()
	end
end

function SkillBase:isPlaying()
	return self._isPlaying
end

function SkillBase:isCollisionEnded()
	return self._isCollisionEnd
end

function SkillBase:isCollisionCounted(index, unit)
	return self._countCollisions and self._countCollisions[index] and self._countCollisions[index][unit]
end

function SkillBase:getDamageCollisionCount(unit)
	if not self.damgeCollsionCnt then
		return 0
	end

	return self.damgeCollsionCnt[unit] or 0
end

function SkillBase:countCollision(index, unit)
	self._countCollisions = self._countCollisions or {}
	self._countCollisions[index] = self._countCollisions[index] or {}
	self._countCollisions[index][unit] = true
	self.damgeCollsionCnt = self.damgeCollsionCnt or {}
	self.damgeCollsionCnt[unit] = (self.damgeCollsionCnt[unit] or 0) + 1
end

function SkillBase:update(deltaTime)
	if not self._isPause and self._isPlaying then
		if self._isPauseOnTranTransforming then
			if not self.unit.attrs:isTransforming() then
				self._isPauseOnTranTransforming = nil
				self._playingTake = self:_getAnimationPath(self._attackTarget, self._attackCount)

				if self:_hasTake() then
					self:_preLoadSkillResources()
				else
					self:_onSkillStart()
				end
			end

			return
		end

		if self._isPauseOnUsingSpiritInvocation then
			if not self.unit.attrs:isUsingSpiritInvocation() then
				self._isPauseOnUsingSpiritInvocation = nil
				self._playingTake = self:_getAnimationPath(self._attackTarget, self._attackCount)

				if self:_hasTake() then
					self:_preLoadSkillResources()
				else
					self:_onSkillStart()
				end
			end

			return
		end

		if self.isUtlSkill and self._skillResourceReady and self._delayPlaySkillTime >= 0 then
			self._delayPlaySkillTime = self._delayPlaySkillTime - deltaTime

			if self._delayPlaySkillTime <= 0 then
				self._delayPlaySkillTime = -1

				self.unit.skillPlayer:setAnimationEventHandler(self._animEventHandler, self._animEventHandlerObj)
				self.unit:playAnimation(self)
			end
		end
	end
end

function SkillBase:setNotSkillEffectTargets(notSkillEffectTargets)
	self._notSkillEffectTargets = notSkillEffectTargets
end

function SkillBase:setSkillTargets(skillTargets)
	self:_lockTargets(false)

	self._skillTargets = skillTargets

	self:_lockTargets(true)
	self:setAttackTarget(self:_getAttackTarget())
end

function SkillBase:_lockTargets(lock)
	if self._skillTargets then
		local cnt = #self._skillTargets

		if lock then
			for i = 1, cnt do
				if not goutil.isNil(self._skillTargets[i].unit.go) then
					self._skillTargets[i].unit:onSkillLocking(self)
					self._skillTargets[i].unit:onStartAttack(self)
				end
			end
		else
			for i = 1, cnt do
				self._skillTargets[i].unit:removeSkillLocking()
			end
		end
	end
end

function SkillBase:getSkillTargets()
	return self._skillTargets
end

function SkillBase:getNotSkillEffectTargets()
	return self._notSkillEffectTargets
end

function SkillBase:playUtlSkillEffect()
	if self.isUtlSkill then
		self.unit:onUseUtlSkill()
	end
end

function SkillBase:onStrickBack()
	if self.isStrickBack then
		self.unit:onStrickBack()
	end
end

function SkillBase:onConsumeVigours()
	if self.costVigours then
		self.unit:onVigour(self.costVigours)

		self.costVigours = nil
	end
end

function SkillBase:addListener(listener, listenerObj)
	self._evtListener = listener
	self._evtListenerObj = listenerObj
end

function SkillBase:removeListener()
	self._evtListener = nil
	self._evtListenerObj = nil
end

function SkillBase:setAnimEventHandler(handler, handlerObj)
	self._animEventHandler = handler
	self._animEventHandlerObj = handlerObj
end

function SkillBase:removeAnimEventHandler()
	self._animEventHandler = nil
	self._animEventHandlerObj = nil
end

function SkillBase:_onEventListener(evt)
	if self._evtListener then
		if self._evtListenerObj then
			self._evtListener(self._evtListenerObj, evt)
		else
			self._evtListener(evt)
		end
	end
end

function SkillBase:stopUtlSkillEffect()
	if self.isUtlSkill then
		self.unit:removeUseUtlSkill()
	end
end

function SkillBase:setAttackTarget(target)
	self._attackTarget = target
end

function SkillBase:getAttacktarget()
	return self._attackTarget
end

function SkillBase:_getAnimationPath(target, attackCount)
	if self.skillCo == nil then
		return GameUrl.EmptySkill
	end

	if UnityEngine.Time.timeScale >= 10 then
		return GameUrl.EmptySkill
	end

	local take, female = BattleConfig.instance:getSkillAnimTake(self.skillCo.id, self.unit.modelId)
	local curTake

	if not target then
		curTake = #take > 0 and take or female
	else
		local petCo = PetSkinConfig.instance:getPetSkinCfg(target.unit.raceId)

		curTake = petCo.genderId == 1 and (#female > 0 and female or take) or #take > 0 and take or female
	end

	attackCount = checknumber(attackCount)

	if attackCount < 1 or attackCount > #curTake then
		attackCount = 1
	end

	return curTake[attackCount]
end

function SkillBase:getAnimationPath()
	return self._playingTake
end

function SkillBase:getHitAnimationPath()
	return
end

function SkillBase:onCollision(index, cData)
	local battleScene = SceneMgr.instance:getCurScene()

	self.unit.battleFlow:onCollision(self, index, cData)

	if index == cData.count then
		self._isCollisionEnd = true

		self:setSkillTargets()
		self:setNotSkillEffectTargets()
		self:stopUtlSkillEffect()
	end
end

function SkillBase:onAnimationStart(animPlayer)
	if self._isPlaying then
		self:_onEventListener("animationStart")

		self._skillAnimStarted = true

		self.unit:adjustSortingOrderOnStartSkill()

		self._skillTimeCount = animPlayer:GetLength()
	end
end

function SkillBase:onSkillWithDraw()
	if self._isPlaying then
		self._isWithDraw = true

		self:setSkillTargets(nil)
		self:setNotSkillEffectTargets()
		self:stopUtlSkillEffect()

		if self._evtDrawListener then
			if self._evtDrawListenerObj then
				self._evtDrawListener(self._evtDrawListenerObj)
			else
				self._evtDrawListener()
			end
		end
	end
end

function SkillBase:isSkillWithDraw()
	if self._isPlaying then
		if not self._skillAnimStarted then
			return
		end

		if self._isWithDraw then
			return true
		end

		return nil
	end

	return true
end

function SkillBase:onAnimationFinish()
	if self._isPlaying then
		self:_endSkill()
	end
end

function SkillBase:_checkIsSpiritInvocationPet(visible)
	local unit = self.unit

	if unit then
		local charactor = BattleModel.instance:getCharactorById(unit.teamId, unit.id)

		if charactor and checkbool(charactor.isSpiritInvocationSummonPet) == true then
			unit:setVisible(visible)
			unit:hideUIAndShadow(true)
			unit:setAlpha(0)
			unit:hideBuffEffects(true)
		end
	end
end

function SkillBase:_checkIsOracleUseSkill(visible)
	local unit = self.unit

	if unit then
		local charactor = BattleModel.instance:getCharactorById(unit.teamId, unit.id)

		if charactor and checknumber(charactor.oracleMasterId) > 0 then
			unit:setVisible(visible)
			unit:hideUIAndShadow(true)

			local battleScene = SceneMgr.instance:getScene(SceneType.Battle)
			local masterUnit = battleScene.unitFactory:getUnit(unit.teamId, charactor.oracleMasterId)

			if masterUnit then
				masterUnit:setVisible(not visible)

				local posX, posY, posZ = masterUnit.transform:getPos()

				unit.transform:setPos(posX, posY, posZ)

				local posX, posY, posZ = masterUnit.attrs:getBirthPoint()

				unit.attrs:setBirthPoint(posX, posY, posZ)
			end
		end
	end
end

function SkillBase:_endSkill()
	if self._isPlaying then
		self:_checkIsSpiritInvocationPet(false)
		self:_checkIsOracleUseSkill(false)
		self:_onEventListener("stop")
		self:removeListener()
		self.unit:resumeSortingOrderOnStopSkill()
		self:stopUtlSkillEffect()
		self.unit.attrs:setUsingSkill(false)
		self:setSkillTargets(nil)
		self:setNotSkillEffectTargets()

		self.damgeCollsionCnt = nil
		self.damageCollisionTotalCnt = 0
		self._countCollisions = nil
		self._delayPlaySkillTime = 0
		self._isPlaying = nil
		self._playingTake = nil
		self._isAnimStarted = nil
		self._isPauseOnTranTransforming = nil
		self._isPauseOnUsingSpiritInvocation = nil
		self._skillAnimStarted = nil
		self.prepareHurtData = nil
		self._isWithDraw = nil
		self._isCollisionEnd = nil
		self._isShowDamageHud = nil
		self._skillExecuteState = nil
		self.resumeVigours = nil
		self._skillResourceReady = nil
		self.costVigours = nil
		self.resumeRecords = nil
		self.unitAttrs = nil
		self.isStrickBack = nil
	end
end

function SkillBase:isShowDamageHud(target)
	if not self._isShowDamageHud then
		return
	end

	return self._isShowDamageHud[target]
end

function SkillBase:markShowDamageHud(target)
	self._isShowDamageHud = self._isShowDamageHud or {}
	self._isShowDamageHud[target] = true
end

function SkillBase:_onSkillStart()
	self.damgeCollsionCnt = nil
	self.damageCollisionTotalCnt = 0
	self._delayPlaySkillTime = 0.2

	self:onStrickBack()

	self._isPauseOnTranTransforming = nil
	self._isPauseOnUsingSpiritInvocation = nil

	self:_onPrepareHurtData()

	self.unitAttrs = self.unit.attrs:getAttributes()

	self:onConsumeVigours()
	self:_checkIsOracleUseSkill(true)
	self:_checkIsSpiritInvocationPet(true)
	self:_onEventListener("start")

	if self:_hasTake() then
		self:_doPlayTake()
	else
		if self._skillExecuteState ~= GameEnum.SkillExecuteState.CanExecute then
			self.unit:onCantExecuteSkill()
		end

		self.unit.attrs:setUsingSkill(true)
		self.unit.battleFlow:onSkillTargetsResult(self, self._skillTargets)
		self.unit.battleFlow:onSkillTargetsResult(self, self._notSkillEffectTargets)
		self.unit.battleFlow:handleAllPlayerResult()

		self._skillTimeCount = 0

		self:_onSkillEnd()
	end
end

function SkillBase:_doPlayTake()
	if self.unit.attrs:isTransforming() then
		self._isPauseOnTranTransforming = true

		return
	end

	if self.unit.attrs:isUsingSpiritInvocation() then
		self._isPauseOnUsingSpiritInvocation = true

		return
	end

	self.unit.attrs:setUsingSkill(true)
	self.unit:onStartAttack()

	if self.isUtlSkill then
		self:playUtlSkillEffect()
	else
		self.unit.skillPlayer:setAnimationEventHandler(self._animEventHandler, self._animEventHandlerObj)
		self.unit:playAnimation(self)
	end
end

function SkillBase:_hasTake()
	if self._playingTake and #self._playingTake > 0 and self._skillExecuteState == GameEnum.SkillExecuteState.CanExecute then
		if self.isPsychicSkill then
			return true
		end

		if self.isAwakenSkill then
			return true
		end

		if self.isCarriedSkillId then
			return true
		end

		if self.isOracleSkillId then
			return true
		end

		if self.isSourceSkillId then
			return true
		end

		if self.isGenesisSkillId then
			return true
		end

		return self._supportEmptyTargets or self._skillTargets and #self._skillTargets > 0
	end
end

function SkillBase:_preLoadSkillResources()
	local scene = SceneMgr.instance:getCurScene()

	if AMPlayer.IsTakeResLoaded(self._playingTake) then
		scene.resPreLoad:preloadSkill(self.skillCo.id, self.unit.modelId, self._onSkillReourcesLoaded, self)
	else
		local take, female = BattleConfig.instance:getSkillAnimTake(self.skillCo.id, self.unit.modelId)
		local resList = {}

		if take and #take > 0 then
			for _, v in ipairs(take) do
				table.insert(resList, v)
			end
		end

		if female and #female > 0 then
			for _, v in ipairs(female) do
				table.insert(resList, v)
			end
		end

		scene.resQueue:pushResources(resList, function(loader)
			scene.stage:onSkillResourcesLoaded(loader)
			scene.resPreLoad:preloadSkill(self.skillCo.id, self.unit.modelId, self._onSkillReourcesLoaded, self)
		end)
	end
end

function SkillBase:_onSkillReourcesLoaded()
	if self._playingTake then
		local scene = SceneMgr.instance:getCurScene()

		if scene and scene.stage.initSkillTake then
			scene.stage:initSkillTake(self._playingTake)
		end
	end

	if self._isPlaying then
		self._skillResourceReady = true

		self:_onSkillStart()
	end
end

function SkillBase:_onSkillEnd()
	if self._isPlaying then
		local skillExecuteState = self._skillExecuteState
		local playingTake = self._playingTake

		self:_endSkill()

		if playingTake and #playingTake > 0 and skillExecuteState == GameEnum.SkillExecuteState.CanExecute then
			self.unit:stopAnimation()
		end
	end
end

function SkillBase:_onPrepareHurtData()
	if self.prepareHurtData then
		local cnt = #self.prepareHurtData

		for i = 1, cnt do
			self.prepareHurtData[i]:handleData()
		end

		self.prepareHurtData = nil
	end
end

function SkillBase:_getAttackTarget()
	if self._skillTargets then
		if #self._skillTargets == 1 then
			return self._skillTargets[1]
		end

		local targets = self:skillType() == GameEnum.SkillFuncType.Treat and self.unit.battleFlow:getFriendTargets(self.unit, self._skillTargets) or self:skillType() == GameEnum.SkillFuncType.Hurt and self.unit.battleFlow:getEnemyTargets(self.unit, self._skillTargets) or self._skillTargets

		if targets then
			local cnt = #targets

			if cnt == 1 then
				return targets[1]
			end

			local dist = 99999999
			local tgt

			for i = 1, cnt do
				local px, py, pz = targets[i].unit.transform:getPos()
				local d = self.unit.transform:dist(px, py, pz)

				if not tgt or d < dist then
					tgt = targets[i]
					dist = d
				end
			end

			if tgt then
				return tgt
			end
		end

		return self._skillTargets[1]
	end
end

return SkillBase
