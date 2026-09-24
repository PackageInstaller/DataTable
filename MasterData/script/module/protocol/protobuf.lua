local c = require("protobuf.c")
local var_0_1 = setmetatable
local var_0_2 = type
local var_0_3 = table
local var_0_4 = assert
local var_0_5 = pairs
local var_0_6 = ipairs
local var_0_7 = string
local var_0_9 = io
local var_0_10 = table.insert
local var_0_11 = rawget
local var_0_12 = rawset
local var_0_13 = {}
local var_0_14 = c._env_new()
local var_0_15 = c._gc(var_0_14)
local var_0_16 = {}
local var_0_17 = {
	__index = function(self, arg_2_1)
		local var_2_0 = var_0_16[self._CType][arg_2_1](self, arg_2_1)

		self[arg_2_1] = var_2_0

		return var_2_0
	end
}
local var_0_18 = {
	int = function(self, arg_3_1)
		return c._rmessage_integer(self._CObj, arg_3_1, 0)
	end,
	real = function(self, arg_4_1)
		return c._rmessage_real(self._CObj, arg_4_1, 0)
	end,
	string = function(self, arg_5_1)
		return c._rmessage_string(self._CObj, arg_5_1, 0)
	end,
	bool = function(self, arg_6_1)
		return c._rmessage_integer(self._CObj, arg_6_1, 0) ~= 0
	end,
	message = function(self, arg_7_1, arg_7_2)
		local var_7_0 = c._rmessage_message(self._CObj, arg_7_1, 0)

		if var_7_0 then
			return var_0_1({
				_CObj = var_7_0,
				_CType = arg_7_2,
				_Parent = self
			}, var_0_17)
		end
	end,
	int32 = function(self, arg_8_1)
		return c._rmessage_int32(self._CObj, arg_8_1, 0)
	end,
	int64 = function(self, arg_9_1)
		return c._rmessage_int64(self._CObj, arg_9_1, 0)
	end,
	int52 = function(self, arg_10_1)
		return c._rmessage_int52(self._CObj, arg_10_1, 0)
	end,
	uint52 = function(self, arg_11_1)
		return c._rmessage_uint52(self._CObj, arg_11_1, 0)
	end,
	int_repeated = function(self, arg_12_1)
		local var_12_0 = {}

		for iter_12_0 = 0, c._rmessage_size(self._CObj, arg_12_1) - 1 do
			var_0_10(var_12_0, c._rmessage_integer(self._CObj, arg_12_1, iter_12_0))
		end

		return var_12_0
	end,
	real_repeated = function(self, arg_13_1)
		local var_13_0 = {}

		for iter_13_0 = 0, c._rmessage_size(self._CObj, arg_13_1) - 1 do
			var_0_10(var_13_0, c._rmessage_real(self._CObj, arg_13_1, iter_13_0))
		end

		return var_13_0
	end,
	string_repeated = function(self, arg_14_1)
		local var_14_0 = {}

		for iter_14_0 = 0, c._rmessage_size(self._CObj, arg_14_1) - 1 do
			var_0_10(var_14_0, c._rmessage_string(self._CObj, arg_14_1, iter_14_0))
		end

		return var_14_0
	end,
	bool_repeated = function(self, arg_15_1)
		local var_15_0 = {}

		for iter_15_0 = 0, c._rmessage_size(self._CObj, arg_15_1) - 1 do
			var_0_10(var_15_0, c._rmessage_integer(self._CObj, arg_15_1, iter_15_0) ~= 0)
		end

		return var_15_0
	end,
	message_repeated = function(self, arg_16_1, arg_16_2)
		local var_16_0 = {}

		for iter_16_0 = 0, c._rmessage_size(self._CObj, arg_16_1) - 1 do
			var_0_10(var_16_0, var_0_1({
				_CObj = c._rmessage_message(self._CObj, arg_16_1, iter_16_0),
				_CType = arg_16_2,
				_Parent = self
			}, var_0_17))
		end

		return var_16_0
	end,
	int32_repeated = function(self, arg_17_1)
		local var_17_0 = {}

		for iter_17_0 = 0, c._rmessage_size(self._CObj, arg_17_1) - 1 do
			var_0_10(var_17_0, c._rmessage_int32(self._CObj, arg_17_1, iter_17_0))
		end

		return var_17_0
	end,
	int64_repeated = function(self, arg_18_1)
		local var_18_0 = {}

		for iter_18_0 = 0, c._rmessage_size(self._CObj, arg_18_1) - 1 do
			var_0_10(var_18_0, c._rmessage_int64(self._CObj, arg_18_1, iter_18_0))
		end

		return var_18_0
	end,
	int52_repeated = function(self, arg_19_1)
		local var_19_0 = {}

		for iter_19_0 = 0, c._rmessage_size(self._CObj, arg_19_1) - 1 do
			var_0_10(var_19_0, c._rmessage_int52(self._CObj, arg_19_1, iter_19_0))
		end

		return var_19_0
	end,
	uint52_repeated = function(self, arg_20_1)
		local var_20_0 = {}

		for iter_20_0 = 0, c._rmessage_size(self._CObj, arg_20_1) - 1 do
			var_0_10(var_20_0, c._rmessage_uint52(self._CObj, arg_20_1, iter_20_0))
		end

		return var_20_0
	end
}

