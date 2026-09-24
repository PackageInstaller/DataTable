local var_0_0 = {}
local var_0_1

local function var_0_3(arg_3_0, arg_3_1)
	gamecore.start_register()

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		local var_3_0 = arg_3_0(iter_3_1 .. ".init")

		if var_3_0.link then
			var_3_0.link(iter_3_1, arg_3_0)
		end
	end

	gamecore.finish_register(arg_3_0)

	gamecore.protobuf = gamecore.protobuf or gamecore._protobuf

	gamecore.start_register()

	for iter_3_2, iter_3_3 in pairs(arg_3_1) do
		local var_3_1 = arg_3_0(iter_3_3 .. ".init")

		if var_3_1.first and not var_3_1.first(iter_3_3, arg_3_0) then
			return false
		end
	end

	gamecore.finish_register(arg_3_0)
	gamecore.start_register()

	for iter_3_4, iter_3_5 in pairs(arg_3_1) do
		local var_3_2 = arg_3_0(iter_3_5 .. ".init")

		if var_3_2.init and not var_3_2.init(iter_3_5, arg_3_0) then
			return false
		end
	end

	gamecore.finish_register(arg_3_0)

	for iter_3_6, iter_3_7 in pairs(arg_3_1) do
		local var_3_3 = arg_3_0(iter_3_7 .. ".init")

		if var_3_3.finish and not var_3_3.finish() then
			return false
		end
	end

	gamecore.start_register()

	for iter_3_8, iter_3_9 in pairs(arg_3_1) do
		local var_3_4 = arg_3_0(iter_3_9 .. ".init")

		if var_3_4.finally and not var_3_4.finally(iter_3_9, arg_3_0) then
			return false
		end
	end

	gamecore.finish_register(arg_3_0)

	return true
end

function var_0_0.reset(arg_4_0)
	gamecore.user = nil
	gamecore.BattleManager = nil

	gamecore.UILoader:reset()
	gamecore.LaunchManager:reset()
	gamecore.PreloadManager:reset()
	gamecore.ResourceLoader:reset()

	return true
end

local function var_0_4(arg_5_0)
	local var_5_0 = debug.getinfo(arg_5_0, "lS")

	if not var_5_0 then
		return nil, nil
	end

	return var_5_0.source:gsub("\\", "/"):match("(script/.*)$"), var_5_0.currentline
end

local function var_0_5()
	return os.date("[%Y-%m-%d %H:%M:%S] ", os.time())
end

local function var_0_6(...)
	local var_7_0 = {
		...
	}

	for iter_7_0 = 1, #var_7_0 do
		var_7_0[iter_7_0] = tostring(var_7_0[iter_7_0])
	end

	return table.concat(var_7_0, "\t")
end

local function var_0_7()
	if not app:isPC() then
		-- block empty
	end

	if _G.__ldb_alrady_init then
		return
	end

	lx.ldb.set_randport_begin_value(7000)
	lx.ldb.startdebug_use_loopfunc(-1)

	_G._l__lxdebug__l_.enable_auth = false
	_G.__ldb_alrady_init = true

	lx.ldb.register_extend_cmd_func("memory", function()
		return string.format("%s", lx.format_to_json({
			memory = processinfo_get().memory.current,
			lua_memory = collectgarbage("count"),
			cs_memory = math.floor(tonumber(tostring(System.GC.GetTotalMemory(false))) / 1024)
		}, {}))
	end)
	lx.ldb.register_extend_cmd_func("do_lua_gc", function()
		collectgarbage("collect")

		return string.format("now lua:%s", tostring(collectgarbage("count")))
	end)
	lx.ldb.register_extend_cmd_func("do_cs_gc", function()
		System.GC.Collect()

		return "cs gc finish."
	end)
	lx.ldb.register_extend_cmd_func("destroy_unused", function()
		gamecore.ResourceLoader:destroyAllUnusedAssets()

		return "destroy unused finish."
	end)
	lx.ldb.register_extend_cmd_func("object_info", function()
		return string.format("%s", lx.format_to_json((tolua_xbask or nil) and tolua_xbask.get_object_info(), {}))
	end)
	lx.ldb.register_extend_cmd_func("sn_memory", function()
		if _G.sn_memory_1 == nil then
			_G.sn_memory_1 = true

			local MemoryReferenceInfo = require("script/module/snapshot/MemoryReferenceInfo")

			MemoryReferenceInfo.m_cConfig.m_bAllMemoryRefFileAddTime = false

			collectgarbage("collect")
			MemoryReferenceInfo.m_cMethods.DumpMemorySnapshot("./", "1-Before", -1)
			collectgarbage("collect")

			_G.sn_memory_1 = true
		else
			local var_14_2 = require("script/module/snapshot/MemoryReferenceInfo")

			var_14_2.m_cConfig.m_bAllMemoryRefFileAddTime = false

			collectgarbage("collect")
			var_14_2.m_cMethods.DumpMemorySnapshot("./", "2-After", -1)
			var_14_2.m_cMethods.DumpMemorySnapshotComparedFile("./", "Compared", -1, "./LuaMemRefInfo-All-[1-Before].txt", "./LuaMemRefInfo-All-[2-After].txt")
			os.remove("./LuaMemRefInfo-All-[1-Before].txt")
			os.remove("LuaMemRefInfo-All-[2-After].txt")

			_G.sn_memory_1 = nil

			collectgarbage("collect")
		end

		return "sn_memory"
	end)
