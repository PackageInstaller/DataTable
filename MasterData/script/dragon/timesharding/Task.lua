-- chunkname: @/tmp/or_script/lua_compile/dragon/timesharding/Task.lua

module("timesharding", package.seeall)

kWarning = 1
kError = 2
kFatal = 3
Task = class("Task")

Task:has("_progress", {
	default = 0,
	is = "r"
})

function Task:initialize()
	super.initialize(self)

	self._progress = 0
end

function Task:setTaskListener(listener)
	self._taskListener = listener
end

function Task:reportProgress(progress)
	self._progress = progress

	if self._taskListener ~= nil then
		self._taskListener:onProgress(self, progress)
	end
end

function Task:breakTask()
	self._isRunning = false
end

function Task:reportError(err, level)
	self._error = true

	if self._taskListener ~= nil then
		self._taskListener:onError(self, err, level or kError)
	end
end

function Task:hasError()
	return self._error
end

function Task:recoveryFromError()
	self._error = nil
end

function Task:traceError()
	return self._error and {
		self
	} or nil
end

function Task:start()
	self._isRunning = true
	self._progress = 0
end

function Task:finish()
	if not self:isRunning() then
		return
	end

	self._isRunning = false

	if self._taskListener ~= nil then
		self._taskListener:onCompleted(self)
	end
end

function Task:isRunning()
	return self._isRunning
end

function Task:abort()
	if not self:isRunning() then
		return
	end

	self:breakTask()

	if self._taskListener ~= nil then
		self._taskListener:onAbort(self)
	end
end