var_0_18[1] = function(arg_21_0)
	return var_0_18.int
end
var_0_18[2] = function(arg_22_0)
	return var_0_18.real
end
var_0_18[3] = function(arg_23_0)
	return var_0_18.bool
end
var_0_18[4] = function(arg_24_0)
	return var_0_18.string
end
var_0_18[5] = function(arg_25_0)
	return var_0_18.string
end
var_0_18[6] = function(arg_26_0)
	local var_26_0 = var_0_18.message

	return function(arg_27_0, arg_27_1)
		return var_26_0(arg_27_0, arg_27_1, arg_26_0)
	end
end
var_0_18[7] = function(arg_28_0)
	return var_0_18.int64
end
var_0_18[8] = function(arg_29_0)
	return var_0_18.int32
end
var_0_18[9] = var_0_18[5]
var_0_18[10] = function(arg_30_0)
	return var_0_18.int52
end
var_0_18[11] = function(arg_31_0)
	return var_0_18.uint52
end
var_0_18[129] = function(arg_32_0)
	return var_0_18.int_repeated
end
var_0_18[130] = function(arg_33_0)
	return var_0_18.real_repeated
end
var_0_18[131] = function(arg_34_0)
	return var_0_18.bool_repeated
end
var_0_18[132] = function(arg_35_0)
	return var_0_18.string_repeated
end
var_0_18[133] = function(arg_36_0)
	return var_0_18.string_repeated
end
var_0_18[134] = function(arg_37_0)
	local var_37_0 = var_0_18.message_repeated

	return function(arg_38_0, arg_38_1)
		return var_37_0(arg_38_0, arg_38_1, arg_37_0)
	end
end
var_0_18[135] = function(arg_39_0)
	return var_0_18.int64_repeated
end
var_0_18[136] = function(arg_40_0)
	return var_0_18.int32_repeated
end
var_0_18[137] = var_0_18[133]
var_0_18[138] = function(arg_41_0)
	return var_0_18.int52_repeated
end
var_0_18[139] = function(arg_42_0)
	return var_0_18.uint52_repeated
end

local var_0_19 = {
	__index = function(self, arg_43_1)
		local var_43_0, var_43_1 = c._env_type(var_0_14, self._CType, arg_43_1)
		local var_43_2 = var_0_4(var_0_18[var_43_0], arg_43_1)(var_43_1)

		self[arg_43_1] = var_43_2

		return var_43_2
	end
}

setmetatable(var_0_16, {
	__index = function(arg_44_0, arg_44_1)
		local var_44_0 = var_0_1({
			_CType = arg_44_1
		}, var_0_19)

		arg_44_0[arg_44_1] = var_44_0

		return var_44_0
	end
})

