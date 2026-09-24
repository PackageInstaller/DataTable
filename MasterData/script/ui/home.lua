local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = string.format
local var_0_5 = gameconfig.ship_config
local var_0_6 = gameconfig.skin_config
local var_0_7 = gameenum.common_type
local var_0_8 = gameenum.config_data
local var_0_9 = lx.json_decode
local var_0_10 = gamecore.util_func
local var_0_11 = gameconfig.level_config
local var_0_12 = lan_rand
local var_0_13 = DG.Tweening.DOTween
local var_0_14 = DG.Tweening.Core
local var_0_15 = table.insert
local var_0_16 = lx.clone_table
local var_0_17 = table.remove
local var_0_18 = gameconfig.shop_config
local var_0_19 = gameconfig.ship_pve_active_config
local var_0_20 = gameconfig.cook_book_config
local var_0_21 = gamecore.AudioManager
local var_0_22 = gameconfig.music_config
local var_0_23 = gameconfig.task_config
local var_0_24 = lx.UserData
local var_0_25 = UnityEngine.Input
local var_0_26 = gameconfig.furniture_config
local var_0_27 = gameconfig.expedition_config
local var_0_28 = gameconfig.ship_rule_config
local var_0_29 = UnityEngine.RectTransformUtility
local var_0_30 = gameconfig.ship_skill_buff_config
local var_0_31 = UnityEngine.Screen
local var_0_32 = gamecore.PayManager
local var_0_33 = Live2D.Cubism.Framework.Raycasting
local var_0_34 = UnityEngine.Vector2
local var_0_35 = UnityEngine.Vector3
local var_0_36 = UnityEngine.TouchPhase
local var_0_37 = gamecore.AuditServerManager
local var_0_38 = gamecore.UserDataManager
local var_0_39 = gameconfig.ship_research_config
local var_0_40 = gamecore.click_spine_mgr
local var_0_41 = {
	first_top_up_float = "main_float_6",
	shop_float = "main_float_3",
	dock_float = "main_float_1",
	sign_float = "main_float_5",
	mail_float = "main_float_2",
	bind_phone_float = "main_float_8",
	friend_float = "main_float_4",
	buy_ten_float = "main_float_9",
	collection_float = "main_float_7",
	figurines_float = "main_float_10",
	level_float = "main_float_11"
}

