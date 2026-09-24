local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.Language
local var_0_5 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_close_btn()
		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back))
		self:setVisible(false)
		var_0_3:destroyInstance("push_pve_active_store")
	end

	function arg_1_0:__onClick_buff_detail_left_toggle_btn()
		self:__update_buff_detail_level_desc(-1)

		self._buff_level = self._buff_level - 1

		self:__update_buff_exp_content()
		self:__update_buff_detail_left_and_right_toggle()
	end

	function arg_1_0:__onClick_buff_detail_right_toggle_btn()
		self:__update_buff_detail_level_desc(1)

		self._buff_level = self._buff_level + 1

		self:__update_buff_exp_content()
		self:__update_buff_detail_left_and_right_toggle()
	end

	function arg_1_0.__onClick_buff_detail_equip_state_btn(arg_5_0)
		return
	end

	function arg_1_0:__onClick_buff_detail_equip_choose_btn()
		local var_6_0 = var_0_1:get_push_info_using_buff()

		if self._is_left then
			var_0_1:set_disassemble_buff(1)

			if var_6_0 and #var_6_0 <= 1 then
				var_0_1:set_push_info_using_buff()
			end

			self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back))
			var_0_1:req_PushRemoveBuffReq({
				buff_id = self._cur_buff_id,
				hard = self._is_hard
			})
		else
			self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))

			local var_6_1 = var_0_1:get_disassemble_buff()
			local var_6_2 = {
				buff_id = self._cur_buff_id,
				hard = self._is_hard
			}

			if var_6_0 then
				if #var_6_0 >= 6 then
					var_0_2:show(var_0_4:getNowLang("active_buff_max2"))
				elseif var_6_1 == 2 then
					var_0_1:req_PushAddBuffReq(var_6_2)
				end
			elseif var_6_1 == 2 then
				var_0_1:req_PushAddBuffReq(var_6_2)
			end
		end
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
