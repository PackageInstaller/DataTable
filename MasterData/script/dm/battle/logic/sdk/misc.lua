-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/sdk/misc.lua

if not SkillDevKit then
	function SkillDevKit.SetCtxVar(env, name, value)
		env.global["$BattleContext"]:setObject(name, value)
	end

	function SkillDevKit.SetGlobalVar(env, name, value)
		return env.global["$BattleContext"]:getObject(name)
	end

	function SkillDevKit.RetainObject(env, object)
		local references = env["$references"]

		if references == nil then
			references = {}
			env["$references"] = references
		end

		local count = references[object]

		if count == nil then
			count = 1
			references[object] = 1

			if object.incReferenceCount ~= nil then
				object:incReferenceCount()
			end
		else
			count = count + 1
			references[object] = count
		end

		return count
	end

	function SkillDevKit.ReleaseObject(env, object)
		local references = env["$references"]
		local count = references and references[object]

		if count == nil then
			return 0
		end

		if count == 1 then
			count = 0
			references[object] = nil

			if object.decReferenceCount ~= nil then
				object:decReferenceCount()
			end
		else
			count = count - 1
			references[object] = count
		end

		return count
	end

	function SkillDevKit.ReleaseLock(env, ...)
		local skillSystem = env.global["$SkillSystem"]

		return releaseAcquiredLocks(skillSystem:getSkillScheduler(), env, ...)
	end

	function SkillDevKit.ModifyDamage(env, damage, operator, factor)
		local dmgIsTable = type(damage) == "table"

		if dmgIsTable then
			if not damage.val then
				local val = damage

				if operator == "*" then
					val = val * factor
				elseif operator == "+" then
					val = val + factor
				elseif operator == "-" then
					val = val - factor
				end

				if dmgIsTable then
					damage.val = val
				else
					damage = val
				end

				return damage
			end
		end
	end

	function SkillDevKit.Dump(env, obj, str, nesting)
		dump(obj, str, nesting)
	end

	function SkillDevKit.StrFind(env, s, pattern, init)
		local startP, endP = string.find(s, pattern, init)

		if startP ~= nil then
			return true
		else
			return false
		end
	end

	function SkillDevKit.TableRemove(env, list, element)
		for i, v in pairs(list) do
			if v == element then
				table.remove(list, i)
			end
		end
	end
end
