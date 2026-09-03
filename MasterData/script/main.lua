-- chunkname: @/tmp/or_script/lua_compile/main.lua

if jit then
	jit.off()
	jit.flush()
	print("关闭jit模式")
end

cc.FileUtils:getInstance():setPopupNotify(false)

local status
local var_0_0, var_0_1 = pcall(require, "dm.trycall")

trycall = var_0_1

if not var_0_0 then
	trycall = _G.pcall
end

trycall(require, "config")
trycall(require, "logging.DpsLogger")

local status, ret = pcall(function()
	local app = cc.Application:getInstance()
	local target = app:getTargetPlatform()

	print("启动mumu共享路径 targe=", target)

	if target == 3 then
		local mumuPath = "/mnt/sdcard/$MuMu共享文件夹/dm"
		local fileUtils = cc.FileUtils:getInstance()
		local searchPath = fileUtils:getSearchPaths()

		table.insert(searchPath, 1, mumuPath .. "/Resources")
		table.insert(searchPath, 1, mumuPath .. "/")

		mumuPath = "/sdcard/Pictures/dm"

		table.insert(searchPath, 1, "/sdcard/Pictures/dm" .. "/Resources")
		table.insert(searchPath, 1, mumuPath .. "/")
		fileUtils:setSearchPaths(searchPath)
	end

	require("dev.devConfig")
end)

if not status then
	print("load dev.devConfig error:" .. (ret or ""))
end

status, ret = pcall(function()
	require("dev.remoteDebug")
end)

if not status then
	print("load dev.remoteDebug  error:" .. (ret or ""))
end

local var_0_2

if DEBUG == 0 and cc.Texture2D.setJPGDefaultAlphaPixelFormat then
	cc.Texture2D:setJPGDefaultAlphaPixelFormat(3)

	var_0_2 = tostring(os.time()):reverse()
end

math.randomseed(tonumber(var_0_2:sub(1, 7)))
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 5000)

local function main()
	require("dm.main")
end

main()
