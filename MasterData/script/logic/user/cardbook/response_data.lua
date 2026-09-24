local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.error_type
local var_0_5 = lx.json_decode
local var_0_6 = gamecore.prompt
local var_0_7 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.ChangeMusicResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("music")

			if not var_2_0 then
				return
			end

			var_2_0:__show_bgm_txt()
		else
			var_0_6:show(var_0_2:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0:LeaderboardResp(arg_3_1)
		if arg_3_1.result == 0 then
			local var_3_0 = {}

			if arg_3_1.board then
				var_3_0 = var_0_5(arg_3_1.board)
			end

			table.sort(var_3_0, function(arg_4_0, arg_4_1)
				return arg_4_0.rank < arg_4_1.rank
			end)

			for iter_3_0, iter_3_1 in pairs(var_3_0) do
				self._user_info_list[iter_3_1.account_id] = iter_3_1
			end

			self._cardbook_info_data[arg_3_1.type] = {
				type = arg_3_1.type,
				board_data = var_3_0
			}

			;(var_0_1:getInstance("loading") or var_0_1:createInstance("loading")):show(false, function()
				local var_5_0 = var_0_1:getInstance("cardbook")

				if var_5_0 then
					var_5_0:setVisible(false)
				end

				local var_5_1 = arg_3_1.type == var_0_7.leaderboard_type.tower and var_0_1:createInstance("tower_ranking_list") or var_0_1:createInstance("cardbook_info")

				if self._cardbook_info_data[arg_3_1.type] and var_5_1 then
					var_5_1:show(self._cardbook_info_data[arg_3_1.type])

					local var_5_2 = var_0_1:getInstance("cardbook")

					if var_5_2 then
						var_5_2:setVisible(false)
					end

					return
				end
			end)
		else
			var_0_6:show(var_0_2:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0.ResetMusicResp(arg_6_0, arg_6_1)
		if arg_6_1.result == 0 then
			local var_6_0 = var_0_1:getInstance("music")

			if not var_6_0 then
				return
			end

			var_6_0:reset_bgm_resp()
		else
			var_0_6:show(var_0_2:get_err_msg(arg_6_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
