local var_0_0 = {}
local var_0_1 = lx

lx.define_class("base_visual", function(arg_1_0)
	function arg_1_0:get_logic()
		return self._logic
	end

	function arg_1_0:get_id()
		return self._id
	end

	function arg_1_0:get_side()
		return self._side
	end

	function arg_1_0.set_miss(arg_5_0, arg_5_1)
		arg_5_0._is_miss = arg_5_1
	end

	function arg_1_0.set_crit(arg_6_0, arg_6_1)
		arg_6_0._is_crit = arg_6_1
	end

	function arg_1_0.set_enable_move(arg_7_0, arg_7_1)
		arg_7_0._enable_move = arg_7_1
	end

	function arg_1_0.eventOnFrame(arg_8_0, arg_8_1, arg_8_2)
		return
	end

	function arg_1_0:process(arg_9_1, arg_9_2)
		self:__process(arg_9_1, arg_9_2)
	end

	function arg_1_0:eventOnDestroy()
		self:__eventOnDestroy()
	end

	function arg_1_0:__eventOnFrame(arg_11_1)
		if not self._last_time or self._battle_processor._pause then
			self._last_time = arg_11_1
		end

		self:eventOnFrame(arg_11_1, arg_11_1 - self._last_time)

		self._last_time = arg_11_1
	end

	function arg_1_0:__eventOnInit(...)
		self:init(...)
	end

	function arg_1_0.init(arg_13_0, ...)
		return
	end

	function arg_1_0.__eventOnDestroy(arg_14_0)
		return
	end

	function arg_1_0.bind(arg_15_0, arg_15_1)
		arg_15_0._battle_processor = arg_15_1:getBattleProcessor()
		arg_15_0._battle_obj_mgr = arg_15_1:getBattleObjectManager()
		arg_15_0._battle_scene = arg_15_1:getBattleScene()
		arg_15_0._battle_time = arg_15_1:getBattleTime()
		arg_15_0._battle_random = arg_15_1:getBattleRandom()
	end
end)

function var_0_0.inherit(arg_16_0)
	local var_16_0 = var_0_1.class("base_visual")

	var_16_0._battle_processor = nil
	var_16_0._battle_obj_mgr = nil
	var_16_0._battle_scene = nil
	var_16_0._battle_time = nil
	var_16_0._battle_random = nil
	var_16_0._side = 0
	var_16_0._velocity = Vector3.zero
	var_16_0._acceleration = Vector3.zero
	var_16_0._is_miss = false
	var_16_0._is_crit = false
	var_16_0._target_pos = Vector3.zero
	var_16_0._move_ratio = 1
	var_16_0._base_scale = 1
	var_16_0._last_render_pos = Vector3.zero
	var_16_0._enable_move = false

	return var_16_0
end

return var_0_0
