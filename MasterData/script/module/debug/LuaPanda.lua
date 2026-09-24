local var_0_0 = true
local var_0_1 = 1
local var_0_2 = 0.005
local var_0_3 = 0.5
local var_0_4 = true
local var_0_5 = false
local var_0_6
local var_0_7 = 2
local var_0_8 = "3.2.0"

LuaPanda = {}

local var_0_9 = LuaPanda
local var_0_10 = {}

var_0_9.tools = var_0_10
var_0_9.curStackId = 0

local var_0_11
local var_0_12 = {
	ALL_HOOK = 3,
	MID_HOOK = 2,
	LITE_HOOK = 1,
	DISCONNECT_HOOK = 0
}
local var_0_13 = {
	WAIT_CMD = 1,
	STEPOVER_STOP = 7,
	HIT_BREAKPOINT = 10,
	STEPIN_STOP = 8,
	STEPOUT_STOP = 9,
	STEPOVER = 4,
	STOP_ON_ENTRY = 2,
	STEPIN = 5,
	DISCONNECT = 0,
	STEPOUT = 6,
	RUN = 3
}
local var_0_14 = "|*|"
local var_0_15 = 86400
local var_0_16
local var_0_17
local var_0_18 = {}

var_0_9.breaks = var_0_18

local var_0_19 = ""
local var_0_20 = ""
local var_0_21 = ""
local var_0_22 = ""
local var_0_23 = ""
local var_0_24 = {}
local var_0_25 = {}
local var_0_26 = false
local var_0_27 = ""
local var_0_28
local var_0_29
local var_0_30
local var_0_31
local var_0_32
local var_0_33
local var_0_34
local var_0_35
local var_0_36
local var_0_37 = false
local var_0_38 = 1
local var_0_39 = 1
local var_0_40 = {}
local var_0_41 = ""
local var_0_42 = true
local var_0_43 = {}
local var_0_44 = {}
local var_0_45 = false
local var_0_46 = false
local var_0_47 = "launch.json文件的配置项useCHook被设置为false."
local var_0_48 = ""
local var_0_49 = ""
local var_0_50 = ""
local var_0_51 = false
local var_0_52
local var_0_53
local var_0_54 = false
local var_0_55
local var_0_56
local var_0_57 = false
local var_0_58 = 0
local var_0_59 = 0
local var_0_60 = 3
local var_0_61 = 0
local var_0_62
local var_0_63
local var_0_64
local var_0_65 = 0
local var_0_66
local var_0_67 = 0
local var_0_68 = false
local var_0_69
local var_0_70 = {}

function var_0_9.formatPathCache()
	return var_0_70
end

local var_0_71 = {}

function var_0_9.fakeBreakPointCache()
	return var_0_71
end

var_0_62 = _VERSION == "Lua 5.1" and loadstring or load

local var_0_72 = setmetatable({}, {
	__index = function(arg_3_0, arg_3_1)
		return (var_0_9.getWatchedVariable(arg_3_1, _G.LuaPanda.curStackId, false))
	end,
	__newindex = function(arg_4_0, arg_4_1, arg_4_2)
		var_0_9.setVariableValue(arg_4_1, _G.LuaPanda.curStackId, arg_4_2)
	end
})

function var_0_9.bindServer(arg_5_0, arg_5_1)
	var_0_31 = var_0_30

	var_0_31:settimeout(var_0_3)
	assert(var_0_31:bind(arg_5_0, arg_5_1))
	var_0_31:setoption("reuseaddr", true)
	assert(var_0_31:listen(0))
end

function var_0_9.startServer(arg_6_0, arg_6_1)
	arg_6_0 = tostring(arg_6_0 or "0.0.0.0")
	arg_6_1 = tonumber(arg_6_1) or 8818
	var_0_56 = true

	var_0_9.printToConsole("Debugger start as SERVER. bind host:" .. arg_6_0 .. " port:" .. tostring(arg_6_1), 1)

	if var_0_30 ~= nil then
		var_0_9.printToConsole("[Warning] 调试器已经启动，请不要再次调用start()", 1)

		return
	end

	var_0_9.changeRunState(var_0_13.DISCONNECT)

	if not var_0_9.reGetSock() then
		var_0_9.printToConsole("[Error] LuaPanda debugger start success , but get Socket fail , please install luasocket!", 2)

		return
	end

	var_0_28 = arg_6_0
	var_0_29 = arg_6_1

	var_0_9.bindServer(var_0_28, var_0_29)

	local var_6_0 = var_0_31:accept()

	var_0_30 = var_6_0

	if var_6_0 then
		var_0_9.printToConsole("First connect success!")
		var_0_9.connectSuccess()
	else
		var_0_9.printToConsole("First connect failed!")
		var_0_9.changeHookState(var_0_12.DISCONNECT_HOOK)
	end
end

function var_0_9.start(arg_7_0, arg_7_1)
	arg_7_0 = tostring(arg_7_0 or "127.0.0.1")
	arg_7_1 = tonumber(arg_7_1) or 8818

	var_0_9.printToConsole("Debugger start as CLIENT. connect host:" .. arg_7_0 .. " port:" .. tostring(arg_7_1), 1)

	if var_0_30 ~= nil then
		var_0_9.printToConsole("[Warning] 调试器已经启动，请不要再次调用start()", 1)

		return
	end

	var_0_9.changeRunState(var_0_13.DISCONNECT)

	if not var_0_9.reGetSock() then
		var_0_9.printToConsole("[Error] Start debugger but get Socket fail , please install luasocket!", 2)

		return
	end

	var_0_28 = arg_7_0
	var_0_29 = arg_7_1

	var_0_30:settimeout(var_0_2)

	if var_0_9.sockConnect(var_0_30) then
		var_0_9.printToConsole("First connect success!")
		var_0_9.connectSuccess()
	else
		var_0_9.printToConsole("First connect failed!")
		var_0_9.changeHookState(var_0_12.DISCONNECT_HOOK)
	end
end

function var_0_9:sockConnect()
	if self then
		local var_8_0, var_8_1 = self:connect(var_0_28, var_0_29)

		if var_8_1 == "connection refused" then
			var_0_9.reGetSock()
		end

		return var_8_0
	end

	return nil
end

function var_0_9.connectSuccess()
	if var_0_31 then
		var_0_31:close()
	end

	var_0_9.changeRunState(var_0_13.WAIT_CMD)
	var_0_9.printToConsole("connectSuccess", 1)

	if var_0_22 == "" then
		for iter_9_0, iter_9_1 in pairs((debug.getinfo(1, "S"))) do
			if iter_9_0 == "source" then
				var_0_22 = tostring(iter_9_1)
				var_0_55 = var_0_22:gsub(".*[Ll][Uu][Aa][Pp][Aa][Nn][Dd][Aa]", "")

				if var_0_34 ~= nil then
					var_0_34.sync_debugger_path(var_0_22)
				end
			end
		end
	end

	if var_0_23 == "" then
		var_0_23 = var_0_10.getFileSource()

		if var_0_34 ~= nil then
			var_0_34.sync_tools_path(var_0_23)
		end
	end

	if var_0_9.debugger_wait_msg() == false then
		var_0_9.printToVSCode("[debugger error]初始化未完成, 建立连接但接收初始化消息失败。请更换端口重试", 2)

		return
	end

	var_0_9.printToVSCode("debugger init success", 1)
	var_0_9.changeHookState(var_0_12.ALL_HOOK)

	if var_0_34 == nil then
		if var_0_64 == nil and type(coroutine.create) == "function" then
			var_0_9.printToConsole("change coroutine.create")

			var_0_64 = coroutine.create

			function coroutine.create(...)
				local var_10_0 = var_0_64(...)

				table.insert(var_0_44, var_10_0)
				var_0_9.changeCoroutineHookState()

				return var_10_0
			end
		else
			var_0_9.printToConsole("restart coroutine")
			var_0_9.changeCoroutineHookState()
		end
	end
end

function var_0_9.clearData()
	var_0_32 = nil
	var_0_33 = nil
	var_0_18 = {}
	var_0_70 = {}
	var_0_71 = {}
	var_0_9.breaks = var_0_18

	if var_0_34 ~= nil then
		var_0_34.sync_breakpoints()
		var_0_34.clear_pathcache()
	end
end

function var_0_9.stopAttach()
	var_0_0 = false

	var_0_9.printToConsole("Debugger stopAttach", 1)
	var_0_9.clearData()
	var_0_9.changeHookState(var_0_12.DISCONNECT_HOOK)

	var_0_65 = os.time()

	var_0_9.changeRunState(var_0_13.DISCONNECT)

	if var_0_30 ~= nil then
		var_0_30:close()

		if var_0_56 and var_0_31 then
			var_0_31 = nil
		end
	end
end

function var_0_9.disconnect()
	var_0_9.printToConsole("Debugger disconnect", 1)
	var_0_9.clearData()
	var_0_9.changeHookState(var_0_12.DISCONNECT_HOOK)

	var_0_65 = os.time()

	var_0_9.changeRunState(var_0_13.DISCONNECT)

	if var_0_30 ~= nil then
		var_0_30:close()

		var_0_30 = nil
		var_0_31 = nil
	end

	if var_0_28 == nil or var_0_29 == nil then
		var_0_9.printToConsole("[Warning] User call LuaPanda.disconnect() before set debug ip & port, please call LuaPanda.start() first!", 2)

		return
	end

	var_0_9.reGetSock()
end

function var_0_9.getBreaks()
	return var_0_18
end

