function table.nums(arg_1_0)
	local var_1_0 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		var_1_0 = var_1_0 + 1
	end

	return var_1_0
end

function table.keys(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		var_2_0[#var_2_0 + 1] = iter_2_0
	end

	return var_2_0
end

function table.values(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		var_3_0[#var_3_0 + 1] = iter_3_1
	end

	return var_3_0
end

function table.exists(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		if iter_4_0 == arg_4_0 then
			break
		end
	end
end

function table.merge(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		arg_5_0[iter_5_0] = iter_5_1
	end
end

function table:add(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		self[iter_6_0] = self[iter_6_0] == nil and iter_6_1 or self[iter_6_0] + iter_6_1
	end
end

function table.insertto(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2 = checkint(arg_7_2)

	if arg_7_2 <= 0 then
		arg_7_2 = #arg_7_0 + 1
	end

	for iter_7_0 = 0, #arg_7_1 - 1 do
		arg_7_0[iter_7_0 + arg_7_2] = arg_7_1[iter_7_0 + 1]
	end
end

function table:indexof(arg_8_1, arg_8_2)
	for iter_8_0 = arg_8_2 or 1, #self do
		if self[iter_8_0] == arg_8_1 then
			return iter_8_0
		end
	end

	return nil
end

function table.keyof(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0) do
		if iter_9_1 == arg_9_1 then
			return iter_9_0
		end
	end

	return nil
end

function table:removebyvalue(arg_10_1, arg_10_2)
	local var_10_0 = 0
	local var_10_1 = 1

	while var_10_1 <= #self do
		if self[var_10_1] == arg_10_1 then
			table.remove(self, var_10_1)

			var_10_0 = var_10_0 + 1
			var_10_1 = var_10_1 - 1

			if not arg_10_2 then
				break
			end
		end

		var_10_1 = var_10_1 + 1
	end

	return var_10_0
end

function table.map(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0) do
		arg_11_0[iter_11_0] = arg_11_1(iter_11_1, iter_11_0)
	end
end

function table.walk(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_0) do
		arg_12_1(iter_12_1, iter_12_0)
	end
end

function table.filter(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_0) do
		if not arg_13_1(iter_13_1, iter_13_0) then
			arg_13_0[iter_13_0] = nil
		end
	end
end

function table.unique(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_0) do
		if not var_14_0[iter_14_1] then
			local var_14_2

			if arg_14_1 then
				var_14_1[1] = iter_14_1
				var_14_2 = 1 + 1
			else
				var_14_1[iter_14_0] = iter_14_1
			end

			var_14_0[iter_14_1] = true
		end
	end

	return var_14_1
end

function table.equal(arg_15_0, arg_15_1)
	if table.nums(arg_15_0) ~= table.nums(arg_15_1) then
		return false
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0) do
		if type(iter_15_1) == "table" and type(arg_15_1[iter_15_0]) == "table" then
			if not table.equal(iter_15_1, arg_15_1[iter_15_0]) then
				return false
			end
		elseif arg_15_1[iter_15_0] ~= iter_15_1 then
			return false
		end
	end

	return true
end

function table.serialize(arg_16_0)
	local var_16_0 = ""
	local var_16_1 = type(arg_16_0)

	if var_16_1 == "number" then
		var_16_0 = var_16_0 .. arg_16_0
	elseif var_16_1 == "boolean" then
		var_16_0 = var_16_0 .. tostring(arg_16_0)
	elseif var_16_1 == "string" then
		var_16_0 = var_16_0 .. string.format("%s", arg_16_0)
	elseif var_16_1 == "table" then
		var_16_0 = var_16_0 .. "{"

		for iter_16_0, iter_16_1 in pairs(arg_16_0) do
			var_16_0 = var_16_0 .. table.serialize(iter_16_0) .. "=" .. table.serialize(iter_16_1) .. ","
		end

		local var_16_2 = getmetatable(arg_16_0)

		if var_16_2 ~= nil and type(var_16_2.__index) == "table" then
			for iter_16_2, iter_16_3 in pairs(var_16_2.__index) do
				var_16_0 = var_16_0 .. table.serialize(iter_16_2) .. "=" .. table.serialize(iter_16_3) .. ","
			end
		end

		var_16_0 = var_16_0 .. "}"
	elseif var_16_1 == "nil" then
		return nil
	else
		return ""
	end

	return var_16_0
end

function table.empty(arg_17_0)
	return not next(arg_17_0)
end

function math.clamp(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0 < arg_18_1 then
		arg_18_0 = arg_18_1
	end

	if arg_18_2 and arg_18_2 < arg_18_0 then
		arg_18_0 = arg_18_2
	end

	return arg_18_0
end

function math.round(arg_19_0)
	arg_19_0 = checknumber(arg_19_0)

	return math.floor(arg_19_0 + 0.5)
end

function math.tointeger(arg_20_0)
	arg_20_0 = checknumberj(arg_20_0)

	return math.floor(arg_20_0)
end

function checkversion(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0 == "" then
		arg_21_0 = "1.0"
	end

	local var_21_0 = string.split(arg_21_0, ".")

	if arg_21_1 < tonumber(var_21_0[1]) then
		return true
	elseif arg_21_1 == tonumber(var_21_0[1]) and arg_21_2 < tonumber(var_21_0[2]) then
		return true
	end
end

function checknumber(arg_22_0, arg_22_1)
	return tonumber(arg_22_0, arg_22_1) or 0
end

function checkint(arg_23_0)
	return math.round(checknumber(arg_23_0))
end

function checkbool(arg_24_0)
	return arg_24_0 ~= nil and arg_24_0 ~= false
end

function checktable(arg_25_0)
	if type(arg_25_0) ~= "table" then
		arg_25_0 = {}
	end

	return arg_25_0
end

function checkhex(arg_26_0)
	return checknumber("0x" .. arg_26_0)
end

string._htmlspecialchars_set = {}
string._htmlspecialchars_set["&"] = "&amp;"
string._htmlspecialchars_set["\""] = "&quot;"
string._htmlspecialchars_set["'"] = "&#039;"
string._htmlspecialchars_set["<"] = "&lt;"
string._htmlspecialchars_set[">"] = "&gt;"

function string.htmlspecialchars(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(string._htmlspecialchars_set) do
		arg_27_0 = string.gsub(arg_27_0, iter_27_0, iter_27_1)
	end

	return arg_27_0
end

function string.restorehtmlspecialchars(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(string._htmlspecialchars_set) do
		arg_28_0 = string.gsub(arg_28_0, iter_28_1, iter_28_0)
	end

	return arg_28_0
end

function string.nl2br(arg_29_0)
	return string.gsub(arg_29_0, "\n", "<br />")
end

function string.text2html(arg_30_0)
	arg_30_0 = string.gsub(arg_30_0, "\t", "    ")
	arg_30_0 = string.htmlspecialchars(arg_30_0)
	arg_30_0 = string.gsub(arg_30_0, " ", "&nbsp;")
	arg_30_0 = string.nl2br(arg_30_0)

	return arg_30_0
end

function string.split(arg_31_0, arg_31_1)
	local var_31_0 = {}

	string.gsub(arg_31_0, "[^" .. arg_31_1 .. "]+", function(arg_32_0)
		table.insert(var_31_0, arg_32_0)
	end)

	return var_31_0
end

function string.ltrim(arg_33_0)
	return string.gsub(arg_33_0, "^[ \t\n\r]+", "")
end

function string.rtrim(arg_34_0)
	return string.gsub(arg_34_0, "[ \t\n\r]+$", "")
end

function string.trim(arg_35_0)
	arg_35_0 = string.gsub(arg_35_0, "^[ \t\n\r]+", "")

	return string.gsub(arg_35_0, "[ \t\n\r]+$", "")
end

function string.ucfirst(arg_36_0)
	return string.upper(string.sub(arg_36_0, 1, 1)) .. string.sub(arg_36_0, 2)
end

local function var_0_0(arg_37_0)
	return "%" .. string.format("%02X", string.byte(arg_37_0))
end

function string.urlencode(arg_38_0)
	arg_38_0 = string.gsub(tostring(arg_38_0), "\n", "\r\n")
	arg_38_0 = string.gsub(arg_38_0, "([^%w%.%- ])", var_0_0)

	return string.gsub(arg_38_0, " ", "+")
end

function string.urldecode(arg_39_0)
	arg_39_0 = string.gsub(arg_39_0, "+", " ")
	arg_39_0 = string.gsub(arg_39_0, "%%(%x%x)", function(arg_40_0)
		return string.char(checknumber(arg_40_0, 16))
	end)
	arg_39_0 = string.gsub(arg_39_0, "\r\n", "\n")

	return arg_39_0
end

function string.utf8len(arg_41_0)
	local var_41_0 = string.len(arg_41_0)
	local var_41_1 = 0
	local var_41_2 = {
		0,
		192,
		224,
		240,
		248,
		252
	}

	while var_41_0 ~= 0 do
		local var_41_3 = string.byte(arg_41_0, -var_41_0)

		while var_41_2[#var_41_2] do
			if var_41_3 >= var_41_2[#var_41_2] then
				var_41_0 = var_41_0 - #var_41_2

				break
			end
		end

		var_41_1 = var_41_1 + 1
	end

	return var_41_1
end

function string.formatnumberthousands(arg_42_0)
	local var_42_0 = tostring(checknumber(arg_42_0))

	repeat
		local var_42_2, var_42_3 = string.gsub(var_42_0, "^(-?%d+)(%d%d%d)", "%1,%2")

		var_42_0 = var_42_2
	until var_42_3 == 0

	return var_42_0
end

local function var_0_2(arg_43_0, arg_43_1)
	local var_43_0 = getmetatable(arg_43_0) or {}

	if not var_43_0.__index then
		var_43_0.__index = arg_43_1

		setmetatable(arg_43_0, var_43_0)
	elseif var_43_0.__index ~= arg_43_1 then
		var_0_2(var_43_0, arg_43_1)
	end
end

setmetatableindex = nil

function cloneconf(arg_44_0)
	local var_44_0 = {}

	local function var_44_1(arg_45_0)
		if type(arg_45_0) ~= "table" then
			return arg_45_0
		elseif var_44_0[arg_45_0] then
			return var_44_0[arg_45_0]
		end

		local var_45_0 = {}

		var_44_0[arg_45_0] = var_45_0

		for iter_45_0, iter_45_1 in pairs(arg_45_0) do
			var_45_0[var_44_1(iter_45_0)] = var_44_1(iter_45_1)
		end

		return var_45_0
	end

	return var_44_1(arg_44_0)
end

function dump(arg_46_0, arg_46_1)
	local var_46_4

	local function var_46_5(arg_47_0)
		return string.rep("\t", arg_47_0)
	end

	local function var_46_6(arg_48_0)
		return "\"" .. string.gsub(arg_48_0, "\"", "\\\"") .. "\""
	end

	local function var_46_7(arg_49_0)
		if type(arg_49_0) == "number" then
			return "[" .. arg_49_0 .. "]"
		elseif type(arg_49_0) == "string" then
			return "[" .. var_46_6(arg_49_0) .. "]"
		else
			return "[" .. tostring(arg_49_0) .. "]"
		end
	end

	local function var_46_8(arg_50_0, arg_50_1)
		if type(arg_50_0) == "table" then
			return var_46_4(arg_50_0, arg_50_1)
		elseif type(arg_50_0) == "number" then
			return arg_50_0
		elseif type(arg_50_0) == "string" then
			return var_46_6(arg_50_0)
		else
			return tostring(arg_50_0)
		end
	end

	function var_46_4(arg_51_0, arg_51_1)
		if type(arg_51_0) ~= "table" then
			return var_46_8(arg_51_0)
		end

		arg_51_1 = arg_51_1 + 1

		local var_51_0 = {}

		var_51_0[#var_51_0 + 1] = "{"

		for iter_51_0, iter_51_1 in pairs(arg_51_0) do
			var_51_0[#var_51_0 + 1] = var_46_5(arg_51_1) .. var_46_7(iter_51_0) .. " = " .. var_46_8(iter_51_1, arg_51_1) .. ","
		end

		var_51_0[#var_51_0 + 1] = var_46_5(arg_51_1 - 1) .. "}"

		return table.concat(var_51_0, (arg_46_1 or nil) and " ")
	end

	return (nil)(arg_46_0, 0)
end

function printdump(arg_52_0)
	print(dump(arg_52_0))
end

function printLog(arg_53_0, arg_53_1, ...)
	print(table.concat({
		"[",
		string.upper(tostring(arg_53_0)),
		"] ",
		string.format(tostring(arg_53_1), ...)
	}))
end

function printError(arg_54_0, ...)
	printLog("ERR", arg_54_0, ...)
	print(debug.traceback("", 2))
end

local function var_0_3(arg_55_0)
	if type(arg_55_0) == "string" then
		arg_55_0 = "\"" .. arg_55_0 .. "\""
	end

	return tostring(arg_55_0)
end

function dumpEx_3_10(arg_56_0, arg_56_1, arg_56_2)
	if type(arg_56_2) ~= "number" then
		arg_56_2 = 3
	end

	local var_56_0 = {}
	local var_56_1 = {}

	print("dump from: " .. string.trim(string.split(debug.traceback("", 2), "\n")[2]))

	local function var_56_2(arg_57_0, arg_57_1, arg_57_2, arg_57_3, arg_57_4)
		arg_57_1 = arg_57_1 or "<var>"

		local var_57_0 = ""

		if type(arg_57_4) == "number" then
			var_57_0 = string.rep(" ", arg_57_4 - string.len(var_0_3(arg_57_1)))
		end

		if type(arg_57_0) ~= "table" then
			var_56_1[#var_56_1 + 1] = string.format("%s%s%s = %s", arg_57_2, var_0_3(arg_57_1), var_57_0, var_0_3(arg_57_0))
		elseif var_56_0[tostring(arg_57_0)] then
			var_56_1[#var_56_1 + 1] = string.format("%s%s%s = *REF*", arg_57_2, var_0_3(arg_57_1), var_57_0)
		else
			var_56_0[tostring(arg_57_0)] = true

			if arg_57_3 > arg_56_2 then
				var_56_1[#var_56_1 + 1] = string.format("%s%s = *MAX NESTING*", arg_57_2, var_0_3(arg_57_1))
			else
				var_56_1[#var_56_1 + 1] = string.format("%s%s = {", arg_57_2, var_0_3(arg_57_1))

				local var_57_1 = {}
				local var_57_2 = 0
				local var_57_3 = {}

				for iter_57_0, iter_57_1 in pairs(arg_57_0) do
					var_57_1[#var_57_1 + 1] = iter_57_0

					local var_57_4 = string.len((var_0_3(iter_57_0)))

					if var_57_2 < var_57_4 then
						var_57_2 = var_57_4
					end

					var_57_3[iter_57_0] = iter_57_1
				end

				table.sort(var_57_1, function(arg_58_0, arg_58_1)
					if type(arg_58_0) == "number" and type(arg_58_1) == "number" then
						return arg_58_0 < arg_58_1
					else
						return tostring(arg_58_0) < tostring(arg_58_1)
					end
				end)

				for iter_57_2, iter_57_3 in ipairs(var_57_1) do
					var_56_2(var_57_3[iter_57_3], iter_57_3, arg_57_2 .. "    ", arg_57_3 + 1, var_57_2)
				end

				var_56_1[#var_56_1 + 1] = string.format("%s}", arg_57_2)
			end
		end
	end

	var_56_2(arg_56_0, arg_56_1, "- ", 1)

	for iter_56_0, iter_56_1 in ipairs(var_56_1) do
		print(iter_56_1)
	end
end

function import(arg_59_0, arg_59_1)
	local var_59_0
	local var_59_1 = arg_59_0

	while true do
		if string.byte(arg_59_0, 1) ~= 46 then
			var_59_1 = string.sub(arg_59_0, 1)

			if var_59_0 and #var_59_0 > 0 then
				var_59_1 = table.concat(var_59_0, ".") .. "." .. var_59_1
			end

			break
		end

		if not var_59_0 then
			if not arg_59_1 then
				local var_59_3, var_59_4 = debug.getlocal(3, 1)

				arg_59_1 = var_59_4
			end

			var_59_0 = string.split(arg_59_1, ".")
		end

		table.remove(var_59_0, #var_59_0)
	end

	return require(var_59_1)
end

function handler(arg_60_0, arg_60_1)
	return function(...)
		return arg_60_1(arg_60_0, ...)
	end
end

function datetime(arg_62_0, arg_62_1)
	local var_62_0 = os.date("*t", arg_62_0)

	if arg_62_1 then
		var_62_0.day = var_62_0.day + arg_62_1
	end

	return math.tointeger(string.format("%02d%02d%02d", var_62_0.year, var_62_0.month, var_62_0.day))
end

function getday(arg_63_0)
	return math.tointeger(os.date("%d", arg_63_0))
end

function gethour(arg_64_0)
	return math.tointeger(os.date("%H", arg_64_0))
end

function isdifferentmonth(arg_65_0, arg_65_1)
	if os.date("%y%m", arg_65_0) ~= os.date("%y%m", arg_65_1) then
		return true
	else
		return false
	end
end

function isdifferentweek(arg_66_0, arg_66_1)
	if os.date("%y%m%d", arg_66_0) ~= os.date("%y%m%d", arg_66_1) then
		return true
	else
		return false
	end
end

function isdifferentday(arg_67_0, arg_67_1)
	if os.date("%y%m%d", arg_67_0) ~= os.date("%y%m%d", arg_67_1) then
		return true
	else
		return false
	end
end

function isdifferenthour(arg_68_0, arg_68_1)
	if os.date("%y%m%d%H", arg_68_0) ~= os.date("%y%m%d%H", arg_68_1) then
		return true
	else
		return false
	end
end

function stringtotime(arg_69_0)
	return os.time({
		hour = 23,
		min = 59,
		sec = 59,
		year = string.sub(arg_69_0, 1, 4),
		month = string.sub(arg_69_0, 5, 6),
		day = string.sub(arg_69_0, 7, 8)
	})
end

local var_0_4 = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

function uuid()
	local var_70_0 = io.open("/dev/urandom", "r")
	local var_70_1 = var_70_0:read(4)

	var_70_0:close()
	math.randomseed(os.time() + var_70_1:byte(1) + var_70_1:byte(2) * 256 + var_70_1:byte(3) * 65536 + var_70_1:byte(4) * 4294967296)

	return string.gsub(var_0_4, "x", function(arg_71_0)
		return string.format("%x", arg_71_0 == "x" and math.random(0, 15) or math.random(8, 11))
	end)
end

function io.exists(arg_72_0)
	local var_72_0 = io.open(arg_72_0, "r")

	if var_72_0 then
		io.close(var_72_0)

		return true
	end

	return false
end

function trace(...)
	print(os.date("%Y-%m-%d %H:%M:%S") .. ":", ...)
end

function stringtodaystart(arg_74_0)
	return os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = string.sub(arg_74_0, 1, 4),
		month = string.sub(arg_74_0, 5, 6),
		day = string.sub(arg_74_0, 7, 8)
	})
end

function stringtodayend(arg_75_0)
	return os.time({
		hour = 23,
		min = 59,
		sec = 59,
		year = string.sub(arg_75_0, 1, 4),
		month = string.sub(arg_75_0, 5, 6),
		day = string.sub(arg_75_0, 7, 8)
	})
end

function stringtotime(arg_76_0)
	local var_76_0 = string.gsub(string.gsub(string.gsub(arg_76_0, " ", ""), "-", ""), ":", "")

	return os.time({
		year = string.sub(var_76_0, 1, 4),
		month = string.sub(var_76_0, 5, 6),
		day = string.sub(var_76_0, 7, 8),
		hour = string.sub(var_76_0, 9, 10),
		min = string.sub(var_76_0, 11, 12),
		sec = string.sub(var_76_0, 13, 14)
	})
end

function optionint(arg_77_0, arg_77_1)
	if arg_77_0 then
		if arg_77_0 == "" then
			return 0
		end

		return math.tointeger(arg_77_0)
	else
		return arg_77_1
	end
end

function optionnumber(arg_78_0, arg_78_1)
	if arg_78_0 then
		if arg_78_0 == "" then
			return 0
		end

		return tonumber(arg_78_0)
	else
		return arg_78_1
	end
end

function optionvalue(arg_79_0, arg_79_1)
	return arg_79_0 or arg_79_1
end

function optionjson(arg_80_0, arg_80_1)
	if arg_80_0 then
		if arg_80_0 == "" then
			return "[]"
		end

		return arg_80_0
	else
		return arg_80_1
	end
end

function unixtime(arg_81_0)
	if arg_81_0 == "" then
		return 0
	end

	local var_81_0, var_81_1, var_81_2, var_81_3, var_81_4, var_81_5 = arg_81_0:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

	if not var_81_0 then
		return 0
	end

	return os.time({
		year = var_81_0 + 2000,
		month = var_81_1,
		day = var_81_2,
		hour = var_81_3,
		min = var_81_4,
		sec = var_81_5
	})
end

function fromunixtime(arg_82_0)
	if arg_82_0 == 0 then
		return ""
	end

	return os.date("%y-%m-%d %H:%M:%S", arg_82_0)
end

function randomtoweight(arg_83_0)
	local var_83_0 = 0

	for iter_83_0, iter_83_1 in ipairs(arg_83_0) do
		var_83_0 = var_83_0 + iter_83_1
	end

	local var_83_1 = var_83_0 > 1 and math.random(1, var_83_0) or 0

	for iter_83_2 = 1, #arg_83_0 do
		if var_83_1 <= arg_83_0[iter_83_2] then
			return iter_83_2
		else
			var_83_1 = var_83_1 - arg_83_0[iter_83_2]
		end
	end
end

function math.newrandomseed()
	math.randomseed(os.time())
	math.random()
	math.random()
	math.random()
	math.random()
end

function file_exists(arg_85_0)
	local var_85_0 = io.open(arg_85_0, "rb")

	if var_85_0 then
		var_85_0:close()
	end

	return var_85_0 ~= nil
end

function string:split(arg_86_1)
	local var_86_0 = {}

	self:gsub(string.format("([^%s]+)", arg_86_1 or "\t"), function(arg_87_0)
		var_86_0[#var_86_0 + 1] = arg_87_0
	end)

	return var_86_0
end

function parse_time(arg_88_0)
	local var_88_0 = string.split(arg_88_0, " ")
	local var_88_1 = string.split(var_88_0[1], "-")
	local var_88_2 = string.split(var_88_0[2], ":")

	return {
		year = tonumber(var_88_1[1]),
		month = tonumber(var_88_1[2]),
		day = tonumber(var_88_1[3]),
		hour = tonumber(var_88_2[1]),
		min = tonumber(var_88_2[2]),
		sec = tonumber(var_88_2[3])
	}
end

function io.pathinfo(arg_89_0)
	local var_89_0 = string.len(arg_89_0)
	local var_89_1 = var_89_0 + 1

	::label_89_0::

	local var_89_3
	local var_89_4

	if var_89_0 > 0 then
		repeat
			local var_89_2 = string.byte(arg_89_0, var_89_0)

			if var_89_2 == 46 then
				var_89_1 = var_89_0
			elseif var_89_2 == 47 then
				break
			end

			var_89_0 = var_89_0 - 1

			goto label_89_0
		until true

		var_89_3 = string.sub(arg_89_0, var_89_0 + 1)
		var_89_4 = {}
	end

	var_89_4.dirname = string.sub(arg_89_0, 1, var_89_0)
	var_89_4.filename = var_89_3
	var_89_4.basename = string.sub(var_89_3, 1, var_89_1 - var_89_0 - 1)
	var_89_4.extname = string.sub(var_89_3, var_89_1 - var_89_0)

	return var_89_4
end
