local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = string.format
local var_0_3 = UnityEngine.Vector2
local var_0_4 = UnityEngine.Vector3
local var_0_5 = UnityEngine.Color
local var_0_6 = gameenum.common_type
local var_0_8 = DG.Tweening.DOTween
local var_0_9 = lan_rand
local var_0_10 = table.insert
local var_0_11 = gamecore.dormitory_idea
local var_0_12 = gamecore.user
local var_0_13 = gamecore.util_func
local var_0_14 = UnityEngine.Input
local var_0_15 = UnityEngine.RectTransformUtility

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:add_ckick_event(arg_2_1, arg_2_2)
		if arg_2_1 == var_0_6.dormitory_special_furniture_id.farm_well then
			self:__add_ckick_event_for_296(arg_2_2)
		elseif arg_2_1 == var_0_6.dormitory_special_furniture_id.chariot then
			self:__add_ckick_event_for_galo_car(arg_2_2)
		elseif arg_2_1 == var_0_6.dormitory_special_furniture_id.veneto then
			self:__add_ckick_event_for_307(arg_2_2)
		elseif arg_2_1 == var_0_6.dormitory_special_furniture_id.dry_land then
			self:__add_ckick_event_for_298(arg_2_2)
		elseif arg_2_1 == var_0_6.dormitory_special_furniture_id.albatross then
			self:__add_click_event_for_254(arg_2_2)
		elseif arg_2_1 == var_0_6.dormitory_special_furniture_id.ugly_wall then
			self:__add_click_event_for_316(arg_2_2)
		elseif arg_2_1 == var_0_6.dormitory_special_furniture_id.tennis then
			self:__add_click_event_for_315(arg_2_2)
		elseif arg_2_1 == var_0_6.dormitory_special_furniture_id.galo or arg_2_1 == var_0_6.dormitory_special_furniture_id.ghost_galo then
			self:__add_click_event_for_250(arg_2_2)
		elseif arg_2_1 == var_0_6.furniture_action_id.warwolf_3 or arg_2_1 == var_0_6.furniture_action_id.pet_chick then
			self:__add_click_event_for_245(arg_2_2)
		elseif arg_2_1 == var_0_6.furniture_action_id.william_cat then
			self:__add_click_event_for_246(arg_2_2)
		elseif arg_2_1 == var_0_6.dormitory_special_furniture_id.holograpgic_projection_device then
			self:__add_click_event_for_holograpgic_projection_device(arg_2_2)
		elseif arg_2_1 == var_0_6.dormitory_special_furniture_id.stare then
			self:__add_click_event_for_stare(arg_2_2)
		elseif arg_2_1 == var_0_6.dormitory_special_furniture_id.hight_screen_TV then
			self:__add_click_event_for_hight_screen_TV(arg_2_2)
		end
	end

	function arg_1_0:set_special_furniture_event(arg_3_1)
		if not self._is_aleady_set and arg_3_1 == var_0_6.dormitory_special_furniture_id.cake_display_case then
			self._is_aleady_set = true

			self:__add_click_event_for_cake_display_case()
		end
	end

	function arg_1_0:add_ai_data(arg_4_1)
		self:autoKillDOTween(var_0_8.Sequence()):AppendCallback(function()
			self:__get_ai_func()
		end)
	end

	function arg_1_0:add_now_time(arg_6_1)
		local var_6_2

		if self._config.cid == var_0_6.dormitory_special_furniture_id.owl_clock then
			var_6_2 = self:loadSprite(var_0_2(var_0_6.dormitory_const.furniture_sprite_path, self._config.icon .. "_s", self._config.icon, "_s"))
		end

		local var_6_3 = self:loadSprite(var_0_2(var_0_6.dormitory_const.furniture_sprite_path, self._config.icon .. "_h", self._config.icon, "_h"))
		local var_6_4 = self:loadSprite(var_0_2(var_0_6.dormitory_const.furniture_sprite_path, self._config.icon .. "_m", self._config.icon, "_m"))

		if var_6_3 then
			self._control.sort_layer.spine.hand_h:SetActive(true)

			self._control.sort_layer.spine.hand_h.image.sprite = var_6_3

			self._control.sort_layer.spine.hand_h.image:SetNativeSize()
		end

		if var_6_4 then
			self._control.sort_layer.spine.hand_m:SetActive(true)

			self._control.sort_layer.spine.hand_m.image.sprite = var_6_4

			self._control.sort_layer.spine.hand_m.image:SetNativeSize()
		end

		if var_6_2 then
			self._control.sort_layer.spine.hand_s:SetActive(true)

			self._control.sort_layer.spine.hand_s.image.sprite = var_6_2

			self._control.sort_layer.spine.hand_s.image:SetNativeSize()

			self.is_have_s = true
		end

		if self._config.cid == var_0_6.dormitory_special_furniture_id.european_wooden_clock then
			self._control.sort_layer.spine.hand_h.rectTransform.anchoredPosition = var_0_3(0, 43)
			self._control.sort_layer.spine.hand_m.rectTransform.anchoredPosition = var_0_3(0, 43)
		end

		if self._config.cid == var_0_6.dormitory_special_furniture_id.wall_mounted_clock_1 then
			self._control.sort_layer.spine.hand_h.rectTransform.pivot = var_0_3(0.495, 0.488)
			self._control.sort_layer.spine.hand_m.rectTransform.pivot = var_0_3(0.495, 0.47)
			self._control.sort_layer.spine.hand_h.rectTransform.anchoredPosition = var_0_3(0.4, -17)
			self._control.sort_layer.spine.hand_m.rectTransform.anchoredPosition = var_0_3(0.3, -17.3)
		end

		if self._config.cid == var_0_6.dormitory_special_furniture_id.orange_clock then
			self._control.sort_layer.spine.hand_h.rectTransform.pivot = var_0_3(0.5, 0.53)
			self._control.sort_layer.spine.hand_m.rectTransform.pivot = var_0_3(0.5, 0.496)
			self._control.sort_layer.spine.hand_h.rectTransform.anchoredPosition = var_0_3(0, -19.2)
			self._control.sort_layer.spine.hand_m.rectTransform.anchoredPosition = var_0_3(0, -19.45)
		end

		if self._config.cid == var_0_6.dormitory_special_furniture_id.little_qutie_clock then
			self._control.sort_layer.spine.hand_h.rectTransform.pivot = var_0_3(0.5, 0.53)
			self._control.sort_layer.spine.hand_m.rectTransform.pivot = var_0_3(0.5, 0.5)
			self._control.sort_layer.spine.hand_h.rectTransform.anchoredPosition = var_0_3(0.5, -20.6)
			self._control.sort_layer.spine.hand_m.rectTransform.anchoredPosition = var_0_3(0.2, -20.6)
		end

		if self._config.cid == var_0_6.dormitory_special_furniture_id.owl_clock then
			self._control.sort_layer.spine.hand_h.rectTransform.pivot = var_0_3(0.5, 0.55)
			self._control.sort_layer.spine.hand_m.rectTransform.pivot = var_0_3(0.5, 0.56)
			self._control.sort_layer.spine.hand_s.rectTransform.pivot = var_0_3(0.5, 0.51)
			self._control.sort_layer.spine.hand_h.rectTransform.anchoredPosition = var_0_3(0, -15)
			self._control.sort_layer.spine.hand_m.rectTransform.anchoredPosition = var_0_3(0, -15)
			self._control.sort_layer.spine.hand_s.rectTransform.anchoredPosition = var_0_3(0, -15)
		end
	end

	function arg_1_0:countdown_time(arg_7_1)
		self._tennis_time = self._tennis_time or arg_7_1 + 833

		local var_7_0 = self._tennis_time - arg_7_1

		if self._tennis_time - arg_7_1 <= 400 and var_7_0 > 0 then
			if self._spine.canvasGroup.interactable == false then
				self:__set_canvas_group(self._spine, true)
			end
		elseif var_7_0 <= 0 then
			self:__set_canvas_group(self._spine, false)

			self._start_tennis_timer = false

			if self._tennis_over then
				self:__tennis_result()
			end
		end
	end

	function arg_1_0:set_bg_spine()
		if self._config.cid == var_0_6.dormitory_special_furniture_id.paris_wall then
			self:__set_bg_spine_of_1029()
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.mountains_wall or self._config.cid == var_0_6.dormitory_special_furniture_id.welcoming or self._config.cid == var_0_6.dormitory_special_furniture_id.water_park or self._config.cid == var_0_6.dormitory_special_furniture_id.sense_of_autumn or self._config.cid == var_0_6.dormitory_special_furniture_id.kingdom_of_eternity then
			self:__set_bg_spine_of_1021()
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.flowing_feast then
			self:__set_bg_spine_of_1018()
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.firefly_street or self._config.cid == var_0_6.dormitory_special_furniture_id.hot_blooded_final then
			self._control.sort_layer.spine.transform:SetAsFirstSibling()
			self:__set_bg_spine_of_1021()
		end
	end

	function arg_1_0:set_common_spine()
		if self._config.cid == var_0_6.dormitory_special_furniture_id.beautiful_vines then
			self._control.sort_layer.spine.transform.anchoredPosition = var_0_3(640, 360)

			self._control.sort_layer.img.image:SetNativeSize()

			self._control.sort_layer.img.rectTransform.sizeDelta = var_0_3(self._sprite_size.x * 1.25, self._sprite_size.y * 1.15)
			self._control.sort_layer.spine.transform.localScale = var_0_4(1.25, 1.15, 1)

			if not self._beautiful_vines_mask then
				local var_9_0 = UnityEngine.Object.Instantiate(self._control.sort_layer2.img.gameObject, self._control.sort_layer.transform, false)

				var_9_0.transform:SetAsFirstSibling()

				var_9_0.transform.anchoredPosition = self._control.sort_layer.img.transform.anchoredPosition
				var_9_0.transform.gameObject:GetComponent("RectTransform").sizeDelta = self._control.sort_layer.img.rectTransform.sizeDelta
				var_9_0.transform.localScale = self._control.sort_layer.img.transform.localScale
				var_9_0.transform.gameObject:GetComponent("Image").color = var_0_5(0.549, 0.686, 0.302, 0.588)
				self._beautiful_vines_mask = var_9_0
			end
		end
	end

	function arg_1_0:adjust_furniture_pos()
		if self._config.cid == var_0_6.dormitory_special_furniture_id.asura_chariot then
			self._control.sort_layer2.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(13, 13)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.old_bike then
			self._control.sort_layer2.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-10, 0)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.mini_rowing then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(3, 22.3)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.farm_well then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(17, -21.5)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.scarecrow then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(15.5, -7.5)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.veneto then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(0, 5)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.tennis then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-1, 14)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.ugly_wall then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(0, 2)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.crab_chef then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(0, 10)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.candlelight_dinner then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(1, 0)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.monstera_deliciosa then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-6, 0.5)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.street_light then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(0, 7)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.splendid_house then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(0, 5)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.sweet_potato then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-1.5, -16)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.star_light_tarot then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-1, 5)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.petri_dish then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-2, 3)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.blue_ghost then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(1, 1.5)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.white_window then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(4, 4)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.blue_hook_lock then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-1, 8)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.imulation_table then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(0, 6.5)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.gas_stove then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-1, 1.5)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.wheel_chair then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(1, 3)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.baby_hook then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-1, 3)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.hot_pot then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-0.5, 5)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.video_game then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-3, 6.5)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.mini_track_boat_race then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(2, 6.5)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.duel_disk then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-2.5, 7.5)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.stare then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(1.5, 0)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.galo_radio then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-2, -3)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.cake_display_case then
			self._control.sort_layer.spine.transform:SetAsFirstSibling()
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.water_slide then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-2, 10)
			self._control.sort_layer2.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-2, 10)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.harvester then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(4, -4)
			self._control.sort_layer2.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(4, -4)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.model_assembly_platform or self._config.cid == var_0_6.dormitory_special_furniture_id.painting_table then
			self._control.sort_layer.img.canvasGroup.alpha = 1
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(0, 200)

			self:open_spine(false)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.tree_swing then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(-2, 0)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.summer_memo then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(0, -13)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.dry_land then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(0, -35)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.beautiful_vines then
			self._control.sort_layer.spine.rectTransform.anchoredPosition = var_0_3(640, 360)
			self._control.sort_layer.img.transform.anchoredPosition = var_0_3(640, 230)
		end
	end

	function arg_1_0:set_furniture_spine_postion(arg_11_1, arg_11_2)
		self._control.sort_layer2.spine.rectTransform.anchoredPosition = var_0_3(arg_11_1, arg_11_2)
		self._furniture_btn_orgin_pos._panel.transform.anchoredPosition = var_0_3(arg_11_1, arg_11_2 - 32.5)
	end

	function arg_1_0:get_furniture_spine_postion()
		return self._control.sort_layer2.spine.rectTransform.anchoredPosition
	end

	function arg_1_0.record_orgin_position(arg_13_0, arg_13_1)
		arg_13_0._furniture_orgin_pos = arg_13_1
	end

	function arg_1_0.__set_canvas_group(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1.canvasGroup.interactable = arg_14_2
		arg_14_1.canvasGroup.blocksRaycasts = arg_14_2
	end

	function arg_1_0.__set_rect_transform(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_15_1:GetComponent("RectTransform")

		if arg_15_2.pivot_x then
			var_15_0.pivot = var_0_3(arg_15_2.pivot_x, arg_15_2.pivot_y)
		end

		if arg_15_2.width then
			var_15_0.sizeDelta = var_0_3(arg_15_2.width, arg_15_2.height)
		end

		if arg_15_2.pos_x then
			var_15_0.anchoredPosition = var_0_3(arg_15_2.pos_x, arg_15_2.pos_y)
		end
	end

	function arg_1_0.__set_skeleton_graphic_spine(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		if arg_16_1 and not arg_16_1:Equals(nil) then
			arg_16_1:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:SetAnimation(arg_16_2, arg_16_3, arg_16_4)
		end
	end

	function arg_1_0:_add_seq_SkeletonGraphic_data(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6, arg_17_7, arg_17_8, arg_17_9)
		if self._acting then
			return
		end

		if arg_17_3 then
			arg_17_2:AppendCallback(function()
				self:__set_skeleton_graphic_spine(arg_17_1, 0, arg_17_3, false)

				self._is_click = false
				self._is_walk = false
				self._is_quick_walk = false
			end)
			arg_17_2:AppendInterval(arg_17_7)
		end

		for iter_17_0 = 1, arg_17_6 do
			arg_17_2:AppendCallback(function()
				self._is_walk = false

				self:__set_skeleton_graphic_spine(arg_17_1, 0, arg_17_4, false)

				if self._is_click == true then
					self._is_click = false
				end

				if arg_17_4 == "walk_slow" or arg_17_4 == "walk_quick" or arg_17_4 == "fly" then
					self._is_walk = true
				end
			end)

			if self._acting then
				return
			end

			arg_17_2:AppendInterval(arg_17_8)

			if iter_17_0 == arg_17_6 and arg_17_5 == nil then
				arg_17_2:AppendCallback(function()
					if self._acting == false then
						self:__get_ai_func()
					end
				end)
			end
		end

		if self._acting then
			return
		end

		if arg_17_5 then
			arg_17_2:AppendCallback(function()
				self._is_walk = false
				self._is_quick_walk = false

				self:__set_skeleton_graphic_spine(arg_17_1, 0, arg_17_5, false)
			end)
			arg_17_2:AppendInterval(arg_17_9)
			arg_17_2:AppendCallback(function()
				if self._acting == false then
					self:__get_ai_func()
				end
			end)
		end

		self:__insert_seq_list(arg_17_2)
	end

	function arg_1_0.__loop_play_seq(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6, arg_23_7)
		for iter_23_0 = 1, arg_23_6 do
			arg_23_1:AppendCallback(function()
				if arg_23_0.__set_skeleton_graphic_spine then
					arg_23_0:__set_skeleton_graphic_spine(arg_23_2, 0, arg_23_3, arg_23_5)
				end
			end)
			arg_23_1:AppendInterval(arg_23_4)
		end

		if arg_23_7 then
			arg_23_1:AppendCallback(function()
				arg_23_1:Kill()

				if arg_23_0.add_self_loop_anim then
					arg_23_0:add_self_loop_anim()
				end
			end)
		end
	end

	function arg_1_0.__set_skeleton_graphic_skin(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = arg_26_1:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

		var_26_0.initialSkinName = arg_26_2

		var_26_0:Initialize(true)
	end

	function arg_1_0:__reset_seq_list()
		for iter_27_0, iter_27_1 in pairs(self._furniture_seq_click_list) do
			iter_27_1:Kill()
		end

		for iter_27_2, iter_27_3 in pairs(self._farmland_furniture_seq_click_list) do
			iter_27_3.seq:Kill()
		end

		self._furniture_seq_click_list = {}
	end

	function arg_1_0:__insert_seq_list(arg_28_1)
		var_0_10(self._furniture_seq_click_list, arg_28_1)
	end

	function arg_1_0:__get_ai_func()
		if self._config.cid == var_0_6.dormitory_special_furniture_id.albatross then
			self:__add_ai_for_254()
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.galo or self._config.cid == var_0_6.dormitory_special_furniture_id.ghost_galo then
			self:__add_ai_for_250()
		elseif self._config.action_id[1] == var_0_6.furniture_action_id.warwolf_3 or self._config.action_id[1] == var_0_6.furniture_action_id.pet_chick then
			self:__add_ai_for_245()
		elseif self._config.action_id[1] == var_0_6.furniture_action_id.william_cat then
			self:__add_ai_for_246()
		end
	end

	function arg_1_0:__add_ckick_event_for_296(arg_30_1)
		local var_30_0 = self._spine

		self._spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._spine:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self:__set_canvas_group(self._spine, true)
		self:__set_rect_transform(self._spine, arg_30_1[1])
		self._spine:GetComponent("Button").onClick:RemoveAllListeners()
		self._spine:GetComponent("Button").onClick:AddListener(function()
			self:__reset_seq_list()
			var_30_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).Skeleton:SetToSetupPose()
			var_30_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:ClearTracks()

			local var_31_0 = self:autoKillDOTween(var_0_8.Sequence())

			var_31_0:AppendCallback(function()
				self:__set_skeleton_graphic_spine(var_30_0, 0, "touch", false)
			end)
			var_31_0:AppendInterval(2.667)
			var_31_0:AppendCallback(function()
				self:__set_skeleton_graphic_spine(var_30_0, 0, "normal", true)
			end)
			var_31_0:Play()
			self:__insert_seq_list(var_31_0)
		end)
	end

	function arg_1_0:__add_ckick_event_for_307(arg_34_1)
		local var_34_0 = self._spine

		self._spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._spine:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self:__set_canvas_group(self._spine, true)
		self:__set_rect_transform(self._spine, arg_34_1[1])
		self._spine:GetComponent("Button").onClick:RemoveAllListeners()
		self._spine:GetComponent("Button").onClick:AddListener(function()
			if self.can_click_veneto == false then
				return
			end

			self:__reset_seq_list()
			var_34_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).Skeleton:SetToSetupPose()
			var_34_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:ClearTracks()

			local var_35_0 = self:autoKillDOTween(var_0_8.Sequence())

			var_35_0:AppendCallback(function()
				self:__set_skeleton_graphic_spine(var_34_0, 0, "suprise", false)
			end)
			var_35_0:AppendInterval(1)
			var_35_0:AppendCallback(function()
				self:__set_skeleton_graphic_spine(var_34_0, 0, "stand", true)
			end)
			var_35_0:Play()
			self:__insert_seq_list(var_35_0)
		end)
	end

	function arg_1_0:__add_ckick_event_for_galo_car(arg_38_1)
		local var_38_0 = self._spine

		self._spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._spine:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self:__set_canvas_group(self._spine, true)
		self:__set_rect_transform(self._spine, arg_38_1[1])
		self._spine:GetComponent("Button").onClick:RemoveAllListeners()
		self._spine:GetComponent("Button").onClick:AddListener(function()
			var_0_11:dormitory_idea_manager_get_galo_car_state(self._data.id, function()
				self:__reset_seq_list()
				var_38_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).Skeleton:SetToSetupPose()
				var_38_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:ClearTracks()

				local var_40_0 = self:autoKillDOTween(var_0_8.Sequence())

				var_40_0:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_38_0, 0, "open", false)
				end)
				var_40_0:AppendInterval(2)
				var_40_0:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_38_0, 0, "attack", false)
				end)
				var_40_0:AppendInterval(2)
				var_40_0:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_38_0, 0, "normal", true)
				end)
				var_40_0:Play()
				self:__insert_seq_list(var_40_0)
			end)
		end)
	end

	function arg_1_0:__add_click_event_for_254(arg_44_1)
		local var_44_0 = self._spine

		self._spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._spine:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self:__set_canvas_group(self._spine, true)
		self:__set_rect_transform(self._spine, arg_44_1[1])
		self._spine:GetComponent("Button").onClick:RemoveAllListeners()
		self._spine:GetComponent("Button").onClick:AddListener(function()
			self._is_click = false

			self:__reset_seq_list()
			var_44_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).Skeleton:SetToSetupPose()
			var_44_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:ClearTracks()

			local var_45_0 = self:autoKillDOTween(var_0_8.Sequence())

			if self._is_click == false then
				var_45_0:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_44_0, 0, "suprise", false)

					self._is_click = true
					self._is_walk = false
				end)
				var_45_0:AppendInterval(1)
				var_45_0:AppendCallback(function()
					self._random_walk = true

					if self._acting == false then
						self:__add_ai_for_254()
					end
				end)
			else
				var_45_0:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_44_0, 0, "stand", true)

					self._is_click = false
					self._is_walk = false
				end)
			end

			var_45_0:Play()
			self:__insert_seq_list(var_45_0)
		end)
	end

	function arg_1_0:__add_ai_for_254()
		spine = self._spine

		self:__reset_seq_list()

		local var_49_0 = self:autoKillDOTween(var_0_8.Sequence())
		local var_49_1
		local var_49_2
		local var_49_3
		local var_49_4 = 0
		local var_49_5 = 0
		local var_49_6 = 0
		local var_49_7 = 0
		local var_49_8 = var_0_9(1, 19)

		if var_49_8 > 0 and var_49_8 <= 10 then
			var_49_2 = "event_walk_slow"
			var_49_1 = "walk_slow"
			var_49_4 = var_0_9(1, 5)
			var_49_5 = 0.5
			var_49_6 = 1
			var_49_7 = 0
		elseif var_49_8 > 10 and var_49_8 <= 11 then
			var_49_2 = "event_sleep"
			var_49_1 = "sleep"
			var_49_3 = "event_sleep_end"
			var_49_4 = var_0_9(1, 3)
			var_49_5 = 0.667
			var_49_6 = 2
			var_49_7 = 0.667
		elseif var_49_8 > 11 and var_49_8 <= 12 then
			var_49_2 = "event_walk_quick"
			var_49_1 = "walk_quick"
			var_49_4 = var_0_9(1, 2)
			var_49_5 = 0.333
			var_49_6 = 0.5
			var_49_7 = 0
		elseif var_49_8 > 12 and var_49_8 <= 16 then
			var_49_2 = "event_fly"
			var_49_1 = "fly"
			var_49_3 = "event_fly_end"
			var_49_4 = var_0_9(1, 3)
			var_49_5 = 1
			var_49_6 = 1.6
			var_49_7 = 1
		elseif var_49_8 > 16 and var_49_8 <= 18 then
			var_49_1 = "stand"
			var_49_4 = var_0_9(1, 2)
			var_49_5 = 0
			var_49_6 = 1
			var_49_7 = 0
		elseif var_49_8 > 18 and var_49_8 <= 19 then
			var_49_1 = "SP"
			var_49_4 = var_0_9(1, 1)
			var_49_5 = 0
			var_49_6 = 4
			var_49_7 = 0
		end

		self:_add_seq_SkeletonGraphic_data(spine, var_49_0, var_49_2, var_49_1, var_49_3, var_49_4, var_49_5, var_49_6, var_49_7)
		var_49_0:Play()
		self:__insert_seq_list(var_49_0)
	end

	function arg_1_0:__add_ckick_event_for_298(arg_50_1)
		self._dry_land_data = {}

		self:__set_canvas_group(self._spine, true)

		self._spine.canvasGroup.alpha = 1

		self:__reset_seq_list()
		self:__init_spine_for_298()
	end

	function arg_1_0:__init_spine_for_298()
		local var_51_0 = {
			"A",
			"B",
			"C",
			"D",
			"E"
		}
		local var_51_1 = {
			normal2 = "normal2",
			touch = "touch",
			normal1 = "normal"
		}
		local var_51_2 = {
			skin_4 = "4",
			skin_1 = "1",
			skin_def = "default",
			skin_2 = "2",
			skin_3 = "3"
		}

		for iter_51_0, iter_51_1 in ipairs({
			{
				height = 20,
				pos_x = -35,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = 0
			},
			{
				height = 20,
				pos_x = 49,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = 0
			},
			{
				height = 20,
				pos_x = 90,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = 0
			},
			{
				height = 20,
				pos_x = 133,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = 0
			},
			{
				height = 20,
				pos_x = -41,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -22
			},
			{
				height = 20,
				pos_x = 4,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -22
			},
			{
				height = 20,
				pos_x = 49,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -22
			},
			{
				height = 20,
				pos_x = 94,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -22
			},
			{
				height = 20,
				pos_x = 139,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -22
			},
			{
				height = 20,
				pos_x = -50,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -48
			},
			{
				height = 20,
				pos_x = 0,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -48
			},
			{
				height = 20,
				pos_x = 49,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -48
			},
			{
				height = 20,
				pos_x = 97,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -48
			},
			{
				height = 20,
				pos_x = 147,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -48
			},
			{
				height = 20,
				pos_x = -55,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -74
			},
			{
				height = 20,
				pos_x = -3,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -74
			},
			{
				height = 20,
				pos_x = 49,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -74
			},
			{
				height = 20,
				pos_x = 102,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -74
			},
			{
				height = 20,
				pos_x = 155,
				pivot_x = 0.5,
				pivot_y = 0.5,
				width = 38,
				pos_y = -74
			}
		}) do
			local var_51_3 = UnityEngine.Object.Instantiate(self._control.sort_layer2.spine.gameObject, self._spine.transform, false)

			var_51_3.transform.localScale = var_0_4.one

			var_51_3.transform:SetSiblingIndex(iter_51_0)
			self:__set_rect_transform(var_51_3.transform, iter_51_1)

			local var_51_4 = var_0_9(1, 4)
			local var_51_5 = self:get_graphic(var_51_3, (self:loadSkeletonDataAsset(var_0_2(var_0_6.dormitory_const.furniture_spine_path, self._config.icon .. var_51_0[var_51_4]))))

			var_51_5.material = self:loadMaterial(var_0_2(var_0_6.dormitory_const.furniture_spine_mat_path, self._config.icon .. var_51_0[var_51_4]))

			self:__set_skeleton_graphic_skin(var_51_3, var_51_2.skin_def)
			var_51_5.AnimationState:ClearTracks()

			local var_51_6 = var_51_3:GetComponent(typeof(UnityEngine.CanvasGroup))

			var_51_6.alpha = 1
			var_51_6.interactable = true
			var_51_6.blocksRaycasts = true

			var_51_3.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

			local var_51_7 = var_51_3:GetComponent("Button")

			var_51_7.transition = UnityEngine.UI.Selectable.Transition.None

			var_51_7.onClick:RemoveAllListeners()
			var_51_7.onClick:AddListener(function()
				if self._farmland_furniture_seq_click_list[iter_51_0] then
					var_0_12:req_RoomCropReq({
						score = self._farmland_furniture_seq_click_list[iter_51_0].score
					})
					self._farmland_furniture_seq_click_list[iter_51_0].seq:Kill()

					self._farmland_furniture_seq_click_list[iter_51_0] = nil

					local var_52_0 = self:autoKillDOTween(var_0_8.Sequence())

					var_52_0:AppendCallback(function()
						self:__set_skeleton_graphic_spine(var_51_3, 0, var_51_1.touch, false)

						var_51_6.interactable = false
					end)
					var_52_0:AppendInterval(0.667)
					var_52_0:AppendCallback(function()
						self:__set_skeleton_graphic_skin(var_51_3, var_51_2.skin_def)

						var_51_6.interactable = true

						var_52_0:Kill()

						var_52_0 = nil
					end)
					var_52_0:Play()

					return
				end

				local var_52_1 = var_0_9(1, 4)
				local var_52_2 = self:get_graphic(var_51_3, (self:loadSkeletonDataAsset(var_0_2(var_0_6.dormitory_const.furniture_spine_path, self._config.icon .. var_51_0[var_52_1]))))

				if not var_52_2:Equals(nil) then
					var_52_2.material = self:loadMaterial(var_0_2(var_0_6.dormitory_const.furniture_spine_mat_path, self._config.icon .. var_51_0[var_52_1]))

					self:__set_skeleton_graphic_skin(var_51_3, var_51_2.skin_def)
					var_52_2.AnimationState:ClearTracks()
				end

				local var_52_3 = self:autoKillDOTween(var_0_8.Sequence())

				var_52_3:AppendCallback(function()
					self:__set_skeleton_graphic_skin(var_51_3, var_51_2.skin_1)
					self:__set_skeleton_graphic_spine(var_51_3, 0, var_51_1.normal2, false)

					var_51_6.interactable = false
				end)
				var_52_3:AppendInterval(0.333)
				var_52_3:AppendCallback(function()
					self:__set_skeleton_graphic_skin(var_51_3, var_51_2.skin_2)
					self:__set_skeleton_graphic_spine(var_51_3, 0, var_51_1.normal1, true)
				end)
				var_52_3:AppendInterval(6)
				var_52_3:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_51_3, 0, var_51_1.normal2, false)
				end)
				var_52_3:AppendInterval(0.333)
				var_52_3:AppendCallback(function()
					self:__set_skeleton_graphic_skin(var_51_3, var_51_2.skin_3)
					self:__set_skeleton_graphic_spine(var_51_3, 0, var_51_1.normal1, true)

					var_51_6.interactable = true
				end)
				var_52_3:AppendInterval(10)
				var_52_3:AppendCallback(function()
					self:__set_skeleton_graphic_skin(var_51_3, var_51_2.skin_4)
					self:__set_skeleton_graphic_spine(var_51_3, 0, var_51_1.normal1, false)

					var_51_6.interactable = false
				end)
				var_52_3:AppendInterval(2)
				var_52_3:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_51_3, 0, var_51_1.normal2, false)
				end)
				var_52_3:AppendInterval(0.333)
				var_52_3:AppendCallback(function()
					self:__set_skeleton_graphic_skin(var_51_3, var_51_2.skin_def)

					var_51_6.interactable = true

					self._farmland_furniture_seq_click_list[iter_51_0].seq:Kill()

					self._farmland_furniture_seq_click_list[iter_51_0] = nil
				end)
				var_52_3:Play()

				self._farmland_furniture_seq_click_list[iter_51_0] = {
					seq = var_52_3,
					score = var_52_1
				}
			end)
		end
	end

	function arg_1_0:__add_click_event_for_316(arg_62_1)
		local var_62_0 = self._spine

		self._spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._spine:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self:__set_canvas_group(self._spine, true)
		self:__set_rect_transform(self._spine, arg_62_1[1])

		self._ugly_wall_tag = true

		self._spine:GetComponent("Button").onClick:RemoveAllListeners()
		self._spine:GetComponent("Button").onClick:AddListener(function()
			self:__reset_seq_list()
			var_62_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).Skeleton:SetToSetupPose()
			var_62_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:ClearTracks()

			local var_63_0 = self:autoKillDOTween(var_0_8.Sequence())

			if not self._ugly_wall_tag then
				self._ugly_wall_tag = true

				var_63_0:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_62_0, 0, "open", false)
				end)
				var_63_0:AppendInterval(1.167)
				var_63_0:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_62_0, 0, "normal2", true)
				end)
				var_63_0:Play()
			else
				self._ugly_wall_tag = false

				var_63_0:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_62_0, 0, "close", false)

					if self._control._param ~= nil then
						var_0_11:dormitory_play_idea_create_play_ugly_wall_out(self._control._param)
					end
				end)
				var_63_0:AppendInterval(1.167)
				var_63_0:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_62_0, 0, "normal", true)
				end)
				var_63_0:Play()
			end

			self:__insert_seq_list(var_63_0)
		end)
	end

	function arg_1_0:__add_click_event_for_315(arg_68_1)
		self._spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._spine:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self:__set_canvas_group(self._spine, false)
		self:__set_rect_transform(self._spine, arg_68_1[1])
		self._spine:GetComponent("Button").onClick:RemoveAllListeners()
		self._spine:GetComponent("Button").onClick:AddListener(function()
			self:__add_click_event_for_315_extend()
		end)
	end

	function arg_1_0:__add_click_event_for_315_extend()
		self._tennis_game_count = self._tennis_game_count == nil and 1 or self._tennis_game_count + 1

		local var_70_0 = {
			open = "open",
			L_touch = "L_touch",
			R_touch = "R_touch",
			start = "start"
		}

		self:__set_canvas_group(self._spine, false)

		self._start_tennis_timer = false
		self._tennis_over = false
		self._tennis_step = self._tennis_step == nil and 1 or 2

		local var_70_1

		if self._tennis_step == 1 then
			var_70_1 = self:autoKillDOTween(var_0_8.Sequence())

			var_70_1:AppendCallback(function()
				self:set_furniture_animation(0, var_70_0.open, false)
			end)
			var_70_1:AppendInterval(0.833)
			var_70_1:AppendCallback(function()
				self:set_furniture_animation(0, var_70_0.start, false)

				self._play_index = 1
			end)
		elseif self._tennis_step == 2 then
			var_70_1 = self:autoKillDOTween(var_0_8.Sequence())

			var_70_1:AppendCallback(function()
				self:set_furniture_animation(0, (self._play_index == 1 or nil) and (var_70_0.R_touch or var_70_0.L_touch), false)

				self._play_index = self._play_index == 1 and 2 or 1
			end)
		end

		var_70_1:AppendCallback(function()
			self._tennis_over = true
			self._tennis_time = nil
			self._start_tennis_timer = true
		end)
		var_70_1:AppendInterval(0.833)
		var_70_1:Play()
		self:__insert_seq_list(var_70_1)
	end

	function arg_1_0:__tennis_result()
		local var_75_0 = {
			R_lose_slow = "R_lose_slow",
			win_L = "win_L",
			R_lose_fast = "R_lose_fast",
			touch_start = "touch_start",
			close = "close",
			L_lose_slow = "L_lose_slow",
			win_R = "win_R",
			L_lose_fast = "L_lose_fast",
			normal = "normal"
		}
		local var_75_1 = self:autoKillDOTween(var_0_8.Sequence())
		local var_75_2 = var_0_9(1, 2)

		var_75_1:AppendCallback(function()
			self:set_furniture_animation(0, self._play_index == 1 and (var_75_2 == 1 and var_75_0.R_lose_fast or var_75_0.R_lose_slow) or var_75_2 == 1 and var_75_0.L_lose_fast or var_75_0.L_lose_slow, false)
		end)
		var_75_1:AppendInterval(var_75_2 == 1 and 0.833 or 1)
		var_75_1:AppendCallback(function()
			self:set_furniture_animation(0, (self._play_index == 1 or nil) and (var_75_0.win_L or var_75_0.win_R), false)
			var_0_11:dormitory_play_idea_create_play_tennis_end(self.param_data, self._play_index)

			self._tennis_step = nil
			self._tennis_over = false
			self._play_index = nil
			self._start_tennis_timer = false
			self._tennis_time = nil
		end)
		var_75_1:AppendInterval(2)
		var_75_1:AppendCallback(function()
			if self._tennis_game_count >= 5 then
				self:set_furniture_animation(0, var_75_0.normal, true)
				self:__set_canvas_group(self._spine, false)

				self._tennis_game_count = 0
			else
				self:set_furniture_animation(0, var_75_0.touch_start, true)
				self:__set_canvas_group(self._spine, true)
			end
		end)
		var_75_1:Play()
		self:__insert_seq_list(var_75_1)
	end

	function arg_1_0:__add_ai_for_250()
		self:__reset_seq_list()

		local var_79_0 = self:autoKillDOTween(var_0_8.Sequence())
		local var_79_1
		local var_79_2
		local var_79_3
		local var_79_4 = 0
		local var_79_5 = 0
		local var_79_6 = 0
		local var_79_7 = 0
		local var_79_8 = var_0_9(1, 80)

		if var_79_8 > 0 and var_79_8 <= 50 then
			var_79_2 = "event_walk_slow"
			var_79_1 = "walk_slow"
			var_79_4 = var_0_9(1, 5)
			var_79_5 = 0.333
			var_79_6 = 1
			var_79_7 = 0
		elseif var_79_8 > 50 and var_79_8 <= 55 then
			var_79_2 = "event_sleep"
			var_79_1 = "sleep"
			var_79_3 = "event_sleep_end"
			var_79_4 = var_0_9(1, 3)
			var_79_5 = 0.667
			var_79_6 = 2
			var_79_7 = 2.667
		elseif var_79_8 > 55 and var_79_8 <= 60 then
			var_79_2 = "event_walk_quick"
			var_79_1 = "walk_quick"
			var_79_4 = var_0_9(1, 2)
			var_79_5 = 0.667
			var_79_6 = 0.667
			var_79_7 = 0
		elseif var_79_8 > 60 and var_79_8 <= 70 then
			var_79_1 = "stand"
			var_79_4 = var_0_9(1, 2)
			var_79_5 = 0
			var_79_6 = 2
			var_79_7 = 0
		elseif var_79_8 > 70 and var_79_8 <= 75 then
			var_79_1 = "event_jump"
			var_79_4 = 1
			var_79_5 = 0
			var_79_6 = 4
			var_79_7 = 0
		elseif var_79_8 > 75 and var_79_8 <= 80 then
			var_79_1 = "SP"
			var_79_4 = 1
			var_79_5 = 0
			var_79_6 = 7.667
			var_79_7 = 0
		end

		self:_add_seq_SkeletonGraphic_data(self._spine, var_79_0, var_79_2, var_79_1, var_79_3, var_79_4, var_79_5, var_79_6, var_79_7)
		var_79_0:Play()
		self:__insert_seq_list(var_79_0)
	end

	function arg_1_0:__add_click_event_for_250(arg_80_1)
		local var_80_0 = self._spine

		self._spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._spine:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self:__set_canvas_group(self._spine, true)
		self:__set_rect_transform(self._spine, arg_80_1[1])
		self._spine:GetComponent("Button").onClick:RemoveAllListeners()
		self._spine:GetComponent("Button").onClick:AddListener(function()
			self:__reset_seq_list()
			var_80_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).Skeleton:SetToSetupPose()
			var_80_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:ClearTracks()

			local var_81_0 = self:autoKillDOTween(var_0_8.Sequence())

			if self._is_second_click == false then
				var_81_0:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_80_0, 0, "suprise", false)

					self._is_second_click = true
					self._is_walk = false
				end)
				var_81_0:AppendInterval(1)
				var_81_0:AppendCallback(function()
					self._random_walk = true

					if self._acting == false then
						self:__get_ai_func()
					end
				end)
			else
				var_81_0:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_80_0, 0, "hug", true)

					self._is_second_click = false
					self._is_walk = false
				end)
				var_81_0:AppendInterval(2)
				var_81_0:AppendCallback(function()
					self._random_walk = true

					if self._acting == false then
						self:__get_ai_func()
					end
				end)
			end

			var_81_0:Play()
			self:__insert_seq_list(var_81_0)
		end)
	end

	function arg_1_0:__add_ai_for_245()
		self:__reset_seq_list()

		local var_86_0 = self:autoKillDOTween(var_0_8.Sequence())
		local var_86_1
		local var_86_2
		local var_86_3
		local var_86_4 = 0
		local var_86_5 = 0
		local var_86_6 = 0
		local var_86_7 = 0
		local var_86_8 = var_0_9(1, 75)

		if var_86_8 > 0 and var_86_8 <= 50 then
			var_86_2 = "event_walk_slow"
			var_86_1 = "walk_slow"
			var_86_4 = var_0_9(1, 5)
			var_86_5 = 0.5
			var_86_6 = 1
			var_86_7 = 0
		elseif var_86_8 > 50 and var_86_8 <= 55 then
			var_86_2 = "event_sleep"
			var_86_1 = "sleep"
			var_86_3 = "event_sleep_end"
			var_86_4 = var_0_9(1, 3)
			var_86_5 = 0.667
			var_86_6 = 2
			var_86_7 = 1.333
		elseif var_86_8 > 55 and var_86_8 <= 60 then
			var_86_2 = "event_walk_quick"
			var_86_1 = "walk_quick"
			var_86_4 = var_0_9(1, 2)
			var_86_5 = 0.5
			var_86_6 = 0.667
			var_86_7 = 0
		elseif var_86_8 > 60 and var_86_8 <= 70 then
			var_86_1 = "stand"
			var_86_4 = var_0_9(1, 2)
			var_86_5 = 0
			var_86_6 = 2
			var_86_7 = 0
		elseif var_86_8 > 70 and var_86_8 <= 75 then
			var_86_1 = "SP"
			var_86_4 = 1
			var_86_5 = 0
			var_86_6 = 2
			var_86_7 = 0
		end

		self:_add_seq_SkeletonGraphic_data(self._spine, var_86_0, var_86_2, var_86_1, var_86_3, var_86_4, var_86_5, var_86_6, var_86_7)
		var_86_0:Play()
		self:__insert_seq_list(var_86_0)
	end

	function arg_1_0:__add_click_event_for_245(arg_87_1)
		local var_87_0 = self._spine

		self._spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._spine:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self:__set_canvas_group(self._spine, true)
		self:__set_rect_transform(self._spine, arg_87_1[1])
		self._spine:GetComponent("Button").onClick:RemoveAllListeners()
		self._spine:GetComponent("Button").onClick:AddListener(function()
			self:__reset_seq_list()
			var_87_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).Skeleton:SetToSetupPose()
			var_87_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:ClearTracks()

			local var_88_0 = self:autoKillDOTween(var_0_8.Sequence())

			var_88_0:AppendCallback(function()
				self:__set_skeleton_graphic_spine(var_87_0, 0, "suprise", false)

				self._is_walk = false
			end)
			var_88_0:AppendInterval(1)
			var_88_0:AppendCallback(function()
				self._random_walk = true

				if self._acting == false then
					self:__get_ai_func()
				end
			end)
			var_88_0:Play()
			self:__insert_seq_list(var_88_0)
		end)
	end

	function arg_1_0:__add_ai_for_246()
		self:__reset_seq_list()

		local var_91_0 = self:autoKillDOTween(var_0_8.Sequence())
		local var_91_1
		local var_91_2
		local var_91_3
		local var_91_4 = 0
		local var_91_5 = 0
		local var_91_6 = 0
		local var_91_7 = 0
		local var_91_8 = var_0_9(1, 100)

		if var_91_8 > 0 and var_91_8 <= 50 then
			var_91_2 = "event_walk_slow"
			var_91_1 = "walk_slow"
			var_91_4 = var_0_9(1, 5)
			var_91_5 = 0.333
			var_91_6 = 1
			var_91_7 = 0
		elseif var_91_8 > 50 and var_91_8 <= 65 then
			var_91_2 = "event_sit"
			var_91_1 = "sit"
			var_91_3 = "event_sit_end"
			var_91_4 = 1
			var_91_5 = 0.5
			var_91_6 = 2
			var_91_7 = 0.5
		elseif var_91_8 > 65 and var_91_8 <= 70 then
			var_91_2 = "event_sleep"
			var_91_1 = "sleep"
			var_91_3 = "event_sleep_end"
			var_91_4 = var_0_9(1, 3)
			var_91_5 = 0.833
			var_91_6 = 2
			var_91_7 = 1.5
		elseif var_91_8 > 70 and var_91_8 <= 75 then
			var_91_2 = "event_walk_quick"
			var_91_1 = "walk_quick"
			var_91_3 = "event_walk_quick_end"
			var_91_4 = var_0_9(1, 2)
			var_91_5 = 0.667
			var_91_6 = 0.667
			var_91_7 = 0.667
		elseif var_91_8 > 75 and var_91_8 <= 85 then
			var_91_1 = "stand"
			var_91_4 = var_0_9(1, 2)
			var_91_5 = 0
			var_91_6 = 2
			var_91_7 = 0
		elseif var_91_8 > 85 and var_91_8 <= 90 then
			var_91_1 = "jump"
			var_91_4 = 1
			var_91_5 = 0
			var_91_6 = 1
			var_91_7 = 0
		elseif var_91_8 > 90 and var_91_8 <= 95 then
			var_91_1 = "scratching"
			var_91_4 = 1
			var_91_5 = 0
			var_91_6 = 3.667
			var_91_7 = 0
		elseif var_91_8 > 95 and var_91_8 <= 100 then
			var_91_1 = "SP"
			var_91_4 = 1
			var_91_5 = 0
			var_91_6 = 3.5
			var_91_7 = 0
		end

		self:_add_seq_SkeletonGraphic_data(self._spine, var_91_0, var_91_2, var_91_1, var_91_3, var_91_4, var_91_5, var_91_6, var_91_7)
		var_91_0:Play()
		self:__insert_seq_list(var_91_0)
	end

	function arg_1_0:__add_click_event_for_246(arg_92_1)
		local var_92_0 = self._spine

		self._spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._spine:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self:__set_canvas_group(self._spine, true)
		self:__set_rect_transform(self._spine, arg_92_1[1])
		self._spine:GetComponent("Button").onClick:RemoveAllListeners()
		self._spine:GetComponent("Button").onClick:AddListener(function()
			self:__reset_seq_list()
			var_92_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).Skeleton:SetToSetupPose()
			var_92_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:ClearTracks()

			local var_93_0 = self:autoKillDOTween(var_0_8.Sequence())

			if self._is_second_click == false then
				var_93_0:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_92_0, 0, "suprise", false)

					self._is_second_click = true
					self._is_walk = false
				end)
				var_93_0:AppendInterval(1)
				var_93_0:AppendCallback(function()
					self._random_walk = true

					if self._acting == false then
						self:__get_ai_func()
					end
				end)
			else
				var_93_0:AppendCallback(function()
					self:__set_skeleton_graphic_spine(var_92_0, 0, "hug", true)

					self._is_second_click = false
					self._is_walk = false
				end)
				var_93_0:AppendInterval(2)
				var_93_0:AppendCallback(function()
					self._random_walk = true

					if self._acting == false then
						self:__get_ai_func()
					end
				end)
			end

			var_93_0:Play()
			self:__insert_seq_list(var_93_0)
		end)
	end

	function arg_1_0:__add_click_event_for_holograpgic_projection_device(arg_98_1)
		local var_98_0 = self._spine

		self._spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._spine:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self:__set_canvas_group(self._spine, true)
		self:__set_rect_transform(self._spine, arg_98_1[1])
		self._spine:GetComponent("Button").onClick:RemoveAllListeners()
		self._spine:GetComponent("Button").onClick:AddListener(function()
			self:__reset_seq_list()
			var_98_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).Skeleton:SetToSetupPose()
			var_98_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:ClearTracks()

			local var_99_0 = self:autoKillDOTween(var_0_8.Sequence())

			var_99_0:AppendCallback(function()
				self:__set_skeleton_graphic_spine(var_98_0, 0, "star", false)
			end)
			var_99_0:AppendInterval(2)
			var_99_0:AppendCallback(function()
				self:__set_skeleton_graphic_spine(var_98_0, 0, "normal", true)
			end)
			var_99_0:AppendInterval((var_0_13.pick_random_from_array({
				5,
				20,
				30
			})))
			var_99_0:AppendCallback(function()
				self:__set_skeleton_graphic_spine(var_98_0, 0, "end", false)
			end)
			var_99_0:AppendInterval(2)
			var_99_0:AppendCallback(function()
				self:__set_skeleton_graphic_spine(var_98_0, 0, "close", true)
			end)
			var_99_0:Play()
			self:__insert_seq_list(var_99_0)
		end)
	end

	function arg_1_0:__add_click_event_for_stare(arg_104_1)
		local var_104_0 = self._spine

		self._spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._spine:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self:__set_canvas_group(self._spine, true)
		self:__set_rect_transform(self._spine, arg_104_1[1])
		self._spine:GetComponent("Button").onClick:RemoveAllListeners()
		self._spine:GetComponent("Button").onClick:AddListener(function()
			self:__reset_seq_list()
			var_104_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).Skeleton:SetToSetupPose()
			var_104_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:ClearTracks()

			local var_105_0 = self:autoKillDOTween(var_0_8.Sequence())

			var_105_0:AppendCallback(function()
				self:__set_skeleton_graphic_spine(var_104_0, 0, "touch", false)
			end)
			var_105_0:AppendInterval(4)
			var_105_0:AppendCallback(function()
				self:__set_skeleton_graphic_spine(var_104_0, 0, "normal", true)
			end)
			var_105_0:Play()
			self:__insert_seq_list(var_105_0)
		end)
	end

	function arg_1_0:__add_click_event_for_hight_screen_TV(arg_108_1)
		local var_108_0 = self._spine

		self._spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._spine:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self:__set_canvas_group(self._spine, true)
		self:__set_rect_transform(self._spine, arg_108_1[1])
		self._spine:GetComponent("Button").onClick:RemoveAllListeners()
		self._spine:GetComponent("Button").onClick:AddListener(function()
			var_108_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).Skeleton:SetToSetupPose()
			var_108_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:ClearTracks()

			if self.is_close then
				if #arg_108_1._game_machine_list ~= 0 then
					self:__set_skeleton_graphic_spine(var_108_0, 0, arg_108_1._game_machine_list[var_0_9(1, #arg_108_1._game_machine_list)], true)
				else
					self:__set_skeleton_graphic_spine(var_108_0, 0, "normal", true)
				end

				self.is_close = false
			else
				self:__set_skeleton_graphic_spine(var_108_0, 0, "close", true)

				self.is_close = true
			end
		end)
	end

	function arg_1_0:add_self_loop_anim()
		local var_110_0 = self:autoKillDOTween(var_0_8.Sequence())
		local var_110_1 = {
			random1 = var_0_9(var_0_6.furntiure_const.loop_num1, var_0_6.furntiure_const.loop_num2),
			random2 = var_0_9(0, 1)
		}

		var_110_1.anim1_name = "normal"
		var_110_1.anim2_name = "normal"
		var_110_1.anim1_time = 4
		var_110_1.anim2_time = 4

		if self._config.cid == var_0_6.self_loop_funriture_list.white_window then
			var_110_1.anim2_name = "normal_bird"
		elseif self._config.cid == var_0_6.self_loop_funriture_list.blue_hook_lock or self._config.cid == var_0_6.self_loop_funriture_list.baby_hook then
			var_110_1.anim1_time = 2
			var_110_1.anim2_time = 2
			var_110_1.anim2_name = "normal"
		elseif self._config.cid == var_0_6.self_loop_funriture_list.imulation_table then
			var_110_1.anim1_time = 33.367
			var_110_1.anim2_time = 16.667
			var_110_1.random1 = 1
			var_110_1.random2 = 1
			var_110_1.anim2_name = "close"
		elseif self._config.cid == var_0_6.self_loop_funriture_list.gas_stove then
			self:__add_self_loop_anim_for_230()

			return
		elseif self._config.cid == var_0_6.self_loop_funriture_list.hot_pot then
			var_110_1.anim2_name = "normal2"
		end

		self:__loop_play_seq(var_110_0, self._spine, var_110_1.anim1_name, var_110_1.anim1_time, false, var_110_1.random1, false)
		self:__loop_play_seq(var_110_0, self._spine, var_110_1.anim2_name, var_110_1.anim2_time, false, var_110_1.random2, true)
		self:__insert_seq_list(var_110_0)
	end

	function arg_1_0:__add_self_loop_anim_for_230()
		local var_111_0 = self:autoKillDOTween(var_0_8.Sequence())

		self:__loop_play_seq(var_111_0, self._spine, "normal", 2, false, 5, false)
		self:__loop_play_seq(var_111_0, self._spine, "normal2", 2, false, 4, false)
		self:__loop_play_seq(var_111_0, self._spine, "normal3", 2, false, 3, false)
		self:__loop_play_seq(var_111_0, self._spine, "end1", 2, false, 2, false)
		self:__loop_play_seq(var_111_0, self._spine, "end", 1, false, 20, true)
		self:__insert_seq_list(var_111_0)
	end

	function arg_1_0:__set_bg_spine_of_1029()
		self._furniture_skeleton_graphic = nil
		self._spine_obj_right_btn = UnityEngine.Object.Instantiate(self._control.sort_layer2.spine.gameObject, self._control.sort_layer2.transform, false)
		self._spine_obj_right_btn.gameObject.name = "rhght_btn"
		self._spine_left_obj = UnityEngine.Object.Instantiate(self._control.sort_layer2.spine.gameObject, self._control.sort_layer2.transform, false)
		self._spine_left_obj.gameObject.name = "left_spine"
		self._spine_right_obj = UnityEngine.Object.Instantiate(self._control.sort_layer2.spine.gameObject, self._control.sort_layer2.transform, false)
		self._spine_right_obj.gameObject.name = "right_spine"
		self._furniture_skeleton_graphic = self:get_graphic(self._spine, (self:loadSkeletonDataAsset(var_0_2(var_0_6.dormitory_const.furniture_spine_path, var_0_2("%s_2", self._config.icon)))))
		self._furniture_skeleton_graphic.material = self:loadMaterial(var_0_2(var_0_6.dormitory_const.furniture_spine_mat_path, var_0_2("%s_2", self._config.icon)))
		self._furniture_skeleton_graphic.startingAnimation = "normal"

		self._furniture_skeleton_graphic:Initialize(true)
		self._furniture_skeleton_graphic.AnimationState:ClearTracks()
		self._furniture_skeleton_graphic.AnimationState:SetAnimation(0, "normal", true)
		self:__set_dormitory_bg_state(false)
		self:__set_bg_spine_pos()
		self:__add_ckick_bg_wall_event()
		self:__set_bg_left_inter_spine("%s_LB", false)
		self:__set_bg_right_inter_spine("%s_RB", false)
		self:__set_sort_layer_canvas()
		self:__set_spine_scale()
	end

	function arg_1_0:__set_bg_left_inter_spine(arg_113_1, arg_113_2)
		self._furniture_skeleton_graphic2 = nil

		local var_113_0 = self:loadSkeletonDataAsset(var_0_2(var_0_6.dormitory_const.furniture_spine_path, var_0_2(arg_113_1, self._config.icon)))

		if arg_113_2 then
			self._furniture_skeleton_graphic2 = self._control.sort_layer2.spine:GetComponent("SkeletonGraphic")

			if self._left_change_index == 0 then
				self._spine_left_obj.gameObject:SetActive(true)

				self._furniture_skeleton_graphic2.initialSkinName = "default"
			else
				self._spine_left_obj.gameObject:SetActive(false)

				self._furniture_skeleton_graphic2.initialSkinName = "normal2"
			end

			self._furniture_skeleton_graphic2.skeletonDataAsset = var_113_0
		else
			self._furniture_skeleton_graphic2 = self:get_graphic(self._control.sort_layer2.spine, var_113_0)

			self:__set_left_clone_spine()
		end

		local var_113_1 = self:loadMaterial(var_0_2(var_0_6.dormitory_const.furniture_spine_mat_path, var_0_2(arg_113_1, self._config.icon)))

		if var_113_1 then
			self._furniture_skeleton_graphic2.material = var_113_1
		end

		self._furniture_skeleton_graphic2.startingAnimation = "normal"

		self._furniture_skeleton_graphic2:Initialize(true)
		self._furniture_skeleton_graphic2.AnimationState:ClearTracks()
		self._furniture_skeleton_graphic2.AnimationState:SetAnimation(0, "normal", true)
	end

	function arg_1_0:__set_left_clone_spine()
		self._furniture_skeleton_graphic_left = nil
		self._furniture_skeleton_graphic_left = self:get_graphic(self._spine_left_obj, (self:loadSkeletonDataAsset(var_0_2(var_0_6.dormitory_const.furniture_spine_path, var_0_2("%s_LA", self._config.icon)))))
		self._furniture_skeleton_graphic_left.initialSkinName = "normal"

		local var_114_0 = self:loadMaterial(var_0_2(var_0_6.dormitory_const.furniture_spine_mat_path, var_0_2("%s_LA", self._config.icon)))

		if var_114_0 then
			self._furniture_skeleton_graphic_left.material = var_114_0
		end

		self._furniture_skeleton_graphic_left.startingAnimation = "normal"

		self._furniture_skeleton_graphic_left:Initialize(true)
		self._furniture_skeleton_graphic_left.AnimationState:ClearTracks()
		self._furniture_skeleton_graphic_left.AnimationState:SetAnimation(0, "normal", true)
	end

	function arg_1_0:__set_right_clone_spine()
		self._furniture_skeleton_graphic_right = nil
		self._furniture_skeleton_graphic_right = self:get_graphic(self._spine_right_obj, (self:loadSkeletonDataAsset(var_0_2(var_0_6.dormitory_const.furniture_spine_path, var_0_2("%s_RA", self._config.icon)))))
		self._furniture_skeleton_graphic_right.initialSkinName = "normal"

		local var_115_0 = self:loadMaterial(var_0_2(var_0_6.dormitory_const.furniture_spine_mat_path, var_0_2("%s_RA", self._config.icon)))

		if var_115_0 then
			self._furniture_skeleton_graphic_right.material = var_115_0
		end

		self._furniture_skeleton_graphic_right.startingAnimation = "normal"

		self._furniture_skeleton_graphic_right:Initialize(true)
		self._furniture_skeleton_graphic_right.AnimationState:ClearTracks()
		self._furniture_skeleton_graphic_right.AnimationState:SetAnimation(0, "normal", true)
	end

	function arg_1_0:__set_bg_right_inter_spine(arg_116_1, arg_116_2)
		self._furniture_skeleton_graphic3 = nil

		local var_116_0 = self:loadSkeletonDataAsset(var_0_2(var_0_6.dormitory_const.furniture_spine_path, var_0_2(arg_116_1, self._config.icon)))

		if arg_116_2 then
			self._furniture_skeleton_graphic3 = self:get_graphic(self._spine_obj_right_btn, var_116_0)

			if self._right_change_index == 0 then
				self._spine_right_obj.gameObject:SetActive(true)

				self._furniture_skeleton_graphic3.initialSkinName = "default"
			else
				self._spine_right_obj.gameObject:SetActive(false)

				self._furniture_skeleton_graphic3.initialSkinName = "normal2"
			end
		else
			self._furniture_skeleton_graphic3 = self:get_graphic(self._spine_obj_right_btn, var_116_0)

			self:__set_right_clone_spine()
		end

		local var_116_1 = self:loadMaterial(var_0_2(var_0_6.dormitory_const.furniture_spine_mat_path, var_0_2(arg_116_1, self._config.icon)))

		if var_116_1 then
			self._furniture_skeleton_graphic3.material = var_116_1
		end

		self._furniture_skeleton_graphic3.startingAnimation = "normal"

		self._furniture_skeleton_graphic3:Initialize(true)
		self._furniture_skeleton_graphic3.AnimationState:ClearTracks()
		self._furniture_skeleton_graphic3.AnimationState:SetAnimation(0, "normal", true)
	end

	function arg_1_0:__set_sort_layer_canvas()
		self._control.sort_layer.img:AddComponent(typeof(UnityEngine.Canvas))
		self._spine:AddComponent(typeof(UnityEngine.Canvas))

		local var_117_0 = self:autoKillDOTween(var_0_8.Sequence())

		var_117_0:AppendInterval(0.03)
		var_117_0:AppendCallback(function()
			self._control.sort_layer.img:GetComponent("Canvas").overrideSorting = true
			self._control.sort_layer.img:GetComponent("Canvas").sortingOrder = self._sort_layer2_canvas.sortingOrder - 1
			self._spine:GetComponent("Canvas").overrideSorting = true
			self._spine:GetComponent("Canvas").sortingOrder = self._sort_layer2_canvas.sortingOrder - 3
			self._spine.canvasGroup.alpha = 1
		end)

		for iter_117_0 = 1, self._control.sort_layer2.transform.childCount - 1 do
			local var_117_1 = self._control.sort_layer2.transform:GetChild(iter_117_0).gameObject

			var_117_1:AddComponent(typeof(UnityEngine.Canvas))

			local var_117_2 = self:autoKillDOTween(var_0_8.Sequence())

			var_117_2:AppendInterval(0.03)
			var_117_2:AppendCallback(function()
				var_117_1:GetComponent("Canvas").overrideSorting = true
				var_117_1:GetComponent("Canvas").sortingOrder = self._sort_layer2_canvas.sortingOrder - 2
				var_117_1:GetComponent("CanvasGroup").alpha = 1
			end)

			if iter_117_0 < 3 then
				var_117_1:AddComponent(typeof(UnityEngine.UI.GraphicRaycaster))

				var_117_1:GetComponent("CanvasGroup").interactable = true
				var_117_1:GetComponent("CanvasGroup").blocksRaycasts = true
			end
		end
	end

	function arg_1_0:__set_bg_spine_pos()
		self._control.sort_layer2.spine.rectTransform.anchoredPosition = var_0_3(691, 360)

		local var_120_0 = {
			pivot_x = 2.56,
			height = 111,
			width = 142,
			pivot_y = 0.91
		}

		self:__set_rect_transform(self._control.sort_layer2.spine, var_120_0)

		self._spine_left_obj:GetComponent("RectTransform").anchoredPosition = var_0_3(691, 360)

		self:__set_rect_transform(self._spine_left_obj.transform, var_120_0)

		self._spine.rectTransform.anchoredPosition = var_0_3(638, 403)
		self._spine_obj_right_btn:GetComponent("RectTransform").anchoredPosition = var_0_3(626, 361)
		self._spine_right_obj:GetComponent("RectTransform").anchoredPosition = var_0_3(626, 361)

		local var_120_1 = {
			pivot_x = -0.9,
			height = 120,
			width = 173,
			pivot_y = 0.9
		}

		self:__set_rect_transform(self._spine_obj_right_btn.transform, var_120_1)
		self:__set_rect_transform(self._spine_right_obj.transform, var_120_1)
	end

	function arg_1_0:__set_spine_scale()
		self._control.sort_layer2.spine.rectTransform.localScale = var_0_4(1.45, 1.24, 1)
		self._spine_left_obj:GetComponent("RectTransform").localScale = var_0_4(1.45, 1.24, 1)
		self._spine_obj_right_btn:GetComponent("RectTransform").localScale = var_0_4(1.32, 1.24, 1)
		self._spine_right_obj:GetComponent("RectTransform").localScale = var_0_4(1.32, 1.24, 1)

		if self._config.cid == var_0_6.dormitory_special_furniture_id.staggered_road then
			self._control.sort_layer2.spine.rectTransform.localScale = var_0_4(1.28, 1.28, 1)
			self._control.sort_layer2.spine.rectTransform.localPosition = var_0_4.New(3, 4, 1)

			if self._control.sort_layer2.transform:Find("rhght_btn") then
				self._control.sort_layer2.transform:Find("rhght_btn"):GetComponent("RectTransform").localPosition = var_0_4.New(-12.2, 3.4, 0)
			end
		end
	end

	function arg_1_0:__update_left_spine_path(arg_122_1)
		self:__set_bg_left_inter_spine(arg_122_1 == 0 and "%s_LB" or "%s_L", true)
	end

	function arg_1_0:__update_right_spine_path(arg_123_1)
		self:__set_bg_right_inter_spine(arg_123_1 == 0 and "%s_RB" or "%s_R", true)
	end

	function arg_1_0.__set_dormitory_bg_state(arg_124_0, arg_124_1)
		var_0_1:getInstance("dormitory"):set_curr_bg_state(arg_124_1)
	end

	function arg_1_0:__add_ckick_bg_wall_event()
		self._control.sort_layer2.spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._control.sort_layer2.spine:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self._control.sort_layer2.spine:GetComponent("Button").onClick:RemoveAllListeners()
		self._control.sort_layer2.spine:GetComponent("Button").onClick:AddListener(function()
			self:__change_left_inter_index()
		end)
		self._spine_obj_right_btn.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		self._spine_obj_right_btn:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.None

		self._spine_obj_right_btn:GetComponent("Button").onClick:RemoveAllListeners()
		self._spine_obj_right_btn:GetComponent("Button").onClick:AddListener(function()
			self:__change_right_inter_index()
		end)
	end

	function arg_1_0:__change_left_inter_index()
		self._left_change_index = self._left_change_index < 1 and self._left_change_index + 1 or 0

		self:__update_left_spine_path(self._left_change_index)
	end

	function arg_1_0:__change_right_inter_index()
		self._right_change_index = self._right_change_index < 1 and self._right_change_index + 1 or 0

		self:__update_right_spine_path(self._right_change_index)
	end

	function arg_1_0:__set_bg_spine_of_1021()
		self:set_spine()

		self._control.sort_layer.img.canvasGroup.alpha = 1
		self._control.sort_layer.spine.transform.localScale = var_0_4(1.25, 1.25, 1)
		self._control.sort_layer.spine.transform.anchoredPosition = var_0_3(640, 360)
	end

	function arg_1_0:__set_bg_spine_of_1018()
		self._control.sort_layer.spine.transform:SetAsFirstSibling()
		self:set_spine()

		self._control.sort_layer.img.canvasGroup.alpha = 1
		self._control.sort_layer.spine.transform.localScale = var_0_4(1.25, 1.25, 1)
		self._control.sort_layer.spine.transform.anchoredPosition = var_0_3(640, 460)
		self._control.sort_layer2.spine.transform.localScale = var_0_4(1.25, 1.25, 1)
		self._control.sort_layer2.spine.transform.anchoredPosition = var_0_3(640, 360)
	end

	function arg_1_0:__add_click_event_for_cake_display_case()
		local var_132_0 = self._control.sort_layer2.spine.transform
		local var_132_1 = self._control.sort_layer.spine

		self._control.sort_layer2.spine.transform.anchoredPosition = self._foot_position + var_0_3(-82, 189) * (1 - (1.25 - self._spine_scale) / self._spine_scale)

		local var_132_2 = self._control.sort_layer2.spine.transform.anchoredPosition

		self:record_orgin_position(self._control.sort_layer2.spine.transform.anchoredPosition)
		self._control.sort_layer.spine.transform:SetParent(self._control.sort_layer2.spine.transform, false)

		self._control.sort_layer.spine.transform.anchoredPosition = var_0_3(60, -70)
		self._control.sort_layer.spine.transform.localScale = var_0_3(self._control.sort_layer.spine.transform.localScale.x, 1)

		self._control.sort_layer.spine:AddComponent(typeof(UnityEngine.Canvas))

		local var_132_3 = self:autoKillDOTween(var_0_8.Sequence())

		var_132_3:AppendInterval(0.03)
		var_132_3:AppendCallback(function()
			var_132_1:GetComponent("Canvas").overrideSorting = true
			var_132_1:GetComponent("Canvas").sortingOrder = self:get_sort_order()
		end)

		self._recover_orgin_pos = false

		local var_132_4, var_132_5 = self:loadUIPrefab("furniture_btn_view", self._control.sort_layer2.transform)

		var_132_4:setVisible(true)

		var_132_4._panel.transform.anchoredPosition = var_0_3(self._control.sort_layer2.spine.transform.anchoredPosition.x, self._control.sort_layer2.spine.transform.anchoredPosition.y - 32.5)
		self._furniture_btn_orgin_pos = var_132_4
		var_132_4._panel.transform:GetComponent("Canvas").sortingOrder = self._sort_layer2_canvas.sortingOrder + 1

		local var_132_6 = var_132_4._panel.transform

		var_132_5.furniture_btn.pointerDownUpEvent.onPointerUp:RemoveAllListeners()
		var_132_5.furniture_btn.pointerDownUpEvent.onPointerUp:AddListener(function()
			local var_134_0 = self._control.sort_layer2.spine

			self:__reset_seq_list()

			local var_134_1 = self:autoKillDOTween(var_0_8.Sequence())

			var_134_1:AppendCallback(function()
				self:__set_skeleton_graphic_spine(var_134_0, 0, "normal2", false)
			end)
			var_134_1:AppendInterval(2)
			var_134_1:AppendCallback(function()
				self:__set_skeleton_graphic_spine(var_134_0, 0, "normal", true)
			end)
			var_134_1:Play()
			self:__insert_seq_list(var_134_1)
		end)

		local var_132_7 = var_0_13.get_ui_root_canvas_rect()

		var_132_5.furniture_btn.dragableItem.onBeginDrag:RemoveAllListeners()
		var_132_5.furniture_btn.dragableItem.onBeginDrag:AddListener(function()
			self._recover_orgin_pos = false

			local var_137_0 = var_0_3()
			local var_137_1, var_137_2 = var_0_15.ScreenPointToLocalPointInRectangle(var_132_7, var_0_3(var_0_14.mousePosition.x, var_0_14.mousePosition.y), nil, nil)

			if var_137_1 then
				self._delta_vector = var_132_6.anchoredPosition - var_137_2
			end
		end)
		var_132_5.furniture_btn.dragableItem.onDrag:RemoveAllListeners()
		var_132_5.furniture_btn.dragableItem.onDrag:AddListener(function()
			local var_138_0 = var_0_3()
			local var_138_1, var_138_2 = var_0_15.ScreenPointToLocalPointInRectangle(var_132_7, var_0_3(var_0_14.mousePosition.x, var_0_14.mousePosition.y), nil, nil)

			if var_138_1 then
				var_132_6.anchoredPosition = self._delta_vector + var_138_2
				var_132_0.anchoredPosition = self._delta_vector + var_138_2
			end

			local var_138_3 = var_132_2.y + 156

			if var_132_2.y + 156 < var_132_6.anchoredPosition.y then
				var_132_6.anchoredPosition = var_0_3(var_132_6.anchoredPosition.x, var_138_3)
				var_132_0.anchoredPosition = var_0_3(var_132_0.anchoredPosition.x, var_138_3)
			end

			local var_138_4 = var_132_2.y

			if var_132_2.y > var_132_6.anchoredPosition.y then
				var_132_6.anchoredPosition = var_0_3(var_132_6.anchoredPosition.x, var_138_4)
				var_132_0.anchoredPosition = var_0_3(var_132_0.anchoredPosition.x, var_138_4)
			end

			local var_138_5 = var_132_2.x

			if var_132_2.x > var_132_6.anchoredPosition.x or var_138_5 < var_132_6.anchoredPosition.x then
				var_132_6.anchoredPosition = var_0_3(var_138_5, var_132_6.anchoredPosition.y)
				var_132_0.anchoredPosition = var_0_3(var_138_5, var_132_6.anchoredPosition.y)
			end
		end)
		var_132_5.furniture_btn.dragableItem.onEndDrag:RemoveAllListeners()
		var_132_5.furniture_btn.dragableItem.onEndDrag:AddListener(function()
			self._recover_orgin_pos = true
		end)
	end
end

function var_0_0.extend_obj(arg_140_0)
	return
end

return var_0_0
