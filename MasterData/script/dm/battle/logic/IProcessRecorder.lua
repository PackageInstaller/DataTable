-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/IProcessRecorder.lua

IProcessRecorder = interface("IProcessRecorder")

function IProcessRecorder:beginSkillAction(actionEnv, actor, target)
	return
end

function IProcessRecorder:endSkillAction(actionEnv, reason)
	return
end

function IProcessRecorder:beginActionFragment(actionEnv)
	return
end

function IProcessRecorder:endActionFragment(actionEnv)
	return
end

function IProcessRecorder:newObjectTimeline(objId, typeName, workId)
	return
end

function IProcessRecorder:recordObjectEvent(objId, event, detail, workId)
	return
end
