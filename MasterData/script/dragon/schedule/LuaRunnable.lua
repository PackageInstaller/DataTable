-- chunkname: @/tmp/or_script/lua_compile/dragon/schedule/LuaRunnable.lua

LuaRunnable = class("LuaRunnable")

local CMD_ABORT = "@abort"
local CMD_NOTIFY = "@notify"

function LuaRunnable:initialize()
	super.initialize(self)
end

function LuaRunnable:log(...)
	if _G.cclog then
		_G.cclog(...)
	else
		print(...)
	end
end

function LuaRunnable:isRunning()
	return self._thread ~= nil
end

function LuaRunnable:isInWorkThread()
	return self._thread ~= nil and coroutine.running() == self._thread
end

function LuaRunnable:run(...)
	if self:isRunning() then
		return false
	end

	self._abortInfo = nil
	self._thread = coroutine.create(self.main)

	return self:_processResumeResult(coroutine.resume(self._thread, self, ...))
end

function LuaRunnable:_processResumeResult(status, ...)
	local thread = self._thread

	if coroutine.status(thread) == "dead" then
		self._thread = nil

		if status then
			self:onExit(...)
		end
	end

	if not status then
		local abortInfo = self._abortInfo

		if abortInfo ~= nil then
			self._abortInfo = nil

			self:onExit(abortInfo.exitCode)

			return true, abortInfo.exitCode
		end

		local innerTraceback = debug.traceback(thread, ..., 1)

		if not __G__TRACKBACK__ then
			-- block empty
		end
	end

	return status, ...
end

function LuaRunnable:notify(...)
	if self._thread == nil then
		return false
	end

	return self:_processResumeResult(coroutine.resume(self._thread, CMD_NOTIFY, ...))
end

function LuaRunnable:abort(exitCode)
	if self._thread == nil then
		return false
	end

	return self:_processResumeResult(coroutine.resume(self._thread, CMD_ABORT, exitCode or -1))
end

function LuaRunnable:exit(exitCode)
	self._abortInfo = {
		exitCode = exitCode
	}

	error("exit", 2)
end

function LuaRunnable:_processYieldResult(cmd, ...)
	if cmd == CMD_ABORT then
		return self:exit(...)
	end

	return ...
end

function LuaRunnable:wait(...)
	assert(self._thread ~= nil)

	return self:_processYieldResult(coroutine.yield(...))
end

function LuaRunnable:onAborted(exitCode)
	return
end

function LuaRunnable:onExit(exitCode)
	return
end

function LuaRunnable:main(...)
	return
end
