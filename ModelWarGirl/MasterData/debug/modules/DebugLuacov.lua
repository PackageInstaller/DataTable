-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugLuacov.lua

local runner = require("Debug/Modules/luacov.runner")
local DebugLuacov = {
	isRun = false
}

function DebugLuacov.get_client_path()
	local handle = io.popen("cd")
	local result = handle:read("*a")

	handle:close()

	local path = result:gsub("^%s*(.-)%s*$", "%1")

	return path
end

function DebugLuacov.gen_luacov_config()
	local client_path = DebugLuacov.get_client_path()

	os.execute(client_path .. "\\luacov\\luacov.exe --client_path=\"" .. client_path .. "\" mode=local")
end

function DebugLuacov.luacov_switch_local()
	if DebugLuacov.isRun then
		runner.shutdown()

		DebugLuacov.isRun = false

		MsgManager.notice("结束luacov代码覆盖率检测")
	else
		DebugLuacov.gen_luacov_config()
		runner.init()

		DebugLuacov.isRun = true

		MsgManager.notice("启动luacov代码覆盖率检测")
	end
end

function DebugLuacov.luacov_switch()
	if DebugLuacov.isRun then
		runner.shutdown()

		DebugLuacov.isRun = false

		MsgManager.notice("结束luacov代码覆盖率检测")
	else
		runner.init()

		DebugLuacov.isRun = true

		MsgManager.notice("启动luacov代码覆盖率检测")
	end
end

function DebugLuacov.init()
	runner.init()
	MsgManager.notice("启动luacov代码覆盖率检测")
end

function DebugLuacov.output()
	runner.output()
	MsgManager.notice("输出luacov代码覆盖率检测")
end

function DebugLuacov.shutdown()
	runner.shutdown()
	MsgManager.notice("结束luacov代码覆盖率检测")
end

function DebugLuacov.save_stats()
	runner.save_stats()
	MsgManager.notice("保存save_stats")
end

function DebugLuacov.gen_report(isshutdown)
	runner.gen_report(isshutdown)
	MsgManager.notice("生成report")
end

function DebugLuacov.merge(path1)
	runner.merge(path1)
	MsgManager.notice("合并luacov代码覆盖率检测 path1=" .. path1)
end

function DebugLuacov.reset()
	runner.reset()
	MsgManager.notice("重置luacov代码覆盖率检测")
end

return DebugLuacov