function var_0_9.testBreakpoint()
	if var_0_63 and var_0_63 ~= "" then
		return var_0_9.breakpointTestInfo()
	else
		local var_15_0 = {}

		var_15_0[#var_15_0 + 1] = "正在准备进行断点测试，请按照如下步骤操作\n"
		var_15_0[#var_15_0 + 1] = "1. 请[删除]当前项目中所有断点;\n"
		var_15_0[#var_15_0 + 1] = "2. 在当前停止行打一个断点;\n"
		var_15_0[#var_15_0 + 1] = "3. 再次运行 'LuaPanda.testBreakpoint()'"
		var_0_57 = true

		return table.concat(var_15_0)
	end
end

function var_0_9.breakpointTestInfo()
	local var_16_0 = var_0_9.getSpecificFunctionStackLevel(var_0_24.func)

	if type(var_16_0) ~= "number" then
		var_16_0 = 2
	end

	local var_16_1 = var_0_24.source

	if var_0_24.source == nil and var_0_34 ~= nil then
		var_16_1 = var_0_9.getPath(tostring(var_0_34.get_last_source()))
	end

	local var_16_2 = debug.getinfo(var_16_0, "S")
	local var_16_3 = var_0_9.truncatedPath(var_0_9.formatOpath(var_16_2.source), var_0_36)
	local var_16_4 = {}
	local var_16_5 = tostring(var_16_1)

	var_16_4[#var_16_4 + 1] = "\n- BreakPoint Test:"
	var_16_4[#var_16_4 + 1] = "\nUser set lua extension:   ." .. tostring(var_0_20)
	var_16_4[#var_16_4 + 1] = "\nAuto get lua extension:   " .. tostring(var_0_55)

	if var_0_36 and var_0_36 ~= "" then
		var_16_4[#var_16_4 + 1] = "\nUser set truncatedOPath:  " .. var_0_36
	end

	var_16_4[#var_16_4 + 1] = "\nGetInfo:    " .. var_16_2.source
	var_16_4[#var_16_4 + 1] = "\nNormalized: " .. var_16_3
	var_16_4[#var_16_4 + 1] = "\nFormated:   " .. var_16_5

	if var_0_63 and var_0_63 ~= "" then
		var_16_4[#var_16_4 + 1] = "\nBreakpoint: " .. var_0_63
	end

	if not var_0_54 then
		var_16_4[#var_16_4 + 1] = var_0_51 and "\n说明:从lua虚拟机获取到的是绝对路径，Formated使用GetInfo路径。" .. var_0_50 or "\n说明:从lua虚拟机获取到的路径(GetInfo)是相对路径，调试器运行依赖的绝对路径(Formated)是来源于cwd+GetInfo拼接。如Formated路径错误请尝试调整cwd或改变VSCode打开文件夹的位置。也可以在Formated对应的文件下打一个断点，调整直到Formated和Breaks Info中断点路径完全一致。" .. var_0_50
	else
		var_16_4[#var_16_4 + 1] = "\n说明:自动路径(autoPathMode)模式已开启。"

		if var_0_63 and var_0_63 ~= "" then
			if string.find(var_0_63, var_16_5, -1 * string.len(var_16_5), true) then
				if var_0_37 == false then
					var_16_4[#var_16_4 + 1] = "本文件中断点可正常命中。"
					var_16_4[#var_16_4 + 1] = "同名文件中的断点识别(distinguishSameNameFile) 未开启，请确保 VSCode 断点不要存在于同名 lua 文件中。"
				else
					var_16_4[#var_16_4 + 1] = "同名文件中的断点识别(distinguishSameNameFile) 已开启。"
					var_16_4[#var_16_4 + 1] = string.find(var_0_63, var_16_3, 1, true) and "本文件中断点可被正常命中" or "断点可能无法被命中，因为 lua 虚拟机中获得的路径 Normalized 不是断点路径 Breakpoint 的子串。 如有需要，可以在 launch.json 中设置 truncatedOPath 来去除 Normalized 部分路径。"
				end
			else
				var_16_4[#var_16_4 + 1] = "断点未被命中，原因是 Formated 不是 Breakpoint 路径的子串，或者 Formated 和 Breakpoint 文件后缀不一致"
			end
		else
			var_16_4[#var_16_4 + 1] = "如果要进行断点测试，请使用 LuaPanda.testBreakpoint()。"
		end
	end

	return table.concat(var_16_4)
end

function var_0_9.getBaseInfo()
	local var_17_0 = {}

	var_17_0[#var_17_0 + 1] = "Lua Ver:" .. _VERSION .. ((jit and jit.version or nil) and "," .. tostring(jit.version)) .. " | Adapter Ver:" .. tostring(var_0_35) .. " | Debugger Ver:" .. tostring(var_0_8)

	local var_17_2 = ""

	if var_0_34 ~= nil then
		local var_17_3, var_17_4 = var_0_34.sync_getLibVersion()

		var_17_0[#var_17_0 + 1] = " | hookLib Ver:" .. (var_17_4 ~= nil and tostring(var_17_3) .. " for " .. tostring(math.ceil(var_17_4)) or tostring(var_17_3))
		var_17_2 = var_17_2 .. "说明: 已加载 libpdebug 库."
	else
		var_17_2 = var_17_2 .. "说明: 未能加载 libpdebug 库。原因请使用 LuaPanda.doctor() 查看"
	end

	var_17_0[#var_17_0 + 1] = " | supportREPL:" .. tostring(type(var_0_61) == "number" and var_0_61 == 1)
	var_17_0[#var_17_0 + 1] = " | useBase64EncodeString:" .. tostring(var_0_46)
	var_17_0[#var_17_0 + 1] = " | codeEnv:" .. tostring(var_0_32)
	var_17_0[#var_17_0 + 1] = " | distinguishSameNameFile:" .. tostring(var_0_37) .. "\n"
	var_17_0[#var_17_0 + 1] = var_17_2

	if var_0_48 ~= nil and var_0_48 ~= "" then
		var_17_0[#var_17_0 + 1] = "\n" .. var_0_48
	end

	return table.concat(var_17_0)
end

function var_0_9.doctor()
	local var_18_0 = {}

	if var_0_8 ~= var_0_35 then
		var_18_0[#var_18_0 + 1] = "\n- 建议更新版本\nLuaPanda VSCode插件版本是" .. var_0_35 .. ", LuaPanda.lua文件版本是" .. var_0_8 .. "。建议检查并更新到最新版本。"
		var_18_0[#var_18_0 + 1] = "\n更新方式   : https://github.com/Tencent/LuaPanda/blob/master/Docs/Manual/update.md"
		var_18_0[#var_18_0 + 1] = "\nRelease版本: https://github.com/Tencent/LuaPanda/releases"
	end

	if var_0_34 == nil then
		var_18_0[#var_18_0 + 1] = "\n\n- libpdebug 库没有加载\n"

		if var_0_53 then
			if var_0_68 == true then
				var_18_0[#var_18_0 + 1] = "用户使用 LuaPanda.lua 中 clibPath 变量指定了 plibdebug 的位置: " .. var_0_33
				var_18_0[#var_18_0 + 1] = var_0_9.tryRequireClib("libpdebug", var_0_33) and "\n引用成功" or "\n引用错误:" .. var_0_47
			else
				local var_18_1
				local var_18_3

				if var_0_32 == "Darwin" then
					var_18_1 = "/?.so;"
					var_18_3 = "mac"
				elseif var_0_32 == "Linux" then
					var_18_1 = "/?.so;"
					var_18_3 = "linux"
				else
					var_18_1 = "/?.dll;"
					var_18_3 = "win"
				end

				local var_18_5 = var_0_33 .. var_18_3 .. "/x86/" .. (_VERSION == "Lua 5.1" and "501" or "503") .. var_18_1

				var_18_0[#var_18_0 + 1] = "尝试引用x64库: " .. var_0_33 .. var_18_3 .. "/x86_64/" .. (_VERSION == "Lua 5.1" and "501" or "503") .. var_18_1

				if var_0_9.tryRequireClib("libpdebug", var_0_33 .. var_18_3 .. "/x86_64/" .. (_VERSION == "Lua 5.1" and "501" or "503") .. var_18_1) then
					var_18_0[#var_18_0 + 1] = "\n引用成功"
				else
					var_18_0[#var_18_0 + 1] = "\n引用错误:" .. var_0_47
					var_18_0[#var_18_0 + 1] = "\n尝试引用x86库: " .. var_18_5
					var_18_0[#var_18_0 + 1] = var_0_9.tryRequireClib("libpdebug", var_18_5) and "\n引用成功" or "\n引用错误:" .. var_0_47
				end
			end
		else
			var_18_0[#var_18_0 + 1] = "原因是" .. var_0_47
		end
	end

	local var_18_6 = var_0_41

	if var_0_34 ~= nil then
		var_18_6 = var_0_9.getPath(tostring(var_0_34.get_last_source()))
	end

	if not var_0_54 and var_18_6 and var_18_6 ~= "" and not var_0_9.fileExists(var_18_6) then
		var_18_0[#var_18_0 + 1] = "\n\n- 路径存在问题\n"

		local var_18_7 = var_0_9.stringSplit(var_18_6, "/")
		local var_18_8 = false

		for iter_18_0, iter_18_1 in pairs(var_0_9.getBreaks()) do
			if string.find(iter_18_0, var_18_7[#var_18_7], 1, true) then
				var_18_8 = true
				var_18_0[#var_18_0 + 1] = var_0_9.breakpointTestInfo()
				var_18_0[#var_18_0 + 1] = "\nfilepath: " .. iter_18_0
				var_18_0[#var_18_0 + 1] = var_0_51 and "\n说明:从lua虚拟机获取到的是绝对路径，format使用getinfo路径。" or "\n说明:从lua虚拟机获取到的是相对路径，调试器运行依赖的绝对路径(format)是来源于cwd+getinfo拼接。"
				var_18_0[#var_18_0 + 1] = "\nfilepath是VSCode通过获取到的文件正确路径 , 对比format和filepath，调整launch.json中CWD，或改变VSCode打开文件夹的位置。使format和filepath一致即可。\n如果format和filepath路径仅大小写不一致，设置launch.json中 pathCaseSensitivity:false 可忽略路径大小写"
			end
		end

		if var_18_8 == false then
			var_18_0[#var_18_0 + 1] = "\n找不到文件:" .. var_18_6 .. ", 请检查路径是否正确。\n或者在VSCode文件" .. var_18_7[#var_18_7] .. "中打一个断点后，再执行一次doctor命令，查看路径分析结果。"
		end
	end

	if var_0_38 < 1 or var_0_7 < 1 then
		var_18_0[#var_18_0 + 1] = "\n\n- 日志等级\n"

		if var_0_38 < 1 then
			var_18_0[#var_18_0 + 1] = "当前日志等级是" .. var_0_38 .. ", 会产生大量日志，降低调试速度。建议调整launch.json中logLevel:1"
		end

		if var_0_7 < 1 then
			var_18_0[#var_18_0 + 1] = "当前console日志等级是" .. var_0_7 .. ", 过低的日志等级会降低调试速度，建议调整LuaPanda.lua文件头部consoleLogLevel=2"
		end
	end

	if #var_18_0 == 0 then
		var_18_0[#var_18_0 + 1] = "未检测出问题"
	end

	return table.concat(var_18_0)
end

function var_0_9.fileExists(arg_19_0)
	local var_19_0 = io.open(arg_19_0, "r")

	if var_19_0 ~= nil then
		io.close(var_19_0)

		return true
	else
		return false
	end
end

function var_0_9.getInfo()
	local var_20_0 = {}

	var_20_0[#var_20_0 + 1] = "\n- Base Info: \n"
	var_20_0[#var_20_0 + 1] = var_0_9.getBaseInfo()
	var_20_0[#var_20_0 + 1] = "\n\n- User Setting: \n"
	var_20_0[#var_20_0 + 1] = "stopOnEntry:" .. tostring(var_0_52) .. " | "
	var_20_0[#var_20_0 + 1] = "logLevel:" .. var_0_38 .. " | "
	var_20_0[#var_20_0 + 1] = "consoleLogLevel:" .. var_0_7 .. " | "
	var_20_0[#var_20_0 + 1] = "pathCaseSensitivity:" .. tostring(var_0_42) .. " | "
	var_20_0[#var_20_0 + 1] = "attachMode:" .. tostring(var_0_0) .. " | "
	var_20_0[#var_20_0 + 1] = "autoPathMode:" .. tostring(var_0_54) .. " | "
	var_20_0[#var_20_0 + 1] = var_0_53 and "useCHook:true" or "useCHook:false"

	if var_0_38 == 0 or var_0_7 == 0 then
		var_20_0[#var_20_0 + 1] = "\n说明:日志等级过低，会影响执行效率。请调整logLevel和consoleLogLevel值 >= 1"
	end

	var_20_0[#var_20_0 + 1] = "\n\n- Path Info: \n"
	var_20_0[#var_20_0 + 1] = "clibPath: " .. tostring(var_0_33) .. "\n"
	var_20_0[#var_20_0 + 1] = "debugger: " .. var_0_22 .. " | " .. var_0_9.getPath(var_0_22) .. "\n"
	var_20_0[#var_20_0 + 1] = "cwd     : " .. var_0_21 .. "\n"
	var_20_0[#var_20_0 + 1] = var_0_9.breakpointTestInfo()

	if var_0_49 ~= nil and var_0_49 ~= "" then
		var_20_0[#var_20_0 + 1] = "\n" .. var_0_49
	end

	var_20_0[#var_20_0 + 1] = "\n\n- Breaks Info: \nUse 'LuaPanda.getBreaks()' to watch."

	return table.concat(var_20_0)
end

function var_0_9.isInMain()
	return var_0_66
end

function var_0_9.tryRequireClib(arg_22_0, arg_22_1)
	var_0_9.printToVSCode("tryRequireClib search : [" .. arg_22_0 .. "] in " .. arg_22_1)

	package.cpath = package.cpath .. ";" .. arg_22_1

	var_0_9.printToVSCode("package.cpath:" .. package.cpath)

	local var_22_0, var_22_1 = pcall(function()
		var_0_34 = require(arg_22_0)
	end)

	if var_22_0 then
		if type(var_0_34) == "table" and var_0_9.getTableMemberNum(var_0_34) > 0 then
			var_0_9.printToVSCode("tryRequireClib success : [" .. arg_22_0 .. "] in " .. arg_22_1)

			package.cpath = package.cpath

			return true
		else
			var_0_47 = "tryRequireClib fail : require success, but member function num <= 0; [" .. arg_22_0 .. "] in " .. arg_22_1

			var_0_9.printToVSCode(var_0_47)

			var_0_34 = nil
			package.cpath = package.cpath

			return false
		end
	else
		var_0_47 = var_22_1

		var_0_9.printToVSCode("[Require clib error]: " .. var_22_1, 0)
	end

	package.cpath = package.cpath

	return false
end

function var_0_9.revFindString(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = string.reverse(arg_24_0)
	local var_24_1, var_24_2 = string.find(var_24_0, arg_24_1, 1, arg_24_2)

	if var_24_2 == nil then
		return nil
	end

	return string.len(var_24_0) - var_24_2 + 1
end

function var_0_9:revSubString(arg_25_1, arg_25_2)
	local var_25_0 = var_0_9.revFindString(self, arg_25_1, arg_25_2)

	if var_25_0 == nil then
		return nil
	end

	return string.sub(self, var_25_0 + 1, self.length)
end

function var_0_9.stringSplit(arg_26_0, arg_26_1)
	local var_26_0 = {}

	string.gsub(arg_26_0, "[^" .. arg_26_1 .. "]+", function(arg_27_0)
		table.insert(var_26_0, arg_27_0)
	end)

	return var_26_0
end

function var_0_9.setCallbackId(arg_28_0)
	if arg_28_0 ~= nil and arg_28_0 ~= "0" then
		var_0_19 = tostring(arg_28_0)
	end
end

function var_0_9.getCallbackId()
	if var_0_19 == nil then
		var_0_19 = "0"
	end

	var_0_19 = "0"

	return var_0_19
end

function var_0_9.trim(arg_30_0)
	return (string.gsub(arg_30_0, "^%s*(.-)%s*$", "%1"))
end

function var_0_9.getTableMemberNum(arg_31_0)
	local var_31_0 = 0

	if type(arg_31_0) ~= "table" then
		var_0_9.printToVSCode("[debugger Error] getTableMemberNum get " .. tostring(type(arg_31_0)), 2)

		return var_31_0
	end

	for iter_31_0, iter_31_1 in pairs(arg_31_0) do
		var_31_0 = var_31_0 + 1
	end

	return var_31_0
end

function var_0_9.getMsgTable(arg_32_0, arg_32_1)
	arg_32_1 = arg_32_1 or 0

	return {
		cmd = arg_32_0,
		callbackId = arg_32_1,
		info = {}
	}
end

function var_0_9.serializeTable(arg_33_0, arg_33_1)
	return (var_0_10.serializeTable(arg_33_0, arg_33_1))
end

function var_0_9.printToVSCode(arg_34_0, arg_34_1, arg_34_2)
	arg_34_2 = arg_34_2 or 0
	arg_34_1 = arg_34_1 or 0

	if var_0_16 == var_0_13.DISCONNECT or arg_34_1 < var_0_38 then
		return
	end

	local var_34_0 = {}

	var_34_0.callbackId = "0"
	var_34_0.cmd = arg_34_2 == 0 and "output" or arg_34_2 == 1 and "tip" or "debug_console"
	var_34_0.info = {}
	var_34_0.info.logInfo = tostring(arg_34_0)

	var_0_9.sendMsg(var_34_0)
end

function var_0_9.printToConsole(arg_35_0, arg_35_1)
	arg_35_1 = arg_35_1 or 0

	if arg_35_1 < var_0_7 then
		return
	end

	print("[LuaPanda] " .. tostring(arg_35_0))
end

function var_0_9:genUnifiedPath()
	if self == "" or self == nil then
		return ""
	end

	if var_0_42 == false then
		self = string.lower(self)
	end

	self = string.gsub(self, "\\", "/")

	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs((var_0_9.stringSplit(self, "/"))) do
		if iter_36_1 == "." then
			-- block empty
		elseif iter_36_1 == ".." and #var_36_0 >= 1 and var_36_0[#var_36_0]:sub(2, 2) ~= ":" then
			table.remove(var_36_0)
		else
			table.insert(var_36_0, iter_36_1)
		end
	end

	local var_36_1 = table.concat(var_36_0, "/")

	if self:sub(1, 1) == "/" then
		var_36_1 = "/" .. var_36_1
	end

	if var_0_32 == "Windows_NT" then
		if var_0_45 then
			var_36_1 = var_36_1:gsub("^%a:", string.upper)
			var_0_50 = "路径中Windows盘符已转为大写。"
		else
			var_36_1 = var_36_1:gsub("^%a:", string.lower)
			var_0_50 = "路径中Windows盘符已转为小写。"
		end
	end

	return var_36_1
end

function var_0_9.getCacheFormatPath(arg_37_0)
	if arg_37_0 == nil then
		return var_0_70
	end

	return var_0_70[arg_37_0]
end

function var_0_9.setCacheFormatPath(arg_38_0, arg_38_1)
	var_0_70[arg_38_0] = arg_38_1
end

function var_0_9:formatOpath()
	if self:sub(1, 1) == "@" then
		self = self:sub(2)
	end

	if self:sub(1, 2) == "./" then
		self = self:sub(2)
	end

	self = var_0_9.genUnifiedPath(self)

	if var_0_42 == false then
		self = string.lower(self)
	end

	self = (var_0_55 == nil or var_0_55 == "") and (not self:find(var_0_20, -1 * var_0_20:len(), true) and string.gsub(self, "%.", "/") or var_0_9.changePotToSep(self, var_0_20)) or var_0_9.changePotToSep(self, var_0_55)

	return self
end

function var_0_9.sendLuaMemory()
	local var_40_0 = {}

	var_40_0.callbackId = "0"
	var_40_0.cmd = "refreshLuaMemory"
	var_40_0.info = {}
	var_40_0.info.memInfo = tostring((collectgarbage("count")))

	var_0_9.sendMsg(var_40_0)
end

function var_0_9.reGetSock()
	if var_0_31 then
		return true
	end

	if var_0_30 ~= nil then
		pcall(function()
			var_0_30:close()
		end)
	end

	var_0_30 = lua_extension and lua_extension.luasocket and lua_extension.luasocket().tcp()

	if var_0_30 == nil then
		if pcall(function()
			var_0_30 = require("socket.core").tcp()
		end) then
			var_0_9.printToConsole("reGetSock success")
		elseif var_0_6 and pcall(function()
			var_0_30 = var_0_6()
		end) then
			var_0_9.printToConsole("reGetSock custom success")
		else
			var_0_9.printToConsole("[Error] reGetSock fail", 2)

			return false
		end
	else
		var_0_9.printToConsole("reGetSock ue4 success")
	end

	return true
end

function var_0_9.reConnect()
	if var_0_17 == var_0_12.DISCONNECT_HOOK then
		if os.time() - var_0_65 < var_0_1 then
			return 0
		end

		var_0_9.printToConsole("Reconnect !")

		if var_0_30 == nil then
			var_0_9.reGetSock()
		end

		local var_45_0

		if var_0_56 == true and var_0_16 == var_0_13.DISCONNECT then
			if var_0_31 == nil then
				var_0_9.bindServer(var_0_28, var_0_29)
			end

			var_0_30 = var_0_31:accept()
			var_45_0 = var_0_30
		else
			var_0_30:settimeout(var_0_2)

			var_45_0 = var_0_9.sockConnect(var_0_30)
		end

		if var_45_0 then
			var_0_9.printToConsole("reconnect success")
			var_0_9.connectSuccess()

			return 1
		else
			var_0_9.printToConsole("reconnect failed")

			var_0_65 = os.time()

			return 0
		end
	end

	return 1
end

function var_0_9:sendMsg()
	if var_0_46 and self.info ~= nil then
		for iter_46_0, iter_46_1 in ipairs(self.info) do
			if iter_46_1.type == "string" then
				iter_46_1.value = var_0_10.base64encode(iter_46_1.value)
			end
		end
	end

	local var_46_0 = var_0_11.encode(self)

	if var_0_16 == var_0_13.DISCONNECT then
		var_0_9.printToConsole("[debugger error] disconnect but want sendMsg:" .. var_46_0, 2)
		var_0_9.disconnect()

		return
	end

	local var_46_1
	local var_46_2

	if pcall(function()
		var_46_1, var_46_2 = var_0_30:send(var_46_0 .. var_0_14 .. "\n")
	end) and var_46_1 == nil and nil == "closed" then
		var_0_9.disconnect()
	end
end

function var_0_9.dataProcess(arg_48_0)
	var_0_9.printToVSCode("debugger get:" .. arg_48_0)

	local var_48_0 = var_0_11.decode(arg_48_0)

	if var_48_0 == nil then
		var_0_9.printToVSCode("[error] Json is error", 2)

		return
	end

	if var_48_0.callbackId ~= "0" then
		var_0_9.setCallbackId(var_48_0.callbackId)
	end

	if var_48_0.cmd == "continue" then
		if var_48_0.info.isFakeHit == "true" and var_48_0.info.fakeBKPath and var_48_0.info.fakeBKLine then
			var_0_69 = false

			if var_0_34 ~= nil and var_0_34.set_bp_twice_check_res then
				var_0_34.set_bp_twice_check_res(0)
			end

			if var_0_71[var_48_0.info.fakeBKPath] == nil then
				var_0_71[var_48_0.info.fakeBKPath] = {}
			end

			table.insert(var_0_71[var_48_0.info.fakeBKPath], var_48_0.info.fakeBKLine)
		else
			var_0_9.changeRunState(var_0_13.RUN)
		end

		var_0_9.sendMsg((var_0_9.getMsgTable("continue", var_0_9.getCallbackId())))
	elseif var_48_0.cmd == "stopOnStep" then
		var_0_9.changeRunState(var_0_13.STEPOVER)
		var_0_9.sendMsg((var_0_9.getMsgTable("stopOnStep", var_0_9.getCallbackId())))
		var_0_9.changeHookState(var_0_12.ALL_HOOK)
	elseif var_48_0.cmd == "stopOnStepIn" then
		var_0_9.changeRunState(var_0_13.STEPIN)
		var_0_9.sendMsg((var_0_9.getMsgTable("stopOnStepIn", var_0_9.getCallbackId())))
		var_0_9.changeHookState(var_0_12.ALL_HOOK)
	elseif var_48_0.cmd == "stopOnStepOut" then
		var_0_9.changeRunState(var_0_13.STEPOUT)
		var_0_9.sendMsg((var_0_9.getMsgTable("stopOnStepOut", var_0_9.getCallbackId())))
		var_0_9.changeHookState(var_0_12.ALL_HOOK)
	elseif var_48_0.cmd == "setBreakPoint" then
		var_0_9.printToVSCode("dataTable.cmd == setBreakPoint")

		var_0_71 = {}

		local var_48_1 = var_0_9.genUnifiedPath(var_48_0.info.path)

		if var_0_57 then
			var_0_63 = var_48_1
		end

		if var_0_54 then
			local var_48_2 = var_0_9.getFilenameFromPath(var_48_1)

			if var_0_18[var_48_2] == nil then
				var_0_18[var_48_2] = {}
			end

			var_0_18[var_48_2][var_48_1] = var_48_0.info.bks

			for iter_48_0, iter_48_1 in pairs(var_0_18[var_48_2]) do
				if next(iter_48_1) == nil then
					var_0_18[var_48_2][iter_48_0] = nil
				end
			end
		else
			if var_0_18[var_48_1] == nil then
				var_0_18[var_48_1] = {}
			end

			var_0_18[var_48_1][var_48_1] = var_48_0.info.bks

			for iter_48_2, iter_48_3 in pairs(var_0_18[var_48_1]) do
				if next(iter_48_3) == nil then
					var_0_18[var_48_1][iter_48_2] = nil
				end
			end
		end

		for iter_48_4, iter_48_5 in pairs(var_0_18) do
			if next(iter_48_5) == nil then
				var_0_18[iter_48_4] = nil
			end
		end

		if var_0_34 ~= nil then
			var_0_34.sync_breakpoints()
		end

		if var_0_16 ~= var_0_13.WAIT_CMD then
			if var_0_34 == nil then
				local var_48_3, var_48_4 = var_0_9.checkHasBreakpoint(var_0_41)

				if var_48_3 == false then
					if var_48_4 == true then
						var_0_9.changeHookState(var_0_12.MID_HOOK)
					else
						var_0_9.changeHookState(var_0_12.LITE_HOOK)
					end
				else
					var_0_9.changeHookState(var_0_12.ALL_HOOK)
				end
			end
		else
			var_0_9.sendMsg((var_0_9.getMsgTable("setBreakPoint", var_0_9.getCallbackId())))

			return
		end

		var_0_9.sendMsg((var_0_9.getMsgTable("setBreakPoint", var_0_9.getCallbackId())))
		var_0_9.printToVSCode("LuaPanda.getInfo()\n" .. var_0_9.getInfo())
		var_0_9.debugger_wait_msg()
	elseif var_48_0.cmd == "setVariable" then
		if var_0_16 == var_0_13.STOP_ON_ENTRY or var_0_16 == var_0_13.HIT_BREAKPOINT or var_0_16 == var_0_13.STEPOVER_STOP or var_0_16 == var_0_13.STEPIN_STOP or var_0_16 == var_0_13.STEPOUT_STOP then
			local var_48_5 = var_0_9.getMsgTable("setVariable", var_0_9.getCallbackId())
			local var_48_6 = tonumber(var_48_0.info.varRef)
			local var_48_7 = tostring(var_48_0.info.newValue)
			local var_48_8 = true
			local var_48_9 = tostring(var_48_0.info.varName)
			local var_48_10 = string.sub(var_48_7, 1, 1)

			if var_48_10 == string.sub(var_48_7, -1, -1) and (var_48_10 == "'" or var_48_10 == "\"") then
				var_48_7 = string.sub(var_48_7, 2, -2)
				var_48_8 = false
			end

			if var_48_7 == "nil" and var_48_8 == true then
				var_48_7 = nil
				var_48_8 = false
			elseif var_48_7 == "true" and var_48_8 == true then
				var_48_7 = true
				var_48_8 = false
			elseif var_48_7 == "false" and var_48_8 == true then
				var_48_7 = false
				var_48_8 = false
			elseif tonumber(var_48_7) and var_48_8 == true then
				var_48_7 = tonumber(var_48_7)
				var_48_8 = false
			end

			if var_48_0.info.stackId ~= nil and tonumber(var_48_0.info.stackId) ~= nil and tonumber(var_48_0.info.stackId) > 1 then
				var_0_9.curStackId = tonumber(var_48_0.info.stackId)
			else
				var_0_9.printToVSCode("未能获取到堆栈层级，默认使用 this.curStackId;")
			end

			if var_48_6 < 10000 then
				var_48_5.info = var_0_9.createSetValueRetTable(var_48_9, var_48_7, var_48_8, var_0_9.curStackId, var_0_40[var_48_6])
			else
				local var_48_11

				if var_48_6 >= 10000 and var_48_6 < 20000 then
					var_48_11 = "local"
				elseif var_48_6 >= 20000 and var_48_6 < 30000 then
					var_48_11 = "global"
				elseif var_48_6 >= 30000 then
					var_48_11 = "upvalue"
				end

				var_48_5.info = var_0_9.createSetValueRetTable(var_48_9, var_48_7, var_48_8, var_0_9.curStackId, nil, var_48_11)
			end

			var_0_9.sendMsg(var_48_5)
			var_0_9.debugger_wait_msg()
		end
	elseif var_48_0.cmd == "getVariable" then
		if var_0_16 == var_0_13.STOP_ON_ENTRY or var_0_16 == var_0_13.HIT_BREAKPOINT or var_0_16 == var_0_13.STEPOVER_STOP or var_0_16 == var_0_13.STEPIN_STOP or var_0_16 == var_0_13.STEPOUT_STOP then
			local var_48_12 = var_0_9.getMsgTable("getVariable", var_0_9.getCallbackId())
			local var_48_13 = tonumber(var_48_0.info.varRef)

			if var_48_13 < 10000 then
				var_48_12.info = var_0_9.getVariableRef(var_48_0.info.varRef, true)
			elseif var_48_13 >= 10000 and var_48_13 < 20000 then
				if var_48_0.info.stackId ~= nil and tonumber(var_48_0.info.stackId) > 1 then
					var_0_9.curStackId = tonumber(var_48_0.info.stackId)

					if type(var_0_25[var_0_9.curStackId - 1]) ~= "table" or type(var_0_25[var_0_9.curStackId - 1].func) ~= "function" then
						var_0_9.printToVSCode("getVariable getLocal currentCallStack " .. var_0_9.curStackId - 1 .. " Error\n" .. var_0_9.serializeTable(var_0_25, "currentCallStack"), 2)

						var_48_12.info = {}
					else
						var_48_12.info = var_0_9.getVariable(var_0_9.getSpecificFunctionStackLevel(var_0_25[var_0_9.curStackId - 1].func), true)
					end
				end
			elseif var_48_13 >= 20000 and var_48_13 < 30000 then
				var_48_12.info = var_0_9.getGlobalVariable()
			elseif var_48_13 >= 30000 and var_48_0.info.stackId ~= nil and tonumber(var_48_0.info.stackId) > 1 then
				var_0_9.curStackId = tonumber(var_48_0.info.stackId)

				if type(var_0_25[var_0_9.curStackId - 1]) ~= "table" or type(var_0_25[var_0_9.curStackId - 1].func) ~= "function" then
					var_0_9.printToVSCode("getVariable getUpvalue currentCallStack " .. var_0_9.curStackId - 1 .. " Error\n" .. var_0_9.serializeTable(var_0_25, "currentCallStack"), 2)

					var_48_12.info = {}
				else
					var_48_12.info = var_0_9.getUpValueVariable(var_0_25[var_0_9.curStackId - 1].func, true)
				end
			end

			var_0_9.sendMsg(var_48_12)
			var_0_9.debugger_wait_msg()
		end
	elseif var_48_0.cmd == "initSuccess" then
		var_0_46 = var_48_0.info.isNeedB64EncodeStr == "true"
		var_0_20 = var_48_0.info.luaFileExtension

		local var_48_14 = var_48_0.info.TempFilePath

		if var_48_0.info.TempFilePath:sub(-1, -1) == "\\" or var_48_14:sub(-1, -1) == "/" then
			var_48_14 = var_48_14:sub(1, -2)
		end

		var_0_27 = var_48_14
		var_0_21 = var_0_9.genUnifiedPath(var_48_0.info.cwd)
		var_0_38 = tonumber(var_48_0.info.logLevel) or 1
		var_0_54 = var_48_0.info.autoPathMode == "true"

		if var_48_0.info.pathCaseSensitivity == "true" then
			var_0_42 = true
			var_0_36 = var_48_0.info.truncatedOPath or ""
		else
			var_0_42 = false
			var_0_36 = string.lower(var_48_0.info.truncatedOPath or "")
		end

		var_0_37 = var_48_0.info.distinguishSameNameFile == "true"

		if var_0_32 == nil then
			if type(var_48_0.info.OSType) == "string" then
				var_0_32 = var_48_0.info.OSType
			else
				var_0_32 = "Windows_NT"
				var_0_48 = "未能检测出OSType, 可能是node os库未能加载，系统使用默认设置Windows_NT"
			end
		end

		var_0_68 = false

		if var_0_33 == nil then
			if type(var_48_0.info.clibPath) == "string" then
				var_0_33 = var_48_0.info.clibPath
			else
				var_0_33 = ""
				var_0_49 = "未能正确获取libpdebug库所在位置, 可能无法加载libpdebug库。"
			end
		else
			var_0_68 = true
		end

		if tostring(var_48_0.info.useCHook) == "true" and _VERSION ~= "Lua 5.4" then
			var_0_53 = true

			if var_0_68 == true then
				if luapanda_chook ~= nil then
					var_0_34 = luapanda_chook
				elseif not var_0_9.tryRequireClib("libpdebug", var_0_33) then
					var_0_9.printToVSCode("Require clib failed, use Lua to continue debug, use LuaPanda.doctor() for more information.", 1)
				end
			else
				local var_48_15
				local var_48_17

				if var_0_32 == "Darwin" then
					var_48_15 = "/?.so;"
					var_48_17 = "mac"
				elseif var_0_32 == "Linux" then
					var_48_15 = "/?.so;"
					var_48_17 = "linux"
				else
					var_48_15 = "/?.dll;"
					var_48_17 = "win"
				end

				if luapanda_chook ~= nil then
					var_0_34 = luapanda_chook
				elseif not var_0_9.tryRequireClib("libpdebug", var_0_33 .. var_48_17 .. "/x86_64/" .. (_VERSION == "Lua 5.1" and "501" or "503") .. var_48_15) and not var_0_9.tryRequireClib("libpdebug", var_0_33 .. var_48_17 .. "/x86/" .. (_VERSION == "Lua 5.1" and "501" or "503") .. var_48_15) then
					var_0_9.printToVSCode("Require clib failed, use Lua to continue debug, use LuaPanda.doctor() for more information.", 1)
				end
			end
		else
			var_0_53 = false
		end

		var_0_35 = tostring(var_48_0.info.adapterVersion)

		local var_48_19 = var_0_9.getMsgTable("initSuccess", var_0_9.getCallbackId())
		local var_48_20 = 0

		if var_0_34 ~= nil then
			var_48_20 = 1

			local var_48_21 = var_0_9.stringSplit(var_0_8, "%.")

			if var_0_34.sync_lua_debugger_ver then
				var_0_34.sync_lua_debugger_ver(var_48_21[1] * 10000 + var_48_21[2] * 100 + var_48_21[3])
			end

			var_0_34.sync_config(var_0_38, var_0_42 and 1 or 0)
			var_0_34.sync_tempfile_path(var_0_27)
			var_0_34.sync_cwd(var_0_21)
			var_0_34.sync_file_ext(var_0_20)
		end

		var_0_61 = 0

		if var_0_62 ~= nil and type(var_0_62) == "function" and pcall(var_0_62("return 0")) then
			var_0_61 = 1
		end

		var_48_19.info = {
			debuggerVer = tostring(var_0_8),
			UseHookLib = tostring(var_48_20),
			UseLoadstring = tostring(var_0_61),
			isNeedB64EncodeStr = tostring(var_0_46)
		}

		var_0_9.sendMsg(var_48_19)

		var_0_52 = var_48_0.info.stopOnEntry

		if var_48_0.info.stopOnEntry == "true" then
			var_0_9.changeRunState(var_0_13.STOP_ON_ENTRY)
		else
			var_0_9.debugger_wait_msg(1)
			var_0_9.changeRunState(var_0_13.RUN)
		end
	elseif var_48_0.cmd == "getWatchedVariable" then
		local var_48_22 = var_0_9.getMsgTable("getWatchedVariable", var_0_9.getCallbackId())
		local var_48_23 = tonumber(var_48_0.info.stackId)

		if var_0_61 == 1 then
			var_0_9.curStackId = var_48_23
			var_48_22.info = var_0_9.processWatchedExp(var_48_0.info)

			var_0_9.sendMsg(var_48_22)
			var_0_9.debugger_wait_msg()

			return
		else
			local var_48_24 = var_0_9.getWatchedVariable(var_48_0.info.varName, var_48_23, true)

			if var_48_24 ~= nil then
				var_48_22.info = var_48_24
			end

			var_0_9.sendMsg(var_48_22)
			var_0_9.debugger_wait_msg()
		end
	elseif var_48_0.cmd == "stopRun" then
		var_0_9.sendMsg((var_0_9.getMsgTable("stopRun", var_0_9.getCallbackId())))

		if not var_0_56 then
			var_0_9.disconnect()
		end
	elseif var_48_0.cmd == "LuaGarbageCollect" then
		var_0_9.printToVSCode("collect garbage!")
		collectgarbage("collect")
		var_0_9.sendLuaMemory()
		var_0_9.debugger_wait_msg()
	elseif var_48_0.cmd == "runREPLExpression" then
		var_0_9.curStackId = tonumber(var_48_0.info.stackId)

		local var_48_25 = var_0_9.getMsgTable("runREPLExpression", var_0_9.getCallbackId())

		var_48_25.info = var_0_9.processExp(var_48_0.info)

		var_0_9.sendMsg(var_48_25)
		var_0_9.debugger_wait_msg()
	end
end

function var_0_9.createSetValueRetTable(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4, arg_49_5)
	local var_49_0
	local var_49_1 = arg_49_2 == false and {
		{
			variablesReference = 0,
			value = arg_49_1,
			name = arg_49_0,
			type = type(arg_49_1)
		}
	} or var_0_9.getWatchedVariable(tostring(arg_49_1), arg_49_3, true)

	if var_49_1 ~= nil then
		local var_49_2
		local var_49_3 = var_49_1[1].value

		if arg_49_2 == true then
			if tonumber(var_49_1[1].variablesReference) > 0 then
				var_49_2 = var_0_40[tonumber(var_49_1[1].variablesReference)]
			else
				if var_49_1[1].type == "number" then
					var_49_2 = tonumber(var_49_1[1].value)
				end

				if var_49_1[1].type == "string" then
					var_49_2 = tostring(var_49_1[1].value)

					local var_49_4 = string.sub(var_49_2, 1, 1)

					if var_49_4 == string.sub(var_49_2, -1, -1) and (var_49_4 == "'" or var_49_4 == "\"") then
						var_49_2 = string.sub(var_49_2, 2, -2)
						var_49_3 = var_49_2
					end
				end

				if var_49_1[1].type == "boolean" then
					var_49_2 = var_49_1[1].value == "true"
				end

				if var_49_1[1].type == "nil" then
					var_49_2 = nil
				end
			end
		else
			var_49_2 = var_49_1[1].value
		end

		local var_49_5

		if type(arg_49_4) ~= table then
			var_49_5 = var_0_9.setVariableValue(arg_49_0, arg_49_3, var_49_2, arg_49_5)
		else
			arg_49_4[arg_49_0] = var_49_2
			var_49_5 = true
		end

		if var_49_1[1].type == "string" then
			var_49_3 = "\"" .. var_49_3 .. "\""
		end

		var_49_0 = var_49_5 ~= false and var_49_5 ~= nil and {
			success = "true",
			name = var_49_1[1].name,
			type = var_49_1[1].type,
			value = var_49_3,
			variablesReference = tostring(var_49_1[1].variablesReference),
			tip = "变量 " .. arg_49_0 .. " 赋值成功"
		} or {
			success = "false",
			tip = "找不到要设置的变量",
			type = type(var_49_2),
			value = var_49_3
		}
	else
		var_49_0 = {
			success = "false",
			tip = "输入的值无意义"
		}
	end

	return var_49_0
end

function var_0_9.receiveMessage(arg_50_0)
	arg_50_0 = arg_50_0 or var_0_15

	var_0_30:settimeout(arg_50_0)

	if #var_0_43 > 0 then
		table.remove(var_0_43, 1)
		var_0_9.dataProcess(var_0_43[1])

		return true
	end

	if var_0_16 == var_0_13.DISCONNECT then
		var_0_9.disconnect()

		return false
	end

	if var_0_30 == nil then
		var_0_9.printToConsole("[debugger error]接收信息失败  |  reason: socket == nil", 2)

		return
	end

	local var_50_0, var_50_1 = var_0_30:receive()

	if var_50_0 == nil then
		if var_50_1 == "closed" then
			var_0_9.printToConsole("[debugger error]接收信息失败  |  reason:" .. var_50_1, 2)
			var_0_9.disconnect()
		end

		return false
	else
		local var_50_2 = string.sub(var_50_0, 1, -1 * (var_0_14:len() + 1))
		local var_50_3 = string.find(var_50_2, var_0_14, 1, true)

		if var_50_3 == nil then
			var_0_9.dataProcess(var_50_2)
		else
			repeat
				table.insert(var_0_43, (string.sub(var_50_2, 1, var_50_3 - 1)))

				var_50_3 = string.find(string.sub(var_50_2, var_50_3 + var_0_14:len(), -1), var_0_14, 1, true)
			until not var_50_3

			var_0_9.receiveMessage()
		end

		return true
	end
end

function var_0_9.debugger_wait_msg(arg_51_0)
	arg_51_0 = arg_51_0 or var_0_15

	if var_0_16 == var_0_13.WAIT_CMD then
		return (var_0_9.receiveMessage(arg_51_0))
	end

	if var_0_16 == var_0_13.STEPOVER or var_0_16 == var_0_13.STEPIN or var_0_16 == var_0_13.STEPOUT or var_0_16 == var_0_13.RUN then
		var_0_9.receiveMessage(0)

		return
	end

	if var_0_16 == var_0_13.STEPOVER_STOP or var_0_16 == var_0_13.STEPIN_STOP or var_0_16 == var_0_13.STEPOUT_STOP or var_0_16 == var_0_13.HIT_BREAKPOINT or var_0_16 == var_0_13.STOP_ON_ENTRY then
		var_0_9.sendLuaMemory()
		var_0_9.receiveMessage(var_0_15)

		return
	end
end

function var_0_9.getStackTable(arg_52_0)
	local var_52_0 = 0

	var_52_0 = var_0_34 ~= nil and (arg_52_0 or var_0_60) or arg_52_0 or var_0_9.getSpecificFunctionStackLevel(var_0_24.func)

	local var_52_1 = {}
	local var_52_2 = 0

	repeat
		local var_52_3 = debug.getinfo(var_52_0, "SlLnf")

		if var_52_3 == nil then
			break
		end

		if var_52_3.source == "=[C]" then
			break
		end

		local var_52_4 = {
			file = var_0_9.getPath(var_52_3),
			oPath = var_0_9.truncatedPath(var_0_9.formatOpath(var_52_3.source), var_0_36)
		}

		var_52_4.name = "文件名"
		var_52_4.line = tostring(var_52_3.currentline)

		local var_52_5 = var_52_0 - 3

		if var_0_34 ~= nil then
			var_52_5 = var_52_5 + 2
		end

		var_52_4.index = tostring(var_52_5)

		table.insert(var_52_1, var_52_4)
		table.insert(var_0_25, {
			name = var_52_4.file,
			line = var_52_4.line,
			func = var_52_3.func,
			realLy = var_52_0
		})

		if var_52_2 == 0 then
			var_52_2 = var_52_0
		end

		var_52_0 = var_52_0 + 1
	until var_52_3 == nil

	return var_52_1, var_52_2
end

function var_0_9:changePotToSep(arg_53_1)
	local var_53_0 = self:find(arg_53_1, -1 * arg_53_1:len(), true)

	if var_53_0 then
		self = self:sub(1, var_53_0 - 1):gsub("%.", "/") .. arg_53_1
	end

	return self
end

function var_0_9.truncatedPath(arg_54_0, arg_54_1)
	if arg_54_0 and arg_54_0 ~= "" and arg_54_1 and arg_54_1 ~= "" then
		local var_54_0, var_54_1 = string.find(arg_54_0, arg_54_1)

		if var_54_1 then
			arg_54_0 = string.sub(arg_54_0, var_54_1 + 1)
		end
	end

	return arg_54_0
end

function var_0_9:getPath()
	local var_55_0 = self

	if type(self) == "table" then
		var_55_0 = self.source
	end

	local var_55_1 = var_0_9.getCacheFormatPath(var_55_0)

	if var_55_1 ~= nil and type(var_55_1) == "string" then
		do return var_55_1 end

		if var_55_0:sub(1, 1) == "@" then
			var_55_0 = var_55_0:sub(2)
		end

		if var_55_0:sub(1, 2) == "./" then
			var_55_0 = var_55_0:sub(3)
		end

		if var_0_4 then
			var_55_0 = (var_0_55 == nil or var_0_55 == "") and (not var_55_0:find(var_0_20, -1 * var_0_20:len(), true) and string.gsub(var_55_0, "%.", "/") or var_0_9.changePotToSep(var_55_0, var_0_20)) or var_0_9.changePotToSep(var_55_0, var_0_55)
		end

		if var_0_20 ~= "" then
			if string.find(var_0_20, "%%%d") then
				var_55_0 = string.gsub(var_55_0, "%.[%w%.]+$", var_0_20)
			else
				var_55_0 = string.gsub(var_55_0, "%.[%w%.]+$", "")
				var_55_0 = var_55_0 .. "." .. var_0_20
			end
		end

		if not var_0_54 then
			if var_55_0:sub(1, 1) ~= "/" then
				if var_55_0:sub(1, 2):match("^%a:") then
					var_0_51 = true

					goto label_55_0
				end
			end

			var_0_51 = false

			if var_0_21 ~= "" and string.find(var_55_0, var_0_21, 1, true) == nil then
				var_55_0 = var_0_21 .. "/" .. var_55_0
			end
		end
	end

	::label_55_0::

	local var_55_2 = var_0_9.genUnifiedPath(var_55_0)

	if var_0_54 then
		var_55_2 = var_0_9.getFilenameFromPath(var_55_2)
	end

	var_0_9:setCacheFormatPath(var_55_2)

	return var_55_2
end

function var_0_9.getFilenameFromPath(arg_56_0)
	if arg_56_0 == nil then
		return ""
	end

	return string.match(arg_56_0, "([^/]*)$")
end

function var_0_9.getCurrentFunctionStackLevel()
	repeat
		local var_57_0 = debug.getinfo(2, "S")

		if var_57_0 ~= nil and (var_57_0.source == var_0_22 or var_57_0.source == var_0_23) == false then
			return 2 - 1
		end
	until not var_57_0

	return 0
end

function var_0_9.getSpecificFunctionStackLevel(arg_58_0)
	repeat
		local var_58_0 = debug.getinfo(2, "f")

		if var_58_0 ~= nil and var_58_0.func == arg_58_0 then
			return 2 - 1
		end
	until not var_58_0

	return 0
end

function var_0_9.checkCurrentLayerisLua(arg_59_0)
	local var_59_0 = debug.getinfo(arg_59_0, "S")

	if var_59_0 == nil then
		return nil
	end

	var_59_0.source = var_0_9.genUnifiedPath(var_59_0.source)

	if var_59_0 ~= nil then
		for iter_59_0, iter_59_1 in pairs(var_59_0) do
			if iter_59_0 == "what" then
				if iter_59_1 == "C" then
					return false
				else
					return true
				end
			end
		end
	end

	return nil
end

function var_0_9.checkRealHitBreakpoint(arg_60_0, arg_60_1)
	if arg_60_0 and var_0_71[arg_60_0] then
		for iter_60_0, iter_60_1 in ipairs(var_0_71[arg_60_0]) do
			if tonumber(iter_60_1) == tonumber(arg_60_1) then
				var_0_9.printToVSCode("cache hit bp in same name file.  source:" .. tostring(arg_60_0) .. " line:" .. tostring(arg_60_1))

				return false
			end
		end
	end

	return true
end

function var_0_9.isHitBreakpoint(arg_61_0, arg_61_1, arg_61_2)
	if var_0_18[arg_61_0] then
		local var_61_0

		for iter_61_0, iter_61_1 in pairs(var_0_18[arg_61_0]) do
			var_0_63 = iter_61_0

			local var_61_1 = false

			for iter_61_2, iter_61_3 in ipairs(iter_61_1) do
				if tonumber(iter_61_3.line) == tonumber(arg_61_2) then
					var_61_1 = true
					cur_node = iter_61_3
					var_0_63 = iter_61_0

					break
				end
			end

			if var_61_1 then
				if var_61_0 == nil then
					var_61_0 = var_0_9.formatOpath(arg_61_1)
					var_61_0 = var_0_9.truncatedPath(var_61_0, var_0_36)
				end

				if not var_0_37 or string.match(iter_61_0, var_61_0) and var_0_9.checkRealHitBreakpoint(arg_61_1, arg_61_2) then
					if cur_node.type == "0" then
						return (var_0_9.IsMeetCondition(cur_node.condition))
					elseif cur_node.type == "1" then
						var_0_9.printToVSCode("[LogPoint Output]: " .. cur_node.logMessage, 2, 2)

						return false
					else
						return true
					end
				end
			end
		end
	else
		var_0_57 = false
		var_0_63 = ""
	end

	return false
end

function var_0_9.IsMeetCondition(arg_62_0)
	var_0_25 = {}
	var_0_40 = {}
	var_0_39 = 1

	if var_0_34 then
		var_0_9.getStackTable(4)
	else
		var_0_9.getStackTable()
	end

	var_0_9.curStackId = 2

	local var_62_0 = var_0_9.processWatchedExp({
		varName = arg_62_0
	})
	local var_62_1 = false

	xpcall(function()
		var_62_1 = var_62_0[1].isSuccess == "true" and not (var_62_0[1].value == "nil" or var_62_0[1].value == "false" and var_62_0[1].type == "boolean") or false
	end, function()
		var_62_1 = false
	end)

	return false
end

function var_0_9.BP()
	var_0_9.printToConsole("BP()")

	if var_0_34 == nil then
		if var_0_17 == var_0_12.DISCONNECT_HOOK then
			var_0_9.printToConsole("BP() but NO HOOK")

			return
		end

		local var_65_0, var_65_1 = coroutine.running()

		if ((_VERSION == "Lua 5.1" or nil) and var_65_0 == nil) == true then
			var_0_9.printToConsole("BP() in main")
		else
			var_0_9.printToConsole("BP() in coroutine")
			debug.sethook(var_65_0, var_0_9.debug_hook, "lrc")
		end

		var_0_26 = true
	else
		if var_0_34.get_libhook_state() == var_0_12.DISCONNECT_HOOK then
			var_0_9.printToConsole("BP() but NO C HOOK")

			return
		end

		var_0_34.sync_bp_hit(1)
	end

	var_0_9.changeHookState(var_0_12.ALL_HOOK)

	return true
end

function var_0_9.checkHasBreakpoint(arg_66_0)
	local var_66_1 = next(var_0_18) ~= nil

	if arg_66_0 ~= nil then
		return var_0_18[arg_66_0] ~= nil, var_66_1
	else
		return var_66_1
	end
end

function var_0_9.checkfuncHasBreakpoint(arg_67_0, arg_67_1, arg_67_2)
	if var_0_18[arg_67_2] == nil then
		return false
	end

	arg_67_0 = tonumber(arg_67_0)
	arg_67_1 = tonumber(arg_67_1)

	if arg_67_1 <= arg_67_0 then
		return true
	end

	if var_0_9.getTableMemberNum(var_0_18[arg_67_2]) <= 0 then
		return false
	else
		for iter_67_0, iter_67_1 in pairs(var_0_18[arg_67_2]) do
			for iter_67_2, iter_67_3 in ipairs(iter_67_1) do
				if arg_67_0 < tonumber(iter_67_3.line) and arg_67_1 >= tonumber(iter_67_3.line) then
					return true
				end
			end
		end
	end

	return false
end

function var_0_9.debug_hook(arg_68_0, arg_68_1)
	if var_0_9.reConnect() == 0 then
		return
	end

	if var_0_38 == 0 then
		var_0_9.printToVSCode((table.concat({
			"-----enter debug_hook-----\n",
			"event:",
			arg_68_0,
			"  line:",
			tostring(arg_68_1),
			" currentHookState:",
			var_0_17,
			" currentRunState:",
			var_0_16
		})))
	end

	if var_0_17 == var_0_12.LITE_HOOK then
		local var_68_0 = os.time()

		if var_68_0 - var_0_67 > 1 then
			var_0_9.debugger_wait_msg(0)

			var_0_67 = var_68_0
		end

		return
	end

	local var_68_1
	local var_68_2, var_68_3 = coroutine.running()

	if _VERSION == "Lua 5.1" then
		var_68_3 = var_68_2 == nil
	end

	var_0_66 = var_68_3
	var_68_1 = var_68_3 == true and debug.getinfo(2, "Slf") or debug.getinfo(var_68_2, 2, "Slf")
	var_68_1.event = arg_68_0

	var_0_9.real_hook_process(var_68_1)
end

function var_0_9:real_hook_process()
	local var_69_0 = false
	local var_69_1 = self.event

	if (self.source == var_0_22 or self.source == var_0_23) == true then
		return
	end

	if var_0_16 == var_0_13.RUN or var_0_16 == var_0_13.STEPOVER or var_0_16 == var_0_13.STEPIN or var_0_16 == var_0_13.STEPOUT then
		local var_69_2 = os.time()

		if var_69_2 - var_0_67 > 1 then
			var_0_9.debugger_wait_msg(0)

			var_0_67 = var_69_2
		end
	end

	if self.source == "=[C]" then
		var_0_9.printToVSCode("current method is C")

		return
	end

	if self.source == "temp buffer" then
		var_0_9.printToVSCode("current method is in temp buffer")

		return
	end

	if self.source == "chunk" then
		var_0_9.printToVSCode("current method is in chunk")

		return
	end

	if self.short_src:match("%[string \"") and self.source:match("[\n;=]") then
		var_0_9.printToVSCode("hook jump Code String!")

		var_69_0 = true
	end

	if var_69_0 == false then
		self.orininal_source = self.source
		self.source = var_0_9.getPath(self)
	end

	if var_0_24.currentline == self.currentline and var_0_24.source == self.source and var_0_24.func == self.func and var_0_24.event == var_69_1 then
		var_0_9.printToVSCode("run twice")
	end

	if var_69_0 == false then
		var_0_24 = self
		var_0_24.event = var_69_1
		var_0_41 = self.source
	end

	if var_0_38 == 0 and var_69_0 == false then
		local var_69_3 = {
			"[lua hook] event:",
			tostring(var_69_1),
			" currentRunState:",
			tostring(var_0_16),
			" currentHookState:",
			tostring(var_0_17),
			" jumpFlag:",
			tostring(var_69_0)
		}

		for iter_69_0, iter_69_1 in pairs(self) do
			table.insert(var_69_3, tostring(iter_69_0))
			table.insert(var_69_3, ":")
			table.insert(var_69_3, tostring(iter_69_1))
			table.insert(var_69_3, " ")
		end

		var_0_9.printToVSCode((table.concat(var_69_3)))
	end

	local var_69_4 = false

	if tostring(var_69_1) == "line" and var_69_0 == false and (var_0_16 == var_0_13.RUN or var_0_16 == var_0_13.STEPOVER or var_0_16 == var_0_13.STEPIN or var_0_16 == var_0_13.STEPOUT) then
		var_69_4 = var_0_9.isHitBreakpoint(self.source, self.orininal_source, self.currentline) or var_0_26

		if var_69_4 == true then
			var_0_9.printToVSCode("HitBreakpoint!")

			var_0_58 = 0
			var_0_59 = 0

			var_0_9.changeRunState(var_0_13.HIT_BREAKPOINT)

			var_0_69 = true

			if var_0_26 then
				var_0_26 = false

				var_0_9.SendMsgWithStack("stopOnCodeBreakpoint")
			else
				var_0_9.SendMsgWithStack("stopOnBreakpoint")

				if var_0_69 == false then
					var_69_4 = false

					var_0_9.changeRunState(var_0_16)

					var_0_58 = var_0_58
					var_0_59 = var_0_59
				end
			end
		end
	end

	if var_69_4 == true then
		return
	end

	if var_0_16 == var_0_13.STEPOVER then
		if var_69_1 == "line" and var_0_58 <= 0 and var_69_0 == false then
			var_0_58 = 0

			var_0_9.changeRunState(var_0_13.STEPOVER_STOP)
			var_0_9.SendMsgWithStack("stopOnStep")
		elseif var_69_1 == "return" or var_69_1 == "tail return" then
			if var_0_58 ~= 0 then
				var_0_58 = var_0_58 - 1
			end
		elseif var_69_1 == "call" then
			var_0_58 = var_0_58 + 1
		end
	elseif var_0_16 == var_0_13.STOP_ON_ENTRY then
		if var_69_1 == "line" and var_69_0 == false then
			var_0_9.SendMsgWithStack("stopOnEntry")
		end
	elseif var_0_16 == var_0_13.STEPIN then
		if var_69_1 == "line" and var_69_0 == false then
			var_0_9.changeRunState(var_0_13.STEPIN_STOP)
			var_0_9.SendMsgWithStack("stopOnStepIn")
		end
	elseif var_0_16 == var_0_13.STEPOUT then
		if var_69_0 == false and var_0_59 <= -1 then
			var_0_59 = 0

			var_0_9.changeRunState(var_0_13.STEPOUT_STOP)
			var_0_9.SendMsgWithStack("stopOnStepOut")
		end

		if var_69_1 == "return" or var_69_1 == "tail return" then
			var_0_59 = var_0_59 - 1
		elseif var_69_1 == "call" then
			var_0_59 = var_0_59 + 1
		end
	end

	if var_0_34 == nil and var_0_16 == var_0_13.RUN and var_69_0 == false and var_0_17 ~= var_0_12.DISCONNECT_HOOK then
		local var_69_5, var_69_6 = var_0_9.checkHasBreakpoint(var_0_41)

		if var_69_5 == false then
			if var_69_6 == true then
				var_0_9.changeHookState(var_0_12.MID_HOOK)
			else
				var_0_9.changeHookState(var_0_12.LITE_HOOK)
			end
		elseif var_0_9.checkfuncHasBreakpoint(var_0_24.linedefined, var_0_24.lastlinedefined, var_0_41) then
			var_0_9.changeHookState(var_0_12.ALL_HOOK)
		else
			var_0_9.changeHookState(var_0_12.MID_HOOK)
		end

		if (var_69_1 == "return" or var_69_1 == "tail return") and var_0_17 == var_0_12.MID_HOOK then
			var_0_9.changeHookState(var_0_12.ALL_HOOK)
		end
	end
end

function var_0_9.SendMsgWithStack(arg_70_0)
	local var_70_1

	var_0_9.getMsgTable(arg_70_0).stack, var_70_1 = var_0_9.getStackTable()

	if var_70_1 ~= 0 then
		var_0_24.func = debug.getinfo(var_70_1 - 1, "f").func
	end

	var_0_9.sendMsg((var_0_9.getMsgTable(arg_70_0)))
	var_0_9.debugger_wait_msg()
end

function var_0_9.changeHookState(arg_71_0)
	if var_0_34 == nil and var_0_17 == arg_71_0 then
		return
	end

	var_0_9.printToConsole("change hook state :" .. arg_71_0)

	if arg_71_0 ~= var_0_12.DISCONNECT_HOOK then
		var_0_9.printToVSCode("change hook state : " .. arg_71_0)
	end

	var_0_17 = arg_71_0

	if arg_71_0 == var_0_12.DISCONNECT_HOOK then
		if var_0_0 == true then
			if var_0_34 then
				var_0_34.lua_set_hookstate(var_0_12.DISCONNECT_HOOK)
			else
				debug.sethook(var_0_9.debug_hook, "r")
			end
		elseif var_0_34 then
			var_0_34.endHook()
		else
			debug.sethook()
		end
	elseif arg_71_0 == var_0_12.LITE_HOOK then
		if var_0_34 then
			var_0_34.lua_set_hookstate(var_0_12.LITE_HOOK)
		else
			debug.sethook(var_0_9.debug_hook, "r")
		end
	elseif arg_71_0 == var_0_12.MID_HOOK then
		if var_0_34 then
			var_0_34.lua_set_hookstate(var_0_12.MID_HOOK)
		else
			debug.sethook(var_0_9.debug_hook, "rc")
		end
	elseif arg_71_0 == var_0_12.ALL_HOOK then
		if var_0_34 then
			var_0_34.lua_set_hookstate(var_0_12.ALL_HOOK)
		else
			debug.sethook(var_0_9.debug_hook, "lrc")
		end
	end

	if var_0_34 == nil then
		var_0_9.changeCoroutineHookState()
	end
end

function var_0_9.changeRunState(arg_72_0, arg_72_1)
	var_0_9.printToConsole("changeRunState :" .. arg_72_0 .. " | from:" .. (arg_72_1 == 1 and "libc" or "lua"))

	if arg_72_0 ~= var_0_13.DISCONNECT and arg_72_0 ~= var_0_13.WAIT_CMD then
		var_0_9.printToVSCode("changeRunState :" .. arg_72_0 .. " | from:" .. var_72_0)
	end

	if var_0_34 ~= nil and arg_72_1 ~= 1 then
		var_0_34.lua_set_runstate(arg_72_0)
	end

	var_0_16 = arg_72_0
	var_0_25 = {}
	var_0_40 = {}
	var_0_39 = 1
end

function var_0_9.changeCoroutineHookState(arg_73_0)
	arg_73_0 = arg_73_0 or var_0_17

	var_0_9.printToConsole("change [Coroutine] HookState: " .. tostring(arg_73_0))

	for iter_73_0, iter_73_1 in pairs(var_0_44) do
		if coroutine.status(iter_73_1) == "dead" then
			table.remove(var_0_44, iter_73_0)
		elseif arg_73_0 == var_0_12.DISCONNECT_HOOK then
			if var_0_0 == true then
				debug.sethook(iter_73_1, var_0_9.debug_hook, "r")
			else
				debug.sethook(iter_73_1, var_0_9.debug_hook, "")
			end
		elseif arg_73_0 == var_0_12.LITE_HOOK then
			debug.sethook(iter_73_1, var_0_9.debug_hook, "r")
		elseif arg_73_0 == var_0_12.MID_HOOK then
			debug.sethook(iter_73_1, var_0_9.debug_hook, "rc")
		elseif arg_73_0 == var_0_12.ALL_HOOK then
			debug.sethook(iter_73_1, var_0_9.debug_hook, "lrc")
		end
	end
end

function var_0_9.clearEnv()
	if var_0_9.getTableMemberNum(var_0_72) > 0 then
		var_0_72 = setmetatable({}, getmetatable(var_0_72))
	end
end

function var_0_9.showEnv()
	return var_0_72
end

function var_0_9:findTableVar(arg_76_1)
	if type(self) ~= "table" or type(arg_76_1) ~= "table" then
		return nil
	end

	local var_76_0 = 2
	local var_76_1 = arg_76_1

	repeat
		if self[var_76_0] ~= nil then
			local var_76_3

			xpcall(function()
				var_76_3 = var_76_1[tonumber(self[var_76_0])]
			end, function()
				var_76_3 = nil
			end)

			if nil == nil then
				xpcall(function()
					var_76_1 = var_76_1[tostring(self[var_76_0])]
				end, function()
					var_76_1 = nil
				end)
			else
				var_76_1 = nil
			end

			var_76_0 = var_76_0 + 1

			if var_76_1 == nil then
				return nil
			end
		else
			var_76_2 = true
		end
	until false == true

	return var_76_1
end

function var_0_9.createWatchedVariableInfo(arg_81_0, arg_81_1)
	local var_81_0 = {
		name = arg_81_0,
		type = tostring(type(arg_81_1))
	}

	xpcall(function()
		var_81_0.value = tostring(arg_81_1)
	end, function()
		var_81_0.value = tostring(type(arg_81_1)) .. " [value can't trans to string]"
	end)

	var_81_0.variablesReference = "0"

	if var_81_0.type == "table" or var_81_0.type == "function" or var_81_0.type == "userdata" then
		var_81_0.variablesReference = var_0_39
		var_0_40[var_0_39] = arg_81_1
		var_0_39 = var_0_39 + 1

		if var_81_0.type == "table" then
			var_81_0.value = var_0_9.getTableMemberNum(arg_81_1) .. " Members " .. var_81_0.value
		end
	elseif var_81_0.type == "string" then
		var_81_0.value = "\"" .. arg_81_1 .. "\""
	end

	return var_81_0
end

function var_0_9.setGlobal(arg_84_0, arg_84_1)
	_G[arg_84_0] = arg_84_1

	var_0_9.printToVSCode("[setVariable success] 已设置  _G." .. arg_84_0 .. " = " .. tostring(arg_84_1))

	return true
end

function var_0_9.setUpvalue(arg_85_0, arg_85_1, arg_85_2, arg_85_3)
	local var_85_0 = false

	for iter_85_0, iter_85_1 in ipairs((var_0_9.getUpValueVariable(var_0_25[arg_85_2 - 1].func, true))) do
		if iter_85_1.name == arg_85_0 then
			if #arg_85_3 > 0 and type(iter_85_1) == "table" then
				if var_0_9.findTableVar(arg_85_3, var_0_40[iter_85_1.variablesReference]) ~= nil then
					local var_85_1 = debug.setupvalue(var_0_25[arg_85_2 - 1].func, iter_85_0, arg_85_1)

					if var_85_1 == arg_85_0 then
						var_0_9.printToConsole("[setVariable success1] 已设置 upvalue " .. arg_85_0 .. " = " .. tostring(arg_85_1))

						var_85_0 = true
					else
						var_0_9.printToConsole("[setVariable error1] 未能设置 upvalue " .. arg_85_0 .. " = " .. tostring(arg_85_1) .. " , 返回结果: " .. tostring(var_85_1))
					end

					return var_85_0
				end
			else
				local var_85_2 = debug.setupvalue(var_0_25[arg_85_2 - 1].func, iter_85_0, arg_85_1)

				if var_85_2 == arg_85_0 then
					var_0_9.printToConsole("[setVariable success] 已设置 upvalue " .. arg_85_0 .. " = " .. tostring(arg_85_1))

					var_85_0 = true
				else
					var_0_9.printToConsole("[setVariable error] 未能设置 upvalue " .. arg_85_0 .. " = " .. tostring(arg_85_1) .. " , 返回结果: " .. tostring(var_85_2))
				end

				return var_85_0
			end
		end
	end

	return var_85_0
end

function var_0_9.setLocal(arg_86_0, arg_86_1, arg_86_2, arg_86_3)
	local var_86_0 = tonumber(arg_86_3)
	local var_86_1, var_86_2 = var_0_9.getVariable(nil, true, (var_86_0 or nil) and (var_86_0 - 2 or 0))
	local var_86_3 = false

	for iter_86_0, iter_86_1 in ipairs(var_86_1) do
		if iter_86_1.name == arg_86_0 then
			if #arg_86_2 > 0 and type(iter_86_1) == "table" then
				if var_0_9.findTableVar(arg_86_2, var_0_40[iter_86_1.variablesReference]) ~= nil then
					local var_86_4 = debug.setlocal(var_86_2, var_86_1[iter_86_0].index, arg_86_1)

					if var_86_4 == arg_86_0 then
						var_0_9.printToConsole("[setVariable success1] 已设置 local " .. arg_86_0 .. " = " .. tostring(arg_86_1))

						var_86_3 = true
					else
						var_0_9.printToConsole("[setVariable error1] 未能设置 local " .. arg_86_0 .. " = " .. tostring(arg_86_1) .. " , 返回结果: " .. tostring(var_86_4))
					end

					return var_86_3
				end
			else
				local var_86_5 = debug.setlocal(var_86_2, var_86_1[iter_86_0].index, arg_86_1)

				if var_86_5 == arg_86_0 then
					var_0_9.printToConsole("[setVariable success] 已设置 local " .. arg_86_0 .. " = " .. tostring(arg_86_1))

					var_86_3 = true
				else
					var_0_9.printToConsole("[setVariable error] 未能设置 local " .. arg_86_0 .. " = " .. tostring(arg_86_1) .. " , 返回结果: " .. tostring(var_86_5))
				end

				return var_86_3
			end
		end
	end

	return var_86_3
end

function var_0_9:setVariableValue(arg_87_1, arg_87_2, arg_87_3)
	var_0_9.printToConsole("setVariableValue | varName:" .. tostring(self) .. " stackId:" .. tostring(arg_87_1) .. " newValue:" .. tostring(arg_87_2) .. " limit:" .. tostring(arg_87_3))

	if tostring(self) == nil or tostring(self) == "" then
		var_0_9.printToConsole("[setVariable Error] 被赋值的变量名为空", 2)
		var_0_9.printToVSCode("[setVariable Error] 被赋值的变量名为空", 2)

		return false
	end

	local var_87_0 = {}

	if self:match("%.") then
		var_87_0 = var_0_9.stringSplit(self, "%.")

		if type(var_87_0) ~= "table" or #var_87_0 < 1 then
			return false
		end

		self = var_87_0[1]
	end

	if arg_87_3 == "local" then
		return (var_0_9.setLocal(self, arg_87_2, var_87_0, arg_87_1))
	elseif arg_87_3 == "upvalue" then
		return (var_0_9.setUpvalue(self, arg_87_2, arg_87_1, var_87_0))
	elseif arg_87_3 == "global" then
		return (var_0_9.setGlobal(self, arg_87_2))
	else
		local var_87_1 = var_0_9.setLocal(self, arg_87_2, var_87_0, arg_87_1) or var_0_9.setUpvalue(self, arg_87_2, arg_87_1, var_87_0) or var_0_9.setGlobal(self, arg_87_2)

		var_0_9.printToConsole("set Value res :" .. tostring(var_87_1))

		return var_87_1
	end
end

function var_0_9:getWatchedVariable(arg_88_1, arg_88_2)
	var_0_9.printToConsole("getWatchedVariable | varName:" .. tostring(self) .. " stackId:" .. tostring(arg_88_1) .. " isFormatVariable:" .. tostring(arg_88_2))

	if tostring(self) == nil or tostring(self) == "" then
		return nil
	end

	if type(var_0_25[arg_88_1 - 1]) ~= "table" or type(var_0_25[arg_88_1 - 1].func) ~= "function" then
		var_0_9.printToVSCode("getWatchedVariable currentCallStack " .. arg_88_1 - 1 .. " Error\n" .. var_0_9.serializeTable(var_0_25, "currentCallStack"), 2)

		return nil
	end

	local var_88_0 = {}

	if self:match("%.") then
		var_88_0 = var_0_9.stringSplit(self, "%.")

		if type(var_88_0) ~= "table" or #var_88_0 < 1 then
			return nil
		end

		self = var_88_0[1]
	end

	local var_88_1 = {}
	local var_88_2 = {}

	table.insert(var_88_2, (var_0_9.getVariable(var_0_9.getSpecificFunctionStackLevel(var_0_25[arg_88_1 - 1].func), arg_88_2)))
	table.insert(var_88_2, (var_0_9.getUpValueVariable(var_0_25[arg_88_1 - 1].func, arg_88_2)))

	for iter_88_0, iter_88_1 in ipairs(var_88_2) do
		for iter_88_2, iter_88_3 in ipairs(iter_88_1) do
			if iter_88_3.name == self then
				if #var_88_0 > 0 and type(iter_88_3) == "table" then
					local var_88_3 = var_0_9.findTableVar(var_88_0, var_0_40[iter_88_3.variablesReference])

					if var_88_3 ~= nil then
						if arg_88_2 then
							table.insert(var_88_1, (var_0_9:createWatchedVariableInfo(var_88_3)))

							return var_88_1
						else
							return var_88_3.value
						end
					end
				elseif arg_88_2 then
					table.insert(var_88_1, iter_88_3)

					return var_88_1
				else
					return iter_88_3.value
				end
			end
		end
	end

	if _G[self] ~= nil then
		if #var_88_0 > 0 and type(_G[self]) == "table" then
			local var_88_4 = var_0_9.findTableVar(var_88_0, _G[self])

			if var_88_4 ~= nil then
				if arg_88_2 then
					table.insert(var_88_1, (var_0_9:createWatchedVariableInfo(var_88_4)))

					return var_88_1
				else
					return var_88_4
				end
			end
		elseif arg_88_2 then
			table.insert(var_88_1, (var_0_9.createWatchedVariableInfo(self, _G[self])))

			return var_88_1
		else
			return _G[self]
		end
	end

	var_0_9.printToConsole("getWatchedVariable not find variable")

	return nil
end

function var_0_9.getVariableRef(arg_89_0)
	local var_89_0 = tonumber(arg_89_0)
	local var_89_1 = {}

	if tostring(type(var_0_40[var_89_0])) == "table" then
		for iter_89_0, iter_89_1 in pairs(var_0_40[var_89_0]) do
			local var_89_2 = {}

			var_89_2.name = type(iter_89_0) == "string" and "\"" .. tostring(iter_89_0) .. "\"" or tostring(iter_89_0)
			var_89_2.type = tostring(type(iter_89_1))

			xpcall(function()
				var_89_2.value = tostring(iter_89_1)
			end, function()
				var_89_2.value = tostring(type(iter_89_1)) .. " [value can't trans to string]"
			end)

			var_89_2.variablesReference = "0"

			if var_89_2.type == "table" or var_89_2.type == "function" or var_89_2.type == "userdata" then
				var_89_2.variablesReference = var_0_39
				var_0_40[var_0_39] = iter_89_1
				var_0_39 = var_0_39 + 1

				if var_89_2.type == "table" then
					var_89_2.value = var_0_9.getTableMemberNum(iter_89_1) .. " Members " .. ((not var_89_2.value or nil) and "")
				end
			elseif var_89_2.type == "string" then
				var_89_2.value = "\"" .. iter_89_1 .. "\""
			end

			table.insert(var_89_1, var_89_2)
		end

		local var_89_4 = getmetatable(var_0_40[var_89_0])

		if var_89_4 ~= nil and type(var_89_4) == "table" then
			local var_89_5 = {}

			var_89_5.name = "_Metatable_"
			var_89_5.type = tostring(type(var_89_4))

			xpcall(function()
				var_89_5.value = "元表 " .. tostring(var_89_4)
			end, function()
				var_89_5.value = "元表 [value can't trans to string]"
			end)

			var_89_5.variablesReference = var_0_39
			var_0_40[var_0_39] = var_89_4
			var_0_39 = var_0_39 + 1

			table.insert(var_89_1, var_89_5)
		end
	elseif tostring(type(var_0_40[var_89_0])) == "function" then
		var_89_1 = var_0_9.getUpValueVariable(var_0_40[var_89_0], true)
	elseif tostring(type(var_0_40[var_89_0])) == "userdata" then
		local var_89_6 = getmetatable(var_0_40[var_89_0])

		if var_89_6 ~= nil and type(var_89_6) == "table" then
			local var_89_7 = {}

			var_89_7.name = "_Metatable_"
			var_89_7.type = tostring(type(var_89_6))

			xpcall(function()
				var_89_7.value = "元表 " .. tostring(var_89_6)
			end, function()
				var_89_7.value = "元表 [value can't trans to string]"
			end)

			var_89_7.variablesReference = var_0_39
			var_0_40[var_0_39] = var_89_6
			var_0_39 = var_0_39 + 1

			table.insert(var_89_1, var_89_7)

			if var_0_5 and var_89_6.__pairs ~= nil and type(var_89_6.__pairs) == "function" then
				for iter_89_2, iter_89_3 in pairs(var_0_40[var_89_0]) do
					local var_89_8 = {
						name = tostring(iter_89_2),
						type = tostring(type(iter_89_3))
					}

					xpcall(function()
						var_89_8.value = tostring(iter_89_3)
					end, function()
						var_89_8.value = tostring(type(iter_89_3)) .. " [value can't trans to string]"
					end)

					var_89_8.variablesReference = "0"

					if var_89_8.type == "table" or var_89_8.type == "function" or var_89_8.type == "userdata" then
						var_89_8.variablesReference = var_0_39
						var_0_40[var_0_39] = iter_89_3
						var_0_39 = var_0_39 + 1

						if var_89_8.type == "table" then
							var_89_8.value = var_0_9.getTableMemberNum(iter_89_3) .. " Members " .. ((not var_89_8.value or nil) and "")
						end
					elseif var_89_8.type == "string" then
						var_89_8.value = "\"" .. iter_89_3 .. "\""
					end

					table.insert(var_89_1, var_89_8)
				end
			end
		end
	end

	return var_89_1
end

function var_0_9.getGlobalVariable(...)
	local var_98_0 = {}

	for iter_98_0, iter_98_1 in pairs(_G) do
		local var_98_1 = {
			name = tostring(iter_98_0),
			type = tostring(type(iter_98_1))
		}

		xpcall(function()
			var_98_1.value = tostring(iter_98_1)
		end, function()
			var_98_1.value = tostring(type(iter_98_1)) .. " [value can't trans to string]"
		end)

		var_98_1.variablesReference = "0"

		if var_98_1.type == "table" or var_98_1.type == "function" or var_98_1.type == "userdata" then
			var_98_1.variablesReference = var_0_39
			var_0_40[var_0_39] = iter_98_1
			var_0_39 = var_0_39 + 1

			if var_98_1.type == "table" then
				var_98_1.value = var_0_9.getTableMemberNum(iter_98_1) .. " Members " .. ((not var_98_1.value or nil) and "")
			end
		elseif var_98_1.type == "string" then
			var_98_1.value = "\"" .. iter_98_1 .. "\""
		end

		table.insert(var_98_0, var_98_1)
	end

	return var_98_0
end

function var_0_9.getUpValueVariable(arg_101_0, arg_101_1)
	local var_101_0 = arg_101_1 ~= true

	arg_101_0 = arg_101_0 or var_0_24.func

	local var_101_1 = {}

	if arg_101_0 == nil then
		return var_101_1
	end

	local var_101_2 = 1

	repeat
		local var_101_3, var_101_4 = debug.getupvalue(arg_101_0, var_101_2)

		if var_101_3 then
			local var_101_5 = {
				name = var_101_3,
				type = tostring(type(var_101_4))
			}

			var_101_5.variablesReference = "0"

			if var_101_0 == false then
				xpcall(function()
					var_101_5.value = tostring(var_101_4)
				end, function()
					var_101_5.value = tostring(type(var_101_4)) .. " [value can't trans to string]"
				end)

				if var_101_5.type == "table" or var_101_5.type == "function" or var_101_5.type == "userdata" then
					var_101_5.variablesReference = var_0_39
					var_0_40[var_0_39] = var_101_4
					var_0_39 = var_0_39 + 1

					if var_101_5.type == "table" then
						var_101_5.value = var_0_9.getTableMemberNum(var_101_4) .. " Members " .. ((not var_101_5.value or nil) and "")
					end
				elseif var_101_5.type == "string" then
					var_101_5.value = "\"" .. var_101_4 .. "\""
				end
			else
				var_101_5.value = var_101_4
			end

			table.insert(var_101_1, var_101_5)

			var_101_2 = var_101_2 + 1
		end
	until not var_101_3

	return var_101_1
end

function var_0_9.getVariable(arg_104_0, arg_104_1, arg_104_2)
	local var_104_0 = arg_104_1 ~= true
	local var_104_1 = 0

	var_104_1 = arg_104_0 ~= nil and type(arg_104_0) == "number" and arg_104_0 + 1 or var_0_9.getSpecificFunctionStackLevel(var_0_24.func)

	if var_104_1 == 0 then
		var_0_9.printToVSCode("[error]获取层次失败！", 2)

		return
	end

	local var_104_2 = {}
	local var_104_3 = var_104_1

	if type(arg_104_2) == "number" then
		var_104_3 = var_104_3 + arg_104_2
	end

	repeat
		local var_104_4, var_104_5 = debug.getlocal(var_104_3, 1)

		if var_104_4 == nil then
			break
		end

		if tostring(var_104_4) ~= "(*temporary)" then
			local var_104_6 = {
				name = var_104_4,
				type = tostring(type(var_104_5))
			}

			var_104_6.variablesReference = "0"
			var_104_6.index = 1

			if var_104_0 == false then
				xpcall(function()
					var_104_6.value = tostring(var_104_5)
				end, function()
					var_104_6.value = tostring(type(var_104_5)) .. " [value can't trans to string]"
				end)

				if var_104_6.type == "table" or var_104_6.type == "function" or var_104_6.type == "userdata" then
					var_104_6.variablesReference = var_0_39
					var_0_40[var_0_39] = var_104_5
					var_0_39 = var_0_39 + 1

					if var_104_6.type == "table" then
						var_104_6.value = var_0_9.getTableMemberNum(var_104_5) .. " Members " .. ((not var_104_6.value or nil) and "")
					end
				elseif var_104_6.type == "string" then
					var_104_6.value = "\"" .. var_104_5 .. "\""
				end
			else
				var_104_6.value = var_104_5
			end

			local var_104_8 = var_0_9.checkSameNameVar(var_104_2, var_104_6)

			if var_104_8 ~= 0 then
				var_104_2[var_104_8] = var_104_6
			else
				table.insert(var_104_2, var_104_6)
			end
		end
	until var_104_4 == nil

	return var_104_2, var_104_3 - 1
end

function var_0_9.checkSameNameVar(arg_107_0, arg_107_1)
	for iter_107_0, iter_107_1 in pairs(arg_107_0) do
		if iter_107_1.name == arg_107_1.name then
			return iter_107_0
		end
	end

	return 0
end

function var_0_9:processExp()
	local var_108_0
	local var_108_1 = {}

	var_108_1.isSuccess = "true"

	if self ~= nil then
		local var_108_2 = var_0_9.trim(tostring(self.Expression))

		if false == false then
			if var_108_2:find("p ", 1, true) == 1 then
				var_108_2 = var_108_2:sub(3)
			end

			local var_108_3 = var_0_62("return " .. var_108_2)

			var_108_3 = var_108_3 or var_0_62(var_108_2)

			if type(var_108_3) == "function" then
				if _VERSION == "Lua 5.1" then
					setfenv(var_108_3, var_0_72)
				else
					debug.setupvalue(var_108_3, 1, var_0_72)
				end

				xpcall(function()
					var_108_0 = var_108_3()
				end, function()
					var_108_0 = "输入错误指令。\n + 请检查指令是否正确\n + 指令仅能在[暂停在断点时]输入, 请不要在程序持续运行时输入"
					var_108_1.isSuccess = false
				end)
			else
				var_108_0 = "指令执行错误。\n + 请检查指令是否正确\n + 可以直接输入表达式，执行函数或变量名，并观察执行结果"
				var_108_1.isSuccess = false
			end
		end
	end

	var_108_1.name = "Exp"
	var_108_1.type = tostring(type(var_108_0))

	xpcall(function()
		var_108_1.value = tostring(var_108_0)
	end, function(arg_112_0)
		var_108_1.value = tostring(type(var_108_0)) .. " [value can't trans to string] " .. arg_112_0
		var_108_1.isSuccess = false
	end)

	var_108_1.variablesReference = "0"

	if var_108_1.type == "table" or var_108_1.type == "function" or var_108_1.type == "userdata" then
		var_0_40[var_0_39] = var_108_0
		var_108_1.variablesReference = var_0_39
		var_0_39 = var_0_39 + 1

		if var_108_1.type == "table" then
			var_108_1.value = var_0_9.getTableMemberNum(var_108_0) .. " Members " .. var_108_1.value
		end
	elseif var_108_1.type == "string" then
		var_108_1.value = "\"" .. var_108_0 .. "\""
	end

	var_0_9.clearEnv()

	local var_108_4 = {}

	table.insert(var_108_4, var_108_1)

	return var_108_4
end

function var_0_9:processWatchedExp()
	local var_113_0
	local var_113_1 = "return " .. tostring(self.varName)

	var_0_9.printToConsole("processWatchedExp | expression: " .. var_113_1)

	local var_113_2 = var_0_62(var_113_1)
	local var_113_3 = {}

	var_113_3.isSuccess = "true"

	if type(var_113_2) == "function" then
		if _VERSION == "Lua 5.1" then
			setfenv(var_113_2, var_0_72)
		else
			debug.setupvalue(var_113_2, 1, var_0_72)
		end

		xpcall(function()
			var_113_0 = var_113_2()
		end, function()
			var_113_0 = "输入了错误的变量信息"
			var_113_3.isSuccess = "false"
		end)
	else
		var_113_0 = "未能找到变量的值"
		var_113_3.isSuccess = "false"
	end

	var_113_3.name = self.varName
	var_113_3.type = tostring(type(var_113_0))

	xpcall(function()
		var_113_3.value = tostring(var_113_0)
	end, function()
		var_113_3.value = tostring(type(var_113_0)) .. " [value can't trans to string]"
		var_113_3.isSuccess = "false"
	end)

	var_113_3.variablesReference = "0"

	if var_113_3.type == "table" or var_113_3.type == "function" or var_113_3.type == "userdata" then
		var_0_40[var_0_39] = var_113_0
		var_113_3.variablesReference = var_0_39
		var_0_39 = var_0_39 + 1

		if var_113_3.type == "table" then
			var_113_3.value = var_0_9.getTableMemberNum(var_113_0) .. " Members " .. var_113_3.value
		end
	elseif var_113_3.type == "string" then
		var_113_3.value = "\"" .. var_113_0 .. "\""
	end

	local var_113_4 = {}

	table.insert(var_113_4, var_113_3)

	return var_113_4
end

function var_0_10.getFileSource()
	for iter_118_0, iter_118_1 in pairs((debug.getinfo(1, "S"))) do
		if iter_118_0 == "source" then
			return iter_118_1
		end
	end
end

function var_0_10.printTable(arg_119_0, arg_119_1, arg_119_2)
	print((var_0_10.show(arg_119_0, arg_119_1, arg_119_2)))
end

function var_0_10.serializeTable(arg_120_0, arg_120_1, arg_120_2)
	return (var_0_10.show(arg_120_0, arg_120_1, arg_120_2))
end

function var_0_10.show(arg_121_0, arg_121_1, arg_121_2)
	local var_121_0
	local var_121_1

	local function var_121_2(arg_122_0)
		return next(arg_122_0) == nil
	end

	local function var_121_3(arg_123_0)
		local var_123_0 = tostring(arg_123_0)

		if type(arg_123_0) == "function" then
			local var_123_1 = debug.getinfo(arg_123_0, "S")

			if var_123_1.what == "C" then
				return string.format("%q", var_123_0 .. ", C function")
			else
				return string.format("%q", var_123_0 .. ", defined in (" .. var_123_1.linedefined .. "-" .. var_123_1.lastlinedefined .. ")" .. var_123_1.source)
			end
		elseif type(arg_123_0) == "number" or type(arg_123_0) == "boolean" then
			return var_123_0
		else
			return string.format("%q", var_123_0)
		end
	end

	local function var_121_4(arg_124_0, arg_124_1, arg_124_2, arg_124_3, arg_124_4)
		arg_124_2 = arg_124_2 or ""
		arg_124_3 = arg_124_3 or {}
		arg_124_4 = arg_124_4 or arg_124_1
		var_121_0 = var_121_0 .. arg_124_2 .. arg_124_4

		if type(arg_124_0) ~= "table" then
			var_121_0 = var_121_0 .. " = " .. var_121_3(arg_124_0) .. ";\n"
		elseif arg_124_3[arg_124_0] then
			var_121_0 = var_121_0 .. " = {}; -- " .. arg_124_3[arg_124_0] .. " (self reference)\n"
			var_121_1 = var_121_1 .. arg_124_1 .. " = " .. arg_124_3[arg_124_0] .. ";\n"
		else
			arg_124_3[arg_124_0] = arg_124_1

			if var_121_2(arg_124_0) then
				var_121_0 = var_121_0 .. " = {};\n"
			else
				var_121_0 = var_121_0 .. " = {\n"

				for iter_124_0, iter_124_1 in pairs(arg_124_0) do
					iter_124_0 = var_121_3(iter_124_0)
					arg_124_4 = string.format("[%s]", iter_124_0)

					var_121_4(iter_124_1, string.format("%s[%s]", arg_124_1, iter_124_0), arg_124_2 .. "   ", arg_124_3, arg_124_4)
				end

				var_121_0 = var_121_0 .. arg_124_2 .. "};\n"
			end
		end
	end

	arg_121_1 = arg_121_1 or "PRINT_Table"

	if type(arg_121_0) ~= "table" then
		do return arg_121_1 .. " = " .. var_121_3(arg_121_0) end

		var_121_1 = ""
	end

	var_121_0 = ""

	var_121_4(arg_121_0, arg_121_1, arg_121_2)

	return var_121_0 .. var_121_1
end

function var_0_10.createJson()
	local math = require("math")
	local string = require("string")
	local table = require("table")
	local var_125_3 = {}
	local var_125_4 = {}

	var_125_3.EMPTY_ARRAY = {}
	var_125_3.EMPTY_OBJECT = {}

	local var_125_5
	local var_125_6
	local var_125_7
	local var_125_8
	local var_125_9
	local var_125_10
	local var_125_11
	local var_125_13
	local var_125_14

	function var_125_3:encode()
		if self == nil then
			return "null"
		end

		local var_126_0 = type(self)

		if var_126_0 == "string" then
			return "\"" .. var_125_4.encodeString(self) .. "\""
		end

		if var_126_0 == "number" or var_126_0 == "boolean" then
			return tostring(self)
		end

		if var_126_0 == "table" then
			local var_126_1 = {}
			local var_126_2, var_126_3 = var_125_13(self)

			if var_126_2 then
				for iter_126_0 = 1, var_126_3 do
					table.insert(var_126_1, var_125_3.encode(self[iter_126_0]))
				end
			else
				for iter_126_1, iter_126_2 in pairs(self) do
					if var_125_14(iter_126_1) and var_125_14(iter_126_2) then
						table.insert(var_126_1, "\"" .. var_125_4.encodeString(iter_126_1) .. "\":" .. var_125_3.encode(iter_126_2))
					end
				end
			end

			if var_126_2 then
				return "[" .. table.concat(var_126_1, ",") .. "]"
			else
				return "{" .. table.concat(var_126_1, ",") .. "}"
			end
		end

		if var_126_0 == "function" and self == var_125_3.null then
			return "null"
		end

		assert(false, "encode attempt to encode unsupported type " .. var_126_0 .. ":" .. tostring(self))
	end

	function var_125_3.decode(arg_127_0, arg_127_1)
		arg_127_1 = arg_127_1 and arg_127_1 or 1
		arg_127_1 = var_125_11(arg_127_0, arg_127_1)

		assert(arg_127_1 <= string.len(arg_127_0), "Unterminated JSON encoded object found at position in [" .. arg_127_0 .. "]")

		local var_127_0 = string.sub(arg_127_0, arg_127_1, arg_127_1)

		if var_127_0 == "{" then
			return var_125_9(arg_127_0, arg_127_1)
		end

		if var_127_0 == "[" then
			return var_125_5(arg_127_0, arg_127_1)
		end

		if string.find("+-0123456789.e", var_127_0, 1, true) then
			return var_125_8(arg_127_0, arg_127_1)
		end

		if var_127_0 == "\"" or var_127_0 == "'" then
			return var_125_10(arg_127_0, arg_127_1)
		end

		if string.sub(arg_127_0, arg_127_1, arg_127_1 + 1) == "/*" then
			return var_125_3.decode(arg_127_0, var_125_6(arg_127_0, arg_127_1))
		end

		return var_125_7(arg_127_0, arg_127_1)
	end

	function var_125_3.null()
		return var_125_3.null
	end

	function var_125_5(arg_129_0, arg_129_1)
		local var_129_0 = {}
		local var_129_1 = string.len(arg_129_0)

		assert(string.sub(arg_129_0, arg_129_1, arg_129_1) == "[", "decode_scanArray called but array does not start at position " .. arg_129_1 .. " in string:\n" .. arg_129_0)

		arg_129_1 = arg_129_1 + 1

		local var_129_2 = 1

		repeat
			arg_129_1 = var_125_11(arg_129_0, arg_129_1)

			assert(arg_129_1 <= var_129_1, "JSON String ended unexpectedly scanning array.")

			local var_129_3 = string.sub(arg_129_0, arg_129_1, arg_129_1)

			if var_129_3 == "]" then
				return var_129_0, arg_129_1 + 1
			end

			if var_129_3 == "," then
				arg_129_1 = var_125_11(arg_129_0, arg_129_1 + 1)
			end

			assert(arg_129_1 <= var_129_1, "JSON String ended unexpectedly scanning array.")

			var_129_0[var_129_2], arg_129_1 = var_125_3.decode(arg_129_0, arg_129_1)
			var_129_2 = var_129_2 + 1
		until false
	end

	function var_125_6(arg_130_0, arg_130_1)
		assert(string.sub(arg_130_0, arg_130_1, arg_130_1 + 1) == "/*", "decode_scanComment called but comment does not start at position " .. arg_130_1)

		local var_130_0 = string.find(arg_130_0, "*/", arg_130_1 + 2)

		assert(var_130_0 ~= nil, "Unterminated comment in string at " .. arg_130_1)

		return var_130_0 + 2
	end

	function var_125_7(arg_131_0, arg_131_1)
		local var_131_0 = {
			["false"] = false,
			["true"] = true
		}

		for iter_131_0, iter_131_1 in pairs({
			"true",
			"false",
			"null"
		}) do
			if string.sub(arg_131_0, arg_131_1, arg_131_1 + string.len(iter_131_1) - 1) == iter_131_1 then
				return var_131_0[iter_131_1], arg_131_1 + string.len(iter_131_1)
			end
		end

		assert(nil, "Failed to scan constant from string " .. arg_131_0 .. " at starting position " .. arg_131_1)
	end

	function var_125_8(arg_132_0, arg_132_1)
		local var_132_0 = arg_132_1 + 1

		while string.find("+-0123456789.e", string.sub(arg_132_0, var_132_0, var_132_0), 1, true) and var_132_0 <= string.len(arg_132_0) do
			var_132_0 = var_132_0 + 1
		end

		return string.sub(arg_132_0, arg_132_1, var_132_0 - 1), var_132_0
	end

	function var_125_9(arg_133_0, arg_133_1)
		local var_133_0 = {}
		local var_133_1 = string.len(arg_133_0)

		assert(string.sub(arg_133_0, arg_133_1, arg_133_1) == "{", "decode_scanObject called but object does not start at position " .. arg_133_1 .. " in string:\n" .. arg_133_0)

		arg_133_1 = arg_133_1 + 1

		repeat
			arg_133_1 = var_125_11(arg_133_0, arg_133_1)

			assert(arg_133_1 <= var_133_1, "JSON string ended unexpectedly while scanning object.")

			local var_133_4 = string.sub(arg_133_0, arg_133_1, arg_133_1)

			if var_133_4 == "}" then
				return var_133_0, arg_133_1 + 1
			end

			if var_133_4 == "," then
				arg_133_1 = var_125_11(arg_133_0, arg_133_1 + 1)
			end

			assert(arg_133_1 <= var_133_1, "JSON string ended unexpectedly scanning object.")

			local var_133_5

			var_133_5, arg_133_1 = var_125_3.decode(arg_133_0, arg_133_1)

			assert(arg_133_1 <= var_133_1, "JSON string ended unexpectedly searching for value of key " .. var_133_5)

			arg_133_1 = var_125_11(arg_133_0, arg_133_1)

			assert(arg_133_1 <= var_133_1, "JSON string ended unexpectedly searching for value of key " .. var_133_5)
			assert(string.sub(arg_133_0, arg_133_1, arg_133_1) == ":", "JSON object key-value assignment mal-formed at " .. arg_133_1)

			arg_133_1 = var_125_11(arg_133_0, arg_133_1 + 1)

			assert(arg_133_1 <= var_133_1, "JSON string ended unexpectedly searching for value of key " .. var_133_5)

			var_133_0[var_133_5], arg_133_1 = var_125_3.decode(arg_133_0, arg_133_1)
		until false
	end

	local var_125_15 = {
		["\\n"] = "\n",
		["\\t"] = "\t",
		["\\f"] = "\f",
		["\\r"] = "\r",
		["\\b"] = "\b"
	}

	setmetatable(var_125_15, {
		__index = function(arg_134_0, arg_134_1)
			return string.sub(arg_134_1, 2)
		end
	})

	function var_125_10(arg_135_0, arg_135_1)
		assert(arg_135_1, "decode_scanString(..) called without start position")

		local var_135_0 = string.sub(arg_135_0, arg_135_1, arg_135_1)

		assert(var_135_0 == "\"" or var_135_0 == "'", "decode_scanString called for a non-string")

		local var_135_1 = {}
		local var_135_3 = arg_135_1

		while string.find(arg_135_0, var_135_0, var_135_3 + 1) ~= var_135_3 + 1 do
			local var_135_4 = var_135_3
			local var_135_5

			var_135_5, var_135_3 = string.find(arg_135_0, "\\.", var_135_3 + 1)

			local var_135_6, var_135_7 = string.find(arg_135_0, var_135_0, var_135_4 + 1)

			if var_135_5 then
				if var_135_6 < var_135_5 then
					var_135_3 = var_135_7 - 1
					var_135_5 = var_135_6
				end
			end

			table.insert(var_135_1, string.sub(arg_135_0, var_135_4 + 1, var_135_5 - 1))

			if string.sub(arg_135_0, var_135_5, var_135_3) == "\\u" then
				local var_135_8 = string.sub(arg_135_0, var_135_3 + 1, var_135_3 + 4)

				var_135_3 = var_135_3 + 4

				local var_135_9 = tonumber(var_135_8, 16)

				assert(var_135_9, "String decoding failed: bad Unicode escape " .. var_135_8 .. " at position " .. var_135_5 .. " : " .. var_135_3)
				table.insert(var_135_1, var_135_9 < 128 and string.char(var_135_9 % 128) or var_135_9 < 2048 and string.char(192 + math.floor(var_135_9 / 64) % 32, 128 + var_135_9 % 64) or string.char(224 + math.floor(var_135_9 / 4096) % 16, 128 + math.floor(var_135_9 / 64) % 64, 128 + var_135_9 % 64))
			else
				table.insert(var_135_1, var_125_15[string.sub(arg_135_0, var_135_5, var_135_3)])
			end
		end

		table.insert(var_135_1, string.sub(var_135_3, var_135_3 + 1))
		assert(string.find(arg_135_0, var_135_0, var_135_3 + 1), "String decoding failed: missing closing " .. var_135_0 .. " at position " .. var_135_3 .. "(for string at position " .. arg_135_1 .. ")")

		return table.concat(var_135_1, ""), var_135_3 + 2
	end

	function var_125_11(arg_136_0, arg_136_1)
		while string.find(" \n\r\t", string.sub(arg_136_0, arg_136_1, arg_136_1), 1, true) and arg_136_1 <= string.len(arg_136_0) do
			arg_136_1 = arg_136_1 + 1
		end

		return arg_136_1
	end

	local var_125_16 = {
		["\f"] = "\\f",
		["\b"] = "\\b",
		["\n"] = "\\n",
		["\r"] = "\\r",
		["\t"] = "\\t",
		["\\"] = "\\\\",
		["/"] = "\\/",
		["\""] = "\\\""
	}

	function var_125_4.encodeString(arg_137_0)
		return tostring(arg_137_0):gsub(".", function(arg_138_0)
			return var_125_16[arg_138_0]
		end)
	end

	function var_125_13(arg_139_0)
		if arg_139_0 == var_125_3.EMPTY_ARRAY then
			return true, 0
		end

		if arg_139_0 == var_125_3.EMPTY_OBJECT then
			return false
		end

		local var_139_0 = 0

		for iter_139_0, iter_139_1 in pairs(arg_139_0) do
			if type(iter_139_0) == "number" and math.floor(iter_139_0) == iter_139_0 and iter_139_0 >= 1 then
				if not var_125_14(iter_139_1) then
					return false
				end

				var_139_0 = math.max(var_139_0, iter_139_0)
			elseif iter_139_0 == "n" then
				if iter_139_1 ~= (arg_139_0.n or #arg_139_0) then
					return false
				end
			elseif var_125_14(iter_139_1) then
				return false
			end
		end

		return true, var_139_0
	end

	function var_125_14(arg_140_0)
		local var_140_0 = type(arg_140_0)

		return var_140_0 == "string" or var_140_0 == "boolean" or var_140_0 == "number" or var_140_0 == "nil" or var_140_0 == "table" or var_140_0 == "function" and arg_140_0 == var_125_3.null
	end

	return var_125_3
end

local var_0_73 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

function var_0_10:base64encode()
	return (self:gsub(".", function(arg_142_0)
		local var_142_0 = ""
		local var_142_1 = arg_142_0:byte()

		for iter_142_0 = 8, 1, -1 do
			var_142_0 = var_142_0 .. (var_142_1 % 2^iter_142_0 - var_142_1 % 2^(iter_142_0 - 1) > 0 and "1" or "0")
		end

		return var_142_0
	end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(arg_143_0)
		if #arg_143_0 < 6 then
			return ""
		end

		local var_143_0 = 0

		for iter_143_0 = 1, 6 do
			var_143_0 = var_143_0 + ((arg_143_0:sub(iter_143_0, iter_143_0) == "1" or nil) and (2^(6 - iter_143_0) or 0))
		end

		return var_0_73:sub(var_143_0 + 1, var_143_0 + 1)
	end) .. ({
		"",
		"==",
		"="
	})[#self % 3 + 1]
end

function var_0_10:base64decode()
	self = string.gsub(self, "[^" .. var_0_73 .. "=]", "")

	return (self:gsub(".", function(arg_145_0)
		if arg_145_0 == "=" then
			return ""
		end

		local var_145_0 = ""
		local var_145_1 = var_0_73:find(arg_145_0) - 1

		for iter_145_0 = 6, 1, -1 do
			var_145_0 = var_145_0 .. (var_145_1 % 2^iter_145_0 - var_145_1 % 2^(iter_145_0 - 1) > 0 and "1" or "0")
		end

		return var_145_0
	end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(arg_146_0)
		if #arg_146_0 ~= 8 then
			return ""
		end

		local var_146_0 = 0

		for iter_146_0 = 1, 8 do
			var_146_0 = var_146_0 + ((arg_146_0:sub(iter_146_0, iter_146_0) == "1" or nil) and (2^(8 - iter_146_0) or 0))
		end

		return string.char(var_146_0)
	end))
end

var_0_11 = var_0_10.createJson()

var_0_9.printToConsole("load LuaPanda success", 1)

return var_0_9
