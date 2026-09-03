-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/skill/BattleSkillExecutor.lua

local error = _G.error

if not __G__TRACKBACK__ then
	local __traceback = debug.traceback

	local function traceback(msg)
		if msg == nil then
			return
		end

		return __traceback(msg, 2)
	end

	ISkillExecutorDelegate = interface("ISkillExecutorDelegate")

	function ISkillExecutorDelegate:skillActionWillStart(executor, actionEnv, actionArgs)
		return
	end

	function ISkillExecutorDelegate:skillActionDidFinish(executor, actionEnv, reason)
		return
	end

	TimeOrderedActionFragments = class("TimeOrderedActionFragments")

	function TimeOrderedActionFragments:initialize()
		super.initialize(self)

		self._pointer = 1
		self._actionFragments = {}
	end

	function TimeOrderedActionFragments:add(time, env, func)
		local actionFragments = self._actionFragments
		local guard = self._pointer
		local pos = #actionFragments

		while guard <= pos do
			local frag = actionFragments[pos]

			if time >= frag.time then
				break
			end

			actionFragments[pos + 1] = frag
			pos = pos - 1
		end

		actionFragments[pos + 1] = {
			time = time,
			env = env,
			func = func
		}

		return pos + 1
	end

	function TimeOrderedActionFragments:remove(env, func)
		local actionFragments = self._actionFragments
		local pointer = self._pointer
		local hole = 1
		local total = #actionFragments

		for i = 1, pointer - 1 do
			actionFragments[i] = nil
		end

		for i = pointer, total do
			local frag = actionFragments[i]

			if frag.env == env and (func == nil or frag.func == func) then
				actionFragments[i] = nil
			else
				if hole ~= i then
					actionFragments[hole] = frag
					actionFragments[i] = nil
				end

				hole = hole + 1
			end
		end

		self._pointer = 1
	end

	function TimeOrderedActionFragments:next(time)
		local actionFragments = self._actionFragments
		local frag = actionFragments[self._pointer]

		if frag == nil or time < frag.time then
			return nil
		end

		self._pointer = self._pointer + 1

		return frag
	end

	BattleSkillExecutor = class("BattleSkillExecutor")

	BattleSkillExecutor:has("_recorder", {
		is = "rw"
	})
	BattleSkillExecutor:has("_delegate", {
		is = "rw"
	})

	function BattleSkillExecutor:initialize(globalEnvironment)
		super.initialize(self)

		self._globalEnvironment = globalEnvironment
		self._environmentsToActions = {}
		self._exportedExecutor = self:_setupSkillScriptSupports()
		self._time = 0
		self._order = 1
		self._timeOrderedFragments = TimeOrderedActionFragments:new()
	end

	function BattleSkillExecutor:getTime()
		return self._time
	end

	function BattleSkillExecutor:getGlobalEnvironment()
		return self._globalEnvironment
	end

	function BattleSkillExecutor:createActionContext(action, actionArgs)
		local order = self._order

		self._order = order + 1

		local env = {}

		for name, value in pairs(actionArgs) do
			if name:sub(1, 1) == "$" then
				env[name] = value
			end
		end

		local global = self._globalEnvironment

		env["$"] = env
		env.global = global
		env.this = action:getSkillScope()
		env["$action"] = action
		env["$id"] = "#" .. global.genID(env)
		env["$executor"] = self._exportedExecutor
		env["$tm_start"] = self._time
		env["$order"] = order
		env["$recorder"] = self._recorder

		return env
	end

	function BattleSkillExecutor:isActionRunning(actionEnv)
		return self._environmentsToActions[actionEnv] ~= nil
	end

	function BattleSkillExecutor:runAction(action, actionArgs, finishCallback)
		assert(action ~= nil, "action is nil, Actor: " .. actionArgs.ACTOR:getId())

		local env = self:createActionContext(action, actionArgs)
		local actor, target = actionArgs.ACTOR, actionArgs.TARGET

		env["$actor"], env["$target"] = actor, target
		env["$callback"] = finishCallback
		self._environmentsToActions[env] = action

		if self._delegate then
			self._delegate:skillActionWillStart(self, env, actionArgs)
		end

		if self._recorder then
			self._recorder:beginSkillAction(env, actor, target)
		end

		local entryFunc = action:getEntryFunction()

		entryFunc(env, actionArgs)

		local duration = action:getDuration()

		if duration ~= nil and duration >= 0 then
			self:execAfterTime(duration, env, function(env)
				self:stopAction(env)
			end)
		else
			self:execAfterTime(10000, env, function(env)
				battlelogf("error: skill action \"%s\" is killed because it's running too long.", action:getFullName())
				self:stopAction(env, "killed")
			end)
		end

		return env
	end

	function BattleSkillExecutor:update(dt)
		local time = self._time + dt

		self._time = time

		local timeOrderedFragments = self._timeOrderedFragments
		local frag = timeOrderedFragments:next(time)

		while frag ~= nil do
			local env = frag.env
			local recorder = self._recorder

			if recorder and env then
				recorder:beginActionFragment(env)
			end

			xpcall(function()
				return frag.func(env, frag.time)
			end, traceback)

			if recorder and env then
				recorder:endActionFragment(env)
			end

			frag = timeOrderedFragments:next(time)
		end
	end

	function BattleSkillExecutor:_setupSkillScriptSupports()
		local executor = setmetatable({}, {
			__index = self
		})

		executor["@time"] = function(args, env, func)
			for i = 1, #args do
				self:execAfterTime(args[i], env, func)
			end
		end

		function executor.exit(env, ...)
			self:stopAction(env, nil, ...)
			error(nil)
		end

		return executor
	end

	function BattleSkillExecutor:execAfterTime(relTime, actionEnv, func)
		if relTime >= 0 then
			self._timeOrderedFragments:add(self._time + relTime, actionEnv, func)
		end
	end

	function BattleSkillExecutor:stopAction(actionEnv, reason, exitData)
		self._timeOrderedFragments:remove(actionEnv)

		self._environmentsToActions[actionEnv] = nil

		if self._recorder then
			self._recorder:endSkillAction(actionEnv, reason)
		end

		if self._delegate then
			self._delegate:skillActionDidFinish(self, actionEnv, reason)
		end

		local finishCallback = actionEnv["$callback"]

		if finishCallback then
			finishCallback(self, actionEnv, reason)
		end
	end

	function BattleSkillExecutor:stopAllActions(reason, exitData, filter)
		local environmentsToActions = self._environmentsToActions
		local all, n = {}, 0

		for env, _ in pairs(environmentsToActions) do
			n = n + 1
			all[n] = env
		end

		if n == 0 then
			return
		end

		if n > 1 then
			table.sort(all, function(a, b)
				return a["$order"] < b["$order"]
			end)
		end

		if filter ~= nil then
			local filtered, j = {}, 1

			for i = 1, n do
				local env = all[i]

				if filter(env) then
					j = j + 1
					filtered[j] = env
				end
			end

			all = filtered
		end

		for i = 1, #all do
			self:stopAction(all[i], reason, exitData)
		end
	end

	local function processReturns(status, ...)
		if not status then
			return nil
		end

		return ...
	end

	function BattleSkillExecutor:callFunction(env, func, ...)
		local arg = {
			...,
			n = select("#", ...)
		}

		local function f()
			return func(env, unpack(arg, 1, arg.n))
		end

		return processReturns(xpcall(f, traceback))
	end
end
