-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/actions/BattleRegularUniqueAction.lua

BattleRegularUniqueAction = class("BattleRegularUniqueAction", BattleFSMAction, _M)

function BattleRegularUniqueAction:initialize()
	super.initialize(self)
end

function BattleRegularUniqueAction:setActor(actor)
	self._actor = actor

	if actor then
		local skillComp = actor:getComponent("Skill")

		skillComp:setUniqueSkillRoutine(self)
	end
end

function BattleRegularUniqueAction:willStartWithContext(battleContext)
	return PreUniqueActionState:new()
end

PreUniqueActionState = class("PreUniqueActionState", BattleActionState, _M)

function PreUniqueActionState:enter(battleAction)
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
	elseif isReadyForUniqueSkill(actor) then
		battleAction:changeState(DoUniqueActionState:new())
	else
		battleAction:changeState(PostUniqueActionState:new())
	end
end

function PreUniqueActionState:update(battleAction, dt)
	return
end

PostUniqueActionState = class("PostUniqueActionState", BattleActionState, _M)

function PostUniqueActionState:enter(battleAction)
	local battleContext = battleAction:getBattleContext()
	local actor = battleAction:getActor()
	local buffSystem = battleContext:getObject("BuffSystem")

	buffSystem:updateAfterActing(actor)
	battleAction:processDying()
	battleAction:finish()

	local skillSystem = battleContext:getObject("SkillSystem")

	skillSystem:activateSpecificTrigger(actor, "UNIQUE_ACTION")

	local battleStatist = battleContext:getObject("BattleStatist")

	if battleStatist ~= nil then
		battleStatist:sendStatisticEvent("UnitDoSkill", {
			type = "unique",
			unit = actor
		})
	end
end

function PostUniqueActionState:update(battleAction, dt)
	return
end

DoUniqueActionState = class("DoUniqueActionState", BattleActionState, _M)

function DoUniqueActionState:enter(battleAction)
	local battleContext = battleAction:getBattleContext()
	local actor = battleAction:getActor()

	if not actor:isInStages(ULS_Normal) then
		battleAction:changeState(PostUniqueActionState:new())

		return
	end

	local skillComp = actor:getComponent("Skill")

	skillComp:setUniqueSkillRoutine(nil)

	local skill = skillComp:getSkill(kBattleUniqueSkill)

	if not skill then
		battleAction:changeState(PostUniqueActionState:new())

		return
	end

	local formationSystem = battleContext:getObject("FormationSystem")
	local primTrgt = formationSystem:findPrimaryTarget(actor)

	if not primTrgt then
		battleAction:changeState(PostUniqueActionState:new())

		return
	end

	local angerComp = actor:getComponent("Anger")

	angerComp:setAnger(0)

	local skillExecutor = battleContext:getObject("SkillSystem"):getSkillExecutor()
	local args = {
		ACTOR = actor,
		TARGET = primTrgt
	}
	local skillAction = skill and skill:getEntryAction()

	skillExecutor:runAction(skillAction, args, function(executor)
		battleAction:changeState(PostUniqueActionState:new())
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

function DoUniqueActionState:update(battleAction, dt)
	return
end
