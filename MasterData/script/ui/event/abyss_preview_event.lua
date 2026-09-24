local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = DG.Tweening.DOTween

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_return()
		var_0_1:destroyInstance("fight_prepare")

		if self._is_select_team then
			self:__team_select_return_func()
		else
			self:__return_main_stage_func()
		end
	end

	function arg_1_0:__onClick_bottom_fight_btn()
		if self._is_select_team then
			self:__go_to_fight()
		else
			self:__enter_abyss_model_fight_prepare()
		end
	end

	function arg_1_0:__onClick_bottom_team_select_player_team()
		self:__set_team_select_state(var_0_2.team_type.abyss_owner_team)
	end

	function arg_1_0:__onClick_bottom_team_select_abyss_team()
		self:__set_team_select_state(var_0_2.team_type.abyss_team)
	end

	function arg_1_0.__onClick_bottom_item_preview_list_content_item(arg_6_0)
		return
	end

	function arg_1_0.__onDropDown_bottom_team_select_gm_gm_1(arg_7_0)
		return
	end

	function arg_1_0.__onToggle_bottom_team_select_gm_gm_1_Template_Viewport_Content_Item(arg_8_0)
		return
	end

	function arg_1_0.__onDropDown_bottom_team_select_gm_gm_2(arg_9_0)
		return
	end

	function arg_1_0.__onToggle_bottom_team_select_gm_gm_2_Template_Viewport_Content_Item(arg_10_0)
		return
	end

	function arg_1_0.__onClick_middle_last_btn(arg_11_0)
		return
	end

	function arg_1_0.__onClick_middle_next_btn(arg_12_0)
		return
	end

	function arg_1_0:__prevent_frequently_click()
		local var_13_0 = self:autoKillDOTween(var_0_3.Sequence())

		var_13_0:AppendInterval(0.4)
		var_13_0:Play()
	end
end

function var_0_0.extend_obj(arg_14_0)
	return
end

return var_0_0
