local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gameenum.common_type
local var_0_5 = gameconfig.pve_mist_level_node_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_close_btn()
		if var_0_2:get_select_into_nf() or var_0_2:get_to_nf_fight_map() then
			if var_0_2:get_mist_bgm() then
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_2:get_mist_bgm()))
			else
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.sixth_activity_bgm))
			end

			local var_2_0 = var_0_2:get_mist_combat_info()

			var_0_2:set_mist_pass_rank(self._rank)

			local var_2_1 = var_0_1:createInstance("nf_map_node")

			var_0_2:set_boss_point_is_fail(false)

			if self._rank == 2 then
				for iter_2_0, iter_2_1 in pairs((var_0_5.get_sequence())) do
					if iter_2_1.id == var_2_0.point and #iter_2_1.next_node == 0 then
						var_0_2:set_boss_point_is_fail(true)
					end
				end
			end

			var_0_2:req_MistPointCompleteReq(self._rank, var_2_0.point)
			var_0_1:destroyInstance("nf_result")
		end
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
