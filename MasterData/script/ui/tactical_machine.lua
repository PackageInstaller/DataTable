local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.tower_buff_stone_config
local var_0_6 = string.format
local var_0_7 = gamecore.util_func
local var_0_8 = UnityEngine.Vector2
local var_0_9 = DG.Tweening.DOTween
local var_0_10 = {}
local var_0_11
local var_0_12 = {}
local var_0_13 = {}
local var_0_14 = string.gsub
local var_0_15 = string.sub

gamecore.UILoader:define("tactical_machine", function(arg_1_0)
	function arg_1_0:__close_panel()
		local var_2_0 = var_0_2:getInstance("buffmap")

		if var_2_0 then
			var_2_0:show()
		else
			local var_2_1 = var_0_2:getInstance("analysis_room")

			if not var_2_1 then
				var_2_1 = var_0_2:createInstance("analysis_room")

				var_2_1:show()
			end

			var_2_1:__set_return_btn_active(true)
		end

		self:__play_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
		self:__do_position(false)
	end

	function arg_1_0:__close_to_buffmap()
		local var_3_0 = var_0_2:getInstance("buffmap")

		if var_3_0 then
			var_3_0:show()
		end

		self._is_from_buff_map = false

		self:__new_buff_animation(false)
		self:__do_position(false)
		self:__set_analysis_return_active(true)
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show(arg_5_1)
		self:setVisible(true)
		self:__init_language()
		self:__init_panel(arg_5_1)
	end

	function arg_1_0:__reset_animations()
		self:__kill_animations()

		self._control.buff_list.transform.localPosition = var_0_8.New(387.5, 0)
	end

	function arg_1_0:__kill_animations()
		if self._buff_list_seq then
			self._buff_list_seq:Kill()

			self._buff_list_seq = nil
		end
	end

	function arg_1_0:__do_position(arg_8_1)
		self:__kill_animations()

		self._buff_list_seq = self:autoKillDOTween(var_0_9.Sequence())

		local var_8_0 = self._panel.transform:GetComponent("CanvasGroup")

		if arg_8_1 then
			self._control.return_btn:SetActive(false)

			self._control.buff_list.transform.localPosition = var_0_8.New(1342, 0)
			var_8_0.blocksRaycasts = false

			self._buff_list_seq:Append(self._control.buff_list.transform:DOLocalMoveX(387.5, 0.2))
			self._buff_list_seq:AppendCallback(function()
				var_8_0.blocksRaycasts = true

				self._control.return_btn:SetActive(true)
			end)
			self._buff_list_seq:Play()
		else
			self._control.return_btn:SetActive(false)
			self._buff_list_seq:Append(self._control.buff_list.transform:DOLocalMoveX(1342, 0.2))
			self._buff_list_seq:AppendCallback(function()
				var_0_2:destroyInstance("tactical_machine")
			end)
			self._buff_list_seq:Play()
		end

		local var_8_1 = var_0_2:getInstance("analysis_room")

		if var_8_1 then
			var_8_1:set_panel_clickable(not arg_8_1 and true)
		end
	end

	function arg_1_0:__init_panel(arg_11_1)
		self._control.msg_box:SetActive(false)

		var_0_11 = nil

		local var_11_0 = false
		local var_11_1 = var_0_3:get_tower_chip_info()

		if arg_11_1 and arg_11_1.is_new or arg_11_1 and arg_11_1.is_buff_map then
			self:__set_left_info(arg_11_1.id)

			var_11_0 = true
		elseif var_11_1.new and var_11_1.new ~= 0 then
			self:__set_left_info(var_11_1.new)

			self._new_card_id = var_11_1.new
			var_11_0 = true
		else
			self._new_card_id = nil
		end

		self._control.buff_trans:SetActive(var_11_0)

		if not self._is_already_init then
			self:__init_buff_list()
		end

		self:set_btn_info(arg_11_1)
		self:__init_buff_storage(var_11_1.transient)
		self:__check_if_show_temp_btn()
		self:__set_analysis_return_active(false)
	end

	function arg_1_0:__init_language()
		self._control.buff_trans.new_icon.new_text.text.text = var_0_1:getNowLang("ui_rewardtitle")
	end

	function arg_1_0:__new_buff_animation(arg_13_1)
		if arg_13_1 then
			self:__play_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

			self._control.buff_trans.transform.localPosition = var_0_8.New(-1028, 0)

			self._control.buff_trans.transform:DOLocalMoveX(-416.77, 0.15)
		else
			self:__play_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
			self._control.buff_trans.transform:DOLocalMoveX(-416.77, 0.15)
		end
	end

	function arg_1_0:__init_buff_storage(arg_14_1)
		if arg_14_1 == nil then
			arg_14_1 = var_0_3:get_tower_chip_info().transient
		end

		var_0_10[1] = nil
		var_0_10[2] = nil

		for iter_14_0 = 1, 2 do
			var_0_10[iter_14_0] = var_0_4.card_status.card_none_new
			var_0_13[iter_14_0] = 0
		end

		var_0_11 = nil
		var_0_12[1] = self._control.buff_list.buff_storage.tower_buff_storage0
		var_0_12[2] = self._control.buff_list.buff_storage.tower_buff_storage1

		for iter_14_1 = 1, 2 do
			if arg_14_1[iter_14_1] then
				self:__set_temp_buff_info(iter_14_1, arg_14_1[iter_14_1])
			else
				self:__set_temp_buff_info(iter_14_1, 0)
			end
		end

		self._is_already_init = true

		self:__update_buff_storage_btnstate()
	end

	function arg_1_0:set_btn_info(arg_15_1)
		self._is_from_buff_map = not not (arg_15_1 and arg_15_1.is_buff_map)

		local var_15_0 = not not (self._new_card_id and self._new_card_id ~= 0)

		self._control.return_btn:SetActive(not var_15_0)

		self._equ_pos = nil
		self._card_status = nil

		local var_15_1 = var_0_3:get_tower_chip_info()

		self._coin = var_15_1.coin

		if var_15_0 or var_0_11 and var_15_1.transient[var_0_11] ~= 0 then
			local var_15_2

			if var_15_0 then
				self._control.buff_trans.giveup_btn:SetActive(var_15_0)

				var_15_2 = var_0_5.find_object_by_id(self._new_card_id)

				self:__set_buff_select_mask()
			else
				var_15_2 = var_0_5.find_object_by_id(var_15_1.transient[var_0_11])
			end

			local var_15_3 = lx.clone_table(var_15_1.slot)

			for iter_15_0, iter_15_1 in ipairs(var_15_1.transient) do
				table.insert(var_15_3, iter_15_1)
			end

			for iter_15_2, iter_15_3 in ipairs(var_15_3) do
				local var_15_4 = var_0_5.find_object_by_id(iter_15_3)

				if var_15_4 and var_15_2 then
					if var_15_4.base_id ~= 0 and var_15_4.base_id == var_15_2.base_id then
						if var_15_2.quality > var_15_4.quality then
							self._card_status = var_0_4.card_status.card_replace
							self._only_exchange_base_id = var_15_2.base_id
							self._equ_pos = iter_15_2

							break
						else
							self._card_status = var_0_4.card_status.card_give_up
							self._only_exchange_base_id = nil

							break
						end
					end
				else
					self._equ_pos = self._equ_pos or iter_15_2
					self._card_status = var_0_4.card_status.card_equips
				end
			end

			self._card_status = self._card_status or var_0_4.card_status.card_all_replace
		else
			for iter_15_4, iter_15_5 in ipairs(var_15_1.slot) do
				if iter_15_5 == 0 then
					self._card_status = var_0_4.card_status.card_none_new
				end
			end
		end

		if self._is_from_buff_map then
			self._control.buff_trans.giveup_btn.giveup_text.text.text = var_0_1:getNowLang("cancel") or var_0_1:getNowLang("decompose")
		end

		self:__update_reusable_cell()
	end

	function arg_1_0:__check_if_show_temp_btn()
		if self._card_status == var_0_4.card_status.card_replace then
			local var_16_0 = self._equ_pos - 5

			for iter_16_0, iter_16_1 in ipairs(var_0_12) do
				var_0_12[iter_16_0].buff_info_panel.replace_btn:SetActive(iter_16_0 == var_16_0)
				var_0_12[iter_16_0].extract_buff_btn:SetActive(false)
			end
		end
	end

	function arg_1_0:__init_buff_list()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.buff_list.all_buff.Viewport.edge_mask.Content.endlessScrollView, self._control.buff_list.all_buff.Viewport.edge_mask.Content, "machine_buff", "tactical_machine", true)

		self._reusable_cell:init()
	end

	function arg_1_0.__set_analysis_return_active(arg_18_0, arg_18_1)
		local var_18_0 = var_0_2:getInstance("analysis_room")

		if var_18_0 then
			var_18_0:__set_return_btn_active(arg_18_1)
		end
	end

	function arg_1_0:__update_reusable_cell()
		local var_19_0 = var_0_3:get_tower_chip_info()

		self._reusable_cell:set_data(var_19_0.slot)

		function self._reusable_cell:_set_func(arg_20_1)
			self:show(var_19_0.slot[arg_20_1 + 1], arg_20_1, self._card_status, var_0_11, self._control.buff_trans.activeSelf, self._only_exchange_base_id)
		end
	end

	function arg_1_0:buff_equip_click(arg_21_1, arg_21_2, arg_21_3)
		if self._new_card_id and self._new_card_id ~= 0 then
			if not arg_21_2 and not self._is_from_buff_map then
				var_0_3:req_TowerEquipChipReq(arg_21_1)
			else
				self:__msg_box_show("确认替换", {
					is_equip_replace = true,
					old_id = arg_21_3 or 0,
					aim_id = self._new_card_id,
					pos = arg_21_1
				}, true)
			end
		elseif var_0_11 then
			if not arg_21_2 then
				var_0_3:req_TowerTransientEquipReq(var_0_11, arg_21_1)
			else
				self:__msg_box_show("确认替换", {
					is_equip_replace = true,
					old_id = arg_21_3,
					aim_id = var_0_13[var_0_11],
					pos = arg_21_1
				}, false)
			end
		end
	end

	function arg_1_0.__get_quality_icon_id(arg_22_0, arg_22_1)
		if not arg_22_1 then
			return "1"
		end

		if arg_22_1 == 4 then
			return "2"
		end

		return "1"
	end

	function arg_1_0.use_other_color(arg_23_0, arg_23_1)
		local var_23_0 = "424242FF"
		local var_23_1 = "24a1f6FF"

		return (var_0_14(var_0_14(arg_23_1, "%^C[^%^]+", function(arg_24_0)
			local var_24_0 = var_0_15(arg_24_0, 3, 10)

			if var_24_0 and var_24_0 == "969799FF" then
				var_24_0 = var_23_0
			end

			if var_24_0 and var_24_0 == "57caffFF" then
				var_24_0 = var_23_1
			end

			return var_0_6("<color=#%s>%s</color>", var_24_0, (var_0_15(arg_24_0, 19, #arg_24_0)))
		end), "{%d}", "%%s"))
	end

	function arg_1_0:__set_left_info(arg_25_1, arg_25_2)
		if arg_25_1 and arg_25_1 ~= 0 then
			local var_25_0 = var_0_5.find_object_by_id(arg_25_1)

			if var_25_0 then
				self._control.buff_trans.buff_name.text.text = var_25_0.title
				self._control.buff_trans.buff_icon.image.sprite = self:loadSprite(var_0_6(var_0_4.tactical_buff_icon, var_25_0.icon))
				self._control.buff_trans.buff_bg.image.sprite = self:loadSprite(var_0_6(var_0_4.tactical_buff_icon, "bg_1_" .. self:__get_quality_icon_id(var_25_0.quality)))
				self._control.buff_trans.buff_info.text.text = self:use_other_color(var_25_0.desc2)

				self:__new_buff_animation(true)
			else
				print("没有找到对应的ID信息！：At ID: " .. arg_25_1)
			end
		else
			self:set_btn_info(false)
		end

		self._new_card_id = arg_25_1
	end

	function arg_1_0:__set_temp_buff_info(arg_26_1, arg_26_2)
		local var_26_0

		if arg_26_2 and arg_26_2 ~= 0 then
			var_26_0 = true
		end

		if not var_0_12[arg_26_1] then
			print("错误的暂存槽参数")
		else
			var_0_13[arg_26_1] = arg_26_2
		end

		local var_26_1

		if var_26_0 then
			var_26_1 = var_0_5.find_object_by_id(arg_26_2)
		end

		var_0_12[arg_26_1].extract_buff_btn:SetActive(not var_26_0)
		var_0_12[arg_26_1].buff_info_panel:SetActive(var_26_0)

		if var_26_1 then
			var_0_12[arg_26_1].buff_info_panel.buff_name.text.text = var_26_1.title
			var_0_12[arg_26_1].buff_info_panel.buff_icon.image.sprite = self:loadSprite(var_0_6(var_0_4.tactical_buff_icon, var_26_1.icon))
			var_0_12[arg_26_1].buff_info_panel.buff_info.text.text = var_0_7.convert_rich_text(var_26_1.desc1)
			var_0_12[arg_26_1].buff_info_panel.buff_icon_bg.image.sprite = self:loadSprite(var_0_6(var_0_4.tower_buff_optimize_icon, (self:__get_quality_icon_id(var_26_1.quality))))

			if not var_0_11 then
				self:__set_buff_select_mask(arg_26_1, var_26_0)
			end
		end

		self:__update_buff_storage_btnstate()
	end

	function arg_1_0:__set_buff_select_mask(arg_27_1, arg_27_2)
		if var_0_12[arg_27_1] and var_0_12[arg_27_1].buff_info_panel and (self._new_card_id == nil or self._new_card_id == 0) then
			local var_27_0 = var_0_3:get_tower_chip_info()

			if not var_27_0 or var_27_0.transient[arg_27_1] == 0 then
				return
			end

			var_0_12[arg_27_1].buff_info_panel.selected_halo:SetActive(arg_27_2)

			if arg_27_2 then
				for iter_27_0, iter_27_1 in pairs(var_0_12) do
					if iter_27_0 ~= arg_27_1 then
						var_0_12[iter_27_0].buff_info_panel.selected_halo:SetActive(false)
					end
				end

				var_0_11 = arg_27_1
			end
		else
			if var_0_12[var_0_11] then
				var_0_12[var_0_11].buff_info_panel.selected_halo:SetActive(false)
			end

			var_0_11 = nil
		end

		if var_0_11 ~= var_0_11 then
			self:set_btn_info()
		end
	end

	function arg_1_0:__extract_buff_click(arg_28_1)
		if not var_0_10 or not var_0_10[arg_28_1] then
			log.print_r(arg_28_1, "此处参数有误！！i == ")
		end

		if var_0_10[arg_28_1] == var_0_4.card_status.card_none_new then
			self:__close_panel()
		elseif var_0_10[arg_28_1] == var_0_4.card_status.card_equips then
			if self._is_from_buff_map then
				self:__msg_box_show("确认替换", {
					old_id = 0,
					aim_id = self._new_card_id,
					pos = arg_28_1
				}, true)
			else
				var_0_3:req_TowerChipInTransientReq(arg_28_1)
			end
		end
	end

	function arg_1_0:__update_buff_storage_btnstate()
		if self._new_card_id and self._new_card_id ~= 0 then
			for iter_29_0, iter_29_1 in pairs(var_0_13) do
				if iter_29_1 and iter_29_1 ~= 0 then
					var_0_10[iter_29_0] = var_0_4.card_status.card_replace

					var_0_12[iter_29_0].buff_info_panel.replace_btn:SetActive(true)
					var_0_12[iter_29_0].buff_info_panel.decompose_btn:SetActive(false)

					var_0_12[iter_29_0].buff_info_panel.replace_btn.txt_replace.text.text = var_0_1:getNowLang("ui_tower_buff_switch")
				else
					var_0_10[iter_29_0] = var_0_4.card_status.card_equips
					var_0_12[iter_29_0].extract_buff_btn.txt_replace.text.text = var_0_1:getNowLang("ui_tower_buff_equip")
				end
			end
		else
			for iter_29_2, iter_29_3 in pairs(var_0_13) do
				if iter_29_3 and iter_29_3 ~= 0 then
					var_0_10[iter_29_2] = var_0_4.card_status.card_give_up

					var_0_12[iter_29_2].buff_info_panel.replace_btn:SetActive(false)
					var_0_12[iter_29_2].buff_info_panel.decompose_btn:SetActive(true)

					var_0_12[iter_29_2].buff_info_panel.replace_btn.txt_replace.text.text = var_0_1:getNowLang("decompose")
				else
					var_0_10[iter_29_2] = var_0_4.card_status.card_none_new
					var_0_12[iter_29_2].extract_buff_btn.txt_replace.text.text = var_0_1:getNowLang("ui_tower_buff_draw")
				end
			end
		end
	end

	function arg_1_0:__set_storage_btn(arg_30_1, arg_30_2)
		print(arg_30_1)

		if not var_0_12[arg_30_1] then
			print("错误的index")
		end

		if arg_30_2 and arg_30_2 ~= 0 then
			if self._card_status == var_0_4.card_status.card_all_replace then
				var_0_12[arg_30_1].buff_info_panel.replace_btn:SetActive(true)
			else
				var_0_12[arg_30_1].buff_info_panel.replace_btn:SetActive(false)
			end
		end
	end

	function arg_1_0:__store_buff(arg_31_1)
		if var_0_10[arg_31_1] == var_0_4.card_status.card_replace then
			self:__msg_box_show("确认替换", {
				is_equip_replace = false,
				old_id = var_0_13[arg_31_1],
				aim_id = self._new_card_id,
				pos = arg_31_1
			}, true)
		end
	end

	function arg_1_0:__decompose_btn_click(arg_32_1)
		if var_0_10[arg_32_1] == var_0_4.card_status.card_give_up then
			self:__msg_box_show("确认分解", arg_32_1)
		else
			log.print_r(arg_32_1, "   **********错误信息：")
		end
	end

	function arg_1_0:__msg_box_show(arg_33_1, arg_33_2, arg_33_3)
		local var_33_0 = self._control.msg_box
		local var_33_1 = self._control.msg_box.main

		self._control.msg_box.main.confirmbtn.button.onClick:RemoveAllListeners()
		self._control.msg_box:SetActive(true)

		local var_33_2 = self:autoKillDOTween(var_0_9.Sequence())

		self._control.msg_box.transform.localScale = var_0_8.New(0.1, 0.1)

		self:__play_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		var_33_2:Append(self._control.msg_box.transform:DOScale(1, 0.15):SetEase(DG.Tweening.Ease.OutBack))

		local var_33_3

		if arg_33_1 == "确认分解" then
			local var_33_4 = var_0_5.find_object_by_id(arg_33_3 and arg_33_2 or var_0_13[arg_33_2])

			var_33_1.title.text.text = "删除芯片"
			var_33_1.main_text.use.text.text = "删除芯片" .. var_33_4.title .. "后可获得GSD资料，是否将芯片放入回收站并删除?"
			var_33_1.former_num.text.text = self._coin
			var_33_1.former_num.arrow.latter_num.text.text = self._coin + var_33_4.quality
			var_33_3 = arg_33_3 and function()
				var_0_3:req_TowerChipAbandonReq()
			end or function()
				var_0_3:req_TowerDecomposeChipReq(arg_33_2)
			end
		end

		if arg_33_1 == "确认替换" then
			local var_33_5 = arg_33_2.aim_id

			if not arg_33_2.old_id or not var_33_5 or var_33_5 == 0 then
				log.print_r("错误的old_id 或 错aim_id``````````````````````````````")

				return
			end

			local var_33_6 = arg_33_2.old_id ~= 0 and var_0_5.find_object_by_id(arg_33_2.old_id) or {
				quality = 0
			}
			local var_33_7 = var_0_5.find_object_by_id(var_33_5)

			var_33_1.title.text.text = self._is_from_buff_map and "确认激活" or var_0_1:getNowLang("ui_tower_buff_switch_title")
			var_33_1.main_text.use.text.text = "是否替换强化数据？（替换后，旧的强化数据将会被覆盖并分解为GSD资料）"

			local var_33_9 = self._coin + var_33_6.quality

			if self._is_from_buff_map then
				var_33_9 = var_33_9 - var_33_7.price
			end

			var_33_1.former_num.text.text = self._coin
			var_33_1.former_num.arrow.latter_num.text.text = var_33_9
			var_33_3 = arg_33_3 and (arg_33_2.is_equip_replace and function()
				var_33_0:SetActive(false)

				if self._is_from_buff_map then
					var_0_3:req_TowerBuyChipReq(var_33_5)
				end

				var_0_3:req_TowerEquipChipReq(arg_33_2.pos)
			end or function()
				var_33_0:SetActive(false)

				if self._is_from_buff_map then
					var_0_3:req_TowerBuyChipReq(var_33_5)
				end

				var_0_3:req_TowerChipInTransientReq(arg_33_2.pos)
			end) or function()
				var_0_3:req_TowerTransientEquipReq(var_0_11, arg_33_2.pos)
			end
		end

		var_33_2:AppendCallback(function()
			var_33_1.confirmbtn.button.onClick:AddListener(var_33_3)
		end)
		var_33_2:Play()
	end

	function arg_1_0:__msg_box_anim()
		local var_40_0 = self:autoKillDOTween(var_0_9.Sequence())

		self._control.msg_box.transform.localScale = var_0_8.New(0.1, 0.1)

		self:__play_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		var_40_0:Append(self._control.msg_box.transform:DOScale(1, 0.15):SetEase(DG.Tweening.Ease.OutBack))
		var_40_0:Play()
	end

	function arg_1_0:__play_se(arg_41_1)
		self:playSE(arg_41_1, false)
	end

	function arg_1_0:__onReset()
		self:__reset_animations()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_43_0)
	local var_43_0 = var_0_2:class("tactical_machine")

	var_43_0._reusable_cell = nil
	var_43_0._lower_card = nil
	var_43_0._speical_card = nil
	var_43_0._hight_card = nil
	var_43_0._all_hight_card = 0
	var_43_0._new_card_id = nil
	var_43_0._is_already_init = false
	var_43_0._equ_pos = nil
	var_43_0._card_status = nil

	return var_43_0
end

return var_0_0
