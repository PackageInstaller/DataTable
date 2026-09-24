local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = DG.Tweening.DOTween
local var_0_5 = gameenum.common_type
local var_0_6 = string.format
local var_0_7 = table.insert
local var_0_8 = gameconfig.ship_config
local var_0_9 = gamecore.util_func
local var_0_10 = math.sqrt
local var_0_11 = math.ceil
local var_0_12 = gameconfig.bathhouse_config
local var_0_13 = gameconfig.shop_config
local var_0_14 = gameconfig.skin_config
local var_0_15 = table.sort
local var_0_16 = gamecore.prompt
local var_0_17 = UnityEngine.Vector3
local var_0_18 = gameconfig.workshop_config
local var_0_20
local var_0_21
local var_0_22
local var_0_23
local var_0_24
local var_0_25
local var_0_26 = {
	general_repair = 2,
	waiting_change = 4,
	free = 1,
	fast_repair = 3
}
local var_0_27 = {}
local var_0_28 = {}
local var_0_29 = {}
local var_0_30 = {}
local var_0_31 = 100
local var_0_32 = {
	Color(0.2549019607843137, 0.5882352941176471, 0.7647058823529411),
	Color(0.8823529411764706, 0.4392156862745098, 0.050980392156862744)
}
local var_0_33 = {
	Color.New(0.2549019607843137, 0.5882352941176471, 0.7647058823529411),
	Color.New(0.8823529411764706, 0.4392156862745098, 0.050980392156862744)
}

