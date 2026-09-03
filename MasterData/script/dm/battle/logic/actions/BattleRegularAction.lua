-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/actions/BattleRegularAction.lua

function shouldForbidRegularAction(actor)
	local flagComp = actor:getComponent("Flag")

	return flagComp:hasAnyStatus({
		kBEFrozen,
		kBENumbed,
		kBEDazed
	})
end

BattleRegularAction = class("BattleRegularAction", BattleFSMAction, _M)

BattleRegularAction:has("_isProud", {
	is = "rwb"
})

function BattleRegularAction:initialize()
	super.initialize(self)
end

function BattleRegularAction:willStartWithContext(battleContext)
	self._executedSkillInfo = nil

	return PreActionState:new()
end

function BattleRegularAction:setExecutedSkillInfo(skillInfo)
	self._executedSkillInfo = skillInfo
end

function BattleRegularAction:getExecutedSkillInfo()
	return self._executedSkillInfo
end

PreActionState = class("PreActionState", BattleActionState, _M)

function PreActionState:enter(battleAction)
	local battleContext = battleAction:getBattleContext()
	local actor = battleAction:getActor()
	local buffSystem = battleContext:getObject("BuffSystem")

	buffSystem:updateBeforeActing(actor)

	if battleAction:checkResultWithProcessDying() then
		battleAction:finish()

		return
	end

	if not actor:isInStages(ULS_Normal) then
		battleAction:finish()
	else
		local forbidReason = shouldForbidRegularAction(actor)

		if forbidReason then
			battleAction:changeState(NonActionState:new(forbidReason))
		else
			battleAction:changeState(DoActionState:new())
		end
	end
end

function PreActionState:update(battleAction, dt)
	return
end

PostActionState = class("PostActionState", BattleActionState, _M)

function PostActionState:enter(battleAction)
	local battleContext = battleAction:getBattleContext()
	local actor = battleAction:getActor()
	local buffSystem = battleContext:getObject("BuffSystem")

	buffSystem:updateAfterActing(actor)
	battleAction:processDying()
	battleAction:finish()

	local skillSystem = battleContext:getObject("SkillSystem")

	skillSystem:activateSpecificTrigger(actor, "AFTER_ACTION")
	skillSystem:activateGlobalTrigger("UNIT_AFTER_ACTION", {
		unit = actor
	})

	if battleAction:isProud() then
		skillSystem:activateSpecificTrigger(actor, "AFTER_PROUD")
		skillSystem:activateGlobalTrigger("UNIT_AFTER_PROUD", {
			unit = actor
		})
	end

	local battleStatist = battleContext:getObject("BattleStatist")

	if battleStatist ~= nil then
		battleStatist:sendStatisticEvent("UnitDoSkill", {
			unit = actor,
			type = battleAction:isProud() and "proud" or "normal"
		})
	end
end

function PostActionState:update(battleAction, dt)
	return
end

NonActionState = class("NonActionState", BattleActionState, _M)

function NonActionState:initialize(forbidReason)
	super.initialize(self)

	self._forbidReason = forbidReason
end

function NonActionState:enter(battleAction)
	battleAction:changeState(PostActionState:new())
end

function NonActionState:update(battleAction, dt)
	return
end

DoActionState = class("DoActionState", BattleActionState, _M)

function DoActionState:enter(battleAction)
	local battleContext = battleAction:getBattleContext()
	local actor = battleAction:getActor()
	local cell = actor:getComponent("Position"):getCell()
	local formationSystem = battleContext:getObject("FormationSystem")
	local primTrgt = formationSystem:findPrimaryTarget(actor)

	if primTrgt ~= nil then
		local skillComp = actor:getComponent("Skill")
		local proudSkill = skillComp:getSkill(kBattleProudSkill)
		local skill = proudSkill

		if skill == nil then
			skill = skillComp:getSkill(kBattleNormalSkill)
		else
			local attrComp = actor:getComponent("Numeric")
			local skillrate = (attrComp:getAttrValue(kAttrSkillRate) or 0) + (attrComp:getAttrValue(kAttrExtraSkillRate) or 0)
			local flagComp = actor:getComponent("Flag")

			if flagComp and flagComp:hasAnyStatus({
				kBEMuted
			}) or skillrate < battleContext:random() then
				skill = skillComp:getSkill(kBattleNormalSkill)
			end
		end

		assert(skill ~= nil, "No skill for regular action")
		battleAction:setExecutedSkillInfo({
			skill = skill,
			actor = actor,
			target = primTrgt,
			actorCellId = cell:getId()
		})

		local skillExecutor = battleContext:getObject("SkillSystem"):getSkillExecutor()
		local skillScheduler = battleContext:getObject("SkillSystem"):getSkillScheduler()
		local args = {
			ACTOR = actor,
			TARGET = primTrgt
		}
		local skillAction = skill and skill:getEntryAction()

		assert(skillAction ~= nil, "skillAction is nil, SkillId: " .. skill:getId())

		if skill == proudSkill then
			battleAction:setIsProud(true)
		end

		local skillSystem = battleContext:getObject("SkillSystem")

		skillSystem:activateSpecificTrigger(actor, "BEFORE_ACTION", {
			primTrgt = primTrgt
		})
		skillSystem:activateGlobalTrigger("UNIT_BEFORE_ACTION", {
			unit = actor,
			primTrgt = primTrgt
		})
		skillScheduler:update(0)

		local forbidReason = shouldForbidRegularAction(actor)

		if forbidReason then
			battleAction:changeState(NonActionState:new(forbidReason))

			return
		end

		skillExecutor:runAction(skillAction, args, function(executor)
			local angerSystem = battleContext:getObject("AngerSystem")

			angerSystem:applyAngerRuleOnTarget(nil, actor, AngerRules.kAfterAction)

			if battleAction:checkResultWithProcessDying() then
				battleAction:changeState(PostActionState:new())

				return
			end

			battleAction:changeState(DoubleHitState:new())
		end)
		skillExecutor:update(0)
	else
		battleAction:changeState(PostActionState:new())
	end
