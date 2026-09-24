local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_change_style_framework_close_btn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		self:play_out_animation(function()
			self:setVisible(false)
		end)
	end

	function arg_1_0:__onClick_change_style_framework_use_btn()
		if self._now_index ~= self._now_selected_style then
			self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))

			local var_4_0

			for iter_4_0, iter_4_1 in pairs(var_0_1.show_room_style_id) do
				if iter_4_1 == self._now_selected_style then
					var_4_0 = iter_4_1
				end
			end

			self:use_showroom_by_style(var_4_0)
		end

		self:setVisible(false)
	end

	function arg_1_0:__onToggle_change_style_framework_content_style_default()
		self:set_showroom_by_style(10146)
	end

	function arg_1_0:__onToggle_change_style_framework_content_style_1()
		self:set_showroom_by_style(10246)
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