gamecore.UILoader:define("bathroom", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		var_0_3:set_to_shower(true)
		self:setVisible(true)
		self:__init_panel(arg_2_1, arg_2_2)
	end

	function arg_1_0:set_graphic_raster(arg_3_1)
		self._panel:GetComponent(typeof(UnityEngine.UI.GraphicRaycaster)).enabled = arg_3_1
	end

	function arg_1_0:__onUpdate()
		if self._start_update then
			for iter_4_0, iter_4_1 in ipairs(self._countdown_list) do
				if iter_4_1.countdown_state == var_0_26.general_repair then
					self:__set_countdown_time(iter_4_0, iter_4_1, false)
				elseif iter_4_1.countdown_state == var_0_26.fast_repair then
					self:__set_countdown_time(iter_4_0, iter_4_1, true)
				end
			end
		end

		self:_after_quick_time()

		if self._allow_mouse_move then
			if UnityEngine.Input.GetMouseButtonDown(0) then
				self._room_start_pos = UnityEngine.Input.mousePosition
			end

			if UnityEngine.Input.GetMouseButtonUp(0) then
				self._room_end_pos = UnityEngine.Input.mousePosition

				if self._room_start_pos and self._room_end_pos then
					self:__room_mouse_up_event()
				end
			end
		end
	end

	function arg_1_0:__room_mouse_up_event()
		if 50 >= math.abs(self._room_end_pos.y - self._room_start_pos.y) and 50 >= math.abs(self._room_end_pos.x - self._room_start_pos.x) or #self._now_unlock_room == 1 then
			return
		end

		if self._room_end_pos.x - self._room_start_pos.x or self._room_end_pos.x - self._room_start_pos.x then
			if self._room_end_pos.x - self._room_start_pos.x < -50 or 50 < self._room_end_pos.y - self._room_start_pos.y then
				self:_set_now_room_index((self._now_room_num + 1 > #self._now_unlock_room or nil) and 1)
			elseif 50 < self._room_end_pos.x - self._room_start_pos.x or self._room_end_pos.y - self._room_start_pos.y < -50 then
				self:_set_now_room_index((self._now_room_num - 1 < 1 or nil) and #self._now_unlock_room)
			end
		end

		self._allow_mouse_move = true
		self._room_end_pos = nil
		self._room_start_pos = nil
	end

	function arg_1_0._clear_quick_list(arg_6_0)
		return
	end

	function arg_1_0:_after_quick_time()
		if not var_0_27 or not var_0_28 then
			return
		end

		for iter_7_0, iter_7_1 in pairs(var_0_27) do
			if iter_7_1 then
				if iter_7_1 > 0 then
					if self._now_room_num == 1 then
						if iter_7_0 > 4 then
							return
						end
					elseif self._now_room_num == 2 then
						if iter_7_0 > 8 or iter_7_0 < 5 then
							return
						end
					elseif iter_7_0 < 9 then
						return
					end

					var_0_27[iter_7_0] = iter_7_1 - 1
					var_0_28[iter_7_0].bathroom_player_title.time_txt.text.text = var_0_9.secondsToTime((var_0_11(var_0_27[iter_7_0] / var_0_31 * var_0_29[iter_7_0])))
					self:__set_blood_color(var_0_28[iter_7_0], (var_0_31 - var_0_27[iter_7_0]) / var_0_31 * (1 - var_0_30[iter_7_0]) + var_0_30[iter_7_0]).image.fillAmount = (var_0_31 - var_0_27[iter_7_0]) / var_0_31 * (1 - var_0_30[iter_7_0]) + var_0_30[iter_7_0]
				else
					var_0_27[iter_7_0] = nil

					var_0_28[iter_7_0].bathroom_player_title:SetActive(false)
					var_0_28[iter_7_0].quick_repair_spine:SetActive(false)

					var_0_28[iter_7_0] = nil
					var_0_30[iter_7_0] = nil
					var_0_29[iter_7_0] = nil
				end
			end
		end
	end

	function arg_1_0:get_guide_btn_pos_info(arg_8_1)
		if arg_8_1 == var_0_5.guide_const_id.third_group.three then
			return self._control.repair_btn.transform
		elseif arg_8_1 == var_0_5.guide_const_id.third_group.five then
			return self._control.home_btn.transform
		end
	end

	function arg_1_0:__load_role_with_pool(arg_9_1)
		local var_9_0 = false
		local var_9_1

		for iter_9_0, iter_9_1 in ipairs(self._obj_pool) do
			if not iter_9_1.using then
				var_9_0 = true
				var_9_1 = iter_9_1

				break
			end
		end

		if var_9_0 then
			var_9_1.using = true

			var_9_1.prefabContorl.role.transform.parent.transform:SetParent(arg_9_1, false)

			return var_9_1.prefabContorl, true
		else
			self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.into_living_any_room))

			local var_9_2, var_9_3 = self:loadUIPrefab("single_repair_role", arg_9_1)

			var_9_3.role.transform.parent.transform:SetParent(arg_9_1, false)
			var_0_7(self._obj_pool, {
				using = true,
				prefabContorl = var_9_3
			})

			return var_9_3, false
		end
	end

	function arg_1_0.__reset_role(arg_10_0, arg_10_1)
		arg_10_1.role.transform.parent.rotation = var_0_17.zero

		arg_10_1.quick_repair_spine:SetActive(false)
		arg_10_1.bathroom_player_title.heart:SetActive(false)
		arg_10_1.bathroom_player_title:SetActive(false)
		arg_10_1.role.water:SetActive(false)
		arg_10_1.blood_spine:SetActive(false)
	end

	function arg_1_0:__hide_role_to_pool(arg_11_1)
		if not arg_11_1 then
			for iter_11_0, iter_11_1 in ipairs(self._obj_pool) do
				if iter_11_1.using then
					iter_11_1.prefabContorl.role.transform.parent:SetParent(self._control.role_pool.transform, false)
					self:__reset_role(iter_11_1.prefabContorl)

					iter_11_1.using = false
				end
			end

			return
		end

		for iter_11_2, iter_11_3 in ipairs(self._obj_pool) do
			if arg_11_1 == iter_11_3.prefabContorl then
				iter_11_3.prefabContorl.role.transform.parent:SetParent(self._control.role_pool.transform, false)
				self:__reset_role(iter_11_3.prefabContorl)

				iter_11_3.using = false
			end
		end
	end

	function arg_1_0.__get_distance(arg_12_0, arg_12_1, arg_12_2)
		return (arg_12_1 - arg_12_2).magnitude
	end

	function arg_1_0.__set_work_buff_reduce(arg_13_0, arg_13_1)
		local var_13_0 = 0

		for iter_13_0, iter_13_1 in pairs((var_0_3:get_workshop_data())) do
			local var_13_1 = var_0_18.find_object_by_id(iter_13_1.id).effect[1]

			if var_13_1.type == var_0_5.workshop_const.work_type.reduce_repair_time and arg_13_1 == var_13_1.shipType then
				var_13_0 = var_13_1.num

				return var_13_1.num
			end
		end

		return var_13_0
	end

	function arg_1_0:__set_sit_state_data_list(arg_14_1, arg_14_2, arg_14_3)
		arg_14_2 = var_0_3:find_character_by_id(arg_14_2.id)
		self._countdown_list[arg_14_1].countdown_state = var_0_26.general_repair
		self._countdown_list[arg_14_1].role_control = arg_14_3
		self._countdown_list[arg_14_1].start_time = lx.ServerTime:getUtcTime()
		self._countdown_list[arg_14_1].character_data = arg_14_2
		self._countdown_list[arg_14_1].repair_time = arg_14_2.repair.repair_time - self._countdown_list[arg_14_1].start_time
		self._start_update = true
	end

	function arg_1_0.__set_blood_color(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = {
			arg_15_1.bathroom_player_title.blood_red,
			arg_15_1.bathroom_player_title.blood_yellow,
			arg_15_1.bathroom_player_title.blood_green
		}
		local var_15_1

		local function var_15_2(arg_16_0)
			for iter_16_0, iter_16_1 in ipairs(var_15_0) do
				iter_16_1:SetActive(false)
			end

			var_15_0[arg_16_0]:SetActive(true)

			var_15_1 = var_15_0[arg_16_0]
		end

		if arg_15_2 < var_0_24.big_break.max then
			var_15_2(1)
		elseif arg_15_2 >= var_0_24.middle_break.min and arg_15_2 < var_0_24.middle_break.max then
			var_15_2(2)
		else
			var_15_2(3)
		end

		return var_15_1
	end

	function arg_1_0:__have_repaired()
		local var_17_0 = false

		for iter_17_0, iter_17_1 in pairs(self._countdown_list) do
			if iter_17_1.countdown_state ~= var_0_26.free then
				var_17_0 = true

				break
			end
		end

		self._start_update = var_17_0
	end

	function arg_1_0:__is_reach_the_pos(arg_18_1, arg_18_2)
		return self:__get_distance(arg_18_2.role.transform.parent.transform.localPosition, var_0_21[arg_18_1][6]) < 1
	end

	function arg_1_0:__reset_countdown_list()
		for iter_19_0, iter_19_1 in pairs(self._countdown_list) do
			self:__reset_countdown_by_index(iter_19_0)
		end
	end

	function arg_1_0:__reset_countdown_by_index(arg_20_1)
		self._countdown_list[arg_20_1].countdown_state = var_0_26.free
		self._countdown_list[arg_20_1].role_control = nil
		self._countdown_list[arg_20_1].start_time = 0
		self._countdown_list[arg_20_1].character_data = {}
		self._countdown_list[arg_20_1].repair_time = 0
	end

	function arg_1_0.__get_basket_count(arg_21_0)
		local var_21_0 = 0
		local var_21_1 = var_0_3:get_dock_group(var_0_5.pool_type.repair)

		if not var_21_1 then
			var_0_16:show(var_0_1:getNowLang("Server data reading exception"))

			return var_21_0
		end

		for iter_21_0, iter_21_1 in pairs(var_21_1) do
			if iter_21_1.available then
				var_21_0 = var_21_0 + 1
			end
		end

		return var_21_0
	end

	function arg_1_0.__get_basket_last_count(arg_22_0)
		local var_22_0 = 0
		local var_22_1 = var_0_3:get_dock_group(var_0_5.pool_type.repair)

		if not var_22_1 then
			var_0_16:show(var_0_1:getNowLang("Server data reading exception"))

			return var_22_0
		end

		for iter_22_0, iter_22_1 in pairs(var_22_1) do
			if iter_22_1.available and iter_22_1.state == var_0_5.pool_state.free then
				var_22_0 = var_22_0 + 1
			end
		end

		return var_22_0
	end

	function arg_1_0:__get_now_room_last_count(arg_23_1)
		arg_23_1 = arg_23_1 or false

		local var_23_0 = 0
		local var_23_1 = 0

		if not var_0_3:get_dock_group(var_0_5.pool_type.repair) then
			var_0_16:show(var_0_1:getNowLang("Server data reading exception"))

			return var_23_0
		end

		self:_now_room_info()

		local var_23_2 = self._all_ship_data.one_room

		if self._now_room_num == 2 then
			var_23_2 = self._all_ship_data.two_room
		elseif self._now_room_num == 3 then
			var_23_2 = self._all_ship_data.three_room
		end

		for iter_23_0, iter_23_1 in pairs(var_23_2) do
			if iter_23_1.available and iter_23_1.state == var_0_5.pool_state.free then
				var_23_0 = var_23_0 + 1
			end

			if iter_23_1.available then
				var_23_1 = var_23_1 + 1
			end
		end

		if arg_23_1 then
			var_23_0 = var_23_0 + self._wait_change_count
		end

		return var_23_0, var_23_1
	end

	function arg_1_0:__show_quick_repair_layer(arg_24_1)
		self._control.quick_repair_layer:SetActive(arg_24_1)
	end

	function arg_1_0:__show_expantion_layer(arg_25_1)
		self._allow_mouse_move = false

		if not arg_25_1 then
			self._allow_mouse_move = true
		end

		self._room_end_pos = nil
		self._room_start_pos = nil

		self._control.expantion_layer:SetActive(arg_25_1)
		self._control.expantion_layer.expansion_btn:SetActive(true)

		if #var_0_3:get_bathroom_style() == 3 and self:__get_basket_count() == #var_0_3:get_bathroom_style() * 4 then
			self._control.expantion_layer.expansion_btn:SetActive(false)
		end
	end

	function arg_1_0:show_role_heart(arg_26_1, arg_26_2)
		if self._countdown_list[arg_26_1].role_control then
			self._countdown_list[arg_26_1].role_control.bathroom_player_title.heart:SetActive(arg_26_2)
		end
	end

	function arg_1_0:__create_repair_role(arg_27_1)
		local var_27_0 = 0

		if not self._countdown_list then
			return
		end

		if arg_27_1 and arg_27_1.pos then
			var_27_0 = arg_27_1.pos
		elseif self._now_room_num == 2 then
			for iter_27_0 = 5, #self._countdown_list do
				if self._countdown_list[iter_27_0].countdown_state == var_0_26.free then
					var_27_0 = iter_27_0

					break
				end
			end
		elseif self._now_room_num == 3 then
			for iter_27_1 = 9, #self._countdown_list do
				if self._countdown_list[iter_27_1].countdown_state == var_0_26.free then
					var_27_0 = iter_27_1

					break
				end
			end
		else
			for iter_27_2, iter_27_3 in ipairs(self._countdown_list) do
				if iter_27_3.countdown_state == var_0_26.free then
					var_27_0 = iter_27_2

					break
				end
			end
		end

		local var_27_1, var_27_2 = self:__load_role_with_pool(var_0_20[var_27_0].rectTransform)

		var_27_1.role.transform.parent:GetComponent("RectTransform").anchoredPosition = var_0_21[var_27_0][1]

		var_27_1.bathroom_player_title.fast_btn.button.onClick:RemoveAllListeners()
		var_27_1.bathroom_player_title.fast_btn.button.onClick:AddListener(function()
			self._room_end_pos = nil
			self._room_start_pos = nil

			self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.task_goto))
			self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))
			self:__click_quick_repair_item_event(var_27_0)
		end)
		var_27_1.bathroom_player_title.rub_btn.button.onClick:RemoveAllListeners()
		var_27_1.bathroom_player_title.rub_btn.button.onClick:AddListener(function()
			self._now_character_time = self._countdown_list[var_27_0].repair_time

			self:__click_rub_event(var_27_0)
		end)

		return var_27_0, var_27_1, var_27_2
	end

	function arg_1_0.__play_animation(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
		if not arg_30_1.skeletonGraphic.AnimationState:Equals(nil) then
			arg_30_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_30_2, arg_30_3)
		end
	end

	function arg_1_0:__init_ske(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
		local var_31_0 = var_0_8.find_object_by_cid(arg_31_2.cid).pic_id

		arg_31_1.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_5:get_ship_spine(var_0_5.common_icon.common_ship_q_asset, (arg_31_2.skin ~= 0 or nil) and var_0_14.find_object_by_cid(arg_31_2.skin).icon))
		arg_31_1.skeletonGraphic.material.shader = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")
		arg_31_1.skeletonGraphic.initialSkinName = arg_31_3

		if not arg_31_1.skeletonGraphic:Equals(nil) then
			arg_31_1.skeletonGraphic:Initialize(true)
		end
	end

	function arg_1_0:__init_ske_2(arg_32_1, arg_32_2, arg_32_3, arg_32_4)
		arg_32_1.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(arg_32_2 .. "_SkeletonData.asset")
		arg_32_1.skeletonGraphic.material = self:loadMaterial(arg_32_2 .. "_Material.mat")
		arg_32_1.skeletonGraphic.initialSkinName = "default"

		arg_32_1.skeletonGraphic:Initialize(true)
		self:__play_animation(arg_32_1, arg_32_3, arg_32_4)
	end

	function arg_1_0:__set_countdown_time(arg_33_1, arg_33_2, arg_33_3)
		local var_33_0 = lx.ServerTime:getUtcTime()
		local var_33_2

		for iter_33_0, iter_33_1 in pairs((var_0_3:get_repair_info())) do
			if iter_33_1.pos_id == arg_33_1 then
				var_33_2 = iter_33_1.time
			end
		end

		self._speed_ratio = self._speed_ratio + self._speed_ratio

		local var_33_3 = var_33_2 - lx.ServerTime:getUtcTime() or 1000000

		if not arg_33_2 or not arg_33_2.role_control then
			return
		end

		if self._now_room_num == 1 then
			if arg_33_1 > 4 then
				return
			end
		elseif self._now_room_num == 2 then
			if arg_33_1 < 4 or arg_33_1 > 9 then
				return
			end
		elseif self._now_room_num == 3 and arg_33_1 < 9 then
			return
		end

		arg_33_2.role_control.bathroom_player_title.time_txt.text.text = var_0_9.secondsToTime(var_33_3)

		local var_33_4, var_33_5 = self:__get_repair_need_time(arg_33_2.character_data)

		self:__set_blood_color(arg_33_2.role_control, 1 - var_33_3 / var_33_5).image.fillAmount = 1 - var_33_3 / var_33_5

		if var_33_3 <= 0 or arg_33_3 then
			if arg_33_3 then
				var_0_27[arg_33_1] = var_0_31
				var_0_28[arg_33_1] = arg_33_2.role_control
				var_0_29[arg_33_1] = var_33_3
				var_0_30[arg_33_1] = (arg_33_2.character_data.now_hp + (var_33_0 - arg_33_2.start_time) / arg_33_2.repair_time * (arg_33_2.character_data.hp - arg_33_2.character_data.now_hp)) / arg_33_2.character_data.hp
			else
				arg_33_2.role_control.bathroom_player_title:SetActive(false)
				arg_33_2.role_control.quick_repair_spine:SetActive(false)
			end

			arg_33_2.role_control.bathroom_player_title.rub_btn.button.onClick:RemoveAllListeners()
			arg_33_2.role_control.bathroom_player_title.fast_btn.button.onClick:RemoveAllListeners()
			self:__role_out_bathroom(arg_33_1, nil, arg_33_2.role_control)
		end

		if self._control.quick_repair_layer.activeSelf and arg_33_1 == self._now_repair_role_index then
			if var_33_3 > 0 then
				self._control.quick_repair_layer.time1.text.text = var_0_9.secondsToTime(var_33_3)
			else
				self:__show_quick_repair_layer(false)
			end
		end
	end

	function arg_1_0:__get_repair_need_time(arg_34_1)
		local var_34_0 = var_0_8.find_object_by_cid(arg_34_1.cid)
		local var_34_1 = arg_34_1.hp - arg_34_1.now_hp
		local var_34_2 = arg_34_1.hp
		local var_34_4 = 1
		local var_34_5 = 1
		local var_34_6 = arg_34_1.level <= 11 and 0 or var_0_10(arg_34_1.level - 11) * 10 + 50

		if arg_34_1.marry then
			var_34_5 = var_34_5 * var_0_5.bathroom_const.repair_marry_reduce
		end

		for iter_34_0, iter_34_1 in pairs((var_0_3:get_bathroom_style())) do
			var_34_4 = var_34_4 * var_0_12.find_object_by_id(iter_34_1).effect.time
		end

		local var_34_7 = self:__set_work_buff_reduce(var_34_0.type)
		local var_34_8 = 1

		if var_34_7 ~= 0 then
			var_34_8 = var_34_8 - var_34_7 / 100
		end

		return var_0_11(var_0_11(var_0_11(var_0_11((arg_34_1.level * 5 + var_34_6) * var_34_0.repair_time * var_34_1 + 30) * var_34_5) * var_34_8) * var_34_4), (var_0_11((arg_34_1.level * 5 + var_34_6) * var_34_0.repair_time * var_34_2 + 30))
	end

	function arg_1_0:__role_out_bathroom(arg_35_1, arg_35_2, arg_35_3)
		if self:__is_reach_the_pos(arg_35_1, arg_35_3) then
			if arg_35_2 then
				self:__ship_out_anim_seq(arg_35_1, arg_35_2, arg_35_3)
			else
				self:__ship_out_anim_seq(arg_35_1, self._countdown_list[arg_35_1].character_data, arg_35_3)
			end
		end

		self:__reset_countdown_by_index(arg_35_1)
		self:__have_repaired()

		local var_35_0 = var_0_2:getInstance("bathroom_rubdown")

		if var_35_0 and var_35_0._now_rub_role_index == arg_35_1 then
			var_35_0:__reset_arraw()
		end
	end

	function arg_1_0:__ship_enter_anim_seq(arg_36_1, arg_36_2, arg_36_3)
		self._wait_change_count = self._wait_change_count + 1

		local var_36_0 = self._spine_index

		self._spine_index = self._spine_index + 1

		local var_36_1 = arg_36_3.role
		local var_36_2 = arg_36_3.role.water.transform
		local var_36_3 = self:__get_distance(var_0_21[arg_36_1][3], var_0_21[arg_36_1][4])

		arg_36_3.role.transform.rotation = var_0_17.New(0, 0, 0)

		arg_36_3.role.transform.parent.gameObject:SetActive(true)
		self:__set_sit_state_data_list(arg_36_1, arg_36_2, arg_36_3)

		local var_36_4 = var_0_3:find_character_by_id(arg_36_2.id)

		if not var_36_4 then
			var_0_3:set_bug_id(arg_36_2.id)

			return
		end

		self:__play_animation(arg_36_3.role, var_0_5.ship_spine_anim_name_list.walk_slow, true)

		local var_36_5 = self:autoKillDOTween(var_0_4.Sequence())

		var_36_5:Append(arg_36_3.role.transform.parent:DOLocalMove(var_0_21[arg_36_1][2], self:__get_distance(var_0_21[arg_36_1][1], var_0_21[arg_36_1][2]) / 40):SetEase(DG.Tweening.Ease.Linear))
		var_36_5:AppendCallback(function()
			if var_36_0 ~= self._spine_index and not self._control.role_list.curtain_spine:Equals(nil) then
				self._control.role_list.curtain_spine:SetActive(true)
			end

			self:__play_animation(self._control.role_list.curtain_spine, "normal", false)
		end)
		var_36_5:AppendInterval(1)
		var_36_5:AppendCallback(function()
			self:__init_ske(var_36_1, var_36_4, var_0_5.ship_spine_skin_name_list.bathroom)
			self:__play_animation(var_36_1, var_0_5.ship_spine_anim_name_list.stand1, true)

			self._wait_change_count = math.max(self._wait_change_count - 1, 0)

			self:__set_bath_towel_count(true)
		end)
		var_36_5:AppendInterval(1.167)
		var_36_5:AppendCallback(function()
			if var_36_0 == self._spine_index and not self._control.role_list.curtain_spine:Equals(nil) then
				self._control.role_list.curtain_spine:SetActive(false)
			end

			self:__play_animation(var_36_1, var_0_5.ship_spine_anim_name_list.walk_slow, true)
		end)
		var_36_5:Append(arg_36_3.role.transform.parent:DOLocalMove(var_0_21[arg_36_1][3], self:__get_distance(var_0_21[arg_36_1][2], var_0_21[arg_36_1][3]) / 40):SetEase(DG.Tweening.Ease.Linear))
		var_36_5:AppendCallback(function()
			if not var_36_2:Equals(nil) then
				var_36_2.localPosition = var_0_17.New(0, -45, 0)

				var_36_2.gameObject:SetActive(true)
			end
		end)
		var_36_5:Append(arg_36_3.role.transform.parent:DOLocalMove(var_0_21[arg_36_1][4], var_36_3 / 40):SetEase(DG.Tweening.Ease.Linear))
		var_36_5:Join(arg_36_3.role.water.transform:DOLocalMoveY(-12, var_36_3 / 40):SetEase(DG.Tweening.Ease.Linear))
		var_36_5:Append(arg_36_3.role.transform.parent:DOLocalMove(var_0_21[arg_36_1][5], self:__get_distance(var_0_21[arg_36_1][4], var_0_21[arg_36_1][5]) / 40):SetEase(DG.Tweening.Ease.Linear))
		var_36_5:Append(arg_36_3.role.transform.parent:DOLocalMove(var_0_21[arg_36_1][6], self:__get_distance(var_0_21[arg_36_1][5], var_0_21[arg_36_1][6]) / 40):SetEase(DG.Tweening.Ease.Linear))
		var_36_5:AppendCallback(function()
			arg_36_3.bathroom_player_title:SetActive(true)
			arg_36_3.quick_repair_spine:SetActive(true)
			self:__init_ske(var_36_1, var_36_4, var_0_5.ship_spine_skin_name_list.bathroom)
			self:__play_animation(arg_36_3.quick_repair_spine, var_0_23.fix, true)

			if arg_36_2.now_hp / arg_36_2.hp < var_0_24.big_break.max then
				self:__play_animation(var_36_1, var_0_5.ship_spine_anim_name_list.bathroom_sit_down, true)
			else
				self:__play_animation(var_36_1, var_0_5.ship_spine_anim_name_list.sit_Janpan, true)
			end

			if self._countdown_list[arg_36_1].countdown_state == var_0_26.free then
				arg_36_3.bathroom_player_title:SetActive(false)
				arg_36_3.quick_repair_spine:SetActive(false)
				self:__role_out_bathroom(arg_36_1, arg_36_2, arg_36_3)
			end
		end)
		var_36_5:Play()
		var_0_7(var_0_22, var_36_5)
	end

	function arg_1_0:__ship_out_anim_seq(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
		self._wait_change_count = self._wait_change_count + 1

		local var_42_0 = self._spine_index

		self._spine_index = self._spine_index + 1

		local var_42_1 = arg_42_3.role
		local var_42_2 = arg_42_3.role.transform.parent
		local var_42_3 = arg_42_3.role.water.transform
		local var_42_4 = self:__get_distance(var_0_21[arg_42_1][3], var_0_21[arg_42_1][4])
		local var_42_5 = var_0_3:find_character_by_id(arg_42_2.id)

		if not var_42_5 then
			var_0_3:set_bug_id(arg_42_2.id)

			return
		end

		arg_42_3.role.transform.rotation = var_0_17.New(0, 180, 0)

		local var_42_6 = self:autoKillDOTween(var_0_4.Sequence())

		arg_42_3.quick_repair_spine:SetActive(false)
		var_42_6:AppendCallback(function()
			self:__play_animation(var_42_1, var_0_5.ship_spine_anim_name_list.walk_slow, true)

			if not arg_42_3.blood_spine:Equals(nil) then
				arg_42_3.blood_spine:SetActive(true)
			end

			self:__play_animation(arg_42_3.blood_spine, "repair_effect", false)
		end)
		var_42_6:Append(arg_42_3.role.transform.parent:DOLocalMove(var_0_21[arg_42_1][5], self:__get_distance(var_0_21[arg_42_1][5], var_0_21[arg_42_1][6]) / 40):SetEase(DG.Tweening.Ease.Linear))
		var_42_6:AppendCallback(function()
			if not arg_42_3.blood_spine:Equals(nil) then
				arg_42_3.blood_spine:SetActive(false)
			end
		end)
		var_42_6:Append(arg_42_3.role.transform.parent:DOLocalMove(var_0_21[arg_42_1][4], self:__get_distance(var_0_21[arg_42_1][4], var_0_21[arg_42_1][5]) / 40):SetEase(DG.Tweening.Ease.Linear))
		var_42_6:Append(arg_42_3.role.transform.parent:DOLocalMove(var_0_21[arg_42_1][3], var_42_4 / 40):SetEase(DG.Tweening.Ease.Linear))
		var_42_6:Join(arg_42_3.role.water.transform:DOLocalMoveY(-45, var_42_4 / 40):SetEase(DG.Tweening.Ease.Linear))
		var_42_6:AppendCallback(function()
			if var_42_3 and not var_42_3.gameObject:Equals(nil) then
				var_42_3.gameObject:SetActive(false)
			end
		end)
		var_42_6:Append(arg_42_3.role.transform.parent:DOLocalMove(var_0_21[arg_42_1][2], self:__get_distance(var_0_21[arg_42_1][2], var_0_21[arg_42_1][3]) / 40):SetEase(DG.Tweening.Ease.Linear))
		var_42_6:AppendCallback(function()
			if var_42_0 ~= self._spine_index and not self._control.role_list.curtain_spine:Equals(nil) then
				self._control.role_list.curtain_spine:SetActive(true)
			end

			self:__play_animation(self._control.role_list.curtain_spine, "normal", false)
		end)
		var_42_6:AppendInterval(1)
		var_42_6:AppendCallback(function()
			self:__init_ske(var_42_1, var_42_5, var_0_5.ship_spine_skin_name_list.normal)
			self:__play_animation(var_42_1, var_0_5.ship_spine_anim_name_list.stand1, true)

			self._wait_change_count = math.max(self._wait_change_count - 1, 0)

			self:__set_bath_towel_count(false)
		end)
		var_42_6:AppendInterval(1.167)
		var_42_6:AppendCallback(function()
			if var_42_0 == self._spine_index and not self._control.role_list.curtain_spine:Equals(nil) then
				self._control.role_list.curtain_spine:SetActive(false)
			end

			self:__play_animation(var_42_1, var_0_5.ship_spine_anim_name_list.walk_slow, true)
		end)
		var_42_6:Append(arg_42_3.role.transform.parent:DOLocalMove(var_0_21[arg_42_1][1], self:__get_distance(var_0_21[arg_42_1][1], var_0_21[arg_42_1][2]) / 40):SetEase(DG.Tweening.Ease.Linear))
		var_42_6:AppendCallback(function()
			var_42_2.rotation = var_0_17.New(0, 0, 0)
			var_42_1.rotation = var_0_17.zero

			self:__play_animation(var_42_1, var_0_5.ship_spine_anim_name_list.stand1, false)
			self:__hide_role_to_pool(arg_42_3)
		end)
		var_42_6:Play()
		var_0_7(var_0_22, var_42_6)
	end

	function arg_1_0:ship_repaired_general()
		for iter_50_0, iter_50_1 in ipairs(var_0_2:getInstance("bathroom_repair")._repair_character_array) do
			if not iter_50_1 then
				return
			end

			local var_50_0 = var_0_3:find_character_by_id(iter_50_1.id)

			if not var_50_0 then
				var_0_3:set_bug_id(iter_50_1.id)

				return
			end

			local var_50_1, var_50_2 = self:__create_repair_role()

			self:__init_ske(var_50_2.role, var_50_0, var_0_5.ship_spine_skin_name_list.normal)
			self:__play_animation(var_50_2.role, var_0_5.ship_spine_anim_name_list.walk_slow, true)
			self:__ship_enter_anim_seq(var_50_1, iter_50_1, var_50_2)
		end
	end

	function arg_1_0:__set_repaired_role(arg_51_1)
		local var_51_0 = var_0_3:find_character_by_id(arg_51_1.id)
		local var_51_1 = var_0_3:find_character_by_id(var_51_0.id)
		local var_51_2, var_51_3, var_51_4 = self:__create_repair_role(var_51_0.repair)

		if not var_51_3 then
			return
		end

		local var_51_5 = var_51_3.role

		if not var_51_1 then
			var_0_3:set_bug_id(var_51_0.id)

			return
		end

		self:__init_ske(var_51_5, var_51_1, var_0_5.ship_spine_skin_name_list.bathroom, var_51_4)

		var_51_5.transform.parent.transform.localPosition = var_0_21[var_51_2][6]

		var_51_5.water:SetActive(true)

		var_51_5.water.transform.localPosition = var_0_17.New(0, -12, 0)
		var_51_5.transform.rotation = var_0_17.New(0, 0, 0)

		var_51_3.bathroom_player_title.heart:SetActive(not var_51_0.repair.can_rub_back)
		var_51_5.skeletonGraphic.AnimationState:ClearTracks()

		if var_51_0.now_hp / var_51_0.hp < var_0_24.big_break.max then
			self:__play_animation(var_51_5, var_0_5.ship_spine_anim_name_list.bathroom_sit_down, true)
		else
			self:__play_animation(var_51_5, var_0_5.ship_spine_anim_name_list.sit_Janpan, true)
		end

		self:__set_sit_state_data_list(var_51_2, var_51_0, var_51_3)
		var_51_3.bathroom_player_title:SetActive(true)
		var_51_3.quick_repair_spine:SetActive(true)
		var_51_3.blood_spine:SetActive(false)
		var_51_5.transform.parent.gameObject:SetActive(true)
	end

	function arg_1_0:__init_style_data()
		for iter_52_0, iter_52_1 in ipairs((var_0_12.get_sequence())) do
			table.insert(self._my_style_data, {
				is_have = false,
				id = iter_52_1.id
			})
		end

		var_0_15(self._my_style_data, function(arg_53_0, arg_53_1)
			return arg_53_0.id < arg_53_1.id
		end)
	end

	function arg_1_0:__set_bath_towel_count(arg_54_1)
		if not var_0_25[self._now_room_num] then
			return
		end

		self:_now_style_num_show(arg_54_1)
	end

	function arg_1_0:_now_style_num_show(arg_55_1)
		local var_55_0 = self:__get_basket_count()
		local var_55_1, var_55_2 = self:__get_now_room_last_count(arg_55_1)
		local var_55_3 = var_55_2 == 4
		local var_55_4 = 1

		for iter_55_0, iter_55_1 in pairs(var_0_5.bathroom_style_k) do
			if self._now_all_style_list[self._now_room_num] == iter_55_1 then
				var_55_4 = iter_55_0
			end
		end

		local var_55_5 = var_0_25[var_55_4]

		for iter_55_2, iter_55_3 in pairs(var_0_25) do
			iter_55_3:SetActive(false)
		end

		var_55_5:SetActive(true)

		if var_55_4 == 1 then
			var_55_5.frame_1:SetActive(true)
			var_55_5.frame_2:SetActive(false)
			var_55_5.frame_1.basket_small_left_empty:SetActive(true)
			var_55_5.frame_1.basket_bottom:SetActive(true)
			var_55_5.frame_1.basket_small_right_empty:SetActive(false)
			var_55_5.frame_1.basket_top:SetActive(false)

			if self._now_room_num == 1 then
				var_55_5.frame_1.basket_small_right_empty:SetActive(true)
				var_55_5.frame_1.basket_top:SetActive(true)
			end

			if var_55_3 then
				var_55_5.frame_1:SetActive(false)
				var_55_5.frame_2:SetActive(true)
				var_55_5.frame_2.basket_big_left_bottom_empty:SetActive(true)
				var_55_5.frame_2.basket_bottom_2:SetActive(true)
				var_55_5.frame_2.basket_big_right_bottom_empty:SetActive(true)
				var_55_5.frame_2.basket_bottom_1:SetActive(true)
				var_55_5.frame_2.basket_big_left_top_empty:SetActive(true)
				var_55_5.frame_2.basket_top_2:SetActive(true)
				var_55_5.frame_2.basket_big_right_top_empty:SetActive(true)
				var_55_5.frame_2.basket_top_1:SetActive(true)
			elseif var_55_2 == 3 then
				var_55_5.frame_1:SetActive(false)
				var_55_5.frame_2:SetActive(true)
				var_55_5.frame_2.basket_big_left_bottom_empty:SetActive(true)
				var_55_5.frame_2.basket_bottom_2:SetActive(true)
				var_55_5.frame_2.basket_big_right_bottom_empty:SetActive(true)
				var_55_5.frame_2.basket_bottom_1:SetActive(true)
				var_55_5.frame_2.basket_big_left_top_empty:SetActive(true)
				var_55_5.frame_2.basket_top_2:SetActive(true)
				var_55_5.frame_2.basket_big_right_top_empty:SetActive(false)
				var_55_5.frame_2.basket_top_1:SetActive(false)
			elseif var_55_2 == 2 then
				var_55_5.frame_1.basket_small_right_empty:SetActive(true)
				var_55_5.frame_1.basket_top:SetActive(true)
			end

			if var_55_1 == 3 then
				if var_55_3 then
					var_55_5.frame_2.basket_top_1:SetActive(false)
				end
			elseif var_55_1 == 2 then
				if var_55_2 > 2 then
					var_55_5.frame_2.basket_top_1:SetActive(false)
					var_55_5.frame_2.basket_top_2:SetActive(false)
				end
			elseif var_55_1 == 1 then
				if var_55_2 > 2 then
					var_55_5.frame_2.basket_top_1:SetActive(false)
					var_55_5.frame_2.basket_top_2:SetActive(false)
					var_55_5.frame_2.basket_bottom_1:SetActive(false)
				else
					var_55_5.frame_1.basket_top:SetActive(false)
				end
			elseif var_55_1 == 0 then
				var_55_5.frame_2.basket_bottom_2:SetActive(false)
				var_55_5.frame_2.basket_bottom_1:SetActive(false)
				var_55_5.frame_2.basket_top_2:SetActive(false)
				var_55_5.frame_2.basket_top_1:SetActive(false)

				if var_55_2 < 3 then
					var_55_5.frame_1.basket_bottom:SetActive(false)
					var_55_5.frame_1.basket_top:SetActive(false)
				end
			end
		elseif var_55_4 == 2 then
			var_55_5.frame_1:SetActive(false)
			var_55_5.frame_2:SetActive(true)
			var_55_5.frame_2.frame:SetActive(true)
			var_55_5.frame_2.basket_bottom:SetActive(true)
			var_55_5.frame_2.basket_bottom_empty:SetActive(true)
			var_55_5.frame_2.basket_top_empty:SetActive(false)
			var_55_5.frame_2.basket_top:SetActive(false)

			if self._now_room_num == 1 then
				var_55_5.frame_2.basket_top_empty:SetActive(true)
				var_55_5.frame_2.basket_top:SetActive(true)
			end

			if var_55_3 then
				var_55_5.frame_2.basket_top_empty:SetActive(true)
				var_55_5.frame_2.basket_top:SetActive(true)
				var_55_5.frame_1:SetActive(true)
				var_55_5.frame_1.frame:SetActive(true)
				var_55_5.frame_1.basket_bottom_empty:SetActive(true)
				var_55_5.frame_1.basket_bottom:SetActive(true)
				var_55_5.frame_1.basket_top_empty:SetActive(true)
				var_55_5.frame_1.basket_top:SetActive(true)
			elseif var_55_2 == 3 then
				var_55_5.frame_2.basket_top_empty:SetActive(true)
				var_55_5.frame_2.basket_top:SetActive(true)
				var_55_5.frame_1:SetActive(true)
				var_55_5.frame_1.frame:SetActive(true)
				var_55_5.frame_1.basket_bottom_empty:SetActive(true)
				var_55_5.frame_1.basket_bottom:SetActive(true)
				var_55_5.frame_1.basket_top_empty:SetActive(false)
				var_55_5.frame_1.basket_top:SetActive(false)
			elseif var_55_2 == 2 then
				var_55_5.frame_2.basket_top_empty:SetActive(true)
				var_55_5.frame_2.basket_top:SetActive(true)
			end

			if var_55_1 == 3 then
				if var_55_3 then
					var_55_5.frame_1.basket_top_empty:SetActive(true)
					var_55_5.frame_1.basket_top:SetActive(false)
				end
			elseif var_55_1 == 2 then
				if var_55_2 > 2 then
					var_55_5.frame_1.basket_bottom:SetActive(false)
					var_55_5.frame_1.basket_top:SetActive(false)
				end
			elseif var_55_1 == 1 then
				if var_55_2 > 2 then
					var_55_5.frame_1.basket_bottom:SetActive(false)
					var_55_5.frame_1.basket_top:SetActive(false)
					var_55_5.frame_2.basket_top:SetActive(false)
				else
					var_55_5.frame_1.basket_bottom:SetActive(false)
					var_55_5.frame_2.basket_top:SetActive(false)
				end
			elseif var_55_1 == 0 then
				var_55_5.frame_1.basket_top:SetActive(false)
				var_55_5.frame_1.basket_bottom:SetActive(false)
				var_55_5.frame_2.basket_top:SetActive(false)
				var_55_5.frame_2.basket_bottom:SetActive(false)
			end
		elseif var_55_4 == 3 then
			var_55_5.frame_1:SetActive(true)
			var_55_5.frame_2:SetActive(false)
			var_55_5.frame_1.basket_bottom:SetActive(true)
			var_55_5.frame_1.basket_top:SetActive(false)

			if self._now_room_num == 1 then
				var_55_5.frame_1.basket_top:SetActive(true)
			end

			if var_55_3 then
				var_55_5.frame_1.basket_top:SetActive(true)
				var_55_5.frame_2:SetActive(true)
				var_55_5.frame_2.basket_bottom:SetActive(true)
				var_55_5.frame_2.basket_top:SetActive(true)
			elseif var_55_2 == 3 then
				var_55_5.frame_1.basket_top:SetActive(true)
				var_55_5.frame_2:SetActive(true)
				var_55_5.frame_2.basket_bottom:SetActive(true)
				var_55_5.frame_2.basket_top:SetActive(false)
			else
				var_55_5.frame_1.basket_top:SetActive(true)
			end

			if var_55_1 == 3 then
				if var_55_3 then
					var_55_5.frame_2.basket_top:SetActive(false)
				end
			elseif var_55_1 == 2 then
				if var_55_2 > 2 then
					var_55_5.frame_1.basket_top:SetActive(true)
					var_55_5.frame_2.basket_bottom:SetActive(false)
					var_55_5.frame_2.basket_top:SetActive(false)
				end
			elseif var_55_1 == 1 then
				var_55_5.frame_1.basket_top:SetActive(false)

				if var_55_2 > 2 then
					var_55_5.frame_2.basket_bottom:SetActive(false)
					var_55_5.frame_2.basket_top:SetActive(false)
				end
			elseif var_55_1 == 0 then
				var_55_5.frame_2.basket_bottom:SetActive(false)
				var_55_5.frame_2.basket_top:SetActive(false)
				var_55_5.frame_1.basket_top:SetActive(false)
				var_55_5.frame_1.basket_bottom:SetActive(false)
			end
		end
	end

	function arg_1_0:__set_style_by_index()
		local var_56_0 = 1

		self._now_all_style_list = var_0_3:get_use_info_data().room_style_list

		for iter_56_0, iter_56_1 in pairs(var_0_5.bathroom_style_k) do
			if self._now_all_style_list and next(self._now_all_style_list) and self._now_all_style_list[self._now_room_num] == iter_56_1 then
				var_56_0 = iter_56_0
				self._now_bathroom_style_index = iter_56_0
			end
		end

		self._control.bg.image.sprite = self:loadSprite(var_0_5:get_format_url(var_0_5.bathroom_const.bathroom_bg, var_56_0))

		self._control.role_list.teaboard_spine:SetActive(var_56_0 ~= 1)

		local var_56_1
		local var_56_2

		if var_56_0 == 1 then
			self:__init_ske_2(self._control.role_list.wave_spine, var_0_5.bathroom_const.SP_water, "normal", true)

			var_56_2 = var_0_17.New(408, 101, 0)
			var_56_1 = var_0_17.New(1.25, 1.25, 1)
		elseif var_56_0 == 2 then
			self:__init_ske_2(self._control.role_list.wave_spine, var_0_5.bathroom_const.SP_water3, "normal", true)
			self:__init_ske_2(self._control.role_list.teaboard_spine, var_0_5.bathroom_const.SP_water2_galo, "normal", true)

			var_56_2 = var_0_17.New(448, 120, 0)
			var_56_1 = var_0_17.New(1.35, 1.35, 1)
		else
			self:__init_ske_2(self._control.role_list.wave_spine, var_0_5.bathroom_const.bathhouse_effect_wave, "bathhouse_effect_wave", true)
			self:__init_ske_2(self._control.role_list.teaboard_spine, var_0_5.bathroom_const.SP_water3_add, "normal", true)

			var_56_2 = var_0_17.New(681, 325, 0)
			var_56_1 = var_0_17.New(1, 1, 1)
		end

		self._control.role_list.wave_spine.transform.localPosition = var_56_2
		self._control.role_list.wave_spine.transform.localScale = var_56_1
	end

	function arg_1_0:update_repair()
		local var_57_0 = 1

		for iter_57_0, iter_57_1 in pairs(var_0_5.bathroom_style_k) do
			if self._now_all_style_list and next(self._now_all_style_list) then
				if self._now_all_style_list[self._now_room_num] == iter_57_1 then
					var_57_0 = iter_57_0
				end
			else
				var_57_0 = 1
			end
		end

		self._control.smoke.transform:SetParent(var_0_25[var_57_0].transform, true)
		self._control.smoke.transform:SetAsLastSibling()

		if var_57_0 == 1 or var_57_0 == 2 then
			self._control.smoke.transform:SetAsLastSibling()
		else
			self._control.smoke.transform:SetSiblingIndex(self._control.smoke.transform:GetSiblingIndex() - 1)
		end
	end

	function arg_1_0:quick_repair_resp()
		self:_now_room_info()

		self._speed_ratio = 5

		if self._is_all_fast_repair then
			for iter_58_0, iter_58_1 in pairs(self._countdown_list) do
				if self._countdown_list[iter_58_0].countdown_state == var_0_26.general_repair then
					self._countdown_list[iter_58_0].countdown_state = var_0_26.fast_repair
				end
			end

			self._is_all_fast_repair = false

			return
		end

		if self._now_repair_role_index == 0 then
			return
		end

		self:__show_quick_repair_layer(false)

		self._countdown_list[self._now_repair_role_index].countdown_state = var_0_26.fast_repair
		self._now_repair_role_index = 0
	end

	function arg_1_0:__click_quick_repair_item_event(arg_59_1)
		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.task_goto))

		local var_59_0 = var_0_3:get_fast_item_count()

		if var_59_0 <= 0 then
			var_0_16:show(var_0_1:getNowLang("quick_item_not_enough"))

			return
		end

		self._now_repair_role_index = arg_59_1
		self._control.quick_repair_layer.tip.text.text = var_0_1:getNowLang("confirmfastbuildcontent3", true)
		self._control.quick_repair_layer.count1.text.text = var_59_0
		self._control.quick_repair_layer.count2.text.text = var_59_0 - 1
		self._control.quick_repair_layer.time2.text.text = "00:00:00"

		self:__show_quick_repair_layer(true)
	end

	function arg_1_0:changestyle_resp()
		self:set_bathroom_style()

		self._control.expantion_layer.expantion_count_txt.text.text = self:__get_basket_count() .. "/" .. #var_0_3:get_bathroom_style() * 4

		self:_updata_now_info()
		self:_initialize_change_room()
		self:_now_style_num_show()
	end

	function arg_1_0:__click_basket_expantion_event()
		self._control.expantion_layer.expantion_count_txt.text.text = self:__get_basket_count() .. "/" .. #var_0_3:get_bathroom_style() * 4

		self:__show_expantion_layer(true)
	end

	function arg_1_0:__click_buy_expansion_event()
		if self:__get_basket_count() / #var_0_3:get_dock_group(var_0_5.pool_type.repair) == 1 then
			var_0_16:show(var_0_1:getNowLang("ismax"))
		else
			var_0_3:set_bathroom_buy_type(var_0_5.bathroom_buy_type.extension)
			var_0_2:createInstance("shop_bounced"):show(var_0_13.find_object_by_id(23))
		end
	end

	function arg_1_0:__click_rub_event(arg_63_1)
		if not self._countdown_list[arg_63_1] and not self._countdown_list[arg_63_1].character_data then
			return
		end

		self._countdown_list[arg_63_1].character_data = var_0_3:find_character_by_id(self._countdown_list[arg_63_1].character_data.id)

		if not self._countdown_list[arg_63_1].character_data.repair then
			return
		end

		if self._countdown_list[arg_63_1].character_data.repair.can_rub_back then
			self._now_rub_role_index = arg_63_1

			var_0_2:createInstance("bathroom_rubdown"):show({
				now_rub_role_index = arg_63_1,
				countdown_data = self._countdown_list[arg_63_1],
				now_style_index = self._now_style_index
			})
		end
	end

	function arg_1_0.role_rub_resp(arg_64_0)
		return
	end

	function arg_1_0:buy_repair_resp()
		var_0_16:show(var_0_1:getNowLang("shopbuysuccess"))
		self:update_repair()
		self:__set_bath_towel_count(1)

		self._control.expantion_layer.expantion_count_txt.text.text = self:__get_basket_count() .. "/" .. #var_0_3:get_bathroom_style() * 4
	end

	function arg_1_0:set_bathroom_style()
		self._user_data = var_0_3:get_use_info_data()
		self._now_all_style_list = var_0_3:get_use_info_data().room_style_list

		for iter_66_0, iter_66_1 in ipairs(self._my_style_data) do
			if iter_66_1.id == self._user_data.repair_style then
				self._now_style_index = iter_66_0

				break
			end
		end

		self:__set_style_by_index()
		self:update_repair()
		self:__set_bath_towel_count()
		self:set_repaired_ship()
	end

	function arg_1_0:__reset_role_list()
		for iter_67_0, iter_67_1 in pairs(var_0_22 or {}) do
			iter_67_1:Kill()
		end

		var_0_22 = {}

		self:__hide_role_to_pool()
	end

	function arg_1_0:set_repaired_ship()
		local var_68_0 = self._all_ship_data.one_room

		if self._now_room_num == 2 then
			var_68_0 = self._all_ship_data.two_room
		elseif self._now_room_num == 3 then
			var_68_0 = self._all_ship_data.three_room
		end

		for iter_68_0, iter_68_1 in pairs(var_68_0) do
			if iter_68_1.available and iter_68_1.state == var_0_5.pool_state.engaged and self._now_room_style_change then
				self:__set_repaired_role(iter_68_1)
			end
		end
	end

	function arg_1_0:__init_panel(arg_69_1, arg_69_2)
		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
			self:__init_style_data()
		end

		self._enter_panel = arg_69_1
		self._return_param = arg_69_2

		self:_updata_now_info()

		self._now_basket_count = self:__get_basket_count()

		self._control.role_list.curtain_spine:SetActive(false)
		self:_now_room_info()

		self._is_already_init = true

		self:_initialize_change_room()
		self:_set_now_room_index(1)
		self:_play_now_bgm()
	end

	function arg_1_0._updata_now_info(arg_70_0)
		arg_70_0._user_data = var_0_3:get_use_info_data()
		arg_70_0._now_unlock_room = var_0_3:get_bathroom_style()
		arg_70_0._now_all_style_list = var_0_3:get_use_info_data().room_style_list
	end

	function arg_1_0:_now_room_info()
		self._all_ship_data = {
			one_room = {},
			two_room = {},
			three_room = {}
		}

		for iter_71_0, iter_71_1 in pairs((var_0_3:get_dock_group(var_0_5.pool_type.repair))) do
			if iter_71_1.pos_id <= 4 then
				var_0_7(self._all_ship_data.one_room, iter_71_1)
			elseif iter_71_1.pos_id > 4 and iter_71_1.pos_id <= 8 then
				var_0_7(self._all_ship_data.two_room, iter_71_1)
			else
				var_0_7(self._all_ship_data.three_room, iter_71_1)
			end
		end
	end

	function arg_1_0:_initialize_change_room()
		for iter_72_0, iter_72_1 in pairs(self._change_now_room) do
			iter_72_1.ban_btn:SetActive(true)

			iter_72_1.toggle.enabled = false
		end

		for iter_72_2, iter_72_3 in pairs(self._now_unlock_room) do
			self._change_now_room[iter_72_2].ban_btn:SetActive(false)

			self._change_now_room[iter_72_2].toggle.enabled = true
		end
	end

	function arg_1_0:_set_now_room_index(arg_73_1)
		for iter_73_0, iter_73_1 in pairs(self._change_now_room) do
			iter_73_1.change:SetActive(false)

			if iter_73_0 ~= arg_73_1 then
				iter_73_1.num_img.image.color = var_0_32[1]
				iter_73_1.room_text.text.color = var_0_33[1]
			else
				iter_73_1.num_img.image.color = var_0_32[2]
				iter_73_1.room_text.text.color = var_0_33[2]
			end
		end

		self._change_now_room[arg_73_1].change:SetActive(true)

		self._change_now_room[arg_73_1].toggle.isOn = true
		self._wait_change_count = 0

		self:__reset_countdown_list()
		self:__reset_role_list()
		self:set_bathroom_style()
		self:__set_style_by_index()
		self:update_repair()
		self:_play_now_bgm()

		var_0_27 = {}
	end

	function arg_1_0:_play_now_bgm()
		if self._now_all_style_list and next(self._now_all_style_list) then
			if self._now_all_style_list[self._now_room_num] == var_0_5.bathroom_style_id.one_style then
				self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.bathroom_one))
			elseif self._now_all_style_list[self._now_room_num] == var_0_5.bathroom_style_id.two_style then
				self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.bathroom_two))
			elseif self._now_all_style_list[self._now_room_num] == var_0_5.bathroom_style_id.three_style then
				self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.bathroom_three))
			end
		end
	end

	function arg_1_0:__init_language()
		self._control.style_btn.changedecoration.text.text = var_0_1:getNowLang("changedecoration")
		self._control.repair_btn.select_team_basic.text.text = var_0_1:getNowLang("select_team_basic")
		self._control.expantion_layer.title.text.text = var_0_1:getNowLang("sexpantiontitle")
		self._control.expantion_layer.ui_expantioninfo.text.text = var_0_1:getNowLang("ui_expantioninfo")
		self._control.expantion_layer.ui_expantioncount.text.text = var_0_1:getNowLang("ui_expantioncount")
		self._control.expantion_layer.expansion.text.text = var_0_1:getNowLang("expantion")
		self._control.quick_repair_layer.title.text.text = var_0_1:getNowLang("pvefastrepairtitle")
		self._control.quick_repair_layer.text.text.text = var_0_1:getNowLang("space_confirm")
		self._control.quick_repair_layer.quitbtn.text.text.text = var_0_1:getNowLang("space_cancel")
		self._control.quick_repair_layer.item.txt.text.text = var_0_1:getNowLang("itemamount")
		self._control.quick_repair_layer.time.txt.text.text = var_0_1:getNowLang("timereduce")
	end

	function arg_1_0:__init_constant()
		var_0_20 = {
			self._control.role_list.role_1,
			self._control.role_list.role_2,
			self._control.role_list.role_3,
			self._control.role_list.role_4,
			self._control.role_list.role_5,
			self._control.role_list.role_6,
			self._control.role_list.role_7,
			self._control.role_list.role_8,
			self._control.role_list.role_9,
			self._control.role_list.role_10,
			self._control.role_list.role_11,
			self._control.role_list.role_12
		}
		var_0_21 = {
			{
				var_0_17.New(1380, 110, 0),
				var_0_17.New(1180, 110, 0),
				var_0_17.New(790, 110, 0),
				var_0_17.New(680, 75, 0),
				var_0_17.New(560, 45, 0),
				var_0_17.New(240, 45, 0)
			},
			{
				var_0_17.New(1430, 110, 0),
				var_0_17.New(1180, 110, 0),
				var_0_17.New(790, 110, 0),
				var_0_17.New(680, 75, 0),
				var_0_17.New(570, 122, 0),
				var_0_17.New(265, 122, 0)
			},
			{
				var_0_17.New(1480, 110, 0),
				var_0_17.New(1180, 110, 0),
				var_0_17.New(790, 110, 0),
				var_0_17.New(680, 75, 0),
				var_0_17.New(560, 45, 0),
				var_0_17.New(560, 45, 0)
			},
			{
				var_0_17.New(1530, 110, 0),
				var_0_17.New(1180, 110, 0),
				var_0_17.New(790, 110, 0),
				var_0_17.New(680, 75, 0),
				var_0_17.New(570, 122, 0),
				var_0_17.New(570, 122, 0)
			},
			{
				var_0_17.New(1380, 110, 0),
				var_0_17.New(1180, 110, 0),
				var_0_17.New(790, 110, 0),
				var_0_17.New(680, 75, 0),
				var_0_17.New(560, 45, 0),
				var_0_17.New(240, 45, 0)
			},
			{
				var_0_17.New(1430, 110, 0),
				var_0_17.New(1180, 110, 0),
				var_0_17.New(790, 110, 0),
				var_0_17.New(680, 75, 0),
				var_0_17.New(570, 122, 0),
				var_0_17.New(265, 122, 0)
			},
			{
				var_0_17.New(1480, 110, 0),
				var_0_17.New(1180, 110, 0),
				var_0_17.New(790, 110, 0),
				var_0_17.New(680, 75, 0),
				var_0_17.New(560, 45, 0),
				var_0_17.New(560, 45, 0)
			},
			{
				var_0_17.New(1530, 110, 0),
				var_0_17.New(1180, 110, 0),
				var_0_17.New(790, 110, 0),
				var_0_17.New(680, 75, 0),
				var_0_17.New(570, 122, 0),
				var_0_17.New(570, 122, 0)
			},
			{
				var_0_17.New(1380, 110, 0),
				var_0_17.New(1180, 110, 0),
				var_0_17.New(790, 110, 0),
				var_0_17.New(680, 75, 0),
				var_0_17.New(560, 45, 0),
				var_0_17.New(240, 45, 0)
			},
			{
				var_0_17.New(1430, 110, 0),
				var_0_17.New(1180, 110, 0),
				var_0_17.New(790, 110, 0),
				var_0_17.New(680, 75, 0),
				var_0_17.New(570, 122, 0),
				var_0_17.New(265, 122, 0)
			},
			{
				var_0_17.New(1480, 110, 0),
				var_0_17.New(1180, 110, 0),
				var_0_17.New(790, 110, 0),
				var_0_17.New(680, 75, 0),
				var_0_17.New(560, 45, 0),
				var_0_17.New(560, 45, 0)
			},
			{
				var_0_17.New(1530, 110, 0),
				var_0_17.New(1180, 110, 0),
				var_0_17.New(790, 110, 0),
				var_0_17.New(680, 75, 0),
				var_0_17.New(570, 122, 0),
				var_0_17.New(570, 122, 0)
			}
		}
		var_0_22 = {}
		var_0_23 = {
			fix_end = "end",
			event_fix = "event_fix",
			fix = "fix"
		}
		self._countdown_list = {
			{
				start_time = 0,
				repair_time = 0,
				countdown_state = var_0_26.free,
				character_data = {}
			},
			{
				start_time = 0,
				repair_time = 0,
				countdown_state = var_0_26.free,
				character_data = {}
			},
			{
				start_time = 0,
				repair_time = 0,
				countdown_state = var_0_26.free,
				character_data = {}
			},
			{
				start_time = 0,
				repair_time = 0,
				countdown_state = var_0_26.free,
				character_data = {}
			},
			{
				start_time = 0,
				repair_time = 0,
				countdown_state = var_0_26.free,
				character_data = {}
			},
			{
				start_time = 0,
				repair_time = 0,
				countdown_state = var_0_26.free,
				character_data = {}
			},
			{
				start_time = 0,
				repair_time = 0,
				countdown_state = var_0_26.free,
				character_data = {}
			},
			{
				start_time = 0,
				repair_time = 0,
				countdown_state = var_0_26.free,
				character_data = {}
			},
			{
				start_time = 0,
				repair_time = 0,
				countdown_state = var_0_26.free,
				character_data = {}
			},
			{
				start_time = 0,
				repair_time = 0,
				countdown_state = var_0_26.free,
				character_data = {}
			},
			{
				start_time = 0,
				repair_time = 0,
				countdown_state = var_0_26.free,
				character_data = {}
			},
			{
				start_time = 0,
				repair_time = 0,
				countdown_state = var_0_26.free,
				character_data = {}
			}
		}
		var_0_27 = {}
		var_0_28 = {}
		var_0_29 = {}
		var_0_30 = {}
		var_0_24 = {
			normal = {
				value = 1,
				min = 0.5,
				max = 1
			},
			middle_break = {
				value = 2,
				min = 0.25,
				max = 0.5
			},
			big_break = {
				value = 3,
				min = 0,
				max = 0.25
			}
		}
		var_0_25 = {
			self._control.basket_1,
			self._control.basket_2,
			self._control.basket_3
		}
		self._change_now_room = {
			self._control.now_room.left_btn,
			self._control.now_room.mid_btn,
			self._control.now_room.right_btn
		}

		for iter_76_0, iter_76_1 in pairs(self._change_now_room) do
			iter_76_1.num_img.image.sprite = self:loadSprite((var_0_6("data/ui/common/number_%d.png", iter_76_0)))
			iter_76_1.room_text.text.text = var_0_1:getNowLang("bathroom_title")
		end
	end

	function arg_1_0:_play_audio(arg_77_1)
		self:playBackgroundMusic(arg_77_1)
	end

	function arg_1_0:_play_into_se(arg_78_1)
		self:playSE(arg_78_1, false)
	end

	function arg_1_0:__onReset()
		self._is_already_init = false
		self._countdown_list = {}
		self._my_style_data = {}
		self._now_style_index = nil
		self._spine_index = 0
		self._now_repair_role_index = 0
		self._start_update = false

		self._control.role_list.curtain_spine:SetActive(false)

		self._room_start_pos = nil
		self._room_end_pos = nil
		self._allow_mouse_move = true
		self._invoke_time_btn = true
		self._now_room_num = 1
		self._all_ship_data = {
			one_room = {},
			two_room = {},
			three_room = {}
		}
		self._now_room_style_change = true
		self._now_all_style_list = {}
		self._wait_change_count = 0
		self._now_bathroom_style_index = 1
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_80_0)
	local var_80_0 = var_0_2:class("bathroom")

	var_80_0._enter_panel = nil
	var_80_0._return_param = nil
	var_80_0._is_already_init = false
	var_80_0._start_update = false
	var_80_0._now_repair_role_index = 0
	var_80_0._now_rub_role_index = 0
	var_80_0._countdown_list = {}
	var_80_0._now_basket_count = 0
	var_80_0._my_style_data = {}
	var_80_0._now_style_index = nil
	var_80_0._speed_ratio = 0
	var_80_0._user_data = {}
	var_80_0._is_all_fast_repair = false
	var_80_0._spine_index = 0
	var_80_0._obj_pool = {}
	var_80_0._now_character_time = nil
	var_80_0._room_start_pos = nil
	var_80_0._room_end_pos = nil
	var_80_0._allow_mouse_move = true
	var_80_0._now_room_num = 1
	var_80_0._now_room_style_change = true
	var_80_0._now_all_style_list = {}
	var_80_0._wait_change_count = 0
	var_80_0._now_bathroom_style_index = 1

	gamecore.extend_obj(var_80_0)

	return var_80_0
end

return var_0_0
