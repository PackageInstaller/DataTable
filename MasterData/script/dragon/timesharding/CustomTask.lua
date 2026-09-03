-- chunkname: @/tmp/or_script/lua_compile/dragon/timesharding/CustomTask.lua

module("timesharding", package.seeall)

CustomTask = class("CustomTask", Task)

function CustomTask:initialize(func, abort)
	super.initialize(self)
	assert(func ~= nil)

	self._taskFunc = func
	self._abortFunc = abort
end

function CustomTask:start()
	super.start(self)
	self:reportProgress(0)

	local result, err = self:_taskFunc()

	if result == nil then
		return
	end

	if result then
		self:reportProgress(1)
		self:finish()
	else
		self:reportError(err, kError)
	end
end

function CustomTask:abort()
	if not self:isRunning() then
		return
	end

	if self._abortFunc then
		self:_abortFunc()
	end

	super.abort(self)
end
