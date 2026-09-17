local var_0_0 = {}
local var_0_1 = 3
local var_0_3 = false

var_0_0.requestingPool = {}

function var_0_0.registerRequesting(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.requestingPool[arg_1_0] = {
		sendcount = 1,
		time = var_0_1,
		package = arg_1_1,
		callback = arg_1_2
	}
end

function var_0_0.unregisterRequesting(arg_2_0)
	var_0_0.requestingPool[arg_2_0] = nil
end

function var_0_0.exeResponse(arg_3_0, arg_3_1)
	local var_3_0

	if var_0_0.requestingPool[arg_3_0] then
		var_3_0 = var_0_0.requestingPool[arg_3_0].callback
	end

	var_0_0.requestingPool[arg_3_0] = nil

	if var_3_0 then
		local var_3_1, var_3_2 = pcall(var_3_0, arg_3_1)

		if not var_3_1 then
			if cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_WINDOWS then
				print(var_3_2)
			else
				buglyReportLuaException(tostring(var_3_2), debug.traceback())
			end
		end
	end
end

function var_0_0.sendAllRequestAgain()
	local network = require("network.network")

	for iter_4_0, iter_4_1 in pairs(var_0_0.requestingPool) do
		network:sendpackage(iter_4_1.package)

		var_0_0.requestingPool[iter_4_0].time = var_0_1
		var_0_0.requestingPool[iter_4_0].sendcount = var_0_0.requestingPool[iter_4_0].sendcount + 1
	end
end

function var_0_0.clearAllRequest()
	var_0_0.requestingPool = {}
end

local function var_0_4(arg_6_0)
	if var_0_3 then
		return
	end

	local network = require("network.network")

	for iter_6_0, iter_6_1 in pairs(var_0_0.requestingPool) do
		iter_6_1.time = iter_6_1.time - 1

		if iter_6_1.time < 0 then
			network:checkconnection(function(arg_7_0)
				if arg_7_0 then
					var_0_3 = false
				else
					network:unnetschedule()
					network:disable_connect_check()
					network:missconnection()
				end
			end)

			iter_6_1.time = var_0_1
			var_0_3 = true

			break
		end
	end
end

function var_0_0.schedule()
	if not var_0_0.scheduleid then
		var_0_0.scheduleid = cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_0_4, 1, false)
		var_0_3 = false
	end
end

function var_0_0.unschedule()
	if var_0_0.scheduleid then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_0.scheduleid)

		var_0_0.scheduleid = nil
		var_0_3 = false
	end
end

return var_0_0
