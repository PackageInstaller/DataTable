local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = table.insert
local var_0_3 = string.format
local var_0_4 = gameenum.battle_type
local var_0_5 = gamecore.condition_logic
local var_0_6 = gamecore.action_logic

lx.define_class("trigger_logic", function(arg_1_0)
	function arg_1_0:init(arg_2_1)
		self._conditions = self._conditions or {}
		self._actions = self._actions or {}
		self._owner._multiple_attr_value = 1

		if arg_2_1.conditions then
			for iter_2_0, iter_2_1 in pairs(arg_2_1.conditions) do
				local var_2_0 = var_0_5:create()

				var_2_0:bind(self._battlefield)
				var_2_0:init(iter_2_1, arg_2_1.owner_id)
				var_0_2(self._conditions, var_2_0)
			end
		end

		if self:onTriggerEvent(arg_2_1.trigger_type) and self:pass_condition() then
			self:action_logic_init(arg_2_1)
		end

		if arg_2_1.rate then
			if self:__get_release_skill_effect_state(arg_2_1) then
				self:apply_actions()
			end
		else
			self:apply_actions()
		end
	end

	function arg_1_0:action_logic_init(arg_3_1)
		local var_3_0 = self._owner:get_skill_effect_count()

		for iter_3_0, iter_3_1 in ipairs(arg_3_1.actions) do
			if var_3_0 >= 0 and var_3_0 < iter_3_0 then
				break
			end

			local var_3_1 = var_0_6:create()

			var_3_1:bind(self._battlefield)
			var_3_1:init(iter_3_1, arg_3_1.buff_target, arg_3_1.owner_id, arg_3_1.atk_type, arg_3_1.attr_snapshot)
			var_0_2(self._actions, var_3_1)
		end
	end

	function arg_1_0:apply_actions()
		for iter_4_0, iter_4_1 in pairs(self._actions) do
			iter_4_1:apply()
		end
	end

	function arg_1_0:pass_condition()
		if #self._conditions == 0 then
			return true
		end

		for iter_5_0, iter_5_1 in pairs(self._conditions) do
			if iter_5_1:pass() then
				return true
			end
		end

		return false
	end

	function arg_1_0:onTriggerEvent(arg_6_1)
		if not arg_6_1 then
			return
		end

		local var_6_0 = var_0_3("__onTrigger_%s", (var_0_4:get_trigger_type(arg_6_1)))

		if not self[var_6_0] then
			log.errorlog("no trigger event")

			return
		end

		return self[var_6_0](self)
	end

	function arg_1_0.bind(arg_7_0, arg_7_1)
		arg_7_0._battlefield = arg_7_1
		arg_7_0._battle_obj_mgr = arg_7_1:getBattleObjectManager()
		arg_7_0._battle_random = arg_7_1:getBattleRandom()
		arg_7_0._battle_scene = arg_7_1:getBattleScene()
	end

	function arg_1_0:__get_release_skill_effect_state(arg_8_1)
		local var_8_0 = arg_8_1.rate

		if arg_8_1.rate1 and self._owner._multiple_attr_value then
			var_8_0 = var_8_0 + arg_8_1.rate1 * self._owner._multiple_attr_value
		end

		if var_8_0 >= 1 then
			return true
		end

		if var_8_0 * 100 >= self._battle_random:randRange(1, 100) then
			return true
		end

		return false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_9_0, arg_9_1)
	local var_9_0 = var_0_1.class("trigger_logic")

	var_9_0._owner = arg_9_1
	var_9_0._conditions = nil
	var_9_0._actions = nil
	var_9_0._trigger_type = nil

	gamecore.extend_obj(var_9_0)

	return var_9_0
end

return var_0_0
