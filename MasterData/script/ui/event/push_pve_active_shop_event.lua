local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gamecore.prompt
local var_0_4 = gamecore.Language
local var_0_5 = gameconfig.pve_active_buff_config
local var_0_6 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_close_btn(arg_2_0)
		return
	end

	function arg_1_0:__onClick_bg_close_btn()
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.back))
		self:setVisible(false)
		var_0_1:destroyInstance("push_pve_active_shop")

		local var_3_0 = var_0_1:getInstance("combat_result")

		if var_3_0 then
			var_3_0:__destroy_spine(var_3_0._control.score.spineparent)
			var_3_0:__back_combat()
		end
	end

	function arg_1_0:__onClick_buff_content_pve_active_buff_cell_1_buff_button()
		if self:__init_max_buff_num() == self:__init_now_buff_num() then
			var_0_3:show(var_0_4:getNowLang("active_buff_max"))

			return
		end

		local var_4_0 = {
			map_id = self.map_id,
			buff_id = self._buff_1
		}
		local var_4_1 = var_0_5.find_object_by_id(self._buff_1)

		if ((var_4_1 or nil) and var_4_1.value) <= var_0_2:get_push_info_coin() then
			var_0_2:set_bug_buff_index(1)
			var_0_2:req_PushBuyBuffReq(var_4_0)
		else
			var_0_3:show(var_0_4:getNowLang("active_buff_inadequate"))
		end
	end

	function arg_1_0:__onClick_buff_content_pve_active_buff_cell_2_buff_button()
		if self:__init_max_buff_num() == self:__init_now_buff_num() then
			var_0_3:show(var_0_4:getNowLang("active_buff_max"))

			return
		end

		local var_5_0 = {
			map_id = self.map_id,
			buff_id = self._buff_2
		}
		local var_5_1 = var_0_5.find_object_by_id(self._buff_2)
		local var_5_2 = 0

		if var_5_1 then
			var_5_2 = var_5_1.value
		end

		if var_5_2 <= var_0_2:get_push_info_coin() and var_5_2 > 0 then
			var_0_2:set_bug_buff_index(2)
			var_0_2:req_PushBuyBuffReq(var_5_0)
		else
			var_0_3:show(var_0_4:getNowLang("active_buff_inadequate"))
		end
	end

	function arg_1_0:__onClick_buff_content_pve_active_buff_cell_3_buff_button()
		if self:__init_max_buff_num() == self:__init_now_buff_num() then
			var_0_3:show(var_0_4:getNowLang("active_buff_max"))

			return
		end

		local var_6_0 = {
			map_id = self.map_id,
			buff_id = self._buff_3
		}
		local var_6_1 = var_0_5.find_object_by_id(self._buff_3)
		local var_6_2 = 0

		if var_6_1 then
			var_6_2 = var_6_1.value
		end

		if var_6_2 <= var_0_2:get_push_info_coin() and var_6_2 > 0 then
			var_0_2:set_bug_buff_index(3)
			var_0_2:req_PushBuyBuffReq(var_6_0)
		else
			var_0_3:show(var_0_4:getNowLang("active_buff_inadequate"))
		end
	end

	function arg_1_0:__onClick_buff_content_pve_active_buff_cell_4_buff_button()
		if self:__init_max_buff_num() == self:__init_now_buff_num() then
			var_0_3:show(var_0_4:getNowLang("active_buff_max"))

			return
		end

		local var_7_0 = {
			map_id = self.map_id,
			buff_id = self._buff_4
		}
		local var_7_1 = var_0_5.find_object_by_id(self._buff_4)
		local var_7_2 = 0

		if var_7_1 then
			var_7_2 = var_7_1.value
		end

		if var_7_2 <= var_0_2:get_push_info_coin() and var_7_2 > 0 then
			var_0_2:set_bug_buff_index(4)
			var_0_2:req_PushBuyBuffReq(var_7_0)
		else
			var_0_3:show(var_0_4:getNowLang("active_buff_inadequate"))
		end
	end

	function arg_1_0:__onClick_buff_content_pve_active_buff_cell_5_buff_button()
		if self:__init_max_buff_num() == self:__init_now_buff_num() then
			var_0_3:show(var_0_4:getNowLang("active_buff_max"))

			return
		end

		local var_8_0 = {
			map_id = self.map_id,
			buff_id = self._buff_5
		}
		local var_8_1 = var_0_5.find_object_by_id(self._buff_5)
		local var_8_2 = 0

		if var_8_1 then
			var_8_2 = var_8_1.value
		end

		if var_8_2 <= var_0_2:get_push_info_coin() and var_8_2 > 0 then
			var_0_2:set_bug_buff_index(5)
			var_0_2:req_PushBuyBuffReq(var_8_0)
		else
			var_0_3:show(var_0_4:getNowLang("active_buff_inadequate"))
		end
	end

	function arg_1_0:__onClick_buff_content_pve_active_buff_cell_6_buff_button()
		if self:__init_max_buff_num() == self:__init_now_buff_num() then
			var_0_3:show(var_0_4:getNowLang("active_buff_max"))

			return
		end

		local var_9_0 = {
			map_id = self.map_id,
			buff_id = self._buff_6
		}
		local var_9_1 = var_0_5.find_object_by_id(self._buff_6)
		local var_9_2 = 0

		if var_9_1 then
			var_9_2 = var_9_1.value
		end

		if var_9_2 <= var_0_2:get_push_info_coin() and var_9_2 > 0 then
			var_0_2:set_bug_buff_index(6)
			var_0_2:req_PushBuyBuffReq(var_9_0)
		else
			var_0_3:show(var_0_4:getNowLang("active_buff_inadequate"))
		end
	end
end

function var_0_0.extend_obj(arg_10_0)
	return
end

return var_0_0
