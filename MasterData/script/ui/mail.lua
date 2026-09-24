local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.Language
local var_0_5 = string.format
local var_0_6 = UnityEngine.Vector2
local var_0_7 = DG.Tweening.DOTween
local var_0_8 = gamecore.util_func
local var_0_10 = gameenum.common_type
local var_0_11 = gamecore.prompt
local var_0_12 = lx.clone_table

gamecore.UILoader:define("mail", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
		self:__init_mask_move()
		self:__set_mail_panel_position()
		var_0_1:set_get_all_mail_state(false)

		is_enter_mail = true
	end

	function arg_1_0:update_mail_data_by_sever()
		self:__get_mail_data_by_sever()

		if self._already_init then
			self:__update_cell()
		end
	end

	function arg_1_0:__onUpdate()
		if not self._sever_data then
			return
		end

		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:get_curr_select_mail_award()
		return self._curr_select_mail_data
	end

	function arg_1_0.set_curr_select_mail_info(arg_6_0, arg_6_1)
		arg_6_0._curr_select_mail_data = arg_6_1
	end

	function arg_1_0.destroy_panel(arg_7_0)
		var_0_3:destroyInstance("reward_tip")
		var_0_3:destroyInstance("new_ship_or_equip")
		var_0_3:destroyInstance("mail")
		var_0_3:destroyInstance("mail_box")
	end

	function arg_1_0:__init_panel()
		if not self._already_init then
			self._control.main.mailui.text.text = var_0_4:getNowLang("mailui")
			self._control.main.lock_mail.lock_mail_txt.text.text = var_0_4:getNowLang("mail_lock")
			self._control.main.sbtn_delet_all.Text.text.text = var_0_4:getNowLang("ui_deleteall")
			self._control.main.sbtn_read_all.Text.text.text = var_0_4:getNowLang("ui_getall")

			self._control.main.sbtn_delet_all:SetActive(true)
			self._control.main.sbtn_read_all:SetActive(true)
			var_0_8.setTextHorizonInfo(self._control.main.mail_info_notic_mask, var_0_4:getNowLang("mailinfonotice"))

			if var_0_8.check_channel_is_en() then
				self._control.main.sbtn_delet_all.Text.text.fontSize = 27
				self._control.main.sbtn_read_all.Text.text.fontSize = 27
			end

			self:show_curr_mail_amount(0)
			self:__init_mail_list()

			self._already_init = true
			self._is_lock_state = false
		end

		self:_play_into_se(var_0_10:get_audio_url(var_0_10.common_icon.music_path, var_0_10.open))
		self:__get_mail_data_by_sever()
		self:__update_cell()
		var_0_10:play_in_out_animation(self._control.show_on_tween.uITweenSequence, true)
	end

	function arg_1_0:__get_mail_data_by_sever()
		self._sever_data = var_0_1:get_mail_data()

		if self._is_lock_state then
			self:set_mail_info()
		end
	end

	function arg_1_0:__init_mail_list()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.main.mail_scroll_view.mail_scroll_rect.viewport.edge_mask.content.endlessScrollView, self._control.main.mail_scroll_view.mail_scroll_rect.viewport.edge_mask.content, "mail_item", "mail")

		self._reusable_cell:init()
	end

	function arg_1_0:__update_cell()
		local var_11_0 = var_0_12(self._sever_data)

		self:__set_scrollbar_state()

		if not var_11_0 then
			return
		end

		if self._is_lock_state then
			local var_11_1 = 0

			for iter_11_0, iter_11_1 in pairs(var_11_0) do
				if iter_11_1.lock then
					var_11_1 = var_11_1 + 1
				end
			end

			self._lock_mail_num = var_11_1

			self:show_lock_mail_amount(var_11_1)
		else
			self:show_curr_mail_amount(#var_11_0)
		end

		for iter_11_2, iter_11_3 in pairs(var_11_0) do
			if iter_11_3.item then
				for iter_11_4, iter_11_5 in pairs(iter_11_3.item) do
					local var_11_2, var_11_3 = var_0_10:get_image_path_by_type(iter_11_5.id, iter_11_5.type, iter_11_5.count, false)

					if not var_11_2 then
						table.remove(iter_11_3.item, iter_11_4)
					end
				end
			end
		end

		table.sort(var_11_0, function(arg_12_0, arg_12_1)
			return arg_12_0.send_time > arg_12_1.send_time
		end)
		self._reusable_cell:set_data(var_11_0)

		function self._reusable_cell:_set_func(arg_13_1)
			self.tilte.text.text = var_11_0[arg_13_1 + 1].title
			self.date.text.text = var_0_8._get_receive_time(var_11_0[arg_13_1 + 1].send_time)

			local var_13_0 = var_11_0[arg_13_1 + 1].get

			if var_11_0[arg_13_1 + 1].lock and not var_13_0 then
				self.bar_status.image.sprite = self:loadSprite(var_0_10.mail_lock_open_bg)
				self.get_reward.blue_angle.image.sprite = self:loadSprite(var_0_10.mail_lock)
			elseif var_11_0[arg_13_1 + 1].lock and var_13_0 then
				self.bar_status.image.sprite = self:loadSprite(var_0_10.mail_lock_close_bg)
				self.get_reward.blue_angle.image.sprite = self:loadSprite(var_0_10.mail_lock)
			elseif not var_11_0[arg_13_1 + 1].lock and var_13_0 then
				self.bar_status.image.sprite = self:loadSprite(var_0_10.mail_close_bg)
				self.get_reward.blue_angle.image.sprite = self:loadSprite(var_0_10.mail_unlock)
			end

			self.bar_status.image.sprite = self:loadSprite(var_0_10.mail_open_bg)
			self.get_reward.blue_angle.image.sprite = self:loadSprite(var_0_10.mail_unlock)

			self:__update_mail_item_info(self, var_11_0[arg_13_1 + 1].item or {})
			self.blind_delete_btn_root.btn_blind:SetActive(false)

			local var_13_1 = self.get_reward
			local var_13_2 = self.get_reward_btn

			self.get_reward.yellow_angle:SetActive(false)

			self.get.text.text = var_0_4:getNowLang("ui_havegetattach")

			self.get:SetActive(var_13_0)
			self.item_content:SetActive(not var_13_0)

			if var_13_0 and not var_11_0[arg_13_1 + 1].lock then
				var_13_1.mail_attach_have:SetActive(var_13_0)
			elseif var_13_0 then
				var_13_1.mail_attach_have:SetActive(false)
				var_13_1.yellow_angle:SetActive(true)
			end

			var_13_1.blue_angle:SetActive(not var_13_0)

			local var_13_3 = self.blind_delete_btn_root.btn_delete

			self.blind_delete_btn_root.btn_delete.Text.text.text = var_0_4:getNowLang("ui_delete")

			if self._is_lock_state then
				var_13_3:SetActive(false)
			else
				var_13_3:SetActive(var_13_0)
			end

			var_13_2.button.onClick:RemoveAllListeners()
			var_13_2.button.onClick:AddListener(function()
				self:_play_into_se(var_0_10:get_audio_url(var_0_10.common_icon.music_path, var_0_10.open))

				if var_11_0[arg_13_1 + 1].item then
					self:set_curr_select_mail_info(var_11_0[arg_13_1 + 1].item)
				end

				if self._is_lock_state then
					self:_play_into_se(var_0_10:get_audio_url(var_0_10.common_icon.music_path, var_0_10.open))

					if not var_11_0[arg_13_1 + 1].lock then
						if self._lock_mail_num >= 30 then
							var_0_11:show(var_0_4:getNowLang("ismax"))
						else
							var_0_1:req_LockMail(var_11_0[arg_13_1 + 1].id, 1)
						end
					else
						var_0_1:req_LockMail(var_11_0[arg_13_1 + 1].id, 0)
					end
				else
					self:_play_into_se(var_0_10:get_audio_url(var_0_10.common_icon.music_path, var_0_10.open))

					if not var_11_0[arg_13_1 + 1].lock and not var_13_0 then
						var_0_1:req_GetMail(var_11_0[arg_13_1 + 1])
					elseif var_11_0[arg_13_1 + 1].lock and not var_13_0 then
						var_0_3:createInstance("msgbox"):show(var_0_4:getNowLang("mail_get_desc"), function()
							var_0_1:req_GetMail(var_11_0[arg_13_1 + 1])
						end, function()
							self:_play_into_se(var_0_10:get_audio_url(var_0_10.common_icon.music_path, var_0_10.back))
						end, var_0_4:getNowLang("mail_get"), var_0_10.msg_type.tip)
					end
				end
			end)
			var_13_3.button.onClick:RemoveAllListeners()
			var_13_3.button.onClick:AddListener(function()
				if self._is_lock_state then
					var_0_3:createInstance("msgbox"):show(var_0_4:getNowLang("mail_delate_desc"), function()
						self:_play_into_se(var_0_10:get_audio_url(var_0_10.common_icon.music_path, var_0_10.open))

						if not var_11_0[arg_13_1 + 1].lock then
							if self._lock_mail_num >= 30 then
								var_0_11:show(var_0_4:getNowLang("ismax"))
							else
								var_0_1:req_LockMail(var_11_0[arg_13_1 + 1].id, 1)
							end
						else
							var_0_1:req_LockMail(var_11_0[arg_13_1 + 1].id, 0)
						end
					end, function()
						self:_play_into_se(var_0_10:get_audio_url(var_0_10.common_icon.music_path, var_0_10.back))
					end, var_0_4:getNowLang("mail_delete"), var_0_10.msg_type.tip)
				elseif not var_11_0[arg_13_1 + 1].lock then
					var_0_1:req_DeleteMail(var_11_0[arg_13_1 + 1])
				else
					var_0_3:createInstance("msgbox"):show(var_0_4:getNowLang("mail_delate_desc"), function()
						var_0_1:req_DeleteMail(var_11_0[arg_13_1 + 1])
					end, function()
						self:_play_into_se(var_0_10:get_audio_url(var_0_10.common_icon.music_path, var_0_10.back))
					end, var_0_4:getNowLang("mail_delete"), var_0_10.msg_type.tip)
				end
			end)
		end
	end

	function arg_1_0:set_mail_info()
		if self._is_lock_state then
			self._control.main.mailui.text.text = var_0_4:getNowLang("mail_lock")

			var_0_8.setTextHorizonInfo(self._control.main.mail_info_notic_mask, var_0_4:getNowLang("mail_lock_desc"))
			self._control.main.sbtn_delet_all:SetActive(false)
			self._control.main.sbtn_read_all:SetActive(false)

			local var_22_0 = 0

			for iter_22_0, iter_22_1 in pairs((var_0_12(self._sever_data))) do
				if iter_22_1.lock then
					var_22_0 = var_22_0 + 1
				end
			end

			self._lock_mail_num = var_22_0

			self:show_lock_mail_amount(var_22_0)
		else
			self._control.main.mailui.text.text = var_0_4:getNowLang("mailui")

			var_0_8.setTextHorizonInfo(self._control.main.mail_info_notic_mask, var_0_4:getNowLang("mailinfonotice"))
			self._control.main.sbtn_delet_all:SetActive(true)
			self._control.main.sbtn_read_all:SetActive(true)
			self:show_curr_mail_amount(#var_0_12(self._sever_data))
		end
	end

	function arg_1_0:__update_mail_item_info(arg_23_1, arg_23_2)
		self:__reset_mail_item_state(arg_23_1)

		for iter_23_0, iter_23_1 in pairs(arg_23_2) do
			if iter_23_0 <= var_0_10.mail_const.mail_show_props_max_num then
				local var_23_0, var_23_1 = self:loadUIPrefab("mail_res_item", arg_23_1.item_content.transform)

				var_23_0:setVisible(true)

				var_23_0._panel.transform.localScale = Vector3.one

				local var_23_2, var_23_3 = var_0_10:get_image_path_by_type(iter_23_1.id, iter_23_1.type, iter_23_1.count, false)
				local var_23_4 = self:loadSprite(var_23_2)

				var_23_1.get_icon.image.sprite = var_23_4 == nil and self:loadSprite((var_0_5(var_0_10.mail_icon, "11242"))) or var_23_4

				var_23_1.get_icon.image:SetNativeSize()

				local var_23_5 = var_23_1.item_name:GetComponent(typeof(TextScroller))

				if iter_23_1.id > 10000 and iter_23_1.id < 20000 then
					if var_23_3 then
						var_23_5:SetText(var_23_3 .. "x" .. iter_23_1.count)
					end
				elseif var_23_3 then
					var_23_5:SetText(var_23_3)
				end

				var_23_5.deltaLength = var_0_10.mail_const.text_interval
				var_23_5.scrollSpeed = var_0_10.mail_const.text_move_speed
			end
		end
	end

	function arg_1_0:__init_mask_move()
		self._control.main.mask.glow.rectTransform.anchoredPosition = var_0_6(var_0_10.mail_const.shadow_position.x, var_0_10.mail_const.shadow_position.y)
		self._mail_seq = self:autoKillDOTween(var_0_7.Sequence())

		self._mail_seq:Append(self._control.main.mask.glow.transform:DOLocalMove(Vector3.New(var_0_10.mail_const.shadow_target_pos.x, var_0_10.mail_const.shadow_target_pos.y, 0), 5):SetEase(DG.Tweening.Ease.Linear))
		self._mail_seq:SetLoops(-1)
		self._mail_seq:Play()
	end

	function arg_1_0:__reset_mail_item_state(arg_25_1)
		for iter_25_0 = 1, arg_25_1.item_content.transform.childCount do
			self:destroyGameObject(arg_25_1.item_content.transform:GetChild(iter_25_0 - 1).gameObject)
		end
	end

	function arg_1_0:__set_mail_panel_position()
		self._control.main.mail_scroll_view.mail_scroll_rect.viewport.edge_mask.content.rectTransform.anchoredPosition = var_0_6(0, 0)
	end

	function arg_1_0:_play_into_se(arg_27_1)
		self:playSE(arg_27_1, false)
	end

	function arg_1_0:__set_scrollbar_state()
		local var_28_0 = self._control.main.mail_scroll_view.mail_scroll_rect

		if #self._sever_data == 0 then
			var_28_0.viewport.Scrollbar.sliding_area:SetActive(true)
			self._control.main.mask_bg:SetActive(true)
		else
			self._control.main.mask_bg:SetActive(false)
			var_28_0.viewport.Scrollbar.sliding_area:SetActive(#self._sever_data >= var_0_10.mail_const.scrollbar_area)
		end
	end

	function arg_1_0:show_curr_mail_amount(arg_29_1)
		if arg_29_1 > var_0_10.mail_const.mail_max_num then
			arg_29_1 = var_0_10.mail_const.mail_max_num
		end

		self._control.main.mail_num_text.text.text = var_0_5("%s / %s", arg_29_1, var_0_10.mail_const.mail_max_num)
	end

	function arg_1_0:show_lock_mail_amount(arg_30_1)
		if arg_30_1 >= 30 then
			arg_30_1 = 30
		end

		self._control.main.mail_num_text.text.text = var_0_4:getNowLang("mail_lock_max") .. var_0_5("%s / %s", arg_30_1, var_0_10.mail_const.mail_lock_max_num)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_31_0)
	local var_31_0 = var_0_3:class("mail")

	var_31_0._already_init = false
	var_31_0._reusable_cell = nil
	var_31_0._mail_seq = nil
	var_31_0._curr_select_mail_data = {}
	var_31_0._sever_data = {}
	var_31_0._is_lock_state = false
	var_31_0._lock_mail_num = 0

	return var_31_0
end

return var_0_0
