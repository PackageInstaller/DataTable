-- chunkname: @/tmp/or_script/lua_compile/dragon/timesharding/TaskListener.lua

module("timesharding", package.seeall)

TaskListener = class("TaskListener")

function TaskListener:initialize()
	super.initialize(self)
end

function TaskListener:onProgress(task, progress)
	return
end

function TaskListener:onError(task, err, level)
	return
end

function TaskListener:onCompleted(task)
	return
end

function TaskListener:onAbort(task)
	return
end
