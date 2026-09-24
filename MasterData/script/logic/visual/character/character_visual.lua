local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = UnityEngine
local var_0_3 = Vector3
local var_0_4 = gameenum.common_type
local var_0_5 = DG.Tweening.DOTween
local var_0_6 = gameconfig.ship_config
local var_0_8 = gameconfig.skin_config
local var_0_9 = gameconfig.shop_config
local var_0_13 = gamecore.BattleManager
local var_0_14 = table.insert

lx.define_class("character_visual", function(arg_1_0)
	function arg_1_0:init()
		if not self._logic:get_is_alive() then
			return
		end

		local var_2_0 = var_0_2.GameObject.Find("sea/unit/player")
		local var_2_1 = var_0_2.GameObject.Find("sea/unit/enemy")
		local var_2_2 = var_0_2.GameObject.Find("undersea/unit/player")
		local var_2_3 = var_0_2.GameObject.Find("undersea/unit/enemy")
		local var_2_4 = self._side == var_0_4.character_type.player and 0 or 180

		if self._side == var_0_4.character_type.player then
			self:__load_player(var_2_0, var_2_2, var_2_4)
		else
			self:__load_enemy(var_2_1, var_2_3, var_2_4)
		end

		self._flag = self._spine_root.transform:Find("flag")

		self:__init_animation()
		self:__init_hp_bar()
		self:__init_damage_text()
		self:__init_dialogue()
		self:set_flag_active(self._index == 1)
	end

	function arg_1_0:get_skin_id(arg_3_1)
		if self._skin_id == 0 then
			return arg_3_1
		end

		local var_3_0 = var_0_8.find_object_by_cid(self._skin_id)

		if not var_3_0 then
			return arg_3_1
		end

		return var_3_0.skin_id
	end

	function arg_1_0:get_position()
		return self._spine.transform.position
	end

	function arg_1_0:show_damage(arg_5_1, arg_5_2)
		if not arg_5_1.damage_info then
			return
		end

		local var_5_0 = var_0_1.clone_table(arg_5_1)
		local var_5_1 = self._battle_processor:find_visual(var_5_0.target_id)
		local var_5_2 = var_0_4.character_anim_type.damage

		if var_5_0.damage_info.is_dodging and not var_5_1._logic.copy_skill and var_5_1._spine.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).Skeleton.Data:FindAnimation(var_0_4.character_anim_type.dodging.name) then
			var_5_2 = var_0_4.character_anim_type.dodging

			var_5_1:play_animation(var_0_4.character_anim_type.dodging)

			var_5_0.damage_info.is_miss = true
		end

		if not var_5_1 then
			return
		end

		if not var_5_0.damage_info.is_miss then
			self._battle_processor:delay(100, function()
				var_5_1:play_animation(var_5_2)
			end)

			local var_5_3 = self._logic:get_ship_ton()

			if var_5_3 == 3 then
				self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.destroyer_l))
			elseif var_5_3 == 2 then
				self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.destroyer_m))
			else
				self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.destroyer_s))
			end
		end

		local function var_5_4()
			if var_5_0.damage_delay then
				self._battle_processor:delay(0, function()
					var_5_1:add_damage_text(var_5_0, var_5_0.target_now_hp, arg_5_2, var_5_0.damage_count)
				end)
			else
				var_5_1:add_damage_text(var_5_0, var_5_0.target_now_hp, arg_5_2, var_5_0.damage_count)
			end
		end

		if var_5_0.damage_info.is_recover_life and var_5_0.damage_info.is_recover_life ~= true then
			var_5_4()
			self._battle_processor:delay(800, function()
				self._battle_processor:pause_frame()
				var_5_1:show_damage_recovery(function()
					self._battle_processor:resume_frame()
					var_5_1:update_hp(var_5_0.damage_info.is_recover_life)
					var_5_1:update_submarine_hp(var_5_0.damage_info.is_recover_life)
				end, var_5_0.damage_info.is_recover_life)
			end)

			return
		end

		if not var_5_0.damage_info.is_miss then
			var_5_1:set_event_listener("damage_point", function()
				var_5_4()
			end)
		else
			var_5_4()
		end
	end

	function arg_1_0:rise_to_sea(arg_12_1)
		if not self._ss_fake then
			return
		end

		self._ss_mask.gameObject:SetActive(true)
		self._ss_fake:SetActive(true)

		self.is_rise = true

		local var_12_0 = self:autoKillDOTween(var_0_5.Sequence())

		var_12_0:AppendCallback(function()
			self._ss_fake.transform:DOLocalMoveY(0, 1):OnComplete(function()
				if arg_12_1 then
					arg_12_1()

					arg_12_1 = nil

					var_12_0:Kill()

					var_12_0 = nil
				end
			end)
		end)
		var_12_0:Play()
	end

	function arg_1_0:sink_to_under_sea(arg_15_1)
		if not self._ss_fake then
			return
		end

		self:create_sank_effect(self._ss_fake.transform.parent)

		self.is_rise = false

		local var_15_0 = self:autoKillDOTween(var_0_5.Sequence())

		var_15_0:AppendCallback(function()
			self._ss_fake.transform:DOLocalMoveY(-3.5, 1):OnComplete(function()
				if arg_15_1 then
					self._ss_fake:SetActive(false)
					self._ss_mask.gameObject:SetActive(false)
					arg_15_1()

					arg_15_1 = nil

					var_15_0:Kill()

					var_15_0 = nil
				end
			end)
		end)
		var_15_0:Play()
	end

	function arg_1_0:death_to_undersea(arg_18_1, arg_18_2)
		if arg_18_2 == "mix_attack_first" or arg_18_2 == "double_attack_first" then
			return
		end

		local var_18_0 = 0

		if arg_18_2 == "aircraft_atk" then
			var_18_0 = 0.5
		end

		if self._logic:is_submarine() then
			self._battle_processor:delay(100, function()
				self:set_submarine_shadow_active(false)
				self:set_submarine_flag_active(false)
			end)
			self._battle_processor:delay(100, function()
				self:set_hp_bar_active(false)
				self:set_submarine_hp_bar_active(false)
			end)
		else
			self._battle_processor:delay(100, function()
				self:create_sank_effect(self._spine_root.transform)
				self:set_mask_active(true)
			end)
		end

		self:set_shadow_active(false)
		self:set_flag_active(false)
		self:set_submarine_flagship(false)
		self:set_above_revamp_active(false)
		self:set_below_revamp_active(false)
		self:set_surface_revamp_active(false)

		local var_18_1 = self:autoKillDOTween(var_0_5.Sequence())

		var_18_1:AppendInterval(var_18_0)

		if self.is_death == true then
			var_18_1:Kill()

			return
		end

		var_18_1:AppendCallback(function()
			if self._spine:Equals(nil) then
				return
			end

			self.is_death = true

			;(self._logic:is_submarine() and self._spine.transform:DOLocalMoveY(-3.5, 0.7) or self._spine.transform:DOLocalMoveY(-3.5, 1.5)):OnComplete(function()
				self._spine_root:SetActive(false)
				self:set_mask_active(false)

				if arg_18_1 then
					arg_18_1()

					arg_18_1 = nil
				end

				var_18_1:Kill()

				var_18_1 = nil
			end)
		end)
		var_18_1:Play()
	end

	function arg_1_0:create_sank_effect(arg_24_1)
		local var_24_0 = self:create_effect({
			path = var_0_4.effect_spine.path,
			motion = var_0_4.effect_spine.sank
		})

		var_24_0.transform:SetParent(arg_24_1.transform, false)

		var_24_0.transform.localPosition = var_0_3.New(0, 0, 0)
		var_24_0.transform:GetComponent(typeof(var_0_2.MeshRenderer)).sortingOrder = 0
		var_24_0.transform.localScale = var_0_3.New(self._side, 1, 1)
		var_24_0.transform.localPosition = var_0_3.New(0, 0, -1)

		var_24_0.transform:SetParent(self._spine_root.transform, false)
	end

	function arg_1_0:recovery(arg_25_1)
		local var_25_0 = var_0_9.find_object_by_id(var_0_4.shop_damage_control_cid).content[1].id

		self._spine.transform.localPosition = var_0_3.zero

		self:play_animation(var_0_4.character_anim_type.normal)
		self:set_hp_bar_active(true)
		self:set_shadow_active(true)
		self:set_submarine_shadow_active(true)
		self:set_above_revamp_active(true)
		self:set_below_revamp_active(true)
		self:set_surface_revamp_active(true)
		self:set_flag_active(self._index == 1)
		self:set_submarine_flagship(self._index == 1)
		self:set_ignore_break_state(false)
		self._spine_root:SetActive(true)

		if self._logic:is_submarine() then
			self:set_submarine_flag_active(true)
			self:set_submarine_hp_bar_active(true)
		end
	end

	function arg_1_0:set_flag_active(arg_26_1)
		if self._index ~= 1 then
			return
		end

		self._flag.gameObject:SetActive(arg_26_1)
	end

	function arg_1_0:create_immune_effect(arg_27_1)
		local var_27_0 = self:create_effect({
			path = var_0_4.effect_spine.path,
			motion = var_0_4.effect_spine.immune
		})

		var_27_0.transform:SetParent(arg_27_1.transform, false)

		var_27_0.transform.localRotation = var_0_3.New(0, self._side == 180, 0)
		var_27_0.transform.localPosition = var_0_3.New(1, 0, 0)
	end

	function arg_1_0.pause(arg_28_0)
		return
	end

	function arg_1_0.resume(arg_29_0)
		return
	end

	function arg_1_0:__load_player(arg_30_1, arg_30_2, arg_30_3)
		local var_30_0 = var_0_6.find_object_by_cid((self._logic:get_cid()))

		self._pic_id = self:get_skin_id(var_30_0.pic_id)

		if self._logic:is_submarine() then
			self:__create_undersea_ship(var_30_0, arg_30_1, arg_30_2, var_0_4.submarine_position.player[self._index], arg_30_3)
			self:create_submarine_flag()
		else
			self:__create_sea_ship(var_30_0, arg_30_1, var_0_4.ship_position.player[self._index], arg_30_3)
		end
	end

	function arg_1_0:__load_enemy(arg_31_1, arg_31_2, arg_31_3)
		local var_31_0 = self._logic:get_ship_cfg()
		local var_31_1 = self._logic:get_pos()

		self._pic_id = self:get_skin_id(var_31_0.pic_id)

		if self._logic:is_submarine() then
			self:__create_undersea_ship(var_31_0, arg_31_1, arg_31_2, var_0_4.submarine_position.enemy[var_31_1], arg_31_3)
			self:create_submarine_flag()
		else
			self:__create_sea_ship(var_31_0, arg_31_1, var_0_4.ship_position.enemy[var_31_1], arg_31_3)
		end
	end

	function arg_1_0:__create_undersea_ship(arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
		self._spine_root = var_0_13:createBattleGameObject("data/battle/prefab/ship_root/ship_root.prefab")
		self._spine_root.transform.localPosition = var_0_3.New(arg_32_4.x, arg_32_4.y, arg_32_4.z)

		self._spine_root.transform:SetParent(arg_32_3.transform, false)

		self._spine, self._spine_skele = self:create_spine(self._pic_id, self._logic:get_attribute().now_hp:get_final_value() / self._logic:get_attribute().hp:get_final_value() < gameenum.battle_type.hp_ratio_type.medhp)
		self._spine.transform.localScale = var_0_3.New(1, 1, 1)
		self._spine.transform.localRotation = var_0_3.New(0, arg_32_5, 0)

		self._spine.transform:SetParent(self._spine_root.transform, false)

		if var_0_4:get_is_new_battle() then
			self:__ship_below_revamp()
		end

		self:__slip_action(self._spine_root, 0.5)
	end

	function arg_1_0:__create_sea_ship(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
		self._spine_root = var_0_13:createBattleGameObject("data/battle/prefab/ship_root/ship_root.prefab")

		local var_33_0 = self._battle_processor:get_hook((var_0_1.clone_table(arg_33_3)))

		self._spine_root.transform.localPosition = var_0_3.New(var_33_0.x, var_33_0.y, var_33_0.z)

		self._spine_root.transform:SetParent(arg_33_2.transform, false)

		self._spine, self._spine_skele = self:create_spine(self._pic_id, self._logic:get_attribute().now_hp:get_final_value() / self._logic:get_attribute().hp:get_final_value() < gameenum.battle_type.hp_ratio_type.medhp)
		self._spine.transform.localScale = var_0_3.New(1, 1, 1)

		if arg_33_1.enemyScale and arg_33_1.enemyScale ~= 0 then
			self._spine.transform.localScale = var_0_3.New(arg_33_1.enemyScale, arg_33_1.enemyScale, arg_33_1.enemyScale)
		end

		self:_set_sm_ship_size()

		self._spine.transform.localRotation = var_0_3.New(0, arg_33_4, 0)

		self._spine.transform:SetParent(self._spine_root.transform, false)

		local var_33_1 = self._spine_root.transform.localPosition

		self._spine_root.transform.localPosition = self._spine_root.transform.localPosition + var_0_3.New(-7 * self._side, 0, 0)

		self._battle_processor:delay((self._battle_scene.has_submarine or nil) and 2000, function()
			self:__ship_spray()
			self:__slip_action(self._spine_root, 0.7, var_33_1)
		end)
	end

	function arg_1_0:_set_sm_ship_size()
		if self._logic:get_cid() == 10046013 then
			self._spine.transform.localScale = var_0_3.New(0.9, 0.9, 0.9)
		end

		if (self._logic:get_cid() == 10002913 or self._logic:get_cid() == 11002913) and self._logic:get_skin_id() == 1000290251 then
			self._spine.transform.localScale = var_0_3.New(0.9, 0.9, 0.9)
		end

		if self._logic:get_cid() == 24000201 then
			self._spine.transform.localScale = var_0_3.New(0.9, 0.9, 0.9)
		end

		if (self._logic:get_cid() == 10018011 or self._logic:get_cid() == 11018011) and (self._logic:get_skin_id() == 0 or not self._logic:get_skin_id()) then
			self._spine.transform.localScale = var_0_3.New(1.2, 1.2, 1.2)
		end

		if self._logic:get_cid() == 10005612 then
			if self._logic:get_skin_id() == 0 or not self._logic:get_skin_id() then
				self._spine.transform.localScale = var_0_3.New(1.2, 1.2, 1.2)
			end
		elseif self._logic:get_cid() == 11005612 and (self._logic:get_skin_id() == 0 or not self._logic:get_skin_id()) then
			self._spine.transform.localScale = var_0_3.New(0.9, 0.9, 1)
		end

		if self._logic:get_cid() == 10012612 or self._logic:get_cid() == 11012612 then
			if self._logic:get_cid() == 10012612 and self._logic:get_cid() ~= 11012612 then
				self._spine.transform.localScale = var_0_3.New(1, 1, 1)
			end

			if self._logic:get_skin_id() == 1001260151 then
				self._spine.transform.localScale = var_0_3.New(0.9, 0.9, 1)
			end
		end
	end

	function arg_1_0:change_pos()
		if var_0_4:get_is_new_battle() then
			return
		end

		local var_36_0
		local var_36_1
		local var_36_2 = self._logic:get_pos()

		if self._side == var_0_4.character_type.player then
			var_36_1 = var_0_4.ship_position.player[var_36_2]
			var_36_0 = var_0_4.ship_position.player[1]
		else
			var_36_1 = var_0_4.ship_position.enemy[var_36_2]
			var_36_0 = var_0_4.ship_position.enemy[1]
		end

		if self._logic:is_submarine() then
			if self._submarine_spine_root and not self._submarine_spine_root:Equals(nil) and self._battle_processor._hook then
				self._submarine_spine_root.transform:DOMove(var_0_3.New(var_36_1.x, var_36_0.y, var_36_1.z), 0.8 / self._battle_processor._hook)
			end
		elseif self._spine_root and not self._spine_root:Equals(nil) and self._battle_processor._hook then
			self._spine_root.transform:DOMove(var_0_3.New(var_36_1.x, var_36_0.y, var_36_1.z), 0.8 / self._battle_processor._hook)
		end
	end

	function arg_1_0:restore_pos()
		if var_0_4:get_is_new_battle() then
			return
		end

		local var_37_1
		local var_37_2 = self._logic:get_pos()

		var_37_1 = self._side == var_0_4.character_type.player and var_0_4.ship_position.player[var_37_2] or var_0_4.ship_position.enemy[var_37_2]

		self._battle_processor:delay(200, function()
			if self._logic:is_submarine() then
				if self._submarine_spine_root and not self._submarine_spine_root:Equals(nil) and self._battle_processor._hook then
					self._submarine_spine_root.transform:DOLocalMove(var_0_3.New(var_37_1.x, var_37_1.y * self._battle_processor._hook, var_37_1.z), 0.2 / self._battle_processor._hook)
				end
			elseif self._spine_root and not self._spine_root:Equals(nil) and self._battle_processor._hook then
				self._spine_root.transform:DOLocalMove(var_0_3.New(var_37_1.x, var_37_1.y * self._battle_processor._hook, var_37_1.z), 0.2 / self._battle_processor._hook)
			end
		end)
	end

	function arg_1_0:__slip_action(arg_39_1, arg_39_2, arg_39_3)
		if self._logic:get_cid() == 10053413 and self._logic:get_skin_id() == 1005340151 then
			self:play_animation(var_0_4.character_anim_type.special)
		end

		arg_39_3 = arg_39_3 or arg_39_1.transform.localPosition
		arg_39_1.transform.localPosition = self._spine_root.transform.localPosition + var_0_3.New(-7 * self._side, 0, 0)

		arg_39_1.transform:DOLocalMove(arg_39_3, arg_39_2):OnComplete(function()
			self:__init_hp_bar(true)
		end)
	end

	function arg_1_0:__ship_spray()
		if var_0_4:get_is_new_battle() then
			self:__ship_above_revamp()
		else
			local var_41_0 = {
				path = var_0_4.effect_spine.path
			}

			var_41_0.motion = var_0_4.effect_spine.spray

			local var_41_1, var_41_2 = self:create_effect(var_41_0)

			var_41_1.transform:GetComponent(typeof(var_0_2.MeshRenderer)).sortingOrder = 0
			var_41_1.transform.localScale = var_0_3.New(self._side, 1, 1)

			var_41_1.transform:SetParent(self._spine_root.transform, false)
		end
	end

	function arg_1_0:__ship_above_revamp()
		local var_42_0 = self:create_effect({
			path = var_0_4.effect_revamp_battle.path
		}, true, true)

		if not var_42_0 then
			return
		end

		var_42_0.transform.localScale = var_0_3.New(1, 1, 1)
		var_42_0.transform.localPosition = var_0_3.New(0, -0.15, -0.5)

		var_42_0.transform:SetParent(self._spine_root.transform, false)

		local var_42_1 = var_42_0.transform:Find("above")
		local var_42_2 = var_42_0.transform:Find("surface")
		local var_42_3 = var_42_0.transform:Find("below")

		if var_42_1 then
			var_42_1.gameObject:SetActive(true)
		end

		if var_42_2 then
			var_42_2.gameObject:SetActive(false)
		end

		if var_42_3 then
			var_42_3.gameObject:SetActive(false)
		end

		self._spray_revamp_obj = var_42_0

		self:set_shadow_active(false)
	end

	function arg_1_0:set_above_revamp_active(arg_43_1)
		if self._spray_revamp_obj then
			self._spray_revamp_obj.gameObject:SetActive(arg_43_1)
		end
	end

	function arg_1_0:__ship_below_revamp()
		local var_44_0 = self:create_effect({
			path = var_0_4.effect_revamp_battle.path
		}, true, true)

		if not var_44_0 then
			return
		end

		var_44_0.transform.localScale = var_0_3.New(1, 1, 1)
		var_44_0.transform.localPosition = var_0_3.New(0, -0.15, -1)

		var_44_0.transform:SetParent(self._spine_root.transform, false)

		local var_44_1 = var_44_0.transform:Find("above")
		local var_44_2 = var_44_0.transform:Find("surface")
		local var_44_3 = var_44_0.transform:Find("below")

		if var_44_1 then
			var_44_1.gameObject:SetActive(false)
		end

		if var_44_2 then
			var_44_2.gameObject:SetActive(false)
		end

		if var_44_3 then
			var_44_3.gameObject:SetActive(true)
		end

		self._below_obj = var_44_0

		self:set_shadow_active(false)
	end

	function arg_1_0:set_below_revamp_active(arg_45_1)
		if self._below_obj then
			self._below_obj.gameObject:SetActive(arg_45_1)
		end
	end

	function arg_1_0:autoKillDOTween(arg_46_1)
		var_0_14(self._do_tween_list, arg_46_1)

		return arg_46_1
	end

	function arg_1_0:__release_do_tween()
		for iter_47_0, iter_47_1 in pairs(self._do_tween_list) do
			iter_47_1:Kill()
		end

		self._do_tween_list = {}
	end

	function arg_1_0.__destroy_character(arg_48_0)
		return
	end

	function arg_1_0:__eventOnDestroy()
		self:__destroy_hp()
		self:__destroy_submarine_sea_flag()
		self:__destroy_cutin()
		self:__destroy_skill_cutin()
		self:__destroy_character()
		self:__destroy_dialogue()
		self:__release_do_tween()
	end

	gamecore.extend_method(arg_1_0)
end, "base_visual")

function var_0_0.create(arg_50_0, arg_50_1)
	local var_50_0 = var_0_1.class("character_visual", gamecore.base_visual:inherit())

	var_50_0._spine_root = nil
	var_50_0._spine = nil
	var_50_0._side = arg_50_1:get_side()
	var_50_0._index = arg_50_1:get_index()
	var_50_0._cid = arg_50_1:get_cid()
	var_50_0._pic_id = 0
	var_50_0._skin_id = arg_50_1:get_skin_id()
	var_50_0._flag = nil
	var_50_0._mask = nil
	var_50_0._now_hp = 0
	var_50_0._do_tween_list = {}

	gamecore.extend_obj(var_50_0)

	return var_50_0
end

return var_0_0
