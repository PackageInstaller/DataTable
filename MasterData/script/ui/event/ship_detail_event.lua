local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.prompt
local var_0_6 = gameconfig.skin_config
local var_0_8 = UnityEngine.Input
local var_0_9 = DG.Tweening.DOTween
local var_0_10 = gamecore.AudioManager
local var_0_11 = gameconfig.ship_config
local var_0_12 = gamecore.util_func
local var_0_13 = string.format
local var_0_14 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_left_return_btn()
		self._index = nil

		if self._enter_type == var_0_2.enter_ship_detail_type.dock or self._enter_type == var_0_2.enter_ship_detail_type.dock_team_equip then
			local var_2_0 = var_0_1:getInstance("dock_team")

			if var_2_0 and var_2_0._current_team_index == 5 then
				var_2_0:update_content(var_2_0._current_content_type, 5)
				var_2_0:update_single_select_team_list()
			end
		elseif self._enter_type == var_0_2.enter_ship_detail_type.single_ship then
			local var_2_1 = var_0_1:getInstance("tactics_select_member")

			if var_2_1 then
				var_0_1:destroyInstance("ship_detail")
				var_2_1:__update_reusable_cell()

				return
			end
		end

		if self and self._control then
			self:play_in_out_animation(true, function()
				self:play_in_out_animation(false, nil, self._control.left_seq.uITweenSequence)
			end, self._control.left_seq.uITweenSequence)
		end

		if self._enter_type == var_0_2.enter_ship_detail_type.new_ship then
			var_0_1:destroyInstance("ship_detail")
			var_0_1:destroyInstance("equip_list")
			self._control.left.alone_view_btn:SetActive(false)

			local var_2_2 = var_0_1:getInstance("new_ship_or_equip")

			if var_2_2 then
				var_2_2:setVisible(true)
				var_2_2:set_sub_canvas()
			else
				local var_2_3 = var_0_1:createInstance("new_ship_or_equip")

				var_2_3:setVisible(true)
				var_2_3:set_sub_canvas()
			end

			return
		end

		self:play_in_out_animation(true, function()
			self:play_in_out_animation(false, function()
				self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))

				if self._enter_type == var_0_2.enter_ship_detail_type.ship_map then
					var_0_1:destroyInstance("ship_detail")

					local var_5_0 = var_0_1:getInstance("ship_map")
					local var_5_1 = var_0_1:getInstance("ship_available")

					if var_5_0 then
						var_5_0:setVisible(true)
					elseif var_5_1 then
						var_5_1:setVisible(true)
					end
				elseif self._enter_type == var_0_2.enter_ship_detail_type.mall_shop then
					var_0_1:destroyInstance("ship_detail")
					var_0_1:getInstance("mall_shop"):setVisible(true)

					self._is_mall_change_init = false
				elseif self._enter_type == var_0_2.enter_ship_detail_type.mail_ship_award then
					local var_5_2 = var_0_1:getInstance("new_ship_or_equip")

					self:play_in_out_animation(true, function()
						self:autoKillDOTween(var_0_9.Sequence()):AppendCallback(function()
							var_0_1:destroyInstance("ship_detail")

							if var_5_2 then
								var_5_2:setVisible(true)
							end
						end)
					end, self._control.right_seq.uITweenSequence)
				elseif self._is_single or self._is_team then
					if self._control.left.ship_btns.dress_toggle.toggle.isOn then
						self._control.left.ship_btns.dress_toggle.toggle.isOn = false

						self:__onToggle_all_do_left_ship_btns_dress_toggle()
					end

					if self._enter_type == var_0_2.enter_ship_detail_type.remake then
						var_0_1:destroyInstance("ship_detail")

						local var_5_3 = var_0_1:getInstance("remake")

						if var_5_3 then
							var_5_3:show()
							var_5_3:update_data()
						end
					elseif self._enter_type == var_0_2.enter_ship_detail_type.single_ship then
						local var_5_4 = var_0_1:getInstance("select_member")

						if var_5_4 then
							if not var_0_1:getInstance("bathroom_repair") and not var_0_1:getInstance("captainroom_fleet") then
								var_5_4:set_scrollbar()
								var_5_4:setVisible(true)

								if self._select_cell then
									self._select_cell:update_cell_info()
								end

								var_5_4:__update_cell_data_by_cid(self._data.id)
							end
						end

						local var_5_5 = var_0_1:getInstance("enemy_ship_detail")

						if var_5_5 then
							var_5_5:setVisible(true)
						end

						local var_5_6 = self._special_enter_type

						if self._special_enter_type == var_0_2.enter_ship_detail_type.captainroom_fleet then
							var_0_1:destroyInstance("ship_detail")

							local var_5_7 = var_0_1:getInstance("captainroom")

							if var_5_7 then
								var_5_7:setVisible(true)
								var_5_7:__init_panel_order()
							end

							local var_5_8 = var_0_1:getInstance("select_member")

							if var_5_8 then
								var_5_8:setVisible(false)
							end

							local var_5_9 = var_0_1:getInstance("captainroom_fleet")

							if var_5_9 then
								var_5_9:setVisible(true)
								var_5_9:set_fleet_list()
							end
						elseif var_5_6 == var_0_2.enter_ship_detail_type.captainroom_friend_fleet then
							var_0_1:destroyInstance("ship_detail")

							local var_5_10 = var_0_1:getInstance("captainroom")

							if var_5_10 then
								var_5_10:setVisible(true)
							end

							local var_5_11 = var_0_1:getInstance("captainroom_friend_fleet")

							if var_5_11 then
								var_5_11:setVisible(true)
							end
						elseif var_5_6 == var_0_2.enter_ship_detail_type.show_room then
							var_0_1:destroyInstance("ship_detail")

							local var_5_12 = var_0_1:getInstance("show_room")

							if var_5_12 then
								var_5_12:setVisible(true)
							end

							local var_5_13 = var_0_1:getInstance("captainroom_friend_fleet")

							if var_5_13 then
								var_5_13:setVisible(true)
							end
						elseif var_5_6 == var_0_2.enter_ship_detail_type.bathroom_repair then
							var_0_1:destroyInstance("ship_detail")

							local var_5_14 = var_0_1:getInstance("bathroom")

							if var_5_14 then
								var_5_14:setVisible(true)

								local var_5_15 = var_0_1:getInstance("bathroom_repair")

								var_5_15:setVisible(true)
								var_5_15:show()
							end
						elseif var_5_6 == var_0_2.enter_ship_detail_type.sixth_select then
							var_0_1:destroyInstance("ship_detail")

							local var_5_16 = var_0_1:getInstance("select_member")

							if var_5_16 then
								var_5_16:update_data()
								var_5_16:setVisible(true)
							end
						elseif var_5_6 == var_0_2.enter_ship_detail_type.ocean_select then
							var_0_1:destroyInstance("ship_detail")

							local var_5_17 = var_0_1:getInstance("fight_prepare")

							if var_5_17 then
								var_5_17:setVisible(true)
								var_5_17:refresh_ocean_info_list()
							end
						elseif var_5_6 == var_0_2.enter_ship_detail_type.dormitory_ship then
							var_0_1:destroyInstance("ship_detail")

							local var_5_18 = var_0_1:getInstance("select_member")

							if var_5_18 then
								var_5_18:update_data()
								var_5_18:setVisible(true)
							end
						elseif var_5_6 == var_0_2.enter_ship_detail_type.strike_fight_prepare then
							var_0_1:destroyInstance("ship_detail")

							local var_5_19 = var_0_1:getInstance("fight_prepare")

							if var_5_19 then
								var_5_19:refresh_strike_info_list()
							end
						elseif var_5_6 == var_0_2.enter_ship_detail_type.strike_fight_select then
							var_0_1:destroyInstance("ship_detail")

							local var_5_20 = var_0_1:getInstance("select_member")

							if var_5_20 then
								var_5_20:setVisible(true)
							end
						else
							var_0_1:destroyInstance("ship_detail")

							local var_5_21 = var_0_1:getInstance("select_member")

							if var_5_21 then
								var_5_21:setVisible(true)
							end
						end
					elseif self._enter_type == var_0_2.enter_ship_detail_type.sixth_fight_prepare then
						var_0_1:destroyInstance("ship_detail")

						local var_5_22 = var_0_1:getInstance("fight_prepare")

						if var_5_22 then
							var_5_22:setVisible(true)
							var_5_22:refresh_sixth_info_list()
						end
					elseif self._enter_type == var_0_2.enter_ship_detail_type.abyss_fight_prepare then
						var_0_1:destroyInstance("ship_detail")

						local var_5_23 = var_0_1:getInstance("select_member")

						if var_5_23 then
							if self._select_cell then
								self._select_cell:update_cell_info()
							end

							var_5_23:__update_cell_data_by_cid(self._data.id)
						end

						local var_5_24 = var_0_1:getInstance("fight_prepare")

						if var_5_24 then
							var_5_24:setVisible(true)
							var_5_24:update_abyss_model_team_list(self._toggle_type, var_0_2.team_type.abyss_owner_team)
						end
					elseif self._enter_type == var_0_2.enter_ship_detail_type.dock then
						var_0_1:destroyInstance("ship_detail")

						local var_5_25 = var_0_1:getInstance("dock")

						if var_5_25 then
							var_5_25:setVisible(true)
						end
					elseif self._enter_type == var_0_2.enter_ship_detail_type.dock_team or self._enter_type == var_0_2.enter_ship_detail_type.dock_team_equip then
						var_0_1:destroyInstance("ship_detail")

						local var_5_26 = var_0_1:getInstance("dock_team")
						local var_5_27

						if var_5_26 then
							var_5_26:setVisible(true)

							var_5_27 = var_5_26:get_current_team_index()
						end

						if var_5_27 and var_5_27 ~= 5 then
							var_5_26:update_content(self._toggle_type, self._team_id)
						elseif var_5_27 and var_5_27 == 5 then
							var_5_26:__onToggle_bg_top_menu_fleet_toggle_fleetid5()
						end
					elseif self._enter_type == var_0_2.enter_ship_detail_type.fight_team then
						var_0_1:destroyInstance("ship_detail")

						local var_5_28 = var_0_1:getInstance("fight_prepare")

						if var_5_28 then
							var_5_28:setVisible(true)
							var_5_28:refresh_info_list()
							var_5_28:refresh_campaign_info_list()
						end
					elseif self._enter_type == var_0_2.enter_ship_detail_type.strike_fight_prepare then
						var_0_1:destroyInstance("ship_detail")

						local var_5_29 = var_0_1:getInstance("fight_prepare")

						if var_5_29 then
							var_5_29:setVisible(true)
							var_5_29:refresh_info_list()
							var_5_29:refresh_campaign_info_list()
							var_5_29:refresh_strike_info_list()
						end
					elseif self._enter_type == var_0_2.enter_ship_detail_type.sixth_select then
						var_0_1:destroyInstance("ship_detail")

						local var_5_30 = var_0_1:getInstance("fight_prepare")
						local var_5_31 = var_0_1:getInstance("select_member")

						if var_5_30 then
							var_5_30:setVisible(true)
							var_5_30:refresh_sixth_info_list()
						end

						if var_5_31 and var_5_30 then
							var_5_30._panel.transform:GetComponent("Canvas").sortingOrder = var_5_31._panel.transform:GetComponent("Canvas").sortingOrder - 1

							var_5_31:setVisible(true)
						end
					elseif self._enter_type == var_0_2.enter_ship_detail_type.pre_formation then
						var_0_1:destroyInstance("ship_detail")

						local var_5_32 = var_0_1:getInstance("pre_formation")

						if var_5_32 then
							var_5_32:setVisible(true)
							var_5_32:refresh_info_list()
						end
					end
				elseif self._enter_type == var_0_2.enter_ship_detail_type.seven_bootyshop then
					local var_5_33 = var_0_1:getInstance("seven_sea_map")

					if var_5_33 then
						var_5_33:setVisible(true)
					end

					local var_5_34 = var_0_1:getInstance("cover")

					if var_5_34 then
						var_5_34:setVisible(false)
					end
				elseif self._enter_type == var_0_2.enter_ship_detail_type.eighth_bootyshop then
					local var_5_35 = var_0_1:getInstance("eighth_sea_map")

					if var_5_35 then
						var_5_35:setVisible(true)
					end

					local var_5_36 = var_0_1:getInstance("cover")

					if var_5_36 then
						var_5_36:setVisible(false)
					end
				elseif self._enter_type == var_0_2.enter_ship_detail_type.ninth_shop then
					local var_5_37 = var_0_1:getInstance("ninth_awardbox")

					if var_5_37 then
						var_5_37:setVisible(true)
					end
				end

				var_0_1:destroyInstance("ship_detail")
				self:reset_enter_type()
			end, self._control.right_seq.uITweenSequence)
		end, self._control.right_seq.uITweenSequence)
		self:play_mall_anim(false)
	end

	function arg_1_0:__onClick_left_skin_btns_video_btn()
		var_0_10:destroyCV()
		self._control.video_btn_layer:SetActive(true)

		local var_8_0 = var_0_3:get_skin_data_info()

		if var_8_0 and next(var_8_0) then
			if self._now_label == 1 then
				local var_8_1 = {}

				if #self._now_ship_data.skins > 0 then
					for iter_8_0, iter_8_1 in pairs(self._now_ship_data.skins) do
						table.insert(var_8_1, iter_8_1)
					end

					for iter_8_2, iter_8_3 in ipairs(var_8_1) do
						if not self._now_ship_data.evo_class and (iter_8_3 - 1000000000) % 10000 % 1000 / 100 < 0.9 then
							table.remove(var_8_1, iter_8_2)
						end
					end
				end

				local var_8_2 = var_0_11.find_object_by_cid(self._now_ship_data.cid).skins

				if self._is_married then
					if self._now_index_2 ~= 0 then
						for iter_8_4, iter_8_5 in pairs(var_8_0) do
							if var_0_12.have_data(var_8_0, var_8_1[self._now_index_2]) then
								self._control.video_btn_layer.video_btn_2:SetActive(true)
								self._control.video_btn_layer.btn_mask:SetActive(false)
							else
								self._control.video_btn_layer.video_btn_2:SetActive(false)
								self._control.video_btn_layer.btn_mask:SetActive(true)
							end
						end
					else
						self._control.video_btn_layer.video_btn_2:SetActive(true)
						self._control.video_btn_layer.btn_mask:SetActive(false)
					end
				else
					self._control.video_btn_layer.video_btn_2:SetActive(false)
					self._control.video_btn_layer.btn_mask:SetActive(true)
				end
			elseif self._now_label == 2 then
				local var_8_3 = var_0_11.find_object_by_cid(self._now_ship_data.evo_cid).skins

				if self._is_married then
					if self._now_index_2 ~= 0 and self._now_index_2 ~= 1 then
						for iter_8_6, iter_8_7 in pairs(var_8_0) do
							if var_0_12.have_data(var_8_0, var_8_3[self._now_index_2]) then
								self._control.video_btn_layer.video_btn_2:SetActive(true)
								self._control.video_btn_layer.btn_mask:SetActive(false)
							else
								self._control.video_btn_layer.video_btn_2:SetActive(false)
								self._control.video_btn_layer.btn_mask:SetActive(true)
							end
						end
					else
						self._control.video_btn_layer.video_btn_2:SetActive(true)
						self._control.video_btn_layer.btn_mask:SetActive(false)
					end
				else
					self._control.video_btn_layer.video_btn_2:SetActive(false)
					self._control.video_btn_layer.btn_mask:SetActive(true)
				end
			end
		end

		self._control.video_btn_layer.title.text.text = var_0_4:getNowLang("revertdialogue")
	end

	function arg_1_0:__onClick_left_skin_btns_clothes_btn()
		self:show_layer(self._now_lable == 1 and 2 or 1)
	end

	function arg_1_0:__onToggle_all_do_left_ship_btns_dress_toggle()
		self._now_lable = self._now_lable == 1 and 2 or 1
		self._now_skin_page = self._now_lable

		self:show_layer(self._now_lable)
		self:__set_ship_btns(self._control.left.ship_btns.dress_toggle.toggle.isOn)
		self:show_ship_icon(self._save_now_pic)
	end

	function arg_1_0:__onClick_left_ship_btns_achieve_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		var_0_1:createInstance("achievement"):show(self._data.statistics)
	end

	function arg_1_0:__onToggle_all_do_left_ship_btns_lock_toggle()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))

		if self._no_req then
			return
		end

		local function var_12_0()
			self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))

			self._no_req = true

			if self and self._control then
				self._control.left.ship_btns.lock_toggle.toggle.isOn = false
			end

			self._no_req = false

			var_0_3:req_ShipLock({
				id = self._data.id
			})
		end

		local function var_12_1()
			self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))

			self._no_req = true

			if self and self._control then
				self._control.left.ship_btns.lock_toggle.toggle.isOn = true
			end

			self._no_req = false
		end

		if not self._control.left.ship_btns.lock_toggle.toggle.isOn then
			local var_12_2 = var_0_1:getInstance("msgbox") or var_0_1:createInstance("msgbox")

			self._no_req = true
			self._control.left.ship_btns.lock_toggle.toggle.isOn = true
			self._no_req = false

			if self._data.statistics and next(self._data.statistics) and self._data.statistics.medal and next(self._data.statistics.medal) then
				var_12_2:show(var_0_4:getNowLang("unlockshipornot"), var_12_0, var_12_1, var_0_4:getNowLang("unlockship"), var_0_2.msg_type.tip)

				self._is__ship_have_medal = true
			else
				var_12_2:show(var_0_4:getNowLang("unlockshipornotb"), var_12_0, var_12_1, var_0_4:getNowLang("unlockship"), var_0_2.msg_type.tip)

				self._is__ship_have_medal = false
			end
		else
			var_0_3:req_ShipLock({
				id = self._data.id
			})
		end
	end

	function arg_1_0:__onToggle_all_do_left_ship_btns_leader_toggle()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))

		if not self._no_req then
			({}).id = self._data.id

			local var_15_0 = lx.clone_table(var_0_3:get_secretary_info().members)

			if self._control.left.ship_btns.leader_toggle.toggle.isOn then
				if var_15_0 and next(var_15_0) then
					if #var_15_0 < 6 then
						var_0_14(var_15_0, self._data.id)
						var_0_3:req_ChangeSecretaryDataReq(var_15_0)
						var_0_5:show(var_0_4:getNowLang("setsecrataryok"))
					else
						var_0_5:show(var_0_4:getNowLang("secretary_max"))
					end
				end
			elseif var_15_0 and next(var_15_0) then
				if #var_15_0 > 1 then
					for iter_15_0, iter_15_1 in pairs(var_15_0) do
						if iter_15_1 == self._data.id then
							table.remove(var_15_0, iter_15_0)
						end
					end

					var_0_3:req_ChangeSecretaryDataReq(var_15_0)
					var_0_5:show(var_0_4:getNowLang("secretarial_cancellation"))
				else
					var_0_3:req_ResetSecretary()
				end
			end
		end
	end

	function arg_1_0:__onClick_left_ship_btns_view_btn()
		var_0_8.multiTouchEnabled = true
		self._ui_close_state = true

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))

		if self.can_not_click then
			return
		end

		self._control.left.ship_role.image.raycastTarget = true
		self._control.role_scale.slide.slider.value = 0

		self:playViewAni()
		self:__look_over_view(true)

		if self._is_team and #self._members > 1 then
			self._control.left.drag_for_switch:SetActive(false)
		end
	end

	function arg_1_0:__onClick_left_ship_love_love_btn()
		if self:__check_abyss_prepare_point("love") then
			return
		end

		if self:__check_strike_battle_number("love") then
			return
		end

		if self:__is_special_type(2) and var_0_3:get_other_info() then
			return
		end

		if self._is_my_ship and (self._special_enter_type == var_0_2.enter_ship_detail_type.robot_ship or self._special_enter_type == var_0_2.enter_ship_detail_type.captainroom_friend_fleet) then
			return
		end

		self._control.tip_layer:SetActive(false)

		local var_17_0 = var_0_1:createInstance("marry")

		var_17_0:show(self._data, self._save_data_to_marry)

		var_17_0._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 2
	end

	function arg_1_0:__onClick_right_ship_detail_ship_equip_equip_1_add_equip()
		self:__add_equip(1)
	end

	function arg_1_0:__onClick_right_ship_detail_ship_equip_equip_1_equipment_change_btn()
		if not self._is_robot then
			self:__change_equip(1)
		end
	end

	function arg_1_0:__onClick_right_ship_detail_ship_equip_equip_1_equipment_off_btn()
		self:__remove_equip(1)
	end

	function arg_1_0:__onClick_right_ship_detail_ship_equip_equip_2_add_equip()
		self:__add_equip(2)
	end

	function arg_1_0:__onClick_right_ship_detail_ship_equip_equip_2_equipment_change_btn()
		if not self._is_robot then
			self:__change_equip(2)
		end
	end

	function arg_1_0:__onClick_right_ship_detail_ship_equip_equip_2_equipment_off_btn()
		self:__remove_equip(2)
	end

	function arg_1_0:__onClick_right_ship_detail_ship_equip_equip_3_add_equip()
		self:__add_equip(3)
	end

	function arg_1_0:__onClick_right_ship_detail_ship_equip_equip_3_equipment_change_btn()
		if not self._is_robot then
			self:__change_equip(3)
		end
	end

	function arg_1_0:__onClick_right_ship_detail_ship_equip_equip_3_equipment_off_btn()
		self:__remove_equip(3)
	end

	function arg_1_0:__onClick_right_ship_detail_ship_equip_equip_4_add_equip()
		self:__add_equip(4)
	end

	function arg_1_0:__onClick_right_ship_detail_ship_equip_equip_4_equipment_change_btn()
		if not self._is_robot then
			self:__change_equip(4)
		end
	end

	function arg_1_0:__onClick_right_ship_detail_ship_equip_equip_4_equipment_off_btn()
		self:__remove_equip(4)
	end

	function arg_1_0:__onClick_right_ship_detail_detail_info_tactics_content_change_tactics_btn()
		self:__change_tactics()
	end

	function arg_1_0:__onClick_right_ship_detail_detail_info_tactics_content_tactics_1_add_btn()
		self:__change_tactics()
	end

	function arg_1_0:__onClick_right_ship_detail_detail_info_tactics_content_tactics_2_add_btn()
		self:__change_tactics()
	end

	function arg_1_0:__onClick_right_ship_detail_detail_info_tactics_content_tactics_3_add_btn()
		self:__change_tactics()
	end

	function arg_1_0:__onClick_right_ship_detail_detail_info_right_arrow()
		self._is_tactics = true

		self:__refresh_detail_page()
	end

	function arg_1_0:__onClick_right_ship_detail_detail_info_left_arrow()
		if not self._is_tactics then
			return
		end

		self._is_tactics = false

		self:__refresh_detail_page()
	end

	function arg_1_0:__onClick_right_btn_ship_change_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))

		if not gameenum.common_type.open_broken then
			return
		end

		local var_36_0 = lx.UserData:getKeyData(var_0_2.setting_key_list.setting_broken)

		if not ((var_36_0 ~= "" and var_36_0 ~= " " or nil) and lx.json_decode(var_36_0).value) then
			return
		end

		self._control.right_btn_ship.switch_btn.toggle.isOn = false

		local var_36_2

		if self._changed_image then
			var_36_2 = self._data.now_hp and self._data.hp and self._data.now_hp / self._data.hp < gameenum.common_type.health_sprite_rule.yellow.max_value and gameenum.common_type.ship_icon.model_broken_l or gameenum.common_type.ship_icon.model_normal_l

			if not self._data.now_hp then
				var_36_2 = gameenum.common_type.ship_icon.model_normal_l
			end
		else
			var_36_2 = self._data.now_hp and self._data.hp and self._data.now_hp / self._data.hp >= gameenum.common_type.health_sprite_rule.yellow.max_value and gameenum.common_type.ship_icon.model_broken_l or gameenum.common_type.ship_icon.model_normal_l

			if not self._data.now_hp then
				var_36_2 = gameenum.common_type.ship_icon.model_broken_l
			end
		end

		local var_36_3 = 0

		if self._now_ship_data then
			for iter_36_0, iter_36_1 in pairs(self._now_ship_data.skins) do
				if self._data.skin == iter_36_1 then
					var_36_3 = iter_36_0
				end
			end
		end

		if var_36_3 ~= 0 then
			if self._now_ship_data then
				self._control.left.ship_role.image.sprite = self:loadSprite(var_0_2:get_ship_icon(var_36_2, self:__get_skin_cfg(self._now_ship_data.skins[var_36_3]).icon))
			elseif self._data.pic_id then
				self._control.left.ship_role.image.sprite = self:loadSprite(var_0_2:get_ship_icon(var_36_2, self._data.pic_id))
			end
		elseif self._now_ship_data then
			self._control.left.ship_role.image.sprite = self:loadSprite(var_0_2:get_ship_icon(var_36_2, self._now_ship_data.pic_id))
		elseif self._data.pic_id then
			self._control.left.ship_role.image.sprite = self:loadSprite(var_0_2:get_ship_icon(var_36_2, self._data.pic_id))
		end

		self._changed_image = not self._changed_image
	end

	function arg_1_0:__onClick_right_btn_ship_view_btn()
		var_0_8.multiTouchEnabled = false
		self._ui_close_state = false

		if self._enter_type == var_0_2.enter_ship_detail_type.war_concerto_play then
			var_0_1:destroyInstance("ship_detail")
			var_0_1:destroyInstance("equip_list")

			return
		end

		self._control.left.ship_role.image.sprite = self._now_paint_sprite
		self._changed_image = false
		self._control.left.ship_role.image.raycastTarget = false

		self:playReverseAni()

		if self._enter_type == var_0_2.enter_ship_detail_type.upgradeawards or self._enter_type == var_0_2.enter_ship_detail_type.bootyshop or self._enter_type == var_0_2.enter_ship_detail_type.seven_bootyshop or self._enter_type == var_0_2.enter_ship_detail_type.mail_ship_award or self._enter_type == var_0_2.enter_ship_detail_type.ship_map or self._enter_type == var_0_2.enter_ship_detail_type.eighth_bootyshop or self._enter_type == var_0_2.enter_ship_detail_type.new_ship then
			self._control.left.alone_view_btn:SetActive(true)
			self._control.left.skip_info:SetActive(true)
			self._control.right:SetActive(true)
			self._control.right_btn_ship:SetActive(false)
			self._control.role_scale:SetActive(false)
			self._control.left.return_btn:SetActive(true)

			if self._enter_type == var_0_2.enter_ship_detail_type.ship_map then
				self._control.left.skin_btns:SetActive(true)
				self._control.left.alone_view_btn:SetActive(false)
			end
		else
			self:__look_over_view(false)

			if self._is_team and #self._members > 1 then
				self._control.left.drag_for_switch:SetActive(true)
			end
		end

		if self._special_paint_url ~= nil and self._control.right_btn_ship.switch_btn.toggle.isOn then
			self._control.left.ship_role.image.sprite = self:loadSprite(self._normal_paint_url)
			self._control.right_btn_ship.switch_btn.toggle.isOn = false
		end
	end

	function arg_1_0:__onClick_role_scale_add_btn()
		self._control.role_scale.slide.slider.value = self._control.role_scale.slide.slider.value + 0.1 > 1 and 1 or self._control.role_scale.slide.slider.value + 0.1
	end

	function arg_1_0:__onClick_role_scale_reduce_btn()
		self._control.role_scale.slide.slider.value = self._control.role_scale.slide.slider.value - 0.1 < 0 and 0 or self._control.role_scale.slide.slider.value - 0.1
	end

	function arg_1_0:__onClick_video_btn_layer_close_btn()
		self._control.video_btn_layer:SetActive(false)
	end

	function arg_1_0:__onClick_video_btn_layer_video_btn_1()
		var_0_1:createInstance("new_ship_or_equip"):show(true, self._now_ship_data, var_0_2.enter_get_ship_type.ship_detail)
	end

	function arg_1_0:__onClick_video_btn_layer_video_btn_2()
		local var_42_0 = var_0_1:createInstance("marry_ok")

		if self._now_lable == 2 and self._need_buy == false then
			local var_42_1 = {}

			if #self._now_ship_data.skins > 0 then
				for iter_42_0, iter_42_1 in pairs(self._now_ship_data.skins) do
					table.insert(var_42_1, iter_42_1)
				end

				for iter_42_2, iter_42_3 in ipairs(var_42_1) do
					if not self._now_ship_data.evo_class and (iter_42_3 - 1000000000) % 10000 % 1000 / 100 < 0.9 then
						table.remove(var_42_1, iter_42_2)
					end
				end
			end

			local var_42_2 = false

			if self._now_label == 1 then
				if self._now_index_2 == 0 then
					var_42_0:show(self._now_ship_data.cid, nil, var_0_2.enter_marry_ok_type.ship_map, self._now_ship_data.pic_id, var_42_2)
				else
					var_42_0:show(self._now_ship_data.cid, nil, var_0_2.enter_marry_ok_type.ship_map, self:__get_skin_cfg(var_42_1[self._now_index_2]).icon, var_42_2)
				end
			elseif self._now_label == 2 then
				if self._now_index_2 and self._now_index_2 == 0 then
					var_42_0:show(self._now_ship_data.cid, nil, var_0_2.enter_marry_ok_type.ship_map, self._now_ship_data.pic_id, var_42_2)
				elseif self._now_index_2 >= 1 then
					var_42_0:show(self._now_ship_data.cid - 1000000, nil, var_0_2.enter_marry_ok_type.ship_map, self:__get_skin_cfg(var_42_1[self._now_index_2]).icon, true)
				end
			end
		else
			var_42_0:show(self._now_ship_data.cid)
		end
	end

	function arg_1_0.__onToggle_skin_layer_scrollview_content_role_icon(arg_43_0)
		return
	end

	function arg_1_0.__onClick_skin_layer_skin_bg_1_email(arg_44_0)
		return
	end

	function arg_1_0:__onClick_skin_layer_skin_bg_2_confirmbtn()
		if self._now_lable == 0 then
			local var_45_0 = var_0_6.find_object_by_cid(self._now_ship_data.cid)

			var_0_1:createInstance("shop_bounced"):show({
				type = 5,
				price = var_45_0.gold,
				id = var_45_0.cid,
				title = var_45_0.title,
				discount = var_45_0.sale_discount,
				is_sale = var_45_0.is_sale,
				sale_start_time = var_45_0.sale_start_time,
				sale_end_time = var_45_0.sale_end_time
			})
		else
			local var_45_3 = {}
			local var_45_4

			if self._skin_num == #self._now_ship_data.skins then
				var_45_4 = var_0_6.find_object_by_cid(self._now_ship_data.skins[self._now_show_skin_icon])
			else
				for iter_45_0, iter_45_1 in pairs(self._now_ship_data.skins) do
					table.insert(var_45_3, iter_45_1)
				end

				for iter_45_2, iter_45_3 in pairs(var_45_3) do
					local var_45_5 = var_0_6.find_object_by_cid(iter_45_3)

					if #var_45_5.card_cids == 1 and var_45_5.card_cids[1] ~= self._now_ship_data.cid then
						table.remove(var_45_3, iter_45_2)
					end
				end

				var_45_4 = var_0_6.find_object_by_cid(var_45_3[self._now_show_skin_icon])
			end

			var_0_1:createInstance("shop_bounced"):show({
				type = 5,
				price = var_45_4.gold,
				id = var_45_4.cid,
				title = var_45_4.title,
				discount = var_45_4.sale_discount,
				is_sale = var_45_4.is_sale,
				sale_start_time = var_45_4.sale_start_time,
				sale_end_time = var_45_4.sale_end_time
			})
		end
	end

	function arg_1_0:__onClick_skin_layer_skin_bg_2_usebtn()
		local var_46_0 = 0

		if self._enter_type == var_0_2.enter_ship_detail_type.mall_shop and self._now_character_data.bought then
			local var_46_1 = self._now_character_data.card_cids

			local function var_46_2(arg_47_0)
				for iter_47_0, iter_47_1 in ipairs(var_46_1) do
					if iter_47_1 == arg_47_0 then
						return true
					end
				end

				return false
			end

			local var_46_3 = {}

			for iter_46_0, iter_46_1 in pairs((var_0_3:get_character_list())) do
				if var_46_2(iter_46_1.cid) then
					var_46_3[#var_46_3 + 1] = iter_46_1
				end
			end

			if #var_46_3 <= 0 then
				if self._now_character_data.is_have then
					gamecore.prompt:show(var_0_4:getNowLang("leaderboardship") .. var_0_4:getNowLang("state_no_possess"))

					return
				else
					gamecore.prompt:show(var_0_4:getNowLang("shipnotget"))
					self:leave_ship()

					return
				end
			end

			local var_46_4 = var_0_1:createInstance("change_skin_panel")

			var_46_4:show(self._now_character_data.now_data, var_46_3)

			local var_46_5 = var_46_4._panel:GetComponent("Canvas")

			var_46_5.sortingOrder = var_46_5.sortingOrder + 200
		elseif self._now_show_skin_icon ~= 0 then
			local var_46_6 = {}

			if self._skin_num == #self._now_ship_data.skins then
				var_46_0 = self._now_ship_data.skins[self._now_show_skin_icon]
			else
				for iter_46_2, iter_46_3 in pairs(self._now_ship_data.skins) do
					table.insert(var_46_6, iter_46_3)
				end

				for iter_46_4, iter_46_5 in pairs(var_46_6) do
					local var_46_8 = var_0_6.find_object_by_cid(iter_46_5)

					if #var_46_8.card_cids == 1 and var_46_8.card_cids[1] ~= self._now_ship_data.cid then
						table.remove(var_46_6, iter_46_4)
					end
				end

				var_46_0 = var_46_6[self._now_show_skin_icon]
			end
		end

		if self._enter_type ~= var_0_2.enter_ship_detail_type.mall_shop then
			if not self._is_marry and self._marry_type == 2 then
				var_0_5:show(var_0_4:getNowLang("not_marry_skin"))
			else
				var_0_3:req_ShipChangeSkin({
					id = self._data.id,
					skin_id = var_46_0
				})
			end
		end
	end

	function arg_1_0.__onToggle_skin_layer_scrollview_content_single_skin_icon(arg_48_0)
		return
	end

	function arg_1_0.__onClick_skin_layer_skin_bg_1_tip_list_tip(arg_49_0)
		return
	end

	function arg_1_0:__onClick_tip_layer()
		if self._now_click_desc_trans then
			self._now_click_desc_trans:GetChild(0).gameObject:SetActive(false)
		end

		self:__show_equip_attr_panel(false)
		self._control.tip_layer:SetActive(false)
	end

	function arg_1_0.__onClick_skin_layer_skin_bg_1_desc_list_desc(arg_51_0)
		return
	end

	function arg_1_0:__onLeftDragEnd_left_drag_for_switch()
		self.can_not_click = true

		var_0_2:play_in_out_animation(self._control.bg.uITweenSequence, true, function()
			self.can_not_click = false

			local var_53_0 = #self._members
			local var_53_1 = self:get_single_ship_index()

			if not self._index and var_53_1 and var_53_1 > 0 then
				self._index = var_53_1
			end

			if self._index then
				self._index = self._index == var_53_0 and 1 or self._index + 1

				self:set_data_by_index(self._index)
				self:__init_panel()
				self:show_layer(1)
				var_0_2:play_in_out_animation(self._control.left.drag_for_switch.uITweenSequence, false)
			end
		end)
	end

	function arg_1_0:get_single_ship_index()
		if self._enter_type == var_0_2.enter_ship_detail_type.single_ship and self._special_enter_type and self._special_enter_type == var_0_2.enter_ship_detail_type.captainroom_fleet then
			local var_54_0 = var_0_3:get_captainroom_garrison()

			if var_54_0 and next(var_54_0) then
				for iter_54_0, iter_54_1 in pairs(var_54_0) do
					if iter_54_1 == self._data.id then
						return iter_54_0
					end
				end
			end

			return
		end

		local var_54_1 = var_0_1:getInstance("captainroom_fleet")

		if var_54_1 and not var_0_1:getInstance("select_member") then
			if self._enter_type == var_0_2.enter_ship_detail_type.single_ship then
				self._is_team = true

				if var_54_1._enter_team and next(var_54_1._enter_team) then
					for iter_54_2, iter_54_3 in pairs(var_54_1._enter_team) do
						if iter_54_3 == self._data.id then
							return iter_54_2
						end
					end
				end
			end
		elseif self._enter_type == var_0_2.enter_ship_detail_type.single_ship or self._enter_type == var_0_2.enter_ship_detail_type.sixth_select or self._enter_type == var_0_2.enter_ship_detail_type.dock_team_equip or self._enter_type == var_0_2.enter_ship_detail_type.dock then
			local var_54_2 = var_0_3:get_all_select_member_list()

			if self._is_tactics_panel then
				var_54_2 = var_0_3:get_tactics_all_select_member_list()
			end

			if var_54_2 and next(var_54_2) then
				for iter_54_4, iter_54_5 in pairs(var_54_2) do
					if iter_54_5 == self._data.id then
						return iter_54_4
					end
				end
			end
		end
	end

	function arg_1_0:__onRightDragEnd_left_drag_for_switch()
		var_0_2:play_in_out_animation(self._control.left.drag_for_switch.uITweenSequence, true, function()
			local var_56_0 = #self._members
			local var_56_1 = self:get_single_ship_index()

			if not self._index and var_56_1 and var_56_1 > 0 then
				self._index = var_56_1
			end

			if self._index then
				self._index = self._index == 1 and var_56_0 or self._index - 1

				self:set_data_by_index(self._index)
				self:__init_panel()
				self:show_layer(1)
				var_0_2:play_in_out_animation(self._control.bg.uITweenSequence, false)
			end
		end)
	end

	function arg_1_0.__onToggle_left_ship_btns_dress_toggle(arg_57_0)
		return
	end

	function arg_1_0.__onToggle_left_ship_btns_lock_toggle(arg_58_0)
		return
	end

	function arg_1_0.__onToggle_left_ship_btns_leader_toggle(arg_59_0)
		return
	end

	function arg_1_0:__onLongClick_right_ship_detail_ship_equip_equip_1_equipment_change_btn()
		self:__show_equip_att(self._control.right.ship_detail.ship_equip.equip_1.equipment.change_btn, 1)
	end

	function arg_1_0:__onLongClick_right_ship_detail_ship_equip_equip_2_equipment_change_btn()
		self:__show_equip_att(self._control.right.ship_detail.ship_equip.equip_2.equipment.change_btn, 2)
	end

	function arg_1_0:__onLongClick_right_ship_detail_ship_equip_equip_3_equipment_change_btn()
		self:__show_equip_att(self._control.right.ship_detail.ship_equip.equip_3.equipment.change_btn, 3)
	end

	function arg_1_0:__onLongClick_right_ship_detail_ship_equip_equip_4_equipment_change_btn()
		self:__show_equip_att(self._control.right.ship_detail.ship_equip.equip_4.equipment.change_btn, 4)
	end

	function arg_1_0:__onPointerUp_right_ship_detail_ship_equip_equip_1_equipment_change_btn()
		self:__show_equip_attr_panel(false)
	end

	function arg_1_0:__onPointerUp_right_ship_detail_ship_equip_equip_2_equipment_change_btn()
		self:__show_equip_attr_panel(false)
	end

	function arg_1_0:__onPointerUp_right_ship_detail_ship_equip_equip_3_equipment_change_btn()
		self:__show_equip_attr_panel(false)
	end

	function arg_1_0:__onPointerUp_right_ship_detail_ship_equip_equip_4_equipment_change_btn()
		self:__show_equip_attr_panel(false)
	end

	function arg_1_0:__onClick_left_ship_btns_equip_record_btn()
		if self:__check_abyss_prepare_point("equip") then
			return
		elseif self._data.state == var_0_2.ship_state.expedition then
			var_0_5:show(var_0_4:getNowLang("pveinexpore"))

			return
		end

		if self:__check_strike_battle_number("equip") then
			return
		end

		self:setVisible(false)

		local var_68_0 = var_0_1:createInstance("equip_record")

		var_68_0:show(self._data)
		var_68_0:__set_current_data("tog_one")
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_1_add_equip()
		self:__add_equip(1)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_1_equipment_change_btn()
		self:__change_equip(1)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_1_equipment_off_btn()
		self:__remove_equip(1)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_2_add_equip()
		self:__add_equip(2)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_2_equipment_change_btn()
		self:__change_equip(2)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_2_equipment_off_btn()
		self:__remove_equip(2)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_3_add_equip()
		self:__add_equip(3)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_3_equipment_change_btn()
		self:__change_equip(3)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_3_equipment_off_btn()
		self:__remove_equip(3)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_4_add_equip()
		self:__add_equip(4)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_4_equipment_change_btn()
		self:__change_equip(4)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_4_equipment_off_btn()
		self:__remove_equip(4)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_1_equipment_attr_btn()
		self:__show_equip_detail_equip_att(self._control.right.ship_equip_detail.content.equip_1.equipment.down, 1)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_2_equipment_attr_btn()
		self:__show_equip_detail_equip_att(self._control.right.ship_equip_detail.content.equip_2.equipment.down, 2)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_3_equipment_attr_btn()
		self:__show_equip_detail_equip_att(self._control.right.ship_equip_detail.content.equip_3.equipment.down, 3)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_content_equip_4_equipment_attr_btn()
		self:__show_equip_detail_equip_att(self._control.right.ship_equip_detail.content.equip_4.equipment.down, 4)
	end

	function arg_1_0:__onClick_left_alone_view_btn()
		var_0_8.multiTouchEnabled = true
		self._ui_close_state = true
		self._control.left.ship_role.image.raycastTarget = true
		self._control.role_scale.slide.slider.value = 0

		self:playViewAni()
		self._control.left.alone_view_btn:SetActive(false)
		self._control.left.return_btn:SetActive(false)
		self._control.right:SetActive(false)
		self._control.right_btn_ship:SetActive(true)
		self._control.role_scale:SetActive(true)

		if self._enter_type == var_0_2.enter_ship_detail_type.ship_map then
			self._control.left.skin_btns:SetActive(false)
			self._control.left.skip_info:SetActive(false)
		end

		if self._enter_type == var_0_2.enter_ship_detail_type.upgradeawards then
			self._control.left.skip_info:SetActive(false)
		end

		if self._enter_type == var_0_2.enter_ship_detail_type.bootyshop or self._enter_type == var_0_2.enter_ship_detail_type.eighth_bootyshop or self._enter_type == var_0_2.enter_ship_detail_type.seven_bootyshop then
			self._control.left.skip_info:SetActive(false)
		end

		self:__look_over_view(true)
	end

	function arg_1_0:__onToggle_all_do_right_btn_ship_switch_btn()
		if self._control.right_btn_ship.switch_btn.toggle.isOn then
			local var_86_0, var_86_1 = self:loadSprite(self._fight_specail_url)

			self._control.left.ship_role.image.sprite = var_86_0

			if self._is_picture_hd == false and var_86_1 then
				var_0_2:hd_sprite_half_scale(self._control.left.ship_role.transform)

				self._is_picture_hd = true
			elseif not var_86_1 then
				self._is_picture_hd = false
			end
		else
			local var_86_2, var_86_3 = self:loadSprite(self._fight_normal_url)

			self._control.left.ship_role.image.sprite = var_86_2

			if self._is_picture_hd == false and var_86_3 then
				var_0_2:hd_sprite_half_scale(self._control.left.ship_role.transform)

				self._is_picture_hd = true
			elseif not var_86_3 then
				self._is_picture_hd = false
			end
		end
	end

	function arg_1_0.__onToggle_right_btn_ship_switch_btn(arg_87_0)
		return
	end

	function arg_1_0:__onClick_left_skin_btns_view_btn()
		self:__onClick_left_alone_view_btn()
	end

	function arg_1_0:__onClick_left_ship_btns_set_custom_btn()
		local var_89_0 = var_0_3:get_custom_ship_list()

		if var_89_0 and next(var_89_0) then
			if #var_89_0 >= var_0_2.max_select_type.two_hundred then
				var_0_5:show(var_0_13(var_0_4:getNowLang("selectstrenmaterialmax"), var_0_2.max_select_type.two_hundred))

				return
			elseif self._data then
				var_0_14(var_89_0, self._data.id)
				var_0_3:req_ChangeStarSetReq(var_89_0)
				var_0_3:_set_custom_ship_state(true)
			end
		elseif self._data then
			var_0_14(var_89_0, self._data.id)
			var_0_3:_set_custom_ship_state(true)
			var_0_3:req_ChangeStarSetReq(var_89_0)
		end
	end

	function arg_1_0:__onClick_left_ship_btns_cancel_custom_btn()
		local var_90_0 = var_0_3:get_custom_ship_list()
		local var_90_1 = {}

		if var_90_0 and next(var_90_0) then
			for iter_90_0, iter_90_1 in ipairs(var_90_0) do
				if iter_90_1 ~= self._data.id then
					var_0_14(var_90_1, iter_90_1)
				end
			end
		end

		if var_90_1 and next(var_90_1) then
			var_0_3:_set_custom_ship_state(false)
			var_0_3:req_ChangeStarSetReq(var_90_1)
		elseif #var_90_0 == 1 then
			var_0_3:_set_custom_ship_state(false)
			var_0_3:req_ChangeStarSetReq({
				0
			})
		end
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_1_add_equip()
		self:__add_equip(1)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_1_equipment_change_btn()
		if not self._is_robot then
			self:__change_equip(1)
		end
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_1_equipment_off_btn()
		self:__remove_equip(1)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_1_equipment_attr_btn()
		self:__show_equip_detail_equip_att(self._control.right.ship_equip_detail.ship_equip_detail_content.equip_1.equipment.down, 1)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_2_add_equip()
		self:__add_equip(2)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_2_equipment_change_btn()
		if not self._is_robot then
			self:__change_equip(2)
		end
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_2_equipment_off_btn()
		self:__remove_equip(2)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_2_equipment_attr_btn()
		self:__show_equip_detail_equip_att(self._control.right.ship_equip_detail.ship_equip_detail_content.equip_2.equipment.down, 2)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_3_add_equip()
		self:__add_equip(3)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_3_equipment_change_btn()
		if not self._is_robot then
			self:__change_equip(3)
		end
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_3_equipment_off_btn()
		self:__remove_equip(3)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_3_equipment_attr_btn()
		self:__show_equip_detail_equip_att(self._control.right.ship_equip_detail.ship_equip_detail_content.equip_3.equipment.down, 3)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_4_add_equip()
		self:__add_equip(4)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_4_equipment_change_btn()
		if not self._is_robot then
			self:__change_equip(4)
		end
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_4_equipment_off_btn()
		self:__remove_equip(4)
	end

	function arg_1_0:__onClick_right_ship_equip_detail_ship_equip_detail_content_equip_4_equipment_attr_btn()
		self:__show_equip_detail_equip_att(self._control.right.ship_equip_detail.ship_equip_detail_content.equip_4.equipment.down, 4)
	end

	function arg_1_0:__onClick_left_ship_btns_secretary_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))

		if not self._no_req then
			({}).id = self._data.id

			local var_107_0 = lx.clone_table(var_0_3:get_secretary_info().members)

			if var_0_12.have_data(var_107_0, self._data.id) then
				if #var_107_0 > 1 then
					for iter_107_0, iter_107_1 in pairs(var_107_0) do
						if iter_107_1 == self._data.id then
							table.remove(var_107_0, iter_107_0)
						end
					end

					var_0_3:req_ChangeSecretaryDataReq(var_107_0)
					var_0_5:show(var_0_4:getNowLang("secretarial_cancellation"))

					self._control.left.ship_btns.secretary_btn.image.sprite = self:loadSprite(var_0_2.secretary_list_img.shipDetail_btn_leader_active1)
				else
					local var_107_1 = lx.clone_table(var_0_3:get_team_all_data())[1][1]

					var_0_5:show(var_0_4:getNowLang("resetsecrataryok"))
					var_0_3:req_ChangeSecretaryDataReq({
						var_107_1.members[1]
					})

					self._control.left.ship_btns.secretary_btn.image.sprite = self:loadSprite(var_0_2.secretary_list_img.shipDetail_btn_leader_active1)
				end
			elseif var_107_0 and next(var_107_0) then
				if #var_107_0 > 5 then
					var_0_5:show(var_0_4:getNowLang("secretary_max"))

					self._control.left.ship_btns.secretary_btn.image.sprite = self:loadSprite(var_0_2.secretary_list_img.shipDetail_btn_leader_active1)
				else
					var_0_14(var_107_0, self._data.id)
					var_0_3:req_ChangeSecretaryDataReq(var_107_0)
					var_0_5:show(var_0_4:getNowLang("setsecrataryok"))

					self._control.left.ship_btns.secretary_btn.image.sprite = self:loadSprite(var_0_2.secretary_list_img.shipDetail_btn_leader_unactive1)
				end
			end
		end
	end

	function arg_1_0:__add_equip(arg_108_1)
		local var_108_0 = var_0_1:getInstance("equip_list")

		if var_108_0 then
			var_108_0._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		if self:__check_abyss_prepare_point("equip") then
			return
		end

		if self:__check_strike_battle_number("equip") then
			return
		end

		if var_0_3:get_other_info() then
			return
		elseif self:__is_special_type(1) then
			return
		elseif self._data.state == var_0_2.ship_state.expedition then
			var_0_5:show(var_0_4:getNowLang("pveinexpore"))

			return
		end

		self:setVisible(false)

		var_108_0 = var_108_0 or var_0_1:createInstance("equip_list")

		var_108_0:show(self._data, nil, arg_108_1)
	end

	function arg_1_0:__change_equip(arg_109_1)
		local var_109_0 = var_0_1:getInstance("equip_list")

		if var_109_0 then
			var_109_0._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		if self:__check_abyss_prepare_point("equip") then
			return
		end

		if self:__check_strike_battle_number("equip") then
			return
		end

		if var_0_3:get_other_info() then
			return
		elseif self:__is_special_type(1) then
			return
		elseif self._data.state == var_0_2.ship_state.expedition then
			var_0_5:show(var_0_4:getNowLang("pveinexpore"))

			return
		end

		self:setVisible(false)

		var_109_0 = var_109_0 or var_0_1:createInstance("equip_list")

		var_109_0:show(self._data, self:__get_equip_data(arg_109_1), arg_109_1)
	end

	function arg_1_0:__remove_equip(arg_110_1)
		if self:__check_abyss_prepare_point("equip") then
			return
		end

		if self:__check_strike_battle_number("equip") then
			return
		end

		if var_0_3:get_other_info() then
			return
		elseif self:__is_special_type(1) then
			return
		elseif self._data.state == var_0_2.ship_state.station then
			var_0_5:show(var_0_4:getNowLang("noticeshipisinguard"))

			return
		elseif self._data.state == var_0_2.ship_state.expedition then
			var_0_5:show(var_0_4:getNowLang("pveinexpore"))

			return
		end

		local var_110_0 = {
			id = self._data.id,
			pos = arg_110_1
		}
		local var_110_1 = self:__get_equip_data(arg_110_1)

		local function var_110_2()
			var_0_3:req_ShipRemoveEquip(var_110_0)
		end

		if var_110_1 then
			if var_110_1.type == 32 or var_110_1.type == 33 then
				var_0_1:createInstance("msgbox"):show(var_0_4:getNowLang("tipunequipmissile"), var_110_2, nil, var_0_4:getNowLang("tipmessage"))
			else
				var_110_2()
			end
		end
	end

	function arg_1_0:__change_tactics()
		if self:__check_abyss_prepare_point("tactic") then
			return
		end

		if self:__is_special_type(2) and self._is_my_ship then
			return
		end

		if self._special_enter_type == var_0_2.enter_ship_detail_type.captainroom_friend_fleet or self._special_enter_type == var_0_2.enter_ship_detail_type.robot_ship then
			return
		end

		local var_112_0 = var_0_1:createInstance("change_tactics")

		var_112_0._enter_type = self._enter_type

		var_112_0:show(self._data)
	end

	function arg_1_0.__get_dock_team_index(arg_113_0)
		local var_113_0 = var_0_1:getInstance("dock_team")
		local var_113_1

		if var_113_0 then
			var_113_1 = var_113_0:get_current_team_index()

			if var_113_1 and var_113_1 == 5 then
				var_113_0:setVisible(true)
				var_113_0:__onToggle_bg_top_menu_fleet_toggle_fleetid5()
			end
		end

		return var_113_1
	end

	function arg_1_0.__check_abyss_prepare_point(arg_114_0, arg_114_1)
		if var_0_3:get_abyss_enter_repair_time() ~= 0 then
			local var_114_0

			if arg_114_1 == "equip" then
				var_114_0 = var_0_4:getNowLang("battlecantequip")
			elseif arg_114_1 == "tactic" then
				var_114_0 = var_0_4:getNowLang("battlecanttactic")
			elseif arg_114_1 == "love" then
				return true
			end

			var_0_5:show(nil)

			return true
		end
	end

	function arg_1_0.__check_strike_battle_number(arg_115_0, arg_115_1)
		local var_115_0 = var_0_3:get_strike_enter_battle_nunber()

		if var_115_0 and var_115_0 >= 1 then
			local var_115_1

			if arg_115_1 == "equip" then
				var_115_1 = var_0_4:getNowLang("battlecantequip")
			elseif arg_115_1 == "school" then
				var_115_1 = var_0_4:getNowLang("inoutcannotgotoshool")
			elseif arg_115_1 == "love" then
				return true
			end

			var_0_5:show(nil)

			return true
		end
	end
end

function var_0_0.extend_obj(arg_116_0)
	arg_116_0._is__ship_have_medal = false
end

return var_0_0
