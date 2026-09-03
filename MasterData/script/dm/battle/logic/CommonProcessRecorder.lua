-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/CommonProcessRecorder.lua

CommonProcessRecorder = class("CommonProcessRecorder")

function CommonProcessRecorder:initialize(battleRecorder)
	super.initialize(self)

	self._battleRecorder = battleRecorder
end

function CommonProcessRecorder:reset()
	self._skillWorks = {}
end

CommonProcessRecorder:implements(IProcessRecorder)

function CommonProcessRecorder:getCurrentFrame()
	return self._battleRecorder:getCurrentFrame()
end

function CommonProcessRecorder:gotoFrame(frame)
	return self._battleRecorder:gotoFrame(frame)
end

function CommonProcessRecorder:beginSkillAction(actionEnv, actor, target)
	local action = actionEnv["$action"]
	local workId = actionEnv["$id"]

	assert(workId ~= nil)

	self._skillWorks[workId] = {
		action = action,
		actor = actor,
		target = target
	}

	local var_5_0 = actor:getId()
	local var_5_1 = {
		act = workId,
		trgt = target and target:getId(),
		skill = action:getFullName(),
		model = action:getCutInAnimation(),
		proud = action:getProudAnimation(),
		load = action:getEffectRes()
	}

	var_5_1.type = action:getOwnerSkill():getType()

	self._battleRecorder:recordEvent(var_5_0, "BeginSkill", var_5_1)

	return workId
end

function CommonProcessRecorder:endSkillAction(actionEnv, reason)
	local workId = actionEnv["$id"]
	local skillWork = self._skillWorks[workId]

	if skillWork == nil then
		return
	end

	local actor = skillWork.actor

	self._battleRecorder:recordEvent(actor:getId(), "EndSkill", {
		act = workId,
		abort = reason and true or nil
	})
end

function CommonProcessRecorder:beginActionFragment(actionEnv)
	return
end

function CommonProcessRecorder:endActionFragment(actionEnv)
	return
end

function CommonProcessRecorder:newObjectTimeline(objId, typeName, workId)
	self._battleRecorder:newTimeline(objId, typeName)
end

function CommonProcessRecorder:recordObjectEvent(objId, event, detail, workId)
	if type(detail) == "table" and workId ~= nil then
		detail.act = workId
	end

	self._battleRecorder:recordEvent(objId, event, detail)
end

function CommonProcessRecorder:recordMetaEvent(objId, evt, data, typeName, workId)
	self._battleRecorder:recordMetaEvent(objId, evt, data, typeName)
end
