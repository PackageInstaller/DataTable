-- chunkname: @/tmp/or_script/lua_compile/dm/utils/LuaProfilerUtils.lua

module("LuaProfilerUtils", package.seeall)
pcall(require, "luaprofiler")

local isStart = false

function startLuaProfiler()
	if not luaprofiler then
		print("luaprofiler只在debug模式下开启")

		return
	end

	if isStart then
		stopLuaProfiler()
	end

	local ret = luaprofiler.start(device.writablePath .. "profile.csv")

	if ret then
		isStart = true

		print("luaprofiler初始化完成")
		luaprofiler.clearLog()
		luaprofiler.beginFastLog()
		print("luaprofiler开始记录日志")
	else
		print("luaprofiler初始失败")
	end
end

function stopLuaProfiler(data)
	if not luaprofiler then
		print("luaprofiler只在debug模式下开启")

		return
	end

	if not isStart then
		return
	end

	luaprofiler.stopFastLog()
	print("luaprofiler结束检测准备获取结果...")

	local ret = luaprofiler.getLogResult()

	luaprofiler.clearLog()
	luaprofiler.stop()

	isStart = false
	data = data or {}
	data.key = data.key or "LuaProfiler"

	print("结果获取成功,准备进行排序....")
	table.sort(ret, function(a, b)
		return tonumber(a.sumtotal) > tonumber(b.sumtotal)
	end)

	local retStrArray = {}

	table.insert(retStrArray, 1, string.format("%s   ,%s   ,%s   ,%s   ,%s   ,%s   \n", "name", "call", "sumlocal", "sumtotal", "maxlocal", "maxtotal"))

	for i, val in ipairs(ret) do
		table.insert(retStrArray, string.format("%s   ,%d   ,%.5f   ,%.5f   ,%.5f   ,%.5f   \n", val.name, val.callnum, val.sumlocal, val.sumtotal, val.maxlocal, val.maxtotal))
	end

	local resStr = table.concat(retStrArray)

	if data.path then
		print("结果获取成功,准备写入文件....")

		local f = assert(io.open(data.path .. "taskpro.csv", "w"))

		f:write(resStr)
		f:close()
	else
		print("结果获取成功,准备上传文件....")
		CommonUtils.uploadData({
			content = resStr,
			key = data.key .. ".csv"
		})
	end

	return resStr
end
