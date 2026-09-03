-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/sdk/recorder.lua

if not SkillDevKit then
	function SkillDevKit.RecordEffect(env, objId, event, data)
		local recorder = env["$recorder"]

		if recorder then
			recorder:recordObjectEvent(objId, event, data, env["$id"])
		end
	end

	function SkillDevKit.RecordImmediately(env, objId, event, data)
		local recorder = env["$recorder"]

		if recorder then
			recorder:recordObjectEvent(objId, event, data, nil)
		end
	end
end
