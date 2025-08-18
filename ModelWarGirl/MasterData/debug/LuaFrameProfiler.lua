-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\LuaFrameProfiler.lua

local LuaProfiler = LuaProfiler
local ffnames = {
	event = {
		[142] = "event.__call",
		[20] = "_xpcall.__call"
	}
}
local ffnames2 = {
	[0] = "Lua",
	"C",
	"assert",
	"type",
	"next",
	"pairs",
	"ipairs_aux",
	"ipairs",
	"getmetatable",
	"setmetatable",
	"getfenv",
	"setfenv",
	"rawget",
	"rawset",
	"rawequal",
	"unpack",
	"select",
	"tonumber",
	"tostring",
	"error",
	"pcall",
	"xpcall",
	"loadfile",
	"load",
	"loadstring",
	"dofile",
	"gcinfo",
	"collectgarbage",
	"newproxy",
	"print",
	"coroutine.status",
	"coroutine.running",
	"coroutine.isyieldable",
	"coroutine.create",
	"coroutine.yield",
	"coroutine.resume",
	"coroutine.wrap_aux",
	"coroutine.wrap",
	"math.abs",
	"math.floor",
	"math.ceil",
	"math.sqrt",
	"math.log10",
	"math.exp",
	"math.sin",
	"math.cos",
	"math.tan",
	"math.asin",
	"math.acos",
	"math.atan",
	"math.sinh",
	"math.cosh",
	"math.tanh",
	"math.frexp",
	"math.modf",
	"math.log",
	"math.atan2",
	"math.pow",
	"math.fmod",
	"math.ldexp",
	"math.min",
	"math.max",
	"math.random",
	"math.randomseed",
	"bit.tobit",
	"bit.bnot",
	"bit.bswap",
	"bit.lshift",
	"bit.rshift",
	"bit.arshift",
	"bit.rol",
	"bit.ror",
	"bit.band",
	"bit.bor",
	"bit.bxor",
	"bit.tohex",
	"string.byte",
	"string.char",
	"string.sub",
	"string.rep",
	"string.reverse",
	"string.lower",
	"string.upper",
	"string.dump",
	"string.find",
	"string.match",
	"string.gmatch_aux",
	"string.gmatch",
	"string.gsub",
	"string.format",
	"table.maxn",
	"table.insert",
	"table.concat",
	"table.sort",
	"table.new",
	"table.clear",
	"io.method.close",
	"io.method.read",
	"io.method.write",
	"io.method.flush",
	"io.method.seek",
	"io.method.setvbuf",
	"io.method.lines",
	"io.method.__gc",
	"io.method.__tostring",
	"io.open",
	"io.popen",
	"io.tmpfile",
	"io.close",
	"io.read",
	"io.write",
	"io.flush",
	"io.input",
	"io.output",
	"io.lines",
	"io.type",
	"os.execute",
	"os.remove",
	"os.rename",
	"os.tmpname",
	"os.getenv",
	"os.exit",
	"os.clock",
	"os.date",
	"os.time",
	"os.difftime",
	"os.setlocale",
	"debug.getregistry",
	"debug.getmetatable",
	"debug.setmetatable",
	"debug.getfenv",
	"debug.setfenv",
	"debug.getinfo",
	"debug.getlocal",
	"debug.setlocal",
	"debug.getupvalue",
	"debug.setupvalue",
	"debug.upvalueid",
	"debug.upvaluejoin",
	"debug.sethook",
	"debug.gethook",
	"debug.debug",
	"debug.traceback",
	"jit.on",
	"jit.off",
	"jit.flush",
	"jit.status",
	"jit.attach",
	"jit.util.funcinfo",
	"jit.util.funcbc",
	"jit.util.funck",
	"jit.util.funcuvname",
	"jit.util.traceinfo",
	"jit.util.traceir",
	"jit.util.tracek",
	"jit.util.tracesnap",
	"jit.util.tracemc",
	"jit.util.traceexitstub",
	"jit.util.ircalladdr",
	"jit.opt.start",
	"jit.profile.start",
	"jit.profile.stop",
	"jit.profile.dumpstack",
	"ffi.meta.__index",
	"ffi.meta.__newindex",
	"ffi.meta.__eq",
	"ffi.meta.__len",
	"ffi.meta.__lt",
	"ffi.meta.__le",
	"ffi.meta.__concat",
	"ffi.meta.__call",
	"ffi.meta.__add",
	"ffi.meta.__sub",
	"ffi.meta.__mul",
	"ffi.meta.__div",
	"ffi.meta.__mod",
	"ffi.meta.__pow",
	"ffi.meta.__unm",
	"ffi.meta.__tostring",
	"ffi.meta.__pairs",
	"ffi.meta.__ipairs",
	"ffi.clib.__index",
	"ffi.clib.__newindex",
	"ffi.clib.__gc",
	"ffi.callback.free",
	"ffi.callback.set",
	"ffi.cdef",
	"ffi.new",
	"ffi.cast",
	"ffi.typeof",
	"ffi.typeinfo",
	"ffi.istype",
	"ffi.sizeof",
	"ffi.alignof",
	"ffi.offsetof",
	"ffi.errno",
	"ffi.string",
	"ffi.copy",
	"ffi.fill",
	"ffi.abi",
	"ffi.metatype",
	"ffi.gc",
	"ffi.load"
}
local blacklist = {
	["_xpcall.__call"] = 1,
	ipairs_aux = 1,
	unknow = 1
}
local profiler = {
	mark = 1,
	cache = 1
}
local stacktrace = {}