gamecore.UILoader:define("home", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self._uiroot_canvas_rect = var_0_10.get_ui_root_canvas_rect()
		self._ui_camera = var_0_10.get_ui_camera()
		self._enter_game = var_0_2:getInstance("enter_game")

		self:setVisible(true, arg_2_1)

		self._ship_pos_start_pos = nil
		self._ship_pos_end_pos = nil

		var_0_3:set_in_bootyshop(false)
		var_0_3:set_to_normal_fight(false)

		self._init_scale = 1
		self._role_sp_change = false

		self:__init_panel(arg_2_1)

		self._init_scale = self._is_last_picture_hd and 0.5 or 1
		self._control.model_layer.cc_sprite.icon.transform.localScale = var_0_35.New(1.2, 1.2, 1.2)

		self:_init_main_panel_position()
		self:_update_main_position()
		var_0_32:verifyReceipt()

		if var_0_3:get_guide_state() then
			self:__show_guide_info()
		else
			self:__destroy_guide_view()
		end

		self:init_float()
		self:__show_school_open_prompt()
		self:__role_move()
		self:__update_not_pass_map()
		self:_into_home_hot()
		self:_into_addiction()
		var_0_2:destroyStateUISet("living_areas")
		self:set_home_panel_active_time()
		self:__have_research_ship_need_change_stage_info()
		self:__check_solid_battle_data()
		self:_check_home_panel_object()
		self:set_secretary_info_show()
		var_0_3:set_all_select_member_list()
		var_0_3:set_tactics_all_select_member_list()
		var_0_3:set_show_panel_equip_state(false)
	end

	function arg_1_0._check_home_panel_object(arg_3_0)
		if var_0_2:getInstance("six_year_main_interface") then
			var_0_2:destroyInstance("six_year_main_interface")
		end

		if var_0_2:getInstance("gotofight") then
			var_0_2:destroyInstance("gotofight")
		end

		if var_0_2:getInstance("dock") then
			var_0_2:destroyInstance("dock")
		end

		if var_0_2:getInstance("remake") then
			var_0_2:destroyInstance("remake")
		end

		if var_0_2:getInstance("fight_prepare") then
			var_0_2:destroyInstance("fight_prepare")
		end

		if var_0_2:getInstance("new_ship_or_equip") then
			var_0_2:destroyInstance("new_ship_or_equip")
		end

		if var_0_2:getInstance("marry_ok") then
			var_0_2:destroyInstance("marry_ok")
		end

		if var_0_2:getInstance("enemy_ship_detail") then
			var_0_2:destroyInstance("enemy_ship_detail")
		end

		local var_3_0 = var_0_2:getInstance("equip_type_layer")

		if var_3_0 then
			var_3_0:reset_sort_info()
			var_0_2:destroyInstance("equip_type_layer")
		end

		if var_0_2:getInstance("equip_map") then
			var_0_2:destroyInstance("equip_map")
		end

		if var_0_2:getInstance("voucher_shop") then
			var_0_2:destroyInstance("voucher_shop")
		end
	end

	function arg_1_0.__save_data(arg_4_0, arg_4_1, arg_4_2)
		var_0_24:setKeyData(arg_4_1, lx_json_encode({
			value = arg_4_2
		}))
	end

	function arg_1_0:_into_home_hot()
		if var_0_3:get_update_hot() then
			self:destroyGameObject(self._live2d)
			var_0_3:set_update_hot(false)
			var_0_2:createInstance("msgbox"):showOne(var_0_1:getNowLang("find_new_download"), function()
				self:setVisible(false)

				if app:getSystem():getOSType() == "android" then
					if AndroidJavaQuitManager then
						AndroidJavaQuitManager.MyJavaQuit()
					else
						os.exit()
					end
				else
					os.exit()
				end
			end, (var_0_1:getNowLang("signininvitecodebtn")))
		end
	end

	function arg_1_0._into_addiction(arg_7_0)
		if var_0_3:get_addiction_flag() then
			var_0_2:createInstance("addiction_box"):show((var_0_3:get_addiction_data()))
		end

		var_0_3:set_addiction_flag(false, now_data)
	end

	function arg_1_0:__get_spine_clickable(arg_8_1)
		self._panel:GetComponent("GraphicRaycaster").enabled = arg_8_1
	end

	function arg_1_0:create_home_spine(arg_9_1)
		if self._spine_model and next(self._spine_model) then
			self._spine_model:destroy()

			self._spine_model = nil
		end

		self._spine_model = self:loadUI((var_0_4("character_spine_%s", arg_9_1)))

		self._spine_model._panel.transform:SetParent(self._control.model_layer.home_spine_pre.transform, false)
		self._spine_model:setVisible(true)
		self:refresh_role(arg_9_1)
	end

	function arg_1_0:refresh_role(arg_10_1)
		self._spine_model._panel.transform.localPosition = var_0_35.zero
		self._spine_model._panel.transform.localScale = var_0_35(1, 1, 1)

		local var_10_0 = var_0_35(self._spine_model.x, self._spine_model.y, self._spine_model.z)

		self._spine_model._panel.transform.localPosition = var_0_35(var_10_0.x + self._now_spine_info.pos.x, var_10_0.y + self._now_spine_info.pos.y, self._spine_model.z)
		self._spine_model._panel.transform.localScale = var_0_35(self._now_spine_info.scale, self._now_spine_info.scale, 1)
		self.__skeleton = self._spine_model._panel:GetComponent("SkeletonGraphic")
		self._ani_index = 1

		if arg_10_1 == "209_2" then
			self.__missouri_weaponisclose = false
			self.__missouri_glassisclose = false

			self:__play_animation_func(self._spine_model._panel, "mainGunOpenGlassOnIdle_1", true)
		else
			self:__play_animation_func(self._spine_model._panel, "original", true)
		end
	end

	function arg_1_0:_model_spine_click()
		if var_0_25.GetMouseButtonDown(0) then
			if var_0_40:__r_is_ui() then
				return
			end

			local var_11_0 = var_0_2:getInstance("home")

			if var_11_0 and var_11_0._panel.activeSelf and self._allow_mouse_move and self._spine_model then
				local var_11_1 = self:get_obj_name()

				if var_11_1 and not self._control.model_layer.talk.activeSelf then
					if self._now_spine_id == "209_2" then
						if var_11_1 then
							self:__missouri_motions(var_11_1)
						end
					else
						self:__set_spine_talk_show(var_11_1)

						local var_11_2 = self._spine_model._panel:GetComponent("SkeletonGraphic")
						local var_11_3 = var_11_2.skeletonDataAsset:GetAnimationStateData()

						if not var_11_2.AnimationState:GetCurrent(1) then
							self:__play_animation_func(self._spine_model._panel, self._now_motions, false, function()
								self:__play_animation_func(self._spine_model._panel, "original", true, nil)
							end)
						end
					end
				end
			end
		end
	end

	function arg_1_0:__inspect_spine_idleAnimation()
		if not self._now_spine_info or self._control.model_layer.cc_sprite.activeSelf or not self._now_spine_id or self._now_spine_id == "" then
			return
		end

		if self._now_motions then
			if self._now_spine_id == "209_2" then
				if self.__skeleton then
					if self._now_motions == "mainGunOpenGlassOnIdle" then
						if self.__skeleton.AnimationState:GetCurrent(0).IsComplete then
							self._ani_index = self._ani_index == 2 and 1 or 2

							self.__skeleton.AnimationState:SetAnimation(0, self._have_idlemotions_mi_open[self._ani_index], true)
						end
					elseif self._now_motions == "mainGunCloseGlassOnIdle" and self.__skeleton.AnimationState:GetCurrent(0).IsComplete then
						self._ani_index = self._ani_index == 2 and 1 or 2

						self.__skeleton.AnimationState:SetAnimation(0, self._have_idlemotions_mi_close[self._ani_index], true)
					end
				end
			elseif self.__skeleton and self._now_motions == "original" and self.__skeleton.AnimationState:GetCurrent(0).IsComplete then
				self._ani_index = self._ani_index == 1 and 2 or 1

				self.__skeleton.AnimationState:SetAnimation(0, self._have_idlemotions[self._ani_index], true)
			end
		end
	end

	function arg_1_0:__missouri_motions(arg_14_1)
		if arg_14_1 == "kiss" then
			if self.__missouri_glassisclose then
				self.__missouri_glassisclose = false

				if self.__missouri_weaponisclose then
					self:__play_animation_func(self._spine_model._panel, "wearGlassGunClose", false, function()
						self:__set_spine_talk_show("kissGunClose")
						self:__play_animation_func(self._spine_model._panel, "kissGunClose", false, function()
							self:__play_animation_func(self._spine_model._panel, "mainGunCloseGlassOnIdle", true, nil)
						end)
					end)
				else
					self:__play_animation_func(self._spine_model._panel, "wearGlassGunClose", false, function()
						self:__set_spine_talk_show("kissGunOpen")
						self:__play_animation_func(self._spine_model._panel, "kissGunOpen", false, function()
							self:__play_animation_func(self._spine_model._panel, "mainGunOpenGlassOnIdle", true, nil)
						end)
					end)
				end
			elseif self.__missouri_weaponisclose then
				self:__set_spine_talk_show("kissGunClose")
				self:__play_animation_func(self._spine_model._panel, "kissGunClose", false, function()
					self:__play_animation_func(self._spine_model._panel, "mainGunCloseGlassOnIdle", true, nil)
				end)
			else
				self:__set_spine_talk_show("kissGunOpen")
				self:__play_animation_func(self._spine_model._panel, "kissGunOpen", false, function()
					self:__play_animation_func(self._spine_model._panel, "mainGunOpenGlassOnIdle", true, nil)
				end)
			end
		elseif arg_14_1 == "glass" then
			if self.__missouri_glassisclose then
				self.__missouri_glassisclose = false

				self:__set_spine_talk_show("takeOffGlassGunClose")

				if self.__missouri_weaponisclose then
					self:__play_animation_func(self._spine_model._panel, "wearGlassGunClose", false, function()
						self:__play_animation_func(self._spine_model._panel, "mainGunCloseGlassOnIdle", true, nil)
					end)
				else
					self:__play_animation_func(self._spine_model._panel, "wearGlassGunOpen", false, function()
						self:__play_animation_func(self._spine_model._panel, "mainGunOpenGlassOnIdle", true, nil)
					end)
				end
			else
				self.__missouri_glassisclose = true

				self:__set_spine_talk_show("takeOffGlassGunOpen")

				if self.__missouri_weaponisclose then
					self:__play_animation_func(self._spine_model._panel, "takeOffGlassGunClose", false, function()
						self:__play_animation_func(self._spine_model._panel, "mainGunCloseGlassOffIdle", true, nil)
					end)
				else
					self:__play_animation_func(self._spine_model._panel, "takeOffGlassGunOpen", false, function()
						self:__play_animation_func(self._spine_model._panel, "mainGunOpenGlassOffIdle", true, nil)
					end)
				end
			end
		elseif arg_14_1 == "weapon" then
			if self.__missouri_weaponisclose then
				if self.__missouri_glassisclose then
					self.__missouri_glassisclose = false

					self:__play_animation_func(self._spine_model._panel, "wearGlassGunClose", false, function()
						self:__set_spine_talk_show("wearGlassGunOpen")
						self:__play_animation_func(self._spine_model._panel, "mainGunTransBack", false, function()
							self:__play_animation_func(self._spine_model._panel, "mainGunOpenGlassOnIdle", true, nil)
						end)
					end)
				else
					self:__set_spine_talk_show("wearGlassGunOpen")
					self:__play_animation_func(self._spine_model._panel, "mainGunTransBack", false, function()
						self:__play_animation_func(self._spine_model._panel, "mainGunOpenGlassOnIdle", true, nil)
					end)
				end

				self.__missouri_weaponisclose = false
			else
				if self.__missouri_glassisclose then
					self.__missouri_glassisclose = false

					self:__play_animation_func(self._spine_model._panel, "wearGlassGunOpen", false, function()
						self:__set_spine_talk_show("wearGlassGunClose")
						self:__play_animation_func(self._spine_model._panel, "mainGunTransfer", false, function()
							self:__play_animation_func(self._spine_model._panel, "mainGunCloseGlassOnIdle", true, nil)
						end)
					end)
				else
					self:__set_spine_talk_show("wearGlassGunClose")
					self:__play_animation_func(self._spine_model._panel, "mainGunTransfer", false, function()
						self:__play_animation_func(self._spine_model._panel, "mainGunCloseGlassOnIdle", true, nil)
					end)
				end

				self.__missouri_weaponisclose = true
			end
		elseif arg_14_1 == "boobs" then
			if self.__missouri_glassisclose then
				self.__missouri_glassisclose = false

				if self.__missouri_weaponisclose then
					self.__missouri_weaponisclose = true

					self:__play_animation_func(self._spine_model._panel, "wearGlassGunClose", false, function()
						self:__set_spine_talk_show("boobs")
						self:__play_animation_func(self._spine_model._panel, "boobsGunCLose", false, function()
							self:__play_animation_func(self._spine_model._panel, "mainGunCloseGlassOnIdle", true, nil)
						end)
					end)
				else
					self:__play_animation_func(self._spine_model._panel, "wearGlassGunOpen", false, function()
						self:__set_spine_talk_show("boobs")
						self:__play_animation_func(self._spine_model._panel, "boobs", false, function()
							self:__play_animation_func(self._spine_model._panel, "mainGunOpenGlassOnIdle", true, nil)
						end)
					end)
				end
			else
				self:__set_spine_talk_show("boobs")

				if self.__missouri_weaponisclose then
					self.__missouri_weaponisclose = true

					self:__play_animation_func(self._spine_model._panel, "boobsGunOpen", false, function()
						self:__play_animation_func(self._spine_model._panel, "mainGunOpenGlassOnIdle", true, nil)
					end)
				else
					self:__play_animation_func(self._spine_model._panel, "boobs", false, function()
						self:__play_animation_func(self._spine_model._panel, "mainGunOpenGlassOnIdle", true, nil)
					end)
				end
			end
		end
	end

	function arg_1_0:__set_spine_talk_show(arg_37_1)
		if not self._control.model_layer.talk.gameObject.activeSelf then
			self._control.model_layer.talk.bg1.bg3:SetActive(false)
			self._control.model_layer.talk.bg1.bg2:SetActive(true)

			self._control.model_layer.talk.bg1.transform.rotation = var_0_35.New(0, 0, 0)
			self._control.model_layer.talk.bg1.transform.localRotation = var_0_35(0, 0, 0)
			self._control.model_layer.talk.rectTransform.anchoredPosition = var_0_34(219, -275)

			self:__show_talk(arg_37_1)

			local var_37_3 = self._control.model_layer.talk.rectTransform.anchoredPosition.x
			local var_37_5 = var_0_31.height - math.abs(self._control.model_layer.rectTransform.anchoredPosition.y) - (self._control.model_layer.talk.bg1.rectTransform.rect.height + self._control.model_layer.talk.bg1.bg2.rectTransform.rect.height + 40)
			local var_37_6 = var_0_31.width / 2 - math.abs(self._control.model_layer.rectTransform.anchoredPosition.x) - 360

			if self._control.model_layer.rectTransform.anchoredPosition.x + self._control.model_layer.talk.rectTransform.anchoredPosition.x - self._control.model_layer.talk.label_txt.rectTransform.rect.height / 2 < 600 and self._control.model_layer.rectTransform.anchoredPosition.x + self._control.model_layer.talk.rectTransform.anchoredPosition.x - self._control.model_layer.talk.label_txt.rectTransform.rect.height / 2 > 200 then
				self._control.model_layer.talk.bg1.transform.localRotation = var_0_35(0, 180, 0)
			end

			if self._control.model_layer.rectTransform.anchoredPosition.x > 0 then
				var_37_3 = var_37_3 - math.abs(360)
				self._control.model_layer.talk.rectTransform.anchoredPosition = var_0_34(var_37_3, 0)
			end

			local var_37_8 = self._control.model_layer.rectTransform.anchoredPosition.y + self._control.model_layer.talk.rectTransform.anchoredPosition.y - (self._control.model_layer.talk.label_txt.rectTransform.rect.height + 100) / 2

			if self._control.model_layer.rectTransform.anchoredPosition.y + self._control.model_layer.talk.rectTransform.anchoredPosition.y < 0 and self._control.model_layer.rectTransform.anchoredPosition.y < -120 then
				if math.abs(var_37_8) > 608.5 - (self._control.model_layer.talk.label_txt.rectTransform.rect.height + 100) then
					self._control.model_layer.talk.bg1.bg3:SetActive(true)
					self._control.model_layer.talk.bg1.bg2:SetActive(false)

					self._control.model_layer.talk.rectTransform.anchoredPosition = var_0_34(var_37_3, 0)
				end
			elseif self._control.model_layer.rectTransform.anchoredPosition.y + self._control.model_layer.talk.rectTransform.anchoredPosition.y > 0 and math.abs(var_37_8) > 191.5 - (self._control.model_layer.talk.label_txt.rectTransform.rect.height + 100) then
				self._control.model_layer.talk.rectTransform.anchoredPosition = var_0_34(var_37_3, 0 - (self._control.model_layer.rectTransform.anchoredPosition.y + self._control.model_layer.talk.rectTransform.anchoredPosition.y + self._control.model_layer.talk.label_txt.rectTransform.rect.height + 100))
			end
		end
	end

	function arg_1_0.get_obj_name(arg_38_0)
		local var_38_0 = var_0_2:getUIRoot().parent.transform:Find("UICamera"):GetComponent("Camera")
		local var_38_1 = var_38_0:ScreenToWorldPoint(var_0_25.mousePosition)
		local var_38_2 = UnityEngine.Physics2D.RaycastAll(var_0_34.New(var_38_1.x, var_38_1.y), var_0_34.zero)

		if var_38_0.Length > 0 then
			for iter_38_0 = 0, var_38_2.Length - 1 do
				if var_38_2[var_38_2.Length - 1].collider.gameObject.name and var_38_2[var_38_2.Length - 1].collider.gameObject.name ~= "" then
					return var_38_2[var_38_2.Length - 1].collider.gameObject.name
				end
			end
		end
	end

	function arg_1_0:_create_spine(arg_39_1)
		if not arg_39_1 then
			return
		end

		self:__set_idle_motions()

		self._now_spine_info = ""

		for iter_39_0, iter_39_1 in pairs(var_0_7.spine_home_scale) do
			if arg_39_1 == iter_39_1.id then
				self._now_spine_info = iter_39_1
			end
		end

		if self._now_spine_info == "" then
			return
		end

		if self._now_spine_info ~= "" then
			self:create_home_spine(arg_39_1)
			self._control.model_layer.cc_sprite:SetActive(false)
			self._control.model_layer.model_btn:SetActive(false)

			self._model_layer_is_spine = true
		end
	end

	function arg_1_0.__set_idle_motions(arg_40_0)
		arg_40_0._have_idlemotions = {
			"original",
			"original_1"
		}
		arg_40_0._have_idlemotions_mi_open = {
			"mainGunOpenGlassOnIdle_1",
			"mainGunOpenGlassOnIdle"
		}
		arg_40_0._have_idlemotions_mi_close = {
			"mainGunCloseGlassOnIdle_1",
			"mainGunCloseGlassOnIdle"
		}
	end

	function arg_1_0:_destroy_spine()
		if self._spine_model then
			self._spine_model:destroy()

			self._spine_model = nil
		end

		self._is_spine_2d = false

		if not self._is_live_2d then
			self._control.model_layer.cc_sprite:SetActive(true)
			self._control.model_layer.model_btn:SetActive(true)
		end

		self._model_layer_is_spine = false
	end

	function arg_1_0:create_live2d(arg_42_1)
		self.canot_click = false
		self.live2d_time = 0

		if self._live2d then
			self.is_close = false
			self.glass_on = false

			self:destroy_live2d()
		end

		self._live2d_parent = self._live2d_parent or self:createGameObject(var_0_7.live2d_prefab)

		local var_42_0 = self._live2d_parent.transform:Find("Main Camera"):GetComponent(typeof(UnityEngine.Camera))

		if tostring(arg_42_1) == "6_2" then
			self:_set_bsm_camera(var_42_0)
		end

		self._live2d = self:createGameObject(string.format(var_0_7.live2d_dir, arg_42_1, arg_42_1))

		self._live2d.transform:SetParent(self._live2d_parent.transform, false)

		local var_42_1 = self._live2d:GetComponent(typeof(UnityEngine.Animator))

		self:_set_live2d_pos(var_42_0)

		self._live2d:GetComponent("CubismLookController").Target = self._live2d_parent.transform:Find("clickpoint").gameObject
		self._control.raw_image.live2DController.cubismRaycaster = self._live2d:GetComponent(typeof(var_0_33.CubismRaycaster))
		self._control.raw_image.live2DController.animator = var_42_1
		self._control.raw_image.live2DController.uicamera = UnityEngine.GameObject.Find("UICamera"):GetComponent(typeof(UnityEngine.Camera))
		self._control.raw_image.live2DController.live2dCamera = var_42_0
		self._live2d_camera = self._live2d_parent.transform:Find("Main Camera"):GetComponent(typeof(UnityEngine.Camera))
		self._live2d_camera.targetTexture = self:loadTexture(var_0_7.live2d_texture)
		self._control.raw_image.rawImage.texture = self:loadTexture(var_0_7.live2d_texture)

		local var_42_2 = self:loadTextAsset(var_0_4(var_0_7.live2d_model, arg_42_1, arg_42_1))

		function self._control.raw_image.live2DController.hitaction(arg_43_0)
			local var_43_0 = var_0_12(1, 100)

			if self.canot_click then
				return
			end

			if self.glass_seq then
				self.glass_seq = self.glass_seq:Kill()
				self.glass_seq = nil
			end

			local var_43_1 = self:_safe_get_layer_weight(1)
			local var_43_2 = self:_safe_get_layer_weight(2)

			self:_safe_set_layer_weight(3, 1)

			if arg_43_0 == "HitArea" or arg_43_0 == "HitArea5" or self.is_close then
				var_0_13.To(var_0_14.DOSetter_float(function(arg_44_0)
					if self and self._control then
						self:_safe_set_layer_weight(1, arg_44_0)
					end
				end), var_43_1, 1, 0.5)

				var_43_1 = 1

				if arg_43_0 == "HitArea" or arg_43_0 == "HitArea5" then
					var_0_13.To(var_0_14.DOSetter_float(function(arg_45_0)
						if self and self._control then
							self:_safe_set_layer_weight(5, arg_45_0)
						end
					end), 0, 1, 0.5)

					local var_43_3 = self:autoKillDOTween(var_0_13.Sequence())

					var_43_3:AppendInterval(2.5)
					var_43_3:AppendCallback(function()
						var_0_13.To(var_0_14.DOSetter_float(function(arg_47_0)
							if self and self._control then
								self:_safe_set_layer_weight(5, arg_47_0)
							end
						end), 1, 0, 0.5)
					end)
				end
			elseif not self.is_close then
				var_0_13.To(var_0_14.DOSetter_float(function(arg_48_0)
					if self and self._control then
						self:_safe_set_layer_weight(1, arg_48_0)
					end
				end), var_43_1, 0, 0.5)

				var_43_1 = 0
			else
				var_0_13.To(var_0_14.DOSetter_float(function(arg_49_0)
					if self and self._control then
						self:_safe_set_layer_weight(1, arg_49_0)
					end
				end), var_43_1, 0, 0.5)
			end

			if arg_43_0 == "HitArea3" or self.glass_on then
				var_0_13.To(var_0_14.DOSetter_float(function(arg_50_0)
					if self and self._control then
						self:_safe_set_layer_weight(2, arg_50_0)
					end
				end), var_43_2, 1, 0.5)

				var_43_2 = 1
				self.glass_seq = self:autoKillDOTween(var_0_13.Sequence())
			end

			if arg_43_0 == "HitArea3" then
				self._control.raw_image.live2DController.animator:SetTrigger("HitArea6")

				local var_43_5 = self._control.raw_image.live2DController.animator:GetCurrentAnimatorStateInfo(0)
			end

			local var_43_6 = var_42_1:GetCurrentAnimatorClipInfo(0)[0].clip.name
			local var_43_7 = lx.json_decode(var_42_2.text).trigger
			local var_43_8 = ""
			local var_43_11 = ""

			if tostring(arg_42_1) == "209_2" then
				if arg_43_0 == "HitArea" and self.is_close then
					arg_43_0 = "HitArea5"
				end

				if arg_43_0 == "HitArea5" and not self.is_close then
					arg_43_0 = "HitArea"
				end
			end

			local var_43_12 = app:getSystem():getChannel()
			local var_43_13 = var_43_12 == var_0_7.channel.android_jp or var_43_12 == var_0_7.channel.iOS_jp

			for iter_43_0, iter_43_1 in pairs(var_43_7) do
				if iter_43_1.id == arg_43_0 then
					self.live2d_time = iter_43_1.delay / 1000 + 0.1

					if var_43_13 then
						var_43_8 = iter_43_1.dialogue_jp
					else
						var_43_8 = iter_43_1.dialogue

						if tostring(arg_42_1) == "6_2" then
							var_43_11 = iter_43_1.cv
						end
					end
				end
			end

			if tostring(arg_42_1) == "209_2" and arg_43_0 == "HitArea3" and not self.glass_on then
				var_0_13.To(var_0_14.DOSetter_float(function(arg_51_0)
					self:_safe_set_layer_weight(4, arg_51_0)
				end), 0, 1, 0.5)

				self.live2d_time = 3

				self.glass_seq:AppendInterval(2)
				self.glass_seq:AppendCallback(function()
					var_0_13.To(var_0_14.DOSetter_float(function(arg_53_0)
						self:_safe_set_layer_weight(4, arg_53_0)
					end), self:_safe_get_layer_weight(4), 0, 1)
				end)
				self._control.raw_image.live2DController.animator:SetInteger("random", 30)
			end

			if tostring(arg_42_1) == "209_2" then
				if arg_43_0 == "HitArea" then
					self.is_close = true
					self.live2d_time = 3
				end

				if arg_43_0 == "HitArea5" then
					self.is_close = false
					self.live2d_time = 3
				end

				if self.glass_on and arg_43_0 == "HitArea3" then
					local var_43_16 = self:autoKillDOTween(var_0_13.Sequence())

					var_43_16:AppendInterval(0.5)
					var_43_16:AppendCallback(function()
						var_0_13.To(var_0_14.DOSetter_float(function(arg_55_0)
							self:_safe_set_layer_weight(2, arg_55_0)
						end), var_43_2, 0, 1)

						var_43_2 = 0
					end)
					self._control.raw_image.live2DController.animator:CrossFade("GLASS_On", 0.3, -1, 0)

					self.glass_on = false

					return
				end

				if arg_43_0 == "HitArea3" then
					self.glass_on = true
				end
			end

			if not self.menu_is_open then
				if self.glass_on then
					var_43_0 = 30
				end

				self._control.raw_image.live2DController.animator:SetTrigger(arg_43_0)
				self._control.raw_image.live2DController.animator:SetInteger("random", var_43_0)
				self:__show_live_2d_dialogue(var_43_8, var_43_11, tostring(arg_42_1))
			end

			self.canot_click = true
		end
	end

	function arg_1_0:__onUpdate()
		if self._start_buff then
			local var_56_0 = self._buff_info.end_time - lx.ServerTime:getUtcTime()
			local var_56_1 = ""

			if var_56_0 > 59 then
				self:__show_buff_node(1, true)

				var_56_1 = var_0_4("%dm", var_56_0 / 60)
			elseif var_56_0 <= 59 and var_56_0 >= 0 then
				self:__show_buff_node(1, true)

				var_56_1 = var_0_4("%ds", var_56_0)
			else
				self._start_buff = false

				self:__show_buff_node(1, false)
			end

			self._control.left_upon.node.on_button_buff.buff_time.text.text = var_56_1
		end

		if self._start_cook_buff then
			local var_56_2 = lx.ServerTime:getUtcTime()

			self._user_data = var_0_3:get_use_info_data()

			local var_56_3 = ""

			if self._user_data.exp_card - var_56_2 > 59 then
				self._buff_contents[2]:SetActive(true)

				var_56_3 = var_0_4("%dm", (self._user_data.exp_card - var_56_2) / 60)
			elseif self._user_data.exp_card - var_56_2 <= 59 and self._user_data.exp_card - var_56_2 >= 0 then
				self._buff_contents[2]:SetActive(true)

				var_56_3 = var_0_4("%ds", self._user_data.exp_card - var_56_2)
			else
				self._start_cook_buff = false

				self._buff_contents[2]:SetActive(false)
			end

			self._buff_contents[2].buff_time.text.text = var_56_3
		end

		if self._start_race_buff then
			local var_56_4 = self._race_buff_info.end_time - lx.ServerTime:getUtcTime()
			local var_56_5 = ""

			if var_56_4 > 59 then
				self:__show_buff_node(3, true)

				var_56_5 = var_0_4("%dm", var_56_4 / 60)
			elseif var_56_4 <= 59 and var_56_4 >= 0 then
				self:__show_buff_node(3, true)

				var_56_5 = var_0_4("%ds", var_56_4)
			else
				self._start_race_buff = false

				self:__show_buff_node(3, false)
			end

			self._control.left_upon.node.on_furniture_button_buff.buff_time.text.text = var_56_5
		end

		if self._start_combatshop_exp_buff then
			local var_56_6 = lx.ServerTime:getUtcTime()

			self._user_data = var_0_3:get_use_info_data()

			local var_56_7 = ""

			if self._user_data.combatshop_exp_card - var_56_6 > 59 then
				self:__show_buff_node(4, true)

				var_56_7 = var_0_4("%dm", (self._user_data.combatshop_exp_card - var_56_6) / 60)
			elseif self._user_data.combatshop_exp_card - var_56_6 <= 59 and self._user_data.combatshop_exp_card - var_56_6 >= 0 then
				self:__show_buff_node(4, true)

				var_56_7 = var_0_4("%ds", self._user_data.combatshop_exp_card - var_56_6)
			else
				self._start_combatshop_exp_buff = false

				self:__show_buff_node(4, false)
			end

			self._control.left_upon.node.on_combatshop_button_buff.buff_time.text.text = var_56_7
		end

		if self._start_combatshop_tactics_buff then
			local var_56_8 = lx.ServerTime:getUtcTime()

			self._user_data = var_0_3:get_use_info_data()

			local var_56_9 = ""

			if self._user_data.combatshop_tactics_card - var_56_8 > 59 then
				self:__show_buff_node(5, true)

				var_56_9 = var_0_4("%dm", (self._user_data.combatshop_tactics_card - var_56_8) / 60)
			elseif self._user_data.combatshop_tactics_card - var_56_8 <= 59 and self._user_data.combatshop_tactics_card - var_56_8 >= 0 then
				self:__show_buff_node(5, true)

				var_56_9 = var_0_4("%ds", self._user_data.combatshop_tactics_card - var_56_8)
			else
				self._start_combatshop_tactics_buff = false

				self:__show_buff_node(5, false)
			end

			self._control.left_upon.node.on_combattactics_button_buff.buff_time.text.text = var_56_9
		end

		if self.scorll_auto == true and self.is_down == false then
			self.time = Time.deltaTime + self.time

			if self.time >= 3 then
				self.time = 0

				self:__acticity_scorll_auto_event()
			end

			self:__acticity_scorll_jump_event()
		end

		if self.is_down == true then
			self.time = 0

			if var_0_25.GetMouseButtonDown(0) then
				self._start_pos = var_0_25.mousePosition
			end

			if var_0_25.GetMouseButtonUp(0) then
				self._control.mp_activity_node.cover:SetActive(false)

				self._end_pos = var_0_25.mousePosition

				if self._start_pos and self._end_pos then
					self:__mouse_drag_event()
				end

				self.is_down = false
			end
		end

		if self.surplus_time then
			self.surplus_time = self.surplus_time - Time.deltaTime

			if self.surplus_time < 0 and self._sure_come then
				self:__refresh_acticity()

				local var_56_10 = self:autoKillDOTween(var_0_13.Sequence())

				var_56_10:AppendInterval(0.025)
				var_56_10:AppendCallback(function()
					self:__acticity_scorll(true)

					self._sure_come = false
				end)
				var_56_10:Play()
			end
		end

		if self.canot_click then
			self.live2d_time = self.live2d_time - Time.deltaTime

			if self.live2d_time <= 0 then
				self.canot_click = false
			end
		end

		if self._ui_close_state then
			self:refresh_view_scale()
		end

		if gamecore.user:isGameIng() then
			if app:getSystem():getChannel() == var_0_7.channel.android_yyb and var_0_2:getInstance("enter_game") then
				var_0_2:destroyInstance("enter_game")
			end
		end

		if self._limit_time_task > 0 then
			self:update_task_limit_time()
		end

		self:__update_red_dot()

		if self._allow_mouse_move and not var_0_37:isAuditVersion() then
			if var_0_25.GetMouseButtonDown(0) then
				self._ship_pos_start_pos = var_0_25.mousePosition
			end

			if var_0_25.GetMouseButtonUp(0) then
				self._ship_pos_end_pos = var_0_25.mousePosition

				if self._ship_pos_start_pos and self._ship_pos_end_pos then
					self:__set_mouse_up_event()
				end
			end
		end

		self:_model_spine_click()
		self:__inspect_spine_idleAnimation()
	end

	function arg_1_0:__set_mouse_up_event()
		local var_58_0, var_58_1 = var_0_29.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, self._ship_pos_start_pos, self._ui_camera, nil)

		if 160 >= math.abs(self._ship_pos_end_pos.x - self._ship_pos_start_pos.x) or #lx.clone_table((var_0_3:get_secretary_info())) == 1 or self._control.mp_activity_node.rectTransform.anchoredPosition.x - 198 < var_58_1.x then
			return
		end

		if self._ship_pos_end_pos.x - self._ship_pos_start_pos.x or self._ship_pos_end_pos.x - self._ship_pos_start_pos.x then
			self._role_sp_change = false

			if self._ship_pos_end_pos.x - self._ship_pos_start_pos.x < -300 or 160 < self._ship_pos_end_pos.y - self._ship_pos_start_pos.y then
				self._secretary_rand_num = self._secretary_rand_num + 1

				self:updata_model(true)
			elseif 160 < self._ship_pos_end_pos.x - self._ship_pos_start_pos.x or self._ship_pos_end_pos.y - self._ship_pos_start_pos.y < -300 then
				self._secretary_rand_num = self._secretary_rand_num - 1

				self:updata_model(true)
			end
		end

		if self._model_talk_seq then
			self._model_talk_seq:Pause()
			self._model_talk_seq:Kill()
		end

		var_0_21:destroyCV()
		self._control.model_layer.talk.popVerticalAdaptive:SetText("")

		self._control.model_layer.talk.label_txt.text.text = ""

		self._control.model_layer.talk.gameObject:SetActive(false)

		self._room_end_pos = nil
		self._room_start_pos = nil
	end

	function arg_1_0._set_live2d_pos(arg_59_0, arg_59_1)
		if var_0_31.width / var_0_31.height < 2.18 and var_0_31.width / var_0_31.height > 2.16 then
			arg_59_1.transform.localPosition = var_0_35(-0.21, 0.24, -1.48)
		elseif var_0_31.width / var_0_31.height > 2 and var_0_31.width / var_0_31.height < 2.12 then
			arg_59_1.transform.localPosition = var_0_35(0, 0.1, -1.48)
		elseif var_0_31.width / var_0_31.height > 1.3 and var_0_31.width / var_0_31.height < 1.4 then
			arg_59_1.transform.localPosition = var_0_35(0, -0.1, -1.48)
		elseif var_0_31.width / var_0_31.height >= 1.7 and var_0_31.width / var_0_31.height < 1.8 then
			arg_59_1.transform.localPosition = var_0_35(0.12, 0.1, -1.48)
		elseif var_0_31.width / var_0_31.height < 2.1 and var_0_31.width / var_0_31.height > 1.99 then
			arg_59_1.transform.localPosition = var_0_35(0, 0.16, -1.48)
		elseif var_0_31.width / var_0_31.height > 2.14 and var_0_31.width / var_0_31.height < 2.2 then
			arg_59_1.transform.localPosition = var_0_35(0.3, 0, -1.48)
		elseif var_0_31.width / var_0_31.height > 2.2 and var_0_31.width / var_0_31.height < 2.4 then
			arg_59_1.transform.localPosition = var_0_35(-0.2, 0.1, -1.48)
		end
	end

	function arg_1_0:play_first_in_animation(arg_60_1)
		if self._is_live_2d then
			var_0_7:play_in_out_animation(self._control.first_in_tween.uITweenSequence, true, arg_60_1)
		end

		local var_60_1 = var_0_24:getKeyData(var_0_7.setting_key_list.setting_scene_change)

		if var_60_1 ~= "" then
			if var_0_9(var_60_1).value ~= "" then
				-- block empty
			end
		end

		if not false then
			self:getCreate3DScene(false)
			var_0_7:play_in_out_animation(self._control.background.uITweenSequence, true)
		else
			self:getCreate3DScene(true)
			self._control.background:SetActive(false)
		end
	end

	function arg_1_0._set_bsm_camera(arg_61_0, arg_61_1)
		arg_61_1.orthographicSize = var_0_31.width / var_0_31.height > 1.3 and var_0_31.width / var_0_31.height < 1.4 and 0.85 or var_0_31.width / var_0_31.height > 1.43 and var_0_31.width / var_0_31.height < 1.44 and 0.75 or 1
	end

	function arg_1_0:__update_red_dot()
		local var_62_0, var_62_1 = var_0_27.get_sequence()
		local var_62_2 = false

		for iter_62_0, iter_62_1 in ipairs(var_62_0) do
			local var_62_3, var_62_4 = var_0_3:check_expedition_state(iter_62_1.id)

			if var_62_3 == var_0_7.expedition_state.done then
				var_62_2 = true

				break
			end
		end

		self._control.bottom.btn_out.red_image:SetActive(var_62_2)

		if var_62_2 then
			self._control.bottom.btn_out.new:SetActive(false)
		end
	end

	function arg_1_0:play_in_out_animation(arg_63_1, arg_63_2)
		self:set_top_ui_open(arg_63_1)

		local var_63_0 = true
		local var_63_1 = var_0_24:getKeyData(var_0_7.setting_key_list.setting_scene_change)

		if var_63_1 ~= "" then
			local var_63_2 = var_0_9(var_63_1).value

			if var_63_2 ~= "" then
				var_63_0 = var_63_2
			end
		end

		if not var_63_0 then
			self:getCreate3DScene(false)
			var_0_7:play_in_out_animation(self._control.background.uITweenSequence, arg_63_1, arg_63_2)
		else
			self:getCreate3DScene(true)
			self._control.background:SetActive(false)
		end

		var_0_7:play_in_out_animation(self._control.model_seq.uITweenSequence, arg_63_1)
	end

	function arg_1_0:getCreate3DScene(arg_64_1)
		local var_64_0 = var_0_7.main_special_bg and var_0_7.main_bg_3D[var_0_7.main_special__bg_3D] or var_0_7.main_bg_3D[self:__get_season()]

		local function var_64_1(arg_65_0)
			local var_65_0 = self:createGameObject(arg_65_0)

			var_65_0.transform:SetParent(self._control.camera_parent.transform)

			var_65_0.transform.localScale = var_0_35.one
			var_65_0.transform.localPosition = var_0_34.New(20, 0)

			var_65_0.gameObject:SetActive(true)

			return var_65_0
		end

		if self._control.camera_parent.transform.childCount == 0 and false then
			self._control.camera_parent:SetActive(true)

			self._scene_main = var_64_1(var_64_0)
		else
			if not self._scene_main and self._control.camera_parent.transform.childCount > 0 then
				self._scene_main = self._control.camera_parent.transform:GetChild(0)
			end

			if self._scene_main then
				self._control.camera_parent:SetActive(false)
			end
		end

		if self._scene_main and false then
			self:destroyGameObject(self._scene_main)

			self._scene_main = var_64_1(var_64_0)

			local var_64_2 = self._scene_main.transform:GetChild(0):GetComponent(typeof(MainCameraRotate))

			var_64_2 = var_64_2 or self._scene_main.transform:GetChild(0).gameObject:AddComponent(typeof(MainCameraRotate))
			var_64_2.vertRotateRateScale = 0.15
			var_64_2.horiRotateRateScale = 0.2
			var_64_2.restoreRate = 0.005
			var_64_2.reverse_X = false
			var_64_2.reverse_Y = false
			var_64_2.need_back = true
		end
	end

	function arg_1_0:init_float()
		self:update_dock_float()
		self:update_mail_float()
		self:update_shop_float()
		self:update_friend_float()
		self:update_sign_float()
		self:update_cook_buff_float()
		self:update_mysterious_textbook_buff_float()
		self:update_combatshop_mysterious_textbook_buff_float()
		self:update_combatshop_tactics_textbook_buff_float()
		self:update_race_buff_float()
		self:update_first_top_up_float()
		self:update_collection_flag()
		self:update_task_limit_time(true)
		self:update_phone_bind_float()
		self:update_ten_buy_float()
		self:update_figurines_float()
		self:update_level_award_float()
	end

	function arg_1_0:update_dock_float()
		self._dock_data = var_0_3:get_total_dock_data()

		local var_67_0

		for iter_67_0, iter_67_1 in ipairs(self._dock_data[var_0_7.pool_type.ship_build] or {}) do
			if iter_67_1.state == var_0_7.pool_state.finish then
				var_67_0 = true
			end
		end

		local var_67_1

		for iter_67_2, iter_67_3 in ipairs(self._dock_data[var_0_7.pool_type.equipment_build] or {}) do
			if iter_67_3.state == var_0_7.pool_state.finish then
				var_67_1 = true
			end
		end

		if var_67_1 and not var_67_0 then
			self._dock_finish_type = var_0_7.pool_type.equipment_build
		elseif var_67_0 or var_67_1 then
			self._dock_finish_type = var_0_7.pool_type.ship_build
		end

		self._control.bottom.main_float_content[var_0_41.dock_float]:SetActive(var_67_0 or var_67_1)
	end

	function arg_1_0:update_mail_float()
		local var_68_0, var_68_1 = var_0_3:get_new_mail_flag()

		self._control.bottom.main_float_content[var_0_41.mail_float]:SetActive(var_68_0)

		if is_enter_mail == true then
			self._control.bottom.main_float_content[var_0_41.mail_float]:SetActive(false)
		end

		if var_68_1 >= var_0_7.mail_const.mail_prompt_num and var_68_0 then
			self._control.bottom.main_float_content[var_0_41.mail_float].icon.image.sprite = self:loadSprite(var_0_7.mail_full)
			self._control.bottom.main_float_content[var_0_41.mail_float].halo.image.sprite = self:loadSprite(var_0_7.mail_full_rotation)
			self._control.bottom.main_float_content[var_0_41.mail_float].num.text.text = var_68_1

			self._control.bottom.main_float_content[var_0_41.mail_float].num.gameObject:SetActive(true)
			self._control.bottom.main_float_content[var_0_41.mail_float].red.gameObject:SetActive(true)
		end
	end

	function arg_1_0:update_shop_float()
		for iter_69_0, iter_69_1 in pairs(self._shop_config_list) do
			if iter_69_1.type == 2 then
				local var_69_0 = false

				if iter_69_1.start_time > 0 and iter_69_1.end_time > 0 then
					var_69_0 = var_0_10._get_open_time(iter_69_1.start_time, iter_69_1.end_time)
				end

				if var_69_0 then
					self._control.bottom.main_float_content[var_0_41.shop_float]:SetActive(var_69_0)

					return
				end
			end
		end

		self._control.bottom.main_float_content[var_0_41.shop_float]:SetActive(false)
	end

	function arg_1_0:update_friend_float()
		self._control.bottom.main_float_content[var_0_41.friend_float]:SetActive((var_0_3:get_new_friend_req_flag()))
	end

	function arg_1_0:update_sign_float()
		if self._user_data.once_login_award.cumulative_days > 10 then
			self._control.bottom.main_float_content[var_0_41.sign_float]:SetActive(false)
		else
			self._control.bottom.main_float_content[var_0_41.sign_float]:SetActive(true)
		end
	end

	function arg_1_0:update_cook_buff_float()
		self._start_buff = false
		self._buff_info = var_0_3:get_restaurant_cookbook_buff()

		if next(self._buff_info) then
			if lx.ServerTime:getUtcTime() < self._buff_info.end_time then
				self._buff_end_time = self._buff_info.end_time
				self._start_buff = true

				self:__show_buff_node(1, true)

				local var_72_0 = var_0_20.find_object_by_cid(self._buff_info.id)

				self._buff_tip_info_list[1] = {
					title = var_72_0.title,
					content = self:__get_txt(var_72_0.effect_desc)
				}
			else
				self:__show_buff_node(1, false)
			end
		else
			self:__show_buff_node(1, false)
		end
	end

	function arg_1_0:update_mysterious_textbook_buff_float()
		self._start_cook_buff = false
		self._user_data = var_0_3:get_use_info_data()

		if lx.ServerTime:getUtcTime() < self._user_data.exp_card then
			self._start_cook_buff = true

			self._buff_contents[2]:SetActive(true)

			local var_73_0 = var_0_30.find_object_by_cid(var_0_7.shop_const.mysterious_textbook_buff_cid)

			self._buff_tip_info_list[2] = {
				title = var_73_0.title,
				content = var_0_1:convert_rich_text((var_0_7.open_broken or nil) and var_73_0.desc)
			}
		else
			self._buff_contents[2]:SetActive(false)
		end
	end

	function arg_1_0:update_race_buff_float()
		self._start_race_buff = false
		self._race_buff_info = var_0_3:get_dormitory_race_buff()

		if self._race_buff_info and self._race_buff_info.end_time ~= nil then
			if lx.ServerTime:getUtcTime() < self._race_buff_info.end_time then
				self._buff_end_time = self._race_buff_info.end_time
				self._start_race_buff = true

				self:__show_buff_node(3, true)

				local var_74_0 = var_0_26.find_object_by_cid(self._race_buff_info.id)

				self._buff_tip_info_list[3] = {
					title = var_74_0.title,
					content = var_0_4(var_0_1:convert_rich_text(var_74_0.buff_desc), var_0_1:getNowLang(var_0_7:get_country_language_key(self._race_buff_info.country)))
				}
			else
				self:__show_buff_node(3, false)
			end
		else
			self:__show_buff_node(3, false)
		end
	end

	function arg_1_0:update_combatshop_mysterious_textbook_buff_float()
		self._start_combatshop_exp_buff = false
		self._user_data = var_0_3:get_use_info_data()

		if self._user_data.combatshop_exp_card and lx.ServerTime:getUtcTime() < self._user_data.combatshop_exp_card then
			self._start_combatshop_exp_buff = true

			self._buff_contents[4]:SetActive(true)

			local var_75_0 = var_0_30.find_object_by_cid(var_0_7.shop_const.making_mysterious_textbook_buff_cid)

			self._buff_tip_info_list[4] = {
				title = var_75_0.title,
				content = var_0_1:convert_rich_text((var_0_7.open_broken or nil) and var_75_0.desc)
			}
		else
			self._buff_contents[4]:SetActive(false)
		end
	end

	function arg_1_0:update_combatshop_tactics_textbook_buff_float()
		self._start_combatshop_tactics_buff = false
		self._user_data = var_0_3:get_use_info_data()

		if self._user_data.combatshop_tactics_card and lx.ServerTime:getUtcTime() < self._user_data.combatshop_tactics_card then
			self._start_combatshop_tactics_buff = true

			self._buff_contents[5]:SetActive(true)

			local var_76_0 = var_0_30.find_object_by_cid(var_0_7.shop_const.making_tactics_textbook_buff_cid)

			self._buff_tip_info_list[5] = {
				title = var_76_0.title,
				content = var_0_1:convert_rich_text((var_0_7.open_broken or nil) and var_76_0.desc)
			}
		else
			self._buff_contents[5]:SetActive(false)
		end
	end

	function arg_1_0:update_first_top_up_float()
		self.user_info = var_0_3:get_use_info_data()

		local var_77_0 = var_0_3:get_account_id()

		if var_0_38:getDataByID("first_top_up_data", var_77_0) == "" then
			var_0_38:setDataByID("first_top_up_data", var_77_0, "true")

			if not self.user_info.first_pay and not self.user_info.first_get or self.user_info.first_pay and not self.user_info.first_get then
				self:set_first_top_up_state(true)
			else
				self:set_first_top_up_state(false)
			end
		elseif not self.user_info.first_get and self.user_info.first_pay then
			self:set_first_top_up_state(true)
		else
			self:set_first_top_up_state(false)
		end
	end

	function arg_1_0:set_first_top_up_state(arg_78_1)
		self._control.bottom.main_float_content[var_0_41.first_top_up_float]:SetActive(arg_78_1)
	end

	function arg_1_0:update_collection_flag()
		local var_79_0 = var_0_3:get_player_unlock_medal_data()

		self._control.bottom.main_float_content[var_0_41.collection_float]:SetActive((var_0_3:get_new_collection_flag() or var_79_0 and next(var_79_0)) and true)
	end

	function arg_1_0:update_phone_bind_float()
		local var_80_0 = app:getSystem():getChannel()

		if var_80_0 == var_0_7.channel.android_xiaomi or var_80_0 == var_0_7.channel.android_yyb or var_80_0 == var_0_7.channel.android_jp or var_80_0 == var_0_7.channel.iOS_jp then
			return
		end

		if var_0_37:isAuditVersion() then
			return
		end

		self._control.bottom.main_float_content[var_0_41.bind_phone_float]:SetActive(not var_0_3:get_use_info_data().binding_phone_hint)
	end

	function arg_1_0:update_ten_buy_float()
		local var_81_0 = var_0_24:getKeyData("is_click_buy_ten") == ""

		self._control.bottom.main_float_content[var_0_41.buy_ten_float]:SetActive((1730390399 < lx.ServerTime:getUtcTime() or nil) and false)
	end

	function arg_1_0:update_figurines_float()
		local var_82_0 = var_0_24:getKeyData("is_click_buy_figurines") == ""

		self._control.bottom.main_float_content[var_0_41.figurines_float]:SetActive((1737442800 < lx.ServerTime:getUtcTime() or nil) and false)
	end

	function arg_1_0:update_level_award_float()
		local var_83_0 = self:is_have_level_award()

		if var_83_0 then
			self._control.bottom.main_float_content[var_0_41.level_float]:SetActive(var_83_0)
		else
			self._control.bottom.main_float_content[var_0_41.level_float]:SetActive(false)
		end
	end

	function arg_1_0:update_task_limit_time(arg_84_1)
		if self._limit_left_time <= 0 or arg_84_1 then
			self._limit_time_task = var_0_3:__get_limit_time()
		end

		if self._limit_time_task == 0 then
			self._control.bottom.btn_task.task_bg:SetActive(false)

			return
		end

		self._control.bottom.btn_task.task_bg:SetActive(true)

		local var_84_0 = ""
		local var_84_1 = self._limit_time_task - lx.ServerTime:getUtcTime()

		if var_84_1 < 0 then
			var_84_1 = 0
		end

		self._limit_left_time = var_84_1

		if var_84_1 > 86400 then
			var_84_0 = var_0_4(var_0_1:getNowLang("daysleft3"), math.floor(var_84_1 / 86400))
		elseif var_84_1 > 3600 then
			var_84_0 = var_0_4(var_0_1:getNowLang("hourleft2"), math.floor(var_84_1 / 3600))
		elseif var_84_1 > 60 then
			var_84_0 = var_0_4(var_0_1:getNowLang("minleft2"), math.floor(var_84_1 / 60))
		elseif var_84_1 > 0 and var_84_1 <= 60 then
			var_84_0 = var_0_4(var_0_1:getNowLang("secleft2"), math.floor(var_84_1))
		end

		self._control.bottom.btn_task.task_bg.limit_time.text.text = var_84_0

		if gamecore.util_func.check_channel_is_en() then
			self._control.bottom.btn_task.task_bg.limit_time.text.fontSize = 15
			self._control.bottom.btn_task.task_bg.transform.sizeDelta = var_0_34(80, 40)
		else
			self._control.bottom.btn_task.task_bg.limit_time.text.fontSize = 19
			self._control.bottom.btn_task.task_bg.transform.sizeDelta = var_0_34(85, 22)
		end
	end

	function arg_1_0:play_open_ui_animation(arg_85_1, arg_85_2)
		self:set_top_ui_open(arg_85_1)
		var_0_7:play_in_out_animation(self._control.open_or_close_ui.uITweenSequence, arg_85_1, arg_85_2)
	end

	function arg_1_0:play_model_animation(arg_86_1)
		var_0_7:play_in_out_animation(self._control.model_seq.uITweenSequence, arg_86_1)
	end

	function arg_1_0:set_top_ui_open(arg_87_1)
		self._control.top.back_button.gameObject:SetActive(not arg_87_1)
		self._control.top.role_scale.gameObject:SetActive(not arg_87_1)
		self._control.top.main_save_btn.gameObject:SetActive(not arg_87_1)
		self._control.top.main_reset_btn.gameObject:SetActive(not arg_87_1)
		self._control.top.ui_open.gameObject:SetActive(arg_87_1)
		self._control.top.ui_close.gameObject:SetActive(not arg_87_1)
		self._control.model_layer.model_btn:SetActive(false)
		self._control.model_layer.model_btn_2:SetActive(not arg_87_1)

		if not arg_87_1 then
			self._control.first_in_tween.shortcut_long_btn:SetActive(false)

			if self._control.model_layer.cc_sprite.icon.rectTransform.sizeDelta.x >= 2048 then
				self:__look_over_view(true)
			else
				self:__look_over_view()
			end
		else
			self._control.model_layer.model_btn:SetActive(true)
			self._control.first_in_tween.shortcut_long_btn:SetActive(true)
		end
	end

	function arg_1_0.__get_data(arg_88_0, arg_88_1)
		local var_88_0 = var_0_24:getKeyData(arg_88_1)

		if var_88_0 ~= "" then
			var_88_0 = var_0_9(var_88_0).value
		end

		return var_88_0
	end

	function arg_1_0:set_secretary_info_show()
		if var_0_37:isAuditVersion() then
			self._control.left_upon.on_button_support:SetActive(false)
		end
	end

	function arg_1_0:updata_model(arg_90_1, arg_90_2)
		self._user_data = var_0_3:get_use_info_data()

		local var_90_0 = var_0_3:get_secretary_info()

		if arg_90_1 and var_90_0 and var_90_0.members and not next(var_90_0.members) then
			return
		end

		local var_90_1

		self._allow_mouse_move = true

		if self._secretary_rand_num == 0 and not var_0_37:isAuditVersion() then
			if var_90_0 and var_90_0.members and next(var_90_0.members) then
				if var_90_0.rand_secretary_flag == 1 and #var_90_0.members > 1 and not arg_90_2 then
					self._secretary_rand_num = var_0_12(1, #var_90_0.members)
					self._secretary_id = var_90_0.members[self._secretary_rand_num]
					var_90_1 = var_0_3:find_character_by_id(self._secretary_id)
				else
					local var_90_2 = tonumber(var_0_24:getKeyData("is_secretary_info_id"))

					if var_90_2 and var_90_2 and var_90_2 > 0 and var_0_10.have_data(var_90_0.members, var_90_2) then
						self._secretary_id = var_90_2

						for iter_90_0, iter_90_1 in pairs(var_90_0.members) do
							if iter_90_1 == var_90_2 then
								self._secretary_rand_num = iter_90_0
							end
						end

						var_90_1 = var_0_3:find_character_by_id(self._secretary_id)
					elseif var_90_0.members[1] and var_90_0.members[1] > 0 then
						self._secretary_id = var_90_0.members[1]
						self._secretary_rand_num = 0
						var_90_1 = var_0_3:find_character_by_id(self._secretary_id)
					else
						self._secretary_id = self._user_data.secretary
						self._secretary_rand_num = 0
						var_90_1 = var_0_3:find_character_by_id(self._secretary_id)
					end
				end
			else
				self._secretary_id = self._user_data.secretary

				if not self._secretary_id then
					return
				end

				var_90_1 = var_0_3:find_character_by_id(self._secretary_id)
			end
		elseif self._secretary_rand_num > 0 and not var_0_37:isAuditVersion() then
			local var_90_3 = 0

			if var_90_0 and next(var_90_0) then
				for iter_90_2, iter_90_3 in pairs(var_90_0.members) do
					if self._secretary_id == iter_90_3 then
						var_90_3 = iter_90_2 + 1
					end
				end

				if var_90_3 <= #var_90_0.members then
					for iter_90_4, iter_90_5 in pairs(var_90_0.members) do
						if var_90_3 == iter_90_4 then
							self._secretary_id = iter_90_5
						end
					end
				else
					self._secretary_id = var_90_0.members[1]
				end

				var_90_1 = var_0_3:find_character_by_id(self._secretary_id)
			end
		elseif self._secretary_rand_num < 0 and not var_0_37:isAuditVersion() then
			local var_90_4 = 0

			if var_90_0 and next(var_90_0) then
				for iter_90_6, iter_90_7 in pairs(var_90_0.members) do
					if self._secretary_id == iter_90_7 then
						var_90_4 = iter_90_6 - 1
					end
				end

				if var_90_4 >= 1 then
					for iter_90_8, iter_90_9 in pairs(var_90_0.members) do
						if var_90_4 == iter_90_8 then
							self._secretary_id = iter_90_9
						end
					end
				else
					self._secretary_id = var_90_0.members[#var_90_0.members]
				end

				var_90_1 = var_0_3:find_character_by_id(self._secretary_id)
			end
		elseif var_0_37:isAuditVersion() then
			self._secretary_id = self._user_data.secretary

			if not self._secretary_id then
				return
			end

			var_90_1 = var_0_3:find_character_by_id(self._secretary_id)
		end

		var_0_24:setKeyData("is_secretary_info_id", self._secretary_id)

		self._secretary_rand_num = 0

		local var_90_5 = var_90_1 and var_0_10.little_clone(var_90_1) or {}

		self._main_panel_cid = var_90_5.cid

		local var_90_6 = var_0_10:get_ship_attr(var_90_5, (var_0_5.find_object_by_cid(var_90_5.cid)))

		if var_90_6 and next(var_90_6) and var_90_5.hp ~= var_90_6.hp then
			var_90_5.hp = var_90_6.hp
		end

		local var_90_7 = var_0_5.find_object_by_cid(var_90_5.cid)
		local var_90_8
		local var_90_9 = ""
		local var_90_10 = ""
		local var_90_11 = var_90_0 and next(var_90_0) and (var_90_0.middle_broken_flag == 1 and var_0_10:use_big_break_painting_2(var_90_5, var_0_7.ship_icon_type.model_l, true) or var_0_10:use_big_break_painting(var_90_5, var_0_7.ship_icon_type.model_l, true)) or var_0_10:use_big_break_painting(var_90_5, var_0_7.ship_icon_type.model_l, true)

		if var_90_5.skin ~= 0 then
			local var_90_13 = var_0_6.find_object_by_cid(var_90_5.skin)

			if var_90_13 then
				local var_90_14 = var_90_13.icon

				var_90_9 = var_90_13.icon == "248_2" and "248_1" or var_90_13.live2d
				var_90_10 = var_90_14 == "248_2" and "248_1" or var_90_14 == "248_1" and "248_1" or var_90_14 == "59_1" and "59_1" or var_90_14 == "209_2" and "209_2" or var_90_14 == "6_2" and "6_2" or var_90_14 == "325_1" and "325_1" or var_90_10
				var_90_8 = var_0_7:get_ship_icon(var_90_11, var_90_14, var_90_14)
			end
		else
			var_90_8 = var_0_7:get_ship_icon(var_90_11, var_90_7.pic_id, var_90_7.pic_id)
		end

		local var_90_15 = app:getSystem():getChannel()
		local var_90_16 = var_90_15 == var_0_7.channel.android_cn or var_90_15 == var_0_7.channel.taptap or var_90_15 == var_0_7.channel.android_cn_small or var_90_15 == var_0_7.channel.default or var_90_15 == var_0_7.channel.android_yyb or var_90_15 == var_0_7.channel.android_xiaomi

		self._now_spine_id = var_90_10

		local var_90_17 = self:__get_data(var_0_7.setting_key_list.setting_live2d)

		self._is_live_2d = (var_90_17 == "" and true or var_90_17) and var_90_9 ~= "" and var_90_9 ~= "0" and not var_90_16

		self._control.mp_activity_node.mask:SetActive(self._is_live_2d)
		self._control.model_layer.cc_sprite:SetActive(not self._is_live_2d)
		self._control.model_layer.model_btn:SetActive(not self._is_live_2d)

		local var_90_18 = self:__get_data(var_0_7.setting_key_list.setting_spine)

		self._is_spine_2d = (var_90_18 == "" and true or var_90_18) and var_90_10 ~= "" and var_90_10 ~= "0" and var_90_16

		if var_90_16 then
			self._control.raw_image:SetActive(false)
		elseif self._is_live_2d then
			self._control.raw_image:SetActive(true)
		else
			self._control.raw_image:SetActive(false)
		end

		self._control.mp_activity_node.mask:SetActive(self._is_spine_2d)
		self._control.first_in_tween.shortcut_long_btn:SetActive(true)

		if self._is_live_2d then
			self._allow_mouse_move = false

			self:create_live2d(var_90_9)
		else
			self:destroy_live2d()
		end

		if self._is_spine_2d then
			self:_create_spine(var_90_10)
		else
			self:_destroy_spine()
		end

		local var_90_20, var_90_21 = self:loadSprite(var_90_8)

		self._control.model_layer.cc_sprite.icon.image.sprite = var_90_20

		if not self._is_last_picture_hd and var_90_21 then
			self._is_hd_icon = true
			self._is_init_hd_icon = true
			self._is_last_picture_hd = true
			self._init_scale = 0.5

			var_0_7:hd_sprite_half_samll_scale(self._control.model_layer.cc_sprite.icon.transform, true)
		elseif self._is_last_picture_hd and not var_90_21 then
			var_0_7:hd_sprite_half_scale_big(self._control.model_layer.cc_sprite.icon.transform, true)

			self._is_last_picture_hd = false
			self._init_scale = 1
		end

		if var_90_5 and next(var_90_5) then
			if var_90_5.skin ~= 0 then
				local var_90_22 = var_0_6.find_object_by_cid(var_90_5.skin)

				if var_90_0.middle_broken_flag ~= 1 and var_90_22.time_switchover and next(var_90_22.time_switchover) then
					local var_90_23 = tonumber(os.date("%H", (lx.ServerTime:getUtcTime())))

					for iter_90_10, iter_90_11 in pairs(var_90_22.time_switchover) do
						if var_90_23 >= iter_90_11.start_time and var_90_23 < iter_90_11.end_time then
							self:change_role_pic(iter_90_11.path, "time")
						end
					end
				end
			else
				local var_90_25 = var_0_5.find_object_by_cid(var_90_5.cid)

				if var_90_0.middle_broken_flag ~= 1 and var_90_25.time_switchover and next(var_90_25.time_switchover) then
					local var_90_26 = tonumber(os.date("%H", (lx.ServerTime:getUtcTime())))

					for iter_90_12, iter_90_13 in pairs(var_90_25.time_switchover) do
						if var_90_26 >= iter_90_13.start_time and var_90_26 < iter_90_13.end_time then
							self:change_role_pic(iter_90_13.path, "time")
						end
					end
				end
			end
		end

		if not self._is_live_2d then
			self:_update_main_position()
		end

		if not self._already_init then
			self:set_ship_bgm(var_90_5.cid, var_90_5.skin)
		end

		self:change_secretary_bgm(arg_90_1)
	end

	function arg_1_0:set_ship_bgm(arg_91_1, arg_91_2)
		local var_91_0 = var_0_3:get_use_info_data()

		if (arg_91_1 == 10000113 or arg_91_1 == 11000113) and arg_91_2 == 1000010251 then
			self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.Hood))

			self._sp_bgm = true
		elseif (arg_91_1 == 10000613 or arg_91_1 == 11000613) and arg_91_2 == 1000060151 then
			self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.Bismarck))

			self._sp_bgm = true
		elseif (arg_91_1 == 10022413 or arg_91_1 == 11022413) and arg_91_2 == 1002240151 then
			self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.formidable))

			self._sp_bgm = true
		elseif (arg_91_1 == 10022313 or arg_91_1 == 11022313) and arg_91_2 == 1002230151 then
			self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.shinano))

			self._sp_bgm = true
		elseif (arg_91_1 == 10009711 or arg_91_1 == 11009711) and arg_91_2 == 1000970351 then
			self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.changchun))

			self._sp_bgm = true
		else
			self._sp_bgm = false

			self:_bgm_play()
		end
	end

	function arg_1_0:into_home_bgm()
		self._user_data = var_0_3:get_use_info_data()

		local var_92_0 = self._secretary_id and var_0_3:find_character_by_id(self._secretary_id) or var_0_3:find_character_by_id(self._user_data.secretary)

		if var_92_0 then
			if (var_92_0.cid == 10000113 or var_92_0.cid == 11000113) and var_92_0.skin == 1000010251 then
				self._sp_bgm = true

				self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.Hood))
			elseif (var_92_0.cid == 10000613 or var_92_0.cid == 11000613) and var_92_0.skin == 1000060151 then
				self._sp_bgm = true

				self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.Bismarck))
			elseif (var_92_0.cid == 10022413 or var_92_0.cid == 11022413) and var_92_0.skin == 1002240151 then
				self._sp_bgm = true

				self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.formidable))
			elseif (var_92_0.cid == 10022313 or var_92_0.cid == 11022313) and var_92_0.skin == 1002230151 then
				self._sp_bgm = true

				self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.shinano))
			elseif (var_92_0.cid == 10009711 or var_92_0.cid == 11009711) and var_92_0.skin == 1000970351 then
				self._sp_bgm = true

				self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.changchun))
			else
				self:_bgm_play()
			end
		else
			self:_bgm_play()
		end
	end

	function arg_1_0:change_secretary_bgm(arg_93_1)
		if self._secretary_id then
			local var_93_0 = var_0_3:find_character_by_id(self._secretary_id)

			if var_93_0 then
				if (var_93_0.cid == 10000113 or var_93_0.cid == 11000113) and var_93_0.skin == 1000010251 then
					self._sp_bgm = true

					self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.Hood))
				elseif (var_93_0.cid == 10000613 or var_93_0.cid == 11000613) and var_93_0.skin == 1000060151 then
					self._sp_bgm = true

					self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.Bismarck))
				elseif (var_93_0.cid == 10022413 or var_93_0.cid == 11022413) and var_93_0.skin == 1002240151 then
					self._sp_bgm = true

					self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.formidable))
				elseif (var_93_0.cid == 10022313 or var_93_0.cid == 11022313) and var_93_0.skin == 1002230151 then
					self._sp_bgm = true

					self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.shinano))
				elseif (var_93_0.cid == 10009711 or var_93_0.cid == 11009711) and var_93_0.skin == 1000970351 then
					self._sp_bgm = true

					self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.changchun))
				elseif not arg_93_1 or self._last_secretary_cid == 10000113 or self._last_secretary_cid == 11000113 or self._last_secretary_cid == 10000613 or self._last_secretary_cid == 11000613 or self._last_secretary_cid == 10022413 or self._last_secretary_cid == 11022413 or self._last_secretary_cid == 10022313 or self._last_secretary_cid == 11022313 or self._last_secretary_cid == 10009711 or self._last_secretary_cid == 11009711 then
					self:_bgm_play()
				end

				self._last_secretary_cid = var_93_0.cid
			else
				self:_bgm_play()
			end
		end
	end

	function arg_1_0.init_issignin(arg_94_0)
		local var_94_0 = var_0_3:get_use_info_data().login_award.is_already_get

		if var_94_0 then
			-- block empty
		elseif not var_94_0 and var_0_3:get_close_sign() then
			-- block empty
		elseif not var_94_0 and not var_0_3:get_close_sign() and var_0_2:getInstance("home")._panel.activeSelf then
			var_0_2:createInstance("signin"):show(true)
		end
	end

	function arg_1_0:init_announcement(arg_95_1)
		local var_95_0 = var_0_3:get_is_first_auth()
		local var_95_1 = var_0_3:get_use_info_data().daily_notice
		local var_95_2, var_95_3, var_95_4, var_95_5, var_95_6, var_95_7, var_95_8, var_95_9 = string.find(var_0_24:getKeyData("announcement"), "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
		local var_95_10, var_95_11, var_95_12, var_95_13, var_95_14, var_95_15, var_95_16, var_95_17 = string.find(lx.Time:getDateString(), "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")

		if not var_95_1 and var_0_3:get_close_announcement() or arg_95_1 then
			if var_95_0 and not var_95_1 then
				var_0_24:setKeyData("announcement_1", nil)
				var_0_3:req_AnnouncementRefreshReq()
			end
		else
			self:init_issignin()
		end
	end

	function arg_1_0:get_guide_btn_pos_info(arg_96_1)
		if arg_96_1 == var_0_7.guide_const_id.first_group.one or arg_96_1 == var_0_7.guide_const_id.nine_group.zero then
			return self._control.bottom.btn_out.transform
		elseif arg_96_1 == var_0_7.guide_const_id.second_group.zero or arg_96_1 == var_0_7.guide_const_id.five_group.zero or arg_96_1 == var_0_7.guide_const_id.seven_group.zero then
			return self._control.bottom.btn_task.transform
		elseif arg_96_1 == var_0_7.guide_const_id.third_group.one or arg_96_1 == var_0_7.guide_const_id.four_group.zero or arg_96_1 == var_0_7.guide_const_id.eight_group.zero then
			return self._control.bottom.btn_ship.transform
		elseif arg_96_1 == var_0_7.guide_const_id.six_group.zero then
			return self._control.bottom.menu_btn.transform
		end
	end

	function arg_1_0:_finish_task()
		self._control.bottom.task_event.gameObject:SetActive(false)
		self:_get_task_info()

		local var_97_0 = var_0_16(self._task_array)

		for iter_97_0 = #var_97_0, 1, -1 do
			if var_97_0[iter_97_0].state == 2 then
				var_0_17(var_97_0, iter_97_0)
			end

			if var_97_0[iter_97_0] then
				local var_97_1 = var_0_23.find_object_by_cid(var_97_0[iter_97_0].id)

				if var_97_1 then
					if var_97_1.end_utc_time and lx.ServerTime:getUtcTime() > var_97_1.end_utc_time then
						var_0_17(var_97_0, iter_97_0)
					end
				end
			end
		end

		for iter_97_1, iter_97_2 in pairs(var_97_0) do
			local var_97_2 = var_0_23.find_object_by_cid(iter_97_2.id)

			if var_97_2 then
				for iter_97_3, iter_97_4 in pairs(iter_97_2.progresses) do
					if iter_97_4.counter / var_97_2.condition[2] * 100 >= 100 then
						self._control.bottom.task_event.gameObject:SetActive(true)

						break
					end
				end
			end
		end
	end

	function arg_1_0:_task_light()
		self._control.bottom.btn_task.light.image.gameObject:SetActive(false)
		self:_get_task_info()

		local var_98_0 = lx.ServerTime:getUtcTime()

		for iter_98_0, iter_98_1 in pairs(self._task_array) do
			local var_98_1 = var_0_23.find_object_by_cid(iter_98_1.id)

			if var_98_1 then
				if var_98_1.type == 4 and iter_98_1.state == 1 and var_98_0 < var_98_1.end_utc_time and var_98_1.start_utc_time < var_98_0 then
					self._control.bottom.btn_task.light.image.gameObject:SetActive(true)

					break
				end
			end
		end

		if not self._control.bottom.btn_task.light.image.gameObject.activeSelf then
			return
		end

		self._control.bottom.btn_task.light.canvasGroup.alpha = 0
		self._task_light_seq = self:autoKillDOTween(var_0_13.Sequence())

		self._task_light_seq:AppendInterval(0.5)
		self._task_light_seq:Append(self._control.bottom.btn_task.light.canvasGroup:DOFade(1, 1))
		self._task_light_seq:AppendInterval(0.5)
		self._task_light_seq:Append(self._control.bottom.btn_task.light.canvasGroup:DOFade(0, 1))
		self._task_light_seq:SetLoops(-1)
		self._task_light_seq:Play()
	end

	function arg_1_0:__not_pass_map_light(arg_99_1)
		if arg_99_1 == nil then
			arg_99_1 = false
		end

		self._control.bottom.btn_out.light:SetActive(arg_99_1)
		self._control.bottom.btn_out.new:SetActive(arg_99_1)

		if not arg_99_1 then
			return
		end

		self._control.bottom.btn_out.light.canvasGroup.alpha = 0
		self._act_light_seq = self:autoKillDOTween(var_0_13.Sequence())

		self._act_light_seq:AppendInterval(0.5)
		self._act_light_seq:Append(self._control.bottom.btn_out.light.canvasGroup:DOFade(1, 1))
		self._act_light_seq:AppendInterval(0.5)
		self._act_light_seq:Append(self._control.bottom.btn_out.light.canvasGroup:DOFade(0, 1))
		self._act_light_seq:SetLoops(-1)
		self._act_light_seq:Play()
	end

	function arg_1_0:_get_task_info()
		self._task_array = {}

		for iter_100_0, iter_100_1 in pairs((var_0_3:get_task_list())) do
			var_0_15(self._task_array, iter_100_1)
		end
	end

	function arg_1_0:updata_user_res()
		local var_101_0 = var_0_11.find_object_by_level(self._user_data.level)

		self._user_data = var_0_3:get_use_info_data()
		self._control.top.user_res_bar.right_upon.oil_bg.oil_txt.text.text = var_0_10.get_simplify_num(self._user_data.oil)
		self._control.top.user_res_bar.right_upon.steel_bg.steel_txt.text.text = var_0_10.get_simplify_num(self._user_data.fe)
		self._control.top.user_res_bar.right_upon.aluminum_bg.aluminum_txt.text.text = var_0_10.get_simplify_num(self._user_data.al)
		self._control.top.user_res_bar.right_upon.bullet_bg.bullet_txt.text.text = var_0_10.get_simplify_num(self._user_data.bullet)
		self._control.top.user_res_bar.right_upon.diamond_bg.diamond_txt.text.text = var_0_10.get_simplify_num(self._user_data.diamond)
		self._control.blur_layer.resource_mask.layer_1.txt.text.text = var_0_10.get_simplify_num(self._user_data.oil) .. "/" .. var_101_0.resources_top
		self._control.blur_layer.resource_mask.layer_2.txt.text.text = var_0_10.get_simplify_num(self._user_data.bullet) .. "/" .. var_101_0.resources_top
		self._control.blur_layer.resource_mask.layer_3.txt.text.text = var_0_10.get_simplify_num(self._user_data.fe) .. "/" .. var_101_0.resources_top
		self._control.blur_layer.resource_mask.layer_4.txt.text.text = var_0_10.get_simplify_num(self._user_data.al) .. "/" .. var_101_0.resources_top
	end

	function arg_1_0:open_fight_red_image()
		local var_102_0, var_102_1 = var_0_27.get_sequence()
		local var_102_2 = false

		for iter_102_0, iter_102_1 in ipairs(var_102_0) do
			local var_102_3, var_102_4 = var_0_3:check_expedition_state(iter_102_1.id)

			if var_102_3 == var_0_7.expedition_state.done then
				var_102_2 = true

				break
			end
		end

		self._control.bottom.fight_event:SetActive(var_102_2)
	end

	function arg_1_0.set_guide_task_state(arg_103_0, arg_103_1)
		if arg_103_1 then
			local var_103_0 = var_0_2:createInstance("guide_panel_mask")

			var_103_0:show()
			var_103_0:set_mask_state(true)
		end

		arg_103_0._record_task_state = arg_103_1
	end

	function arg_1_0:get_guide_task_state()
		return self._record_task_state
	end

	function arg_1_0:destroy_live2d()
		self.is_close = false
		self.glass_on = false
		self.canot_click = false
		self.live2d_time = 0

		if self.glass_seq then
			self.glass_seq:Kill()

			self.glass_seq = nil
		end

		if self._live2d then
			self:destroyGameObject(self._live2d)

			self._live2d = nil
		end

		if self._live2d_parent then
			self:destroyGameObject(self._live2d_parent)

			self._live2d_parent = nil
		end
	end

	function arg_1_0:_get_animator_layer_count()
		if self._control and self._control.raw_image then
			if self._control.raw_image.live2DController.animator then
				return self._control.raw_image.live2DController.animator.layerCount
			end
		end

		return 0
	end

	function arg_1_0:_safe_set_layer_weight(arg_107_1, arg_107_2)
		if self._control and self._control.raw_image then
			if self._control.raw_image.live2DController.animator and arg_107_1 < self._control.raw_image.live2DController.animator.layerCount then
				self._control.raw_image.live2DController.animator:SetLayerWeight(arg_107_1, arg_107_2)
			end
		end
	end

	function arg_1_0:_safe_get_layer_weight(arg_108_1)
		if self._control and self._control.raw_image then
			if self._control.raw_image.live2DController.animator and arg_108_1 < self._control.raw_image.live2DController.animator.layerCount then
				return self._control.raw_image.live2DController.animator:GetLayerWeight(arg_108_1)
			end
		end

		return 0
	end

	function arg_1_0:__onVisible(arg_109_1, arg_109_2)
		self:_finish_task()

		if self._role_move_seq then
			self._role_move_seq:Restart()
		end

		if not arg_109_1 then
			self:__destroy_seq()

			return
		end
	end

	function arg_1_0:__onDestroy()
		self:__destroy_seq()
		self:destroy_live2d()
	end

	function arg_1_0:__destroy_seq()
		self:__show_model_talk_ani("", false)

		if self._task_light_seq then
			self._task_light_seq:Kill()

			self._task_light_seq = nil
		end

		if self._act_light_seq then
			self._act_light_seq:Kill()

			self._act_light_seq = nil
		end
	end

	function arg_1_0:_bgm_play()
		if self._user_data.music == 0 then
			local var_112_0 = lx.ServerTime:getUtcTime()
			local var_112_1 = tonumber(os.date("%H", var_112_0))
			local var_112_2

			if var_112_1 > 6 and var_112_1 <= 18 then
				local var_112_3 = var_0_22.find_object_by_cid(175)

				var_112_2 = self:__judge_now_time(var_112_3.start_utc_time, var_112_3.end_utc_time, var_112_0) and var_112_3.res2 or var_112_3.res
			else
				local var_112_4 = var_0_22.find_object_by_cid(275)

				var_112_2 = self:__judge_now_time(var_112_4.start_utc_time, var_112_4.end_utc_time, var_112_0) and var_112_4.res2 or var_112_4.res
			end

			self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_112_2))
		else
			self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_22.find_object_by_cid(self._user_data.music).res))
		end
	end

	function arg_1_0.__judge_now_time(arg_113_0, arg_113_1, arg_113_2, arg_113_3)
		if not arg_113_1 or not arg_113_2 then
			return false
		end

		return arg_113_1 <= arg_113_3 and arg_113_3 <= arg_113_2
	end

	function arg_1_0:__set_bg_by_time()
		local var_114_0 = tonumber(os.date("%H", (lx.ServerTime:getUtcTime())))
		local var_114_1 = self:__get_season()
		local var_114_5 = var_114_0 >= 7 and var_114_0 < 19

		self._control.flower_night.gameObject:SetActive(false)
		self._control.flower_day.gameObject:SetActive(false)
		self._control.snow_day.gameObject:SetActive(false)

		if var_0_7.main_special_flower_bg then
			-- block empty
		elseif var_114_1 == 1 then
			if var_114_5 then
				self._control.flower_day.gameObject:SetActive(true)
				self._control.flower_night.gameObject:SetActive(false)

				self._control.flower_day.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_7.main_bg_flower_day)
			else
				self._control.flower_day.gameObject:SetActive(false)
				self._control.flower_night.gameObject:SetActive(true)

				self._control.flower_night.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_7.main_bg_flower_night)
			end
		elseif var_114_1 == 4 or var_114_1 == "special_2" then
			self._control.snow_day.gameObject:SetActive(true)
		end

		self._control.background.image.sprite = self:loadSprite(var_114_0 >= 6 and var_114_0 < 8 and var_0_4(var_0_7.main_bg.main_dawn_bg, tostring(var_114_1)) or var_114_0 >= 8 and var_114_0 < 17 and var_0_4(var_0_7.main_bg.main_noon_bg, tostring(var_114_1)) or var_114_0 >= 17 and var_114_0 < 19 and var_0_4(var_0_7.main_bg.main_dusk_bg, tostring(var_114_1)) or var_0_4(var_0_7.main_bg.main_night_bg, tostring(var_114_1)))
	end

	function arg_1_0.__get_season(arg_115_0)
		local var_115_0 = tonumber(os.date("%m"))
		local var_115_1 = lx.ServerTime:getUtcTime()
		local var_115_2 = app:getSystem():getChannel()
		local var_115_3 = false
		local var_115_4 = false
		local var_115_5 = false
		local var_115_6 = false
		local var_115_7 = false
		local var_115_8 = false

		if var_115_2 == var_0_7.channel.android_jp or var_115_2 == var_0_7.channel.iOS_jp then
			var_115_3 = true
		else
			var_115_4 = true
		end

		if var_115_1 >= var_0_7.special_day.christmas_start and var_115_1 <= var_0_7.special_day.christmas_end then
			var_115_5 = true
		end

		if var_115_1 >= var_0_7.special_day.jp_anniversary_start and var_115_1 <= var_0_7.special_day.jp_anniversary_end then
			var_115_6 = true
		end

		if var_115_1 >= var_0_7.special_day.cn_anniversary_start and var_115_1 <= var_0_7.special_day.cn_anniversary_end then
			var_115_7 = true
		end

		if var_115_1 >= var_0_7.special_day.cn_hallowmas_day_start and var_115_1 <= var_0_7.special_day.cn_hallowmas_day_end then
			var_115_8 = true
		end

		return var_115_5 and "special_2" or var_115_3 and var_115_6 and "special" or var_115_3 and (var_115_1 >= var_0_7.special_day.jp_hallowmas_day_start and var_115_1 <= var_0_7.special_day.jp_hallowmas_day_end or nil) and true and "special_3" or var_115_4 and var_115_7 and "special" or var_115_4 and var_115_8 and "special_3" or (var_115_0 == 1 or var_115_0 == 2) and 4 or math.floor(var_115_0 / 3)
	end

	function arg_1_0:__init_panel(arg_116_1)
		if var_0_2:getInstance("enter_game") then
			var_0_2:destroyInstance("enter_game")
		end

		self.is_have_acticity = false

		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))

		self._user_data = var_0_3:get_use_info_data()
		var_0_25.multiTouchEnabled = false

		if self._model_talk_seq and self._model_talk_seq:IsPlaying() then
			self._model_talk_seq:Kill()
		end

		if not self._already_init then
			self._control.blur_layer.resource_mask.layer_5.title.text.text = var_0_1:getNowLang("resourcehelpinfo")
			self._shop_config_list = var_0_18:get_sequence()
			self._buff_contents = {
				self._control.left_upon.node.on_button_buff,
				self._control.left_upon.node.on_item_button_buff,
				self._control.left_upon.node.on_furniture_button_buff,
				self._control.left_upon.node.on_combatshop_button_buff,
				self._control.left_upon.node.on_combattactics_button_buff
			}

			self:_bgm_play()
		end

		if not var_0_3:get_guide_state() then
			if self.is_announcement == false then
				self:init_announcement()
			else
				self:init_issignin()
			end
		end

		self:__show_data()
		self:updata_user_res()
		self:updata_model(false)

		if not arg_116_1 then
			self:play_first_in_animation()
		end

		self:__set_bg_by_time()
		self:_task_light()

		self._already_init = true

		for iter_116_0 = 1, self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.viewport.content.transform.childCount do
			self:destroyChildren("home_activity_scroll_item")

			self.is_have_acticity = false
		end

		for iter_116_1 = 1, self._control.mp_activity_node.crumbs.transform.childCount do
			self:destroyChildren("crumbs_point")
		end

		local var_116_0 = true
		local var_116_1 = var_0_24:getKeyData(var_0_7.setting_key_list.setting_scene_change)

		if var_116_1 ~= "" then
			local var_116_2 = var_0_9(var_116_1).value

			if var_116_2 ~= "" then
				var_116_0 = var_116_2
			end
		end

		if var_116_0 then
			self:getCreate3DScene(true)
		end

		var_0_7:set_is_tactics(false)

		if var_0_3:get_home_panel_count() == 1 then
			var_0_3:set_home_panel_count(2)
		elseif self.is_have_acticity == false then
			self:__acticity_scorll()

			self.is_have_acticity = true
		end
	end

	function arg_1_0:__show_data()
		self._user_name = var_0_3:get_name()
		self._user_data = var_0_3:get_use_info_data()
		self._control.top.name_txt.text.text = self._user_name
		self._control.top.level_txt.text.text = self._user_data.level
		self._control.bottom.outfight.text.text = var_0_1:getNowLang("outfight")
		self._control.bottom.shipyard.text.text = var_0_1:getNowLang("shipyard")
		self._control.bottom.task.text.text = var_0_1:getNowLang("task")

		if gamecore.util_func.check_channel_is_en() then
			self._control.bottom.task.text.fontSize = 15
		end

		self._control.blur_layer.resource_mask.layer_1.title.text.text = var_0_1:getNowLang("resourceproductivity")
		self._control.blur_layer.resource_mask.layer_4.txt.text.text = var_0_1:getNowLang("resourcehelpinfo")
		self._control.blur_layer.resource_mask.layer_1.recovery.text.text = self:__get_recovery(3600 / var_0_8.oil_recover_time * var_0_8.oil_recover_amount)
		self._control.blur_layer.resource_mask.layer_2.recovery.text.text = self:__get_recovery(3600 / var_0_8.bullet_recover_time * var_0_8.bullet_recover_amount)
		self._control.blur_layer.resource_mask.layer_3.recovery.text.text = self:__get_recovery(3600 / var_0_8.fe_recover_time * var_0_8.fe_recover_amount)
		self._control.blur_layer.resource_mask.layer_4.recovery.text.text = self:__get_recovery(3600 / var_0_8.al_recover_time * var_0_8.al_recover_amount)
		self._control.top.exp_bar.image.fillAmount = self._user_data.exp / var_0_11.find_object_by_level(self._user_data.level).exp
	end

	function arg_1_0:__show_talk(arg_118_1)
		if self._control.model_layer.talk.activeSelf and self._control.model_layer.talk.canvasGroup.alpha ~= 0 then
			return
		end

		self._user_data = var_0_3:get_use_info_data()

		local var_118_0 = tonumber(os.date("%H", (lx.ServerTime:getUtcTime())))
		local var_118_1 = var_118_0 >= 7 and var_118_0 < 19
		local var_118_2 = var_0_3:get_secretary_info()
		local var_118_3 = self._secretary_id and var_0_3:find_character_by_id(self._secretary_id) or var_0_3:find_character_by_id(self._user_data.secretary)
		local var_118_4 = var_0_5.find_object_by_cid(var_118_3.cid)
		local var_118_5 = var_0_9(var_118_4.main_dialogue)
		local var_118_6 = 0
		local var_118_7 = {}
		local var_118_8 = 0
		local var_118_9 = 0
		local var_118_10 = 0
		local var_118_11 = 0
		local var_118_12 = {}
		local var_118_13 = false
		local var_118_14 = ""

		if var_118_3.skin ~= 0 and not var_0_10.have_data({
			1006130151
		}, var_118_3.skin) then
			local var_118_15 = var_0_6.find_object_by_cid(var_118_3.skin)

			if var_118_15.dialogue_add and next(var_118_15.dialogue_add) and var_118_15.main_dialogue_2 ~= "" then
				var_118_7 = var_0_16(var_118_15.dialogue_add)

				for iter_118_0, iter_118_1 in pairs(var_118_15.dialogue_add) do
					if self:check_special_dialogue(iter_118_1.condition, 1, iter_118_1.switchover, var_118_12) then
						var_118_6 = var_0_9(var_118_15.main_dialogue_2)

						if iter_118_1.dialogue_time == 1 then
							if iter_118_1.dialogue_type == 1 then
								var_118_8 = var_118_8 + #iter_118_1.switchover
							else
								var_118_10 = var_118_10 + #iter_118_1.switchover
							end
						elseif iter_118_1.dialogue_type == 1 then
							var_118_9 = var_118_9 + #iter_118_1.switchover
						else
							var_118_11 = var_118_11 + #iter_118_1.switchover
						end
					end
				end
			end

			if var_118_15.main_dialogue ~= "" then
				var_118_5 = var_0_9(var_118_15.main_dialogue)
			end
		elseif var_118_4.dialogue_add and next(var_118_4.dialogue_add) and var_118_4.main_dialogue_2 ~= "" then
			var_118_7 = var_0_16(var_118_4.dialogue_add)

			for iter_118_2, iter_118_3 in pairs(var_118_4.dialogue_add) do
				if self:check_special_dialogue(iter_118_3.condition, 1, iter_118_3.switchover, var_118_12) then
					var_118_6 = var_0_9(var_118_4.main_dialogue_2)

					if iter_118_3.dialogue_time == 1 then
						if iter_118_3.dialogue_type == 1 then
							var_118_8 = var_118_8 + #iter_118_3.switchover
						else
							var_118_10 = var_118_10 + #iter_118_3.switchover
						end
					elseif iter_118_3.dialogue_type == 1 then
						var_118_9 = var_118_9 + #iter_118_3.switchover
					else
						var_118_11 = var_118_11 + #iter_118_3.switchover
					end
				end
			end
		end

		if not var_118_5 then
			return
		end

		local var_118_16
		local var_118_17 = 1
		local var_118_18
		local var_118_19 = 0

		if var_118_3.marry then
			var_118_17 = var_0_12(1, 2)

			if var_118_1 then
				if var_118_17 == 1 then
					var_118_18 = var_0_12(1, 3 + var_118_8)

					if var_118_18 > 3 then
						local var_118_20 = self:get_add_dialogue(var_118_18 - 3, 1, 1, var_118_7, var_118_12)

						var_118_16 = var_118_6[var_118_20]
						var_118_19 = var_118_20

						if self:check_dialogue_change_pic(var_118_3, var_118_20) then
							var_118_13, var_118_14 = self:add_dialogue_change_pic(var_118_3, var_118_20)
						end
					else
						var_118_16 = var_118_5[var_118_18]
					end
				else
					var_118_18 = var_0_12(13, 15 + var_118_10)

					if var_118_18 > 15 then
						local var_118_21 = self:get_add_dialogue(var_118_18 - 15, 1, 2, var_118_7, var_118_12)

						var_118_16 = var_118_6[var_118_21]
						var_118_19 = var_118_21

						if self:check_dialogue_change_pic(var_118_3, var_118_21) then
							var_118_13, var_118_14 = self:add_dialogue_change_pic(var_118_3, var_118_21)
						end
					else
						var_118_16 = var_118_5[var_118_18]
					end
				end
			elseif var_118_17 == 1 then
				var_118_18 = var_0_12(7, 9 + var_118_9)

				if var_118_18 > 9 then
					local var_118_22 = self:get_add_dialogue(var_118_18 - 9, 2, 1, var_118_7, var_118_12)

					var_118_16 = var_118_6[var_118_22]
					var_118_19 = var_118_22

					if self:check_dialogue_change_pic(var_118_3, var_118_22) then
						var_118_13, var_118_14 = self:add_dialogue_change_pic(var_118_3, var_118_22)
					end
				else
					var_118_16 = var_118_5[var_118_18]
				end
			else
				var_118_18 = var_0_12(16, 18 + var_118_11)

				if var_118_18 > 18 then
					local var_118_23 = self:get_add_dialogue(var_118_18 - 18, 2, 2, var_118_7, var_118_12)

					var_118_16 = var_118_6[var_118_23]
					var_118_19 = var_118_23

					if self:check_dialogue_change_pic(var_118_3, var_118_23) then
						var_118_13, var_118_14 = self:add_dialogue_change_pic(var_118_3, var_118_23)
					end
				else
					var_118_16 = var_118_5[var_118_18]
				end
			end
		elseif var_118_1 then
			var_118_18 = var_0_12(1, 3 + var_118_8)

			if var_118_18 > 3 then
				local var_118_24 = self:get_add_dialogue(var_118_18 - 3, 1, 1, var_118_7, var_118_12)

				var_118_16 = var_118_6[var_118_24]
				var_118_19 = var_118_24

				if self:check_dialogue_change_pic(var_118_3, var_118_24) then
					var_118_13, var_118_14 = self:add_dialogue_change_pic(var_118_3, var_118_24)
				end
			else
				var_118_16 = var_118_5[var_118_18]
			end
		else
			var_118_18 = var_0_12(7, 9 + var_118_9)

			if var_118_18 > 9 then
				local var_118_25 = self:get_add_dialogue(var_118_18 - 9, 2, 1, var_118_7, var_118_12)

				var_118_16 = var_118_6[var_118_25]
				var_118_19 = var_118_25

				if self:check_dialogue_change_pic(var_118_3, var_118_25) then
					var_118_13, var_118_14 = self:add_dialogue_change_pic(var_118_3, var_118_25)
				end
			else
				var_118_16 = var_118_5[var_118_18]
			end
		end

		if var_118_16 == "" then
			var_118_18 = var_118_18 - 3
			var_118_16 = var_118_5[var_118_18]
		end

		local var_118_26 = false

		if var_118_4.dialogue_switchover and next(var_118_4.dialogue_switchover) and var_118_4.main_dialogue_2 ~= "" then
			local var_118_27 = var_0_9(var_118_4.main_dialogue_2)

			for iter_118_4, iter_118_5 in pairs(var_118_4.dialogue_switchover) do
				if iter_118_5.switchover == var_118_18 and self:check_special_dialogue(iter_118_5.condition, 2) then
					var_118_16 = var_118_27[iter_118_5.switchover_2]
					var_118_18 = iter_118_5.switchover_2
					var_118_26 = true
				end
			end
		end

		local var_118_28

		if var_118_18 < 10 then
			if var_118_3.skin ~= 0 then
				local var_118_29 = var_0_6.find_object_by_cid(var_118_3.skin)

				if var_118_29 and var_118_29.switchover_path and next(var_118_29.switchover_path) then
					for iter_118_6, iter_118_7 in pairs(var_118_29.switchover_path) do
						if iter_118_7.dialogue_state == 1 then
							for iter_118_8, iter_118_9 in pairs(iter_118_7.dialogue) do
								if iter_118_9 == var_118_18 then
									var_118_13 = true
									var_118_14 = iter_118_7.path
								end
							end
						end
					end
				end

				var_118_28 = var_118_29.cv_id == "0" and (var_118_29.main_dialogue ~= "" and "" or var_0_4("%s/%s_main_0%s.mp3", var_118_4.pic_id, var_118_4.pic_id, var_118_18)) or var_0_4("%s/%s_main_0%s.mp3", var_118_29.cv_id, var_118_29.cv_id, var_118_18)

				if var_118_19 ~= 0 then
					var_118_28 = var_118_19 < 10 and var_0_4("%s/%s_main_2_0%s.mp3", var_118_29.cv_id, var_118_29.cv_id, var_118_19) or var_0_4("%s/%s_main_2_%s.mp3", var_118_29.cv_id, var_118_29.cv_id, var_118_19)
				end

				if var_118_26 then
					var_118_28 = var_0_4("%s/%s_main_2_0%s.mp3", var_118_29.cv_id, var_118_29.cv_id, var_118_18)
				end
			else
				if var_118_4 and var_118_4.switchover_path and next(var_118_4.switchover_path) then
					for iter_118_10, iter_118_11 in pairs(var_118_4.switchover_path) do
						if iter_118_11.dialogue_state == 1 then
							for iter_118_12, iter_118_13 in pairs(iter_118_11.dialogue) do
								if iter_118_13 == var_118_18 then
									var_118_13 = true
									var_118_14 = iter_118_11.path
								end
							end
						end
					end
				end

				if var_118_19 ~= 0 then
					var_118_28 = var_118_19 < 10 and var_0_4("%s/%s_main_2_0%s.mp3", var_118_4.pic_id, var_118_4.pic_id, var_118_19) or var_0_4("%s/%s_main_2_%s.mp3", var_118_4.pic_id, var_118_4.pic_id, var_118_19)
				end

				if not var_118_28 and var_118_19 == 0 then
					var_118_28 = var_118_26 and var_0_4("%s/%s_main_2_0%s.mp3", var_118_4.pic_id, var_118_4.pic_id, var_118_18) or var_0_4("%s/%s_main_0%s.mp3", var_118_4.pic_id, var_118_4.pic_id, var_118_18)
				end
			end
		elseif var_118_3.skin ~= 0 then
			local var_118_30 = var_0_6.find_object_by_cid(var_118_3.skin)

			if var_118_30 and var_118_30.switchover_path and next(var_118_30.switchover_path) then
				for iter_118_14, iter_118_15 in pairs(var_118_30.switchover_path) do
					if iter_118_15.dialogue_state == 1 then
						for iter_118_16, iter_118_17 in pairs(iter_118_15.dialogue) do
							if iter_118_17 == var_118_18 then
								var_118_13 = true
								var_118_14 = iter_118_15.path
							end
						end
					end
				end
			end

			if var_118_30.cv_id == "0" then
				if var_118_30.main_dialogue ~= "" then
					var_118_28 = ""

					return
				else
					var_118_28 = var_0_4("%s/%s_main_%s.mp3", var_118_4.pic_id, var_118_4.pic_id, var_118_18)
				end
			else
				var_118_28 = var_0_4("%s/%s_main_%s.mp3", var_118_30.cv_id, var_118_30.cv_id, var_118_18)
			end

			if var_118_19 ~= 0 then
				var_118_28 = var_118_19 < 10 and var_0_4("%s/%s_main_2_0%s.mp3", var_118_30.cv_id, var_118_30.cv_id, var_118_19) or var_0_4("%s/%s_main_2_%s.mp3", var_118_30.cv_id, var_118_30.cv_id, var_118_19)
			end

			if var_118_26 then
				var_118_28 = var_0_4("%s/%s_main_2_%s.mp3", var_118_30.cv_id, var_118_30.cv_id, var_118_18)
			end
		else
			if var_118_4 and var_118_4.switchover_path and next(var_118_4.switchover_path) then
				for iter_118_18, iter_118_19 in pairs(var_118_4.switchover_path) do
					if iter_118_19.dialogue_state == 1 then
						for iter_118_20, iter_118_21 in pairs(iter_118_19.dialogue) do
							if iter_118_21 == var_118_18 then
								var_118_13 = true
								var_118_14 = iter_118_19.path
							end
						end
					end
				end
			end

			if var_118_19 ~= 0 then
				var_118_28 = var_118_19 < 10 and var_0_4("%s/%s_main_2_0%s.mp3", var_118_4.pic_id, var_118_4.pic_id, var_118_19) or var_0_4("%s/%s_main_2_%s.mp3", var_118_4.pic_id, var_118_4.pic_id, var_118_19)
			end

			var_118_28 = var_118_28 or var_118_26 and var_0_4("%s/%s_main_2_%s.mp3", var_118_4.pic_id, var_118_4.pic_id, var_118_18) or var_0_4("%s/%s_main_%s.mp3", var_118_4.pic_id, var_118_4.pic_id, var_118_18)
		end

		if var_118_17 == 2 then
			self._control.model_layer.talk.bg1.image.sprite = self:loadSprite(var_0_7.common_tip_bg.tip_bg_marry)
			self._control.model_layer.talk.bg1.bg2.image.sprite = self:loadSprite(var_0_7.common_tip_bg.tip_up_mark_marry)
			self._control.model_layer.talk.bg1.bg3.image.sprite = self:loadSprite(var_0_7.common_tip_bg.tip_down_mark_marry)
		else
			self._control.model_layer.talk.bg1.image.sprite = self:loadSprite(var_0_7.common_tip_bg.tip_bg)
			self._control.model_layer.talk.bg1.bg2.image.sprite = self:loadSprite(var_0_7.common_tip_bg.tip_up_mark)
			self._control.model_layer.talk.bg1.bg3.image.sprite = self:loadSprite(var_0_7.common_tip_bg.tip_down_mark)
		end

		if self._is_spine_2d or self._is_live_2d then
			self._control.model_layer.talk.bg1.image.sprite = self:loadSprite(var_0_7.common_tip_bg.tip_bg)
			self._control.model_layer.talk.bg1.bg2.image.sprite = self:loadSprite(var_0_7.common_tip_bg.tip_up_mark)
			self._control.model_layer.talk.bg1.bg3.image.sprite = self:loadSprite(var_0_7.common_tip_bg.tip_down_mark)
		elseif var_118_28 and var_118_28 ~= "" then
			self:playCV(var_118_28, false, "cv")
		end

		if self._is_spine_2d then
			self._now_motions = "original"

			local var_118_31

			if self._now_spine_info.motions and next(self._now_spine_info.motions) then
				for iter_118_22, iter_118_23 in pairs(self._now_spine_info.motions) do
					if iter_118_22 == arg_118_1 then
						var_118_31 = iter_118_23
					end
				end
			end

			if var_118_31 then
				local var_118_32 = math.random(1, #var_118_31)

				for iter_118_24, iter_118_25 in pairs(self._now_spine_info.dialogue) do
					if var_118_31[var_118_32] == iter_118_24 then
						var_118_16 = iter_118_25
						self._now_motions = iter_118_24
					end
				end
			end
		end

		self:__show_model_talk_ani(var_118_16, true, var_118_13, var_118_14)
	end

	function arg_1_0:__show_live_2d_dialogue(arg_119_1, arg_119_2, arg_119_3)
		if not self._control.model_layer.talk:Equals(nil) and self._control.model_layer.talk.activeSelf and self.canot_click then
			return
		end

		if arg_119_1 == "" then
			return
		end

		local var_119_1

		if arg_119_3 == "6_2" then
			if arg_119_2 and arg_119_2 ~= "" then
				var_119_1 = var_0_4("%s/%s.wav", arg_119_3, arg_119_2)
			end

			if var_119_1 and var_119_1 ~= "" then
				self:playCV(var_119_1, false, "cv")
			end
		end

		self:__show_model_talk_ani(arg_119_1, true, false)
	end

	function arg_1_0:__show_model_talk_ani(arg_120_1, arg_120_2, arg_120_3, arg_120_4)
		if not arg_120_2 and self._continue_talk then
			return
		end

		if self.canot_click then
			return
		end

		local var_120_0

		if var_0_21._is_have_cv and not self._is_spine_2d then
			var_120_0 = var_0_21._cv_length * 0.9
		elseif arg_120_1 then
			var_120_0 = #arg_120_1 * 0.03
		else
			var_120_0 = 0.3
			arg_120_1 = " "
		end

		if not arg_120_2 then
			if self._control.model_layer.talk.activeSelf and self._model_talk_seq and self._model_talk_seq:IsPlaying() then
				self._model_talk_seq:Pause()
				self._model_talk_seq:Kill()
				self._control.model_layer.talk.popVerticalAdaptive:SetText("")

				self._control.model_layer.talk.label_txt.text.text = ""
			end

			self._control.model_layer.talk.gameObject:SetActive(false)

			return
		end

		self._control.model_layer.talk.popVerticalAdaptive:SetText(arg_120_1)

		self._control.model_layer.talk.label_txt.text.text = ""

		if not self._control.model_layer.talk:Equals(nil) then
			self._control.model_layer.talk.gameObject:SetActive(arg_120_2)
		end

		self._model_talk_seq = self:autoKillDOTween(var_0_13.Sequence())

		if self._live2d then
			self._control.model_layer.rectTransform.anchoredPosition = var_0_34.New(-288, 0)
		end

		if arg_120_3 then
			self:change_role_pic(arg_120_4, "dialogue")
		elseif self._role_sp_change and not arg_120_3 then
			self:updata_model(false, self._role_sp_change)
		end

		self._model_talk_seq:Append(self._control.model_layer.talk.canvasGroup:DOFade(1, 0.3))

		arg_120_1 = string.gsub(arg_120_1, " ", " ")

		self._model_talk_seq:Append(self._control.model_layer.talk.label_txt.text:DOText(arg_120_1, #arg_120_1 * 0.02):SetEase(DG.Tweening.Ease.Linear))
		self._model_talk_seq:AppendInterval(var_120_0)
		self._model_talk_seq:Append(self._control.model_layer.talk.canvasGroup:DOFade(0, 0.7):OnComplete(function()
			if self._model_talk_seq then
				self._model_talk_seq:Kill()

				self._model_talk_seq = nil

				var_0_21:destroyCV()
			end
		end))
		self._model_talk_seq:OnKill(function()
			if self and self._control then
				self._control.model_layer.talk.popVerticalAdaptive:SetText("")
			end

			if self and self._control and not self._control.model_layer.talk.label_txt:Equals(nil) then
				self._control.model_layer.talk.label_txt.text.text = ""
			end

			if self and self._control and not self._control.model_layer.talk:Equals(nil) then
				self._control.model_layer.talk.gameObject:SetActive(false)
			end
		end)
		self._model_talk_seq:Play()
	end

	function arg_1_0:change_role_pic(arg_123_1, arg_123_2)
		local var_123_0 = lx.split(arg_123_1, "_")
		local var_123_1 = lx.split(arg_123_1, "\\")
		local var_123_2 = var_0_5.find_object_by_cid(10000113)

		if var_123_0[3] == "broken" and self:check_open_broken() and self:get_setting_broken() then
			local var_123_3, var_123_4 = self:loadSprite((var_0_7:get_ship_icon(var_0_10:use_big_break_painting_2(var_123_2, var_0_7.ship_icon_type.model_l, true), var_123_1[3], var_123_1[3])))

			self._control.model_layer.cc_sprite.icon.image.sprite = var_123_3
		elseif var_123_0[3] == "normal" then
			if not self:get_setting_broken() and var_123_1[3] == "1560_1" then
				return
			end

			local var_123_5 = var_0_10:use_big_break_painting(var_123_2, var_0_7.ship_icon_type.model_l, false)
			local var_123_6 = string.gsub(string.gsub(tostring(var_123_1[4]), "L_NORMAL_HD_", ""), "\"%]", "")
			local var_123_8, var_123_9 = self:loadSprite(var_123_6 ~= var_123_1[3] and var_0_7:get_ship_icon_sp(var_123_5, var_123_1[3], (string.gsub(var_123_6, ".png", ""))) or var_0_7:get_ship_icon_sp(var_123_5, var_123_1[3], var_123_1[3]))

			self._control.model_layer.cc_sprite.icon.image.sprite = var_123_8
		end

		if arg_123_2 == "dialogue" then
			self._role_sp_change = true
		end
	end

	function arg_1_0:__show_resourse()
		self._control.blur_layer:SetActive(true)

		self._user_data = var_0_3:get_use_info_data()

		local var_124_0 = var_0_11.find_object_by_level(self._user_data.level)

		self._control.blur_layer.resource_mask.layer_1.txt.text.text = self._user_data.oil .. "<b>/</b> " .. var_124_0.resources_top
		self._control.blur_layer.resource_mask.layer_2.txt.text.text = self._user_data.bullet .. "<b>/</b> " .. var_124_0.resources_top
		self._control.blur_layer.resource_mask.layer_3.txt.text.text = self._user_data.fe .. "<b>/</b> " .. var_124_0.resources_top
		self._control.blur_layer.resource_mask.layer_4.txt.text.text = self._user_data.al .. "<b>/</b> " .. var_124_0.resources_top
	end

	function arg_1_0.__get_recovery(arg_125_0, arg_125_1)
		return arg_125_1 == 20 and var_0_1:getNowLang("resourceproductperhour2") or arg_125_1 == 60 and var_0_1:getNowLang("resourceproductperhour1") or arg_125_1 .. "/时"
	end

	function arg_1_0:__set_listener(arg_126_1, arg_126_2)
		self._control.raw_image.myGameController:SetLive2dModel(self:loadTextAsset(var_0_4(var_0_7.live2d_model, arg_126_1)).text, arg_126_2)

		local var_126_0 = self._control.raw_image.myGameController:GetModel()
		local var_126_1 = var_126_0:GetModelSetting()

		var_126_0:SetModelDataFromAssetBundle(self:loadTextAsset(var_0_4(var_0_7.live2d_dir, arg_126_1) .. var_126_1:GetModelFile() .. ".bytes").bytes)

		for iter_126_0 = 0, var_126_1:GetTextureNum() - 1 do
			var_126_0:LoadTextureFromAssetBundle(iter_126_0, (self:loadTexture(var_0_4(var_0_7.live2d_dir, arg_126_1) .. var_126_1:GetTextureFile(iter_126_0))))
		end

		if var_126_1:GetExpressionNum() ~= 0 then
			for iter_126_1 = 0, var_126_1:GetExpressionNum() - 1 do
				var_126_0:loadExpressionFromAssetBundle(var_126_1:GetExpressionName(iter_126_1), self:loadTextAsset(var_0_4(var_0_7.live2d_dir, arg_126_1) .. var_126_1:GetExpressionFile(iter_126_1)).bytes)
			end
		end

		if var_126_1:GetPhysicsFile() then
			var_126_0:LoadPhysicsFromAssetBundle(self:loadTextAsset(var_0_4(var_0_7.live2d_dir, arg_126_1) .. var_126_1:GetPhysicsFile()).bytes)
		end

		if var_126_1:GetPoseFile() then
			var_126_0:loadPoseFromAssetBundle(self:loadTextAsset(var_0_4(var_0_7.live2d_dir, arg_126_1) .. var_126_1:GetPoseFile()).bytes)
		end

		function var_126_0.motionAction(arg_127_0, arg_127_1)
			var_126_0.motion = var_126_0:loadMotionFromAssetBundle(arg_127_0, self:loadTextAsset(var_0_4(var_0_7.live2d_dir, arg_126_1) .. arg_127_1 .. ".bytes").bytes)
		end

		var_126_0:InitParam()
		var_126_0.showDialogueEvent:AddListener(function()
			self:__show_live_2d_dialogue((var_126_0:GetTriggerWord()))
		end)
	end

	function arg_1_0:__show_buff_node(arg_129_1, arg_129_2)
		local var_129_0 = {
			{
				self._control.left_upon.node.on_button_buff,
				self._control.left_upon.node.on_button_buff.buff_time
			},
			{
				self._control.left_upon.node.on_item_button_buff,
				self._control.left_upon.node.on_item_button_buff.buff_time
			},
			{
				self._control.left_upon.node.on_furniture_button_buff,
				self._control.left_upon.node.on_furniture_button_buff.buff_time
			},
			{
				self._control.left_upon.node.on_combatshop_button_buff,
				self._control.left_upon.node.on_combatshop_button_buff.buff_time
			},
			{
				self._control.left_upon.node.on_combattactics_button_buff,
				self._control.left_upon.node.on_combattactics_button_buff.buff_time
			}
		}

		if arg_129_1 ~= 0 then
			for iter_129_0, iter_129_1 in pairs(var_129_0[arg_129_1]) do
				iter_129_1:SetActive(arg_129_2)
			end
		else
			for iter_129_2, iter_129_3 in pairs(var_129_0) do
				for iter_129_4, iter_129_5 in pairs(iter_129_3) do
					iter_129_5:SetActive(false)
				end
			end
		end
	end

	function arg_1_0:__click_buff_btn_event(arg_130_1, arg_130_2)
		local var_130_0 = self._control.left_upon.tip_bg

		self._control.left_upon.tip_bg:SetActive(arg_130_2)

		if not arg_130_2 then
			return
		end

		if arg_130_2 then
			local var_130_1 = self:__buff_active_num()

			var_130_0.rectTransform.anchoredPosition = var_0_34.New(500, -322 - 55 * ((arg_130_1 <= var_130_1 or nil) and (arg_130_1 - 1 or var_130_1 - 1)))
			self._cur_show_buff_tip_index = arg_130_1
			var_130_0.tip_bg_2.title.text.text = self._buff_tip_info_list[arg_130_1].title
			var_130_0.tip_bg_2.content.text.text = self._buff_tip_info_list[arg_130_1].content
		end
	end

	function arg_1_0:__buff_active_num()
		local var_131_0 = 0

		for iter_131_0, iter_131_1 in pairs(self._buff_contents) do
			if iter_131_1.activeSelf then
				var_131_0 = var_131_0 + 1
			end
		end

		return var_131_0
	end

	function arg_1_0.__get_txt(arg_132_0, arg_132_1)
		return (string.gsub(arg_132_1, "%^C[^%^]+", function(arg_133_0)
			return string.format("<color=#%s>%s</color>", string.sub(arg_133_0, 3, 10), (string.sub(arg_133_0, 19, #arg_133_0)))
		end))
	end

	function arg_1_0:__mouse_drag_event()
		if #self.acticity <= 1 then
			return
		end

		local var_134_3, var_134_4 = var_0_29.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, self._start_pos, self._ui_camera, nil)
		local var_134_5, var_134_6 = var_0_29.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, self._end_pos, self._ui_camera, nil)
		local var_134_8, var_134_9 = math.modf(math.abs(self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.viewport.content.rectTransform.anchoredPosition.x) / 178)

		if var_134_6.x - var_134_4.x < 0 then
			if var_134_9 > 0.2808989 then
				local var_134_10 = self.show_index

				if self.show_index >= #self.acticity - 2 then
					var_134_10 = 0
				end

				self.show_index = var_134_10 + 1

				for iter_134_0, iter_134_1 in pairs(self.show_crubs_list) do
					iter_134_1.image.sprite = self:loadSprite(var_0_4(var_0_7.main_banner_list, "normal"))

					iter_134_1:GetComponent("Image"):SetNativeSize()
				end

				if self.show_crubs_list[var_134_10 + 1] then
					self.show_crubs_list[var_134_10 + 1].image.sprite = self:loadSprite(var_0_4(var_0_7.main_banner_list, "selected"))

					self.show_crubs_list[var_134_10 + 1]:GetComponent("Image"):SetNativeSize()
					self:get_acticity_surplus_time(self.acticity[var_134_10 + 1])
				else
					self.show_crubs_list[1].image.sprite = self:loadSprite(var_0_4(var_0_7.main_banner_list, "selected"))

					self.show_crubs_list[1]:GetComponent("Image"):SetNativeSize()
					self:get_acticity_surplus_time(self.acticity[1])
				end
			end
		elseif var_134_6.x - var_134_4.x > 0 and 1 - var_134_9 > 0.2808989 then
			local var_134_11 = self.show_index

			if self.show_index <= 1 then
				var_134_11 = #self.acticity - 1
			end

			self.show_index = var_134_11 - 1

			for iter_134_2, iter_134_3 in pairs(self.show_crubs_list) do
				iter_134_3.image.sprite = self:loadSprite(var_0_4(var_0_7.main_banner_list, "normal"))

				iter_134_3:GetComponent("Image"):SetNativeSize()
			end

			if self.show_crubs_list[var_134_11 - 1] then
				self.show_crubs_list[var_134_11 - 1].image.sprite = self:loadSprite(var_0_4(var_0_7.main_banner_list, "selected"))

				self.show_crubs_list[var_134_11 - 1]:GetComponent("Image"):SetNativeSize()
				self:get_acticity_surplus_time(self.acticity[var_134_11 - 1])
			else
				self.show_crubs_list[1].image.sprite = self:loadSprite(var_0_4(var_0_7.main_banner_list, "selected"))

				self.show_crubs_list[1]:GetComponent("Image"):SetNativeSize()
				self:get_acticity_surplus_time(self.acticity[1])
			end
		end
	end

	function arg_1_0:__acticity_scorll(arg_135_1)
		local var_135_0 = {}

		self.show_crubs_list = {}
		self.acticity = {}

		local var_135_1, var_135_2 = var_0_19.get_sequence()

		for iter_135_0, iter_135_1 in pairs(var_135_1) do
			if self:get_acticity_time(iter_135_1) then
				var_0_15(self.acticity, iter_135_1)
			end
		end

		self.scorll_auto = false

		if #self.acticity == 0 then
			self._control.mp_activity_node:SetActive(false)

			return
		else
			self._control.mp_activity_node:SetActive(false)

			if not var_0_37:isAuditVersion() then
				self._control.mp_activity_node:SetActive(true)
			end
		end

		self._active_isopen_list = {}
		self.show_crubs_list = self.show_crubs_list or {}

		if #self.acticity > 1 then
			for iter_135_2 = 1, #self.acticity do
				local var_135_3, var_135_4 = self:loadUIPrefab("crumbs_point", self._control.mp_activity_node.crumbs.transform)

				table.insert(var_135_0, var_135_4)
				var_135_3:setVisible(true)
				var_135_4.Image:GetComponent("Image"):SetNativeSize()

				self.show_crubs_list[iter_135_2] = var_135_4.Image
			end

			var_0_15(self.acticity, 1, self.acticity[#self.acticity])
			var_0_15(self.acticity, self.acticity[2])

			self.scorll_auto = true
		end

		self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.viewport.content.transform.localPosition.x = -178

		for iter_135_3, iter_135_4 in pairs(self.acticity) do
			self._active_isopen_list[iter_135_4.id] = true

			local var_135_5 = iter_135_4
			local var_135_6, var_135_7 = self:loadUIPrefab("home_activity_scroll_item", self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.viewport.content.transform)

			var_135_6._panel.transform.localPosition = var_0_35.New(178 * iter_135_3, 0, 0)

			var_135_6:setVisible(true)

			self._acitveControlList[#self._acitveControlList + 1] = var_135_7
			var_135_7.enter.image.sprite = self:loadSprite(var_0_4(var_0_7.main_activity_image_list, iter_135_4.pic))

			local var_135_8 = false

			if iter_135_4.award_time > 0 and lx.ServerTime:getUtcTime() >= iter_135_4.end_time and lx.ServerTime:getUtcTime() < iter_135_4.award_time then
				var_135_8 = true
				var_135_7.mask_banar.statis_text.text.text = var_0_1:getNowLang("battlefield_close")
				var_135_7.mask_banar.static_text2.text.text = var_0_1:getNowLang("only_get_award")
			end

			var_135_7.enter.button.onClick:RemoveAllListeners()
			var_135_7.enter.button.onClick:AddListener(function()
				if var_135_5.type == var_0_7.pve_active_type.sixth_event then
					self:__six_acticity_enter_event()
				elseif var_135_5.type == var_0_7.pve_active_type.normal then
					self:__fearlessness_sea_acticity_enter_event(var_135_5.id)
				elseif var_135_5.type == var_0_7.pve_active_type.climb_tower then
					self:__climb_tower_acticity_enter_event(var_135_8)
				elseif var_135_5.type == var_0_7.pve_active_type.fourth_event then
					self:__ocean_main_map_acticity_enter_event()
				elseif var_135_5.type == var_0_7.pve_active_type.score_event then
					self:__score_push_map_acticity_enter_event(var_135_5.id)
				elseif var_135_5.type == var_0_7.pve_active_type.fifth_event then
					self:__fifth_event_acticity_enter_event()
				elseif var_135_5.type == var_0_7.pve_active_type.strike_event then
					self:__strike_main_acticity_enter_event(var_135_5.id)
				elseif var_135_5.type == var_0_7.pve_active_type.bootyshop then
					self:__bootyshop_event_acticity_enter_event()
				elseif var_135_5.type == var_0_7.pve_active_type.abyss_event then
					self:__abyss_event_acticity_enter_event()
				elseif var_135_5.type == var_0_7.pve_active_type.dock_event then
					self:__dock_event_acticity_enter_event()
				elseif var_135_5.type == var_0_7.pve_active_type.seventh_event then
					self:__seventh_event_acticity_enter_event(var_135_5.id)
				elseif var_135_5.type == var_0_7.pve_active_type.eighth_event then
					self:__eighth_event_acticity_enter_event(var_135_5.id)
				elseif var_135_5.type == var_0_7.pve_active_type.mist_event then
					self:__mist_event_acticity_enter_event()
				elseif var_135_5.type == var_0_7.pve_active_type.ninth_event then
					self:__ninth_event_acticity_enter_event(var_135_5.id)
				elseif var_135_5.type == var_0_7.pve_active_type.ten_buy_event then
					self:__figurines_event_acticity_enter_event(var_135_5.id)
				end
			end)
			var_135_7.mask_banar:SetActive(var_135_8)

			var_135_7.enter.image.material = var_135_8 and self:loadMaterial(var_0_7.common_icon.furniture_gray_material) or nil

			var_135_7.enter.pointerDownUpEvent.onPointerDown:RemoveAllListeners()
			var_135_7.enter.pointerDownUpEvent.onPointerDown:AddListener(function()
				self._control.mp_activity_node.cover:SetActive(true)

				self.is_down = true
			end)

			if iter_135_3 == 1 then
				self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.latticeScrollRect:InitItemWidth(var_135_6._panel)
			end

			if #self.acticity == 1 then
				var_135_6._panel.transform.localPosition = var_0_35.New(0, 0, 0)
			end
		end

		self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.latticeScrollRect:SetContentWidthWithMapCount(#self.acticity)
		self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.latticeScrollRect:SetTargetItemIndex(1)
		self:get_acticity_surplus_time(self.acticity[1])

		self.show_index = 1

		if self.show_crubs_list[1] then
			self.show_crubs_list[1].image.sprite = self:loadSprite(var_0_4(var_0_7.main_banner_list, "selected"))

			self.show_crubs_list[1]:GetComponent("Image"):SetNativeSize()
		end
	end

	function arg_1_0:__refresh_acticity()
		self._acitveControlList = {}
		self._active_isopen_list = {}
		self.show_crubs_list = {}

		for iter_138_0 = 1, self._control.mp_activity_node.crumbs.transform.childCount do
			self:destroyGameObject(self._control.mp_activity_node.crumbs.transform:GetChild(iter_138_0 - 1).gameObject)
		end

		for iter_138_1 = 1, self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.viewport.content.transform.childCount do
			self:destroyGameObject(self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.viewport.content.transform:GetChild(iter_138_1 - 1).gameObject)
		end
	end

	function arg_1_0:__acticity_scorll_jump_event()
		if self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.latticeScrollRect.m_ShowItemIndex == 0 then
			self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.latticeScrollRect:SetTargetItemIndex(#self.acticity - 2)
		end

		if self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.latticeScrollRect.m_ShowItemIndex == #self.acticity - 1 then
			self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.latticeScrollRect:SetTargetItemIndex(1)
		end
	end

	function arg_1_0:active_is_open(arg_140_1)
		if not arg_140_1 then
			return false
		end

		return self._active_isopen_list and self._active_isopen_list[arg_140_1]
	end

	function arg_1_0.get_acticity_time(arg_141_0, arg_141_1)
		if not arg_141_1 then
			return false
		end

		local var_141_0 = arg_141_1.start_time or 0
		local var_141_1 = arg_141_1.end_time or 0

		if arg_141_1.start_time == 0 or arg_141_1.end_time == 0 then
			return false
		end

		local var_141_2 = arg_141_1.award_time or 0
		local var_141_3 = var_0_3:get_emergency_info()

		if var_141_3 and next(var_141_3) then
			for iter_141_0, iter_141_1 in pairs(var_141_3) do
				if iter_141_1.id == arg_141_1.id then
					var_141_0 = iter_141_1.start_time
					var_141_1 = iter_141_1.end_time
					var_141_2 = iter_141_1.award_time
				end
			end
		end

		if var_141_2 == 0 then
			if var_141_0 < lx.ServerTime:getUtcTime() and var_141_1 > lx.ServerTime:getUtcTime() then
				return true
			end
		elseif var_141_0 < lx.ServerTime:getUtcTime() and var_141_2 > lx.ServerTime:getUtcTime() then
			return true
		end

		return false
	end

	function arg_1_0:get_acticity_surplus_time(arg_142_1)
		local var_142_0 = arg_142_1.end_time - lx.ServerTime:getUtcTime()

		if var_142_0 < 0 then
			var_142_0 = arg_142_1.award_time - lx.ServerTime:getUtcTime()
		end

		if var_142_0 > 86400 then
			self._control.mp_activity_node.surplus_time_text.text.text = var_0_4(var_0_1:getNowLang("daysleft2"), math.floor(var_142_0 / 86400))
		elseif var_142_0 > 3600 then
			self._control.mp_activity_node.surplus_time_text.text.text = var_0_4(var_0_1:getNowLang("hourleft"), math.floor(var_142_0 / 3600))
		elseif var_142_0 > 60 then
			self._control.mp_activity_node.surplus_time_text.text.text = var_0_4(var_0_1:getNowLang("minleft"), math.floor(var_142_0 / 60))
		elseif var_142_0 > 0 and var_142_0 <= 60 then
			self._control.mp_activity_node.surplus_time_text.text.text = var_0_4(var_0_1:getNowLang("minleft"), math.floor(1))
		end

		if not self.surplus_time or var_142_0 < self.surplus_time then
			self.surplus_time = var_142_0
		end
	end

	function arg_1_0:__acticity_scorll_auto_event()
		local var_143_0 = self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.latticeScrollRect.m_ShowItemIndex

		self.show_index = self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.latticeScrollRect.m_ShowItemIndex + 1

		if self.show_index >= #self.acticity then
			self.show_index = 1
		end

		self:get_acticity_surplus_time(self.acticity[self.show_index])
		self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.viewport.content.transform:DOLocalMoveX(-178.22, 0.5):SetRelative(true):SetAutoKill(true):OnComplete(function()
			if self and self._control then
				self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.latticeScrollRect:SetTargetItemIndex(var_143_0 + 1)
			end

			for iter_144_0, iter_144_1 in pairs(self.show_crubs_list) do
				iter_144_1.image.sprite = self:loadSprite(var_0_4(var_0_7.main_banner_list, "normal"))

				iter_144_1:GetComponent("Image"):SetNativeSize()
			end

			if self.show_crubs_list[self.show_index] then
				self.show_crubs_list[self.show_index].image.sprite = self:loadSprite(var_0_4(var_0_7.main_banner_list, "selected"))

				self.show_crubs_list[self.show_index]:GetComponent("Image"):SetNativeSize()
			else
				self.show_crubs_list[1].image.sprite = self:loadSprite(var_0_4(var_0_7.main_banner_list, "selected"))

				self.show_crubs_list[1]:GetComponent("Image"):SetNativeSize()
			end
		end)
	end

	function arg_1_0:__six_acticity_enter_event()
		self:setVisible(false)
		var_0_2:createInstance("six_year_main_interface"):show()
	end

	function arg_1_0:__fearlessness_sea_acticity_enter_event(arg_146_1)
		self:setVisible(false)
		var_0_2:createInstance("fearlessness_sea"):show(arg_146_1)
		var_0_3:set_fearlessness_id(arg_146_1)
		var_0_3:req_PushActivityGetInReq()
	end

	function arg_1_0:__climb_tower_acticity_enter_event(arg_147_1)
		self:setVisible(false)
		var_0_2:createInstance("climb_tower"):show(arg_147_1)

		local var_147_0 = var_0_3:get_tower_chip_info()

		if var_147_0.new and var_147_0.new ~= 0 then
			var_0_2:createInstance("analysis_room"):show()
			var_0_2:createInstance("tactical_machine"):show()
		end
	end

	function arg_1_0:__ocean_main_map_acticity_enter_event()
		self:setVisible(false)
		var_0_2:createInstance("ocean_main_map"):show()
	end

	function arg_1_0:__score_push_map_acticity_enter_event(arg_149_1)
		self:setVisible(false)

		if var_0_2:getInstance("score_push_map") then
			var_0_2:destroyInstance("score_push_map")
		end

		var_0_2:createInstance("score_push_map"):show(arg_149_1)
	end

	function arg_1_0:__strike_main_acticity_enter_event(arg_150_1)
		var_0_3:req_SolidInitBattleDataReq()
		self:setVisible(false)
		var_0_2:createInstance("strike_main"):show(nil, arg_150_1)
	end

	function arg_1_0:get_strike_info_id()
		for iter_151_0 = 1, #self.acticity do
			if self.acticity[iter_151_0].type == var_0_7.pve_active_type.strike_event then
				return self.acticity[iter_151_0].id
			end
		end
	end

	function arg_1_0:__fifth_event_acticity_enter_event()
		self:setVisible(false)
		var_0_2:createInstance("fifth_event"):show()
	end

	function arg_1_0.__bootyshop_event_acticity_enter_event(arg_153_0)
		var_0_2:createInstance("bootyshop"):show(var_0_7.go_to_bootyshop.home_go)
	end

	function arg_1_0.__dock_event_acticity_enter_event(arg_154_0)
		local var_154_0 = var_0_2:createInstance("dock")

		var_154_0:show(true)
		var_154_0:set_enter_type("home")
	end

	function arg_1_0:__fire_fighting_moth_acticity_enter_event(arg_155_1)
		self:setVisible(false)
		var_0_2:createInstance("fearlessness_sea"):show(arg_155_1)
		var_0_3:set_fearlessness_id(arg_155_1)
	end

	function arg_1_0.__strike_two_event_enter_event(arg_156_0)
		var_0_2:createInstance("strike_main"):show()
	end

	function arg_1_0.__abyss_event_acticity_enter_event(arg_157_0)
		local var_157_0 = var_0_2:createInstance("abyss_event")
		local var_157_1 = var_157_0:create_chapter_cfg()

		if var_157_1 and next(var_157_1) then
			var_0_3:setAbyssBossInfoRespCallback(function()
				local var_158_0 = var_0_2:getInstance("home")

				if var_158_0 then
					var_158_0:setVisible(false)
				end

				var_157_0:show(true, true)
			end)
			var_0_3:req_AbyssBossInfoReq(next(var_157_1))
		end
	end

	function arg_1_0:__seventh_event_acticity_enter_event(arg_159_1)
		self:setVisible(false)
		var_0_2:createInstance("mix_main_map"):show(arg_159_1)
	end

	function arg_1_0:__eighth_event_acticity_enter_event(arg_160_1)
		self:setVisible(false)
		var_0_3:set_eighth_team()
		var_0_2:createInstance("eighth_main_map"):show(arg_160_1)

		local var_160_0 = {
			id = arg_160_1
		}

		var_160_0.start_time = 1
		var_160_0.end_time = 0

		var_0_3:req_ActivityDurationReq(var_160_0)
	end

	function arg_1_0:__mist_event_acticity_enter_event(arg_161_1)
		if not var_0_7:getIsCheckNf() and gamecore.SubPatchManager:isDataNFNeedUpdate() then
			gamecore.SubPatchManager:downloadDataNF()
		else
			gamecore.SubPatchManager:copy_nfdb_to_writepath()
			self:setVisible(false)
			var_0_2:createInstance("nf_main_interface"):show()

			local var_161_0 = {}

			var_161_0.id = 56
			var_161_0.start_time = 1
			var_161_0.end_time = 0

			var_0_3:req_ActivityDurationReq(var_161_0)
		end
	end

	function arg_1_0:__ninth_event_acticity_enter_event(arg_162_1)
		self:setVisible(false)

		local var_162_0 = var_0_2:createInstance("ninth_main_map")

		if var_162_0 then
			var_162_0:show(arg_162_1)
		end

		local var_162_1 = {
			id = arg_162_1
		}

		var_162_1.start_time = 1
		var_162_1.end_time = 0

		var_0_3:req_ActivityDurationReq(var_162_1)
	end

	function arg_1_0.__ten_event_acticity_enter_event(arg_163_0)
		var_0_2:createInstance("msgbox"):show(var_0_1:getNowLang("tenth_shop"), function()
			arg_163_0:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
			UnityEngine.Application.OpenURL("https://zhongchou.modian.com/item/135256.html")
		end, function()
			arg_163_0:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.back))
		end, var_0_1:getNowLang("jumpornot"), var_0_7.msg_type.tip, nil)
	end

	function arg_1_0.__figurines_event_acticity_enter_event(arg_166_0)
		var_0_2:createInstance("msgbox"):show(var_0_1:getNowLang("tenth_shop"), function()
			arg_166_0:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
			UnityEngine.Application.OpenURL("https://e.tb.cn/h.7DgmUR0Vxt1xTGS?tk=nQZfUOxYBxh")
		end, function()
			arg_166_0:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.back))
		end, var_0_1:getNowLang("jumpornot"), var_0_7.msg_type.tip, nil)
	end

	function arg_1_0:_play_audio(arg_169_1)
		var_0_21:init()
		self:playBackgroundMusic(arg_169_1, true)
	end

	function arg_1_0:_play_into_se(arg_170_1)
		self:playSE(arg_170_1, false)
	end

	function arg_1_0.__show_school_open_prompt(arg_171_0)
		if var_0_3:get_school_open_condition() then
			var_0_2:createInstance("school_open_view"):show()
			var_0_3:set_school_open_condition(false)
		end
	end

	function arg_1_0:__show_guide_info()
		local var_172_0 = var_0_2:getInstance("guide_panel")

		if var_172_0 then
			if var_172_0:get_current_step() == var_0_7.guide_const_id.ten_group.one then
				var_172_0:set_limit_step_to_complate(var_0_7.guide_const_id.ten_group.one)
				self:init_announcement()

				return
			end

			local var_172_1 = var_172_0:get_next_step()

			if var_172_1 == var_0_7.guide_const_id.second_group.zero or var_172_1 == var_0_7.guide_const_id.nine_group.zero or var_172_1 == var_0_7.guide_const_id.five_group.zero then
				var_172_0:reset_guide_panel()
			elseif var_172_1 == var_0_7.guide_const_id.first_group.six or var_172_1 == var_0_7.guide_const_id.first_group.seven then
				if var_0_2:getInstance("combat_result") then
					return
				end

				var_172_0:set_current_step(8)
				var_172_0:reset_guide_panel()
			elseif var_172_1 == var_0_7.guide_const_id.first_group.five then
				if var_0_2:getInstance("combat_result") then
					return
				end

				var_172_0:set_current_step(0)
				var_172_0:reset_guide_panel()
			elseif var_172_1 == var_0_7.guide_const_id.ten_group.zero then
				var_172_0:set_limit_step_to_complate(var_0_7.guide_const_id.ten_group.one)
			end
		end
	end

	function arg_1_0.__destroy_guide_view(arg_173_0)
		var_0_2:destroyInstance("guide_panel_mask")
		var_0_2:destroyInstance("guide_panel")
	end

	function arg_1_0:__role_move(arg_174_1)
		local var_174_0 = self._control.flower_day.transform:GetComponentInParent(typeof(UnityEngine.Canvas)).scaleFactor

		self._role_move_seq = self:autoKillDOTween(var_0_13.Sequence())

		self._role_move_seq:Append(self._control.model_layer.cc_sprite.icon.rectTransform:DOLocalMoveY(-7, 10))
		self._role_move_seq:Append(self._control.model_layer.cc_sprite.icon.rectTransform:DOLocalMoveY(0, 10))
		self._role_move_seq:SetLoops(-1)
	end

	function arg_1_0:__update_not_pass_map()
		local var_175_0, var_175_1 = self:__get_map_data()
		local var_175_2 = {}
		local var_175_4 = var_0_3:get_map_list()
		local var_175_5 = 0
		local var_175_6 = 0

		if not var_175_4 and not next(var_175_4) then
			self:__not_pass_map_light(true)

			return
		end

		for iter_175_0, iter_175_1 in pairs(var_175_4) do
			for iter_175_2, iter_175_3 in pairs(var_175_0) do
				if iter_175_1.id == iter_175_3 then
					var_175_5 = var_175_5 + 1

					var_0_15(var_175_2, iter_175_1)
				end
			end
		end

		if var_175_5 < var_175_1 then
			self:__not_pass_map_light(true)

			return
		end

		if var_175_2 and next(var_175_2) then
			for iter_175_4, iter_175_5 in pairs(var_175_2) do
				if iter_175_5.hp > 0 then
					var_175_6 = var_175_6 + 1
				end
			end
		else
			self:__not_pass_map_light(true)
		end

		if var_175_6 > 0 then
			self:__not_pass_map_light(true)
		else
			self:__not_pass_map_light(false)
		end
	end

	function arg_1_0.__get_map_data(arg_176_0)
		local var_176_0 = {}
		local var_176_1, var_176_2 = gameconfig.map_config.get_sequence()

		for iter_176_0, iter_176_1 in pairs(var_176_1) do
			if tonumber(iter_176_1.pve_id) < 20 then
				var_0_15(var_176_0, iter_176_1.id)
			end
		end

		return var_176_0, var_176_2
	end

	function arg_1_0:__look_over_view(arg_177_1)
		local var_177_2 = 400
		local var_177_3 = 800

		self._control.model_layer.shipViewControl.onDrag:RemoveAllListeners()
		self._control.model_layer.shipViewControl.onDrag:AddListener(function(arg_178_0, arg_178_1)
			local var_178_0 = self._control.model_layer.rectTransform.anchoredPosition.x + arg_178_0
			local var_178_1 = self._control.model_layer.rectTransform.anchoredPosition.y + arg_178_1

			if self._control.model_layer.rectTransform.anchoredPosition.x + arg_178_0 <= -550 then
				var_178_0 = -550
			end

			if var_178_0 >= var_177_2 then
				var_178_0 = var_177_2
			end

			if arg_177_1 then
				if var_178_1 <= (-var_177_3 / 2 + 66.5) * 3 then
					var_178_1 = (-var_177_3 / 2 + 66.5) * 3
				end

				if var_178_1 >= (var_177_3 / 2 + 66.5) * 3 then
					var_178_1 = (var_177_3 / 2 + 66.5) * 3
				end
			else
				if var_178_1 <= -var_177_3 / 2 + 66.5 then
					var_178_1 = -var_177_3 / 2 + 66.5
				end

				if var_178_1 >= var_177_3 / 2 + 66.5 then
					var_178_1 = var_177_3 / 2 + 66.5
				end
			end

			if not self._allow_mouse_move then
				self._control.model_layer.rectTransform.anchoredPosition = var_0_34(var_178_0, var_178_1)
			end
		end)
	end

	function arg_1_0:_init_main_panel_position()
		self._control.model_layer.rectTransform.anchoredPosition = var_0_34(-288, 0)

		if 0.33 then
			self._control.top.role_scale.slide.slider.value = 0.33

			self._control.model_layer.cc_sprite.icon.shipViewControl:SetScale(0.33 * 100 / 66 - 0.5)

			self._control.model_layer.cc_sprite.icon.transform.localScale = var_0_35.New(self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.x, self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.y, self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.z)
		end

		if var_0_25.touchCount <= 1 then
			self._control.model_layer.shipViewControl.enabled = true
		end

		self._control.top.role_scale.slide.slider.onValueChanged:AddListener(function(arg_180_0)
			arg_180_0 = arg_180_0 * 100 / 66 - 0.5

			self._control.model_layer.cc_sprite.icon.shipViewControl:SetScale(arg_180_0)

			self._control.model_layer.cc_sprite.icon.transform.localScale = var_0_35.New(self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.x, self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.y, self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.z)
		end)
	end

	function arg_1_0:refresh_view_scale()
		local var_181_0 = self._control.top.role_scale.slide.slider.value

		if var_0_25.touchCount > 1 then
			self._control.model_layer.shipViewControl.enabled = false
			self.lastDistance = self.lastDistance and self.lastDistance or 0
			self.twoTouchDistance = self.twoTouchDistance and self.twoTouchDistance or 0

			if var_0_25.GetTouch(1).phase == var_0_36.Began then
				local var_181_2 = var_0_25.GetTouch(0).position
				local var_181_3 = var_0_25.GetTouch(1).position

				self.lastDistance = var_0_34.Distance(var_181_2, var_181_3)
				self.twoTouchDistance = var_0_34.Distance(var_181_2, var_181_3)
			end

			local var_181_4

			if var_0_25.GetTouch(0).phase ~= var_0_36.Moved then
				if var_0_25.GetTouch(1).phase == var_0_36.Moved then
					self.twoTouchDistance = var_0_34.Distance(var_0_25.GetTouch(0).position, var_0_25.GetTouch(1).position)
					var_181_4 = (self.twoTouchDistance - self.lastDistance) / 100
				end

				if var_181_4 and var_181_4 > 0 then
					var_181_0 = var_181_0 + var_181_4 * 0.1
					self._control.top.role_scale.slide.slider.value = var_181_0

					if var_181_0 >= 0.99 then
						return
					end

					var_181_0 = var_181_0 * 100 / 66 - 0.5

					if self._is_spine_2d then
						self._control.model_layer.home_spine_pre.shipViewControl:SetScale(var_181_0)

						self._control.model_layer.home_spine_pre.transform.localScale = var_0_35.New(1 * self._control.model_layer.home_spine_pre.transform.localScale.x, 1 * self._control.model_layer.home_spine_pre.transform.localScale.y, 1 * self._control.model_layer.home_spine_pre.transform.localScale.z)
					else
						self._control.model_layer.cc_sprite.icon.shipViewControl:SetScale(var_181_0)

						self._control.model_layer.cc_sprite.icon.transform.localScale = var_0_35.New(self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.x, self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.y, self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.z)
					end
				elseif var_181_4 and var_181_4 < 0 then
					self._control.top.role_scale.slide.slider.value = var_181_0 + var_181_4 * 0.1

					if var_181_0 + var_181_4 * 0.1 < 0.01 then
						return
					end

					local var_181_5 = (var_181_0 + var_181_4 * 0.1) * 100 / 66 - 0.5

					if self._is_spine_2d then
						self._control.model_layer.home_spine_pre.shipViewControl:SetScale(var_181_5)

						self._control.model_layer.home_spine_pre.transform.localScale = var_0_35.New(1 * self._control.model_layer.home_spine_pre.transform.localScale.x, 1 * self._control.model_layer.home_spine_pre.transform.localScale.y, 1 * self._control.model_layer.home_spine_pre.transform.localScale.z)
					else
						self._control.model_layer.cc_sprite.icon.shipViewControl:SetScale(var_181_5)

						self._control.model_layer.cc_sprite.icon.transform.localScale = var_0_35.New(self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.x, self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.y, self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.z)
					end
				end

				if self.twoTouchDistance then
					self.lastDistance = self.twoTouchDistance
				end

				if var_0_25.GetTouch(1).phase == var_0_36.Ended then
					self.lastDistance = 0
					self.twoTouchDistance = 0
				end
			end
		else
			self._control.model_layer.shipViewControl.enabled = true
		end
	end

	function arg_1_0:_update_main_position()
		local var_182_0 = var_0_3:get_main_icon_panel_position(self._main_panel_cid)
		local var_182_1 = -288
		local var_182_2 = 0
		local var_182_3 = 0.33
		local var_182_4 = 0.33

		if var_182_0 and var_182_0.cid == self._main_panel_cid then
			var_182_1 = var_182_0.pos_x / 100
			var_182_2 = var_182_0.pos_y / 100
			var_182_3 = var_182_0.scale / 100
			var_182_4 = var_182_0.scale / 100
		end

		self._control.model_layer.rectTransform.anchoredPosition = var_0_34(var_182_1, var_182_2)

		if var_182_3 then
			self._control.top.role_scale.slide.slider.value = var_182_3

			self._control.model_layer.cc_sprite.icon.shipViewControl:SetScale(var_182_3 * 100 / 66 - 0.5)

			self._control.model_layer.cc_sprite.icon.transform.localScale = var_0_35.New(self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.x, self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.y, self._init_scale * self._control.model_layer.cc_sprite.icon.transform.localScale.z)
		end

		if var_182_0 and self._model_layer_is_spine then
			self._control.model_layer.cc_sprite.icon.shipViewControl:SetScale(var_182_4 * 100 / 66 - 0.5)

			self._control.model_layer.home_spine_pre.transform.localScale = var_0_35.New(1 * self._control.model_layer.home_spine_pre.transform.localScale.x, 1 * self._control.model_layer.home_spine_pre.transform.localScale.y, 1 * self._control.model_layer.home_spine_pre.transform.localScale.z)
		end
	end

	function arg_1_0.set_click_opean_time(arg_183_0, arg_183_1)
		arg_183_0.click_opean_time = arg_183_1
	end

	function arg_1_0:get_click_opean_time()
		return self.click_opean_time
	end

	function arg_1_0:set_home_panel_active_time()
		local var_185_0 = self:autoKillDOTween(var_0_13.Sequence())

		var_185_0:AppendInterval(0.1)
		var_185_0:AppendCallback(function()
			for iter_186_0 = 1, self._control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.viewport.content.transform.childCount do
				self:destroyChildren("home_activity_scroll_item")

				self.is_have_acticity = false
			end

			for iter_186_1 = 1, self._control.mp_activity_node.crumbs.transform.childCount do
				self:destroyChildren("crumbs_point")

				self.is_have_acticity = false
			end

			if self.is_have_acticity == false then
				self:__acticity_scorll()

				self.is_have_acticity = true
			end
		end)
	end

	function arg_1_0:__have_research_ship_need_change_stage_info()
		if not self:__is_have_research_data() then
			return
		end

		if not var_0_3:get_now_research_ship_id() then
			local var_187_1 = var_0_3:get_init_ship_research_id()

			if var_187_1 < 10000 then
				return
			end

			local var_187_2 = var_0_39.find_object_by_id(var_187_1)

			if var_187_2 and next(var_187_2) and (var_187_2.stage == 1 or var_187_2.stage == 2) then
				local var_187_3 = lx.ServerTime:getUtcTime()
				local var_187_4 = 0

				for iter_187_0, iter_187_1 in pairs((var_0_3:get_ship_task_info())) do
					if iter_187_1.id == var_187_1 then
						var_187_4 = iter_187_1.complete_time
					end
				end

				if var_187_4 ~= 0 and var_187_3 >= var_187_4 + var_0_7.research_ship_time then
					var_0_3:req_ResearchBoatIdReq(var_187_1 + 1)

					return
				end
			end
		end
	end

	function arg_1_0.__is_have_research_data(arg_188_0)
		local var_188_0 = var_0_3:get_ship_task_info()
		local var_188_1 = var_0_3:get_equip_task_info()

		if var_188_0 and next(var_188_0) then
			for iter_188_0, iter_188_1 in ipairs(var_188_0) do
				if iter_188_1.task_num_1 > 0 then
					return true
				end
			end
		end

		if var_188_1 and next(var_188_1) then
			for iter_188_2, iter_188_3 in ipairs(var_188_1) do
				if iter_188_3.task_num_1 > 0 then
					return true
				end
			end
		end
	end

	function arg_1_0.__check_solid_battle_data(arg_189_0)
		local var_189_0 = lx.ServerTime:getUtcTime()
		local var_189_1 = var_0_19.find_object_by_id(var_0_28.find_object_by_id(17).content.activeId)

		if var_189_1 then
			if var_0_28.find_object_by_id(17).content.startTime < var_189_0 and var_189_0 < var_189_1.award_time then
				var_0_3:req_SolidInitBattleDataReq()
				var_0_3:reset_strike_enter_battle_nunber()
			end
		end
	end

	function arg_1_0.get_setting_broken(arg_190_0)
		local var_190_0 = lx.UserData:getKeyData(var_0_7.setting_key_list.setting_broken)
		local var_190_1 = true

		if var_190_0 ~= "" and var_190_0 ~= " " then
			var_190_1 = lx.json_decode(var_190_0).value
		end

		if var_190_1 ~= "" and var_190_1 ~= " " and type(var_190_1) == "boolean" then
			var_190_1 = var_190_1 or false
		end

		return var_190_1
	end

	function arg_1_0.check_open_broken(arg_191_0)
		local var_191_0 = app:getSystem():getChannel()

		return (gamecore.SubPatchManager:getIsDownloadPatch("data2") or var_191_0 == gameenum.common_type.channel.android_jp or var_191_0 == gameenum.common_type.channel.iOS_jp) and true
	end

	function arg_1_0.check_special_dialogue(arg_192_0, arg_192_1, arg_192_2, arg_192_3, arg_192_4)
		local var_192_0 = 0

		for iter_192_0, iter_192_1 in pairs(arg_192_1) do
			if iter_192_1.type == 1 then
				local var_192_1 = var_0_3:get_cardbook_ship_list()
				local var_192_2 = 0

				for iter_192_2, iter_192_3 in pairs(iter_192_1.cid) do
					for iter_192_4, iter_192_5 in ipairs(var_192_1) do
						if iter_192_3 == iter_192_5.id then
							var_192_2 = var_192_2 + 1

							break
						end
					end
				end

				if var_192_2 >= #iter_192_1.cid then
					var_192_0 = var_192_0 + 1
				else
					return false
				end
			elseif iter_192_1.type == 2 then
				local var_192_3 = var_0_3:get_skin_list()
				local var_192_4 = 0

				for iter_192_6, iter_192_7 in pairs(iter_192_1.cid) do
					for iter_192_8, iter_192_9 in pairs(var_192_3) do
						if var_0_10.have_data(iter_192_9, iter_192_7) then
							var_192_4 = var_192_4 + 1
						end
					end
				end

				if var_192_4 >= #iter_192_1.cid then
					var_192_0 = var_192_0 + 1
				else
					return false
				end
			elseif iter_192_1.type == 3 then
				local var_192_5 = var_0_3:get_marrystate_ship()
				local var_192_6 = 0

				for iter_192_10, iter_192_11 in pairs(iter_192_1.cid) do
					local var_192_7 = var_0_5.find_object_by_cid(iter_192_11)
					local var_192_8 = 0

					if var_192_7.can_evo then
						var_192_8 = var_192_7.evo_to_cid
					end

					if var_0_10.have_data(var_192_5, iter_192_11) or var_192_8 ~= 0 and var_0_10.have_data(var_192_5, var_192_8) then
						var_192_6 = var_192_6 + 1
					end
				end

				if var_192_6 >= #iter_192_1.cid then
					var_192_0 = var_192_0 + 1
				else
					return false
				end
			end
		end

		if arg_192_2 == 1 then
			for iter_192_12, iter_192_13 in pairs(arg_192_3) do
				var_0_15(arg_192_4, iter_192_13)
			end
		end

		if var_192_0 == #arg_192_1 then
			return true
		else
			return false
		end
	end

	function arg_1_0.get_add_dialogue(arg_193_0, arg_193_1, arg_193_2, arg_193_3, arg_193_4, arg_193_5)
		local var_193_0 = {}

		if arg_193_5 and next(arg_193_5) then
			for iter_193_0, iter_193_1 in pairs(arg_193_4) do
				if not var_0_10.have_data(arg_193_5, iter_193_0) and iter_193_1.dialogue_type == arg_193_3 and iter_193_1.dialogue_time == arg_193_2 then
					var_0_15(var_193_0, iter_193_0)
				end
			end
		end

		for iter_193_2, iter_193_3 in pairs(arg_193_4) do
			if iter_193_3.dialogue_type == arg_193_3 and iter_193_3.dialogue_time == arg_193_2 then
				if arg_193_1 > #iter_193_3.switchover then
					arg_193_1 = arg_193_1 - #iter_193_3.switchover
				elseif var_193_0 and next(var_193_0) and #var_193_0 < #arg_193_4 then
					local var_193_1 = iter_193_3.switchover[arg_193_1]

					for iter_193_4, iter_193_5 in pairs(var_193_0) do
						if iter_193_5 <= var_193_1 then
							var_193_1 = var_193_1 + 1
						end
					end

					return var_193_1
				else
					return iter_193_3.switchover[arg_193_1]
				end
			end
		end
	end

	function arg_1_0.check_dialogue_change_pic(arg_194_0, arg_194_1, arg_194_2)
		if arg_194_1.skin ~= 0 then
			local var_194_0 = var_0_6.find_object_by_cid(arg_194_1.skin)

			if var_194_0.dialogue_add and next(var_194_0.dialogue_add) and var_194_0.main_dialogue_2 ~= "" then
				if not next(var_194_0.switchover) and next(var_194_0.switchover_path) then
					for iter_194_0, iter_194_1 in pairs(var_194_0.switchover_path) do
						if iter_194_1.dialogue_state == 2 then
							for iter_194_2, iter_194_3 in pairs(iter_194_1.dialogue) do
								if iter_194_3 == arg_194_2 then
									return true
								end
							end
						end
					end
				else
					for iter_194_4, iter_194_5 in pairs(var_194_0.dialogue_add) do
						if var_0_10.have_index(iter_194_5, "switchover_path") then
							for iter_194_6, iter_194_7 in pairs(iter_194_5.switchover) do
								if iter_194_7 == arg_194_2 then
									return true
								end
							end
						end
					end
				end
			end
		end

		return false
	end

	function arg_1_0.add_dialogue_change_pic(arg_195_0, arg_195_1, arg_195_2)
		if arg_195_1.skin ~= 0 then
			local var_195_0 = var_0_6.find_object_by_cid(arg_195_1.skin)

			if var_195_0.dialogue_add and next(var_195_0.dialogue_add) and var_195_0.main_dialogue_2 ~= "" then
				if not next(var_195_0.switchover) and next(var_195_0.switchover_path) then
					for iter_195_0, iter_195_1 in pairs(var_195_0.switchover_path) do
						if iter_195_1.dialogue_state == 2 then
							for iter_195_2, iter_195_3 in pairs(iter_195_1.dialogue) do
								if iter_195_3 == arg_195_2 then
									return true, iter_195_1.path
								end
							end
						end
					end
				else
					for iter_195_4, iter_195_5 in pairs(var_195_0.dialogue_add) do
						if var_0_10.have_index(iter_195_5, "switchover_path") then
							for iter_195_6, iter_195_7 in pairs(iter_195_5.switchover) do
								if iter_195_7 == arg_195_2 then
									for iter_195_8, iter_195_9 in pairs(iter_195_5.switchover_path) do
										return true, iter_195_9
									end
								end
							end
						end
					end
				end
			end
		end

		return false
	end

	function arg_1_0.__play_animation_func(arg_196_0, arg_196_1, arg_196_2, arg_196_3, arg_196_4)
		local var_196_0 = arg_196_1:GetComponent("SkeletonGraphic")

		arg_196_0.__ske_ani = var_196_0.AnimationState

		if arg_196_4 then
			local var_196_1 = var_196_0.AnimationState.Complete

			local function var_196_2()
				arg_196_4()

				var_196_0.AnimationState.Complete = var_196_1
			end

			var_196_1 = var_196_0.AnimationState.Complete + var_196_2
			var_196_0.AnimationState.Complete = var_196_0.AnimationState.Complete + var_196_2
			var_196_1 = var_196_1 - var_196_2
		end

		var_196_0.AnimationState:SetAnimation(0, arg_196_2, arg_196_3)

		arg_196_0._now_motions = arg_196_2
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_198_0)
	local var_198_0 = var_0_2:class("home")

	var_198_0._data = nil
	var_198_0._already_init = false
	var_198_0._getaward = nil
	var_198_0._user_name = nil
	var_198_0._user_data = nil
	var_198_0._is_live_2d = false
	var_198_0._dock_finish_type = nil
	var_198_0._shop_config_list = {}
	var_198_0._start_buff = false
	var_198_0._start_cook_buff = false
	var_198_0._start_race_buff = false
	var_198_0._buff_tip_info_list = {}
	var_198_0._cur_show_buff_tip_index = nil
	var_198_0._buff_contents = {}
	var_198_0._is_play_music = false
	var_198_0._task_array = {}
	var_198_0.level_tips = false
	var_198_0._acitveControlList = {}
	var_198_0.is_have_acticity = false
	var_198_0.time = 0
	var_198_0.time_2 = 0
	var_198_0.acticity = {}
	var_198_0.is_down = false
	var_198_0.is_announcement = false
	var_198_0._scene_main = nil
	var_198_0.get_sign_rse = false
	var_198_0._record_task_state = false
	var_198_0._continue_talk = false
	var_198_0._sp_bgm = false
	var_198_0._now_animator = true
	var_198_0.menu_is_open = false
	var_198_0.is_close = false
	var_198_0.glass_on = false
	var_198_0.canot_click = false
	var_198_0.live2d_time = 0
	var_198_0._sure_come = true
	var_198_0._have_cv = false
	var_198_0._can_change_scale = true
	var_198_0._init_distance = nil
	var_198_0.click_opean_time = 1
	var_198_0.lastDistance = 0
	var_198_0.twoTouchDistance = 0
	var_198_0._main_panel_cid = 0
	var_198_0._is_last_picture_hd = false
	var_198_0._is_hd_icon = false
	var_198_0._is_visible = false
	var_198_0._limit_time_task = 0
	var_198_0._limit_left_time = 0
	var_198_0._secretary_id = nil
	var_198_0._last_secretary_cid = 0
	var_198_0._allow_mouse_move = true
	var_198_0._ship_pos_start_pos = nil
	var_198_0._ship_pos_end_pos = nil
	var_198_0._secretary_rand_num = 0
	var_198_0._role_sp_change = false
	var_198_0._spine_model = nil

	return var_198_0
end

return var_0_0
