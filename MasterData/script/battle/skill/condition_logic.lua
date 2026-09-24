local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = string.format
local var_0_3 = gameenum.battle_type

lx.define_class("condition_logic", function(arg_1_0)
	function arg_1_0:init(arg_2_1, arg_2_2)
		if not self:__check_condition_config(arg_2_1) then
			log.print_r("condition_data 配置 is nil")

			return
		end

		self._condition_data = arg_2_1
		self._owner = self._battle_obj_mgr:findObject(arg_2_2)
	end

	function arg_1_0:pass()
		return self:onConditionFunc(self._condition_data)
	end

	function arg_1_0:onConditionFunc(arg_4_1)
		if not arg_4_1.type then
			log.print_r("condition_data.type is nil")

			return
		end

		local var_4_0 = var_0_2("__onConditionFunc_%s", (var_0_3:get_condition_type(arg_4_1.type)))

		if not self[var_4_0] then
			return
		end

		return self[var_4_0](self, self._owner, arg_4_1)
	end

	function arg_1_0.bind(arg_5_0, arg_5_1)
		arg_5_0._battlefield = arg_5_1
		arg_5_0._battle_obj_mgr = arg_5_1:getBattleObjectManager()
		arg_5_0._battle_random = arg_5_1:getBattleRandom()
		arg_5_0._battle_scene = arg_5_1:getBattleScene()
	end

	function arg_1_0.__check_condition_config(arg_6_0, arg_6_1)
		if not arg_6_1 then
			return false
		end

		return true
	end

	function arg_1_0.__have_key(arg_7_0, arg_7_1, arg_7_2)
		if #arg_7_1 ~= 0 then
			for iter_7_0, iter_7_1 in pairs(arg_7_1) do
				if arg_7_2[iter_7_1] then
					return true
				end
			end

			return false
		end

		return true
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_8_0)
	local var_8_0 = var_0_1.class("condition_logic")

	var_8_0._condition_data = nil
	var_8_0._param = 0
	var_8_0._ship_typs = nil
	var_8_0._ship_tons = nil
	var_8_0._owner = nil

	gamecore.extend_obj(var_8_0)

	return var_8_0
end

return var_0_0
