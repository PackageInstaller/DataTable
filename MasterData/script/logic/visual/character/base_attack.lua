local var_0_0 = {}
local var_0_1 = UnityEngine
local var_0_2 = Vector3
local var_0_3 = DG.Tweening.DOTween
local var_0_4 = gamecore.BattleManager
local var_0_5 = gameenum.common_type
local var_0_6 = gamecore.UILoader
local var_0_8 = gameconfig.skill_config
local var_0_10 = gameconfig.ship_skill_buff_config
local var_0_11 = gamecore.effect
local var_0_13 = DG.Tweening.Core
local var_0_14 = gamecore.user
local var_0_15 = string.format

local function var_0_17(arg_1_0)
	local var_1_0 = var_0_8.find_object_by_skill_id(arg_1_0.skill_id)

	return var_1_0 and var_0_10.find_object_by_cid(var_1_0.skill_id)
end

function var_0_0.extend_method(arg_2_0)
	function arg_2_0:buff_anim_step(arg_3_1, arg_3_2, arg_3_3)
		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.skin_buff))

		local var_3_0 = var_0_17(arg_3_1)

		self:set_save_stage(var_0_5.henshin_type.buff)
		self:__henshin_skill(var_0_5.henshin_type.buff, arg_3_3)

		local var_3_1 = var_0_5.buff_step_time.buff_cutin
		local var_3_2, var_3_3 = self:create_spine(self._pic_id)

		var_3_3.AnimationState.TimeScale = 1

		var_3_3.AnimationState:SetAnimation(var_0_5.character_anim_type.normal.priority, var_0_5.character_anim_type.normal.name, var_0_5.character_anim_type.normal.loop)

		var_3_2.transform.position = self._spine.transform.position
		var_3_2.transform.localScale = var_0_2.New(1, 1, 1)
		var_3_2.transform.localRotation = var_0_2.New(0, self._side == var_0_5.character_type.enemy and -180 or 0, 0)
		var_3_2.transform:GetComponent(typeof(var_0_1.MeshRenderer)).sortingOrder = 1

		var_3_2.transform:DOScale(var_0_2.New(1.5, 1.3, 1), var_3_1)
		var_0_3.To(var_0_13.DOSetter_float(function(arg_4_0)
			if not var_3_3:Equals(nil) then
				var_3_3.skeleton.A = arg_4_0
			end
		end), 1, 0, var_3_1)

		if var_3_0 and var_3_0.buff_cutIn == 1 then
			self:show_skill_cutin(arg_3_2, var_3_0.icon, nil)

			return
		end

		local var_3_4 = self:autoKillDOTween(var_0_3.Sequence())

		self._battle_processor:enqueue_visual(var_3_4)
		var_3_4:AppendInterval(var_3_1)
		var_3_4:AppendCallback(function()
			if arg_3_2 then
				arg_3_2()
			end
		end)
		var_3_4:Play()
	end

	function arg_2_0.buff_has_cutin(arg_6_0, arg_6_1)
		local var_6_0 = var_0_17(arg_6_1)

		return var_6_0 ~= nil and var_6_0.buff_cutIn == 1
	end

	function arg_2_0.buff_info_step(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = var_0_8.find_object_by_skill_id(arg_7_1.skill_id)
		local var_7_1 = var_0_6:getInstance(var_0_5:get_battle_name())

		if var_7_1 and var_7_0 then
			var_7_1:attach_aircontrol_tip(nil, var_7_0.title, {
				delta_y = 0,
				wait_time = 0.5,
				time = 0.5,
				move_y = 250
			}, arg_7_2)
		elseif arg_7_2 then
			arg_7_2()
		end
	end

	function arg_2_0:show_immune_effect(arg_8_1)
		if arg_8_1.damage_info and arg_8_1.damage_info.is_immune and not arg_8_1.damage_info.is_dodging then
			self:create_immune_effect(self._battle_processor:find_visual(arg_8_1.target_id)._spine_root.transform:Find("damage").transform)
		end
	end

	function arg_2_0:buff_up_tips(arg_9_1)
		if arg_9_1.buff_type == gameenum.battle_type.buff_type.none then
			return
		end

		local var_9_0 = "buff_up"

		if arg_9_1.buff_type == gameenum.battle_type.buff_type.down then
			var_9_0 = "buff_down"
		end

		local var_9_1 = gamecore.effect:create()

		var_9_1:create_effect(var_9_0)
		var_9_1:set_pos(self._damage_point.transform.position)

		var_9_1._effect.transform:GetComponent(typeof(var_0_1.MeshRenderer)).sortingOrder = 2
	end

	function arg_2_0:buff_icon(arg_10_1, arg_10_2, arg_10_3)
		local var_10_0 = var_0_8.find_object_by_skill_id(arg_10_1)
		local var_10_1 = self:autoKillDOTween(var_0_3.Sequence())

		self._battle_processor:enqueue_visual(var_10_1)
		var_10_1:AppendInterval(0.2)
		var_10_1:AppendCallback(function()
			local var_11_0 = var_0_6:getInstance(var_0_5:get_battle_name())

			if var_11_0 and var_10_0 then
				var_11_0:attach_buff(arg_10_2 == var_0_5.character_type.enemy and "enemy" or "player", var_10_0.buff_cid)
			end
		end)

		if arg_10_3 then
			var_10_1:AppendCallback(arg_10_3)
		end

		var_10_1:Play()
	end

	function arg_2_0:normal_attack(arg_12_1, arg_12_2)
		local var_12_0 = self._logic:get_ship_ton()
		local var_12_1 = self._logic:get_cid()
		local var_12_2 = var_0_5.character_anim_type.attack

		local function var_12_3()
			if not arg_12_1.is_double_second and arg_12_1.target_count == 1 then
				self:show_attack_dialogue()
			end

			local var_13_0 = 0

			if arg_12_1.be_guardian_man_id and arg_12_1.guardian_man_id then
				local var_13_1 = self._battle_processor:find_visual(arg_12_1.be_guardian_man_id)
				local var_13_2 = self._battle_processor:find_visual(arg_12_1.guardian_man_id)
				local var_13_3 = var_13_2._spine_root.transform.transform.position
				local var_13_4 = self:autoKillDOTween(var_0_3.Sequence())

				self._battle_processor:enqueue_visual(var_13_4)
				var_13_4:AppendCallback(function()
					var_13_2._spine_root.transform:DOMove(var_13_1._spine_root.transform.transform.position + var_0_2(0.5, 0, 0), 0.2):SetEase(DG.Tweening.Ease.Linear)
				end)
				var_13_4:AppendInterval(2)
				var_13_4:AppendCallback(function()
					if var_13_2._now_hp > 0 then
						var_13_2._spine_root.transform:DOMove(var_13_3, 0.5):SetEase(DG.Tweening.Ease.Linear)
					end
				end)

				var_13_0 = 0.2
			end

			if arg_12_1.aircraft_id then
				var_12_2 = var_0_5.character_anim_type.throw

				self:play_animation(var_12_2)
				self:set_event_listener("throw_point", function()
					local var_16_0 = self:autoKillDOTween(var_0_3.Sequence())

					var_16_0:AppendInterval(1)
					var_16_0:AppendCallback(function()
						self:show_immune_effect(arg_12_1)
					end)
					self:__create_aircraft_by_type(arg_12_1, arg_12_2)
					self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.plane_flying_two))

					if arg_12_1.show_aircraft_effect then
						self._battle_processor:delay(1000, function()
							local var_18_0 = self._battle_processor:find_visual(arg_12_1.show_aircraft_effect)

							var_18_0:play_animation(var_0_5.character_anim_type.antiaircraft)
							self:__create_abti_aircraft_fire_effect("aircraft_fire", var_18_0._spine.transform.transform.position, var_18_0._logic._side)
						end)
					end
				end)

				return
			end

			if arg_12_1.projectile_id then
				self:show_immune_effect(arg_12_1)

				if self._logic:is_submarine() then
					self:set_submarine_flag_active(false)
					self:rise_to_sea(function()
						self:fake_play_animation(var_12_2)
						self:set_event_listener("attack_point", function()
							self:__create_projectile(arg_12_1, self:get_fake_attack_point(), arg_12_2)
							self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.s_ship_attack))
						end, self._ss_fake_skele)
					end)
				elseif arg_12_1.mallet_id and arg_12_1.animation_type == 2 and arg_12_1.is_show_cutin and not self._logic.copy_skill and self._spine.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).Skeleton.Data:FindAnimation(var_0_5.character_anim_type.hit.name) then
					var_12_2 = var_0_5.character_anim_type.hit

					local var_13_5 = self._battle_processor:find_visual(arg_12_1.target_id)
					local var_13_6 = var_13_5:get_side()
					local var_13_7 = self._spine.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).skeleton.A
					local var_13_8 = self._spine_root.transform.position
					local var_13_9 = self:autoKillDOTween(var_0_3.Sequence())

					var_13_9:AppendInterval(var_13_0)
					var_13_9:AppendCallback(function()
						for iter_21_0, iter_21_1 in pairs(arg_12_1.mallet_id) do
							if self._battle_processor:find_visual(iter_21_1)._spine_root then
								self._battle_processor:find_visual(iter_21_1)._spine_root:SetActive(false)
							end

							if self._battle_processor:find_visual(iter_21_1)._hp_bar then
								self._battle_processor:find_visual(iter_21_1)._hp_bar:SetActive(false)
							end
						end

						var_0_3.To(var_0_13.DOSetter_float(function(arg_22_0)
							self._spine.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).skeleton.A = arg_22_0
						end), 1, 0, 0.5)
						self._hp_bar:SetActive(false)
					end)
					var_13_9:AppendInterval(0.5)
					var_13_9:AppendCallback(function()
						var_0_3.To(var_0_13.DOSetter_float(function(arg_24_0)
							self._spine.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).skeleton.A = arg_24_0
						end), 0, 1, 0.3)
						self:play_animation(var_12_2)
						self._hp_bar:SetActive(true)

						self._spine_root.transform.position = var_13_5._spine_root.transform.position + var_0_2(var_13_6, 0, 0)

						self:set_event_listener("Hit_point", function()
							self:show_damage(arg_12_1, type)
						end)
						self:set_event_listener("End", function()
							return
						end)
					end)
					var_13_9:AppendInterval(1.3)
					var_13_9:AppendCallback(function()
						if not self._spine_root:Equals(nil) then
							self._spine_root.transform:DOMove(var_13_8, 0.5):SetEase(DG.Tweening.Ease.Linear)
						end
					end)
					var_13_9:AppendInterval(0.5)
					var_13_9:AppendCallback(function()
						if arg_12_2 then
							arg_12_2()

							arg_12_2 = nil
						end

						for iter_28_0, iter_28_1 in pairs(arg_12_1.mallet_id) do
							if not self._battle_processor:find_visual(iter_28_1).is_death then
								if self._battle_processor:find_visual(iter_28_1)._spine_root then
									self._battle_processor:find_visual(iter_28_1)._spine_root:SetActive(true)
								end

								if self._battle_processor:find_visual(iter_28_1)._hp_bar then
									self._battle_processor:find_visual(iter_28_1)._hp_bar:SetActive(true)
								end
							end
						end
					end)
				elseif arg_12_1.damage_info.is_double and arg_12_1.animation_type == 1 then
					local var_13_10 = 0

					self:__henshin_skill(var_0_5.henshin_type.normal_attack)

					local var_13_11 = lx.clone_table(arg_12_1)
					local var_13_12 = self._battle_processor:find_visual(arg_12_1.target_id)._now_hp

					var_13_11.damage_info.damage = math.ceil(arg_12_1.damage_info.damage / 2)
					var_13_11.target_now_hp = var_13_12 - var_13_11.damage_info.damage <= 0 and 0 or var_13_12 - var_13_11.damage_info.damage

					if var_13_11.damage_info.boss_info and var_13_11.damage_info.boss_info.damage then
						var_13_10 = var_13_11.damage_info.boss_info.damage

						if var_13_11.damage_info.boss_info.damage - var_13_11.damage_info.damage > 0 then
							var_13_11.damage_info.boss_info.damage = var_13_11.damage_info.damage or var_13_10
						end

						var_13_10 = var_13_10 - var_13_11.damage_info.boss_info.damage
					end

					local var_13_13 = lx.clone_table(arg_12_1)

					var_13_13.damage_info.damage = arg_12_1.damage_info.damage - var_13_11.damage_info.damage

					if var_13_13.damage_info.boss_info and var_13_13.damage_info.boss_info.damage then
						if var_13_10 - var_13_13.damage_info.damage > 0 then
							var_13_13.damage_info.boss_info.damage = var_13_13.damage_info.damage or var_13_10
						end
					end

					self:play_animation(var_12_2)
					self:set_event_listener("attack_point", function()
						self:show_immune_effect(arg_12_1)
						self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.l_ship_attack))
						self:__create_projectile(var_13_11, self:get_attack_point(), function()
							var_13_11.damage_info.is_double = false
							var_13_11.show_skill = false
							var_13_11.is_double_second = false

							self._battle_processor:delay(1000, function()
								self:create_second_normal_attack(var_13_13, arg_12_2)
							end)
						end, "double_attack_first")
					end)
				else
					self:play_animation(var_12_2)
					self:set_event_listener("attack_point", function()
						if self._cid == 10030911 then
							self:play_animation(var_0_5.character_anim_type.turn)
						end

						local var_32_0 = self:get_attack_point()
						local var_32_1 = self:autoKillDOTween(var_0_3.Sequence())

						var_32_1:AppendInterval(var_13_0)
						var_32_1:AppendCallback(function()
							self:__create_projectile(arg_12_1, var_32_0, arg_12_2)

							if var_12_0 == 3 then
								self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.l_ship_attack))
							elseif var_12_0 == 2 then
								self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.m_ship_attack))
							elseif var_12_1 == 10006211 or var_12_1 == 11006211 or var_12_1 == 10006311 or var_12_1 == 11006311 then
								self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.l_ship_attack))
							else
								self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.s_ship_attack))
							end
						end)
					end)
				end

				return
			end

			if arg_12_1.depthcharge_id then
				if arg_12_1.aircraft_id then
					self:aircrat_antisub(arg_12_1, arg_12_2)

					return
				end

				self:normal_antisub(arg_12_1, arg_12_2)

				return
			end

			if arg_12_1.torpedo_id then
				self:torpedo_attack(arg_12_1, false, arg_12_2, "normal_attack")

				return
			end
		end

		if arg_12_1.couple_cid_list then
			if arg_12_1.target_count == 1 then
				self:couple_skill_cutin(arg_12_1.couple_cid_list[1], arg_12_1.couple_cid_list[2], arg_12_1.show_skill, self._logic:get_cid())

				local var_12_4 = self:couple_attack_move(arg_12_1.couple_cid_list[1], arg_12_1.couple_cid_list[2])
				local var_12_5 = arg_12_2

				function arg_12_2()
					if var_12_5 then
						var_12_5()
					end

					if var_12_4 then
						var_12_4()
					end
				end
			end

			local var_12_6 = self:autoKillDOTween(var_0_3.Sequence())

			var_12_6:AppendInterval(var_0_5.buff_step_time.couple_cutin)
			var_12_6:AppendCallback(var_12_3)
			var_12_6:Play()

			return
		end

		if arg_12_1.show_skill == 40 and arg_12_1.step ~= "night_attack" then
			if arg_12_1.damage_info.is_crit == true and arg_12_1.is_show_cutin then
				self:show_skill_cutin(var_12_3, arg_12_1.show_skill, arg_12_1.show_skill_2)
			else
				self:show_cutin(var_12_3)
			end

			return
		end

		if arg_12_1.is_hit_complex_target and arg_12_1.show_skill then
			self:show_skill_cutin(var_12_3, arg_12_1.show_skill)

			return
		end

		if arg_12_1.show_skill == 106 then
			if arg_12_1.torpedo_id then
				self:show_skill_cutin(var_12_3, arg_12_1.show_skill)
			else
				self:show_cutin(var_12_3)
			end

			return
		end

		if arg_12_1.show_skill == 120 then
			local var_12_7 = self._battle_obj_mgr:findObject(arg_12_1.target_id)

			if arg_12_1.is_show_cutin then
				self:show_skill_cutin(var_12_3, arg_12_1.show_skill)
			else
				self:show_cutin(var_12_3)
			end

			return
		end

		if arg_12_1.show_skill and not arg_12_1.depthcharge_id and arg_12_1.is_show_cutin then
			self:show_skill_cutin(var_12_3, arg_12_1.show_skill, arg_12_1.show_skill_2)
		elseif arg_12_1.is_double_second then
			var_12_3()
		elseif arg_12_1.target_count == 1 then
			self:show_cutin(var_12_3)
		else
			local var_12_8 = self:autoKillDOTween(var_0_3.Sequence())

			var_12_8:AppendInterval(1.167)
			var_12_8:AppendCallback(function()
				var_12_3()
			end)
		end
	end

	function arg_2_0:couple_attack_move(arg_36_1, arg_36_2)
		local var_36_0 = self._logic:get_cid() == arg_36_1 and arg_36_2 or arg_36_1
		local var_36_1

		for iter_36_0, iter_36_1 in pairs(self._battle_obj_mgr:get_ships_by_side(self:get_side())) do
			if iter_36_1:get_cid() == var_36_0 then
				var_36_1 = self._battle_processor:find_visual(iter_36_1:getID())

				break
			end
		end

		if not var_36_1 then
			return
		end

		local var_36_2 = self._spine_root.transform.position
		local var_36_3 = false

		local function var_36_4()
			if var_36_3 then
				return
			end

			var_36_3 = true

			self._spine_root.transform:DOMove(var_36_2, 0.5):SetEase(DG.Tweening.Ease.Linear)
		end

		local var_36_5 = self:autoKillDOTween(var_0_3.Sequence())

		var_36_5:AppendCallback(function()
			self._spine_root.transform:DOMove(var_36_1._spine_root.transform.position + var_0_2(0.5, 0, 0), 0.3):SetEase(DG.Tweening.Ease.Linear)
		end)
		var_36_5:AppendInterval(10)
		var_36_5:AppendCallback(var_36_4)

		return var_36_4
	end

	function arg_2_0:aircrat_antisub(arg_39_1, arg_39_2)
		self:aircraft_attack(arg_39_1, arg_39_2, true)
	end

	function arg_2_0:normal_antisub(arg_40_1, arg_40_2)
		self:play_animation(var_0_5.character_anim_type.attack)
		self:set_event_listener("attack_point", function()
			self:__create_depth_charge(arg_40_1, self:get_attack_point(), "normal_anitsub_attack", arg_40_2)

			local var_41_0 = self._battle_obj_mgr:findObject(arg_40_1.target_id)

			if var_41_0 then
				local var_41_1 = var_41_0:get_index()
				local var_41_2 = var_0_6:getInstance(var_0_5:get_battle_name())

				if var_41_2 then
					self._battle_processor:delay(500, function()
						var_41_2:show_periscope(self._side, var_41_1)

						for iter_42_0, iter_42_1 in pairs(self._battle_processor.visual_pos_list) do
							if iter_42_1._logic:get_side() == var_41_0:get_side() and iter_42_1._logic:is_submarine() and not iter_42_1._spine_root:Equals(nil) then
								iter_42_1._spine_root:SetActive(var_41_1 == iter_42_1._logic:get_index())
							end
						end
					end)
				end
			end
		end)
	end

	function arg_2_0:open_antisub_attack(arg_43_1, arg_43_2)
		self:play_animation(var_0_5.character_anim_type.attack)

		self._limit_under = true

		self:set_event_listener("attack_point", function()
			self:__create_depth_charge(arg_43_1, self:get_attack_point(), "open_antisub", arg_43_2)
			self._battle_processor:switch_to_undersea()
			self:__change_all_pos()
		end)
	end

	function arg_2_0:antisub_attack(arg_45_1, arg_45_2)
		self:show_cutin(function()
			self:play_animation(var_0_5.character_anim_type.attack)
			self:set_event_listener("attack_point", function()
				self:__create_depth_charge(arg_45_1, self:get_attack_point(), "normal_anitsub_attack", arg_45_2)

				local var_47_0 = self._battle_obj_mgr:findObject(arg_45_1.target_id)
				local var_47_1 = var_47_0:get_index()
				local var_47_2 = var_0_6:getInstance(var_0_5:get_battle_name())

				self._battle_processor:delay(500, function()
					var_47_2:show_periscope(self._side, var_47_1)

					for iter_48_0, iter_48_1 in pairs(self._battle_processor.visual_pos_list) do
						if iter_48_1._logic:get_side() == var_47_0:get_side() and iter_48_1._logic:is_submarine() and not iter_48_1._spine_root:Equals(nil) then
							iter_48_1._spine_root:SetActive(var_47_1 == iter_48_1._logic:get_index())
						end
					end
				end)
			end)
		end)
	end

	function arg_2_0:missile_attack(arg_49_1, arg_49_2, arg_49_3, arg_49_4)
		local function var_49_0()
			arg_49_4 = arg_49_4 or 0

			self:play_animation(var_0_5.character_anim_type.throw)

			if arg_49_1.intercept and arg_49_1.tmd_target_id then
				self._battle_processor:find_visual(arg_49_1.tmd_target_id):play_animation(var_0_5.character_anim_type.throw)
			end

			self:set_event_listener("throw_point", function()
				local var_51_0 = self:autoKillDOTween(var_0_3.Sequence())

				var_51_0:AppendInterval(arg_49_4 * 0.1)
				var_51_0:AppendCallback(function()
					self:__create_missile(arg_49_1, arg_49_3)
					self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.missile_launch))
				end)
			end)
		end

		if arg_49_2 then
			self:show_cutin(var_49_0)

			return
		end

		var_49_0()
	end

	function arg_2_0:aircraft_attack(arg_53_1, arg_53_2, arg_53_3)
		local var_53_0 = self._logic:get_side()

		arg_53_1.is_aircraft = true
		self._plane_img_type = arg_53_1.plane_type == 0 and 1 or arg_53_1.plane_type

		local var_53_1 = self._battle_processor:find_visual(arg_53_1.target_id)._logic:get_attribute().hp:get_final_value()

		self:play_animation(var_0_5.character_anim_type.throw)
		self:set_event_listener("throw_point", function()
			local var_54_0 = self:autoKillDOTween(var_0_3.Sequence())

			var_54_0:AppendInterval(1)
			var_54_0:AppendCallback(function()
				self:show_immune_effect(arg_53_1)
			end)

			if self._plane_img_type == 2 then
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.plane_flying_three))
			else
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.plane_flying_four))
			end

			if arg_53_1.can_show_it == true and var_53_0 == 1 then
				self:show_attack_dialogue()
			end

			self:__create_aircraft_by_type(arg_53_1, arg_53_2)

			if arg_53_1.show_aircraft_effect then
				local var_54_1 = self:autoKillDOTween(var_0_3.Sequence())

				var_54_1:AppendInterval(1)
				var_54_1:AppendCallback(function()
					local var_56_0 = self._battle_processor:find_visual(arg_53_1.show_aircraft_effect)

					var_56_0:play_animation(var_0_5.character_anim_type.antiaircraft)
					self:__create_abti_aircraft_fire_effect("aircraft_fire", var_56_0._spine.transform.transform.position, var_56_0._logic._side)
				end)
			end
		end)
	end

	function arg_2_0:open_torpedo_attack(arg_57_1, arg_57_2)
		local var_57_0 = self._logic:get_side()

		if self._logic:is_submarine() then
			local var_57_1 = self._battle_obj_mgr:get_dunker_status()
			local var_57_2 = var_0_14:get_cur_formation()

			if true then
				self._battle_processor:switch_to_undersea()
				self:__change_all_pos()
			end

			self._battle_processor:delay(100, function()
				self:play_animation(var_0_5.character_anim_type.throw)
				self:set_event_listener("throw_point", function()
					if var_57_0 == 1 then
						if self._logic:get_index() == self._logic._battle_scene:save_open_torpedo_ships() then
							self:show_night_attack_dialogue((self._logic:get_ship_type() == var_0_5.ship_type_rule.heavy_bomb_submarine.value or self._logic:get_ship_type() == var_0_5.ship_type_rule.submarine.value) and var_0_2(0, 1.3, 0) or var_0_2(0, 1.3, 0))
						end
					end

					self:__create_torpedo(arg_57_1, arg_57_2)
					self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.torpedo_under_sea))
				end)
			end)
		else
			(function()
				if arg_57_1.syncytium_skill_id then
					local var_60_0 = self._battle_processor:find_visual(arg_57_1.syncytium_skill_id)
					local var_60_1 = self._spine_root.transform.transform.position
					local var_60_2 = self:autoKillDOTween(var_0_3.Sequence())

					var_60_2:AppendCallback(function()
						self._spine_root.transform:DOMove(var_60_0._spine_root.transform.position + var_0_2(0.5, 0, 0), 0.3):SetEase(DG.Tweening.Ease.Linear)
					end)
					var_60_2:AppendInterval(3)
					var_60_2:AppendCallback(function()
						self._spine_root.transform:DOMove(var_60_1, 0.5):SetEase(DG.Tweening.Ease.Linear)
					end)
				end

				self:play_animation(var_0_5.character_anim_type.throw)
				self:set_event_listener("throw_point", function()
					if not arg_57_1.syncytium_skill_id and self._logic:get_index() == self._logic._battle_scene:save_open_torpedo_ships() and arg_57_1.target_count == 1 and var_57_0 == 1 then
						self:show_night_attack_dialogue()
					end

					self:__create_torpedo(arg_57_1, arg_57_2)
					self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.torpedo_on_sea))
				end)
			end)()
		end
	end

	function arg_2_0:torpedo_attack(arg_64_1, arg_64_2, arg_64_3, arg_64_4)
		local var_64_0 = self._logic:get_side()
		local var_64_1 = var_0_14:get_team_by_id(var_0_14:get_battle_info().team)

		if self._logic:is_submarine() then
			if not self._battle_processor._is_night_point and not self._battle_processor:is_undersea() and arg_64_1.step ~= "night_attack" then
				self._battle_processor:switch_to_undersea()
				self:__change_all_pos()
			end

			self._battle_processor:delay(100, function()
				local function var_65_0()
					if self._border_skele then
						local var_66_0 = self._border_skele.AnimationState:SetAnimation(var_0_5.character_anim_type.throw.priority, var_0_5.character_anim_type.throw.name, var_0_5.character_anim_type.throw.loop)
						local var_66_1 = self._border_skele.AnimationState.Complete

						local function var_66_2()
							self._border_skele.AnimationState:SetAnimation(var_0_5.character_anim_type.normal.priority, var_0_5.character_anim_type.normal.name, var_0_5.character_anim_type.normal.loop)

							self._border_skele.AnimationState.Complete = var_66_1
						end

						var_66_1 = self._border_skele.AnimationState.Complete + var_66_2
						self._border_skele.AnimationState.Complete = self._border_skele.AnimationState.Complete + var_66_2
						var_66_1 = var_66_1 - var_66_2
					end

					self:play_animation(var_0_5.character_anim_type.throw)
					self:set_event_listener("throw_point", function()
						if self._logic:is_flag() and arg_64_1.step ~= "night_attack" then
							if (not arg_64_4 or arg_64_4 ~= "mix_attack_first" and arg_64_4 ~= "normal_attack") and var_64_0 == 1 and arg_64_1.target_count == 1 then
								self:show_attack_dialogue()
							end
						elseif arg_64_1.step == "night_attack" and (not arg_64_4 or arg_64_4 ~= "mix_attack_first" and arg_64_4 ~= "normal_attack") and arg_64_1.target_count == 1 then
							self:show_attack_dialogue()
						end

						self:__create_torpedo(arg_64_1, arg_64_3)
						self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.torpedo_under_sea))
					end)
				end

				if arg_64_2 then
					self:show_cutin(var_65_0)

					return
				end

				var_65_0()
			end)
		else
			local function var_64_3()
				self:play_animation(var_0_5.character_anim_type.throw)
				self:set_event_listener("throw_point", function()
					if self._logic:is_flag() and arg_64_1.step ~= "night_attack" then
						if arg_64_2 then
							if not arg_64_4 or arg_64_4 ~= "mix_attack_first" and arg_64_4 ~= "normal_attack" then
								log.print_r(arg_64_4)

								if var_64_0 == 1 or arg_64_1.step == "night_attack" and arg_64_1.target_count == 1 then
									self:show_night_attack_dialogue()
								end
							end
						elseif (not arg_64_4 or arg_64_4 ~= "mix_attack_first" and arg_64_4 ~= "normal_attack") and var_64_0 == 1 and arg_64_1.target_count == 1 then
							self:show_night_attack_dialogue()
						end
					elseif arg_64_1.step == "night_attack" and (not arg_64_4 or arg_64_4 ~= "mix_attack_first" and arg_64_4 ~= "normal_attack") and arg_64_1.target_count == 1 then
						self:show_night_attack_dialogue()
					end

					self:__create_torpedo(arg_64_1, arg_64_3, arg_64_4 == "normal_attack")
					self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.torpedo_on_sea))
				end)
			end

			if arg_64_2 then
				self:show_cutin(var_64_3)

				return
			end

			var_64_3()
		end
	end

	function arg_2_0:night_mix_attack(arg_71_1, arg_71_2)
		local var_71_0 = self._logic:get_side()
		local var_71_1 = lx.clone_table(arg_71_1)
		local var_71_2 = math.ceil(var_71_1.damage_info.damage / 2)
		local var_71_3 = arg_71_1.damage_info.damage - var_71_2

		self:show_cutin(function()
			self:play_animation(var_0_5.character_anim_type.attack)
			self:set_event_listener("attack_point", function()
				self:show_immune_effect(arg_71_1)
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.m_ship_attack))

				local var_73_0 = self:get_attack_point()

				if var_71_0 == 1 or arg_71_1.step == "night_attack" then
					self:show_night_attack_dialogue()
				end

				var_71_1.damage_info.damage = var_71_2
				var_71_1.target_now_hp = arg_71_1.target_befor_hp - var_71_2 < 0 and 0 or arg_71_1.target_befor_hp - var_71_2

				self:__create_projectile(var_71_1, var_73_0, function()
					var_71_1.damage_info.damage = var_71_3
					var_71_1.target_now_hp = arg_71_1.target_now_hp

					self:torpedo_attack(var_71_1, false, arg_71_2, "mix_attack_first")
				end, "mix_attack_first")
			end)
		end)
	end

	function arg_2_0:create_second_normal_attack(arg_75_1, arg_75_2)
		arg_75_1.projectile_id = arg_75_1.projectile_second_id

		local var_75_0 = self:get_attack_point()

		self:play_animation(var_0_5.character_anim_type.attack)
		self:set_event_listener("attack_point", function()
			self:__create_projectile(arg_75_1, var_75_0, function()
				arg_75_1.damage_info.is_double = false
				arg_75_1.target_now_hp = arg_75_1.target_now_hp
				arg_75_1.show_skill = false
				arg_75_1.is_double_second = false

				self._battle_processor:delay(1000, arg_75_2)
			end, "double_attack_second")
		end)
	end

	function arg_2_0:__create_projectile(arg_78_1, arg_78_2, arg_78_3, arg_78_4)
		self:__create_openfire_effect("ship_fire", arg_78_2.transform.position)

		local var_78_0 = self._battle_processor:find_visual(arg_78_1.projectile_id)

		if not var_78_0 then
			return
		end

		var_78_0:create_projectile()
		var_78_0:set_miss(arg_78_1.damage_info.is_miss)
		var_78_0:set_crit(arg_78_1.damage_info.is_crit)
		var_78_0:set_pos(arg_78_2.transform.position)
		var_78_0:set_target(arg_78_1.target_id)
		var_78_0:set_call_func(function()
			self:show_damage(arg_78_1, arg_78_4)

			if arg_78_3 then
				arg_78_3(arg_78_4)

				arg_78_3 = nil
			end

			self:sink_to_under_sea(function()
				self:set_submarine_flag_active(true)
			end)
		end)
	end

	function arg_2_0:__create_torpedo(arg_81_1, arg_81_2, arg_81_3)
		local var_81_0 = self:get_attack_point()
		local var_81_1 = self._battle_processor:find_visual(arg_81_1.torpedo_id)

		if not var_81_1 then
			return
		end

		if self._logic:is_submarine() then
			var_81_1:create_torpedo("undersea_torpedo")
			var_81_1:set_pos(var_81_0.transform.position)
			var_81_1:set_miss(arg_81_1.damage_info.is_miss)
			var_81_1:set_crit(arg_81_1.damage_info.is_crit)
			var_81_1:fire_target_under_sea(arg_81_1.target_id)
			var_81_1:set_event_listener("Torpedo_under_sea", function()
				var_81_1:set_enable_move(true)

				local var_82_1 = self._battle_processor:get_hook((lx.clone_table((self._side == var_0_5.character_type.enemy or nil) and var_0_5.ship_position.enemy[self._index])))

				if arg_81_1.step ~= "night_attack" then
					var_82_1 = var_82_1 - var_0_2.New(0, 1.65 * self._battle_processor._hook, 0)
				end

				self._battle_processor:delay(100, function()
					var_81_1:create_seaeffect(arg_81_1.target_id, var_82_1)
				end)
			end)
		else
			var_81_1:create_torpedo(arg_81_3 and "undersea_torpedo_special" or "sea_torpedo")
			var_81_1:set_miss(arg_81_1.damage_info.is_miss)
			var_81_1:set_crit(arg_81_1.damage_info.is_crit)
			var_81_1:set_event_listener("End", function()
				var_81_1:fire_target_in_sea(arg_81_1.target_id, arg_81_3)
			end)
			var_81_1:set_pos(var_0_2.New(var_81_0.transform.position.x, self:get_position().y, var_81_0.transform.position.z))
		end

		var_81_1:set_call_func(function()
			self:show_immune_effect(arg_81_1)
			self:show_damage(arg_81_1)

			if arg_81_2 then
				arg_81_2()

				arg_81_2 = nil
			end
		end)
	end

	function arg_2_0:__create_depth_charge(arg_86_1, arg_86_2, arg_86_3, arg_86_4)
		local var_86_0 = self._battle_processor:find_visual(arg_86_1.depthcharge_id)

		if not var_86_0 then
			return
		end

		if arg_86_3 == "open_antisub" then
			var_86_0.is_open_antisub = true
		end

		var_86_0:create_depthcharge(var_86_0.is_open_antisub)
		var_86_0:set_pos(arg_86_2.transform.position)
		var_86_0:set_target(arg_86_1.target_id)
		var_86_0:set_miss(arg_86_1.damage_info.is_miss)
		var_86_0:set_crit(arg_86_1.damage_info.is_crit)
		var_86_0:set_call_func(function()
			self:show_damage(arg_86_1)
			self:add_periscope_damage_text(arg_86_1.damage_info)

			if arg_86_4 then
				arg_86_4()

				arg_86_4 = nil
			end

			if arg_86_3 == "open_antisub" then
				self._battle_processor:delay(2000, function()
					print("上升到海面上1")
					self._battle_processor:switch_to_sea()
					self:__change_all_pos(true)
				end)
			else
				self._battle_processor:delay(300, function()
					local var_89_0 = var_0_6:getInstance(var_0_5:get_battle_name())

					if var_89_0 then
						var_89_0:close_periscope()
					end

					for iter_89_0, iter_89_1 in pairs(self._battle_processor.visual_pos_list) do
						if iter_89_1._spine_root and not iter_89_1._spine_root:Equals(nil) then
							iter_89_1._spine_root:SetActive(iter_89_1._now_hp > 0)
						end
					end
				end)
			end
		end)
	end

	function arg_2_0:__create_missile(arg_90_1, arg_90_2)
		local var_90_0 = self._battle_processor:find_visual(arg_90_1.target_id)

		if not var_90_0 then
			return
		end

		local var_90_1 = self:get_attack_point()
		local var_90_2 = var_90_0:get_damage_point()
		local var_90_3 = var_90_0:get_attack_point()

		self:__create_openfire_effect("missile_attack", var_90_1.transform.position)

		if arg_90_1.can_show_it == true and arg_90_1.target_count == 1 then
			if (self._logic:get_side() == 1 or arg_90_1.step == "night_attack") and arg_90_1.target_count == 1 then
				self:show_night_attack_dialogue()
			end
		elseif arg_90_1.step == "night_attack" and arg_90_1.target_count == 1 then
			self:show_night_attack_dialogue()
		end

		if arg_90_1.intercept and arg_90_1.tmd_target_id then
			local var_90_4 = self._battle_processor:find_visual(arg_90_1.tmd_target_id)
			local var_90_5 = var_90_4:get_damage_point()
			local var_90_6 = var_90_4:get_attack_point()
			local var_90_7 = var_0_2.New((var_90_1.transform.position.x + var_90_6.transform.position.x) / 2, (var_90_1.transform.position.x + var_90_6.transform.position.x) / 2 + self._battle_random:visualRandRange(15, 30) / 5, (var_90_1.transform.position.z + var_90_6.transform.position.z) / 2)
			local var_90_8 = self._battle_processor:find_visual(arg_90_1.atk_missile_id)

			var_90_8:create_missile()
			var_90_8:set_pos(var_90_1.transform.position)
			var_90_8:set_intercept(true)
			var_90_8:set_target_position(var_90_7, 1.5)

			local var_90_9 = self._battle_processor:find_visual(arg_90_1.tmd_id)

			var_90_9:create_missile()
			var_90_9:set_pos(var_90_6.transform.position)
			var_90_9:set_intercept(true)
			var_90_9:set_target_position(var_90_7, 1.5)
			var_90_8:set_call_func(function()
				if arg_90_2 then
					arg_90_2()

					arg_90_2 = nil
				end
			end)

			return
		end

		local var_90_10 = self._battle_processor:find_visual(arg_90_1.atk_missile_id)

		var_90_10:create_missile(arg_90_1.step)
		var_90_10:set_booster_id(arg_90_1.booster_id)
		var_90_10:set_miss(arg_90_1.damage_info.is_miss)
		var_90_10:set_crit(arg_90_1.damage_info.is_crit)
		var_90_10:set_pos(var_90_1.transform.position)
		var_90_10:set_target(arg_90_1.target_id)
		var_90_10:set_call_func(function()
			self:show_damage(arg_90_1)
			self:show_immune_effect(arg_90_1)

			if arg_90_2 then
				arg_90_2()

				arg_90_2 = nil
			end
		end)
	end

	function arg_2_0:__create_aircraft_by_type(arg_93_1, arg_93_2)
		local var_93_0 = self._battle_processor:find_visual(arg_93_1.target_id)

		if not var_93_0 then
			return
		end

		local var_93_1 = var_93_0:get_damage_point().transform.position + var_0_2.New(0, -2.2, 0)

		if arg_93_1.plane_idx == 1 then
			var_0_2.zero.z = -0.68
		end

		if arg_93_1.plane_idx == 2 then
			var_0_2.zero.x = -0.8
		end

		if arg_93_1.plane_idx == 3 then
			var_0_2.zero.x = 0.8
		end

		if arg_93_1.plane_idx == 4 then
			var_0_2.zero.z = 0.68
		end

		local var_93_2 = false
		local var_93_3 = self._battle_processor:find_visual(arg_93_1.aircraft_id)

		var_93_3:create_aircraft(arg_93_1)
		var_93_3:set_miss(arg_93_1.damage_info and arg_93_1.damage_info.is_miss)
		var_93_3:set_crit(arg_93_1.damage_info and arg_93_1.damage_info.is_crit)
		var_93_3:set_pos(self:get_throw_point().transform.position + var_0_2.zero)
		var_93_3:set_target_pos(var_93_1)
		var_93_3:set_call_func(function()
			if var_93_2 == false then
				self:show_damage(arg_93_1, "aircraft_atk")

				if arg_93_1.attack_type == var_0_5.plane_attack_type.throw_depthcharge or arg_93_1.depthcharge_id then
					self:add_periscope_damage_text(arg_93_1.damage_info)
				end
			end

			if arg_93_2 then
				arg_93_2()

				arg_93_2 = nil
			end

			self._battle_processor:delay(300, function()
				local var_95_0 = var_0_6:getInstance(var_0_5:get_battle_name())

				if var_95_0 then
					var_95_0:close_periscope()
				end

				if arg_93_1.attack_type == var_0_5.plane_attack_type.throw_depthcharge or arg_93_1.depthcharge_id then
					for iter_95_0, iter_95_1 in pairs(self._battle_processor.visual_pos_list) do
						if iter_95_1._spine_root and not iter_95_1._spine_root:Equals(nil) then
							iter_95_1._spine_root:SetActive(iter_95_1._now_hp > 0)
						end
					end
				end
			end)

			var_93_2 = true
		end)

		if arg_93_1.attack_type == var_0_5.plane_attack_type.none then
			var_93_3:go_to_attack_position(var_93_1)

			return
		end

		if arg_93_1.attack_type == var_0_5.plane_attack_type.throw_torpedo then
			var_93_3:go_to_attack_position(var_93_1)

			return
		end

		if arg_93_1.attack_type == var_0_5.plane_attack_type.throw_bomb then
			var_93_3:go_to_attack_position(var_93_1)

			return
		end

		if arg_93_1.attack_type == var_0_5.plane_attack_type.throw_depthcharge or arg_93_1.depthcharge_id then
			var_93_3:go_to_attack_position(var_93_1)

			return
		end
	end

	function arg_2_0:__create_openfire_effect(arg_96_1, arg_96_2)
		local var_96_0 = var_0_11:create()

		var_96_0:create_effect(arg_96_1)
		var_96_0:set_side(self._side)
		var_96_0:set_pos(arg_96_2)
	end

	function arg_2_0.__create_abti_aircraft_fire_effect(arg_97_0, arg_97_1, arg_97_2, arg_97_3)
		local var_97_0 = var_0_11:create()

		var_97_0:create_effect(arg_97_1)
		var_97_0:set_side(arg_97_3)

		if arg_97_3 == var_0_5.character_type.player then
			var_97_0:set_pos(arg_97_2 + var_0_2(1.5, 1.5, -1))
		else
			var_97_0:set_pos(arg_97_2 + var_0_2(-1.5, 1.5, -1))
		end
	end

	function arg_2_0:__change_all_pos(arg_98_1)
		for iter_98_0, iter_98_1 in pairs(self._battle_processor.visual_pos_list) do
			if iter_98_1 then
				if arg_98_1 then
					iter_98_1:restore_pos()
				else
					iter_98_1:change_pos()
				end
			end
		end
	end

	function arg_2_0:__henshin_skill(arg_99_1, arg_99_2)
		if self._logic:get_attribute().skill_num.ship_henshin then
			local var_99_0 = self._logic:get_attribute().skill_num.ship_henshin.now_animation_id
			local var_99_1 = self._logic:get_attribute().skill_num.ship_henshin.now_henshin_cid
			local var_99_2 = self._logic:get_attribute().skill_num.ship_henshin.now_stage
			local var_99_3 = self._logic:get_attribute().skill_num.ship_henshin.now_animation_num2
			local var_99_4 = self._logic:get_attribute().skill_num.ship_henshin.now_is_skin

			if self._logic:get_skin_id() ~= 0 then
				local var_99_5

				if self._pic_id then
					var_99_5 = string.match(tostring(self._pic_id), "_(%d+)$")
					var_99_5 = var_99_5 and tonumber(var_99_5)
				end

				if var_99_4 then
					for iter_99_0, iter_99_1 in pairs(var_99_4) do
						if var_99_5 == iter_99_1 then
							break
						end
					end

					var_99_0 = false and var_99_0 .. "_" .. self._logic:get_attribute().skill_num.ship_henshin.now_animation_num3 or var_99_0 .. "_" .. var_99_3
				else
					var_99_0 = var_99_0 .. "_" .. var_99_3
				end
			else
				var_99_0 = var_99_0 .. "_" .. var_99_3
			end

			if not arg_99_1 then
				log.print_r("空阶段")

				return
			end

			if var_99_2 == arg_99_1 then
				for iter_99_2, iter_99_3 in pairs(var_99_1) do
					if self._logic:get_cid() == iter_99_3 then
						local var_99_7 = self._spine.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

						var_99_7.skeletonDataAsset = var_0_4:loadBattleSkeletonDataAsset((var_0_15(var_0_5.ship_spine, var_99_0, var_99_0)))

						if not var_99_7.skeletonDataAsset then
							return
						end

						var_99_7:Initialize(true)
						var_99_7:Update(1)

						local var_99_8 = "default"
						local var_99_9 = var_99_7.Skeleton.Data:FindSkin("normal")

						if var_99_9 then
							var_99_8 = "normal"
						end

						var_99_7.skeleton:SetSkin((not not (arg_99_2 and arg_99_2 / self._logic:get_attribute().hp:get_final_value() <= gameenum.battle_type.hp_ratio_type.medhp) and var_99_7.Skeleton.Data:FindSkin("damage") or nil) and "damage")
						self:play_animation(var_0_5.character_anim_type.normal)
					end
				end
			end
		end
	end

	function arg_2_0.set_save_stage(arg_100_0, arg_100_1)
		arg_100_0.__now_henshin_skill_stage = arg_100_1
	end

	function arg_2_0:get_save_stage()
		return self.__now_henshin_skill_stage
	end
end

function var_0_0.extend_obj(arg_102_0)
	arg_102_0.__now_henshin_skill_stage = nil
end

return var_0_0
