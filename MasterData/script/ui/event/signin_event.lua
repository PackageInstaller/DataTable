local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_fragment_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.task_goto))
		var_0_5:req_Signin()
	end

	function arg_1_0:__onClick_fragment_rewardone_btn()
		var_0_1:createInstance("specificdetails"):show(self._configs[7 * self._remainder - 6].award[1].id, var_0_4.enter_icon_detail_type.sign)
	end

	function arg_1_0:__onClick_fragment_rewardtwo_btn()
		var_0_1:createInstance("specificdetails"):show(self._configs[7 * self._remainder - 5].award[1].id, var_0_4.enter_icon_detail_type.sign)
	end

	function arg_1_0:__onClick_fragment_rewardthree_btn()
		var_0_1:createInstance("specificdetails"):show(self._configs[7 * self._remainder - 4].award[1].id, var_0_4.enter_icon_detail_type.sign)
	end

	function arg_1_0:__onClick_fragment_rewardfour_btn()
		var_0_1:createInstance("specificdetails"):show(self._configs[7 * self._remainder - 3].award[1].id, var_0_4.enter_icon_detail_type.sign)
	end

	function arg_1_0:__onClick_fragment_rewardfive_btn()
		var_0_1:createInstance("specificdetails"):show(self._configs[7 * self._remainder - 2].award[1].id, var_0_4.enter_icon_detail_type.sign)
	end

	function arg_1_0:__onClick_fragment_rewardsix_btn()
		var_0_1:createInstance("specificdetails"):show(self._configs[7 * self._remainder - 1].award[1].id, var_0_4.enter_icon_detail_type.sign)
	end

	function arg_1_0:__onClick_fragment_rewardseven_btn()
		var_0_1:createInstance("specificdetails"):show(self._configs[7 * self._remainder].award[1].id, var_0_4.enter_icon_detail_type.sign)
	end

	function arg_1_0:__onScaleButtonClick_fragment_mainfragment_close()
		if self._signin_seq then
			self._signin_seq:Pause()

			self._signin_seq = nil
		end

		self:play_in_out_animation(false, function()
			self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
			var_0_1:destroyInstance("signin")

			local var_11_0 = var_0_5:get_use_info_data()

			if var_11_0.once_login_award.cumulative_days > 10 then
				-- block empty
			elseif var_11_0.once_login_award.is_already_get then
				-- block empty
			elseif not var_0_5:get_close_sp_sign() then
				var_0_1:createInstance("sp_sign"):show()
			end
		end)
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
