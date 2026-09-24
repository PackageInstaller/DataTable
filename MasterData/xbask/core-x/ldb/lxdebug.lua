local var_0_0 = {}
local var_0_1 = _G
local var_0_2 = pairs
local var_0_3 = assert
local var_0_4 = type
local var_0_5 = next
local var_0_6 = tostring
local var_0_7 = tonumber
local var_0_8 = getmetatable
local var_0_9 = string.rep
local var_0_10 = string.len
local var_0_11 = string.format
local var_0_12 = string.sub
local var_0_13 = string.find
local var_0_14 = table.insert
local var_0_15 = table.concat
local var_0_16 = debug.traceback
local var_0_17 = debug.sethook
local var_0_18 = debug.gethook
local var_0_19 = debug.getinfo
local var_0_20 = debug.getlocal
local var_0_21 = debug.getupvalue
local var_0_22 = lxnet
local var_0_23 = socketer
local var_0_24 = listener
local var_0_25 = packet
local var_0_26 = self_sleep

if not _G._l__lxdebug__l_ then
	_G._l__lxdebug__l_ = {
		runmodule = "unknow",
		dirty = false,
		lastcmd = "",
		nextstep = false,
		trace = false,
		used_tree = false,
		need_release = false,
		already_auth = false,
		already_init = false,
		enable_debug = true,
		num = 1,
		begin_port = 3563,
		trace_count = 0,
		enable_auth = true,
		lastnum = 1,
		thisfilename = debug.getinfo(1, "S").source,
		breaktable = {
			linehook = false,
			validnum = 0,
			num = 0,
			tb = {},
			blist = {}
		},
		noseelist = {},
		cfile = {},
		extend_cmd_func_set = {}
	}

	local var_0_27 = _G._l__lxdebug__l_

	for iter_0_0, iter_0_1 in pairs(_G.cfile) do
		_G._l__lxdebug__l_.cfile[iter_0_0] = iter_0_1
		_G.cfile[iter_0_0] = nil
	end

	local var_0_28 = cfile.open

	function cfile.open(arg_1_0)
		for iter_1_0, iter_1_1 in var_0_2(var_0_27.noseelist) do
			if var_0_13(arg_1_0, iter_1_1) then
				return nil
			end
		end

		return var_0_28(arg_1_0)
	end
end

local var_0_29 = _G._l__lxdebug__l_
local var_0_30 = _G._l__lxdebug__l_.cfile
local var_0_31

local function var_0_32()
	if var_0_29.runmodule == "purelua" then
		return
	end

	if var_0_29.runmodule == "useframefunc" then
		if var_0_29.hook_func then
			var_0_29.hook_func = nil

			var_0_17()
		end

		var_0_29.breaktable.linehook = false
	end
end

local function var_0_33()
	if not var_0_18() then
		var_0_29.hook_func = var_0_31

		var_0_17(var_0_31, "l")

		var_0_29.breaktable.linehook = true
	end
end

local function var_0_34()
	var_0_29.breaktable.num = 0
	var_0_29.breaktable.validnum = 0
	var_0_29.breaktable.tb = {}
	var_0_29.breaktable.blist = {}
	var_0_29.breaktable.linehook = false
end

