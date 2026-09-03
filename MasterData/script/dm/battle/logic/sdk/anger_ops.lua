-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/sdk/anger_ops.lua

if not SkillDevKit then
	local floor, ceil = math.floor, math.ceil

	function SkillDevKit.ApplyRPDamage(env, target, damage)
		if not target:isInStages(ULS_Normal) then
			return
		end

		local angerSystem = env.global["$AngerSystem"]

		return angerSystem:performAngerDamage(env["$actor"], target, damage, env["$id"])
	end

	function SkillDevKit.ApplyRPRecovery(env, target, recovery)
		if not target:isInStages(ULS_Normal) then
			return
		end

		local angerSystem = env.global["$AngerSystem"]

		return angerSystem:performAngerRecovery(env["$actor"], target, recovery, env["$id"])
	end
end
