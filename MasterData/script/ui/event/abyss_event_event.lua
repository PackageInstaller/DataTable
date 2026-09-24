local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_return()
		local var_2_0 = var_0_1:createInstance("home")

		if var_2_0 then
			var_2_0:show()
			var_2_0:_bgm_play()
		end

		self._is_already_bgm = false

		var_0_2:set_into_cinema(false)
		var_0_2:set_goto_abyss(false)
		var_0_2:req_AbyssQuitMapReq()
		self:__destroy_panel()
	end

	function arg_1_0.__onClick_top_rank(arg_3_0)
		return
	end

	function arg_1_0:__onClick_top_reward()
		self:__open_reward_box()
	end

	function arg_1_0:__onClick_top_spec()
		self:__switch_desc_panel(true)
	end

	function arg_1_0:__onClick_top_story()
		var_0_1:createInstance("cinema_story_node"):show(self._activity_cfg.movie_group_id, true)
	end

	function arg_1_0:__onClick_bottom_dock()
		self:setVisible(false)
		var_0_1:createInstance("abyss_dock_team"):show()
	end

	function arg_1_0:__onClick_desc_panel_colse()
		self:__switch_desc_panel(false)
		self:switch_desc_page(1)

		if var_0_2:check_abyss_first_in() then
			self:__init_abyss_ship()
		end
	end

	function arg_1_0:__onClick_desc_panel_prev()
		if self._desc_now_page then
			self:switch_desc_page(self._desc_now_page - 1)
		end
	end

	function arg_1_0:__onClick_desc_panel_next()
		if self._desc_now_page then
			self:switch_desc_page(self._desc_now_page + 1)
		end
	end

	function arg_1_0:__onClick_npc()
		self:__show_talk()
	end

	function arg_1_0:__onClick_abyss_msgbox_main_one()
		self._control.abyss_msgbox:SetActive(false)
	end
end

function var_0_0.extend_obj(arg_13_0)
	return
end

return var_0_0
