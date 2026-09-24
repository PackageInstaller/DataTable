local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.prompt
local var_0_5 = gamecore.user
local var_0_7 = gamecore.AudioManager
local var_0_11 = gameconfig.skin_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_new_ship_ship_detail_btn()
		self:setVisible(false)

		local var_2_0 = var_0_1:createInstance("ship_detail")

		if self._enter_type == var_0_3.enter_get_ship_type.mail_ship_award then
			var_2_0:show(var_0_3.enter_ship_detail_type.mail_ship_award, self._ship_data)
		else
			var_2_0:show(var_0_3.enter_ship_detail_type.new_ship, self._ship_data)
		end
	end

	function arg_1_0:__onClick_back_btn()
		if not self._is_new_ship then
			if self._enter_type == var_0_3.enter_get_ship_type.mail_ship_award and not gamecore.util_func.have_index(self._data, "skills") then
				self._data = var_0_5:find_character_by_id(self._data.id)
			end

			if not self._data.skills or self._data.skills and #self._data.skills < 2 then
				var_0_7:init()
			end
		end

		if self._seven_out_type then
			local var_3_0 = var_0_1:getInstance("cover")

			if var_3_0 then
				var_3_0:setVisible(false)
			end

			self._seven_out_type = nil
		end

		if self._enter_type == var_0_3.enter_get_ship_type.ship_detail then
			var_0_7:destroyCV()
			self:_bgm_play()
		end

		if self._skin_data then
			local var_3_1 = var_0_1:createInstance("msgbox")

			var_3_1:show((self._ship_data or nil) and string.format(var_0_2:getNowLang("skin_replace_desc"), self._ship_data.title), function()
				local var_5_0 = self._skin_data.card_cids

				local function var_5_1(arg_6_0)
					for iter_6_0, iter_6_1 in ipairs(var_5_0) do
						if iter_6_1 == arg_6_0 then
							return true
						end
					end

					return false
				end

				local var_5_2 = {}

				for iter_5_0, iter_5_1 in pairs((var_0_5:get_character_list())) do
					if var_5_1(iter_5_1.cid) then
						var_5_2[#var_5_2 + 1] = iter_5_1
					end
				end

				if #var_5_2 <= 0 then
					gamecore.prompt:show(var_0_2:getNowLang("shipnotget"))
					self:leave_ship()
					var_3_1._control.main.close.gameObject:SetActive(true)

					local var_5_3 = var_0_1:getInstance("voucher_shop")
					local var_5_4 = var_0_1:getInstance("mall_shop")

					if var_5_3 and var_5_4 then
						var_5_3:setVisible(true)
						var_5_4:setVisible(false)
					end

					return
				end

				local var_5_5 = var_0_1:createInstance("change_skin_panel")

				var_5_5:show(self._skin_data, var_5_2)

				local var_5_6 = var_5_5._panel:GetComponent("Canvas")

				var_5_6.sortingOrder = var_5_6.sortingOrder + 200

				var_3_1._control.main.close.gameObject:SetActive(true)

				local var_5_7 = var_0_1:getInstance("voucher_shop")
				local var_5_8 = var_0_1:getInstance("mall_shop")

				if var_5_7 and var_5_8 then
					var_5_7:setVisible(true)
					var_5_8:setVisible(false)
				end
			end, function()
				self:leave_ship()
				var_3_1._control.main.close.gameObject:SetActive(true)

				local var_7_0 = var_0_1:getInstance("voucher_shop")
				local var_7_1 = var_0_1:getInstance("mall_shop")

				if var_7_0 and var_7_1 then
					var_7_0:setVisible(true)
					var_7_1:setVisible(false)
				end
			end, var_0_2:getNowLang("replace_desc"), var_0_3.msg_type.tip)

			return
		end

		if (self._enter_type == var_0_3.enter_get_ship_type.remake or self._enter_type == var_0_3.enter_get_ship_type.spoils_shop) and self._data.skills and self._data.skills and #self._data.skills >= 2 then
			local var_3_3 = var_0_1:getInstance("home")

			self:__show_select_skill()

			return
		end

		if self._enter_type == var_0_3.enter_get_ship_type.abyss_evo_panel then
			self:__check_abyss_new_ship()

			return
		end

		if self._enter_type == var_0_3.enter_get_ship_type.remake then
			self:__show_select_skill()

			local var_3_4 = var_0_1:getInstance("home")

			if var_3_4 then
				var_3_4:into_home_bgm()
			end

			return
		elseif self._enter_type == var_0_3.enter_get_ship_type.dock_building then
			var_0_5:set_new_battle_type(nil)
			self:_is_lock()

			return
		elseif self._enter_type == var_0_3.enter_get_ship_type.abyss_get_awards then
			self:__check_new_ship()

			return
		end

		if self._is_new_ship and self._enter_type ~= var_0_3.enter_get_ship_type.abyss_combine_panel then
			if var_0_1:getInstance("mail") then
				self:__set_guide_data()

				if self._data_length == 1 and not self._is_new_ship then
					self:leave_ship()

					return
				end

				if self._data_length == 1 and self._is_new_ship then
					self:leave_ship()

					return
				end
			end

			if var_0_1:getInstance("task") then
				self:__set_guide_data()

				self._is_click_num = self._is_click_num + 1

				if self._is_click_num == self._data_length then
					self:leave_ship()
				end

				local var_3_5

				do
					self:__show_next_sopit()

					var_3_5 = var_0_1:getInstance("strike_awardbox")
				end
			end

			if not var_0_1:getInstance("dock") then
				self:__set_guide_data()

				if self._is_click_num == self._data_length and not var_3_5 then
					if self._is_first_equal then
						self._is_first_equal = false

						self:__show_next()
					else
						self:leave_ship()
					end
				elseif var_3_5 and self._data_length == 1 then
					self:leave_ship()
				elseif var_3_5 and self._data_length == 2 and self._is_click_num == self._data_length then
					self:leave_ship()
				else
					self:__show_next()
				end
			elseif var_0_5:get_ship_lock_state(self._data.id) == false then
				local var_3_6 = var_0_1:createInstance("msgbox")

				var_3_6._control.main.close.gameObject:SetActive(false)
				var_3_6:show(var_0_2:getNowLang("shiplockbody"), function()
					self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

					self._is_lock_by_msgbox = true

					var_0_5:req_ShipLock({
						id = self._new_ship_id
					})
					self:__set_guide_data()

					if self._data_length == 1 and not self._is_new_ship then
						self:leave_ship()

						return
					end

					if self._data_length == 1 and self._is_new_ship then
						self:leave_ship()

						return
					end

					var_3_6._control.main.close.gameObject:SetActive(true)
				end, function()
					self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
					self:__set_guide_data()

					if var_0_1:getInstance("mail") and var_0_5:get_get_all_mail_state() then
						var_0_5:__show_special_ship_detail()

						return
					end

					if self._data_length == 1 then
						self:leave_ship()

						return
					else
						self:__show_next()
					end

					if self._is_click_num == self._data_length then
						if self._is_first_equal then
							self._is_first_equal = false
						else
							self:leave_ship()
						end
					end

					var_3_6._control.main.close.gameObject:SetActive(true)
				end, var_0_2:getNowLang("shiplocktitle"), var_0_3.msg_type.tip)
			elseif self._is_click_num == self._data_length then
				if self._is_first_equal then
					self._is_first_equal = false

					self:__show_next()
				else
					self:leave_ship()
				end
			else
				self:__show_next()
			end

			return
		elseif self._is_new_equipment and self._enter_type ~= var_0_3.enter_get_ship_type.abyss_combine_panel then
			if var_0_1:getInstance("mail") or self._enter_type == var_0_3.enter_get_ship_type.sign_and_task then
				self:__set_guide_data()

				if self._is_click_num == self._data_length then
					if self._is_first_equal then
						self._is_first_equal = false
					else
						self:leave_ship()
					end
				elseif not self._data_length then
					self:leave_ship()
				end

				if self._enter_type == var_0_3.enter_get_ship_type.sign_and_task and self._back_func then
					self._back_func()
				end

				self:__show_next()
			end

			if not var_0_1:getInstance("dock") then
				if self._is_click_num == self._data_length then
					if self._is_first_equal then
						self._is_first_equal = false

						self:__show_next()
					else
						self:leave_ship()
					end
				else
					self:__show_next()
				end

				return
			elseif self._control.new_equip.lock_toggle.lock_state.gameObject.activeSelf == false then
				local var_3_7 = var_0_1:createInstance("msgbox")

				var_3_7._control.main.close.gameObject:SetActive(false)
				var_3_7:show(var_0_2:getNowLang("equipment_lock"), function()
					self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

					self._is_lock_by_msgbox = true

					var_0_5:req_EquipLock({
						id = self._equipment_id
					})
					var_0_4:show(var_0_2:getNowLang("equipment_lock_desc"))

					self._last_same_equipment_lock.id = self._equipment_id
					self._last_same_equipment_lock.lock = true

					self:__set_guide_data()

					if self._is_click_num == self._data_length then
						if self._is_first_equal then
							self._is_first_equal = false
						else
							self:leave_ship()
						end
					elseif not self._data_length then
						self:leave_ship()
					end

					if self._enter_type == var_0_3.enter_get_ship_type.sign_and_task and self._back_func then
						self._back_func()
					end

					self:__show_next()
					var_3_7._control.main.close.gameObject:SetActive(true)
				end, function()
					self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
					self:__set_guide_data()

					if var_0_1:getInstance("mail") and var_0_5:get_get_all_mail_state() then
						var_0_5:__show_special_equip_info_detail()

						return
					end

					if self._is_click_num == self._data_length then
						if self._is_first_equal then
							self._is_first_equal = false
						else
							self:leave_ship()
						end
					elseif not self._data_length then
						self:leave_ship()
					end

					if self._enter_type == var_0_3.enter_get_ship_type.sign_and_task and self._back_func then
						self._back_func()
					end

					self:__show_next()
					var_3_7._control.main.close.gameObject:SetActive(true)
				end, var_0_2:getNowLang("equipment_lock_title"), var_0_3.msg_type.tip)
			elseif self._is_click_num == self._data_length then
				if self._is_first_equal then
					self._is_first_equal = false

					self:__show_next()
				else
					self:leave_ship()
				end
			else
				self:__show_next()
			end

			return
		else
			self:__show_next()

			if self._is_click_num == self._data_length then
				if self._is_first_equal then
					self._is_first_equal = false
				else
					self:leave_ship()
				end
			elseif not self._data_length then
				self:leave_ship()
			end
		end

		if self._enter_type == var_0_3.enter_get_ship_type.mall_shop then
			local var_3_8 = var_0_1:getInstance("ship_detail")

			if var_3_8 then
				var_3_8:reset_current_panel(true)
			end
		end

		if (self._now_battle_type ~= gameenum.battle_type.fight_type.abyss or self._enter_type ~= var_0_3.enter_get_ship_type.salvage_award) and not var_0_1:getInstance("task") then
			(function()
				if self._back_func then
					self._back_func()
				end
			end)()
		end

		if not self._skin_data then
			local var_3_9 = var_0_1:getInstance("new_ship_or_equip")

			return
		end

		local var_3_10 = var_0_11.find_object_by_cid(self._skin_data.cid)

		if not var_3_10 then
			return
		end

		if var_3_10.bgm == 0 then
			return
		end

		var_0_1:createInstance("reward_tip"):show_get_music(var_3_10.bgm)
	end

	function arg_1_0:_is_lock()
		if self._is_new_ship then
			if var_0_5:get_ship_lock_state(self._data.id) == false then
				if not var_0_1:getInstance("dock") then
					self:__set_guide_data()

					return
				end

				self:_play_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.get_item))

				local var_12_1 = var_0_1:createInstance("msgbox")

				var_12_1._control.main.close.gameObject:SetActive(false)
				var_12_1:show(var_0_2:getNowLang("shiplockbody"), function()
					self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

					self._is_lock_by_msgbox = true

					var_0_5:req_ShipLock({
						id = self._new_ship_id
					})
				end, function()
					self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
					self:__set_guide_data()

					if self._data_length == 1 then
						self:leave_ship()

						return
					end

					var_0_7:resumeAll()

					if self._is_click_num == self._data_length then
						if self._is_first_equal then
							self._is_first_equal = false
						else
							self:leave_ship()
						end
					end

					self:__show_next()

					if self._is_click_num == self._data_length then
						if self._is_first_equal then
							self._is_first_equal = false
						else
							self:leave_ship()
						end
					end

					var_12_1._control.main.close.gameObject:SetActive(true)
				end, var_0_2:getNowLang("shiplocktitle"), var_0_3.msg_type.tip)
			else
				self:__show_next()

				if self._is_click_num == self._data_length then
					if self._is_first_equal then
						self._is_first_equal = false
					else
						self:leave_ship()
					end
				end
			end
		else
			if self._data_length == 1 then
				self:leave_ship(function()
					self:__set_guide_data()
				end)

				return
			end

			self:__show_next()

			if self._is_click_num == self._data_length then
				if self._is_first_equal then
					self._is_first_equal = false
				else
					self:leave_ship()
				end
			end
		end
	end

	function arg_1_0:__onClick_new_ship_switch_layer_confirm_btn()
		local var_17_0 = {
			id = self._data.id,
			skill_id = self._select_skill
		}

		var_0_5:set_save_remake_skill(var_17_0)
		var_0_5:req_ShipChangeSkill(var_17_0)

		local var_17_1 = var_0_1:getInstance("home")

		if var_17_1 then
			var_17_1:into_home_bgm()
		end
	end

	function arg_1_0:__onToggle_new_ship_switch_layer_toggle_group_tog_rs_1()
		self._select_skill = self._data.skills[1]
	end

	function arg_1_0:__onToggle_new_ship_switch_layer_toggle_group_tog_rs_2()
		self._select_skill = self._data.skills[2]
	end

	function arg_1_0:__onToggle_all_do_new_equip_lock_toggle()
		if self._is_first_equip_toggle then
			self._is_first_equip_toggle = false

			return
		end

		var_0_5:req_EquipLock({
			id = self._equipment_id
		})

		if not self._control.new_equip.lock_toggle.toggle.isOn then
			self._last_same_equipment_lock.id = self._equipment_id
			self._last_same_equipment_lock.lock = false

			var_0_4:show(var_0_2:getNowLang("equipment_not_lock_desc"))
		else
			self._last_same_equipment_lock.id = self._equipment_id
			self._last_same_equipment_lock.lock = true

			var_0_4:show(var_0_2:getNowLang("equipment_lock_desc"))
		end
	end

	function arg_1_0:__onClick_new_equip_lock_toggle_lock_state()
		var_0_5:req_EquipLock({
			id = self._equipment_id
		})

		self._last_same_equipment_lock.id = self._equipment_id
		self._last_same_equipment_lock.lock = false

		var_0_4:show(var_0_2:getNowLang("equipment_not_lock_desc"))
		self._control.new_equip.lock_toggle.lock_state:SetActive(false)
		self._control.new_equip.lock_toggle.unlocklock_state:SetActive(true)
	end

	function arg_1_0:__onClick_new_equip_lock_toggle_unlocklock_state()
		var_0_5:req_EquipLock({
			id = self._equipment_id
		})

		self._last_same_equipment_lock.id = self._equipment_id
		self._last_same_equipment_lock.lock = true

		var_0_4:show(var_0_2:getNowLang("equipment_lock_desc"))
		self._control.new_equip.lock_toggle.lock_state:SetActive(true)
		self._control.new_equip.lock_toggle.unlocklock_state:SetActive(false)
	end

	function arg_1_0:__onClick_new_ship_lock_toggle_lock_state()
		var_0_5:req_ShipLock({
			id = self._data.id
		})
		self._control.lock_toggle.lock_state:SetActive(false)
		self._control.lock_toggle.unlocklock_state:SetActive(true)
	end

	function arg_1_0:__onClick_new_ship_lock_toggle_unlocklock_state()
		var_0_5:req_ShipLock({
			id = self._data.id
		})
		self._control.lock_toggle.lock_state:SetActive(true)
		self._control.lock_toggle.unlocklock_state:SetActive(false)
	end

	function arg_1_0:__onClick_new_ship_lock_toggle_ship_detail_btn()
		self:setVisible(false)

		local var_25_0 = var_0_1:createInstance("ship_detail")

		if self._enter_type == var_0_3.enter_get_ship_type.mail_ship_award then
			var_25_0:show(var_0_3.enter_ship_detail_type.mail_ship_award, self._ship_data)
		else
			var_25_0:show(var_0_3.enter_ship_detail_type.new_ship, self._ship_data)
		end
	end

	function arg_1_0:__onClick_lock_toggle_lock_state()
		var_0_5:req_ShipLock({
			id = self._data.id
		})
		self._control.lock_toggle.lock_state:SetActive(false)
		self._control.lock_toggle.unlocklock_state:SetActive(true)
	end

	function arg_1_0:__onClick_lock_toggle_unlocklock_state()
		var_0_5:req_ShipLock({
			id = self._data.id
		})
		self._control.lock_toggle.lock_state:SetActive(true)
		self._control.lock_toggle.unlocklock_state:SetActive(false)
	end

	function arg_1_0:__onClick_lock_toggle_ship_detail_btn()
		self:setVisible(false)

		local var_28_0 = var_0_1:createInstance("ship_detail")

		if self._enter_type == var_0_3.enter_get_ship_type.mail_ship_award then
			var_28_0:show(var_0_3.enter_ship_detail_type.mail_ship_award, self._ship_data)
		else
			var_28_0:show(var_0_3.enter_ship_detail_type.new_ship, self._ship_data)
		end
	end

	function arg_1_0:__set_guide_data()
		if (self._enter_type == var_0_3.enter_get_ship_type.sign_and_task or self._enter_type == var_0_3.enter_get_ship_type.other or self._enter_type == var_0_3.enter_get_ship_type.dock_building) and var_0_5:get_guide_state() then
			local var_29_0 = var_0_1:getInstance("guide_panel")

			if var_29_0:get_next_step() ~= var_0_3.guide_const_id.ten_group.zero then
				var_29_0:reset_guide_panel()
			end
		end
	end
end

function var_0_0.extend_obj(arg_30_0)
	return
end

return var_0_0
