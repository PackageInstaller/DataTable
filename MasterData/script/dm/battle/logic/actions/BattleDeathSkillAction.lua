-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/actions/BattleDeathSkillAction.lua

BattleDeathSkillAction = class("BattleDeathSkillAction", BattleAction, _M)

function BattleDeathSkillAction:initialize()
	super.initialize(self)
end

function BattleDeathSkillAction:setActor(actor)
	self._actor = actor
	self._actorSkillComp = actor and actor:getComponent("Skill") or nil
end

function BattleDeathSkillAction:checkIsActive()
	if not self._actor:isInStages(ULS_Dying) then
		return false
	end

	return true
end

function BattleDeathSkillAction:doStart(battleContext)
	local skill = self._actorSkillComp:getSkill(kBattleDeathSkill)

	if not skill then
		self:finish()

		return
	end

	local actor = self:getActor()

	if not actor:isInStages(ULS_Dying) then
		self:finish()

		return
	end

	local formationSystem = battleContext:getObject("FormationSystem")
	local primTrgt = formationSystem:findFoe(actor) or formationSystem:findPrimaryTarget(actor)
	local isnotAskForTrg = skill:notAskForTarget()

	if not primTrgt and not isnotAskForTrg then
		if actor:isInStages(ULS_Dying) then
			formationSystem:buryUnit(actor)
		end

		self:finish()

		return
	end

	local skillExecutor = battleContext:getObject("SkillSystem"):getSkillExecutor()
	local args = {
		ACTOR = actor,
		TARGET = primTrgt
	}
	local skillAction = skill and skill:getEntryAction()

	skillExecutor:runAction(skillAction, args, function(executor)
		if actor:isInStages(ULS_Dying) then
			formationSystem:buryUnit(actor)
		end

		self:finish()
	end)
	skillExecutor:update(0)
end

function BattleDeathSkillAction:doUpdate(dt)
	return
end
