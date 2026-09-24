local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_4 = gamecore.user
local var_0_7 = gameenum.common_type
local var_0_8 = gameconfig.ship_pve_active_config
local var_0_9 = gameconfig.ship_config
local var_0_10 = gamecore.PreloadManager
local var_0_11 = gamecore.AuditServerManager
local var_0_12 = gamecore.AudioManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_content_return_btn()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
		self:main_menu_out_animaiton(function()
			self:setVisible(false)
		end)

		local var_2_0 = var_0_2:createInstance("home")

		var_2_0:_update_main_position()

		var_2_0._allow_mouse_move = not var_2_0._is_live_2d

		var_2_0:set_menu_info(false)
		self:reset(true)
	end

	function arg_1_0:__onScaleButtonClick_content_mail_btn()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
		var_0_2:createInstance("mail"):show()
	end

	function arg_1_0:__onClick_content_setting_btn()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
		var_0_2:createInstance("setting"):show()
	end

	function arg_1_0.__onToggle_content_toggle_group_friend(arg_6_0)
		return
	end

	function arg_1_0:__onClick_back_btn()
		local var_7_0 = var_0_2:createInstance("home")

		var_7_0:_update_main_position()

		if var_7_0:get_menu_info() == false then
			return
		end

		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
		self:main_menu_out_animaiton(function()
			self:setVisible(false)

			var_7_0._allow_mouse_move = not var_7_0._is_live_2d
		end)
		var_7_0:set_menu_info(false)
		self:reset(true)
	end

	function arg_1_0:__onClick_content_arrow_content_item_btn_1()
		if self._now_label == "activity" then
			local var_9_0 = var_0_8.get_sequence()

			self:__into_combatshop()
		elseif self._now_label == "cardbookui" then
			if not var_0_11:isAuditVersion() then
				self:__into_cardbook()
			else
				var_0_2:createInstance("user_info"):show(nil)
				self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
			end
		elseif self._now_label == "remake" then
			self:__into_remake()
		elseif self._now_label == "build" then
			self:_into_build()
		end
	end

	function arg_1_0:__onClick_content_arrow_content_item_btn_2()
		if self._now_label == "activity" then
			self:__into_bootyshop()
		elseif self._now_label == "cardbookui" then
			self:__into_ship_map()
		elseif self._now_label == "remake" then
			self:__into_workshop()
		elseif self._now_label == "build" then
			self:__into_research_ship()
		end
	end

	function arg_1_0:__onClick_content_arrow_content_item_btn_3()
		if self._now_label == "activity" then
			self:__into_signin()
		elseif self._now_label == "cardbookui" then
			self:__into_equip_map()
		end
	end

	function arg_1_0:__onClick_content_arrow_content_item_btn_4()
		if self._now_label == "activity" then
			self:__into_upgradeawards()
		elseif self._now_label == "cardbookui" then
			self:__into_music()
		end
	end

	function arg_1_0:__onClick_content_arrow_content_item_btn_5()
		if self._now_label == "activity" then
			self:__into_firsttopup()
		elseif self._now_label == "cardbookui" then
			-- block empty
		end
	end

	function arg_1_0.__init_test(arg_14_0)
		var_0_2:createInstance("ocean_main_map"):show()
	end

	function arg_1_0:__into_combatshop()
		var_0_12:destroyCV()
		var_0_2:createInstance("combat_shop"):show(var_0_7.combat_shop_enter_type.home)
		self:setVisible(false)
	end

	function arg_1_0:__into_bootyshop()
		var_0_12:destroyCV()

		local var_16_0 = var_0_2:createInstance("bootyshop")

		self:setVisible(false)
		var_16_0:show(true)
		var_16_0:__select_one("btnone", true)
	end

	function arg_1_0.__into_signin(arg_17_0)
		var_0_2:createInstance("signin"):show(true)
	end

	function arg_1_0.__into_upgradeawards(arg_18_0)
		var_0_2:createInstance("upgradeawards"):show(true)
	end

	function arg_1_0.__into_firsttopup(arg_19_0)
		var_0_2:createInstance("firsttopup"):show(true)
	end

	function arg_1_0:__into_cardbook()
		var_0_12:destroyCV()
		self:setVisible(false)
		var_0_2:getInstance("home"):setVisible(false)
		var_0_2:createInstance("cardbook"):show(true)
	end

	function arg_1_0.__into_ship_map(arg_21_0)
		var_0_12:destroyCV()

		local var_21_0 = var_0_2:createInstance("loading")

		var_21_0:show(true, nil, false, "")

		local var_21_1 = var_0_4:get_character_num()
		local var_21_2 = 0

		local function var_21_3()
			var_21_2 = var_21_2 + 1

			if var_21_1 ~= var_21_2 then
				return
			end

			var_21_0:show(false)
			arg_21_0:setVisible(false)

			local var_22_0 = var_0_2:getInstance("home")

			if var_22_0 then
				var_22_0:setVisible(false)
			end

			var_0_2:createInstance("ship_map"):show(true)
		end

		for iter_21_0, iter_21_1 in pairs((var_0_4:get_character_list())) do
			local var_21_4 = var_0_9.find_object_by_cid(iter_21_1.cid)

			var_0_10:preload_ship_asset(string.format(var_0_7.ship_icon.model_normal_xm, var_21_4.pic_id, var_21_4.pic_id), var_21_3)
		end
	end

	function arg_1_0:__into_equip_map()
		var_0_12:destroyCV()
		self:setVisible(false)
		var_0_2:getInstance("home"):setVisible(false)
		var_0_2:createInstance("equip_map"):show()
	end

	function arg_1_0:__into_music()
		var_0_12:destroyCV()
		self:setVisible(false)
		var_0_2:getInstance("home"):setVisible(false)
		var_0_2:createInstance("music"):show(true)
	end

	function arg_1_0:__into_remake()
		var_0_12:destroyCV()
		self:setVisible(false)
		var_0_2:getInstance("home"):setVisible(false)
		var_0_2:createInstance("remake"):show(true)
	end

	function arg_1_0:__into_workshop()
		var_0_12:destroyCV()
		self:setVisible(false)
		var_0_2:createInstance("workshop"):show()
	end

	function arg_1_0:__onClick_content_arrow_content_item_btn_6()
		if self._now_label then
			return
		end

		var_0_2:createInstance("sp_sign"):show()
	end

	function arg_1_0:__onScaleButtonClick_content_official_btn()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
		var_0_4:req_AnnouncementRefreshReq()
	end

	function arg_1_0:_into_build()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))

		local var_29_0 = false
		local var_29_1 = false

		for iter_29_0, iter_29_1 in pairs((var_0_4:get_dock_group(var_0_7.pool_type.ship_build))) do
			if iter_29_1.state == 3 then
				var_29_0 = true

				break
			end
		end

		for iter_29_2, iter_29_3 in pairs((var_0_4:get_dock_group(var_0_7.pool_type.equipment_build))) do
			if iter_29_3.state == 3 then
				var_29_1 = true

				break
			end
		end

		self:__select_one("build")

		if var_29_0 == false and var_29_1 == true then
			local var_29_2 = var_0_2:createInstance("dock")

			self:setVisible(false)
			var_29_2:show(true, "research")
			var_29_2:select_one("research", true)
		else
			self:setVisible(false)
			var_0_2:createInstance("dock"):show(true)
		end
	end

	function arg_1_0:__into_research_ship()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
		self:setVisible(false)
		var_0_2:destroyInstance("home")
		var_0_2:createInstance("research_bureau"):show()
	end

	function arg_1_0.is_have_research_data(arg_31_0)
		local var_31_0 = var_0_4:get_ship_task_info()
		local var_31_1 = var_0_4:get_equip_task_info()

		if var_31_0 and next(var_31_0) then
			for iter_31_0, iter_31_1 in ipairs(var_31_0) do
				if iter_31_1.task_num_1 > 0 then
					return true
				end
			end
		end

		if var_31_1 and next(var_31_1) then
			for iter_31_2, iter_31_3 in ipairs(var_31_1) do
				if iter_31_3.task_num_1 > 0 then
					return true
				end
			end
		end
	end

	function arg_1_0:__onClick_content_toggle_group_mall()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
		self:__select_one("mall")
		self:setVisible(false)
		self:set_home_active(false)
		var_0_2:createInstance("mall_shop"):show(var_0_7.mall_layer_type.layer_diamond, var_0_7.mall_enter_type.enter_menu)
	end

	function arg_1_0:__onClick_content_toggle_group_activity()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
		self:__select_one("activity")
		self:__set_arrow_parent(self._control.content.toggle_group.activity.transform)
	end

	function arg_1_0:__onClick_content_toggle_group_build()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
		self:__select_one("build")

		if self:is_have_research_data() then
			var_0_4:req_ResearchBoatIdReq(0)
		end

		self:__set_arrow_parent(self._control.content.toggle_group.build.transform)
	end

	function arg_1_0:__onClick_content_toggle_group_remake()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
		self:__select_one("remake")
		self:__set_arrow_parent(self._control.content.toggle_group.remake.transform)
	end

	function arg_1_0:__onClick_content_toggle_group_cardbookui()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
		self:__select_one("cardbookui")

		if self:is_have_research_data() then
			var_0_4:req_ResearchBoatIdReq(0)
		end

		self:__set_arrow_parent(self._control.content.toggle_group.cardbookui.transform)
	end

	function arg_1_0:__onClick_content_toggle_group_friend()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
		self:__select_one("friend")
		self:setVisible(false)
		var_0_2:createInstance("friendsmain"):show("main_menu")
		self:set_home_active(false)

		var_0_2:getInstance("home")._continue_talk = true
	end
end

function var_0_0.extend_obj(arg_38_0)
	return
end

return var_0_0