end

local function var_0_8(arg_15_0)
	if gamecore.ErrorReport and gamecore.ErrorReport.report then
		if gamecore.user and gamecore.user.haveErrorReport then
			gamecore.user:haveErrorReport()
		end

		gamecore.ErrorReport:report(arg_15_0)
	end

	local var_15_0 = gamecore.UILoader:createInstance("launch_msgbox")

	if gamecore.BattleManager and gamecore.BattleManager.reset then
		gamecore.BattleManager:reset()
	end

	var_15_0:showOne(gamecore.Language:getNowLang("unknow_error"), function()
		if gamecore.SceneManager:getIsBattleScene() then
			gamecore.SceneManager:loadScene("main", function()
				gamecore.PreloadManager:unload_battle_asset()
				gamecore.SceneManager:stop()
				os.exit()
			end)
		elseif app:getSystem():getOSType() == "android" then
			if AndroidJavaQuitManager then
				AndroidJavaQuitManager.MyJavaQuit()
			else
				os.exit()
			end
		else
			os.exit()
		end
	end)
end

local function var_0_9()
	if app:isPC() then
		if _G.__console_log == nil then
			require("console_log")

			local var_18_0 = __console_log

			function _console_log(arg_19_0, arg_19_1)
				arg_19_1 = arg_19_1 or false

				var_18_0(arg_19_0, arg_19_1)
				var_18_0("\n", false)
			end
		end
	else
		function _console_log()
			return
		end
	end

	local var_18_1 = _console_log

	function _G.__hotupdate__()
		local var_21_1, var_21_2 = xpcall(lx.hotUpdateAll, debug.traceback)

		;((var_21_1 or nil) and log.debuglog)("hotupdate result:\n" .. var_21_2)
	end

	if lx.__log_print == nil then
		lx.__log_print = lx.log_print
	end

	function lx.log_print(arg_22_0, arg_22_1)
		local var_22_0, var_22_1 = var_0_4(arg_22_1 or 4)

		if var_22_0 then
			arg_22_0 = string.format("[%s:%s]:%s", var_22_0, var_22_1, arg_22_0)
		end

		var_18_1(arg_22_0)
		Debugger.Log(arg_22_0)
	end

	if lx.__raw_print == nil then
		lx.__raw_print = print
	end

	function print(...)
		local var_23_0 = var_0_5() .. var_0_6(...)
		local var_23_1, var_23_2 = var_0_4(3)

		if var_23_1 then
			var_23_0 = string.format("[%s:%s]:%s", var_23_1, var_23_2, var_23_0)
		end

		var_18_1(var_23_0)
		Debugger.Log(var_23_0)
	end

	if lx.__assert_hook == nil then
		lx.__assert_hook = assert

		function assert(arg_24_0, ...)
			if arg_24_0 then
				return arg_24_0, ...
			else
				log.errorlog(...)
				lx.__assert_hook(arg_24_0, ...)
			end
		end
	end

	if lx.__error_hook == nil then
		lx.__error_hook = lx.error

		function lx.error(arg_25_0)
			arg_25_0 = debug.traceback(arg_25_0, 2)

			local var_25_0
			local var_25_1 = var_0_5()
			local var_25_2, var_25_3 = var_0_4(3)

			var_25_0 = var_25_2 and string.format("[%s:%s]:%s%s", var_25_2, var_25_3, var_25_1, arg_25_0) or var_25_1 .. arg_25_0

			var_18_1(var_25_0, true)
			Debugger.LogError(var_25_0)
			var_0_8(var_25_0)
			_G.error(arg_25_0, 2)
		end
	end

	if log.__log_error_hook == nil then
		log.__log_error_hook = log.__log_error

		function log.__log_error(arg_26_0, ...)
			local var_26_0
			local var_26_1 = var_0_5()
			local var_26_2, var_26_3 = var_0_4(4)

			var_26_0 = var_26_2 and string.format("[%s:%s]:%s%s", var_26_2, var_26_3, var_26_1, arg_26_0) or var_26_1 .. arg_26_0

			var_18_1(var_26_0, true)
			Debugger.LogError(var_26_0)

			if not ((gamecore.ErrorReport and gamecore.ErrorReport.isRelease or nil) and gamecore.ErrorReport:isRelease()) then
				log.__log_error_hook(arg_26_0, ...)
			end

			var_0_8(var_26_0)
		end
	end

	if encode.__utf8_to_ansi == nil then
		encode.__utf8_to_ansi = encode.utf8_to_ansi

		function encode.utf8_to_ansi(...)
			return ...
		end
	end
