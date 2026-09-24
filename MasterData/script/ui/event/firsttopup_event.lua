local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = gameconfig.ship_config
local var_0_5 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_close()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:play_out_animation(function()
			self:setVisible(false)
		end)
	end

	function arg_1_0.__onClick_main_characterinfo(arg_4_0)
		return
	end

	function arg_1_0:__onClick_main_gain()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_goto))

		if not self.user_info.first_get and not self.user_info.first_pay then
			var_0_1:createInstance("mall_shop"):show(var_0_3.mall_layer_type.layer_diamond, var_0_3.mall_enter_type.enter_topup)
		elseif not self.user_info.first_get and self.user_info.first_pay then
			var_0_5:req_GetFirstRewardReq()
		end
	end

	function arg_1_0.__onClick_main_rewardmain_rewardone_btn(arg_6_0)
		return
	end

	function arg_1_0.__onClick_main_rewardmain_rewardtwo_btn(arg_7_0)
		return
	end

	function arg_1_0.__onClick_main_rewardmain_rewardthree_btn(arg_8_0)
		return
	end

	function arg_1_0.__onClick_main_rewardmain_rewardfour_btn(arg_9_0)
		return
	end

	function arg_1_0.__onClick_main_rewardmain_rewardfive_btn(arg_10_0)
		return
	end

	function arg_1_0.__onClick_main_rewardmain_rewardsix_btn(arg_11_0)
		return
	end

	function arg_1_0.__onClick_main_info(arg_12_0)
		var_0_1:createInstance("ship_detail"):show(var_0_3.enter_ship_detail_type.bootyshop, (var_0_4.find_object_by_cid(var_0_3.firsttopup_ship_id)))
	end

	function arg_1_0:__onScaleButtonClick_main_gain()
		self:__onClick_main_gain()
	end
end

function var_0_0.extend_obj(arg_14_0)
	return
end

return var_0_0
