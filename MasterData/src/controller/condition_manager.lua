local ConditionManager = class("ConditionManager", (require("controller.base_manager")))

ConditionManager.MULTITON_MSG = "ConditionManager instancealready constructed!"

local var_0_1 = string.split
local var_0_2 = string.find
local var_0_3 = tonumber
local var_0_4 = tostring

ConditionManager.Type = {
	SupermarketPrivilege = E_SUBSCRIPTION_PRIVILEGE,
	Level = E_PASS_LEVEL
}
ConditionManager.Tips = {
	[ConditionManager.Type.SupermarketPrivilege] = {
		tips = "未开通特权"
	},
	[ConditionManager.Type.Level] = {
		tips = "未通关%s关卡"
	}
}

setmetatable(ConditionManager.Tips, {
	__index = function(arg_1_0, arg_1_1)
		return {
			tips = "不满足条件"
		}
	end
})

ConditionManager.Method = {
	[ConditionManager.Type.SupermarketPrivilege] = function(arg_2_0)
		return require("controller.supermarket_privilege_manager"):getInstance():isOpenPrivilege()
	end,
	[ConditionManager.Type.Level] = function(arg_3_0)
		return require("controller.level_manager"):isPlayerPassLevel(arg_3_0[2])
	end
}
ConditionManager.CustomFormatTips = {
	[ConditionManager.Type.SupermarketPrivilege] = function(arg_4_0)
		return ConditionManager.Tips[var_0_3(arg_4_0[1])].tips or ""
	end
}

function ConditionManager:ctor()
	ConditionManager.super.ctor(self)

	self._data = {}
end

function ConditionManager:check(arg_6_1, arg_6_2)
	arg_6_1 = var_0_4(arg_6_1) or ""

	local var_6_0 = var_0_1(arg_6_1, "#")
	local var_6_1 = var_0_3(var_6_0[1])

	if not var_6_1 then
		return true
	end

	if ConditionManager.Method[var_6_1] then
		local var_6_2 = ConditionManager.Method[var_6_1](var_6_0)

		if var_6_2 then
			return var_6_2
		else
			local var_6_3 = {
				tips = ConditionManager.Tips[var_6_1].tips
			}

			if ConditionManager.CustomFormatTips[var_6_1] then
				var_6_3.tips = ConditionManager.CustomFormatTips[var_6_1](var_6_0)
			else
				local var_6_4 = 2

				while var_0_2(var_6_3.tips, "%%s") do
					var_6_3.tips = string.gsub(var_6_3.tips, "%%s", var_6_0[var_6_4] or "", 1)
					var_6_4 = var_6_4 + 1
				end
			end

			self:autoTips(arg_6_2, var_6_3)

			return var_6_2, var_6_3
		end
	else
		print("缺少判断类型为" .. var_6_1 .. "的判断方法，故返回true")

		return true
	end
end

function ConditionManager:autoTips(arg_7_1, arg_7_2)
	arg_7_1 = arg_7_1 or {}

	if arg_7_1.bAutoTips then
		global_ShowBlockWords(arg_7_2.tips)
	end
end

return ConditionManager
