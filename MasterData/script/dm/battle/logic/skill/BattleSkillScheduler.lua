-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/skill/BattleSkillScheduler.lua

local INVALID_TASK = {}

ISkillStarter = interface("ISkillStarter")

function ISkillStarter:willStartSkillAction(actor, action, userData)
	return
end

function ISkillStarter:didStartSkillAction(actionEnv)
	return
end

function ISkillStarter:cancelSkillAction(actor, action, userData)
	return
end

function releaseAcquiredLocks(skillScheduler, env, ...)
	local arg = {
		n = select("#", ...),
		...
	}
	local acquiredLocks = env["$locks"]

	if skillScheduler == nil or acquiredLocks == nil then
		return
	end

	local freedLocks, freedCount = {}, 0

	for i = 1, arg.n do
		local lock = arg[i]
		local count = acquiredLocks[lock]

		if count ~= nil then
			freedCount = freedCount + 1
			freedLocks[freedCount] = lock

			if count == 1 then
				acquiredLocks[lock] = nil
			else
				acquiredLocks[lock] = count - 1
			end
		end
	end

	if freedCount > 0 then
		skillScheduler:releaseLocks(freedLocks)
	end
end

local function releaseRemainingLocks(skillScheduler, acquiredLocks)
	local remainingLocks, remainingCount = {}, 0

	for lock, count in pairs(acquiredLocks) do
		if count ~= nil and count > 0 then
			for x = 1, count do
				remainingCount = remainingCount + 1
				remainingLocks[remainingCount] = lock
			end
		end
	end

	if remainingCount > 0 then
		skillScheduler:releaseLocks(remainingLocks)
	end
end

BattleSkillScheduler = class("BattleSkillScheduler")

BattleSkillScheduler:has("_skillExecutor", {
	is = "r"
})

function BattleSkillScheduler:initialize(skillExecutor)
	super.initialize(self)

	self._skillExecutor = skillExecutor
	self._lockCounts = {}
	self._checkingStartIndex = nil
	self._taskQueue = {}
end

function BattleSkillScheduler:releaseLocks(locks)
	local lockCounts = self._lockCounts

	for i = 1, table.maxn(locks) do
		local obj = locks[i]

		if obj then
			if not lockCounts[obj] then
				if lockCounts[obj] == 1 then
					lockCounts[obj] = nil
					self._checkingStartIndex = 1
				else
					lockCounts[obj] = lockCounts[obj] - 1
				end
			end
		end
	end
end

function BattleSkillScheduler:_tryAcquireLocks(locks)
	local lockCounts = self._lockCounts
	local available = {}

	for i = 1, table.maxn(locks) do
		local obj = locks[i]

		if obj then
			if not lockCounts[obj] then
				local cnt = 0

				if cnt <= 0 then
					available[obj] = (available[obj] or 0) + 1
				else
					return nil
				end
			end
		end
	end

	for obj, count in pairs(available) do
		lockCounts[obj] = (lockCounts[obj] or 0) + count
	end

	return available
end

function BattleSkillScheduler:scheduleWithArgs(actor, action, args, callback)
	local task = {
		actor = actor,
		action = action,
		args = args,
		callback = callback
	}

	return self:_scheduleTask(task)
end

function BattleSkillScheduler:scheduleWithStarter(actor, action, starter, userData)
	local task = {
		actor = actor,
		action = action,
		starter = starter,
		userData = userData
	}

	return self:_scheduleTask(task)
end

function BattleSkillScheduler:_scheduleTask(task)
	local taskQueue = self._taskQueue
	local rearIndex = #taskQueue + 1

	taskQueue[rearIndex] = task

	if self._checkingStartIndex == nil then
		self._checkingStartIndex = rearIndex
	end
end

function BattleSkillScheduler:cancel(actor, action)
	local taskQueue = self._taskQueue
	local canceled

	for i = 1, #taskQueue do
		local task = taskQueue[i]

		if (action == nil or task.action == action) and (actor == nil or task.actor == actor) then
			taskQueue[i] = INVALID_TASK

			if canceled == nil then
				canceled = {
					task
				}
			else
				canceled[#canceled + 1] = task
			end
		end
	end

	if canceled then
		self._hasInvalidEntries = true

		for i = 1, #canceled do
			local task = canceled[i]
			local starter = task.starter

			if starter ~= nil then
				starter:cancelSkillAction(task.actor, task.action, task.userData)
			end
		end
	end
end

function BattleSkillScheduler:update(dt)
	if self._checkingStartIndex == nil then
		return
	end

	local success = 0
	local taskQueue = self._taskQueue

	while true do
		local current = self._checkingStartIndex
		local task = taskQueue[current]

		if task == nil then
			break
		end

		self._checkingStartIndex = current + 1

		if task ~= INVALID_TASK then
			local locks = task.action:getSynchroLocks()
			local acquiredLocks

			if locks ~= nil then
				acquiredLocks = self:_tryAcquireLocks(locks)
			end

			if locks == nil or acquiredLocks ~= nil then
				taskQueue[current] = INVALID_TASK
				self._hasInvalidEntries = true

				if self:_startActionTask(task, acquiredLocks) then
					success = success + 1
				elseif acquiredLocks ~= nil then
					local oldStartIndex = self._checkingStartIndex

					releaseRemainingLocks(self, acquiredLocks)

					self._checkingStartIndex = oldStartIndex
				end
			end
		end
	end

	self._checkingStartIndex = nil

	if self._hasInvalidEntries then
		remove_values(taskQueue, INVALID_TASK)
	end

	if success > 0 then
		self._skillExecutor:update(0)
	end
end

function BattleSkillScheduler:_startActionTask(task, acquiredLocks)
	local args, callback
	local starter = task.starter

	if starter ~= nil then
		args, callback = starter:willStartSkillAction(task.actor, task.action, task.userData)

		if args == nil then
			return false
		end
	else
		args = task.args or {
			ACTOR = task.actor
		}
		callback = task.callback
	end

	local finishCallback

	if acquiredLocks ~= nil then
		local userCallback = callback

		function finishCallback(executor, actionEnv, reason)
			releaseRemainingLocks(self, actionEnv["$locks"])

			actionEnv["$locks"] = nil

			return userCallback and userCallback(self, actionEnv, reason)
		end
	else
		finishCallback = callback
	end

	args["$locks"] = acquiredLocks

	local actionEnv = self._skillExecutor:runAction(task.action, args, finishCallback)

	if starter ~= nil then
		starter:didStartSkillAction(actionEnv, task.userData)
	end

	return true
end
