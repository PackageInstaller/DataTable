-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleActionScheduler.lua

require("dm.battle.logic.actions.all")

BattleActionScheduler = class("BattleActionScheduler", objectlua.Object, _M)

function BattleActionScheduler:initialize()
	super.initialize(self)
end

function BattleActionScheduler:reset(battleContext)
	self._nextActorIndex = nil
	self._actors = {}
	self._finished = false
	self._emergentActions = {}

	if self._userActions then
		for _, action in ipairs(self._userActions) do
			action:cancel(battleContext)
		end
	end

	self._userActions = {}
	self._extraActions = {}
end

function BattleActionScheduler:setFinished()
	self._finished = true
end

function BattleActionScheduler:willBeFinished()
	return self._finished
end

function BattleActionScheduler:isFinished()
	return self._finished and self._currentAction == nil and self._curEmergentAction == nil
end

function BattleActionScheduler:enterNewRoundWithActors(actors)
	self._actors = actors
	self._nextActorIndex = 1

	for _, actor in ipairs(actors) do
		if actor:isInStages(ULS_Reviving) then
			actor:setLifeStage(ULS_Normal)
		end
	end
end

function BattleActionScheduler:hasMoreActor()
	return self._nextActorIndex <= #self._actors
end

function BattleActionScheduler:nextActor()
	local actors = self._actors
	local idx = self._nextActorIndex

	if idx and idx <= #actors then
		for i = idx, #actors do
			local actor = actors[i]

			self._nextActorIndex = i + 1

			if actor:isInStages(ULS_Normal) then
				return actor, i
			end
		end
	else
		return nil
	end
end

function BattleActionScheduler:appendActor(unit)
	local actors = self._actors
	local idx = #actors + 1

	actors[idx] = unit

	return unit, idx
end

function BattleActionScheduler:postponeActor(unit)
	local actors = self._actors
	local n = #actors

	for i = self._nextActorIndex, n - 1 do
		if actors[i] == unit then
			table.remove(actors, i)

			actors[n] = unit

			return unit, n, i
		end
	end

	return nil
end

function BattleActionScheduler:nextActionInSequence(seq, battleContext)
	repeat
		local action = table.remove(seq, 1)

		if action == nil then
			return nil
		end

		if action:checkIsActive() then
			return action
		else
			action:cancel(battleContext)
		end
	until false

	return nil
end

function BattleActionScheduler:removeActionFromSequence(seq, action)
	for i = 1, #seq do
		if seq[i] == action then
			return table.remove(seq, i)
		end
	end
end

