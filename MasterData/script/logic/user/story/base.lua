local var_0_0 = {}
local var_0_1 = lx.UserData
local var_0_2 = table.insert
local var_0_5 = lx.clone_table

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_story_data(arg_2_0)
		arg_2_0._story_data = {}
	end

	function arg_1_0:get_player_story_unlock_data(arg_3_1)
		return self._story_data
	end

	function arg_1_0:add_unlock_player_data(arg_4_1)
		var_0_2(self._story_data, #self._story_data + 1, arg_4_1)
	end

	function arg_1_0:update_player_story_unlock_data(arg_5_1)
		local var_5_0 = 0

		for iter_5_0, iter_5_1 in pairs(self._story_data) do
			if iter_5_1.id == arg_5_1.id then
				var_5_0 = iter_5_0
			end
		end

		if var_5_0 == 0 then
			var_0_2(self._story_data, #self._story_data + 1, arg_5_1)
		else
			self._story_data[var_5_0] = arg_5_1
		end
	end

	function arg_1_0.remove_story_data(arg_6_0, arg_6_1)
		return
	end

	function arg_1_0.set_now_story(arg_7_0, arg_7_1)
		arg_7_0._now_story = arg_7_1
	end

	function arg_1_0:get_now_story()
		return self._now_story
	end

	function arg_1_0:save_selected_pic(arg_9_1)
		self._selected_pic = arg_9_1.ids or {}

		local var_9_0 = ""

		for iter_9_0, iter_9_1 in pairs(self._selected_pic) do
			var_9_0 = var_9_0 .. tostring(iter_9_1)
		end

		var_0_1:setKeyData("CustomCover", var_9_0)
	end

	function arg_1_0.set_selected_pic(arg_10_0, arg_10_1)
		arg_10_0._selected_pic = arg_10_1
	end

	function arg_1_0:get_selected_pic()
		if self._selected_pic and next(self._selected_pic) then
			return (var_0_5(self._selected_pic))
		else
			return {}
		end
	end

	function arg_1_0.set_now_story_info(arg_12_0, arg_12_1)
		arg_12_0._now_story_info = arg_12_1
	end

	function arg_1_0:get_now_story_info()
		return self._now_story_info
	end

	function arg_1_0.set_init_story_id(arg_14_0, arg_14_1)
		arg_14_0._init_story_id = arg_14_1
	end

	function arg_1_0:get_init_story_id()
		return self._init_story_id
	end

	function arg_1_0.set_now_small_story_panel(arg_16_0, arg_16_1)
		arg_16_0._now_small_story_panel = arg_16_1
	end

	function arg_1_0:get_now_small_story_panel()
		return self._now_small_story_panel
	end
end

function var_0_0.extend_obj(arg_18_0)
	arg_18_0._story_data = {}
	arg_18_0._now_story = nil
	arg_18_0._selected_pic = {}
	arg_18_0._now_story_info = nil
	arg_18_0._init_story_id = nil
	arg_18_0._now_small_story_panel = false
end

return var_0_0
