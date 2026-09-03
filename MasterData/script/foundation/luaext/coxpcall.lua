-- chunkname: @/tmp/or_script/lua_compile/foundation/luaext/coxpcall.lua

if _VERSION == "Lua 5.2" then
	copcall = pcall
	coxpcall = xpcall

	return {
		pcall = pcall,
		xpcall = xpcall,
		running = coroutine.running
	}
end

local performResume, handleReturnValue
local oldpcall = pcall

if not table.pack then
	local function pack(...)
		return {
			n = select("#", ...),
			...
		}
	end

	if not table.unpack then
		local unpack = unpack
		local running = coroutine.running
		local coromap = setmetatable({}, {
			__mode = "k"
		})

		function handleReturnValue(err, co, status, ...)
			if not status then
				return false, err(debug.traceback(co, (...)), ...)
			end

			if coroutine.status(co) == "suspended" then
				return performResume(err, co, coroutine.yield(...))
			else
				return true, ...
			end
		end

		function performResume(err, co, ...)
			return handleReturnValue(err, co, coroutine.resume(co, ...))
		end

		function coxpcall(f, err, ...)
			local res, co = oldpcall(coroutine.create, f)

			if not res then
				local params = pack(...)

				local function newf()
					return f(unpack(params, 1, params.n))
				end

				co = coroutine.create(newf)
			end

			coromap[co] = running() or "mainthread"

			return performResume(err, co, ...)
		end

		function corunning(coro)
			if coro ~= nil then
				assert(type(coro) == "thread", "Bad argument; expected thread, got: " .. type(coro))
			else
				coro = running()
			end

			while coromap[coro] do
				coro = coromap[coro]
			end

			if coro == "mainthread" then
				return nil
			end

			return coro
		end

		local function id(trace, ...)
			return ...
		end

		function copcall(f, ...)
			return coxpcall(f, id, ...)
		end

		return {
			pcall = copcall,
			xpcall = coxpcall,
			running = corunning
		}
	end
end
