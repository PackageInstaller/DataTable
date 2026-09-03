-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/sdk/schedule.lua

if not SkillDevKit then
	function SkillDevKit.DelayCall(env, delay, func, ...)
		local executor = env["$executor"]
		local n = select("#", ...)

		if n == 0 then
			executor:execAfterTime(delay, env, function(env, time)
				return func(env)
			end)
		else
			local arg = {
				n = n,
				...
			}

			executor:execAfterTime(delay, env, function(env, time)
				return func(env, unpack(arg, 1, arg.n))
			end)
		end
	end

	function SkillDevKit.MultiDelayCall(env, delays, func, ...)
		local executor = env["$executor"]
		local n = select("#", ...)

		if n == 0 then
			for i = 1, #delays do
				executor:execAfterTime(delays[i], env, function(env, time)
					return func(env, i)
				end)
			end
		else
			local arg = {
				n = n,
				...
			}
			local total = #delays

			assert(#arg[2] == total, "Skill Action:" .. env["$action"]:getFullName() .. " splitValue not match")

			for i = 1, total do
				executor:execAfterTime(delays[i], env, function(env, time)
					return func(env, i, total, unpack(arg, 1, arg.n))
				end)
			end
		end
	end

	function SkillDevKit.LockTime(env, dur)
		local timingSystem = env.global["$TimingSystem"]

		timingSystem:lockTime(dur)
	end

	function SkillDevKit.GetbattleTime(env)
		local timingSystem = env.global["$TimingSystem"]

		return timingSystem:getCumulativeTime()
	end
end
