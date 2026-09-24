local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_content_close_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
		var_0_4:play_in_out_animation(self._control.bg.uITweenSequence, false, function()
			var_0_2:destroyInstance("marry")
		end)
	end

	function arg_1_0:__onClick_content_select_btn()
		if self._have_ring and self._love_enough then
			var_0_3:req_ShipMarry({
				id = self._data.id
			})
		elseif not self._have_ring then
			self:setVisible(false)

			local var_4_0 = var_0_2:getInstance("ship_detail")

			var_4_0.is_marry = true

			var_4_0:setVisible(false)
			var_0_2:createInstance("mall_shop"):show(var_0_4.mall_layer_type.layer_item, var_0_4.mall_enter_type.enter_marry, self._data, true)
		end
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
