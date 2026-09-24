local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = gameconfig.pve_mix_map_config
local var_0_4 = gameconfig.ship_pve_active_config
local var_0_5 = math.abs
local var_0_6 = table.insert
local var_0_7 = table.sort
local var_0_8 = DG.Tweening.DOTween
local var_0_9 = string.format
local var_0_10 = gameenum.common_type
local var_0_11 = gamecore.Language
local var_0_12 = gamecore.user
local var_0_13 = UnityEngine.Vector2
local var_0_14 = UnityEngine.Vector3
local var_0_15 = UnityEngine.Quaternion
local var_0_16 = gamecore.UserDataManager
local var_0_17 = gameconfig.pevent_task_config
local var_0_18 = gameconfig.pve_guide_config
local var_0_19 = gameconfig.pve_mix_level_config
local var_0_20 = gameconfig.ship_cg_config
local var_0_21 = gameconfig.chat_head_config
local var_0_22 = gameconfig.item_config
local var_0_23 = UnityEngine.Input
local var_0_24 = gamecore.util_func
local var_0_25 = UnityEngine.RectTransformUtility
local var_0_26 = gameconfig.ship_rule_config
local var_0_27 = 2
local var_0_28 = 10
local var_0_29 = {
	no_switch = 3,
	left = 1,
	right = 2
}
local var_0_30 = {
	hard = "hard",
	normal = "normal"
}
local var_0_31 = {
	page_end = 6,
	page_first = 1
}
local var_0_32 = {
	id = 0,
	obj = {},
	control = {},
	config = {},
	data = {},
	point_prefab = {},
	line_prefab = {},
	new = function(arg_1_0, arg_1_1)
		arg_1_1 = arg_1_1 or {}

		setmetatable(arg_1_1, arg_1_0)

		arg_1_0.__index = arg_1_0
		arg_1_0.id = 0
		arg_1_0.obj = {}
		arg_1_0.control = {}
		arg_1_0.config = {}
		arg_1_0.data = {}
		arg_1_0.point_prefab = {}
		arg_1_0.line_prefab = {}

		return arg_1_1
	end
}
local var_0_33 = {
	{
		x = -60,
		y = -20
	},
	{
		x = -60,
		y = -100
	},
	{
		x = -130,
		y = -80
	},
	{
		x = -160,
		y = -40
	},
	{
		x = -20,
		y = 50
	},
	{
		x = -100,
		y = 10
	},
	{
		x = -230,
		y = 10
	}
}

