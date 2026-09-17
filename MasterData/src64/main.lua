require("Cocos2d")
require("Cocos2dConstants")
require("DeprecatedEnum.lua")
require("DeprecatedClass.lua")
require("Deprecated.lua")

GAME_STATUS = nil

function cclog(...)
	print(string.format(...))
end

function __G__GAMELOG__(arg_2_0, arg_2_1)
	local var_2_0 = io.open("./src/gamelog.log", "a+")

	var_2_0:write(((string.format("\n--------[%s]--------\n", (os.date("%Y-%m-%d %X"))) .. "LUA ERROR: " .. tostring(arg_2_0) .. "\n") .. arg_2_1) .. "\n--------------[end]------------------\n")
	var_2_0:flush()
	var_2_0:close()
end

function __G__TRACKBACK__(arg_3_0)
	cclog("----------------------------------------")
	cclog("LUA ERROR: " .. tostring(arg_3_0) .. "\n")

	local var_3_0 = debug.traceback()

	cclog(var_3_0)
	cclog("----------------------------------------")

	if cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_WINDOWS then
		__G__GAMELOG__(arg_3_0, var_3_0)
	else
		buglyReportLuaException(tostring(arg_3_0), var_3_0)
	end

	return arg_3_0
end

function print_lua_table(arg_4_0, arg_4_1)
	if arg_4_0 == nil or type(arg_4_0) ~= "table" then
		return
	end

	local function var_4_0(arg_5_0)
		print("[table] " .. tostring(arg_5_0))
	end

	arg_4_1 = arg_4_1 or 0

	for iter_4_0, iter_4_1 in pairs(arg_4_0) do
		if type(iter_4_0) == "string" then
			iter_4_0 = string.format("%q", iter_4_0)
		end

		local var_4_1 = ""

		if type(iter_4_1) == "table" then
			var_4_1 = "{"
		end

		local var_4_2 = string.rep("    ", arg_4_1)

		formatting = var_4_2 .. "[" .. iter_4_0 .. "]" .. " = " .. var_4_1

		if type(iter_4_1) == "table" then
			var_4_0(formatting)
			print_lua_table(iter_4_1, arg_4_1 + 1)
			var_4_0(var_4_2 .. "},")
		else
			var_4_0(formatting .. (type(iter_4_1) == "string" and string.format("%q", iter_4_1) or tostring(iter_4_1)) .. ",")
		end
	end
end

function doString(arg_7_0)
	local var_7_0, var_7_1 = pcall((loadstring(arg_7_0)))

	if var_7_0 then
		return var_7_1
	end

	return nil
end

function doFile(arg_8_0)
	local var_8_0, var_8_1 = pcall((loadstring((cc.FileUtils:getInstance():getStringFromFile(arg_8_0)))))

	if var_8_0 then
		return var_8_1
	end

	return nil
end

package.path = package.path .. ";./src64/?.lua"

require("luaext")

GAME_STORAGE_FOLDER = "vc" .. cc.Native:getVersionCode()
SRC_FOLDER = "src64"

local var_0_2, var_0_3 = xpcall(function()
	collectgarbage("collect")
	collectgarbage("setpause", 200)
	collectgarbage("setstepmul", 200)
	cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. GAME_STORAGE_FOLDER .. "/v12/" .. SRC_FOLDER)
	cc.FileUtils:getInstance():addSearchPath(SRC_FOLDER)
	cc.FileUtils:getInstance():addSearchPath("activity_all_rounder")
	require("appinit").runApp()
end, __G__TRACKBACK__)

if not var_0_2 then
	error(var_0_3)
end