local function var_0_20(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = c._rmessage_new(var_0_14, arg_45_0, arg_45_1, arg_45_2)

	if var_45_0 then
		c._add_rmessage(var_0_15, var_45_0)

		return var_0_1({
			_CObj = var_45_0,
			_CType = arg_45_0
		}, var_0_17)
	end
end

local var_0_21 = {}

local function var_0_22(arg_46_0, arg_46_1, arg_46_2)
	for iter_46_0, iter_46_1 in var_0_5(arg_46_2) do
		var_0_21[arg_46_1][iter_46_0](arg_46_0, iter_46_0, iter_46_1)
	end
end

local var_0_23 = {
	int = c._wmessage_integer,
	real = c._wmessage_real,
	enum = c._wmessage_string,
	string = c._wmessage_string,
	int64 = c._wmessage_int64,
	int32 = c._wmessage_int32,
	int52 = c._wmessage_int52,
	uint52 = c._wmessage_uint52,
	bool = function(arg_47_0, arg_47_1, arg_47_2)
		c._wmessage_integer(arg_47_0, arg_47_1, arg_47_2 and 1 or 0)
	end,
	message = function(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
		var_0_22(c._wmessage_message(arg_48_0, arg_48_1), arg_48_3, arg_48_2)
	end,
	int_repeated = function(arg_49_0, arg_49_1, arg_49_2)
		for iter_49_0, iter_49_1 in var_0_6(arg_49_2) do
			c._wmessage_integer(arg_49_0, arg_49_1, iter_49_1)
		end
	end,
	real_repeated = function(arg_50_0, arg_50_1, arg_50_2)
		for iter_50_0, iter_50_1 in var_0_6(arg_50_2) do
			c._wmessage_real(arg_50_0, arg_50_1, iter_50_1)
		end
	end,
	bool_repeated = function(arg_51_0, arg_51_1, arg_51_2)
		for iter_51_0, iter_51_1 in var_0_6(arg_51_2) do
			c._wmessage_integer(arg_51_0, arg_51_1, iter_51_1 and 1 or 0)
		end
	end,
	string_repeated = function(arg_52_0, arg_52_1, arg_52_2)
		for iter_52_0, iter_52_1 in var_0_6(arg_52_2) do
			c._wmessage_string(arg_52_0, arg_52_1, iter_52_1)
		end
	end,
	message_repeated = function(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
		for iter_53_0, iter_53_1 in var_0_6(arg_53_2) do
			var_0_22(c._wmessage_message(arg_53_0, arg_53_1), arg_53_3, iter_53_1)
		end
	end,
	int32_repeated = function(arg_54_0, arg_54_1, arg_54_2)
		for iter_54_0, iter_54_1 in var_0_6(arg_54_2) do
			c._wmessage_int32(arg_54_0, arg_54_1, iter_54_1)
		end
	end,
	int64_repeated = function(arg_55_0, arg_55_1, arg_55_2)
		for iter_55_0, iter_55_1 in var_0_6(arg_55_2) do
			c._wmessage_int64(arg_55_0, arg_55_1, iter_55_1)
		end
	end,
	int52_repeated = function(arg_56_0, arg_56_1, arg_56_2)
		for iter_56_0, iter_56_1 in var_0_6(arg_56_2) do
			c._wmessage_int52(arg_56_0, arg_56_1, iter_56_1)
		end
	end,
	uint52_repeated = function(arg_57_0, arg_57_1, arg_57_2)
		for iter_57_0, iter_57_1 in var_0_6(arg_57_2) do
			c._wmessage_uint52(arg_57_0, arg_57_1, iter_57_1)
		end
	end
}

var_0_23[1] = function(arg_58_0)
	return var_0_23.int
end
var_0_23[2] = function(arg_59_0)
	return var_0_23.real
end
var_0_23[3] = function(arg_60_0)
	return var_0_23.bool
end
var_0_23[4] = function(arg_61_0)
	return var_0_23.string
end
var_0_23[5] = function(arg_62_0)
	return var_0_23.string
end
var_0_23[6] = function(arg_63_0)
	local var_63_0 = var_0_23.message

	return function(arg_64_0, arg_64_1, arg_64_2)
		return var_63_0(arg_64_0, arg_64_1, arg_64_2, arg_63_0)
	end
end
var_0_23[7] = function(arg_65_0)
	return var_0_23.int64
end
var_0_23[8] = function(arg_66_0)
	return var_0_23.int32
end
var_0_23[9] = var_0_23[5]
var_0_23[10] = function(arg_67_0)
	return var_0_23.int52
end
var_0_23[11] = function(arg_68_0)
	return var_0_23.uint52
end
var_0_23[129] = function(arg_69_0)
	return var_0_23.int_repeated
end
var_0_23[130] = function(arg_70_0)
	return var_0_23.real_repeated
end
var_0_23[131] = function(arg_71_0)
	return var_0_23.bool_repeated
end
var_0_23[132] = function(arg_72_0)
	return var_0_23.string_repeated
end
var_0_23[133] = function(arg_73_0)
	return var_0_23.string_repeated
end
var_0_23[134] = function(arg_74_0)
	local var_74_0 = var_0_23.message_repeated

	return function(arg_75_0, arg_75_1, arg_75_2)
		return var_74_0(arg_75_0, arg_75_1, arg_75_2, arg_74_0)
	end
end
var_0_23[135] = function(arg_76_0)
	return var_0_23.int64_repeated
end
var_0_23[136] = function(arg_77_0)
	return var_0_23.int32_repeated
end
var_0_23[137] = var_0_23[133]
var_0_23[138] = function(arg_78_0)
	return var_0_23.int52_repeated
end
var_0_23[139] = function(arg_79_0)
	return var_0_23.uint52_repeated
end

local var_0_24 = {
	__index = function(self, arg_80_1)
		local var_80_0, var_80_1 = c._env_type(var_0_14, self._CType, arg_80_1)
		local var_80_2 = var_0_4(var_0_23[var_80_0], arg_80_1)(var_80_1)

		self[arg_80_1] = var_80_2

		return var_80_2
	end
}

setmetatable(var_0_21, {
	__index = function(arg_81_0, arg_81_1)
		local var_81_0 = var_0_1({
			_CType = arg_81_1
		}, var_0_24)

		arg_81_0[arg_81_1] = var_81_0

		return var_81_0
	end
})

local var_0_25 = {
	{
		"%d",
		"i"
	},
	{
		"%F",
		"r"
	},
	{
		"%d",
		"b"
	},
	{
		"%d",
		"i"
	},
	{
		"%s",
		"s"
	},
	{
		"%s",
		"m"
	},
	{
		"%D",
		"x"
	},
	{
		"%d",
		"p"
	},
	[10] = {
		"%D",
		"d"
	},
	[11] = {
		"%D",
		"u"
	},
	[129] = {
		"%a",
		"I"
	},
	[130] = {
		"%a",
		"R"
	},
	[131] = {
		"%a",
		"B"
	},
	[132] = {
		"%a",
		"I"
	},
	[133] = {
		"%a",
		"S"
	},
	[134] = {
		"%a",
		"M"
	},
	[135] = {
		"%a",
		"X"
	},
	[136] = {
		"%a",
		"P"
	},
	[138] = {
		"%a",
		"D"
	},
	[139] = {
		"%a",
		"U"
	}
}

var_0_25[9] = var_0_25[5]
var_0_25[137] = var_0_25[133]

local function var_0_26(arg_83_0)
	local var_83_0 = var_0_7.gmatch(arg_83_0, "[^ ]+")
	local var_83_1 = var_83_0()
	local var_83_2 = {}
	local var_83_3 = {}

	for iter_83_0 in var_83_0 do
		local var_83_4 = c._env_type(var_0_14, var_83_1, iter_83_0)

		var_0_4(var_0_25[var_83_4], var_83_4)
		var_0_10(var_83_2, iter_83_0 .. " " .. var_0_25[var_83_4][1])
		var_0_10(var_83_3, var_0_25[var_83_4][2])
	end

	local var_83_5 = c._pattern_new(var_0_14, var_83_1, "@" .. var_0_3.concat(var_83_2, " "))

	if var_83_5 == nil then
		return
	end

	c._add_pattern(var_0_15, var_83_5)

	local var_83_6 = {
		size = 0,
		CObj = var_83_5,
		format = var_0_3.concat(var_83_3)
	}

	var_83_6.size = c._pattern_size(var_83_6.format)

	return var_83_6
end

setmetatable(var_0_13, {
	__index = function(arg_84_0, arg_84_1)
		local var_84_0 = var_0_26(arg_84_1)

		arg_84_0[arg_84_1] = var_84_0

		return var_84_0
	end
})

local function var_0_27(arg_87_0, arg_87_1)
	if arg_87_1 == nil then
		return c._env_type(var_0_14, arg_87_0)
	else
		return c._env_type(var_0_14, arg_87_0, arg_87_1) ~= 0
	end
end

local var_0_28 = {}

local function var_0_29(arg_88_0)
	if var_0_28[arg_88_0] then
		return var_0_28[arg_88_0]
	end

	local var_88_0 = var_0_4(var_0_20(arg_88_0, ""))
	local var_88_1 = {
		__index = function(arg_89_0, arg_89_1)
			if var_0_2(var_88_0[arg_89_1]) ~= "table" then
				return var_88_0[arg_89_1]
			end

			local var_89_0 = var_0_1({}, {
				__index = var_88_0[arg_89_1]
			})

			var_0_12(arg_89_0, arg_89_1, var_89_0)

			return var_89_0
		end
	}

	var_0_28[arg_88_0] = var_88_1

	return var_88_1
end

local var_0_30 = {}

local function var_0_31(arg_90_0, arg_90_1)
	return var_0_1({
		arg_90_0,
		arg_90_1
	}, var_0_30)
end

local function var_0_32(arg_91_0, arg_91_1, arg_91_2)
	local var_91_0 = {}

	if c._decode(var_0_14, var_0_31, var_91_0, arg_91_0, arg_91_1, arg_91_2) then
		return var_0_1(var_91_0, var_0_29(arg_91_0))
	else
		return false, c._last_error(var_0_14)
	end
end

local function var_0_33(arg_92_0)
	local var_92_0 = var_0_11(arg_92_0, 1)

	arg_92_0[1], arg_92_0[2] = nil

	var_0_4(c._decode(var_0_14, var_0_31, arg_92_0, var_92_0, (var_0_11(arg_92_0, 2))), var_92_0)
	var_0_1(arg_92_0, var_0_29(var_92_0))
end

function var_0_30:__index(arg_93_1)
	var_0_33(self)

	return self[arg_93_1]
end

function var_0_30.__pairs(arg_94_0)
	var_0_33(arg_94_0)

	return var_0_5(arg_94_0)
end

local function var_0_34(arg_95_0, arg_95_1)
	for iter_95_0, iter_95_1 in var_0_5(arg_95_1) do
		if var_0_2(iter_95_1) == "table" then
			local var_95_0, var_95_1 = c._env_type(var_0_14, arg_95_0, iter_95_0)

			if var_95_0 == 6 then
				var_0_34(var_95_1, iter_95_1)
			elseif var_95_0 == 134 then
				for iter_95_2, iter_95_3 in var_0_6(iter_95_1) do
					var_0_34(var_95_1, iter_95_3)
				end
			end
		end
	end

	return var_0_1(arg_95_1, var_0_29(arg_95_0))
end

local function var_0_35(arg_99_0)
	local var_99_0 = var_0_11(arg_99_0, 1)

	if var_0_2(var_99_0) == "string" and var_0_2((var_0_11(arg_99_0, 2))) == "string" and var_0_27(var_99_0) then
		var_0_33(arg_99_0)
	end

	for iter_99_0, iter_99_1 in var_0_5(arg_99_0) do
		if var_0_2(iter_99_1) == "table" then
			var_0_35(iter_99_1)
		end
	end
end

return {
	lasterror = function()
		return c._last_error(var_0_14)
	end,
	encode = function(arg_82_0, arg_82_1, arg_82_2, ...)
		local var_82_0 = c._wmessage_new(var_0_14, arg_82_0)

		var_0_4(var_82_0, arg_82_0)
		var_0_22(var_82_0, arg_82_0, arg_82_1)

		if arg_82_2 then
			local var_82_1, var_82_2 = c._wmessage_buffer(var_82_0)

			c._wmessage_delete(var_82_0)

			return (arg_82_2(var_82_1, var_82_2, ...))
		else
			local var_82_3 = c._wmessage_buffer_string(var_82_0)

			c._wmessage_delete(var_82_0)

			return var_82_3
		end
	end,
	decode = function(...)
		local var_100_0, var_100_1 = var_0_32(...)

		if var_100_0 then
			var_0_35(var_100_0)

			return var_100_0
		end

		return nil, var_100_1
	end,
	unpack = function(arg_85_0, arg_85_1, arg_85_2)
		return c._pattern_unpack(var_0_13[arg_85_0].CObj, var_0_13[arg_85_0].format, var_0_13[arg_85_0].size, arg_85_1, arg_85_2)
	end,
	pack = function(arg_86_0, ...)
		return c._pattern_pack(var_0_13[arg_86_0].CObj, var_0_13[arg_86_0].format, var_0_13[arg_86_0].size, ...)
	end,
	check = var_0_27,
	register = function(arg_96_0)
		c._env_register(var_0_14, arg_96_0)
	end,
	register_file = function(arg_97_0)
		local var_97_0 = var_0_4(var_0_9.open(arg_97_0, "rb"))

		c._env_register(var_0_14, (var_97_0:read("*a")))
		var_97_0:close()
	end,
	enum_id = function(arg_98_0, arg_98_1)
		return c._env_enum_id(var_0_14, arg_98_0, arg_98_1)
	end,
	extract = var_0_35,
	default = var_0_34
}