gamecore.UILoader:define("mix_main_map", function(arg_2_0)
	function arg_2_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end

		if self:__check_if_static_map() and not self._is_down then
			return
		end

		if self:__check_if_boundary() then
			return
		end

		self:__main_map_update_rotate_func()
		self:__show_point_gradually_func()
	end

	function arg_2_0:__update_cur_transform_rotation()
		if self._cur_transform_rotation and self._cur_transform_rotation == self._control.big_map_bg.transform.eulerAngles.z then
			return
		end

		local var_4_0 = self._control.big_map_bg.transform.eulerAngles.z

		self._cur_transform_rotation = self._control.big_map_bg.transform.eulerAngles.z < 180 and var_4_0 or var_4_0 - 360
	end

	function arg_2_0:__main_map_update_rotate_func()
		if not self._is_down then
			return
		end

		local var_5_1, var_5_2 = var_0_25.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_23.mousePosition, self._ui_camera, nil)

		self._end_pos = var_5_2

		if var_5_1 then
			self._control.big_map_bg.transform:Rotate(0, 0, -(self._end_pos.x - self._start_pos.x) * Time.deltaTime / 2)
			self._control.big_map.transform:Rotate(0, 0, -(self._end_pos.x - self._start_pos.x) * Time.deltaTime / 2)
			self._control.line_root.transform:Rotate(0, 0, -(self._end_pos.x - self._start_pos.x) * Time.deltaTime / 2)
			self._control.point_root.transform:Rotate(0, 0, -(self._end_pos.x - self._start_pos.x) * Time.deltaTime / 2)

			self._start_pos = self._end_pos
			self._end_click_pos = self._end_pos
		end
	end

	function arg_2_0:__check_if_boundary()
		return self._cur_transform_rotation < self._map_rotate_list[self._difficulty][1].angle - var_0_27 and self._cur_rotate_direction == "left" or self._cur_transform_rotation > self._map_rotate_list[self._difficulty][#self._map_rotate_list[self._difficulty]].angle + var_0_27 and self._cur_rotate_direction == "right"
	end

	function arg_2_0:__get_map_switch_angle_and_id()
		if not self._cur_transform_rotation then
			return
		end

		var_0_7(self._map_determine_rotate_list[self._difficulty], function(arg_8_0, arg_8_1)
			return var_0_5(arg_8_0.determine_angle - self._cur_transform_rotation) < var_0_5(arg_8_1.determine_angle - self._cur_transform_rotation)
		end)

		if self._cur_rotate_direction == "left" then
			self._switch_angle = self._map_determine_rotate_list[self._difficulty][1].before_angle
			self._switch_id = self._map_determine_rotate_list[self._difficulty][1].before_id
		elseif self._cur_rotate_direction == "right" then
			self._switch_angle = self._map_determine_rotate_list[self._difficulty][1].next_angle
			self._switch_id = self._map_determine_rotate_list[self._difficulty][1].next_id
		else
			self._switch_angle = nil
			self._switch_id = nil
		end
	end

	function arg_2_0:__show_point_gradually_func()
		local var_9_0 = false
		local var_9_1

		for iter_9_0, iter_9_1 in pairs(self._map_rotate_list) do
			if iter_9_0 == self._difficulty then
				for iter_9_2, iter_9_3 in pairs(iter_9_1) do
					local var_9_2 = var_0_5(self._cur_transform_rotation - iter_9_3.angle)

					if var_9_2 < var_0_28 then
						local var_9_3 = var_0_5(var_0_28 - var_9_2) / var_0_28

						if self._map_detail_data_list[iter_9_3.id].point_prefab.control.activated_point_image.activeSelf then
							if var_0_5(var_9_3 - 1) < 0.1 then
								var_9_0 = true
								show_title_index = iter_9_2
								var_9_1 = self._map_detail_data_list[iter_9_3.id].config.sub_title
							end

							self._map_detail_data_list[iter_9_3.id].point_prefab.control.activated_point_image.canvasGroup.alpha = var_9_3
						end
					else
						self._map_detail_data_list[iter_9_3.id].point_prefab.control.activated_point_image.canvasGroup.alpha = 0
					end
				end
			end
		end

		self:__show_title_obj_func(var_9_0, show_title_index)
		self:__switch_title_image_func()
		self:__set_mix_map_point_item_text(var_9_1)
	end

	function arg_2_0:__show_title_obj_func(arg_10_1, arg_10_2)
		if not arg_10_1 then
			self._control.title_root:SetActive(false)

			return
		else
			self._control.title_root:SetActive(true)

			arg_10_2 = arg_10_2 < 8 and arg_10_2 or arg_10_2 - 7
			self._control.title_root.rectTransform.anchoredPosition = self:__get_real_pos(var_0_33[arg_10_2].x, var_0_33[arg_10_2].y)
		end
	end

	function arg_2_0:__switch_title_image_func()
		self._control.tip_component.image.sprite = self:loadSprite(self._difficulty == var_0_30.normal and var_0_10.seventh_point.tip_component.normal or var_0_10.seventh_point.tip_component.hard)
		self._control.tip_bg.image.sprite = self:loadSprite(nil)
	end

	function arg_2_0:__check_if_switch_map()
		if not self._is_down and self._switch_angle then
			self:__set_map_angle()
			self:__set_cur_map_id(self._switch_id)
			self:__switch_page_btn_active_state()
		end
	end

	function arg_2_0:__page_btn_switch_map_id_func(arg_13_1)
		local var_13_0, var_13_1 = self:__get_cur_difficulty_min_and_max_map_id()
		local var_13_2 = self:__get_cur_map_id()

		if arg_13_1 == var_0_29.left then
			if var_13_0 < var_13_2 then
				self:__set_cur_map_id(var_13_2 - 1)
			end
		elseif arg_13_1 == var_0_29.right and var_13_2 < var_13_1 then
			self:__set_cur_map_id(var_13_2 + 1)
		end

		self:__switch_page_btn_active_state()
	end

	function arg_2_0:__switch_page_btn_active_state()
		local var_14_0, var_14_1 = self:__get_cur_difficulty_min_and_max_map_id()
		local var_14_2 = false
		local var_14_3 = false
		local var_14_4 = self:__get_cur_map_id()

		if var_14_4 == var_14_0 then
			var_14_2 = true
		elseif var_14_4 == var_14_1 then
			var_14_3 = true
		end

		self._control.page_left_btn:SetActive(not var_14_2)
		self._control.page_right_btn:SetActive(not var_14_3)
	end

	function arg_2_0:__page_btn_switch_angle_func()
		self._switch_angle = self:__get_map_angle((self:__get_cur_map_id()))

		self:__set_map_angle(self._switch_angle)
	end

	function arg_2_0:__get_map_angle(arg_16_1)
		for iter_16_0, iter_16_1 in pairs(self._map_rotate_list) do
			for iter_16_2, iter_16_3 in pairs(iter_16_1) do
				if iter_16_3.id == arg_16_1 then
					return iter_16_3.angle
				end
			end
		end
	end

	function arg_2_0:__set_map_angle()
		self._can_mouse_rotate = false

		local var_17_0 = self:autoKillDOTween(var_0_8.Sequence())

		var_0_6(self._angle_seq_list, var_17_0)

		local var_17_1 = 0.1

		if self._cur_transform_rotation and var_0_5(self._cur_transform_rotation - self._switch_angle) > var_0_28 then
			var_17_1 = 0.5
		end

		self._control.big_map_bg.transform:DORotate(var_0_14(0, 0, self._switch_angle), var_17_1)
		self._control.big_map.transform:DORotate(var_0_14(0, 0, self._switch_angle), var_17_1)
		self._control.line_root.transform:DORotate(var_0_14(0, 0, self._switch_angle), var_17_1)
		var_17_0:Append(self._control.point_root.transform:DORotate(var_0_14(0, 0, self._switch_angle), var_17_1))
		var_17_0:AppendInterval(0.05)
		var_17_0:AppendCallback(function()
			self._can_mouse_rotate = true
			self._switch_angle = nil
			self._cur_transform_rotation = nil
			self._can_update = false
		end)
	end

	function arg_2_0:show(arg_19_1, arg_19_2)
		var_0_12:set_seventh_event_activity_id(arg_19_1)
		self:setVisible(true)

		self._pve_active_cfg = var_0_4.find_object_by_id(arg_19_1)
		self._user_data = var_0_12:get_use_info_data()
		self._uiroot_canvas_rect = var_0_24.get_ui_root_canvas_rect()
		self._ui_camera = var_0_24.get_ui_camera()

		self:__init_panel()
		var_0_12:set_to_mix(true)
	end

	function arg_2_0:__init_panel()
		self:_play_audio(var_0_10:get_audio_url(var_0_10.common_icon.music_path, self._pve_active_cfg.bgm), true)
		self:__init_language()
		self:__init_invisible_const()
		self:__update_map_info()
		self:__register_main_map_rotate_event()
		self:__init_map_id_list()
		self:__init_map_detail_data_list()
		self:__init_map_determine_rotate_list()
		self:__set_cur_difficulty_mode()
		self:__update_point_and_line_prefab_state()
		self:__set_cur_difficulty_mode_point()
		self:__switch_main_map_bg_and_page_btn_func()
		self:__init_default_setting()
		self:__check_if_first_in_and_guide()
		self:__init_for_seventh()
	end

	function arg_2_0:__init_language()
		self._control.title.text.text = self._pve_active_cfg.title
		self._control.main_title.text.text = var_0_11:getNowLang("activityinstruction")
		self._control.prev_text.text.text = var_0_11:getNowLang("ui_new_guide_last")
		self._control.next_text.text.text = var_0_11:getNowLang("ui_new_guide_next")
	end

	function arg_2_0:__init_invisible_const()
		self._invisible_const = {
			self._control.return_btn.image,
			self._control.title.text,
			self._control.exploit_bg.image,
			self._control.exploit_btn.image,
			self._control.story_bg.image,
			self._control.story_btn.image,
			self._control.how_bg.image,
			self._control.how_btn.image
		}
	end

	function arg_2_0:__register_main_map_rotate_event()
		self._control.big_map_bg.pointerDownUpEvent.onPointerDown:RemoveAllListeners()
		self._control.big_map_bg.pointerDownUpEvent.onPointerDown:AddListener(function()
			if self._can_mouse_rotate then
				self._is_down = true

				local var_24_1

				var_24_1, self._start_pos = var_0_25.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_23.mousePosition, self._ui_camera, nil)
				self._end_pos = 0
				self._start_click_pos = self._start_pos
			end
		end)
		self._control.big_map_bg.pointerDownUpEvent.onPointerUp:RemoveAllListeners()
		self._control.big_map_bg.pointerDownUpEvent.onPointerUp:AddListener(function()
			self._is_down = false
			self._start_pos = var_0_14(0, 0, 0)
			self._end_pos = var_0_14(0, 0, 0)
			self._cur_rotate_direction = self._end_click_pos.x - self._start_click_pos.x > 20 and "left" or self._end_click_pos.x - self._start_click_pos.x < -20 and "right" or ""

			self:__get_map_switch_angle_and_id()
			self:__check_if_switch_map()

			self._end_click_pos = var_0_14(0, 0, 0)
			self._start_click_pos = var_0_14(0, 0, 0)
		end)
	end

	function arg_2_0:__init_map_id_list()
		self._map_id_list.normal = self._pve_active_cfg.levels
		self._map_id_list.hard = self._pve_active_cfg.hardLevels
	end

	function arg_2_0:__init_map_detail_data_list()
		for iter_27_0, iter_27_1 in pairs(self._map_id_list) do
			for iter_27_2, iter_27_3 in pairs(iter_27_1) do
				local var_27_0 = var_0_32:new()

				var_27_0.id = iter_27_3

				self:__init_map_detail_data_config(var_27_0, iter_27_3)
				self:__init_map_detail_data_point_prefab(var_27_0)
				self:__init_map_detail_data_line_prefab(var_27_0)

				self._map_detail_data_list[iter_27_3] = var_27_0
			end
		end
	end

	function arg_2_0:__init_map_detail_data_config(arg_28_1, arg_28_2)
		local var_28_0 = var_0_3.find_object_by_id(arg_28_2)

		arg_28_1.config = var_28_0

		if var_28_0.difficulty == 0 then
			var_0_6(self._map_rotate_list.normal, {
				id = var_28_0.id,
				angle = var_28_0.angle
			})
		else
			var_0_6(self._map_rotate_list.hard, {
				id = var_28_0.id,
				angle = var_28_0.angle
			})
		end
	end

	function arg_2_0:__init_map_detail_data_point_prefab(arg_29_1)
		local var_29_0, var_29_1 = self:loadUIPrefab("mix_map_point_item", self._control.point_root.transform)

		arg_29_1.point_prefab = {
			obj = var_29_0,
			control = var_29_1
		}

		self:__set_mix_map_point_item_position(arg_29_1)
		self:__set_mix_map_point_item_image(arg_29_1)
		self:__register_point_prefab_button_event(arg_29_1)
	end

	function arg_2_0.__set_mix_map_point_item_position(arg_30_0, arg_30_1)
		arg_30_1.point_prefab.obj._panel:GetComponent("RectTransform").anchoredPosition = var_0_13(0, 0)
		arg_30_1.point_prefab.obj._panel:GetComponent("RectTransform").localRotation = var_0_15.Euler(0, 0, 0)
		arg_30_1.point_prefab.obj._panel:GetComponent("RectTransform").localScale = var_0_14.one
		arg_30_1.point_prefab.control.unactivated_point_image.rectTransform.anchoredPosition = var_0_13(arg_30_1.config.position[1].x, -arg_30_1.config.position[1].y)
		arg_30_1.point_prefab.control.activated_point_image.rectTransform.anchoredPosition = var_0_13(arg_30_1.config.position[2].x, -arg_30_1.config.position[2].y)
	end

	function arg_2_0:__set_mix_map_point_item_image(arg_31_1)
		local var_31_0 = arg_31_1.config.id
		local var_31_1 = arg_31_1.config.difficulty == 0 and var_0_30.normal or var_0_30.hard
		local var_31_2
		local var_31_3

		if var_31_1 == var_0_30.normal then
			var_31_2 = var_0_9(var_0_10.seventh_point.not_activation.normal, var_31_0)
			var_31_3 = var_0_9(var_0_10.seventh_point.activation.normal, var_31_0)
		elseif var_31_1 == var_0_30.hard then
			var_31_2 = var_0_9(var_0_10.seventh_point.not_activation.hard, var_31_0)
			var_31_3 = var_0_9(var_0_10.seventh_point.activation.hard, var_31_0)
		end

		local var_31_4 = arg_31_1.point_prefab.control

		arg_31_1.point_prefab.control.unactivated_point_image.image.sprite = self:loadSprite(var_31_2)
		var_31_4.activated_point_image.image.sprite = self:loadSprite(var_31_3)

		var_31_4.unactivated_point_image.image:SetNativeSize()
		var_31_4.activated_point_image.image:SetNativeSize()
	end

	function arg_2_0:__set_mix_map_point_item_text(arg_32_1)
		self._control.point_title.text.text = arg_32_1
	end

	function arg_2_0:__check_if_static_map()
		self:__update_cur_transform_rotation()

		return not not (self._cur_transform_rotation and self._cur_map_id[self._difficulty] and var_0_5(self._cur_transform_rotation - self:__get_map_angle(self._cur_map_id[self._difficulty])) < 0.1)
	end

	function arg_2_0.__register_point_prefab_button_event(arg_34_0, arg_34_1)
		arg_34_1.point_prefab.control.activated_point_image.button.onClick:RemoveAllListeners()
		arg_34_1.point_prefab.control.activated_point_image.button.onClick:AddListener(function()
			if var_0_5(arg_34_1.point_prefab.control.activated_point_image.canvasGroup.alpha - 1) < 0.5 then
				local var_35_0

				arg_34_0:__click_point_prefab_anim_func(function()
					var_35_0 = var_0_1:createInstance("seven_sea_map")

					var_0_1:__remove_from_showing("mix_main_map")
					var_35_0:show(arg_34_1.id)
					var_35_0:show_self_cover_func(true)

					var_35_0._panel:GetComponent("CanvasGroup").alpha = 0
				end, function()
					var_35_0:show_self_cover_func(false)

					var_35_0._panel:GetComponent("CanvasGroup").alpha = 1

					var_35_0:show_cover_func(false)
					var_0_1:destroyInstance("mix_main_map")
					var_35_0:__enter_animation()
				end, true)
				arg_34_0._control.page_left_btn:SetActive(false)
				arg_34_0._control.page_right_btn:SetActive(false)
				arg_34_0._control.difficulty_mode_btn:SetActive(false)
			end

			arg_34_1.point_prefab.control.activated_point_image.button.onClick:RemoveAllListeners()
		end)
	end

	function arg_2_0:click_point_prefab_anim_func(arg_38_1, arg_38_2, arg_38_3)
		self:__click_point_prefab_anim_func(arg_38_1, arg_38_2, arg_38_3)
	end

	function arg_2_0:__click_point_prefab_anim_func(arg_39_1, arg_39_2, arg_39_3)
		local var_39_0 = arg_39_3 and 0 or 1
		local var_39_1 = arg_39_3 and 1.21 or 1

		local function var_39_2()
			for iter_40_0, iter_40_1 in pairs(self._invisible_const) do
				iter_40_1:DOFade(var_39_0, 0.1)
			end
		end

		if arg_39_3 then
			var_39_2()
		else
			self._panel:GetComponent("Transform").localScale = var_0_14(1.21, 1.21, 1.21)
		end

		local var_39_3 = self:autoKillDOTween(var_0_8.Sequence())

		var_0_6(self._click_point_seq_list, var_39_3)
		var_39_3:Append(self._panel:GetComponent("Transform"):DOScale(1.1, 0.12))
		var_39_3:AppendCallback(function()
			var_39_2()
		end)
		var_39_3:Append(self._panel:GetComponent("Transform"):DOScale(var_39_1, 0.12))
		var_39_3:AppendCallback(function()
			if arg_39_2 then
				arg_39_2()
			end
		end)

		if arg_39_1 then
			arg_39_1()
		end
	end

	function arg_2_0:__init_map_detail_data_line_prefab(arg_43_1)
		if not next(arg_43_1.config.line_position) then
			return
		end

		local var_43_0, var_43_1 = self:loadUIPrefab("mix_map_line_item", self._control.line_root.transform)

		arg_43_1.line_prefab = {
			obj = var_43_0,
			control = var_43_1
		}

		self:__set_mix_map_line_item_position(arg_43_1, arg_43_1.config.line_position)
		self:__set_mix_map_line_item_image(arg_43_1)
	end

	function arg_2_0.__set_mix_map_line_item_position(arg_44_0, arg_44_1, arg_44_2)
		arg_44_1.line_prefab.obj._panel:GetComponent("RectTransform").anchoredPosition = var_0_13(0, 0)
		arg_44_1.line_prefab.obj._panel:GetComponent("RectTransform").localRotation = var_0_15.Euler(0, 0, 0)
		arg_44_1.line_prefab.obj._panel:GetComponent("RectTransform").localScale = var_0_14.one
		arg_44_1.line_prefab.control.line_image.rectTransform.anchoredPosition = var_0_13(arg_44_2.x, -arg_44_2.y)
	end

	function arg_2_0:__set_mix_map_line_item_image(arg_45_1)
		local var_45_0 = arg_45_1.line_prefab.control
		local var_45_1 = arg_45_1.config.id
		local var_45_4 = arg_45_1.config.difficulty == 0 and var_0_30.normal or var_0_30.hard
		local var_45_5

		if var_45_4 == var_0_30.normal then
			var_45_5 = var_0_9(var_0_10.seventh_line.normal, var_45_1 - 1, var_45_1)
		elseif var_45_4 == var_0_30.hard then
			var_45_5 = var_0_9(var_0_10.seventh_line.hard, var_45_1 - 1, var_45_1)
		end

		var_45_0.line_image.image.sprite = self:loadSprite(var_45_5)

		var_45_0.line_image.image:SetNativeSize()
	end

	function arg_2_0:__init_map_determine_rotate_list()
		for iter_46_0, iter_46_1 in pairs(self._map_rotate_list) do
			for iter_46_2 = 1, #iter_46_1 - 1 do
				var_0_6(self._map_determine_rotate_list[iter_46_0], {
					tag = iter_46_1[iter_46_2].id .. "-" .. iter_46_1[iter_46_2 + 1].id,
					determine_angle = (iter_46_1[iter_46_2].angle + iter_46_1[iter_46_2 + 1].angle) / 2,
					before_angle = iter_46_1[iter_46_2].angle,
					next_angle = iter_46_1[iter_46_2 + 1].angle,
					before_id = iter_46_1[iter_46_2].id,
					next_id = iter_46_1[iter_46_2 + 1].id
				})
			end
		end
	end

	function arg_2_0:__set_cur_difficulty_mode()
		local var_47_0 = self:__get_memory_cur_mode()
		local var_47_1 = self:__check_if_open_difficulty_mode()

		if not var_47_1 then
			var_0_12:set_is_cur_seventh_difficulty_mode("normal")
		else
			var_0_12:set_is_cur_seventh_difficulty_mode(var_47_0)
		end

		self._first_pass_map = var_0_12:get_first_pass_seven_map_id()

		if var_47_0 == "" or not var_47_0 then
			::label_47_0::

			local var_47_2

			if not var_47_1 then
				var_47_2 = var_0_30.normal or var_0_30.hard
			end
		end

		self._difficulty = var_47_2

		if self._first_pass_map and self._first_pass_map == self._map_id_list.normal[#self._map_id_list.normal] then
			self._difficulty = "normal"
		end

		self:__switch_difficulty_mode_btn_func(var_47_1)
	end

	function arg_2_0:__set_cur_difficulty_mode_point()
		local var_48_0, var_48_1 = self:__get_memory_difficulty_mode_point()
		local var_48_2, var_48_3 = self:__get_last_pass_point()

		self._cur_map_id[var_0_30.normal] = var_48_0 ~= 0 and var_48_0 or var_48_2
		self._cur_map_id[var_0_30.hard] = var_48_1 ~= 0 and var_48_1 or var_48_3

		self:__set_enter_map_rotation()
		self:__switch_page_btn_active_state()
	end

	function arg_2_0:__get_last_pass_point()
		local var_49_0 = var_0_4.find_object_by_id(var_0_26.find_object_by_id(self._active_id).content.activeId)
		local var_49_1 = var_49_0.map_id
		local var_49_2 = var_49_0.hardLevels[1]

		self._cur_map_id = {
			normal = var_49_0.map_id,
			hard = var_49_0.hardLevels[1]
		}

		local var_49_3 = self:__get_memory_cur_mode()

		for iter_49_0, iter_49_1 in pairs(self._map_id_list) do
			for iter_49_2, iter_49_3 in pairs(iter_49_1) do
				if var_0_12:is_cur_seventh_map_open(iter_49_3) and iter_49_3 ~= var_49_0.map_id + 1 then
					if iter_49_0 == var_0_30.normal then
						var_49_1 = iter_49_3
					else
						var_49_2 = iter_49_3
					end
				end
			end
		end

		return var_49_1, var_49_2
	end

	function arg_2_0:__set_enter_map_rotation()
		local var_50_0 = self:__get_map_angle(self._cur_map_id[self._difficulty])

		self._control.big_map_bg.transform.localRotation = var_0_15.Euler(0, 0, var_50_0)
		self._control.big_map.transform.localRotation = var_0_15.Euler(0, 0, var_50_0)
		self._control.point_root.transform.localRotation = var_0_15.Euler(0, 0, var_50_0)
		self._control.line_root.transform.localRotation = var_0_15.Euler(0, 0, var_50_0)
	end

	function arg_2_0:__check_if_open_difficulty_mode()
		return (var_0_12:is_cur_seventh_map_pass(self._map_id_list.normal[#self._map_id_list.normal]))
	end

	function arg_2_0:__init_default_setting()
		local var_52_0 = self:__get_cur_map_id()

		self._map_detail_data_list[var_52_0].point_prefab.control.activated_point_image.canvasGroup.alpha = 1

		self:__switch_point_and_line_prefab_func()

		local var_52_1

		for iter_52_0, iter_52_1 in pairs(self._map_id_list[self._difficulty]) do
			if iter_52_1 == var_52_0 then
				var_52_1 = iter_52_0
			end
		end

		self:__show_title_obj_func(true, var_52_1)
		self:__switch_title_image_func()
		self:__set_mix_map_point_item_text(self._map_detail_data_list[self._cur_map_id[self._difficulty]].config.sub_title)

		self._map_detail_data_list[var_52_0].point_prefab.control.activated_point_image.canvasGroup.alpha = 1

		self:__update_cur_transform_rotation()
		self:__show_point_gradually_func()
		self:__update_exploit_bg_btn_show()
	end

	function arg_2_0.__update_map_info(arg_53_0)
		arg_53_0._seventh_map_info_list = var_0_12:get_seventh_map_info()
	end

	function arg_2_0:__update_point_and_line_prefab_state()
		local var_54_0 = var_0_4.find_object_by_id(var_0_26.find_object_by_id(self._active_id).content.activeId).map_id

		if not var_0_12:is_cur_seventh_map_open(var_54_0) then
			self._map_detail_data_list[var_54_0].point_prefab.control.activated_point_image:SetActive(true)

			for iter_54_0, iter_54_1 in pairs(self._map_id_list[self._difficulty]) do
				if self._map_detail_data_list[iter_54_1].line_prefab.control then
					self._map_detail_data_list[iter_54_1].line_prefab.control.line_image:SetActive(false)
				end
			end
		else
			for iter_54_2, iter_54_3 in pairs(self._map_id_list[self._difficulty]) do
				self._map_detail_data_list[iter_54_3].point_prefab.control.activated_point_image:SetActive(var_0_12:is_cur_seventh_map_open(iter_54_3))

				if self._map_detail_data_list[iter_54_3].line_prefab.control then
					self._map_detail_data_list[iter_54_3].line_prefab.control.line_image:SetActive(var_0_12:is_cur_seventh_map_open(iter_54_3))
				end
			end
		end
	end

	function arg_2_0:check_if_first_pass_and_switch()
		local var_55_0 = var_0_12:get_first_pass_seven_map_id()

		if var_55_0 ~= 0 and var_55_0 ~= self._map_id_list[var_0_30.hard][#self._map_id_list[var_0_30.hard]] then
			if var_55_0 ~= self._map_id_list[var_0_30.normal][#self._map_id_list[var_0_30.normal]] then
				self:__onClick_button_root_page_right_btn()
			else
				self:__onClick_button_root_difficulty_mode_btn()
			end

			var_0_12:set_first_pass_seven_map_id("0")
		end
	end

	function arg_2_0:__update_exploit_bg_btn_show()
		self._control.exploit_bg:SetActive(self._difficulty == var_0_30.hard)
	end

	function arg_2_0:__get_cur_difficulty_min_and_max_map_id()
		local var_57_0
		local var_57_1

		if self._map_id_list and self._map_id_list[self._difficulty] then
			var_57_0 = self._map_id_list[self._difficulty][1]
			var_57_1 = self._map_id_list[self._difficulty][#self._map_id_list[self._difficulty]]
		end

		return var_57_0, var_57_1
	end

	function arg_2_0:__switch_main_map_bg_and_page_btn_func()
		local var_58_0

		if self._difficulty == var_0_30.normal then
			var_58_0 = var_0_10.seventh_bg.main_bg.normal or var_0_10.seventh_bg.main_bg.hard

			local var_58_1

			if self._difficulty == var_0_30.normal then
				var_58_1 = var_0_10.seventh_bg.main_light.normal or var_0_10.seventh_bg.main_light.hard

				local var_58_2

				if self._difficulty == var_0_30.normal then
					var_58_2 = var_0_10.seventh_bg.main_map.normal or var_0_10.seventh_bg.main_map.hard

					local var_58_3

					if self._difficulty == var_0_30.normal then
						var_58_3 = var_0_10.seventh_bg.main_texture.normal or var_0_10.seventh_bg.main_texture.hard

						local var_58_4

						if self._difficulty == var_0_30.normal then
							var_58_4 = var_0_10.seventh_bg.main_texture2.normal or var_0_10.seventh_bg.main_texture2.hard

							local var_58_5

							if self._difficulty == var_0_30.normal then
								var_58_5 = var_0_10.seventh_page_btn.left.normal or var_0_10.seventh_page_btn.left.hard

								local var_58_6

								if self._difficulty == var_0_30.normal then
									var_58_6 = var_0_10.seventh_page_btn.right.normal or var_0_10.seventh_page_btn.right.hard
								end
							end
						end
					end
				end
			end
		end

		self._control.big_map_bg.image.sprite = self:loadSprite(var_58_0)
		self._control.big_map_light.image.sprite = self:loadSprite(var_58_1)
		self._control.big_map.image.sprite = self:loadSprite(var_58_2)
		self._control.big_map_texture.image.sprite = self:loadSprite(var_58_3)
		self._control.big_map_texture2.image.sprite = self:loadSprite(var_58_4)
		self._control.page_left_btn.image.sprite = self:loadSprite(var_58_5)
		self._control.page_right_btn.image.sprite = self:loadSprite(var_58_6)
	end

	function arg_2_0:__check_if_first_in_and_guide()
		if not var_0_12:get_seventh_guide_state() then
			self._control.instructions:SetActive(true)
			self:__set_instructions_info(1)

			local var_59_0 = var_0_12:get_account_id()
			local var_59_1 = var_0_26.find_object_by_id(26).content.activeId

			var_0_16:setDataByID("seven_memory_cur_modenormal", var_59_0, tostring(var_0_4.find_object_by_id(var_59_1).levels[1]))
			var_0_16:setDataByID("seven_memory_cur_modehard", var_59_0, tostring(var_0_4.find_object_by_id(var_59_1).hardLevels[1]))
			var_0_16:setDataByID("seven_memory_cur_mode", var_59_0, "normal")
			var_0_12:set_is_cur_seventh_difficulty_mode("normal")

			self._control.big_map_bg.transform.localRotation = var_0_15.Euler(0, 0, -50)
			self._control.big_map.transform.localRotation = var_0_15.Euler(0, 0, -50)
			self._control.point_root.transform.localRotation = var_0_15.Euler(0, 0, -50)
			self._control.line_root.transform.localRotation = var_0_15.Euler(0, 0, -50)
		end
	end

	function arg_2_0:__init_for_seventh()
		local var_60_0 = var_0_4.find_object_by_id(var_0_26.find_object_by_id(26).content.activeId).levels

		if not var_0_12:is_cur_seventh_map_pass(var_60_0[#var_60_0]) then
			self._difficulty = "normal"

			self:__switch_main_map_bg_and_page_btn_func()
			self:__switch_point_and_line_prefab_func()
			self:__switch_difficulty_mode_btn_func(false)
			self:__switch_page_btn_active_state()
			self:__update_exploit_bg_btn_show()

			if not var_0_12:is_cur_seventh_map_pass(var_60_0[1]) then
				self._map_detail_data_list[var_60_0[1]].point_prefab.control.activated_point_image:SetActive(true)

				self._map_detail_data_list[var_60_0[1]].point_prefab.control.activated_point_image.canvasGroup.alpha = 1

				for iter_60_0, iter_60_1 in pairs(self._map_id_list[self._difficulty]) do
					if self._map_detail_data_list[iter_60_1].line_prefab.control then
						self._map_detail_data_list[iter_60_1].line_prefab.control.line_image:SetActive(false)
					end
				end
			else
				for iter_60_2, iter_60_3 in pairs(self._map_id_list[self._difficulty]) do
					self._map_detail_data_list[iter_60_3].point_prefab.control.activated_point_image:SetActive(var_0_12:is_cur_seventh_map_open(iter_60_3))

					if self._map_detail_data_list[iter_60_3].line_prefab.control then
						self._map_detail_data_list[iter_60_3].line_prefab.control.line_image:SetActive(var_0_12:is_cur_seventh_map_open(iter_60_3))
					end
				end
			end
		end
	end

	function arg_2_0:__switch_point_and_line_prefab_func()
		for iter_61_0, iter_61_1 in pairs(self._map_id_list) do
			for iter_61_2, iter_61_3 in pairs(iter_61_1) do
				self._map_detail_data_list[iter_61_3].point_prefab.obj:setVisible(iter_61_0 == self._difficulty)

				if self._map_detail_data_list[iter_61_3].line_prefab.obj then
					self._map_detail_data_list[iter_61_3].line_prefab.obj:setVisible(iter_61_0 == self._difficulty)
				end
			end
		end
	end

	function arg_2_0:__switch_difficulty_mode_btn_func(arg_62_1)
		self._control.difficulty_mode_btn:SetActive(arg_62_1)

		self._control.difficulty_mode_btn.image.sprite = self:loadSprite((self._difficulty == var_0_30.normal or nil) and (var_0_10.seventh_difficulty_mode_btn.hard or var_0_10.seventh_difficulty_mode_btn.normal))

		self._control.difficulty_mode_btn.image:SetNativeSize()
	end

	function arg_2_0:__get_cur_map_id()
		return self._cur_map_id[self._difficulty]
	end

	function arg_2_0:__set_cur_map_id(arg_64_1)
		self._cur_map_id[self._difficulty] = arg_64_1

		self:__set_memory_cur_mode_point()
	end

	function arg_2_0:__set_memory_cur_mode()
		var_0_16:setDataByID("seven_memory_cur_mode", var_0_12:get_account_id(), self._difficulty)
		var_0_12:set_is_cur_seventh_difficulty_mode(self._difficulty)
	end

	function arg_2_0.__get_memory_cur_mode(arg_66_0)
		return (var_0_16:getDataByID("seven_memory_cur_mode", (var_0_12:get_account_id())))
	end

	function arg_2_0:__set_memory_cur_mode_point()
		var_0_16:setDataByID("seven_memory_cur_mode" .. self._difficulty, var_0_12:get_account_id(), tostring(self._cur_map_id[self._difficulty]))
	end

	function arg_2_0:__get_memory_difficulty_mode_point()
		local var_68_0 = var_0_12:get_account_id()
		local var_68_1 = tonumber(var_0_16:getDataByID("seven_memory_cur_mode" .. var_0_30.normal, var_68_0))
		local var_68_2 = tonumber(var_0_16:getDataByID("seven_memory_cur_mode" .. var_0_30.hard, var_68_0))
		local var_68_3 = var_0_4.find_object_by_id(var_0_26.find_object_by_id(self._active_id).content.activeId)
		local var_68_6, var_68_7 = self:__get_last_pass_point()

		var_68_1 = not var_0_12:is_cur_seventh_map_activity(var_68_1) and var_68_6 or var_68_1
		var_68_2 = not var_0_12:is_cur_seventh_map_activity(var_68_2) and var_68_7 or var_68_2

		return var_68_1, var_68_2
	end

	function arg_2_0:__show_special_task(arg_69_1)
		self._control.special_task_panel:SetActive(arg_69_1)
		self:_init_special_task_panel_language()

		if not arg_69_1 then
			return
		end

		self._control.coin_num.text.text = self._user_data.exploit

		self:__init_cell()
		self:__update_cell_list()

		self._already_init_special_task = true
	end

	function arg_2_0:_init_special_task_panel_language()
		self._control.special_task_panel.special_task_bg.left.left_title_panel.title_txt.text.text = var_0_11:getNowLang("crrentownstar")
		self._control.task_bg_title_txt.text.text = var_0_11:getNowLang("taskdestitle")
		self._control.task_aim_title_txt.text.text = var_0_11:getNowLang("tasktargettitle")
		self._control.task_reward_title_txt.text.text = var_0_11:getNowLang("taskrewardtitle")
		self._control.task_reward_txt.text.text = var_0_11:getNowLang("taskstar")
	end

	function arg_2_0:__init_cell()
		if self._already_init_special_task then
			return
		end

		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.all_task_content.endlessScrollView, self._control.all_task_content, "single_special_task", "mix_main_map")

		self._reusable_cell:init()
	end

	function arg_2_0:__update_cell_list()
		local var_72_0, var_72_1 = var_0_17.get_sequence()

		self._control.right_title_txt.text.text = var_72_0[1].title
		self._control.task_bg_txt.text.text = var_72_0[1].story
		self._control.task_aim_txt.text.text = var_0_11:convert_rich_text(var_72_0[1].condition_desc)
		self._control.task_reward_num.text.text = "X" .. var_72_0[1].award

		local var_72_2 = var_0_12:get_special_task_by_id(var_72_0[1].cid)

		self._control.task_reward_image:SetActive(var_72_2.state == var_0_10.task_state.complete)
		self._control.task_reward_text:SetActive(var_72_2.state == var_0_10.task_state.complete)
		self._reusable_cell:set_data(var_72_0)

		function self._reusable_cell:_set_func(arg_73_1)
			local var_73_0 = var_0_12:get_special_task_by_id(var_72_0[arg_73_1 + 1].cid)
			local var_73_1 = ""

			if var_73_0.state == var_0_10.task_state.complete then
				self.info_layer.complete_image:SetActive(true)

				var_73_1 = "_complete"
			else
				self.info_layer.complete_image:SetActive(false)
			end

			self.info_layer.bg.image.sprite = self:loadSprite(var_0_9(var_0_10.special_task_bg, var_73_1))
			self.info_layer.map_title_txt.text.text = var_72_0[arg_73_1 + 1].sub_title
			self.info_layer.task_txt.task_txt_1.text.text = var_72_0[arg_73_1 + 1].title

			self.info_layer.task_txt:GetComponent("TextHorizonScroller"):SetText(var_72_0[arg_73_1 + 1].title)
			self.select_layer.takeoff_btn.button.onClick:RemoveAllListeners()
			self.select_layer.takeoff_btn.button.onClick:AddListener(function()
				self._control.right_title_txt.text.text = var_72_0[arg_73_1 + 1].title
				self._control.task_bg_txt.text.text = var_72_0[arg_73_1 + 1].story
				self._control.task_aim_txt.text.text = var_0_11:convert_rich_text(var_72_0[arg_73_1 + 1].condition_desc)
				self._control.task_reward_num.text.text = "X" .. var_72_0[arg_73_1 + 1].award
				var_73_0 = var_0_12:get_special_task_by_id(var_72_0[arg_73_1 + 1].cid)

				self._control.task_reward_image:SetActive(var_73_0.state == var_0_10.task_state.complete)
				self._control.task_reward_text:SetActive(var_73_0.state == var_0_10.task_state.complete)
			end)
		end
	end

	function arg_2_0:__set_instructions_info(arg_75_1)
		arg_75_1 = arg_75_1 or 1

		local var_75_0 = var_0_18.find_object_by_guide_id(self._pve_active_cfg.guide_id * 100 + arg_75_1)
		local var_75_1 = tonumber(var_0_24.utf8sub(var_75_0.pic_id, 2, 2))

		self._control.page_1.text.text = arg_75_1

		self._control.prev:SetActive(arg_75_1 ~= var_0_31.page_first)
		self._control.next:SetActive(arg_75_1 ~= var_0_31.page_end)

		local var_75_2 = app:getSystem():getChannel()

		self._control.main_pic.image.sprite = (var_75_2 == "hm_android_jp" or var_75_2 == "hm_ios_jp") and self:loadSprite(var_0_9(var_0_10.seven_instructions_pic_jp, var_75_1)) or self:loadSprite(var_0_9(var_0_10.seven_instructions_pic, var_75_1))
		self._control.content.txt.text.text = var_0_11:convert_rich_text(var_75_0.desc, true)
	end

	function arg_2_0:__get_real_pos(arg_76_1, arg_76_2, arg_76_3)
		return var_0_13(arg_76_1 / 1280 * self._control.obj_pool_root.rectTransform.rect.width, not arg_76_3 and -1 * arg_76_2 / 960 * self._control.obj_pool_root.rectTransform.rect.height or arg_76_2 / 960 * self._control.obj_pool_root.rectTransform.rect.height)
	end

	function arg_2_0:_play_audio(arg_77_1)
		self:playBackgroundMusic(arg_77_1)
	end

	function arg_2_0:_play_into_se(arg_78_1)
		self:playSE(arg_78_1, false)
	end

	function arg_2_0:show_panel_pass()
		local var_79_0 = var_0_12:get_clear_map_reward()

		if not var_79_0 or not next(var_79_0) then
			return
		else
			var_79_0 = var_79_0[1]
		end

		local var_79_1 = var_0_12:get_battle_info().id
		local var_79_2 = var_79_0.type
		local var_79_3 = var_79_0.id

		var_0_6({}, var_79_0)

		local function var_79_4()
			local var_80_0 = var_0_1:getInstance("mix_main_map")

			if not var_80_0 then
				var_80_0 = var_0_1:createInstance("mix_main_map")

				var_80_0:show((var_0_12:get_seventh_event_activity_id()))
			end

			var_80_0:check_if_first_pass_and_switch()

			if self._first_pass_map == self._map_id_list.normal[#self._map_id_list.normal] then
				self:__onClick_button_root_difficulty_mode_btn()
			end
		end

		self._panel.transform:GetComponent("Canvas").sortingOrder = 500

		local var_79_5 = self:autoKillDOTween(var_0_8.Sequence())

		var_0_6(self._seven_seq_list, var_79_5)

		if var_79_0.type and var_79_0.type ~= nil then
			var_0_1:createInstance("reward_tip"):show_map_pass(var_0_11:getNowLang("ui_activityworldpasstip"), var_0_19.find_object_by_id(var_79_1).sub_title)
			var_79_5:AppendInterval(4.5)
			var_79_5:AppendCallback(function()
				local var_81_0 = var_0_1:createInstance("reward_tip")

				if var_79_2 == var_0_10.reward_type.item then
					local var_81_2 = var_0_22.find_object_by_cid(var_79_3)

					var_81_0:show_map_pass_award(var_0_11:getNowLang("logget"), (var_0_22.find_object_by_cid(var_79_3) and var_0_22.find_object_by_cid(var_79_3).title or " ") .. "*" .. var_79_0.count, true)
				elseif var_79_2 == var_0_10.reward_type.equipment or var_79_2 == var_0_10.reward_type.ship then
					var_0_1:createInstance("new_ship_or_equip"):show(true, var_79_0, var_0_10.enter_get_ship_type.seven_big_map, var_79_4)
				elseif var_79_2 == var_0_10.reward_type.cg then
					var_81_0:show_map_pass_award(var_0_11:getNowLang("logget"), var_0_20.find_object_by_cid(var_79_3).title .. "*" .. var_79_0.count, true)
				elseif var_79_2 == var_0_10.reward_type.head_icon then
					var_81_0:show_by_enter_type(var_0_21.find_object_by_cid(var_79_0.id).icon, var_0_10.enter_get_ship_type.task_award)
				end
			end)
		end

		var_0_12:set_clear_map_reward(nil)
	end

	function arg_2_0:__finish_special_task(arg_82_1)
		if not next(arg_82_1) then
			return
		end

		self._task_num = 0
		self._task_info = {}

		for iter_82_0, iter_82_1 in pairs(arg_82_1) do
			var_0_6(self._task_info, iter_82_0)

			self._task_num = self._task_num + 1
		end

		local var_82_0 = self:autoKillDOTween(var_0_8.Sequence())

		if self._task_num > 1 then
			local var_82_1 = self._control.msg_panel.finish_special_mission

			var_82_0:AppendCallback(function()
				self:set_finish_task(self._task_info, 1, var_82_1)
			end)
			var_82_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
			var_82_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
			self._control.msg_panel.finish_special_mission_btn:SetActive(true)
		else
			for iter_82_2, iter_82_3 in pairs(self._task_info) do
				local var_82_2 = self._control.msg_panel.finish_special_mission

				var_82_0:AppendCallback(function()
					self:set_finish_task(self._task_info, iter_82_2, var_82_2)
				end)
				var_82_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
				var_82_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				self._control.msg_panel.finish_special_mission_btn:SetActive(true)
			end
		end

		var_0_12:clear_open_seven_panel()
	end

	function arg_2_0.set_finish_task(arg_85_0, arg_85_1, arg_85_2, arg_85_3)
		local var_85_0 = var_0_17.find_object_by_cid(arg_85_1[arg_85_2])

		arg_85_3:SetActive(true)

		arg_85_3.map_title.text.text = var_85_0.sub_title
		arg_85_3.task_title.text.text = var_85_0.title
		arg_85_3.coin_num.text.text = var_85_0.award
	end

	function arg_2_0:__onReset()
		self:__initia_lize()
		self:destroyChildren("mix_map_line_item")
		self:destroyChildren("mix_map_point_item")

		for iter_86_0, iter_86_1 in ipairs(self._finish_special_seq_list) do
			iter_86_1:Kill()
		end

		for iter_86_2, iter_86_3 in ipairs(self._click_point_seq_list) do
			iter_86_3:Kill()
		end

		for iter_86_4, iter_86_5 in ipairs(self._angle_seq_list) do
			iter_86_5:Kill()
		end

		for iter_86_6, iter_86_7 in ipairs(self._seven_seq_list) do
			iter_86_7:Kill()
		end

		self._seven_seq_list = {}
		self._finish_special_seq_list = {}
		self._click_point_seq_list = {}
		self._angle_seq_list = {}
	end

	function arg_2_0.__initia_lize(arg_87_0)
		arg_87_0._pve_active_cfg = {}
		arg_87_0._map_detail_data_list = {}
		arg_87_0._map_id_list = {
			normal = {},
			hard = {}
		}
		arg_87_0._map_rotate_list = {
			normal = {},
			hard = {}
		}
		arg_87_0._map_determine_rotate_list = {
			normal = {},
			hard = {}
		}
		arg_87_0._cur_map_id = {
			hard = 9221,
			normal = 9215
		}
		arg_87_0._cur_rotate_direction = ""
		arg_87_0._cur_transform_rotation = nil
		arg_87_0._difficulty = var_0_30.normal
		arg_87_0._switch_angle = nil
		arg_87_0._switch_id = nil
		arg_87_0._seventh_map_info_list = {}
		arg_87_0._already_init_special_task = false
		arg_87_0._reusable_cell = nil
		arg_87_0._page_move = 1
		arg_87_0._can_mouse_rotate = true
		arg_87_0._start_pos = var_0_14(0, 0, 0)
		arg_87_0._end_pos = var_0_14(0, 0, 0)
		arg_87_0._start_click_pos = var_0_14(0, 0, 0)
		arg_87_0._end_click_pos = var_0_14(0, 0, 0)
		arg_87_0._uiroot_canvas_rect = nil
		arg_87_0._ui_camera = nil
		arg_87_0._invisible_const = {}
		arg_87_0._seven_seq_list = {}
		arg_87_0._finish_special_seq_list = {}
		arg_87_0._click_point_seq_list = {}
		arg_87_0._angle_seq_list = {}
		arg_87_0._active_id = 26
	end

	gamecore.extend_method(arg_2_0)
end)

function var_0_0.create(arg_88_0)
	local var_88_0 = var_0_1:class("mix_main_map")

	var_88_0:__initia_lize()

	return var_88_0
end

return var_0_0
