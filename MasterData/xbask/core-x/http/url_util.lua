local var_0_0 = tonumber
local var_0_1 = string.gsub
local var_0_2 = string.format
local var_0_3 = string.byte
local var_0_4 = string.char
local var_0_5 = string.sub
local var_0_6 = table.insert
local var_0_7 = (function(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		var_3_0[arg_3_0[iter_3_0]] = 1
	end

	return var_3_0
end)({
	"-",
	"_",
	".",
	"!",
	"~",
	"*",
	"'",
	"(",
	")",
	":",
	"@",
	"&",
	"=",
	"+",
	"$",
	","
})

local function var_0_8(arg_4_0)
	return var_0_1(arg_4_0, "([^A-Za-z0-9_])", function(arg_5_0)
		if var_0_7[arg_5_0] then
			return arg_5_0
		else
			return var_0_2("%%%02x", var_0_3(arg_5_0))
		end
	end)
end

local function var_0_9(arg_6_0)
	return var_0_1(arg_6_0, "%%(%x%x)", function(arg_7_0)
		return var_0_4(var_0_0(arg_7_0, 16))
	end)
end

local function var_0_10(arg_8_0, arg_8_1)
	if var_0_5(arg_8_1, 1, 1) == "/" then
		return arg_8_1
	end

	local var_8_0 = var_0_1(var_0_1(var_0_1(arg_8_0, "[^/]*$", "") .. arg_8_1, "([^/]*%./)", function(arg_9_0)
		if arg_9_0 ~= "./" then
			return arg_9_0
		else
			return ""
		end
	end), "/%.$", "/")
	local var_8_1

	while var_8_1 ~= var_8_0 do
		var_8_1 = var_8_0
		var_8_0 = var_0_1(var_8_0, "([^/]*/%.%./)", function(arg_10_0)
			if arg_10_0 ~= "../../" then
				return ""
			else
				return arg_10_0
			end
		end)
	end

	return (var_0_1(var_8_1, "([^/]*/%.%.)$", function(arg_11_0)
		if arg_11_0 ~= "../.." then
			return ""
		else
			return arg_11_0
		end
	end))
end

local function var_0_11(arg_12_0, arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_1 or var_12_0) do
		var_12_0[iter_12_0] = iter_12_1
	end

	if not arg_12_0 or arg_12_0 == "" then
		return nil, "invalid url"
	end

	arg_12_0 = var_0_1(arg_12_0, "#(.*)$", function(arg_13_0)
		var_12_0.fragment = arg_13_0

		return ""
	end)
	arg_12_0 = var_0_1(arg_12_0, "^([%w][%w%+%-%.]*)%:", function(arg_14_0)
		var_12_0.scheme = arg_14_0

		return ""
	end)
	arg_12_0 = var_0_1(arg_12_0, "^//([^/]*)", function(arg_15_0)
		var_12_0.authority = arg_15_0

		return ""
	end)
	arg_12_0 = var_0_1(arg_12_0, "%?(.*)", function(arg_16_0)
		var_12_0.query = arg_16_0

		return ""
	end)
	arg_12_0 = var_0_1(arg_12_0, "%;(.*)", function(arg_17_0)
		var_12_0.params = arg_17_0

		return ""
	end)

	if arg_12_0 ~= "" then
		var_12_0.path = arg_12_0
	end

	local var_12_1 = var_12_0.authority

	if not var_12_0.authority then
		return var_12_0
	end

	local var_12_2 = var_0_1(var_0_1(var_12_1, "^([^@]*)@", function(arg_18_0)
		var_12_0.userinfo = arg_18_0

		return ""
	end), ":([^:]*)$", function(arg_19_0)
		var_12_0.port = arg_19_0

		return ""
	end)

	if var_12_2 ~= "" then
		var_12_0.host = var_12_2
	end

	local var_12_3 = var_12_0.userinfo

	if not var_12_0.userinfo then
		return var_12_0
	end

	var_12_0.user = var_0_1(var_12_3, ":([^:]*)$", function(arg_20_0)
		var_12_0.password = arg_20_0

		return ""
	end)

	return var_12_0
end

local function var_0_12(arg_21_0)
	local var_21_0 = {}

	arg_21_0 = arg_21_0 or ""

	var_0_1(arg_21_0, "([^/]+)", function(arg_22_0)
		var_0_6(var_21_0, arg_22_0)
	end)

	for iter_21_0 = 1, table.getn(var_21_0) do
		var_21_0[iter_21_0] = var_0_9(var_21_0[iter_21_0])
	end

	if var_0_5(arg_21_0, 1, 1) == "/" then
		var_21_0.is_absolute = 1
	end

	if var_0_5(arg_21_0, -1, -1) == "/" then
		var_21_0.is_directory = 1
	end

	return var_21_0
end

local function var_0_13(arg_23_0, arg_23_1)
	local var_23_0 = ""
	local var_23_1 = table.getn(arg_23_0)

	if arg_23_1 then
		for iter_23_0 = 1, var_23_1 - 1 do
			var_23_0 = var_23_0 .. arg_23_0[iter_23_0]
			var_23_0 = var_23_0 .. "/"
		end

		if var_23_1 > 0 then
			var_23_0 = var_23_0 .. arg_23_0[var_23_1]

			if arg_23_0.is_directory then
				var_23_0 = var_23_0 .. "/"
			end
		end
	else
		for iter_23_1 = 1, var_23_1 - 1 do
			var_23_0 = var_23_0 .. var_0_8(arg_23_0[iter_23_1])
			var_23_0 = var_23_0 .. "/"
		end

		if var_23_1 > 0 then
			var_23_0 = var_23_0 .. var_0_8(arg_23_0[var_23_1])

			if arg_23_0.is_directory then
				var_23_0 = var_23_0 .. "/"
			end
		end
	end

	if arg_23_0.is_absolute then
		var_23_0 = "/" .. var_23_0
	end

	return var_23_0
end

local function var_0_14(arg_24_0)
	local var_24_1 = var_0_13((var_0_12(arg_24_0.path or "")))

	if arg_24_0.params then
		var_24_1 = var_24_1 .. ";" .. arg_24_0.params
	end

	if arg_24_0.query then
		var_24_1 = var_24_1 .. "?" .. arg_24_0.query
	end

	local var_24_2 = arg_24_0.authority

	if arg_24_0.host then
		var_24_2 = arg_24_0.host

		if arg_24_0.port then
			var_24_2 = var_24_2 .. ":" .. arg_24_0.port
		end

		local var_24_3 = arg_24_0.userinfo

		if arg_24_0.user then
			var_24_3 = arg_24_0.user

			if arg_24_0.password then
				var_24_3 = var_24_3 .. ":" .. arg_24_0.password
			end
		end

		if var_24_3 then
			var_24_2 = var_24_3 .. "@" .. var_24_2
		end
	end

	if var_24_2 then
		var_24_1 = "//" .. var_24_2 .. var_24_1
	end

	if arg_24_0.scheme then
		var_24_1 = arg_24_0.scheme .. ":" .. var_24_1
	end

	if arg_24_0.fragment then
		var_24_1 = var_24_1 .. "#" .. arg_24_0.fragment
	end

	return var_24_1
end

return {
	escape = function(arg_1_0)
		return var_0_1(arg_1_0, "([^A-Za-z0-9_])", function(arg_2_0)
			return var_0_2("%%%02x", var_0_3(arg_2_0))
		end)
	end,
	unescape = var_0_9,
	parse = var_0_11,
	build = var_0_14,
	absolute = function(arg_25_0, arg_25_1)
		if type(arg_25_0) == "table" then
			base_parsed = arg_25_0
			arg_25_0 = var_0_14(base_parsed)
		else
			base_parsed = var_0_11(arg_25_0)
		end

		local var_25_0 = var_0_11(arg_25_1)

		if not base_parsed then
			return arg_25_1
		elseif not var_25_0 then
			return arg_25_0
		elseif var_25_0.scheme then
			return arg_25_1
		else
			var_25_0.scheme = base_parsed.scheme

			if not var_25_0.authority then
				var_25_0.authority = base_parsed.authority

				if not var_25_0.path then
					var_25_0.path = base_parsed.path

					if not var_25_0.params then
						var_25_0.params = base_parsed.params
						var_25_0.query = var_25_0.query or base_parsed.query
					end
				else
					var_25_0.path = var_0_10((not base_parsed.path or nil) and "", var_25_0.path)
				end
			end

			return var_0_14(var_25_0)
		end
	end,
	parse_path = var_0_12,
	build_path = var_0_13
}
