-- chunkname: @/tmp/or_script/lua_compile/dm/trycall.lua

local function delayCall(func, ...)
	local callFunc = func
	local arglist = {
		n = select("#", ...),
		...
	}
	local animTickEntry

	local function timeUp(time)
		if animTickEntry ~= nil then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(animTickEntry)

			animTickEntry = nil

			if arglist ~= nil and arglist.n > 0 then
				callFunc(unpack(arglist, 1, arglist.n))
			else
				callFunc()
			end
		end
	end

	animTickEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(timeUp, 0, false)

	return animTickEntry
end

local function getLuaErrorDescription(errmsg)
	local _, pos1 = string.find(errmsg, ":")

	if pos1 then
		local _, pos2 = string.find(errmsg, ":", pos1 + 1)

		if pos2 then
			local _, pos3 = string.find(errmsg, " ", pos2 + 1)

			while pos3 == pos2 + 1 do
				pos2 = pos3
				_, pos3 = string.find(errmsg, " ", pos3 + 1)
			end

			return string.sub(errmsg, pos2 + 1)
		end
	end

	return errmsg
end

local function fixErrMsg(errmsg, trace_text)
	local errmsg_fix = getLuaErrorDescription(errmsg)
	local _, pos = string.find(trace_text, "in function 'trycall'")

	if pos then
		local _, pos1 = string.find(trace_text, ":", pos + 1)

		if pos1 then
			local tmpStr = string.sub(trace_text, pos + 3, pos1)
			local pos2, pos3 = string.find(trace_text, tmpStr, 1, true)
			local _, pos4 = string.find(trace_text, ":", pos3 + 1)

			return string.sub(trace_text, pos2, pos4) .. " " .. errmsg_fix, "stack traceback:\n\t" .. string.sub(trace_text, pos2)
		end
	end

	return errmsg
end

local function __TRACKBACK__(errmsg, ...)
	local trace_text = debug.traceback("", 0)

	errmsg = fixErrMsg(errmsg, trace_text)

	print("-----------------------TRACKBACK-----------------------")
	print(errmsg .. "\n" .. trace_text, "LUA ERROR")
	print("-----------------------TRACKBACK-----------------------")
	delayCall(function()
		if DEBUG and DEBUG ~= 0 or app.pkgConfig.showLuaError == 1 then
			app.showMessageBox(errmsg .. "\n" .. trace_text, "LUA_ERROR")
		end

		if app.pkgConfig.enableBugTracer ~= false then
			local curVersion = app:getAssetsManager():getCurrentVersion()

			if curVersion <= 0 then
				curVersion = "dev"
			end

			dpsBugTracer.reportLuaError("[" .. curVersion .. "] LUA ERROR: " .. getLuaErrorDescription(errmsg), errmsg, trace_text)
		end
	end)

	return trace_text
end

return function(func, ...)
	local args = {
		...
	}

	return xpcall(function()
		func(unpack(args))
	end, __TRACKBACK__)
end
