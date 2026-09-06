-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/ToLua/Lua/jit/v.lua

local jit = require("jit")

assert(jit.version_num == 20100, "LuaJIT core/library version mismatch")

local jutil = require("jit.util")
local vmdef = require("jit.vmdef")
local funcinfo, traceinfo = jutil.funcinfo, jutil.traceinfo
local type, format = type, string.format
local stdout, stderr = io.stdout, io.stderr
local active, out, startloc, startex

local function fmtfunc(func, pc)
	local fi = funcinfo(func, pc)

	if fi.loc then
		return fi.loc
	elseif fi.ffid then
		return vmdef.ffnames[fi.ffid]
	elseif fi.addr then
		return format("C:%x", fi.addr)
	else
		return "(?)"
	end
end

local function fmterr(err, info)
	if type(err) == "number" then
		if type(info) == "function" then
			info = fmtfunc(info)
		end

		err = format(vmdef.traceerr[err], info)
	end

	return err
end

local function dump_trace(what, tr, func, pc, otr, oex)
	if what == "start" then
		startloc = fmtfunc(func, pc)

		if otr then
			startex = "(" .. otr .. "/" .. (oex == -1 and "stitch" or oex) .. ") " or ""
		end
	else
		if what == "abort" then
			local loc = fmtfunc(func, pc)

			if loc ~= startloc then
				print(format("[TRACE --- %s%s -- %s at %s]\n", startex, startloc, fmterr(otr, oex), loc))
			else
				print(format("[TRACE --- %s%s -- %s]\n", startex, startloc, fmterr(otr, oex)))
			end
		elseif what == "stop" then
			local info = traceinfo(tr)
			local link, ltype = info.link, info.linktype

			if ltype == "interpreter" then
				print(format("[TRACE %3s %s%s -- fallback to interpreter]\n", tr, startex, startloc))
			elseif ltype == "stitch" then
				print(format("[TRACE %3s %s%s %s %s]\n", tr, startex, startloc, ltype, fmtfunc(func, pc)))
			elseif link == tr or link == 0 then
				print(format("[TRACE %3s %s%s %s]\n", tr, startex, startloc, ltype))
			elseif ltype == "root" then
				print(format("[TRACE %3s %s%s -> %d]\n", tr, startex, startloc, link))
			else
				print(format("[TRACE %3s %s%s -> %d %s]\n", tr, startex, startloc, link, ltype))
			end
		else
			print(format("[TRACE %s]\n", what))
		end

		out:flush()
	end
end

local function dumpoff()
	if active then
		active = false

		jit.attach(dump_trace)

		if out and out ~= stdout and out ~= stderr then
			out:close()
		end

		out = nil
	end
end

local function dumpon(outfile)
	if active then
		dumpoff()
	end

	outfile = outfile or os.getenv("LUAJIT_VERBOSEFILE")

	if outfile then
		if outfile == "-" then
			out = stdout or assert(io.open(outfile, "w"))
		end
	else
		out = stderr
	end

	jit.attach(dump_trace, "trace")

	active = true
end

return {
	on = dumpon,
	off = dumpoff,
	start = dumpon
}