function BattleActionScheduler:addEmergentAction(action)
	self._emergentActions[#self._emergentActions + 1] = action
end

function BattleActionScheduler:addEmergentActionAtFirst(action)
	table.insert(self._emergentActions, 1, action)
end

function BattleActionScheduler:addUserActionAtFirst(action)
	local actionIndex = #self._userActions + 1

	for k, v in pairs(self._userActions) do
		if v._targetSkillType and (v._targetSkillType == kBattleUniqueSkill or v._targetSkillType == kBattleMasterSkill1 or v._targetSkillType == kBattleMasterSkill2 or v._targetSkillType == kBattleMasterSkill3) then
			actionIndex = k

			break
		end
	end

	table.insert(self._userActions, actionIndex, action)
end

function BattleActionScheduler:removeEmergentAction(action)
	return self:removeActionFromSequence(self._emergentActions, action)
end

function BattleActionScheduler:nextEmergentAction(battleContext)
	return self:nextActionInSequence(self._emergentActions, battleContext)
end

function BattleActionScheduler:addUserAction(action)
	self._userActions[#self._userActions + 1] = action
end

function BattleActionScheduler:removeUserAction(action)
	return self:removeActionFromSequence(self._userActions, action)
end

function BattleActionScheduler:nextUserAction(battleContext)
	return self:nextActionInSequence(self._userActions, battleContext)
end

function BattleActionScheduler:exertUniqueSkill(actor, skillType, isEmergent)
	if self._finished then
		return false, "Finished"
	end

	local skillComp = actor:getComponent("Skill")

	if not skillComp then
		return false, "NoSkillComponent"
	end

	if skillComp:getSkill(skillType) == nil then
		return false, "NoSkill"
	end

	local skillRoutine = skillComp:getUniqueSkillRoutine()

	if skillRoutine ~= nil then
		return false, "AlreadyInProcess"
	end

	local healthComp = actor:getComponent("Health")

	if healthComp and healthComp:isDying() then
		return false, "ActorIsDying"
	end

	skillRoutine = BattleUniqueSkillAction:new(skillType):withActor(actor)

	if isEmergent then
		self:addUserActionAtFirst(skillRoutine)
	else
		self:addUserAction(skillRoutine)
	end

	return true
end

function BattleActionScheduler:exertSpecificSkill(actor, skill)
	if self._finished then
		return false, "Finished"
	end

	local specificAction = BattleSpecificSkillAction:new(skill):withActor(actor)

	self:addUserAction(specificAction)

	return true
end

function BattleActionScheduler:exertExtraSkill(actor, skill)
	if self._finished then
		return false, "Finished"
	end

	local specificAction = BattleSpecificSkillAction:new(skill):withActor(actor)

	self:addExtraSkillAction(specificAction)

	return true
end

function BattleActionScheduler:addExtraSkillAction(action)
	self._extraActions[#self._extraActions + 1] = action
end

function BattleActionScheduler:updateExtraSkill(dt, battleContext)
	if self._finished then
		return false, "Finished"
	end

	self._runningExtraActions = self._runningExtraActions or {}

	for k, v in pairs(self._extraActions) do
		if not self._runningExtraActions[v] then
			self._runningExtraActions[v] = v

			self._runningExtraActions[v]:start(battleContext, function()
				self._runningExtraActions[v] = nil

				self:removeActionFromSequence(self._extraActions, v)
			end)
		else
			self._runningExtraActions[v]:update(dt)
		end
	end
end

function BattleActionScheduler:update(dt, battleContext)
	local running = false

	if self._curEmergentAction ~= nil then
		self._curEmergentAction:update(dt)

		running = true
	end

	if self._curEmergentAction == nil and not self._finished then
		local nextAction

		repeat
			local emergentAction = self:nextEmergentAction(battleContext)

			if emergentAction then
				local moreAction = self:nextEmergentAction(battleContext)

				if moreAction then
					do
						local parallel = BattleParallelAction:new(emergentAction)

						while moreAction ~= nil do
							parallel:addAction(moreAction)

							moreAction = self:nextEmergentAction(battleContext)
						end

						nextAction = parallel
					end

					break
				end

				nextAction = emergentAction

				break
			end

			local userAction = self:nextUserAction(battleContext)

			nextAction = userAction and userAction or nextAction
		until true

		if nextAction then
			self._curEmergentAction = nextAction

			nextAction:start(battleContext, function()
				self._curEmergentAction = nil
			end)

			running = true
		end
	end

	if self._currentAction ~= nil then
		self._currentAction:update(dt)

		running = true
	elseif self._currentAction == nil and self._curEmergentAction == nil and not self._finished then
		repeat
			local nextAction

			while nextAction == nil do
				local nextActor = self:nextActor()

				if nextActor then
					if nextActor:getUnitType() == BattleUnitType.kHero and isReadyForUniqueSkill(nextActor) then
						if not nextActor:getFSM():isInState("Preparing") then
							Bdump(self:exertUniqueSkill(nextActor, kBattleUniqueSkill))
						else
							break
						end
					else
						nextAction = BattleRegularAction:new():withActor(nextActor)
					end
				else
					break
				end
			end

			if nextAction then
				self._currentAction = nextAction

				nextAction:start(battleContext, function()
					self._currentAction = nil
				end)

				running = true
			end
		until true
	end

	self:updateExtraSkill(dt, battleContext)

	return running
end

function BattleActionScheduler:getBattleMode(battleContext)
	if self._battleMode == nil then
		self._battleMode = battleContext:getObject("BattleLogic"):getBattleMode()
	end

	return self._battleMode
end

function BattleActionScheduler:enterDiligentRoundWithActors(actors)
	self._specialActors = actors
	self._nextSpecialActorIndex = 1
	self._currentDiligentActions = {}
end

function BattleActionScheduler:isDiligentRoundFinished()
	return self._finished and (self._currentDiligentActions == nil or #self._currentDiligentActions == 0)
end

function BattleActionScheduler:nextDiligentActor()
	local actors = self._specialActors
	local idx = self._nextSpecialActorIndex

	if idx and idx <= #actors then
		for i = idx, #actors do
			local actor = actors[i]

			self._nextSpecialActorIndex = i + 1

			if actor:isInStages(ULS_Normal) then
				return actor, i
			end
		end
	else
		return nil
	end
end

function BattleActionScheduler:updateDiligentRound(dt, battleContext)
	local running = false

	if self._currentDiligentActions and #self._currentDiligentActions > 0 then
		for i, action in ipairs(self._currentDiligentActions) do
			action:update(dt)
		end

		running = true
	end

	if not self._finished then
		while true do
			if self._diligentWaiting then
				self._diligentWaittime = (self._diligentWaittime or 0) + dt

				if self._diligentWaittime > 300 then
					self._diligentWaiting = false
					self._diligentWaittime = 0
				else
					running = true

					break
				end
			end

			local nextAction

			while nextAction == nil do
				local nextActor = self:nextDiligentActor()

				if nextActor then
					nextAction = BattleRegularAction:new():withActor(nextActor)
				else
					break
				end
			end

			if nextAction then
				self._currentDiligentActions[#self._currentDiligentActions + 1] = nextAction

				nextAction:start(battleContext, function()
					for i, action in ipairs(self._currentDiligentActions) do
						if action == nextAction then
							table.remove(self._currentDiligentActions, i)

							return
						end
					end
				end)

				self._diligentWaiting = true
				running = true
			end

			break
		end
	end

	return running
end
