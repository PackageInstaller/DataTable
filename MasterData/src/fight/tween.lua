local var_0_0 = {}
local var_0_1 = math.pow
local var_0_2 = math.sin
local var_0_3 = math.cos
local var_0_4 = math.sqrt
local var_0_5 = math.abs
local var_0_6 = math.asin
local var_0_7 = 3.1415926

local function var_0_8(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	return arg_2_2 * var_0_1(arg_2_0 / arg_2_3, 2) + arg_2_1
end

local function var_0_9(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0 = arg_3_0 / arg_3_3

	return -arg_3_2 * arg_3_0 * (arg_3_0 - 2) + arg_3_1
end

local function var_0_10(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	return arg_6_2 * var_0_1(arg_6_0 / arg_6_3, 3) + arg_6_1
end

local function var_0_11(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return arg_7_2 * (var_0_1(arg_7_0 / arg_7_3 - 1, 3) + 1) + arg_7_1
end

local function var_0_12(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	return arg_10_2 * var_0_1(arg_10_0 / arg_10_3, 4) + arg_10_1
end

local function var_0_13(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return -arg_11_2 * (var_0_1(arg_11_0 / arg_11_3 - 1, 4) - 1) + arg_11_1
end

local function var_0_14(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	return arg_14_2 * var_0_1(arg_14_0 / arg_14_3, 5) + arg_14_1
end

local function var_0_15(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	return arg_15_2 * (var_0_1(arg_15_0 / arg_15_3 - 1, 5) + 1) + arg_15_1
end

local function var_0_16(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	return -arg_18_2 * var_0_3(arg_18_0 / arg_18_3 * (var_0_7 / 2)) + arg_18_2 + arg_18_1
end

local function var_0_17(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	return arg_19_2 * var_0_2(arg_19_0 / arg_19_3 * (var_0_7 / 2)) + arg_19_1
end

local function var_0_18(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_0 == 0 then
		return arg_22_1
	end

	return arg_22_2 * var_0_1(2, 10 * (arg_22_0 / arg_22_3 - 1)) + arg_22_1 - arg_22_2 * 0.001
end

local function var_0_19(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_0 == arg_23_3 then
		return arg_23_1 + arg_23_2
	end

	return arg_23_2 * 1.001 * (-var_0_1(2, -10 * arg_23_0 / arg_23_3) + 1) + arg_23_1
end

local function var_0_20(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	return -arg_26_2 * (var_0_4(1 - var_0_1(arg_26_0 / arg_26_3, 2)) - 1) + arg_26_1
end

local function var_0_21(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	return arg_27_2 * var_0_4(1 - var_0_1(arg_27_0 / arg_27_3 - 1, 2)) + arg_27_1
end

local function var_0_22(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_0, arg_30_1 = arg_30_0 or arg_30_3 * 0.3, arg_30_1 or 0

	if arg_30_1 < var_0_5(arg_30_2) then
		return arg_30_0, arg_30_2, arg_30_0 / 4
	end

	return arg_30_0, arg_30_1, arg_30_0 / (2 * var_0_7) * var_0_6(arg_30_2 / arg_30_1)
end

local function var_0_23(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	if arg_31_0 == 0 then
		return arg_31_1
	end

	arg_31_0 = arg_31_0 / arg_31_3

	if arg_31_0 == 1 then
		return arg_31_1 + arg_31_2
	end

	local var_31_1

	arg_31_5, arg_31_4, var_31_1 = var_0_22(arg_31_5, arg_31_4, arg_31_2, arg_31_3)
	arg_31_0 = arg_31_0 - 1

	return -(arg_31_4 * var_0_1(2, 10 * arg_31_0) * var_0_2((arg_31_0 * arg_31_3 - var_31_1) * (2 * var_0_7) / arg_31_5)) + arg_31_1
end

local function var_0_24(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	if arg_32_0 == 0 then
		return arg_32_1
	end

	arg_32_0 = arg_32_0 / arg_32_3

	if arg_32_0 == 1 then
		return arg_32_1 + arg_32_2
	end

	local var_32_1

	arg_32_5, arg_32_4, var_32_1 = var_0_22(arg_32_5, arg_32_4, arg_32_2, arg_32_3)

	return arg_32_4 * var_0_1(2, -10 * arg_32_0) * var_0_2((arg_32_0 * arg_32_3 - var_32_1) * (2 * var_0_7) / arg_32_5) + arg_32_2 + arg_32_1
end

local function var_0_25(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	arg_35_4 = arg_35_4 or 1.70158
	arg_35_0 = arg_35_0 / arg_35_3

	return arg_35_2 * arg_35_0 * arg_35_0 * ((arg_35_4 + 1) * arg_35_0 - arg_35_4) + arg_35_1
end

local function var_0_26(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	arg_36_4 = arg_36_4 or 1.70158
	arg_36_0 = arg_36_0 / arg_36_3 - 1

	return arg_36_2 * (arg_36_0 * arg_36_0 * ((arg_36_4 + 1) * arg_36_0 + arg_36_4) + 1) + arg_36_1
end

local function var_0_27(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	arg_39_0 = arg_39_0 / arg_39_3

	if arg_39_0 < 0.36363636363636365 then
		return arg_39_2 * (7.5625 * arg_39_0 * arg_39_0) + arg_39_1
	end

	if arg_39_0 < 0.7272727272727273 then
		arg_39_0 = arg_39_0 - 0.5454545454545454

		return arg_39_2 * (7.5625 * arg_39_0 * arg_39_0 + 0.75) + arg_39_1
	elseif arg_39_0 < 0.9090909090909091 then
		arg_39_0 = arg_39_0 - 0.8181818181818182

		return arg_39_2 * (7.5625 * arg_39_0 * arg_39_0 + 0.9375) + arg_39_1
	end

	arg_39_0 = arg_39_0 - 0.9545454545454546

	return arg_39_2 * (7.5625 * arg_39_0 * arg_39_0 + 0.984375) + arg_39_1
end

local function var_0_28(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	return arg_40_2 - var_0_27(arg_40_3 - arg_40_0, 0, arg_40_2, arg_40_3) + arg_40_1
end

var_0_0.func = {
	linear = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
		return arg_1_2 * arg_1_0 / arg_1_3 + arg_1_1
	end,
	inQuad = var_0_8,
	outQuad = var_0_9,
	inOutQuad = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		arg_4_0 = arg_4_0 / arg_4_3 * 2

		if arg_4_0 < 1 then
			return arg_4_2 / 2 * var_0_1(arg_4_0, 2) + arg_4_1
		end

		return -arg_4_2 / 2 * ((arg_4_0 - 1) * (arg_4_0 - 3) - 1) + arg_4_1
	end,
	outInQuad = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		if arg_5_0 < arg_5_3 / 2 then
			return var_0_9(arg_5_0 * 2, arg_5_1, arg_5_2 / 2, arg_5_3)
		end

		return var_0_8(arg_5_0 * 2 - arg_5_3, arg_5_1 + arg_5_2 / 2, arg_5_2 / 2, arg_5_3)
	end,
	inCubic = var_0_10,
	outCubic = var_0_11,
	inOutCubic = function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		arg_8_0 = arg_8_0 / arg_8_3 * 2

		if arg_8_0 < 1 then
			return arg_8_2 / 2 * arg_8_0 * arg_8_0 * arg_8_0 + arg_8_1
		end

		arg_8_0 = arg_8_0 - 2

		return arg_8_2 / 2 * (arg_8_0 * arg_8_0 * arg_8_0 + 2) + arg_8_1
	end,
	outInCubic = function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		if arg_9_0 < arg_9_3 / 2 then
			return var_0_11(arg_9_0 * 2, arg_9_1, arg_9_2 / 2, arg_9_3)
		end

		return var_0_10(arg_9_0 * 2 - arg_9_3, arg_9_1 + arg_9_2 / 2, arg_9_2 / 2, arg_9_3)
	end,
	inQuart = var_0_12,
	outQuart = var_0_13,
	inOutQuart = function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		arg_12_0 = arg_12_0 / arg_12_3 * 2

		if arg_12_0 < 1 then
			return arg_12_2 / 2 * var_0_1(arg_12_0, 4) + arg_12_1
		end

		return -arg_12_2 / 2 * (var_0_1(arg_12_0 - 2, 4) - 2) + arg_12_1
	end,
	outInQuart = function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		if arg_13_0 < arg_13_3 / 2 then
			return var_0_13(arg_13_0 * 2, arg_13_1, arg_13_2 / 2, arg_13_3)
		end

		return var_0_12(arg_13_0 * 2 - arg_13_3, arg_13_1 + arg_13_2 / 2, arg_13_2 / 2, arg_13_3)
	end,
	inQuint = var_0_14,
	outQuint = var_0_15,
	inOutQuint = function(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		arg_16_0 = arg_16_0 / arg_16_3 * 2

		if arg_16_0 < 1 then
			return arg_16_2 / 2 * var_0_1(arg_16_0, 5) + arg_16_1
		end

		return arg_16_2 / 2 * (var_0_1(arg_16_0 - 2, 5) + 2) + arg_16_1
	end,
	outInQuint = function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
		if arg_17_0 < arg_17_3 / 2 then
			return var_0_15(arg_17_0 * 2, arg_17_1, arg_17_2 / 2, arg_17_3)
		end

		return var_0_14(arg_17_0 * 2 - arg_17_3, arg_17_1 + arg_17_2 / 2, arg_17_2 / 2, arg_17_3)
	end,
	inSine = var_0_16,
	outSine = var_0_17,
	inOutSine = function(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
		return -arg_20_2 / 2 * (var_0_3(var_0_7 * arg_20_0 / arg_20_3) - 1) + arg_20_1
	end,
	outInSine = function(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		if arg_21_0 < arg_21_3 / 2 then
			return var_0_17(arg_21_0 * 2, arg_21_1, arg_21_2 / 2, arg_21_3)
		end

		return var_0_16(arg_21_0 * 2 - arg_21_3, arg_21_1 + arg_21_2 / 2, arg_21_2 / 2, arg_21_3)
	end,
	inExpo = var_0_18,
	outExpo = var_0_19,
	inOutExpo = function(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
		if arg_24_0 == 0 then
			return arg_24_1
		end

		if arg_24_0 == arg_24_3 then
			return arg_24_1 + arg_24_2
		end

		arg_24_0 = arg_24_0 / arg_24_3 * 2

		if arg_24_0 < 1 then
			return arg_24_2 / 2 * var_0_1(2, 10 * (arg_24_0 - 1)) + arg_24_1 - arg_24_2 * 0.0005
		end

		return arg_24_2 / 2 * 1.0005 * (-var_0_1(2, -10 * (arg_24_0 - 1)) + 2) + arg_24_1
	end,
	outInExpo = function(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
		if arg_25_0 < arg_25_3 / 2 then
			return var_0_19(arg_25_0 * 2, arg_25_1, arg_25_2 / 2, arg_25_3)
		end

		return var_0_18(arg_25_0 * 2 - arg_25_3, arg_25_1 + arg_25_2 / 2, arg_25_2 / 2, arg_25_3)
	end,
	inCirc = var_0_20,
	outCirc = var_0_21,
	inOutCirc = function(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
		arg_28_0 = arg_28_0 / arg_28_3 * 2

		if arg_28_0 < 1 then
			return -arg_28_2 / 2 * (var_0_4(1 - arg_28_0 * arg_28_0) - 1) + arg_28_1
		end

		arg_28_0 = arg_28_0 - 2

		return arg_28_2 / 2 * (var_0_4(1 - arg_28_0 * arg_28_0) + 1) + arg_28_1
	end,
	outInCirc = function(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
		if arg_29_0 < arg_29_3 / 2 then
			return var_0_21(arg_29_0 * 2, arg_29_1, arg_29_2 / 2, arg_29_3)
		end

		return var_0_20(arg_29_0 * 2 - arg_29_3, arg_29_1 + arg_29_2 / 2, arg_29_2 / 2, arg_29_3)
	end,
	inElastic = var_0_23,
	outElastic = var_0_24,
	inOutElastic = function(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
		if arg_33_0 == 0 then
			return arg_33_1
		end

		arg_33_0 = arg_33_0 / arg_33_3 * 2

		if arg_33_0 == 2 then
			return arg_33_1 + arg_33_2
		end

		local var_33_1

		arg_33_5, arg_33_4, var_33_1 = var_0_22(arg_33_5, arg_33_4, arg_33_2, arg_33_3)
		arg_33_0 = arg_33_0 - 1

		if arg_33_0 < 0 then
			return -0.5 * (arg_33_4 * var_0_1(2, 10 * arg_33_0) * var_0_2((arg_33_0 * arg_33_3 - var_33_1) * (2 * var_0_7) / arg_33_5)) + arg_33_1
		end

		return arg_33_4 * var_0_1(2, -10 * arg_33_0) * var_0_2((arg_33_0 * arg_33_3 - var_33_1) * (2 * var_0_7) / arg_33_5) * 0.5 + arg_33_2 + arg_33_1
	end,
	outInElastic = function(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
		if arg_34_0 < arg_34_3 / 2 then
			return var_0_24(arg_34_0 * 2, arg_34_1, arg_34_2 / 2, arg_34_3, arg_34_4, arg_34_5)
		end

		return var_0_23(arg_34_0 * 2 - arg_34_3, arg_34_1 + arg_34_2 / 2, arg_34_2 / 2, arg_34_3, arg_34_4, arg_34_5)
	end,
	inBack = var_0_25,
	outBack = var_0_26,
	inOutBack = function(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
		arg_37_4 = (arg_37_4 or 1.70158) * 1.525
		arg_37_0 = arg_37_0 / arg_37_3 * 2

		if arg_37_0 < 1 then
			return arg_37_2 / 2 * (arg_37_0 * arg_37_0 * ((arg_37_4 + 1) * arg_37_0 - arg_37_4)) + arg_37_1
		end

		arg_37_0 = arg_37_0 - 2

		return arg_37_2 / 2 * (arg_37_0 * arg_37_0 * ((arg_37_4 + 1) * arg_37_0 + arg_37_4) + 2) + arg_37_1
	end,
	outInBack = function(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
		if arg_38_0 < arg_38_3 / 2 then
			return var_0_26(arg_38_0 * 2, arg_38_1, arg_38_2 / 2, arg_38_3, arg_38_4)
		end

		return var_0_25(arg_38_0 * 2 - arg_38_3, arg_38_1 + arg_38_2 / 2, arg_38_2 / 2, arg_38_3, arg_38_4)
	end,
	inBounce = var_0_28,
	outBounce = var_0_27,
	inOutBounce = function(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
		if arg_41_0 < arg_41_3 / 2 then
			return var_0_28(arg_41_0 * 2, 0, arg_41_2, arg_41_3) * 0.5 + arg_41_1
		end

		return var_0_27(arg_41_0 * 2 - arg_41_3, 0, arg_41_2, arg_41_3) * 0.5 + arg_41_2 * 0.5 + arg_41_1
	end,
	outInBounce = function(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
		if arg_42_0 < arg_42_3 / 2 then
			return var_0_27(arg_42_0 * 2, arg_42_1, arg_42_2 / 2, arg_42_3)
		end

		return var_0_28(arg_42_0 * 2 - arg_42_3, arg_42_1 + arg_42_2 / 2, arg_42_2 / 2, arg_42_3)
	end,
	shake = function(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
		arg_43_4 = arg_43_4 or 40
		arg_43_5 = arg_43_5 or 5

		return arg_43_1 + arg_43_4 * var_0_2(arg_43_0 * arg_43_5 / arg_43_3 * 2 * var_0_7) / var_0_1(2.7182, arg_43_0 * (1.386 / arg_43_3))
	end
}

local function var_0_29(arg_44_0)
	arg_44_0 = arg_44_0 or "linear"

	if type(arg_44_0) == "string" then
		arg_44_0 = var_0_0.func[arg_44_0]
	end

	return arg_44_0
end

local function var_0_30(arg_45_0, arg_45_1)
	for iter_45_0, iter_45_1 in pairs(arg_45_0) do
		arg_45_1[iter_45_0] = iter_45_1
	end

	return arg_45_1
end

local function var_0_31(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5, arg_46_6)
	for iter_46_0, iter_46_1 in pairs(arg_46_2) do
		arg_46_0[iter_46_0] = arg_46_5(arg_46_3, arg_46_1[iter_46_0], iter_46_1 - arg_46_1[iter_46_0], arg_46_4, arg_46_6[iter_46_0] and arg_46_6[iter_46_0][1], arg_46_6[iter_46_0] and arg_46_6[iter_46_0][2])
	end
end

function var_0_0:set(arg_47_1)
	self.initial = self.initial or var_0_30(self.subject, {})
	self.elapse = arg_47_1

	if self.elapse <= 0 then
		self.subject = var_0_30(self.initial, self.subject)
	elseif self.elapse >= self.duration then
		self.elapse = self.duration
		self.subject = var_0_30(self.target, self.subject)
	else
		var_0_31(self.subject, self.initial, self.target, self.elapse, self.duration, self.easing, self.extra)
	end

	return self.elapse >= self.duration
end

function var_0_0:reset()
	return self:set(0)
end

function var_0_0:update(arg_49_1)
	return self:set(self.elapse + arg_49_1)
end

function var_0_0.new(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4)
	arg_50_3 = var_0_29(arg_50_3)
	arg_50_4 = arg_50_4 or {}

	return setmetatable({
		elapse = 0,
		subject = arg_50_1,
		target = arg_50_2,
		duration = arg_50_0,
		easing = arg_50_3,
		extra = arg_50_4
	}, {
		__index = var_0_0
	})
end

return var_0_0
