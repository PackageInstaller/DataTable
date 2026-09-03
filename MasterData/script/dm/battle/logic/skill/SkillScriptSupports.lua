-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/skill/SkillScriptSupports.lua

_G.SkillScriptBuiltins = {}

local builtins = _G.SkillScriptBuiltins

local function getOrCreateRegistry(thisScope, name)
	local registry = thisScope[name]

	if registry == nil then
		registry = {}
		thisScope[name] = registry
	end

	return registry
end

builtins.null = {}

function builtins.__skill(thisScope, def, externs)
	thisScope["$skill"] = externs.skill
	thisScope["$type"] = externs.type
	thisScope["$owner"] = externs.owner
	thisScope["$level"] = externs.level
	thisScope.owner = thisScope["$owner"]
	thisScope.type = thisScope["$type"]

	return thisScope
end

function builtins.__skill_function__(thisScope, def)
	local func = def.entry
	local functions = getOrCreateRegistry(thisScope, "$functions")

	functions[#functions + 1] = func
	functions[func] = def

	return func
end

function builtins.__skill_action__(thisScope, def)
	local action = BattleSkillAction:new(def)
	local actions = getOrCreateRegistry(thisScope, "$actions")

	actions[#actions + 1] = action
	actions[action] = def

	return action
end

local ipairs = _G.ipairs

function builtins.__iter__(iterable, ...)
	if type(iterable) == "table" then
		return ipairs(iterable)
	end

	return iterable, ...
end

builtins["[duration]"] = function(thisScope, args, action)
	assert(type(action) == "table" and action["$type"] == "action")

	if not args[1] then
		action:setDuration(args[1])

		return action
	end
end
builtins["[synchronized]"] = function(thisScope, args, action)
	for i = 1, table.maxn(args) do
		action:addSynchroLock(args[i])
	end

	return action
end
builtins["[cut_in]"] = function(thisScope, args, action)
	assert(type(action) == "table" and action["$type"] == "action")

	if not args[1] then
		action:setCutInAnimation(args[1])

		return action
	end
end
builtins["[proud]"] = function(thisScope, args, action)
	assert(type(action) == "table" and action["$type"] == "action")

	if not args[1] then
		action:setProudAnimation(args[1])

		return action
	end
end
builtins["[load]"] = function(thisScope, args, action)
	assert(type(action) == "table" and action["$type"] == "action")

	local anim = args

	action:setEffectRes(anim)

	return action
end
builtins["[entry_point]"] = function(thisScope, args, action)
	assert(type(action) == "table" and action["$type"] == "action")

	if not args[1] then
		local skill = thisScope["$skill"]

		if args[1] == nil then
			if skill:getDefaultEntry() ~= nil then
				error("The default entry point is already specified.")
			end

			skill:setDefaultEntry(action)
		else
			for _, state in ipairs(args[1]) do
				if skill:getQualifiedEntry(state) ~= nil then
					error(string.format("The entry point for '%s' state is already specified.", state))
				end

				skill:setQualifiedEntry(state, action)
			end
		end

		return action
	end
end
builtins["[trigger_by]"] = function(thisScope, args, actionOrFunction)
	if not args[1] then
		assert(args[1] ~= nil, "trigger event is missing!")

		if not args[2] then
			local oneshot = false

			oneshot = args.priority

			if not args.priority then
				local priority = 0

				if not args[3] then
					oneshot = args.oneshot

					if not args.oneshot then
						local skill = thisScope["$skill"]

						skill:addEventTriggeredAction(args[1], actionOrFunction, priority, oneshot)

						return actionOrFunction
					end
				end
			end
		end
	end
end
builtins["[schedule_in_cycles]"] = function(thisScope, args, actionOrFunction)
	if not args[1] then
		assert(args[1] ~= nil and args[1] > 0, "invalid argument #1 (`interval`)")

		local var_13_0 = {
			type = "Periodic",
			interval = args[1]
		}

		var_13_0.start = args[2] or args.start or 0
		var_13_0.ending = args[3] or args.ending

		local timer = var_13_0
		local var_13_1 = args[4]

		if not args[4] then
			var_13_1 = args.priority

			if not args.priority then
				local priority = 0
				local skill = thisScope["$skill"]

				skill:addTimeTriggeredAction(timer, actionOrFunction, priority)

				return actionOrFunction
			end
		end
	end
end
builtins["[schedule_at_moments]"] = function(thisScope, args, actionOrFunction)
	if not args[1] then
		local moments = args.moments

		assert(moments ~= nil and #moments > 0, "invalid argument #1 (`moments`)")

		local timer = {
			type = "Specific",
			moments = moments
		}
		local var_14_1 = args[2]

		if not args[2] then
			var_14_1 = args.priority

			if not args.priority then
				local priority = 0
				local skill = thisScope["$skill"]

				skill:addTimeTriggeredAction(timer, actionOrFunction, priority)

				return actionOrFunction
			end
		end
	end
end
