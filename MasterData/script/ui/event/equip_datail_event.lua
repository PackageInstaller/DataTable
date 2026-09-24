local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_return_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		self:setVisible(false)

		if self._goto_type == 0 then
			local var_2_0 = var_0_1:getInstance("equip_map")

			if var_2_0 then
				var_2_0:setVisible(true)
			else
				var_0_1:createInstance("equip_map"):show_back()
			end
		else
			local var_2_1 = var_0_1:getInstance("ship_available")

			if var_2_1 then
				var_2_1:setVisible(true)
			end
		end
	end

	function arg_1_0:__onScaleButtonClick_last_btn()
		self:show_equip_detail(self._sort_new_equip_list[self._now_equip_index - 1].cid)
		self:show_btns(self._sort_new_equip_list[self._now_equip_index - 1].cid)
	end

	function arg_1_0:__onScaleButtonClick_next_btn()
		self:show_equip_detail(self._sort_new_equip_list[self._now_equip_index + 1].cid)
		self:show_btns(self._sort_new_equip_list[self._now_equip_index + 1].cid)
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
