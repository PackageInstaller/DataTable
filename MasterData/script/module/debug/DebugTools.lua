local var_0_0 = {}

function var_0_0.getFileSource()
	for iter_1_0, iter_1_1 in pairs((debug.getinfo(1, "S"))) do
		if iter_1_0 == "source" then
			return iter_1_1
		end
	end
end

function var_0_0.printTable(arg_2_0, arg_2_1, arg_2_2)
	print((var_0_0.show(arg_2_0, arg_2_1, arg_2_2)))
end

function var_0_0.serializeTable(arg_3_0, arg_3_1, arg_3_2)
	return (var_0_0.show(arg_3_0, arg_3_1, arg_3_2))
end

function var_0_0.show(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0
	local var_4_1

	local function var_4_2(arg_5_0)
		return next(arg_5_0) == nil
	end

	local function var_4_3(arg_6_0)
		local var_6_0 = tostring(arg_6_0)

		if type(arg_6_0) == "function" then
			local var_6_1 = debug.getinfo(arg_6_0, "S")

			if var_6_1.what == "C" then
				return string.format("%q", var_6_0 .. ", C function")
			else
				return string.format("%q", var_6_0 .. ", defined in (" .. var_6_1.linedefined .. "-" .. var_6_1.lastlinedefined .. ")" .. var_6_1.source)
			end
		elseif type(arg_6_0) == "number" or type(arg_6_0) == "boolean" then
			return var_6_0
		else
			return string.format("%q", var_6_0)
		end
	end

	local function var_4_4(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
		arg_7_2 = arg_7_2 or ""
		arg_7_3 = arg_7_3 or {}
		arg_7_4 = arg_7_4 or arg_7_1
		var_4_0 = var_4_0 .. arg_7_2 .. arg_7_4

		if type(arg_7_0) ~= "table" then
			var_4_0 = var_4_0 .. " = " .. var_4_3(arg_7_0) .. ";\n"
		elseif arg_7_3[arg_7_0] then
			var_4_0 = var_4_0 .. " = {}; -- " .. arg_7_3[arg_7_0] .. " (self reference)\n"
			var_4_1 = var_4_1 .. arg_7_1 .. " = " .. arg_7_3[arg_7_0] .. ";\n"
		else
			arg_7_3[arg_7_0] = arg_7_1

			if var_4_2(arg_7_0) then
				var_4_0 = var_4_0 .. " = {};\n"
			else
				var_4_0 = var_4_0 .. " = {\n"

				for iter_7_0, iter_7_1 in pairs(arg_7_0) do
					iter_7_0 = var_4_3(iter_7_0)
					arg_7_4 = string.format("[%s]", iter_7_0)

					var_4_4(iter_7_1, string.format("%s[%s]", arg_7_1, iter_7_0), arg_7_2 .. "   ", arg_7_3, arg_7_4)
				end

				var_4_0 = var_4_0 .. arg_7_2 .. "};\n"
			end
		end
	end

	arg_4_1 = arg_4_1 or "PRINT_Table"

	if type(arg_4_0) ~= "table" then
		do return arg_4_1 .. " = " .. var_4_3(arg_4_0) end

		var_4_1 = ""
	end

	var_4_0 = ""

	var_4_4(arg_4_0, arg_4_1, arg_4_2)

	return var_4_0 .. var_4_1
end

function var_0_0.createJson()
	local math = require("math")
	local string = require("string")
	local table = require("table")
	local var_8_3 = {}
	local var_8_4 = {}

	var_8_3.EMPTY_ARRAY = {}
	var_8_3.EMPTY_OBJECT = {}

	local var_8_5
	local var_8_6
	local var_8_7
	local var_8_8
	local var_8_9
	local var_8_10
	local var_8_11
	local var_8_13
	local var_8_14

	function var_8_3:encode()
		if self == nil then
			return "null"
		end

		local var_9_0 = type(self)

		if var_9_0 == "string" then
			return "\"" .. var_8_4.encodeString(self) .. "\""
		end

		if var_9_0 == "number" or var_9_0 == "boolean" then
			return tostring(self)
		end

		if var_9_0 == "table" then
			local var_9_1 = {}
			local var_9_2, var_9_3 = var_8_13(self)

			if var_9_2 then
				for iter_9_0 = 1, var_9_3 do
					table.insert(var_9_1, var_8_3.encode(self[iter_9_0]))
				end
			else
				for iter_9_1, iter_9_2 in pairs(self) do
					if var_8_14(iter_9_1) and var_8_14(iter_9_2) then
						table.insert(var_9_1, "\"" .. var_8_4.encodeString(iter_9_1) .. "\":" .. var_8_3.encode(iter_9_2))
					end
				end
			end

			if var_9_2 then
				return "[" .. table.concat(var_9_1, ",") .. "]"
			else
				return "{" .. table.concat(var_9_1, ",") .. "}"
			end
		end

		if var_9_0 == "function" and self == var_8_3.null then
			return "null"
		end

		assert(false, "encode attempt to encode unsupported type " .. var_9_0 .. ":" .. tostring(self))
	end

	function var_8_3.decode(arg_10_0, arg_10_1)
		arg_10_1 = arg_10_1 and arg_10_1 or 1
		arg_10_1 = var_8_11(arg_10_0, arg_10_1)

		assert(arg_10_1 <= string.len(arg_10_0), "Unterminated JSON encoded object found at position in [" .. arg_10_0 .. "]")

		local var_10_0 = string.sub(arg_10_0, arg_10_1, arg_10_1)

		if var_10_0 == "{" then
			return var_8_9(arg_10_0, arg_10_1)
		end

		if var_10_0 == "[" then
			return var_8_5(arg_10_0, arg_10_1)
		end

		if string.find("+-0123456789.e", var_10_0, 1, true) then
			return var_8_8(arg_10_0, arg_10_1)
		end

		if var_10_0 == "\"" or var_10_0 == "'" then
			return var_8_10(arg_10_0, arg_10_1)
		end

		if string.sub(arg_10_0, arg_10_1, arg_10_1 + 1) == "/*" then
			return var_8_3.decode(arg_10_0, var_8_6(arg_10_0, arg_10_1))
		end

		return var_8_7(arg_10_0, arg_10_1)
	end

	function var_8_3.null()
		return var_8_3.null
	end

	function var_8_5(arg_12_0, arg_12_1)
		local var_12_0 = {}
		local var_12_1 = string.len(arg_12_0)

		assert(string.sub(arg_12_0, arg_12_1, arg_12_1) == "[", "decode_scanArray called but array does not start at position " .. arg_12_1 .. " in string:\n" .. arg_12_0)

		arg_12_1 = arg_12_1 + 1

		local var_12_2 = 1

		repeat
			arg_12_1 = var_8_11(arg_12_0, arg_12_1)

			assert(arg_12_1 <= var_12_1, "JSON String ended unexpectedly scanning array.")

			local var_12_3 = string.sub(arg_12_0, arg_12_1, arg_12_1)

			if var_12_3 == "]" then
				return var_12_0, arg_12_1 + 1
			end

			if var_12_3 == "," then
				arg_12_1 = var_8_11(arg_12_0, arg_12_1 + 1)
			end

			assert(arg_12_1 <= var_12_1, "JSON String ended unexpectedly scanning array.")

			object, arg_12_1 = var_8_3.decode(arg_12_0, arg_12_1)
			var_12_0[var_12_2] = object
			var_12_2 = var_12_2 + 1
		until false
	end

	function var_8_6(arg_13_0, arg_13_1)
		assert(string.sub(arg_13_0, arg_13_1, arg_13_1 + 1) == "/*", "decode_scanComment called but comment does not start at position " .. arg_13_1)

		local var_13_0 = string.find(arg_13_0, "*/", arg_13_1 + 2)

		assert(var_13_0 ~= nil, "Unterminated comment in string at " .. arg_13_1)

		return var_13_0 + 2
	end

	function var_8_7(arg_14_0, arg_14_1)
		local var_14_0 = {
			["false"] = false,
			["true"] = true
		}

		for iter_14_0, iter_14_1 in pairs({
			"true",
			"false",
			"null"
		}) do
			if string.sub(arg_14_0, arg_14_1, arg_14_1 + string.len(iter_14_1) - 1) == iter_14_1 then
				return var_14_0[iter_14_1], arg_14_1 + string.len(iter_14_1)
			end
		end

		assert(nil, "Failed to scan constant from string " .. arg_14_0 .. " at starting position " .. arg_14_1)
	end

	function var_8_8(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_1 + 1

		while string.find("+-0123456789.e", string.sub(arg_15_0, var_15_0, var_15_0), 1, true) and var_15_0 <= string.len(arg_15_0) do
			var_15_0 = var_15_0 + 1
		end

		return string.sub(arg_15_0, arg_15_1, var_15_0 - 1), var_15_0
	end

	function var_8_9(arg_16_0, arg_16_1)
		local var_16_0 = {}
		local var_16_1 = string.len(arg_16_0)

		assert(string.sub(arg_16_0, arg_16_1, arg_16_1) == "{", "decode_scanObject called but object does not start at position " .. arg_16_1 .. " in string:\n" .. arg_16_0)

		arg_16_1 = arg_16_1 + 1

		repeat
			arg_16_1 = var_8_11(arg_16_0, arg_16_1)

			assert(arg_16_1 <= var_16_1, "JSON string ended unexpectedly while scanning object.")

			local var_16_4 = string.sub(arg_16_0, arg_16_1, arg_16_1)

			if var_16_4 == "}" then
				return var_16_0, arg_16_1 + 1
			end

			if var_16_4 == "," then
				arg_16_1 = var_8_11(arg_16_0, arg_16_1 + 1)
			end

			assert(arg_16_1 <= var_16_1, "JSON string ended unexpectedly scanning object.")

			local var_16_5

			var_16_5, arg_16_1 = var_8_3.decode(arg_16_0, arg_16_1)

			assert(arg_16_1 <= var_16_1, "JSON string ended unexpectedly searching for value of key " .. var_16_5)

			arg_16_1 = var_8_11(arg_16_0, arg_16_1)

			assert(arg_16_1 <= var_16_1, "JSON string ended unexpectedly searching for value of key " .. var_16_5)
			assert(string.sub(arg_16_0, arg_16_1, arg_16_1) == ":", "JSON object key-value assignment mal-formed at " .. arg_16_1)

			arg_16_1 = var_8_11(arg_16_0, arg_16_1 + 1)

			assert(arg_16_1 <= var_16_1, "JSON string ended unexpectedly searching for value of key " .. var_16_5)

			var_16_0[var_16_5], arg_16_1 = var_8_3.decode(arg_16_0, arg_16_1)
		until false
	end

	local var_8_15 = {
		["\\n"] = "\n",
		["\\t"] = "\t",
		["\\f"] = "\f",
		["\\r"] = "\r",
		["\\b"] = "\b"
	}

	setmetatable(var_8_15, {
		__index = function(arg_17_0, arg_17_1)
			return string.sub(arg_17_1, 2)
		end
	})

	function var_8_10(arg_18_0, arg_18_1)
		assert(arg_18_1, "decode_scanString(..) called without start position")

		local var_18_0 = string.sub(arg_18_0, arg_18_1, arg_18_1)

		assert(var_18_0 == "\"" or var_18_0 == "'", "decode_scanString called for a non-string")

		local var_18_1 = {}
		local var_18_3 = arg_18_1

		while string.find(arg_18_0, var_18_0, var_18_3 + 1) ~= var_18_3 + 1 do
			local var_18_4 = var_18_3
			local var_18_5

			var_18_5, var_18_3 = string.find(arg_18_0, "\\.", var_18_3 + 1)

			local var_18_6, var_18_7 = string.find(arg_18_0, var_18_0, var_18_4 + 1)

			if var_18_5 then
				if var_18_6 < var_18_5 then
					var_18_3 = var_18_7 - 1
					var_18_5 = var_18_6
				end
			end

			table.insert(var_18_1, string.sub(arg_18_0, var_18_4 + 1, var_18_5 - 1))

			if string.sub(arg_18_0, var_18_5, var_18_3) == "\\u" then
				local var_18_8 = string.sub(arg_18_0, var_18_3 + 1, var_18_3 + 4)

				var_18_3 = var_18_3 + 4

				local var_18_9 = tonumber(var_18_8, 16)

				assert(var_18_9, "String decoding failed: bad Unicode escape " .. var_18_8 .. " at position " .. var_18_5 .. " : " .. var_18_3)
				table.insert(var_18_1, var_18_9 < 128 and string.char(var_18_9 % 128) or var_18_9 < 2048 and string.char(192 + math.floor(var_18_9 / 64) % 32, 128 + var_18_9 % 64) or string.char(224 + math.floor(var_18_9 / 4096) % 16, 128 + math.floor(var_18_9 / 64) % 64, 128 + var_18_9 % 64))
			else
				table.insert(var_18_1, var_8_15[string.sub(arg_18_0, var_18_5, var_18_3)])
			end
		end

		table.insert(var_18_1, string.sub(var_18_3, var_18_3 + 1))
		assert(string.find(arg_18_0, var_18_0, var_18_3 + 1), "String decoding failed: missing closing " .. var_18_0 .. " at position " .. var_18_3 .. "(for string at position " .. arg_18_1 .. ")")

		return table.concat(var_18_1, ""), var_18_3 + 2
	end

	function var_8_11(arg_19_0, arg_19_1)
		while string.find(" \n\r\t", string.sub(arg_19_0, arg_19_1, arg_19_1), 1, true) and arg_19_1 <= string.len(arg_19_0) do
			arg_19_1 = arg_19_1 + 1
		end

		return arg_19_1
	end

	local var_8_16 = {
		["\f"] = "\\f",
		["\b"] = "\\b",
		["\n"] = "\\n",
		["\r"] = "\\r",
		["\t"] = "\\t",
		["\\"] = "\\\\",
		["/"] = "\\/",
		["\""] = "\\\""
	}

	function var_8_4.encodeString(arg_20_0)
		return tostring(arg_20_0):gsub(".", function(arg_21_0)
			return var_8_16[arg_21_0]
		end)
	end

	function var_8_13(arg_22_0)
		if arg_22_0 == var_8_3.EMPTY_ARRAY then
			return true, 0
		end

		if arg_22_0 == var_8_3.EMPTY_OBJECT then
			return false
		end

		local var_22_0 = 0

		for iter_22_0, iter_22_1 in pairs(arg_22_0) do
			if type(iter_22_0) == "number" and math.floor(iter_22_0) == iter_22_0 and iter_22_0 >= 1 then
				if not var_8_14(iter_22_1) then
					return false
				end

				var_22_0 = math.max(var_22_0, iter_22_0)
			elseif iter_22_0 == "n" then
				if iter_22_1 ~= (arg_22_0.n or #arg_22_0) then
					return false
				end
			elseif var_8_14(iter_22_1) then
				return false
			end
		end

		return true, var_22_0
	end

	function var_8_14(arg_23_0)
		local var_23_0 = type(arg_23_0)

		return var_23_0 == "string" or var_23_0 == "boolean" or var_23_0 == "number" or var_23_0 == "nil" or var_23_0 == "table" or var_23_0 == "function" and arg_23_0 == var_8_3.null
	end

	return var_8_3
end

return var_0_0
