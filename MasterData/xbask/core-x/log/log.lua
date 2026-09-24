local var_0_0 = lx
local var_0_1 = tostring
local var_0_2 = table.concat
local var_0_3 = debug.traceback
local var_0_4 = os.date
local var_0_5 = os.time
local var_0_6 = lx._print_r_
local var_0_7 = lx._check_clear_old_

lx.log_print = print

local function var_0_8()
	return var_0_4("[%Y-%m-%d %H:%M:%S] ", var_0_5())
end

local function var_0_9(...)
	local var_2_0 = {
		...
	}

	for iter_2_0 = 1, #var_2_0 do
		var_2_0[iter_2_0] = var_0_1(var_2_0[iter_2_0])
	end

	return var_0_2(var_2_0, "\t")
end

if not lx.log then
	lx.log = {}
	lx.log.__log_writelog = _G.log_writelog
	lx.log.__log_error = _G.log_error
end

_G.log_set_directory = nil
_G.log_get_directory = nil
_G.log_append_time = nil
_G.log_every_flush = nil
_G.log_writelog = nil
_G.log_error = nil

local var_0_10 = lx.log

_G.log = lx.log

function lx.log.debuglog(...)
	var_0_0.log_print(var_0_8() .. var_0_9(...))
end

function lx.log.writelog(...)
	var_0_10.__log_writelog(var_0_9(...))
end

function lx.log.writelog_debug(...)
	local var_5_0 = var_0_9(...)

	var_0_10.__log_writelog(var_5_0)
	var_0_0.log_print(var_0_8() .. var_5_0)
end

function lx.log.errorlog(...)
	if var_0_0.monitor_manager then
		var_0_0.monitor_manager:eventOnLogError()
	end

	var_0_10.__log_error(var_0_3(var_0_9(...), 2), 2)
end

function lx.log.print_r(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = var_0_6.format_value_for_table(arg_7_0, arg_7_1)

	if arg_7_2 == nil or arg_7_2 == true then
		var_0_0.log_print(encode.utf8_to_ansi(var_7_0))

		return
	end

	return var_7_0
end

function lx.log.clear_old_log(arg_8_0)
	var_0_7.clear_old_log(arg_8_0)
end