local function var_0_35(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0

	if var_0_29.breaktable.tb[arg_5_2] then
		var_5_0 = var_0_29.breaktable.tb[arg_5_2][arg_5_0]
	end

	if var_5_0 then
		if var_5_0.active then
			return var_0_11("Note: breakpoint %s already at file: %s, line %s.", var_0_6(var_5_0.number), var_0_6(arg_5_1), var_0_6(arg_5_0))
		else
			var_0_29.breaktable.validnum = var_0_29.breaktable.validnum + 1
			var_5_0.active = true

			if var_0_29.breaktable.validnum == 0 then
				var_0_33()
			end

			return var_0_11("Enable breakpoint %s.", var_0_6(var_5_0.number))
		end
	end

	local var_5_1 = {
		source = arg_5_1,
		cmpsource = arg_5_2,
		line = arg_5_0
	}

	var_5_1.active = true
	var_5_1.number = var_0_29.num
	var_0_29.num = var_0_29.num + 1
	var_0_29.breaktable.tb[arg_5_2] = var_0_29.breaktable.tb[arg_5_2] or {}
	var_0_29.breaktable.tb[arg_5_2][arg_5_0] = var_5_1
	var_0_29.breaktable.blist[var_5_1.number] = var_5_1
	var_0_29.breaktable.num = var_0_29.breaktable.num + 1
	var_0_29.breaktable.validnum = var_0_29.breaktable.validnum + 1

	if var_0_29.breaktable.validnum == 0 then
		var_0_33()
	end

	return var_0_11("Breakpoint %s at file: %s, line %s.", var_0_6(var_5_1.number), var_0_6(arg_5_1), var_0_6(arg_5_0))
end

local function var_0_36(arg_6_0, arg_6_1)
	local var_6_0 = var_0_30.open(arg_6_1)

	if not var_6_0 then
		return var_0_11("No source file named %s.", var_0_6(arg_6_1))
	end

	local var_6_1 = 0

	repeat
		if not var_0_30.readline(var_6_0, false) then
			break
		end

		var_6_1 = var_6_1 + 1
	until var_6_1 == arg_6_0

	var_0_30.close(var_6_0)

	if var_6_1 ~= arg_6_0 then
		return var_0_11("No line %s in file \"%s\"", var_0_6(arg_6_0), var_0_6(arg_6_1))
	end

	return var_0_35(arg_6_0, arg_6_1, "@" .. var_0_6(arg_6_1))
end

local function var_0_37(arg_7_0)
	return var_0_29.breaktable.blist[arg_7_0]
end

local function var_0_38(arg_8_0)
	if arg_8_0 == "*" then
		var_0_34()

		if var_0_29.breaktable.num ~= 0 then
			var_0_32()
		end

		return "Delete all breakpoints."
	end

	local var_8_0 = var_0_37(var_0_7(arg_8_0))

	if not var_8_0 then
		return var_0_11("No breakpoint number %s.", var_0_6(arg_8_0))
	end

	var_0_29.breaktable.tb[var_8_0.cmpsource][var_8_0.line] = nil
	var_0_29.breaktable.blist[var_8_0.number] = nil
	var_0_29.breaktable.num = var_0_29.breaktable.num - 1

	if var_8_0.active then
		var_0_29.breaktable.validnum = var_0_29.breaktable.validnum - 1
	end

	if var_0_29.breaktable.num == 0 or var_0_29.breaktable.validnum == 0 then
		var_0_32()
	end

	return var_0_11("Delete breakpoint %s.", var_0_6(arg_8_0))
end

local function var_0_39(arg_9_0)
	if var_0_29.breaktable.num <= 0 then
		return "No breakpoints."
	end

	if arg_9_0 == "*" then
		var_0_29.breaktable.validnum = var_0_29.breaktable.num

		for iter_9_0, iter_9_1 in var_0_2(var_0_29.breaktable.blist) do
			iter_9_1.active = true
		end

		if var_0_29.breaktable.validnum == 0 then
			var_0_33()
		end

		return "Enable all breakpoints."
	end

	local var_9_0 = var_0_37(var_0_7(arg_9_0))

	if not var_9_0 then
		return var_0_11("No breakpoint number %s.", var_0_6(arg_9_0))
	end

	if not var_9_0.active then
		var_0_29.breaktable.validnum = var_0_29.breaktable.validnum + 1
		var_9_0.active = true

		if var_0_29.breaktable.validnum == 0 then
			var_0_33()
		end
	end

	return var_0_11("Enable breakpoint %s.", var_0_6(arg_9_0))
end

local function var_0_40(arg_10_0)
	if var_0_29.breaktable.num <= 0 then
		return "No breakpoints."
	end

	if arg_10_0 == "*" then
		var_0_29.breaktable.validnum = 0

		for iter_10_0, iter_10_1 in var_0_2(var_0_29.breaktable.blist) do
			iter_10_1.active = false
		end

		if var_0_29.breaktable.validnum > 0 then
			var_0_32()
		end

		return "Disable all breakpoints."
	end

	local var_10_0 = var_0_37(var_0_7(arg_10_0))

	if not var_10_0 then
		return var_0_11("No breakpoint number %s.", var_0_6(arg_10_0))
	end

	if var_10_0.active then
		var_0_29.breaktable.validnum = var_0_29.breaktable.validnum - 1
		var_10_0.active = false

		if var_0_29.breaktable.validnum == 0 then
			var_0_32()
		end
	end

	return var_0_11("Disable breakpoint %s.", var_0_6(arg_10_0))
end

local function var_0_41(arg_11_0)
	var_0_23.send_msg(var_0_29.client, arg_11_0)
	var_0_23.check_send(var_0_29.client)
end

local function var_0_42()
	local var_12_0 = 1

	while true do
		if not var_0_19(var_12_0, "S") then
			break
		end

		var_12_0 = var_12_0 + 1
	end

	return var_12_0
end

local function var_0_43(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = 0
	local var_13_1 = 0
	local var_13_2 = {}
	local var_13_4 = var_0_30.open(arg_13_0)

	if not var_13_4 then
		var_0_14(var_13_2, var_0_11("open %s failed!\n", var_0_6(arg_13_0)))

		var_13_0 = 1

		return var_13_2, 1
	end

	arg_13_1 = arg_13_1 >= 1 and arg_13_1 or 1
	arg_13_2 = arg_13_2 >= 1 and arg_13_2 or 1

	while true do
		local var_13_6 = var_0_30.readline(var_13_4)

		if not var_13_6 then
			break
		end

		var_13_1 = var_13_1 + 1

		if arg_13_1 <= var_13_1 and var_13_1 < arg_13_1 + arg_13_2 then
			var_0_14(var_13_2, (var_0_11("%-6d %s", var_13_1, var_13_6)))

			var_13_0 = var_13_0 + 1
		end
	end

	var_0_30.close(var_13_4)

	return var_13_2, var_13_0
end

local function var_0_44()
	local var_14_0 = var_0_19(5)
	local var_14_1 = 1

	if var_14_0.currentline > 5 then
		var_14_1 = var_14_0.currentline - 5
	end

	if var_0_29.lastcmd == "l" then
		var_14_1 = var_0_29.lastnum
	else
		var_0_29.lastnum = var_14_1
	end

	local var_14_2 = var_0_12(var_14_0.source, 2, #var_14_0.source)
	local var_14_3, var_14_4 = var_0_43(var_14_2, var_14_1, 10)

	var_0_29.lastnum = var_0_29.lastnum + var_14_4

	if var_14_4 == 0 then
		var_0_14(var_14_3, (var_0_11("Line number %s out of range; %s has %s lines.\n", var_0_6(var_14_1), var_0_6(var_14_2), var_0_6(var_14_1 - 1))))

		var_14_4 = 1
	end

	local var_14_5 = var_0_25.ldb_msg()

	var_0_25.settype(var_14_5, 0)
	var_0_25.pushint16(var_14_5, var_14_4)

	for iter_14_0, iter_14_1 in var_0_2(var_14_3) do
		var_0_25.pushstring(var_14_5, iter_14_1)
	end

	var_0_41(var_14_5)
end

local function var_0_45()
	local var_15_0 = var_0_25.ldb_msg()

	var_0_25.settype(var_15_0, 0)
	var_0_25.pushint16(var_15_0, 1)
	var_0_25.pushstring(var_15_0, var_0_16("", 5) .. "\n")
	var_0_41(var_15_0)
end

local function var_0_46()
	local var_16_0 = var_0_25.ldb_msg()
	local var_16_1 = 1

	var_0_25.settype(var_16_0, 0)
	var_0_25.pushint16(var_16_0, var_16_1)

	if var_0_29.breaktable.num == 0 then
		var_0_25.pushstring(var_16_0, "No breakpoints.\n")
	else
		var_0_25.pushstring(var_16_0, "Num     Enb   What\n")

		for iter_16_0, iter_16_1 in var_0_2(var_0_29.breaktable.blist) do
			var_0_25.pushstring(var_16_0, var_0_11("%-8d%-6s%s:%d\n", iter_16_1.number, iter_16_1.active and "y" or "n", iter_16_1.source, iter_16_1.line))

			var_16_1 = var_16_1 + 1
		end
	end

	var_0_25.pushint16toindex(var_16_0, 0, var_16_1)
	var_0_41(var_16_0)
end

local var_0_47 = 0
local var_0_48

local function var_0_49(arg_17_0)
	if not var_0_25.canpush(var_0_48, var_0_10(arg_17_0) + 4) then
		var_0_25.settype(var_0_48, 1)
		var_0_25.pushint16toindex(var_0_48, 0, var_0_47)
		var_0_41(var_0_48)

		var_0_47 = 0

		var_0_25.reset(var_0_48)
		var_0_25.settype(var_0_48, 0)
		var_0_25.pushint16(var_0_48, var_0_47)
	end

	var_0_25.pushstring(var_0_48, arg_17_0)

	var_0_47 = var_0_47 + 1
end

local function var_0_50(arg_18_0)
	arg_18_0 = arg_18_0 .. "\n"

	local var_18_0 = var_0_10(arg_18_0)

	if 32750 < var_18_0 then
		local var_18_1 = 32750

		while true do
			var_0_49((var_0_12(arg_18_0, 0, var_18_1)))

			if var_18_0 <= var_18_1 + 32750 then
				break
			end

			var_18_1 = var_18_1 + 32750
		end

		arg_18_0 = var_0_12(arg_18_0, var_18_1 + 1)
	end

	var_0_49(arg_18_0)
end

local function var_0_51(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0 = {}

	local function var_19_1(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
		if var_0_29.__skip_name_set[arg_20_0] then
			return
		end

		local var_20_0 = var_0_9("    ", arg_20_2)
		local var_20_1 = var_0_4(arg_20_1)

		if var_20_1 == "table" and arg_20_3 ~= 0 then
			if not var_19_0[arg_20_1] then
				var_19_0[arg_20_1] = var_0_11(" = {%s} [type:reference]", var_0_6(arg_20_4))
			else
				var_0_50(var_0_11("%s%s%s", var_0_6(var_20_0), var_0_6(arg_20_0), var_0_6(var_19_0[arg_20_1])))

				return
			end

			var_0_50(var_0_11("%s%s = \n%s{", var_20_0, var_0_6(arg_20_0), var_20_0))

			arg_20_3 = arg_20_3 - 1

			for iter_20_0, iter_20_1 in (var_0_0.__get_hook_func(arg_20_1) or var_0_2)(arg_20_1) do
				var_19_1(iter_20_0, iter_20_1, arg_20_2 + 1, arg_20_3, var_0_11("%s.%s", var_0_6(arg_20_4), var_0_6(iter_20_0)), arg_20_5)
			end

			var_0_50(var_0_6(var_20_0) .. "}")
		else
			var_0_50((var_0_11("%s%s = %s    [type:%s]", var_20_0, var_0_6(arg_20_0), var_0_6(arg_20_1), var_0_4(arg_20_1))))

			if arg_20_5 and var_20_1 == "function" then
				if not var_19_0[arg_20_1] then
					var_19_0[arg_20_1] = var_0_11(" = {%s} [type:reference]", var_0_6(arg_20_4))
				else
					var_0_50(var_0_11("%s%s%s", var_0_6(var_20_0), var_0_6(arg_20_0), var_0_6(var_19_0[arg_20_1])))

					return
				end

				local var_20_2 = 1

				while true do
					local var_20_3, var_20_4 = var_0_21(arg_20_1, var_20_2)

					if not var_20_3 then
						break
					end

					var_20_2 = var_20_2 + 1

					if var_0_1[var_20_3] ~= var_20_4 then
						var_19_1("[upvalue]" .. var_20_3, var_20_4, arg_20_2 + 1, -1, var_0_11("%s.[upvalue]%s", var_0_6(arg_20_4), var_0_6(var_20_3)), arg_20_5)
					end
				end

				if debug.getfenv then
					local var_20_5 = debug.getfenv(arg_20_1)

					if var_20_5 ~= var_0_1 then
						var_19_1("[fenv]", var_20_5, arg_20_2 + 1, -1, var_0_11("%s.[fenv]", var_0_6(arg_20_4)), arg_20_5)
					end
				end
			end
		end
	end

	var_19_1(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
end

local function var_0_52(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = {
		[arg_21_1] = arg_21_0
	}

	local function var_21_1(arg_22_0, arg_22_1, arg_22_2)
		if var_0_29.__skip_name_set[arg_22_2] then
			return
		end

		if var_0_4(arg_22_0) ~= "table" then
			return var_0_11(" = %s [type:%s]", var_0_6(arg_22_0), var_0_4(arg_22_0))
		end

		local var_22_0 = {}
		local var_22_1, var_22_2 = var_0_0.__get_hook_func(arg_22_0)

		var_22_1 = var_22_1 or var_0_2
		var_22_2 = var_22_2 or var_0_5

		for iter_22_0, iter_22_1 in var_22_1(arg_22_0) do
			if not var_0_29.__skip_name_set[iter_22_0] then
				local var_22_3 = var_0_6(iter_22_0)

				if var_21_0[iter_22_1] then
					var_0_14(var_22_0, var_0_11("+%s {%s} [type:reference]", var_0_6(var_22_3), var_0_6(var_21_0[iter_22_1])))
				elseif var_0_4(iter_22_1) == "table" then
					local var_22_4 = var_0_11("%s.%s", var_0_6(arg_22_2), var_0_6(var_22_3))

					var_21_0[iter_22_1] = var_22_4

					if arg_21_2 ~= 1 then
						var_0_14(var_22_0, "+" .. var_0_6(var_22_3) .. var_21_1(iter_22_1, arg_22_1 .. (var_22_2(arg_22_0, iter_22_0) and "|" or " ") .. var_0_9(" ", #var_22_3), var_22_4))
					else
						var_0_14(var_22_0, var_0_11("+%s = %s [type:%s]", var_22_3, var_0_6(iter_22_1), var_0_4(iter_22_1)))
					end
				else
					var_0_14(var_22_0, var_0_11("+%s = %s [type:%s]", var_22_3, var_0_6(iter_22_1), var_0_4(iter_22_1)))
				end
			end
		end

		return var_0_15(var_22_0, "\n" .. arg_22_1)
	end

	var_0_50(arg_21_0 .. var_21_1(arg_21_1, var_0_9(" ", #arg_21_0), arg_21_0))
end

local function var_0_53(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if var_0_29.used_tree then
		var_0_52(arg_23_0, arg_23_1, arg_23_2)
	else
		var_0_51(arg_23_0, arg_23_1, 0, arg_23_2, arg_23_0, arg_23_3)
	end
end

local function var_0_54(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = false
	local var_24_2 = 1
	local var_24_3 = var_0_10(arg_24_0)
	local var_24_5 = 0

	while var_24_2 < var_24_3 do
		local var_24_6

		var_24_6, var_24_2 = var_0_13(arg_24_0, "[_%w][_%w]*", var_24_2)

		if not var_24_6 then
			break
		end

		local var_24_7 = var_0_12(arg_24_0, var_24_6, var_24_2)

		var_24_2 = var_24_2 + 1

		if var_0_13(var_24_7, "%d") == 1 then
			var_24_7 = var_0_7(var_24_7)
		end

		if not arg_24_1 then
			return false
		end

		if arg_24_1[var_24_7] then
			if var_0_4(arg_24_1[var_24_7]) == "table" then
				if var_24_3 <= var_24_2 then
					var_0_53(arg_24_0, arg_24_1[var_24_7], arg_24_2)

					var_24_0 = true

					break
				else
					arg_24_1 = arg_24_1[var_24_7]
				end
			else
				if var_24_2 - 1 == var_24_3 then
					var_0_50(var_0_11("%s = %s    [type:%s]", arg_24_0, var_0_6(arg_24_1[var_24_7]), var_0_4(arg_24_1[var_24_7])))

					var_24_0 = true

					break
				end

				var_24_0 = false

				break
			end
		elseif var_24_5 == 1 then
			return false
		end

		var_24_5 = var_24_5 + 1
	end

	return var_24_0
end

local function var_0_55(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_3 then
		var_0_53("[registry]", debug.getregistry(), arg_25_1, arg_25_3)

		return
	end

	if not arg_25_0 then
		var_0_50(var_0_11("%s is invalid.", var_0_6(arg_25_0)))

		return
	end

	if arg_25_0 == "_G" and arg_25_1 == 1 then
		for iter_25_0, iter_25_1 in var_0_2(var_0_1) do
			var_0_50(var_0_11("%s    %s", var_0_6(iter_25_0), var_0_6(iter_25_1)))
		end

		return
	end

	local var_25_0 = false

	if var_0_13(arg_25_0, "[_%a][%.%[][_%w]*") then
		local var_25_1 = var_0_12(arg_25_0, var_0_13(arg_25_0, "[_%a][_%w]*"))

		if var_25_1 == "_G" then
			var_25_0 = var_0_54(arg_25_0, var_0_1, arg_25_1)
		end

		if not var_25_0 then
			local var_25_2 = 1

			while true do
				local var_25_5, var_25_6 = var_0_20(arg_25_2, var_25_2)

				if not var_25_5 then
					break
				end

				var_25_2 = var_25_2 + 1

				if var_25_5 == var_25_1 then
					var_25_0 = var_0_54(arg_25_0, var_25_6, arg_25_1)

					break
				end
			end
		end
	else
		local var_25_7 = 1

		while true do
			local var_25_10, var_25_11 = var_0_20(arg_25_2, var_25_7)

			if not var_25_10 then
				break
			end

			var_25_7 = var_25_7 + 1

			if var_25_10 == arg_25_0 then
				var_0_53(arg_25_0, var_25_11, arg_25_1)

				var_25_0 = true

				return
			end
		end

		local var_25_12 = 1
		local var_25_13 = var_0_19(arg_25_2, "f").func

		while true do
			local var_25_14, var_25_15 = var_0_21(var_25_13, var_25_12)

			if not var_25_14 then
				break
			end

			var_25_12 = var_25_12 + 1

			if var_25_14 == arg_25_0 then
				var_0_53(arg_25_0, var_25_15, arg_25_1)

				var_25_0 = true

				return
			end
		end

		if var_0_1[arg_25_0] ~= nil then
			var_0_53(arg_25_0, var_0_1[arg_25_0], arg_25_1)

			var_25_0 = true

			return
		end
	end

	if not var_25_0 then
		var_0_50(var_0_11("No symbol \"%s\" in current context.", var_0_6(arg_25_0)))
	end
end

local function var_0_56(arg_26_0, arg_26_1, arg_26_2)
	var_0_47 = 0
	var_0_48 = var_0_25.ldb_msg()

	var_0_25.settype(var_0_48, 0)
	var_0_25.pushint16(var_0_48, var_0_47)
	var_0_55(arg_26_0, arg_26_1, 6, arg_26_2)
	var_0_25.pushint16toindex(var_0_48, 0, var_0_47)
	var_0_41(var_0_48)

	var_0_48 = nil
	var_0_47 = 0
end

local function var_0_57(arg_27_0)
	if var_0_12(arg_27_0, #arg_27_0) ~= "\n" then
		arg_27_0 = arg_27_0 .. "\n"
	end

	local var_27_0 = var_0_25.ldb_msg()

	var_0_25.settype(var_27_0, 0)
	var_0_25.pushint16(var_27_0, 1)
	var_0_25.pushstring(var_27_0, arg_27_0)
	var_0_41(var_27_0)
end

local function var_0_58(arg_28_0)
	local var_28_0 = arg_28_0
	local var_28_1
	local var_28_2 = var_0_13(arg_28_0, " ")

	if var_28_2 ~= nil then
		var_28_0 = var_0_12(arg_28_0, 1, var_28_2 - 1)
		var_28_1 = var_0_12(arg_28_0, var_28_2 + 1)
	end

	if var_28_0 == "q" then
		var_0_0.stop_debug()

		return true
	end

	if not var_0_29.already_auth then
		if var_28_0 == "auth" then
			var_0_3(var_0_29.auth_password)
			var_0_3(var_0_29.auth_password ~= "")

			if var_28_1 == var_0_29.auth_password or not var_0_29.enable_auth then
				var_0_29.already_auth = true
				var_0_29.dirty = true

				local var_28_3 = var_0_25.ldb_msg()

				var_0_25.settype(var_28_3, 0)
				var_0_25.pushint16(var_28_3, 1)
				var_0_25.pushstring(var_28_3, "auth suceed.\n")
				var_0_41(var_28_3)

				return true
			end
		end

		var_0_23.close(var_0_29.client)

		return true
	end

	if var_28_0 == "c" then
		var_0_29.trace = false

		if var_0_18() and (var_0_29.breaktable.num == 0 or var_0_29.breaktable.validnum == 0) then
			var_0_32()
		end

		return true
	elseif var_28_0 == "s" then
		var_0_29.trace = true

		var_0_33()

		return true
	elseif var_28_0 == "n" then
		var_0_29.trace = false
		var_0_29.nextstep = true
		var_0_29.current_func = var_0_19(4).func
		var_0_29.trace_count = var_0_42() - 1

		var_0_33()

		return true
	elseif var_28_0 == "p" then
		var_0_56(var_28_1, -1)
	elseif var_28_0 == "pt" then
		var_0_56(var_28_1, 1)
	elseif var_28_0 == "see" then
		var_0_56(var_28_1, -1)

		return true
	elseif var_28_0 == "seet" then
		var_0_56(var_28_1, 1)

		return true
	elseif var_28_0 == "dump" then
		var_0_56(var_28_1, -1, true)

		return true
	elseif var_28_0 == "printtree" then
		local var_28_4 = var_0_25.ldb_msg()

		var_0_25.settype(var_28_4, 0)
		var_0_25.pushint16(var_28_4, 1)
		var_0_25.pushstring(var_28_4, "Use tree structure output.\n")
		var_0_41(var_28_4)

		var_0_29.used_tree = true
	elseif var_28_0 == "printtable" then
		local var_28_5 = var_0_25.ldb_msg()

		var_0_25.settype(var_28_5, 0)
		var_0_25.pushint16(var_28_5, 1)
		var_0_25.pushstring(var_28_5, "Use table structure output.\n")
		var_0_41(var_28_5)

		var_0_29.used_tree = false
	elseif var_28_0 == "b" then
		local var_28_6 = var_0_13(var_28_1, ":")
		local var_28_7 = var_0_25.ldb_msg()

		var_0_25.settype(var_28_7, 0)
		var_0_25.pushint16(var_28_7, 1)
		var_0_25.pushstring(var_28_7, var_0_36(var_0_7((var_0_12(var_28_1, var_28_6 + 1))), (var_0_12(var_28_1, 1, var_28_6 - 1))) .. "\n")
		var_0_41(var_28_7)
	elseif var_28_0 == "d" then
		local var_28_8 = var_0_25.ldb_msg()

		var_0_25.settype(var_28_8, 0)
		var_0_25.pushint16(var_28_8, 1)
		var_0_25.pushstring(var_28_8, var_0_38(var_28_1) .. "\n")
		var_0_41(var_28_8)
	elseif var_28_0 == "bl" then
		var_0_46()
	elseif var_28_0 == "be" then
		local var_28_9 = var_0_25.ldb_msg()

		var_0_25.settype(var_28_9, 0)
		var_0_25.pushint16(var_28_9, 1)
		var_0_25.pushstring(var_28_9, var_0_39(var_28_1) .. "\n")
		var_0_41(var_28_9)
	elseif var_28_0 == "bd" then
		local var_28_10 = var_0_25.ldb_msg()

		var_0_25.settype(var_28_10, 0)
		var_0_25.pushint16(var_28_10, 1)
		var_0_25.pushstring(var_28_10, var_0_40(var_28_1) .. "\n")
		var_0_41(var_28_10)
	elseif var_28_0 == "bt" then
		var_0_45()
	elseif var_28_0 == "l" then
		var_0_44()
	else
		local var_28_11 = "Undefined command: \"" .. arg_28_0 .. "\". Try \"Help\"."
		local var_28_12 = false

		if var_0_29.extend_cmd_func_set[var_28_0] then
			var_28_11, var_28_12 = var_0_29.extend_cmd_func_set[var_28_0](var_28_0, var_28_1, var_0_57)
		end

		if not var_28_12 then
			var_0_57(var_28_11)
		end

		return true
	end

	return false
end

local function var_0_59()
	var_0_23.check_recv(var_0_29.client)

	local var_29_0

	while true do
		if var_0_23.is_close(var_0_29.client) then
			return "q"
		end

		var_29_0 = var_0_23.get_msg_ldb(var_0_29.client)

		if var_29_0 then
			break
		else
			var_0_26(10)
		end
	end

	var_0_25.begin(var_29_0)

	return var_0_25.getstring(var_29_0)
end

local function var_0_60(arg_30_0)
	while true do
		var_0_29.lastcmd = arg_30_0

		if var_0_58(arg_30_0) then
			break
		end

		arg_30_0 = var_0_59()

		var_0_23.check_send(var_0_29.client)
	end
end

local function var_0_61()
	return create_guid()
end

local function var_0_62(arg_32_0)
	local var_32_0 = var_0_22.init(512, 1, 16384, 16, 2, 8, 1)

	var_0_29.listen = var_0_24.create()

	var_0_3(var_0_29.listen, "create listener object failed!")

	if arg_32_0 then
		local var_32_1 = var_0_29.begin_port

		while true do
			if var_0_24.listen(var_0_29.listen, var_32_1, 1) then
				break
			end

			var_32_1 = var_32_1 + 1
		end

		var_0_29.port = var_32_1
	elseif not var_0_24.listen(var_0_29.listen, var_0_29.port, 1) then
		log.errorlog(var_0_11("ldb listen %d failed!", var_0_29.port))
		exit_self_process()
	end

	if var_32_0 then
		var_0_29.need_release = true
	end

	var_0_29.auth_password = var_0_61()
end

local function var_0_63()
	if var_0_24.can_accept(var_0_29.listen) then
		var_0_29.client = var_0_24.accept(var_0_29.listen)

		if var_0_29.client then
			var_0_23.check_send(var_0_29.client)
			var_0_23.check_recv(var_0_29.client)

			var_0_29.dirty = true

			return true
		end
	end

	return false
end

local function var_0_64()
	if var_0_29.client then
		return
	end

	while not var_0_63() do
		var_0_26(50)
	end
end

local function var_0_65()
	var_0_23.check_send(var_0_29.client)
	var_0_23.check_recv(var_0_29.client)

	local var_35_0
	local var_35_1 = var_0_23.get_msg_ldb(var_0_29.client)

	if var_35_1 then
		var_0_25.begin(var_35_1)

		var_35_0 = var_0_25.getstring(var_35_1)
	end

	return var_35_0
end

function var_0_31(arg_36_0, arg_36_1)
	local var_36_0 = forlua_dgetinfo(2)

	if var_0_29.thisfilename == var_36_0 then
		return
	end

	if var_0_29.nextstep then
		local var_36_1 = var_0_42()

		if var_36_1 < var_0_29.trace_count then
			var_0_29.nextstep = false
			var_0_29.trace = true
		elseif var_36_1 == var_0_29.trace_count and var_0_29.current_func == var_0_19(2).func then
			var_0_29.nextstep = false
			var_0_29.trace = true
		end
	end

	local var_36_2

	if not var_0_29.trace and var_0_29.breaktable.tb[var_36_0] then
		if var_0_29.breaktable.tb[var_36_0][arg_36_1] and var_0_29.breaktable.tb[var_36_0][arg_36_1].active then
			var_0_29.nextstep = false
			var_0_29.trace = true
			var_36_2 = var_0_11("Breakpoint %s, at %s:%s", var_0_6(var_0_29.breaktable.tb[var_36_0][arg_36_1].number), var_0_29.breaktable.tb[var_36_0][arg_36_1].source, var_0_6(var_0_29.breaktable.tb[var_36_0][arg_36_1].line))
		end
	end

	if var_0_29.trace then
		local var_36_3, var_36_4 = var_0_43(var_0_12(var_36_0, 2, #var_36_0), arg_36_1, 1)

		if var_36_2 then
			var_36_4 = var_36_4 + 1
		end

		local var_36_5 = var_0_25.ldb_msg()

		var_0_25.settype(var_36_5, 0)
		var_0_25.pushint16(var_36_5, var_36_4)

		if var_36_2 then
			var_0_25.pushstring(var_36_5, var_36_2 .. "\n")
		end

		for iter_36_0, iter_36_1 in var_0_2(var_36_3) do
			var_0_25.pushstring(var_36_5, iter_36_1)
		end

		var_0_41(var_36_5)
		var_0_60(var_0_59())
	elseif var_0_29.runmodule == "purelua" then
		local var_36_6 = var_0_65()

		if var_36_6 then
			var_0_60(var_36_6)
		end
	elseif not var_0_29.nextstep then
		if var_0_29.breaktable.linehook and (var_0_29.breaktable.num == 0 or var_0_29.breaktable.validnum == 0) then
			var_0_32()
		end
	end
end

function var_0_0.debug_pure_lua(arg_37_0)
	var_0_0.startdebug_use_loopfunc(arg_37_0)

	var_0_29.runmodule = "purelua"

	var_0_64()
	var_0_60(var_0_59())
end

function var_0_0.startdebug_use_loopfunc(arg_38_0)
	if var_0_29.already_init then
		return var_0_29.port
	end

	arg_38_0 = arg_38_0 or 3563

	if var_0_29.port then
		return var_0_29.port
	end

	var_0_29.port = arg_38_0

	var_0_62(arg_38_0 < 0)

	var_0_29.runmodule = "useframefunc"
	var_0_29.hook_func = var_0_31

	var_0_17(var_0_31, "l")

	var_0_29.breaktable.linehook = true
	var_0_29.already_init = true

	return var_0_29.port
end

function var_0_0.debug_run_once()
	if not var_0_29.enable_debug then
		return
	end

	if not var_0_29.listen then
		return
	end

	if var_0_29.need_release then
		var_0_22.run()
	end

	if var_0_29.client and var_0_23.is_close(var_0_29.client) then
		var_0_60("q")

		return
	end

	if var_0_29.client then
		local var_39_0 = var_0_65()

		if var_39_0 then
			var_0_60(var_39_0)
		end
	else
		var_0_63()
	end
end

function var_0_0.stop_debug()
	if var_0_29.client then
		var_0_23.release(var_0_29.client)

		var_0_29.client = nil
		var_0_29.already_auth = false
		var_0_29.auth_password = var_0_61()
		var_0_29.dirty = true
	end

	if var_0_29.hook_func then
		var_0_29.hook_func = nil

		var_0_17()
	end

	var_0_34()
end

function var_0_0.destroy()
	var_0_0.stop_debug()

	if var_0_29.listen then
		var_0_24.release(var_0_29.listen)

		var_0_29.listen = nil
	end

	if var_0_29.need_release then
		var_0_22.release()
	end
end

function var_0_0.set_enable(arg_42_0)
	if not arg_42_0 then
		var_0_0.stop_debug()
	end

	var_0_29.enable_debug = arg_42_0
	var_0_29.dirty = true
end

function var_0_0.is_enable()
	return var_0_29.enable_debug
end

function var_0_0.set_randport_begin_value(arg_44_0)
	var_0_29.begin_port = arg_44_0
end

function var_0_0.get_port()
	return var_0_29.port
end

function var_0_0.get_now_client_ip()
	if var_0_29.client == nil then
		return ""
	end

	return var_0_23.get_ip(var_0_29.client)
end

function var_0_0.get_now_auth_password()
	if var_0_29.client or var_0_29.already_auth then
		return ""
	end

	return var_0_29.auth_password
end

function var_0_0.get_now_info()
	return {
		port = var_0_29.port,
		enable_debug = var_0_29.enable_debug,
		debugging = var_0_29.client ~= nil,
		debugging_ip = var_0_0.get_now_client_ip(),
		already_auth = var_0_29.already_auth,
		auth_password = var_0_0.get_now_auth_password()
	}
end

function var_0_0.check_dirty()
	var_0_29.dirty = false

	return var_0_29.dirty
end

function var_0_0.add_access_denied(arg_50_0)
	if var_0_4(arg_50_0) == "string" then
		local var_50_0 = false

		for iter_50_0, iter_50_1 in var_0_2(var_0_29.noseelist) do
			if iter_50_1 == arg_50_0 then
				var_50_0 = true

				break
			end
		end

		if not var_50_0 then
			var_0_14(var_0_29.noseelist, arg_50_0)
		end
	end
end

function var_0_0.register_extend_cmd_func(arg_51_0, arg_51_1)
	var_0_29.extend_cmd_func_set[arg_51_0] = arg_51_1
end

function var_0_0.reset_dump()
	var_0_29.__skip_name_set = {}
	var_0_29.__hook_class_set = {}
end

function var_0_0.dump_skip_name(arg_53_0)
	for iter_53_0, iter_53_1 in var_0_2(arg_53_0) do
		var_0_29.__skip_name_set[iter_53_1] = true
	end
end

function var_0_0.dump_hook_class(arg_54_0)
	var_0_29.__hook_class_set[arg_54_0] = true
end

function var_0_0:__get_hook_func()
	local var_55_0 = var_0_8(self)

	if not var_55_0 or var_0_8(var_55_0) or var_0_4(var_55_0.__index) ~= "table" or not var_55_0.__index.getClassName then
		return
	end

	if not var_0_29.__hook_class_set[self:getClassName()] then
		return
	end

	if self.pairs then
		return self.pairs, self.has_next
	end

	return nil, nil
end

return var_0_0
