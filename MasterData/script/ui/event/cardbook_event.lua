local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_return_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back_two))
		var_0_3:play_in_out_animation(self._control.bg.uITweenSequence, false, function()
			var_0_1:destroyInstance("cardbook")
			var_0_1:destroyInstance("cardbook_info")
			var_0_4.return_home_with_menu_active()
		end)

		local var_2_0 = var_0_1:getInstance("home")

		if var_2_0 and var_0_2:get_secretary_info().rand_secretary_flag == 1 then
			var_2_0:updata_model()
		end
	end

	function arg_1_0.__onClick_scrollview_content_rank_btn_1(arg_4_0)
		var_0_1:createInstance("loading"):show(true)
		var_0_2:req_LeaderboardReq(var_0_3.leaderboard_type.honor)
	end

	function arg_1_0.__onClick_scrollview_content_rank_btn_2(arg_5_0)
		var_0_1:createInstance("loading"):show(true)
		var_0_2:req_LeaderboardReq(var_0_3.leaderboard_type.kills)
	end

	function arg_1_0.__onClick_scrollview_content_rank_btn_3(arg_6_0)
		var_0_1:createInstance("loading"):show(true)
		var_0_2:req_LeaderboardReq(var_0_3.leaderboard_type.strength)
	end

	function arg_1_0.__onClick_scrollview_content_rank_btn_4(arg_7_0)
		var_0_1:createInstance("loading"):show(true)
		var_0_2:req_LeaderboardReq(var_0_3.leaderboard_type.ship_collection)
	end

	function arg_1_0:__onScaleButtonClick_top_return_btn()
		self:__onClick_top_return_btn()
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
