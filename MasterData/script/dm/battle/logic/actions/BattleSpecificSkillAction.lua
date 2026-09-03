-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/actions/BattleSpecificSkillAction.lua

BattleSpecificSkillAction = class("BattleSpecificSkillAction", BattleAction, _M)

function BattleSpecificSkillAction:initialize(skill)
	super.initialize(self)

	self._skill = skill
end

function BattleSpecificSkillAction:cancel(battleContext)
	local actor = self:getActor()

	if actor:getUnitType() == BattleUnitType.kMaster then
		local battleRecorder = battleContext:getObject("BattleRecorder")

		if battleRecorder then
			local actorId = actor:getId()

			battleRecorder:recordEvent(actorId, "CancelSpecificSkill", {})
		end
	end
end

function BattleSpecificSkillAction:doSkill()
	local skill = self._skill

	if not skill then
		self:finish()

		return
	end

	local actor = self:getActor()

	if not actor:isInStages(ULS_Normal) then
		self:finish()

		return
	end

	local battleContext = self:getBattleContext()
	local formationSystem = battleContext:getObject("FormationSystem")
	local primTrgt = formationSystem:findPrimaryTarget(actor)

	if not primTrgt then
		self:finish()

		return
	end

	local skillExecutor = battleContext:getObject("SkillSystem"):getSkillExecutor()
	local args = {
		ACTOR = actor,
		TARGET = primTrgt
	}

	for k, v in pairs(self._skill:getArgs() or {}) do
		args[k] = v
	end

	local skillAction = skill and skill:getEntryAction()

	skillExecutor:runAction(skillAction, args, function(executor)
		local skillSystem = battleContext:getObject("SkillSystem")

		skillSystem:activateSpecificTrigger(actor, "AFTER_SPECIFIC_SKILL")
		skillSystem:activateGlobalTrigger("UNIT_AFTER_SPECIFIC_SKILL", {
			unit = actor
		})
		self:finish()
	end)
	skillExecutor:update(0)
end

function BattleSpecificSkillAction:doUpdate(dt)
	if not self._skilled then
		local actor = self:getActor()

		if not actor:getFSM():isInState("Preparing") then
			self:doSkill()

			self._skilled = true
		end
	end
end