function profiler:scan(t, name)
	if self.mark[t] then
		return
	end

	self.mark[t] = true

	for k, v in pairs(t) do
		if type(k) == "string" then
			if type(v) == "function" then
				local str = k

				if name then
					str = name .. "." .. str
				end

				if not blacklist[str] and k ~= "__index" and k ~= "__newindex" then
					self.cache[v] = {
						id = -1,
						name = str
					}
				end
			elseif type(v) == "table" and not self.mark[v] then
				self:scan(v, k)
			end
		elseif name and k == tolua.gettag or k == tolua.settag then
			self:scan(v, name)
		end
	end
end

function profiler:scanlibs()
	local t = package.loaded

	self.mark[t] = true

	for k, v in pairs(t) do
		if type(k) == "string" and type(v) == "table" then
			self:scan(v, k)

			local mt = getmetatable(v)

			if mt then
				self:scan(mt, k)
			end
		end
	end
end

local function findstack(func)
	local pos = #stacktrace + 1

	for i, v in ipairs(stacktrace) do
		if v == func then
			pos = i
		end
	end

	return pos
end

local function jitreturn(count)
	local top = #stacktrace

	if top > 0 then
		local ar = debug.getinfo(5, "f")

		if ar then
			local func = ar.func
			local index = findstack(func)

			if top < index then
				ar = debug.getinfo(6, "f")

				if ar then
					func = ar.func
					index = findstack(func) or index
				end
			end

			for i = index + 1, top do
				table.remove(stacktrace)
				LuaProfiler.EndSample()
			end
		end
	end
end

local function BeginSample(name, func, cache)
	jitreturn()
	table.insert(stacktrace, func)

	if cache.id == -1 then
		cache.name = name
		cache.id = LuaProfiler.GetID(name)
	end

	LuaProfiler.BeginSample(cache.id)
end

local function BeginSampleNick(name, func, cache)
	jitreturn()
	table.insert(stacktrace, func)

	local id = -1

	if cache.nick == nil then
		cache.nick = {}
	end

	id = cache.nick[name]

	if not id then
		id = LuaProfiler.GetID(name)
		cache.nick[name] = id
	end

	LuaProfiler.BeginSample(id)
end

local function profiler_hook(event, line)
	if event == "call" then
		local name
		local func = debug.getinfo(2, "f").func
		local cache = profiler.cache[func]

		if cache then
			name = cache.name
		end

		if blacklist[name] then
			return
		end

		if name == "event.__call" then
			local ar = debug.getinfo(2, "n")

			BeginSampleNick(ar.name or name, func, cache)
		elseif name then
			BeginSample(name, func, cache)
		else
			local ar = debug.getinfo(2, "Sn")
			local method = ar.name
			local linedefined = ar.linedefined

			if not cache then
				cache = {
					id = -1,
					name = "unknow"
				}
				profiler.cache[func] = cache
			end

			if ar.short_src == "[C]" then
				if method == "__index" or method == "__newindex" then
					return
				end

				local name = tostring(func)
				local index = name:match("function: builtin#(%d+)")

				if not index then
					if method then
						name = method

						BeginSample(method, func, cache)
					elseif linedefined ~= -1 then
						name = ar.short_src .. linedefined

						BeginSample(name, func, cache)
					end
				else
					name = ffnames2[tonumber(index)]

					if not blacklist[name] then
						BeginSample(name, func, cache)
					end
				end
			elseif linedefined ~= -1 or method then
				local short_src = ar.short_src

				method = method or linedefined

				local name

				name = short_src:match("([^/\\]+)%.%w+$")
				name = name or short_src:match("([^/\\]+)$")

				local ffname = ffnames[name]

				if ffname then
					name = ffname[linedefined]
				else
					name = name .. "." .. method
				end

				name = name or short_src .. "." .. method

				BeginSample(name, func, cache)
			else
				BeginSample(name, func, cache)
			end
		end
	elseif event == "return" then
		local top = #stacktrace

		if top == 0 then
			return
		end

		local ar = debug.getinfo(2, "f")

		if ar.func == stacktrace[top] then
			table.remove(stacktrace)
			LuaProfiler.EndSample()
		else
			local index = findstack(ar.func)

			if top < index then
				return
			end

			for i = index, top do
				table.remove(stacktrace)
				LuaProfiler.EndSample()
			end
		end
	end
end

function profiler:start()
	self.mark = {}
	self.cache = {
		__mode = "k"
	}

	self:scan(_G, nil)
	self:scanlibs()

	self.mark = nil

	debug.sethook(profiler_hook, "cr", 0)
end

function profiler:print()
	for k, v in pairs(self.cache) do
		-- block empty
	end
end

function profiler:stop()
	debug.sethook(nil)

	self.cache = nil
end

return profiler
