local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_4 = gamecore.Language
local var_0_6 = gamecore.prompt

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_top_return()
		var_0_3:set_into_tower(false)
		self:__destroy_panel()

		local var_2_0 = var_0_1:createInstance("home")

		var_2_0:show()
		var_2_0:_bgm_play()
	end

	function arg_1_0:__onClick_main_top_btns_rank()
		var_0_3:req_LeaderboardReq(var_0_2.leaderboard_type.tower)
		self:__play_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
	end

	function arg_1_0:__onClick_main_top_btns_explain()
		self._page_move = 1

		self:__set_instructions_info(1)
		self._control.instructions.gameObject:SetActive(true)
		self:__play_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
	end

	function arg_1_0:__onClick_main_top_btns_analysis_room()
		var_0_1:createInstance("analysis_room"):show()
		self._panel:SetActive(false)
		self:__play_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
	end

	function arg_1_0:__onClick_main_top_btns_award()
		var_0_1:createInstance("awardbox"):show()
		self:set_tower_panel_block_raycasts(false)
		self:__play_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
	end

	function arg_1_0:__onClick_main_bottom_last_fast()
		self:__card_anim(false, function()
			self:show_now_layer(self._fast_jump_last_layer)
			self:__card_anim(true, nil)
		end)
	end

	function arg_1_0:__onClick_main_bottom_last_layer()
		if self:get_animation_state() then
			self:__card_anim(false, function()
				if self._now_layer - 1 <= 0 then
					self._control.main.bottom.last_layer:SetActive(false)

					return
				end

				self:show_now_layer(self._now_layer - 1)
				self:__card_anim(true, nil)
			end)
		end

		self:set_animation_state(false)
	end

	function arg_1_0:__onClick_main_bottom_reset()
		if self.isGray then
			var_0_6:show(var_0_4:getNowLang("active_outtime_tip"))

			return
		end

		self:__reset_btn_msgbox()
	end

	function arg_1_0:__onClick_main_bottom_next_layer()
		if self:get_animation_state() then
			self:__card_anim(false, function()
				if self._now_layer + 1 > self._max_layer then
					self._control.main.bottom.next_layer:SetActive(false)

					return
				end

				self:show_now_layer(self._now_layer + 1)
				self:__card_anim(true, nil)
			end)
		end

		self:set_animation_state(false)
	end

	function arg_1_0:__onClick_main_bottom_next_fast()
		self:__card_anim(false, function()
			self:show_now_layer(self._fast_jump_next_layer)
			self:__card_anim(true, nil)
		end)
	end

	function arg_1_0:__onClick_instructions_colse()
		self._control.instructions.gameObject:SetActive(false)
	end

	function arg_1_0:__onClick_instructions_prev()
		self._page_move = self._page_move - 1

		self:__set_instructions_info(self._page_move)
	end

	function arg_1_0:__onClick_instructions_next()
		self._page_move = self._page_move + 1

		self:__set_instructions_info(self._page_move)
	end

	function arg_1_0:__onClick_main_middle_item_1_monster_bg()
		self:__on_click_card_event(1)
	end

	function arg_1_0:__onClick_main_middle_item_2_monster_bg()
		self:__on_click_card_event(2)
	end

	function arg_1_0:__onClick_main_middle_item_3_monster_bg()
		self:__on_click_card_event(3)
	end

	function arg_1_0:__onClick_main_middle_item_4_monster_bg()
		self:__on_click_card_event(4)
	end

	function arg_1_0:__onClick_main_middle_item_5_monster_bg()
		self:__on_click_card_event(5)
	end

	function arg_1_0:__onClick_main_bottom_spine()
		self:on_click_situation_buff_btn_event(true)
	end

	function arg_1_0:__onClick_main_situation_buff()
		self:on_click_situation_buff_btn_event(false)
	end

	function arg_1_0.set_animation_state(arg_26_0, arg_26_1)
		arg_26_0._animation_state = arg_26_1
	end

	function arg_1_0:get_animation_state()
		return self._animation_state
	end
end

function var_0_0.extend_obj(arg_28_0)
	return
end

return var_0_0
