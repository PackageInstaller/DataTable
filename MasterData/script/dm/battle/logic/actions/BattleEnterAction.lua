-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/actions/BattleEnterAction.lua

BattleEnterAction = class("BattleEnterAction", BattleFSMAction, _M)

BattleEnterAction:has("_userCmd", {
	is = "r"
})

function BattleEnterAction:initialize(userCmd)
	super.initialize(self)

	self._userCmd = userCmd
end

function BattleEnterAction:willStartWithContext(battleContext)
	return BlockOnNewBornState:new()
end

BlockOnNewBornState = class("BlockOnNewBornState", BattleActionState, _M)

function BlockOnNewBornState:enter(battleAction)
	local actor = battleAction:getActor()
	local fsmComp = actor:getComponent("FSM")

	if fsmComp == nil or not fsmComp:isInState("NewBorn") then
		battleAction:changeState(DoEnterSkillsState:new())

		local formationSystem = battleAction:getFormationSystem()

		formationSystem:clearOldResident(actor)
	else
		self._actorFsmComp = fsmComp
	end
end

function BlockOnNewBornState:update(battleAction, dt)
	local fsmComp = self._actorFsmComp

	if fsmComp == nil or not fsmComp:isInState("NewBorn") then
		self._actorFsmComp = nil

		battleAction:changeState(DoEnterSkillsState:new())
	elseif battleAction:getActionScheduler():willBeFinished() then
		battleAction:finish()
	end
end

DoEnterSkillsState = class("DoEnterSkillsState", BattleActionState, _M)

function DoEnterSkillsState:enter(battleAction)
	local battleContext = battleAction:getBattleContext()
	local actor = battleAction:getActor()
	local skillComp = actor:getComponent("Skill")
	local buffSystem = battleContext:getObject("BuffSystem")

	buffSystem:triggerEnterBuffs(actor)
	battleAction:changeState(AfterEnteringState:new())
end

function DoEnterSkillsState:update(battleAction, dt)
	super.update(self, battleAction, dt)
end

AfterEnteringState = class("AfterEnteringState", BattleActionState, _M)

function AfterEnteringState:enter(battleAction)
	local actor = battleAction:getActor()

	if not battleAction:getUserCmd() then
		local check = true

		if battleAction:getBattleContext():getObject("BattleLogic"):getBattleMode() ~= 2 then
			local var_7_0 = false
		else
			var_7_0 = true
		end

		local formationSystem = battleAction:getFormationSystem()
		local cardInfo = actor:getCardInfo()

		self._duration = cardInfo and cardInfo.enterPauseTime

		local function doSetDown()
			formationSystem:changeUnitSettled(actor)
		end

		local function doSkill()
			if isReadyForUniqueSkill(actor) and check then
				local battleContext = battleAction:getBattleContext()
				local actionScheduler = battleContext:getObject("ActionScheduler")

				if actionScheduler:exertUniqueSkill(actor, kBattleUniqueSkill) then
					-- block empty
				else
					doSetDown()
				end

				battleAction:finish()
			else
				doSetDown()

				if self._duration and self._duration > 0 then
					self:startTimer(self._duration, function()
						battleAction:finish()
					end)

					return
				end

				battleAction:finish()
			end
		end

		doSkill()
	end
end

function AfterEnteringState:update(battleAction, dt)
	if self._duration and self._duration > 0 then
		super.update(self, battleAction, dt)
	else
		battleAction:finish()
	end
end