end

function DoActionState:update(battleAction, dt)
	return
end

DoubleHitState = class("DoubleHitState", BattleActionState, _M)

function DoubleHitState:enter(battleAction)
	local execInfo = battleAction:getExecutedSkillInfo()

	if execInfo == nil or not execInfo.skill:canDoubleHit() then
		battleAction:changeState(BeatBackState:new())

		return
	end

	local actor = execInfo.actor
	local skillComp = actor:getComponent("Skill")
	local dblhitSkill = skillComp and skillComp:getSkill(kBattleDoubleHitSkill)

	if not dblhitSkill then
		battleAction:changeState(BeatBackState:new())

		return
	end

	local battleContext = battleAction:getBattleContext()
	local attrComp = actor:getComponent("Numeric")
	local dblhitProb = (attrComp:getAttrValue(kAttrDoubleRate) or 0) + (execInfo.skill:getDblhitRate() or 0)

	if dblhitProb <= battleContext:random() then
		battleAction:changeState(BeatBackState:new())

		return
	end

	local primTrgt = execInfo.target

	if not primTrgt:isInStages(ULS_Normal) then
		local formationSystem = battleContext:getObject("FormationSystem")

		primTrgt = formationSystem:findPrimaryTarget(actor)
	end

	if primTrgt == nil then
		battleAction:changeState(BeatBackState:new())

		return
	end

	local skillExecutor = battleContext:getObject("SkillSystem"):getSkillExecutor()
	local args = {
		ACTOR = actor,
		TARGET = primTrgt
	}
	local skillAction = dblhitSkill and dblhitSkill:getEntryAction()

	skillExecutor:runAction(skillAction, args, function(executor)
		if battleAction:checkResultWithProcessDying() then
			battleAction:changeState(PostActionState:new())

			return
		end

		battleAction:changeState(BeatBackState:new())
	end)
	skillExecutor:update(0)
end

function DoubleHitState:update(battleAction, dt)
	return
end

BeatBackState = class("BeatBackState", BattleActionState, _M)

function BeatBackState:enter(battleAction)
	local execInfo = battleAction:getExecutedSkillInfo()

	if execInfo == nil or not execInfo.skill:canBeHitBack() then
		battleAction:changeState(PostActionState:new())

		return
	end

	local actor = execInfo.actor
	local primTrgt = execInfo.target

	if not primTrgt:isInStages(ULS_Normal) or not actor:isInStages(ULS_Normal) then
		battleAction:changeState(PostActionState:new())

		do return end

		primTrgt = actor
	end

	actor = primTrgt

	local skillComp = primTrgt:getComponent("Skill")
	local counterSkill = skillComp and skillComp:getSkill(kBattleCounterSkill)

	if not counterSkill then
		battleAction:changeState(PostActionState:new())

		return
	end

	local battleContext = battleAction:getBattleContext()
	local attrComp = actor:getComponent("Numeric")
	local counterProb = attrComp:getAttrValue(kAttrCounterRate) or 0

	if counterProb <= battleContext:random() then
		battleAction:changeState(PostActionState:new())

		return
	end

	local skillExecutor = battleContext:getObject("SkillSystem"):getSkillExecutor()
	local args = {
		ACTOR = actor,
		TARGET = primTrgt
	}
	local skillAction = counterSkill and counterSkill:getEntryAction()

	skillExecutor:runAction(skillAction, args, function(executor)
		battleAction:changeState(PostActionState:new())
	end)
	skillExecutor:update(0)
end

function BeatBackState:update(battleAction, dt)
	return
end
