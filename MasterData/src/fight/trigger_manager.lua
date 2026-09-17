local var_0_0 = {}
local var_0_2 = {
	[0] = function()
		return true
	end,
	function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		return (arg_2_1 == 1 and arg_2_2:getAttribute("curhp") / arg_2_2:getAttribute("singlehp") or arg_2_3:getAttribute("curhp") / arg_2_3:getAttribute("singlehp")) < tonumber(arg_2_0)
	end,
	function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		return (arg_3_1 == 1 and arg_3_2:getAttribute("curhp") / arg_3_2:getAttribute("singlehp") or arg_3_3:getAttribute("curhp") / arg_3_3:getAttribute("singlehp")) > tonumber(arg_3_0)
	end,
	function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in arg_6_0:gmatch("([^/]+)=([^/]+)") do
			var_6_0[tonumber(iter_6_0)] = tonumber(iter_6_1)
		end

		local var_6_1 = arg_6_1 == 1 and arg_6_2 or arg_6_3

		for iter_6_2, iter_6_3 in pairs(var_6_0) do
			if iter_6_3 <= var_6_1:getBuffCount(iter_6_2) then
				return true
			end
		end

		return false
	end,
	[5] = function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_8_2:getAttackcount()

		return var_8_0 > 0 and var_8_0 % tonumber(arg_8_0) == 0
	end,
	[6] = function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		for iter_9_0, iter_9_1 in pairs(arg_9_1 == 1 and arg_9_2:getAllTeammate() or arg_9_3:getAllTeammate()) do
			if not iter_9_1:checkAttrValid(arg_9_0) then
				return false
			end
		end

		return true
	end,
	[7] = function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		if arg_10_1 == 1 then
			return arg_10_2:checkAttrValid(arg_10_0)
		else
			return arg_10_3:checkAttrValid(arg_10_0)
		end
	end,
	[8] = function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		return (arg_11_1 == 1 and arg_11_2:getAttribute("career") or arg_11_3:getAttribute("career")) == arg_11_0
	end,
	[9] = function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = arg_12_1 == 1 and arg_12_2:getAttribute("range") or arg_12_3:getAttribute("range")

		if tonumber(arg_12_0) == 1 then
			return var_12_0 < 200
		else
			return var_12_0 >= 200
		end
	end,
	[10] = function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		return (arg_13_1 == 1 and arg_13_2:getEffectStatus("shield") or arg_13_3:getEffectStatus("shield")).total > 0
	end,
	[11] = function(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		return arg_14_1 == 1 and arg_14_2:getEffectStatus("immortal") or arg_14_3:getEffectStatus("immortal")
	end,
	[12] = function(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		return arg_15_1 == 1 and arg_15_2:getEffectStatus("vertigo") or arg_15_3:getEffectStatus("vertigo")
	end,
	[13] = function(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		local var_16_0 = {}

		for iter_16_0, iter_16_1 in arg_16_0:gmatch("([^/]+)=([^/]+)") do
			var_16_0[tonumber(iter_16_0)] = tonumber(iter_16_1)
		end

		local var_16_1 = arg_16_1 == 1 and arg_16_2 or arg_16_3

		for iter_16_2, iter_16_3 in pairs(var_16_0) do
			if iter_16_3 > var_16_1:getBuffCount(iter_16_2) then
				return false
			end
		end

		return true
	end,
	[14] = function(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
		if tonumber(arg_18_0) == 1 then
			return arg_18_2.charactertype == arg_18_3.charactertype
		else
			return arg_18_2.charactertype ~= arg_18_3.charactertype
		end
	end,
	[15] = function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
		local var_17_0 = {}

		for iter_17_0, iter_17_1 in arg_17_0:gmatch("([^/]+)=([^/]+)") do
			var_17_0[tonumber(iter_17_0)] = tonumber(iter_17_1)
		end

		local var_17_1 = arg_17_1 == 1 and arg_17_2 or arg_17_3

		for iter_17_2, iter_17_3 in pairs(var_17_0) do
			if iter_17_3 <= var_17_1:getStatusCount(iter_17_2) then
				return true
			end
		end

		return false
	end,
	[16] = function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in arg_7_0:gmatch("([^/]+)=([^/]+)") do
			var_7_0[tonumber(iter_7_0)] = tonumber(iter_7_1)
		end

		local var_7_1 = arg_7_1 == 1 and arg_7_2 or arg_7_3

		for iter_7_2, iter_7_3 in pairs(var_7_0) do
			if iter_7_3 <= var_7_1:getBuffCount(iter_7_2) then
				return false
			end
		end

		return true
	end,
	[17] = function(arg_19_0)
		return FightManager.getFightStage() == tonumber(arg_19_0)
	end,
	[18] = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		return (arg_4_1 == 1 and arg_4_2:getAttribute("defence") or arg_4_3:getAttribute("defence")) <= tonumber(arg_4_0)
	end,
	[19] = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		return (arg_5_1 == 1 and arg_5_2:getAttribute("defence") or arg_5_3:getAttribute("defence")) > tonumber(arg_5_0)
	end,
	[20] = function(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
		return (arg_20_1 == 1 and arg_20_2 or arg_20_3):getAttribute("servantid") == tonumber(arg_20_0)
	end,
	[21] = function(arg_21_0, arg_21_1, arg_21_2)
		local var_21_0 = arg_21_2:getAllTeammate()
		local var_21_1 = false

		for iter_21_0, iter_21_1 in pairs((arg_21_2:getAttribute("validAttr"))) do
			local var_21_2 = true

			for iter_21_2, iter_21_3 in pairs(var_21_0) do
				if not iter_21_3:checkAttrValid(iter_21_1) then
					var_21_2 = false

					break
				end
			end

			if var_21_2 then
				var_21_1 = true

				break
			end
		end

		return var_21_1
	end,
	[22] = function(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
		local var_22_0 = {}

		for iter_22_0, iter_22_1 in arg_22_0:gmatch("([^/]+)=([^/]+)") do
			var_22_0[tonumber(iter_22_0)] = tonumber(iter_22_1)
		end

		local var_22_1 = arg_22_1 == 1 and arg_22_2 or arg_22_3

		for iter_22_2, iter_22_3 in pairs(var_22_0) do
			if iter_22_3 < var_22_1:getBuffCount(iter_22_2) then
				return false
			end
		end

		return true
	end,
	[23] = function(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
		local var_23_0 = arg_23_1 == 1 and arg_23_2 or arg_23_3

		for iter_23_0, iter_23_1 in ipairs((string.split(arg_23_0, ","))) do
			if var_23_0:checkAttrValid(iter_23_1) then
				return false
			end
		end

		return true
	end,
	[24] = function(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
		return (arg_24_1 == 1 and arg_24_2:getEffectStatus("shield") or arg_24_3:getEffectStatus("shield")).total <= 0
	end,
	[25] = function(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
		return arg_25_1 == 1 and arg_25_2:getEffectStatus("silence") or arg_25_3:getEffectStatus("silence")
	end,
	[26] = function(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
		return arg_26_1 == 1 and arg_26_2:getEffectStatus("addict") or arg_26_3:getEffectStatus("addict")
	end
}

function var_0_0.judge_conditions(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	for iter_27_0, iter_27_1 in pairs(arg_27_0) do
		if not var_0_2[iter_27_1](arg_27_1[iter_27_1], arg_27_2[iter_27_1], arg_27_3, arg_27_4) then
			return false
		end
	end

	return true
end

function var_0_0:decode_judge_conditions(arg_28_1, arg_28_2)
	local var_28_0 = {
		conditions = {},
		target = {},
		param = {}
	}

	for iter_28_0 in self:gmatch("([^&]+)") do
		table.insert(var_28_0.conditions, tonumber(iter_28_0))
	end

	if arg_28_1 then
		for iter_28_1, iter_28_2 in arg_28_1:gmatch("([^&]+):([^&]+)") do
			var_28_0.target[tonumber(iter_28_1)] = tonumber(iter_28_2)
		end
	end

	if arg_28_2 then
		for iter_28_3, iter_28_4 in arg_28_2:gmatch("([^&]+):([^&]+)") do
			var_28_0.param[tonumber(iter_28_3)] = iter_28_4
		end
	end

	return var_28_0
end

return var_0_0