end

local function var_0_10(arg_28_0, arg_28_1)
	if not lx._LuaPanda then
		lx._LuaPanda = require("script/module/debug/LuaPanda")

		lx._LuaPanda.start(arg_28_0, arg_28_1, function(arg_29_0)
			if arg_29_0:find("xbask") then
				return true
			end

			return false
		end)
	end
end

local function var_0_12()
	if not app:isPC() then
		function exit_self_process()
			if app:getSystem():getOSType() == "android" then
				if AndroidJavaQuitManager then
					AndroidJavaQuitManager.MyJavaQuit()
				else
					os.exit()
				end
			else
				os.exit()
			end
		end
	end

	function openFileByType(arg_33_0)
		UpdateApp.InstallApk(arg_33_0)
	end
end

local function var_0_14()
	local var_36_0 = {
		hm_ios = {
			access_key = "INULRHFH9AKM",
			access_id = 1600019336
		},
		hm_android = {
			access_key = "A6LSD9CW5GKM",
			access_id = 1500019335
		},
		android_cbt = {
			access_key = "A6LSD9CW5GKM",
			access_id = 1500019335
		},
		hm_android_small = {
			access_key = "A6LSD9CW5GKM",
			access_id = 1500019335
		},
		taptap = {
			access_key = "A6LSD9CW5GKM",
			access_id = 1500019335
		},
		default = {
			access_key = "",
			access_id = 0
		}
	}
	local var_36_1 = var_36_0[app:getSystem():getChannel()] or var_36_0.default

	XGPushManager.InitXGPushSDK(var_36_1.access_id, var_36_1.access_key)
	XGPushManager.RegisterPush()
end

function var_0_0.launch(arg_37_0)
	lx.http_request_manager:enableHostIPCache(false)
	var_0_7()
	var_0_9()
	var_0_12()
	var_0_14()

	if app:isPC() then
		var_0_10("127.0.0.1", 8818)
	end

	if not var_0_3(arg_37_0, {
		"launch"
	}) then
		return false
	end

	if app:isPC() then
		gamecore.ErrorReport:init("http://192.168.1.44:10863/", false)
		gamecore.ErrorReport:setUserInfoFunc(function()
			local var_38_0 = {}

			var_38_0.account_id = gamecore.user and gamecore.user:get_account_id()
			var_38_0.server_name = gamecore.user and gamecore.user:get_server_name()
			var_38_0.is_enter_game = gamecore.user and gamecore.user:isGameIng()
			var_38_0.is_in_battle = gamecore.SceneManager and gamecore.SceneManager:getIsBattleScene()

			return var_38_0
		end)
	else
		gamecore.ErrorReport:init("http://xr-error-report.moefantasy.com:10863/", true)
		gamecore.ErrorReport:setUserInfoFunc(function()
			local var_39_0 = {}

			var_39_0.account_id = gamecore.user and gamecore.user:get_account_id()
			var_39_0.server_name = gamecore.user and gamecore.user:get_server_name()
			var_39_0.is_enter_game = gamecore.user and gamecore.user:isGameIng()
			var_39_0.is_in_battle = gamecore.SceneManager and gamecore.SceneManager:getIsBattleScene()
			var_39_0.is_bug_id = gamecore.user and gamecore.user:get_bug_id()

			return var_39_0
		end)
	end

	return true
end

function var_0_0.init(arg_40_0)
	local var_40_0 = {
		"config"
	}
	local var_40_1 = {
		"module",
		"logic",
		"ui"
	}

	if app.sync_init then
		if not var_0_3(arg_40_0, var_40_0) then
			return false
		end

		if not var_0_3(arg_40_0, var_40_1) then
			return false
		end

		var_0_1 = gamecore.main
	else
		app.queue_init_need_start = false
		var_0_1 = nil

		lx.QueueLoader:begin()

		if not var_0_3(arg_40_0, var_40_0) then
			return false
		end

		lx.QueueLoader:addTask(function()
			var_0_3(arg_40_0, var_40_1)

			var_0_1 = gamecore.main

			return true
		end)
		lx.QueueLoader:setEveryDoTime(8)
		lx.QueueLoader:start(function(arg_42_0)
			return
		end, function()
			if app.queue_init_need_start then
				var_0_1:start()
			end
		end, 8)
	end

	return true
end

function var_0_0.start(arg_44_0)
	if var_0_1 then
		var_0_1:start()
	else
		app.queue_init_need_start = true
	end

	return true
end

function var_0_0.run_once(arg_45_0)
	if var_0_1 then
		var_0_1.run_once(arg_45_0)
	end
end

return var_0_0
