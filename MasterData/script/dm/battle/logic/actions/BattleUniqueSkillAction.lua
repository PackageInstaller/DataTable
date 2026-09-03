-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/actions/BattleUniqueSkillAction.lua

function isReadyForUniqueSkill(actor, angerComp, flagComp)
	if actor ~= nil then
		if angerComp == nil then
			angerComp = actor:getComponent("Anger")
		end

		if flagComp == nil then
			flagComp = actor:getComponent("Flag")
		end
	end

	if angerComp and not angerComp:isFull() then
		return false
	end

	if flagComp and flagComp:hasAnyStatus({
		kBEDazed,
		kBEMuted,
		kBENumbed,
		kBEFrozen
	}) then
		return false
	end

	return true
end

BattleUniqueSkillAction = class("BattleUniqueSkillAction", BattleAction, _M)

function BattleUniqueSkillAction:initialize(skillType)
	super.initialize(self)

	self._targetSkillType = skillType or kBattleUniqueSkill
end

function BattleUniqueSkillAction:setActor(actor)
	self._actor = actor

	if actor then
		self._actorSkillComp = actor:getComponent("Skill")

		self._actorSkillComp:setUniqueSkillRoutine(self)

		self._actorAngerComp = actor:getComponent("Anger")
	else
		self._actorSkillComp = nil
		self._actorAngerComp = nil
	end
end

function BattleUniqueSkillAction:checkIsActive()
	if self._actorSkillComp:getUniqueSkillRoutine() ~= self then
		return false
	end

	if not self._actor:isInStages(ULS_Normal, ULS_Newborn) then
		return false
	end

	return isReadyForUniqueSkill(self._actor, self._actorAngerComp, self._actor:getComponent("Flag"))
end

function BattleUniqueSkillAction:cancel(battleContext)
	local actor = self:getActor()

	if self._actorSkillComp:getUniqueSkillRoutine() == self then
		self._actorSkillComp:setUniqueSkillRoutine(nil)

		if actor:getUnitType() == BattleUnitType.kMaster then
			local angerComp = self._actorAngerComp
			local anger = angerComp:getAnger()
			local battleRecorder = battleContext:getObject("BattleRecorder")

			if battleRecorder then
				local actorId = actor:getId()

				battleRecorder:recordEvent(actorId, "CancelUnique", {
					anger = anger
				})
			end
		end
	end
end

function BattleUniqueSkillAction:doStart(battleContext)
	self._actorSkillComp:setUniqueSkillRoutine(nil)

	local actor = self:getActor()

	if actor:isInStages(ULS_Newborn) then
		self._formationSystem:changeUnitSettled(actor)
	end

	local cardInfo = actor:getCardInfo()

	self._duration = cardInfo and cardInfo.enterPauseTime

	local battleContext = self:getBattleContext()
	local skillSystem = battleContext:getObject("SkillSystem")

	skillSystem:activateSpecificTrigger(actor, "BEFORE_FINDTARGET")
	skillSystem:activateGlobalTrigger("UNIT_BEFORE_FINDTARGET", {
		unit = actor
	})
end

function BattleUniqueSkillAction:doSkill()
	local skill = self._actorSkillComp:getSkill(self._targetSkillType)

	if not skill then
		self:finish()

		return
	end

	local actor = self:getActor()

	if not actor:isInStages(ULS_Normal) then
		self:finish()

		return
	end

	if not isReadyForUniqueSkill(self._actor, self._actorAngerComp, self._actor:getComponent("Flag")) then
		self:finish()

		return
	end

	local battleContext = self:getBattleContext()
	local skillSystem = battleContext:getObject("SkillSystem")
	local formationSystem = battleContext:getObject("FormationSystem")
	local primTrgt = formationSystem:findPrimaryTarget(actor)

	if not primTrgt then
		self:finish()

		return
	end

	local angerComp = self._actorAngerComp

	angerComp:setAnger(0)

	local skillExecutor = battleContext:getObject("SkillSystem"):getSkillExecutor()
	local args = {
		ACTOR = actor,
		TARGET = primTrgt
	}

	skillSystem:activateSpecificTrigger(actor, "BEFORE_UNIQUE", {
		primTrgt = primTrgt
	})
	skillSystem:activateGlobalTrigger("UNIT_BEFORE_UNIQUE", {
		unit = actor,
		primTrgt = primTrgt
	})

	local skillAction = skill and skill:getEntryAction()

	skillExecutor:runAction(skillAction, args, function(executor)
		skillSystem:activateSpecificTrigger(actor, "AFTER_UNIQUE", {
			primTrgt = primTrgt
		})
		skillSystem:activateGlobalTrigger("UNIT_AFTER_UNIQUE", {
			unit = actor,
			primTrgt = primTrgt
		})

		local battleStatist = battleContext:getObject("BattleStatist")

		if battleStatist ~= nil then
			battleStatist:sendStatisticEvent("UnitDoSkill", {
				type = "unique",
				unit = actor
			})
		end

		self:finish()
	end)

	local battleRecorder = battleContext:getObject("BattleRecorder")

	if battleRecorder then
		local actorId = actor:getId()

		battleRecorder:recordEvent(actorId, "Sync", {
			anger = 0
		})
	end

	skillExecutor:update(0)
end

function BattleUniqueSkillAction:doUpdate(dt)
	if not self._skilled then
		local actor = self:getActor()

		if not actor:getFSM():isInState("Preparing") then
			self:doSkill()

			self._skilled = true
		elseif self._actionScheduler:willBeFinished() then
			self:finish()
		end
	end
end
