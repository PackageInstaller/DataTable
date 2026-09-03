-- chunkname: @/tmp/or_script/lua_compile/foundation/luaext/exception.lua

if EXCEPTION_TRACE_DISABLED == nil then
	EXCEPTION_TRACE_DISABLED = false
end

EXCEPTION_LUA_ERROR = {
	_id = "lua error"
}

local _exception

local function _setException(code, msg)
	assert(_exception == nil)

	_exception = {
		code = code,
		msg = msg
	}

	if not EXCEPTION_TRACE_DISABLED then
		_exception.traceback = debug.traceback()
	end
end

function throw(code, msg)
	_setException(code, msg)
	error("throw exception")
end

function try(codeBlock)
	assert(codeBlock ~= nil)

	local catches = {}
	local defaultCatch
	local func = codeBlock
	local env = {}

	function env:catch(...)
		local args = {
			...
		}
		local codes = {}
		local catchBlock

		for i, v in ipairs(args) do
			if v == nil then
				break
			end

			if type(v) == "function" then
				catchBlock = v
			else
				codes[#codes + 1] = v
			end
		end

		if catchBlock ~= nil then
			if #codes == 0 then
				if defaultCatch == nil then
					defaultCatch = catchBlock
				end
			else
				for i, code in ipairs(codes) do
					if catches[code] == nil then
						catches[code] = catchBlock
					end
				end
			end
		end

		return self
	end

	function env:endtry()
		local ret, errmsg = ((coroutine.running() or nil) and coxpcall)(func, function(errmsg)
			if _exception == nil then
				_setException(EXCEPTION_LUA_ERROR, errmsg)

				if __G__TRACKBACK__ ~= nil then
					__G__TRACKBACK__(errmsg)
				end
			end
		end)

		if ret or _exception == nil then
			return
		end

		local catchBlock = catches[_exception.code]

		if catchBlock == nil then
			catchBlock = defaultCatch
		end

		if catchBlock ~= nil then
			local e = _exception

			_exception = nil

			catchBlock(e)

			return
		end

		error("throw exception")
	end

	return env
end
