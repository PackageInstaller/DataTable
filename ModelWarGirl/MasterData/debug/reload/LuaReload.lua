-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Reload\\LuaReload.lua

local LuaReload = {}

function LuaReload.init()
	local LuaReloader = require("Debug/Reload/luahotupdate")
	local luaPath = Framework.Tools.FileUtils.GetLuaPath()
	local isMatch = string.find(luaPath, "/.LuaCode/")

	if isMatch == nil then
		return
	end

	LuaReloader.Init("Debug/Reload/hotupdatelist", {
		luaPath
	})
	LuaReloader.Update()

	LuaReload.LuaReloader = LuaReloader
end

function LuaReload.ReloadSpecialData(...)
	local AVGInfo = require("UI/AVG/AVGInfo")

	AVGInfo:_init()
end

function LuaReload.reload()
	LuaReload.LuaReloader.Update()
	LuaReload.ReloadSpecialData()
end

return LuaReload
