local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = string.format
local var_0_5 = table.insert
local var_0_6 = gameenum.common_type
local var_0_7 = gameconfig.ship_config
local var_0_8 = gameconfig.equip_config
local var_0_9 = table.remove
local var_0_10 = DG.Tweening.DOTween
local var_0_11 = gamecore.prompt
local var_0_12 = gameconfig.skill_config
local var_0_13 = gamecore.util_func
local var_0_14 = gamecore.AudioManager
local var_0_19 = gameconfig.music_config
local var_0_21 = UnityEngine.Screen
local var_0_22 = gameconfig.ship_pve_active_config
local var_0_23 = gameconfig.pve_active_map_config
local var_0_24 = {
	"stars_1",
	"stars_2",
	"stars_3",
	"stars_4",
	"stars_5",
	"stars_6"
}
local var_0_26 = {
	ship = "get_new_ship",
	weapon = "get_new_weapon"
}
local var_0_27 = {
	"grey",
	"green",
	"blue",
	"purple",
	"gold",
	"rainbow"
}

gamecore.UILoader:define("new_equip_only", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
		self:_set_sp_scene_order(arg_2_3)

		self._is_new_ship = false
		self._skin_data = arg_2_5
		self._one_lock = false
		self._is_first_init = true

		self:reset_lock_type()
		self._control.back_btn:SetActive(true)

		self._now_battle_type = var_0_3:get_new_battle_type()

		if not arg_2_1 then
			return
		end

		self._back_func = nil

		if arg_2_4 then
			self._back_func = arg_2_4
		end

		self:setVisible(true)
		var_0_14:pauseAll()

		if arg_2_3 then
			self._enter_type = arg_2_3

			if self._enter_type == var_0_6.enter_get_ship_type.remake or self._enter_type == var_0_6.enter_get_ship_type.abyss_evo_panel or self._enter_type == var_0_6.enter_get_ship_type.abyss_get_awards or self._enter_type == var_0_6.enter_get_ship_type.abyss_combine_panel then
				self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.streng_success))

				self._is_new_ship = (self._enter_type == var_0_6.enter_get_ship_type.abyss_evo_panel or self._enter_type == var_0_6.enter_get_ship_type.abyss_combine_panel) and arg_2_2.data.is_new or arg_2_2.is_new
				self._get_skin = arg_2_2.get_skin

				local var_2_0 = var_0_7.find_object_by_cid(arg_2_2.data.cid)

				self._data = arg_2_2.data
				self._ship_data = var_2_0

				self:__init_panel_for_type(var_2_0)
			elseif self._enter_type == var_0_6.enter_get_ship_type.spoils_shop or self._enter_type == var_0_6.enter_get_ship_type.combats_shop or self._enter_type == var_0_6.enter_get_ship_type.up_award or self._enter_type == var_0_6.enter_get_ship_type.salvage_award or self._enter_type == var_0_6.enter_get_ship_type.seven_big_map or self._enter_type == var_0_6.enter_get_ship_type.seven_treasure_find then
				self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.get_item), false)
				self:__init_panel_sopit(arg_2_2)

				self._one_lock = true
			elseif self._enter_type == var_0_6.enter_get_ship_type.sign_and_task then
				self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.get_item), false)

				if var_0_2:getInstance("research_development") then
					self:__init_panel(arg_2_2)
				else
					self:__init_panel_sopit(arg_2_2)
				end
			elseif self._enter_type == var_0_6.enter_get_ship_type.dock_building then
				self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.get_item), false)
				self:__init_panel(arg_2_2)
			elseif self._enter_type == var_0_6.enter_get_ship_type.abyss_panel then
				self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.get_item), false)
				self:__init_panel_sopit(arg_2_2)
				self._control.new_ship.lock_toggle:SetActive(false)
			elseif self._enter_type == var_0_6.enter_get_ship_type.mail_ship_award then
				self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.streng_success))

				self._is_new_ship = arg_2_2.is_new

				local var_2_1 = var_0_7.find_object_by_cid(var_0_3:find_character_by_id(arg_2_2.id).cid)

				self._data = arg_2_2
				self._ship_data = var_2_1

				self:__init_panel_for_type(var_2_1)
			else
				self._ship_data = arg_2_2

				self:__init_panel_for_type(arg_2_2)
			end
		else
			self._enter_type = var_0_6.enter_get_ship_type.other

			self:__init_panel(arg_2_2)
		end

		if self._enter_type ~= var_0_6.enter_get_ship_type.other then
			self:playCV(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.get_ship_equip), false, "cv")
		end

		self:playCV(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.get_item), false, "cv")
		self:show_btns(self._skin_data == nil)

		if self._enter_type == var_0_6.enter_get_ship_type.abyss_panel then
			if tonumber(string.sub(var_0_3:find_character_by_id(arg_2_2.id).cid, 7)) == 18 then
				self:show_abyss_btns(false)
			end
		elseif (self._enter_type == var_0_6.enter_get_ship_type.abyss_evo_panel or self._enter_type == var_0_6.enter_get_ship_type.abyss_combine_panel) and tonumber(string.sub(arg_2_2.data.cid, 7)) == 18 then
			self:show_abyss_btns(false)
		end

		if self._enter_type == var_0_6.enter_get_ship_type.ship_detail then
			self:__check_layer()
			self:show_btns(true)
			self._control.new_anim:SetActive(true)

			self._control.new_ship.lock_toggle.lock_state:GetComponent("Button").enabled = false
			self._control.new_ship.lock_toggle.unlocklock_state:GetComponent("Button").enabled = false
			self._control.new_ship.ship_detail_btn:GetComponent("Button").enabled = false
		end

		self:now_fitting()
	end

	function arg_1_0:_set_sp_scene_order(arg_3_1)
		if arg_3_1 == var_0_6.enter_get_ship_type.seven_treasure_find then
			self._seven_out_type = arg_3_1

			local var_3_0 = var_0_2:getInstance("seven_sea_map")

			if var_3_0 then
				var_3_0._panel.transform:GetComponent("Canvas").sortingOrder = var_3_0._panel.transform:GetComponent("Canvas").sortingOrder - 5
				var_3_0._control.cloud_list.canvas.sortingOrder = var_3_0._control.cloud_list.canvas.sortingOrder - 104
				self._panel.transform:GetComponent(typeof("UnityEngine.Canvas")).sortingOrder = var_3_0._panel.transform:GetComponent("Canvas").sortingOrder + 1

				var_0_2:createInstance("cover"):setVisible(true)
			end
		end
	end

	function arg_1_0:now_fitting()
		self._control.dialog_bg.transform.anchoredPosition = var_0_21.width / var_0_21.height > 1.32 and var_0_21.width / var_0_21.height < 1.44 and Vector2(21, -360) or var_0_21.width / var_0_21.height == 1.6 and Vector2(21, -300) or Vector2(21, -260)
	end

	function arg_1_0:update_lock()
		self._data = var_0_3:find_character_by_id(self._data.id)

		if self._data.lock then
			var_0_11:show(var_0_1:getNowLang("errorcode-320"))
		else
			var_0_11:show(var_0_1:getNowLang("errorcode-321"))
		end
	end

	function arg_1_0:change_skill_result()
		if var_0_2:getInstance("bootyshop") and not self._is_new_ship then
			var_0_2:destroyInstance("new_equip_only")
		end

		self:__set_contents_in_skill_select(true)
		self:__evo_get_skin()
		self:__check_new_ship()
	end

	function arg_1_0:play_animation(arg_7_1, arg_7_2, arg_7_3)
		if arg_7_3 then
			local var_7_0 = self._skeleton_animation_1.state.Complete

			local function var_7_1()
				arg_7_3()

				self._skeleton_animation_1.state.Complete = var_7_0
			end

			var_7_0 = self._skeleton_animation_1.state.Complete + var_7_1
			self._skeleton_animation_1.state.Complete = self._skeleton_animation_1.state.Complete + var_7_1
			var_7_0 = var_7_0 - var_7_1
		end

		self._skeleton_animation_1.AnimationState:SetAnimation(0, arg_7_1, arg_7_2)
	end

	function arg_1_0:set_ship_info(arg_9_1)
		if self._enter_type == var_0_6.enter_get_ship_type.evo_get_skin then
			self._is_new_ship = false
		end

		self:init_animation()

		local var_9_0, var_9_1 = self:loadSprite((var_0_4(var_0_6.ship_icon.model_normal_l, arg_9_1.pic_id, arg_9_1.pic_id)))

		self._control.new_ship.ship_role.image.sprite = var_9_0

		if var_9_1 then
			var_0_6:hd_sprite_half_scale(self._control.new_ship.ship_role.transform)

			local var_9_2 = self._control.new_ship.ship_role:GetComponent("UIScaleTweener")

			var_9_2.from = Vector3(0.75, 0.75, 0.5)
			var_9_2.to = Vector3(0.5, 0.5, 0.5)
		else
			local var_9_3 = self._control.new_ship.ship_role:GetComponent("UIScaleTweener")

			var_9_3.from = Vector3(1.2, 1.2, 1)
			var_9_3.to = Vector3(1, 1, 1)

			var_0_6:hd_sprite_half_scale_big(self._control.new_ship.ship_role.transform)
		end

		if self._enter_type ~= var_0_6.enter_get_ship_type.mall_shop or self._enter_type ~= var_0_6.enter_get_ship_type.evo_get_skin then
			self._control.new_ship.ship_info.ship_type.text.text = var_0_1:getNowLang(var_0_6:get_ship_type_language_key(arg_9_1.type, 2))
			self._control.new_ship.ship_info.ship_name.text.text = arg_9_1.title

			self:play_animation(var_0_24[arg_9_1.star], false, nil)
			self._control.new_anim:SetActive(self._is_new_ship)
			self._control.dialog_bg:SetActive(true)

			if self._enter_type == var_0_6.enter_get_ship_type.mall_shop or self._enter_type == var_0_6.enter_get_ship_type.bootyshop_clothes or self._enter_type == var_0_6.enter_get_ship_type.ship_map or self._enter_type == var_0_6.enter_get_ship_type.abyss_evo_panel or self._enter_type == var_0_6.enter_get_ship_type.abyss_combine_panel or self._enter_type == var_0_6.enter_get_ship_type.mail_skin_award or self._enter_type == var_0_6.enter_get_ship_type.present_exchange or self._enter_type == var_0_6.enter_get_ship_type.evo_get_skin then
				self._control.dialog_bg:SetActive(false)
			end

			self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.get_item), false)

			self._control.dialog_bg.scrollview.content.text.text.text = arg_9_1.get_dialogue
		end

		local var_9_4

		if arg_9_1.cid then
			var_9_4 = arg_9_1.cid % 10000000 % 1000 % 100
		end

		if var_9_4 and var_9_4 ~= 18 then
			self:playCV(var_0_4("%s/%s_get.mp3", arg_9_1.pic_id, arg_9_1.pic_id), false, "cv")
		end

		if self._enter_type == var_0_6.enter_get_ship_type.remake or self._enter_type == var_0_6.enter_get_ship_type.abyss_get_awards then
			self._control.new_anim:SetActive(self._is_new_ship)

			if self._is_new_ship then
				self._new_ship_id = self._data.id

				self._skeleton_animation_3.AnimationState:SetAnimation(0, var_0_26.ship, false)
				self._control.new_ship.lock_toggle.lock_state:SetActive(var_0_3:get_ship_lock_state(self._data.id))
				self._control.new_ship.lock_toggle.unlocklock_state:SetActive(not var_0_3:get_ship_lock_state(self._data.id))
			else
				self._control.new_ship.lock_toggle.lock_state:SetActive(var_0_3:get_ship_lock_state(self._data.id))
				self._control.new_ship.lock_toggle.unlocklock_state:SetActive(not var_0_3:get_ship_lock_state(self._data.id))
			end
		elseif self._enter_type == var_0_6.enter_get_ship_type.dock_building or self._enter_type == var_0_6.enter_get_ship_type.mail_ship_award or self._enter_type == var_0_6.enter_get_ship_type.sign_and_task or self._enter_type == var_0_6.enter_get_ship_type.up_award or self._enter_type == var_0_6.enter_get_ship_type.salvage_award or self._enter_type == var_0_6.enter_get_ship_type.spoils_shop or self._enter_type == var_0_6.enter_get_ship_type.seven_big_map or self._enter_type == var_0_6.enter_get_ship_type.other then
			self._control.new_ship.lock_toggle:SetActive(true)

			if self._is_new_ship then
				self._new_ship_id = self._data.id

				self._skeleton_animation_3.AnimationState:SetAnimation(0, var_0_26.ship, false)
				self._control.new_ship.lock_toggle.lock_state:SetActive(var_0_3:get_ship_lock_state(self._data.id))
				self._control.new_ship.lock_toggle.unlocklock_state:SetActive(not var_0_3:get_ship_lock_state(self._data.id))
			else
				self._control.new_ship.lock_toggle.lock_state:SetActive(var_0_3:get_ship_lock_state(self._data.id))
				self._control.new_ship.lock_toggle.unlocklock_state:SetActive(not var_0_3:get_ship_lock_state(self._data.id))
			end
		end

		self._control.new_ship.ship_dialog.ship_skin_dialog.text.text.text = arg_9_1.title

		self:set_sub_canvas()
		var_0_6:play_in_out_animation(self._control.new_ship.uITweenSequence, true, function()
			return
		end, self._enter_type == var_0_6.enter_get_ship_type.dock_building)
		self:set_spine_skin(arg_9_1.star)
	end

	function arg_1_0:set_sub_canvas()
		self._control.new_ship.ship_role.canvas.sortingOrder = self._base_canvas.sortingOrder + 1
		self._control.star_anim.canvas.sortingOrder = self._base_canvas.sortingOrder + 2
		self._control.new_anim.canvas.sortingOrder = self._base_canvas.sortingOrder + 3
		self._control.new_ship.ship_info.canvas.sortingOrder = self._base_canvas.sortingOrder + 3
	end

	function arg_1_0:set_equip_info(arg_12_1)
		self:init_animation()

		self._control.new_equip.icon.image.sprite = self:loadSprite(var_0_4(var_0_6.equip_icon.equip, arg_12_1.pic_id, arg_12_1.pic_id))
		self._control.new_equip.equip_info.equip_type.text.text = var_0_1:getNowLang(var_0_6:get_equip_type_language_key(arg_12_1.type))
		self._control.new_equip.equip_info.equip_name.text.text = arg_12_1.title

		self:play_animation(var_0_24[arg_12_1.star], false, nil)
		var_0_6:play_in_out_animation(self._control.new_equip.uITweenSequence, true, function()
			return
		end, self._enter_type == var_0_6.enter_get_ship_type.other)
		self._control.dialog_bg:SetActive(false)
		self:set_spine_skin(arg_12_1.star)
	end

	function arg_1_0:init_animation()
		local var_14_0 = self._control.star_anim.transform:GetComponent(typeof(UnityEngine.MeshRenderer))
		local var_14_1 = self._control.role_bg_anim.transform:GetComponent(typeof(UnityEngine.MeshRenderer))
		local var_14_2 = self._control.new_anim.transform:GetComponent(typeof(UnityEngine.MeshRenderer))

		self._skeleton_animation_1 = self._control.star_anim.transform:GetComponent(typeof(Spine.Unity.SkeletonGraphic))
		self._skeleton_animation_2 = self._control.role_bg_anim.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
		self._skeleton_animation_3 = self._control.new_anim.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

		if var_14_0 then
			var_14_0.sortingOrder = self._base_canvas.sortingOrder + 1
		end

		if var_14_1 then
			var_14_1.sortingOrder = self._base_canvas.sortingOrder + 1
		end

		if var_14_2 then
			var_14_2.sortingOrder = self._base_canvas.sortingOrder + 3
		end
	end

	function arg_1_0:show_btns(arg_15_1)
		if self._enter_type == var_0_6.enter_get_ship_type.ship_detail then
			self._control.new_ship.lock_toggle.lock_state:SetActive(arg_15_1)
			self._control.new_ship.lock_toggle.unlocklock_state:SetActive(not arg_15_1)
		elseif self._enter_type == var_0_6.enter_get_ship_type.mall_shop then
			self._control.new_ship.lock_toggle:SetActive(false)
			self._control.new_ship.lock_toggle.lock_state:SetActive(false)
			self._control.new_ship.lock_toggle.unlocklock_state:SetActive(false)
		elseif self._skin_data then
			self._control.new_ship.lock_toggle:SetActive(false)
			self._control.new_ship.lock_toggle.lock_state:SetActive(false)
			self._control.new_ship.lock_toggle.unlocklock_state:SetActive(false)
		elseif self._enter_type ~= var_0_6.enter_get_ship_type.dock_building then
			self._control.new_ship.lock_toggle.lock_state:SetActive(var_0_3:get_ship_lock_state(self._data.id))
			self._control.new_ship.lock_toggle.unlocklock_state:SetActive(not var_0_3:get_ship_lock_state(self._data.id))
		end

		self._control.new_ship.ship_detail_btn:SetActive(arg_15_1)
	end

	function arg_1_0:show_abyss_btns(arg_16_1)
		self._control.new_ship.lock_toggle.lock_state:SetActive(arg_16_1)
		self._control.new_ship.lock_toggle.unlocklock_state:SetActive(not arg_16_1)
		self._control.new_ship.ship_detail_btn:SetActive(false)
		self._control.new_ship.ship_dialog:SetActive(false)
	end

	function arg_1_0:set_spine_skin(arg_17_1)
		self._skeleton_animation_2.initialSkinName = var_0_27[arg_17_1]

		self._skeleton_animation_2:Initialize(true)
	end

	function arg_1_0:set_sortingOrder(arg_18_1)
		self._panel.transform:GetComponent(typeof("UnityEngine.Canvas")).sortingOrder = arg_18_1
	end

	function arg_1_0:get_lock_type()
		return self._is_lock_by_msgbox
	end

	function arg_1_0.reset_lock_type(arg_20_0)
		arg_20_0._is_lock_by_msgbox = false
	end

	function arg_1_0:__init_panel(arg_21_1)
		self:__check_layer()
		self:__set_now_panel_data()

		self._data_list = arg_21_1

		if self._is_first_init then
			self._data_length = #arg_21_1
			self._is_click_num = 0
			self._is_first_init = false
		end

		self:__show_next()
	end

	function arg_1_0:__init_panel_sopit(arg_22_1)
		self:__check_layer()
		self:__set_now_panel_data()

		self._data_list = arg_22_1

		self:__show_next_sopit()
	end

	function arg_1_0:__check_layer()
		local var_23_0 = var_0_2:getInstance("mist_awardbox")
		local var_23_1 = var_0_2:getInstance("acquire_image")
		local var_23_2 = var_0_2:getInstance("ship_detail")

		if var_23_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_23_0._panel.transform:GetComponent("Canvas").sortingOrder + 2
		end

		if var_23_1 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_23_1._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		local var_23_3

		if var_23_2 then
			var_23_2:setVisible(false)

			var_23_3 = var_0_2:getInstance("ship_detail")
		end

		if var_0_2:getInstance("pre_formation") and var_23_3 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_23_3._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end
	end

	function arg_1_0:__show_next_sopit()
		if not self._data_list or self._data_list == "" then
			self._is_new_ship = false

			return
		end

		local var_24_0 = {}

		if self._is_click_num == 0 and (var_0_2:getInstance("task") or var_0_2:getInstance("score_push_map")) and #self._data_list > 1 then
			self._data_length = #self._data_list
			var_24_0 = self._data_list[1]
			self._is_click_num = self._is_click_num + 1

			var_0_9(self._data_list, 1)
		else
			var_24_0 = self._data_list
		end

		if var_24_0.type == var_0_6.reward_type.ship then
			self._control.new_equip.gameObject:SetActive(false)
			self._control.new_ship.gameObject:SetActive(true)

			local var_24_1 = var_0_3:find_character_by_id(var_24_0.id)
			local var_24_2 = var_0_7.find_object_by_cid(var_24_1.cid)

			self._data = var_24_1
			self._ship_data = var_24_2
			self._is_new_ship = var_24_0.is_new

			self:show_btns(true)
			self:set_ship_info(var_24_2)
			self._control.new_anim:SetActive(var_24_0.is_new)

			if var_24_0.is_new then
				self._new_ship_id = var_24_0.id

				self._skeleton_animation_3.AnimationState:SetAnimation(0, var_0_26.ship, false)
			end
		elseif var_24_0.type == var_0_6.reward_type.equipment then
			self._control.new_ship.gameObject:SetActive(false)
			self._control.new_equip.gameObject:SetActive(true)
			self:set_equip_info((var_0_8.find_object_by_cid(var_24_0.id)))

			self._is_new_equipment = var_24_0.is_new
			self._equipment_id = var_24_0.id

			if var_24_0.is_new then
				self._new_equipment_id = var_24_0.id

				var_0_11:show(var_0_1:getNowLang("equipment_lock_desc"))
			end

			self._control.new_anim:SetActive(var_24_0.is_new)

			if var_24_0.is_new then
				self._skeleton_animation_3.AnimationState:SetAnimation(0, var_0_26.weapon, false)
			end
		end
	end

	function arg_1_0:__show_next()
		local var_25_0 = var_0_2:getInstance("home")

		if self._enter_type ~= var_0_6.enter_get_ship_type.spoils_shop and self._enter_type ~= var_0_6.enter_get_ship_type.bootyshop_clothes and self._enter_type ~= var_0_6.enter_get_ship_type.mall_shop and self._enter_type ~= var_0_6.enter_get_ship_type.evo_get_skin and self._enter_type ~= var_0_6.enter_get_ship_type.ship_map and self._enter_type ~= var_0_6.enter_get_ship_type.remake and self._enter_type ~= var_0_6.enter_get_ship_type.mail_skin_award and self._enter_type ~= var_0_6.enter_get_ship_type.sign_and_task and self._enter_type ~= var_0_6.enter_get_ship_type.ship_map and self._enter_type ~= var_0_6.enter_get_ship_type.combats_shop and self._enter_type ~= var_0_6.enter_get_ship_type.combats_shop_clothes and self._enter_type ~= var_0_6.enter_get_ship_type.seven_big_map then
			if self._enter_type == var_0_6.enter_get_ship_type.score_event then
				local var_25_1 = var_0_3:get_to_six_year()

				if var_0_3:get_goto_abyss() then
					self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.abyss_activity_bgm))
				elseif var_0_3:get_goto_fear_sea() then
					local var_25_2 = var_0_2:getInstance("fearlessness_sea")

					if var_25_2 then
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_25_2._active_config.bgm))
					else
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.sixth_activity_bgm))
					end
				elseif var_0_3:get_to_normal_fight() and not var_25_1 then
					local var_25_3 = var_0_2:getInstance("gotofight")

					if var_25_3 then
						var_25_3:_play_fight_bgm(var_25_3._now_lock_id)
					elseif var_25_0 then
						var_25_0:into_home_bgm()
					else
						var_25_0 = var_0_2:createInstance("home")

						var_25_0:into_home_bgm()
					end
				elseif var_25_1 then
					if var_0_3:get_now_six_bgm() then
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_3:get_now_six_bgm()))
					else
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.sixth_activity_bgm))
					end
				elseif var_0_3:get_to_cap() then
					self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.living_bgm))
				elseif var_0_3:get_to_school() then
					self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, "school"))
				elseif var_0_3:get_to_cook() then
					self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.restaurant))
				elseif var_0_3:get_to_shower() then
					local var_25_4 = var_0_2:getInstance("bathroom")

					if var_25_4 then
						var_25_4:_play_now_bgm()
					else
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.living_bgm))
					end
				elseif var_0_3:get_to_living() then
					local var_25_5 = var_0_2:getInstance("dormitory")

					if var_25_5 then
						if var_25_5._get_furniture_data then
							if next(var_25_5._get_furniture_data) then
								for iter_25_0, iter_25_1 in pairs(var_25_5._get_furniture_data) do
									var_25_5:_now_living_bgm(iter_25_1.cid)
								end
							else
								self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.living_bgm))
							end
						else
							self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.living_bgm))
						end
					else
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.living_bgm))
					end
				elseif var_0_3:get_to_mix() then
					local var_25_6 = var_0_2:getInstance("mix_main_map")
					local var_25_7 = var_0_2:getInstance("seven_sea_map")

					if var_25_6 then
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_25_6._pve_active_cfg.bgm))
					end

					if var_25_7 then
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_25_7.sea_map_data.music_battle))
					end
				elseif var_0_3:get_to_score() then
					local var_25_8 = var_0_2:getInstance("score_push_map")

					if var_25_8 then
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_25_8._active_config.bgm))
					else
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_2:createInstance("score_push_map")._active_config.bgm))
					end
				elseif var_0_3:get_to_strike() then
					local var_25_9 = var_0_2:getInstance("strike_main")

					if var_25_9 then
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_25_9._active_config.bgm))
					else
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_2:createInstance("score_push_map")._active_config.bgm))
					end
				elseif var_25_0 then
					var_25_0:into_home_bgm()
				else
					var_25_0 = var_0_2:createInstance("home")

					var_25_0:into_home_bgm()
				end
			elseif self._enter_type == var_0_6.enter_get_ship_type.abyss_combine_panel then
				self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.abyss_activity_bgm))
			elseif self._enter_type == var_0_6.enter_get_ship_type.dock_building or self._enter_type == var_0_6.enter_get_ship_type.other then
				self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.get_item), false)

				if var_0_3:get_to_score() then
					local var_25_10 = var_0_2:getInstance("score_push_map")

					if var_25_10 then
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_25_10._active_config.bgm))
					else
						self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_22.find_object_by_id(49).bgm))
					end
				end
			elseif self._enter_type ~= var_0_6.enter_get_ship_type.salvage_award and var_25_0 then
				var_25_0:into_home_bgm()
			end
		end

		self:reset_lock_type()

		self._is_reset_toggle = true
		self._is_reset_toggle = false
		self._is_new_ship = false

		if not self._data_list or #self._data_list == 0 then
			self._is_new_ship = false

			if self._now_battle_type and self._now_battle_type ~= gameenum.battle_type.fight_type.abyss then
				if not var_0_2:getInstance("home") then
					self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.get_item), false)
				end

				self:_back_fight()
			end

			var_0_2:destroyInstance("new_equip_only")

			local var_25_12 = var_0_2:getInstance("dock_bet")

			if var_25_12 then
				var_25_12:updata_res_data()
			end

			local var_25_13 = var_0_2:getInstance("ship_detail")

			if var_25_13 then
				var_25_13:setVisible(true)
			end

			local var_25_14 = var_0_2:getInstance("dock")

			if var_25_14 then
				var_25_14:_now__play_bgm()
			elseif var_0_3:get_to_six_year() then
				if var_0_3:get_now_six_bgm() then
					self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_3:get_now_six_bgm()))
				else
					self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.sixth_activity_bgm))
				end
			else
				var_0_14:resumeAll()
			end

			if var_0_3:get_new_battle_type() == gameenum.battle_type.fight_type.push then
				local var_25_15 = var_0_22.find_object_by_id((var_0_3:get_fearlessness_id()))
				local var_25_16 = var_0_3:get_battle_info()

				if var_25_16.point == var_0_23.find_object_by_id(var_25_16.id).boss_node_id[1] and var_25_15 and var_25_15.bgm then
					self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_25_15.bgm))
				end
			end

			return
		end

		local var_25_17 = self._data_list[1]

		if self._data_list[1].type == var_0_6.reward_type.ship then
			self._control.new_equip.gameObject:SetActive(false)
			self._control.new_ship.gameObject:SetActive(true)

			local var_25_18 = var_0_3:find_character_by_id(var_25_17.id)
			local var_25_19 = var_0_7.find_object_by_cid(var_25_18.cid)

			self._data = var_25_18
			self._ship_data = var_25_19
			self._is_new_ship = var_25_17.is_new

			self:show_btns(true)
			self:set_ship_info(var_25_19)
			self._control.new_anim:SetActive(var_25_17.is_new)

			if var_25_17.is_new then
				self._new_ship_id = var_25_17.id

				self._skeleton_animation_3.AnimationState:SetAnimation(0, var_0_26.ship, false)
			end
		elseif var_25_17.type == var_0_6.reward_type.equipment then
			self._control.new_ship.gameObject:SetActive(false)
			self._control.new_equip.gameObject:SetActive(true)
			self:set_equip_info((var_0_8.find_object_by_cid(var_25_17.id)))

			self._is_new_equipment = var_25_17.is_new
			self._equipment_id = var_25_17.id
			self._is_first_equip_toggle = true

			if self._last_same_equipment_lock.id and self._equipment_id == self._last_same_equipment_lock.id then
				self._control.new_equip.lock_toggle.lock_state:SetActive(self._last_same_equipment_lock.lock)
				self._control.new_equip.lock_toggle.unlocklock_state:SetActive(not self._last_same_equipment_lock.lock)
			else
				self._is_equipment_lock = var_0_3:get_equipment_lock_state(self._equipment_id).lock

				self._control.new_equip.lock_toggle.lock_state:SetActive(self._is_equipment_lock)
				self._control.new_equip.lock_toggle.unlocklock_state:SetActive(not self._is_equipment_lock)
			end

			if self._is_new_equipment and not var_0_2:getInstance("dock") then
				self._new_equipment_id = var_25_17.id

				var_0_11:show(var_0_1:getNowLang("equipment_lock_desc"))
			end

			self._control.new_anim:SetActive(var_25_17.is_new)

			if var_25_17.is_new then
				self._skeleton_animation_3.AnimationState:SetAnimation(0, var_0_26.weapon, false)
			end

			self:show_btns(false)
		end

		var_0_5(self._used_data, self._data_list[1])
		var_0_9(self._data_list, 1)

		self._is_click_num = self._is_click_num + 1

		if self._is_click_num <= self._data_length and self._is_first_equal and self._is_click_num ~= 1 then
			self:playCV(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.get_ship_equip), false, "cv")
			self:playCV(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.get_item), false, "cv")
		end
	end

	function arg_1_0:__init_panel_for_type(arg_26_1)
		self:__set_now_panel_data()
		self:set_ship_info(arg_26_1)
	end

	function arg_1_0:__show_select_skill()
		if #self._data.skills >= 2 then
			self:__set_contents_in_skill_select(false)
		else
			self:__check_new_ship()
		end
	end

	function arg_1_0.__check_abyss_new_ship(arg_28_0)
		local var_28_0 = var_0_2:getInstance("abyss_dock_team")

		var_28_0:setVisible(true)
		var_28_0:init_remake_language()
	end

	function arg_1_0:__check_new_ship()
		local var_29_0 = var_0_2:getInstance("remake")

		local function var_29_1()
			self:__evo_get_skin()

			if var_29_0 then
				var_29_0:setVisible(true)
				var_29_0:update_data()
			end
		end

		if self._is_new_ship and not self._data.lock then
			var_0_2:createInstance("msgbox"):show(var_0_1:getNowLang("shiplockbody"), function()
				var_29_1()

				if var_29_0 then
					var_29_0:fake_lock()
				end

				self:__set_guide_data()
				var_0_3:req_ShipLock({
					id = self._new_ship_id
				})
			end, function()
				self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.back))
				var_29_1()
				self:__set_guide_data()
			end, var_0_1:getNowLang("shiplocktitle"), var_0_6.msg_type.tip)
		else
			var_29_1()
		end
	end

	function arg_1_0:__set_contents_in_skill_select(arg_33_1)
		self._control.back_btn:SetActive(false)
		self._control.new_ship.ship_detail_btn:SetActive(arg_33_1)
		self._control.new_ship.ship_info:SetActive(arg_33_1)
		self._control.new_ship.ship_dialog:SetActive(arg_33_1)
		self._control.new_ship.lock_toggle:SetActive(arg_33_1)
		self._control.new_ship.switch_layer:SetActive(not arg_33_1)
		self._control.dialog_bg:SetActive(arg_33_1)
		self._control.star_anim:SetActive(arg_33_1)

		if arg_33_1 then
			self._control.new_ship.ship_role.rectTransform.anchoredPosition = Vector2.New(0, self._control.new_ship.ship_role.rectTransform.anchoredPosition.y)
			self._control.role_bg_anim.transform.localPosition = Vector3.zero
		else
			local var_33_0 = self:autoKillDOTween(var_0_10.Sequence())

			var_33_0:Append(self._control.role_bg_anim.transform:DOBlendableLocalMoveBy(Vector3.New(-250, 0), 0.3))
			var_33_0:Append(self._control.new_ship.ship_role.transform:DOBlendableLocalMoveBy(Vector3.New(-250, 0), 0.3))
			var_33_0:Play()
			self._control.new_anim:SetActive(false)
			self:__init_select()
			self:__show_skills()
		end
	end

	function arg_1_0:__init_select()
		if self._control.new_ship.switch_layer.toggle_group.tog_rs_2.toggle.isOn then
			self._control.new_ship.switch_layer.toggle_group.tog_rs_2.toggle.isOn = false
		end

		self._control.new_ship.switch_layer.toggle_group.tog_rs_1.toggle.isOn = true
		self._select_skill = self._data.skills[1]
	end

	function arg_1_0:__show_skills()
		local var_35_0 = self._control.new_ship.switch_layer

		self._control.new_ship.switch_layer.switch_title.text.text = var_0_1:getNowLang("switchskilltitle")
		var_35_0.switch_tip.text.text = var_0_1:getNowLang("switchskilltip")
		var_35_0.confirm_btn.title.text.text = var_0_1:getNowLang("confirm")

		local var_35_1 = var_0_12.find_object_by_skill_type_skill_level(self._data.skills[1], self._data.skill_level)
		local var_35_2 = var_0_12.find_object_by_skill_type_skill_level(self._data.skills[2], self._data.skill_level)
		local var_35_3 = var_0_4(var_0_6.skill_icon, self._data.skills[1])
		local var_35_4 = self:findPath(var_35_3) and self:loadSprite(var_35_3) or self:loadSprite(var_0_4(var_0_6.skill_default))
		local var_35_5 = var_0_4(var_0_6.skill_icon, self._data.skills[2])
		local var_35_6 = self:findPath(var_35_5) and self:loadSprite(var_35_5) or self:loadSprite(var_0_4(var_0_6.skill_default))

		var_35_0.rs_1.skill_name.text.text = var_35_1.title
		var_35_0.rs_1.skill_phase.text.text = var_0_1:getNowLang("shipinfoskillphase")
		var_35_0.rs_1.buff.text.text = var_35_1.phase_desc
		var_35_0.rs_1.scrollview.content.info_txt.text.text = var_0_1:getNowLang("shipinfoskilldesc", true) .. var_0_13.convert_rich_text(var_35_1.desc)
		var_35_0.rs_1.skill_icon.image.sprite = var_35_4
		var_35_0.rs_2.skill_name.text.text = var_35_2.title
		var_35_0.rs_2.skill_phase.text.text = var_0_1:getNowLang("shipinfoskillphase")
		var_35_0.rs_2.buff.text.text = var_35_2.phase_desc
		var_35_0.rs_2.scrollview.content.info_txt.text.text = var_0_1:getNowLang("shipinfoskilldesc", true) .. var_0_13.convert_rich_text(var_35_2.desc)
		var_35_0.rs_2.skill_icon.image.sprite = var_35_6
	end

	function arg_1_0:__set_now_panel_data()
		local var_36_0 = self._enter_type ~= var_0_6.enter_get_ship_type.mall_shop and self._enter_type ~= var_0_6.enter_get_ship_type.evo_get_skin and self._enter_type ~= var_0_6.enter_get_ship_type.ship_map and self._enter_type ~= var_0_6.enter_get_ship_type.single_ship and self._enter_type ~= var_0_6.enter_get_ship_type.mail_skin_award and self._enter_type ~= var_0_6.enter_get_ship_type.bootyshop_clothes

		self._control.new_ship.ship_info.gameObject:SetActive(self._enter_type ~= var_0_6.enter_get_ship_type.mall_shop and self._enter_type ~= var_0_6.enter_get_ship_type.evo_get_skin and self._enter_type ~= var_0_6.enter_get_ship_type.ship_map and self._enter_type ~= var_0_6.enter_get_ship_type.single_ship and self._enter_type ~= var_0_6.enter_get_ship_type.mail_skin_award and self._enter_type ~= var_0_6.enter_get_ship_type.bootyshop_clothes)
		self._control.new_ship.ship_dialog.ship_ordinary_dialog.gameObject:SetActive(var_36_0)
		self._control.star_anim.gameObject:SetActive(var_36_0)
		self._control.new_anim.gameObject:SetActive(var_36_0)
		self._control.new_ship.ship_dialog.ship_skin_dialog.gameObject:SetActive(not var_36_0)
		self:show_btns(self._enter_type == var_0_6.enter_get_ship_type.other or self._enter_type == var_0_6.enter_get_ship_type.remake or self._enter_type == var_0_6.enter_get_ship_type.abyss_get_awards)

		if self._enter_type ~= var_0_6.enter_get_ship_type.other then
			self._control.new_equip:SetActive(false)
			self._control.new_ship:SetActive(true)
			self._control.new_ship.new_icon:SetActive(false)
		end

		if self._enter_type ~= var_0_6.enter_get_ship_type.abyss_evo_panel or self._enter_type ~= var_0_6.enter_get_ship_type.abyss_combine_panel then
			self._control.new_equip:SetActive(false)
			self._control.new_ship:SetActive(true)
			self._control.new_ship.new_icon:SetActive(false)
			self:show_abyss_btns(true)
		end
	end

	function arg_1_0:__evo_get_skin()
		if self._get_skin and self._get_skin > 0 then
			var_0_2:createInstance("reward_tip"):show(self._get_skin, var_0_6.enter_get_ship_type.evo_get_skin)
		end
	end

	function arg_1_0:_play_se(arg_38_1)
		self:playSE(arg_38_1, false)
	end

	function arg_1_0:leave_ship(arg_39_1)
		if self._enter_type == var_0_6.enter_get_ship_type.spoils_shop or self._enter_type == var_0_6.enter_get_ship_type.combats_shop or self._enter_type == var_0_6.enter_get_ship_type.up_award or self._enter_type == var_0_6.enter_get_ship_type.mail_skin_award or self._enter_type == var_0_6.enter_get_ship_type.mall_shop or self._enter_type == var_0_6.enter_get_ship_type.ship_map or self._enter_type == var_0_6.enter_get_ship_type.sign_and_task then
			local var_39_0 = var_0_2:getInstance("home")

			if var_39_0 then
				var_39_0:into_home_bgm()
			end

			for iter_39_0 = 1, var_0_14._cv_length do
				var_0_14:destroyCV()
			end

			var_0_14:resumeAll()
		elseif self._enter_type == var_0_6.enter_get_ship_type.salvage_award and self._now_battle_type ~= gameenum.battle_type.fight_type.abyss then
			self:_back_fight()
		elseif self._enter_type == var_0_6.enter_get_ship_type.abyss_evo_panel then
			self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.abyss_activity_bgm))
		else
			for iter_39_1 = 1, var_0_14._cv_length do
				var_0_14:destroyCV()
			end

			var_0_14:resumeAll()

			if not self._data_list or not next(self._data_list) then
				var_0_14:destroyCV()

				if self._enter_type == var_0_6.enter_get_ship_type.dock_building then
					local var_39_1 = var_0_2:getInstance("dock")

					if var_39_1 then
						var_39_1:_now__play_bgm()
					end
				else
					var_0_14:resumeAll()
				end
			end
		end

		if self._back_func then
			self._back_func()

			self._back_func = nil
		end

		if arg_39_1 then
			arg_39_1()
		end

		self:setVisible(false)
	end

	function arg_1_0:_bgm_play()
		local var_40_0 = var_0_3:get_use_info_data().music

		if var_40_0 == 0 then
			local var_40_1 = lx.ServerTime:getUtcTime()
			local var_40_2 = tonumber(os.date("%H", var_40_1))
			local var_40_3

			if var_40_2 > 6 and var_40_2 <= 18 then
				local var_40_4 = var_0_19.find_object_by_cid(175)

				var_40_3 = self:__judge_now_time(var_40_4.start_utc_time, var_40_4.end_utc_time, var_40_1) and var_40_4.res2 or var_40_4.res
			else
				local var_40_5 = var_0_19.find_object_by_cid(275)

				var_40_3 = self:__judge_now_time(var_40_5.start_utc_time, var_40_5.end_utc_time, var_40_1) and var_40_5.res2 or var_40_5.res
			end

			self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_40_3), true)
		else
			self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_19.find_object_by_cid(var_40_0).res), true)
		end
	end

	function arg_1_0.__judge_now_time(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
		if not arg_41_1 or not arg_41_2 then
			return false
		end

		return arg_41_1 <= arg_41_3 and arg_41_3 <= arg_41_2
	end

	function arg_1_0:_play_audio(arg_42_1, arg_42_2)
		self:playBackgroundMusic(arg_42_1, arg_42_2)
	end

	function arg_1_0:_play_into_se(arg_43_1)
		self:playSE(arg_43_1, false)
	end

	function arg_1_0._back_fight(arg_44_0)
		local var_44_0 = var_0_2:getInstance("combat_result")

		if var_44_0 then
			var_44_0:__other_call()
		end
	end

	function arg_1_0.__onReset(arg_45_0)
		arg_45_0._is_new_ship = false
		arg_45_0._is_first_init = true
		arg_45_0._data_length = 1
		arg_45_0._data_list = {}
		arg_45_0._is_click_num = 0
		arg_45_0._is_first_equal = true
		arg_45_0._data = {}
		arg_45_0._ship_data = {}
		arg_45_0._used_data = {}
		arg_45_0._new_ship_id = nil
		arg_45_0._new_equipment_id = nil
		arg_45_0._equipment_id = nil
		arg_45_0._is_equipment_lock = false
		arg_45_0._get_skin = nil
		arg_45_0._skeleton_animation_1 = nil
		arg_45_0._skeleton_animation_2 = nil
		arg_45_0._skeleton_animation_3 = nil
		arg_45_0._enter_type = nil
		arg_45_0._select_skill = nil
		arg_45_0._no_req = false
		arg_45_0._one_lock = false
		arg_45_0._back_func = nil
		arg_45_0._is_lock_by_msgbox = false
		arg_45_0._is_sixth = false
		arg_45_0._is_reset_toggle = false
		arg_45_0._data_list = nil
		arg_45_0._skin_data = nil
		arg_45_0._is_first_equip_toggle = true
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_46_0)
	local var_46_0 = var_0_2:class("new_equip_only")

	var_46_0._data = {}
	var_46_0._data_list = {}
	var_46_0._ship_data = {}
	var_46_0._used_data = {}
	var_46_0._data_length = 1
	var_46_0._is_new_ship = false
	var_46_0._new_ship_id = nil
	var_46_0._new_equipment_id = nil
	var_46_0._equipment_id = nil
	var_46_0._is_equipment_lock = false
	var_46_0._get_skin = nil
	var_46_0._skeleton_animation_1 = nil
	var_46_0._skeleton_animation_2 = nil
	var_46_0._skeleton_animation_3 = nil
	var_46_0._enter_type = nil
	var_46_0._select_skill = nil
	var_46_0._no_req = false
	var_46_0._one_lock = false
	var_46_0._back_func = nil
	var_46_0._is_lock_by_msgbox = false
	var_46_0._is_click_num = 0
	var_46_0._is_first_equal = true
	var_46_0._is_sixth = false
	var_46_0._is_first_init = true
	var_46_0._is_reset_toggle = false
	var_46_0._now_battle_type = nil
	var_46_0._data_list = nil
	var_46_0._skin_data = nil
	var_46_0._is_first_equip_toggle = true
	var_46_0._last_same_equipment_lock = {
		id = 0,
		lock = false
	}

	return var_46_0
end

return var_0_0
