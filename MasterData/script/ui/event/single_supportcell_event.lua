local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_icon()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

		local var_2_0 = var_0_1:getInstance("supportlist")

		self._select_index = self._index

		var_2_0:__close_select_bg()

		self._data.select_status = true

		var_2_0:__update_left_panel(self._index)
		self:__update_info_cell(self._data)

		local var_2_1, var_2_2, var_2_3 = var_0_2:get_support_notify()

		if var_2_3 >= self._data.need_achievement then
			var_0_2:req_ReadRankSupportReq(self._data.id)
		end
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
