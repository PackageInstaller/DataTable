local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = lan_rand
local var_0_3 = gamecore.BattleManager
local var_0_5 = DG.Tweening.DOTween
local var_0_6 = gamecore.UILoader
local var_0_7 = gameenum.common_type
local var_0_8 = string.format
local var_0_9 = gameconfig.ship_config
local var_0_11 = gameconfig.skin_config
local var_0_12 = gamecore.SubPatchManager
local var_0_13 = gamecore.ResourceLoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:show_cutin(arg_2_1)
		local var_2_0 = self._logic:get_side()
		local var_2_1 = self._logic:get_ship_cfg()
		local var_2_2 = {
			z = 0,
			x = 0,
			y = 0
		}

		if var_2_0 == var_0_7.character_type.enemy then
			var_2_2 = {
				z = 0,
				x = 0,
				y = 0
			}
		end

		local var_2_3 = var_0_6:getInstance(var_0_7:get_battle_name())
		local var_2_4

		if var_2_3 then
			var_2_4 = var_2_3:get_cutin_root()
		end

		if not var_2_4 then
			return
		end

		self._cutin_gunfire = var_0_3:createBattleGameObject("data/battle/prefab/gunfire/gunfire.prefab")
		self._cutin_gunfire.transform.localPosition = Vector3.New(var_2_2.x, var_2_2.y, var_2_2.z)

		local var_2_5 = false
		local var_2_6 = 0
		local var_2_7 = 0

		if #var_0_7.big_hd_img >= 1 then
			for iter_2_0, iter_2_1 in pairs(var_0_7.big_hd_img) do
				if iter_2_1.id == var_2_1.ship_index then
					var_2_5 = true
					var_2_6 = iter_2_1.pox
					var_2_7 = iter_2_1.poy
				end
			end
		end

		var_2_6 = var_2_6 or 0
		var_2_7 = var_2_7 or 0

		if var_2_5 then
			self._cutin_gunfire.transform.localPosition = Vector3.New(var_2_2.x + var_2_6, var_2_2.y + var_2_7, var_2_2.z)
			self._cutin_gunfire.transform.localScale = Vector3.New(self._cutin_gunfire.transform.localScale.x * var_2_0 * 2, self._cutin_gunfire.transform.localScale.y * 2, 1)
		else
			self._cutin_gunfire.transform.localScale = Vector3.New(self._cutin_gunfire.transform.localScale.x * var_2_0, self._cutin_gunfire.transform.localScale.y, 1)
		end

		self._cutin_gunfire.transform:SetParent(var_2_4.transform, false)

		local var_2_8 = self:__get_skin_by_star(var_2_1.star)
		local var_2_9 = self._cutin_gunfire.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
		local var_2_10 = self._cutin_gunfire.transform:GetComponent(typeof(ChangeSpineSlot))
		local var_2_11 = var_0_3:loadBattleTexture2D((self:__get_spine_sprite()))

		var_2_10:ChangeSlotWithSpriteName(var_2_8, "Actor_picture", var_2_11, false)
		var_2_10:ChangeSlotWithSpriteName(var_2_8, "Actor_picture_black", var_2_11, false)
		self:__after_complete_motion(var_2_9, self._cutin_gunfire, arg_2_1)
		var_2_9.AnimationState:SetAnimation(0, self:__get_spine_motion(var_2_0), false)
	end

	function arg_1_0:show_damage_cutin(arg_3_1, arg_3_2, arg_3_3)
		if self._side == var_0_7.character_type.enemy or self._ignore_cutin then
			return
		end

		if self._played_cutin then
			return
		end

		if self._is_set_damage_cutin and arg_3_2 then
			return
		end

		local var_3_0 = arg_3_1 / self._logic:get_attribute().hp:get_final_value()

		if var_3_0 >= gameenum.battle_type.hp_ratio_type.lowhp and (var_3_0 >= gameenum.battle_type.hp_ratio_type.medhp or var_3_0 < gameenum.battle_type.hp_ratio_type.lowhp) then
			return
		end

		local var_3_1 = var_0_6:getInstance(var_0_7:get_battle_name())

		if not var_3_1 then
			return
		end

		if arg_3_2 then
			self._is_set_damage_cutin = true

			if not self:set_show_damage_cutin_data(arg_3_1, arg_3_2) then
				return
			end
		end

		self._played_cutin = true
		var_3_1._damage_cutin_num = var_3_1._is_show_damage_cutin == true and var_3_1._damage_cutin_num + 1 or 0
		var_3_1._is_show_damage_cutin = true

		local var_3_2 = self:autoKillDOTween(var_0_5.Sequence())

		var_3_2:AppendInterval(2.45 * var_3_1._damage_cutin_num)
		var_3_2:AppendCallback(function()
			self._damage_cutin_spine = var_0_3:createBattleGameObject((var_0_7:get_final_battle_prefab_path(var_0_7.damage_cutin.path)))

			self._damage_cutin_spine.transform:SetParent(var_3_1:get_cutin_root().transform, false)

			if self._damage_cutin_spine:Equals(nil) then
				return
			end

			local var_4_0 = self._damage_cutin_spine.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
			local var_4_1 = self._damage_cutin_spine.transform:GetComponent(typeof(ChangeSpineSlot))
			local var_4_2 = var_0_3:loadBattleTexture2D((self:__get_spine_sprite()))
			local var_4_3 = var_0_7.damage_cutin.skin.medium

			if var_3_0 < gameenum.battle_type.hp_ratio_type.lowhp then
				var_4_3 = var_0_7.damage_cutin.skin.large
			end

			var_4_1:ChangeSlotWithSpriteName(var_4_3, "Actor_picture", var_4_2, false)
			var_4_1:ChangeSlotWithSpriteName(var_4_3, "Actor_picture_light", var_4_2, false)
			self:show_break_dialogue()

			local var_4_4 = self._spine.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

			if var_4_4.Skeleton.Data:FindSkin("damage") then
				var_4_4.skeleton:SetSkin("damage")
				var_4_4:ClearState()
				self:play_animation(var_0_7.character_anim_type.normal)
			end

			self:__after_complete_motion(var_4_0, self._damage_cutin_spine, function()
				if arg_3_3 then
					arg_3_3()
				end
			end, var_3_1)

			if var_0_7.damage_cutin.damage.name == "Damage" and self._logic:is_submarine() then
				self._border_skele.initialSkinName = "damage"

				self._border_skele:Initialize(true)
				self._border_skele.AnimationState:SetAnimation(var_0_7.character_anim_type.normal.priority, var_0_7.character_anim_type.normal.name, var_0_7.character_anim_type.normal.loop)
			end

			var_4_0.AnimationState:SetAnimation(var_0_7.damage_cutin.damage.priority, var_0_7.damage_cutin.damage.name, var_0_7.damage_cutin.damage.loop)
			self._battle_processor:pause_frame()
		end)
		var_3_2:AppendInterval(0.5)
		var_3_2:AppendCallback(function()
			var_3_2:Kill()
		end)
		var_3_2:Play()
	end

	function arg_1_0:set_show_damage_cutin_data(arg_7_1, arg_7_2)
		local var_7_0 = {
			now_hp = arg_7_1,
			id = self._logic:getID()
		}

		if arg_7_2 == "aircraft_attack" then
			self._battle_processor._battlefield._battle_report.air_attack_damage_cutin = self._battle_processor._battlefield._battle_report.air_attack_damage_cutin or {}

			table.insert(self._battle_processor._battlefield._battle_report.air_attack_damage_cutin, var_7_0)
		elseif arg_7_2 == "open_missile_attack" then
			self._battle_processor._battlefield._battle_report.open_missile_attack_damage_cutin = self._battle_processor._battlefield._battle_report.open_missile_attack_damage_cutin or {}

			table.insert(self._battle_processor._battlefield._battle_report.open_missile_attack_damage_cutin, var_7_0)
		elseif arg_7_2 == "open_antisub_attack" then
			self._battle_processor._battlefield._battle_report.open_antisub_attack_damage_cutin = self._battle_processor._battlefield._battle_report.open_antisub_attack_damage_cutin or {}

			table.insert(self._battle_processor._battlefield._battle_report.open_antisub_attack_damage_cutin, var_7_0)
		elseif arg_7_2 == "open_torpedo_attack" then
			self._battle_processor._battlefield._battle_report.open_torpedo_attack_damage_cutin = self._battle_processor._battlefield._battle_report.open_torpedo_attack_damage_cutin or {}

			table.insert(self._battle_processor._battlefield._battle_report.open_torpedo_attack_damage_cutin, var_7_0)
		elseif arg_7_2 == "normal_attack" then
			return true
		elseif arg_7_2 == "normal_attack2" then
			return true
		elseif arg_7_2 == "torpedo_attack" then
			self._battle_processor._battlefield._battle_report.close_torpedo_attack_damage_cutin = self._battle_processor._battlefield._battle_report.close_torpedo_attack_damage_cutin or {}

			table.insert(self._battle_processor._battlefield._battle_report.close_torpedo_attack_damage_cutin, var_7_0)
		elseif arg_7_2 == "close_missile_attack" then
			self._battle_processor._battlefield._battle_report.close_missile_attack_damage_cutin = self._battle_processor._battlefield._battle_report.close_missile_attack_damage_cutin or {}

			table.insert(self._battle_processor._battlefield._battle_report.close_missile_attack_damage_cutin, var_7_0)
		elseif arg_7_2 == "night_attack" then
			return true
		end

		return false
	end

	function arg_1_0:show_aircraft_cutin(arg_8_1)
		local var_8_0 = self._logic:get_side()

		if arg_8_1 == true then
			local var_8_1 = {
				z = 0,
				x = 0,
				y = 0
			}
			local var_8_2 = var_0_6:getInstance(var_0_7:get_battle_name())
			local var_8_3 = var_8_2:get_cutin_root()
			local var_8_4 = var_8_2:get_actor_mask()
			local var_8_5 = self._logic:get_ship_cfg()
			local var_8_6 = var_0_7.aircraft_cutin

			self._aircutin_bg = var_0_3:createBattleGameObject((var_0_7:get_final_battle_prefab_path(var_0_7.aircraft_cutin.bg)))
			self._aircutin_bg.transform.localScale = Vector3.New(self._aircutin_bg.transform.localScale.x * var_8_0, self._aircutin_bg.transform.localScale.y, 1)

			self._aircutin_bg.transform:SetParent(var_8_3.transform, false)

			local var_8_7 = self._aircutin_bg.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
			local var_8_8 = var_8_7.transform:GetComponent(typeof(ChangeSpineSlot))
			local var_8_9 = self._plane_img_type

			if self._skin_id ~= 0 then
				local var_8_10 = var_0_11.find_object_by_cid(self._skin_id)

				if next(var_8_10.plane_img_type) then
					var_8_9 = var_8_10.plane_img_type[1]
				end
			end

			local var_8_11 = var_0_3:loadBattleTexture2D(string.format(var_0_7.airplane, var_8_9))

			var_8_8:ChangeSlotWithSpriteName("default", "Fighter_picture_02", var_8_11, false)
			var_8_8:ChangeSlotWithSpriteName("default", "Fighter_picture_shadow_02", var_8_11, false)
			var_8_7.AnimationState:SetAnimation(0, "appear", false)

			self._aircutin_actor = var_0_3:createBattleGameObject((var_0_7:get_final_battle_prefab_path((var_8_0 == var_0_7.character_type.enemy or nil) and var_8_6.actor_mirror)))

			local var_8_13 = false
			local var_8_14 = 0
			local var_8_15 = 0

			if #var_0_7.big_hd_img >= 1 then
				for iter_8_0, iter_8_1 in pairs(var_0_7.big_hd_img) do
					if iter_8_1.id == var_8_5.ship_index then
						var_8_13 = true
						var_8_14 = iter_8_1.pox
						var_8_15 = iter_8_1.poy
					end
				end
			end

			var_8_14 = var_8_14 or 0
			var_8_15 = var_8_15 or 0

			if var_8_13 then
				self._aircutin_actor.transform.localPosition = Vector3.New(var_8_1.x + var_8_14, var_8_1.y + var_8_15, var_8_1.z)
				self._aircutin_actor.transform.localScale = Vector3.New(self._aircutin_actor.transform.localScale.x * var_8_0 * 2, self._aircutin_actor.transform.localScale.y * 2, 1)
			else
				self._aircutin_actor.transform.localScale = Vector3.New(self._aircutin_actor.transform.localScale.x * var_8_0, self._aircutin_actor.transform.localScale.y, 1)
			end

			self._aircutin_actor.transform:SetParent(var_8_3.transform, false)

			local var_8_16 = self._aircutin_actor.transform:GetComponent(typeof(ChangeSpineSlot))
			local var_8_17 = var_0_3:loadBattleTexture2D((self:__get_spine_sprite()))
			local var_8_18 = self._side == var_0_7.character_type.enemy

			var_8_16:ChangeSlotWithSpriteName("default", "Actor_picture", var_8_17, var_8_18)
			var_8_16:ChangeSlotWithSpriteName("default", "Actor_picture_shadow", var_8_17, var_8_18)
			self._aircutin_actor.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).AnimationState:SetAnimation(0, "appear", false)

			self._aircutin_fighter = var_0_3:createBattleGameObject((var_0_7:get_final_battle_prefab_path(var_8_6.fighters)))
			self._aircutin_fighter.transform.localScale = Vector3.New(self._aircutin_fighter.transform.localScale.x * var_8_0, self._aircutin_fighter.transform.localScale.y, 1)

			self._aircutin_fighter.transform:SetParent(var_8_3.transform, false)

			local var_8_19 = self._aircutin_fighter.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
			local var_8_20 = self._aircutin_fighter.transform:GetComponent(typeof(ChangeSpineSlot))
			local var_8_21 = self._plane_img_type

			if self._skin_id ~= 0 then
				local var_8_22 = var_0_11.find_object_by_cid(self._skin_id)

				if next(var_8_22.plane_img_type) then
					var_8_21 = var_8_22.plane_img_type[1]
				end
			end

			local var_8_23 = var_0_3:loadBattleTexture2D(string.format(var_0_7.airplane, var_8_21))

			var_8_20:ChangeSlotWithSpriteName("default", "Fighter_picture_00", var_8_23, false)
			var_8_20:ChangeSlotWithSpriteName("default", "Fighter_picture_shadow_00", var_8_23, false)
			var_8_20:ChangeSlotWithSpriteName("default", "Fighter_picture_01", var_8_23, false)
			var_8_20:ChangeSlotWithSpriteName("default", "Fighter_picture_shadow_01", var_8_23, false)
			var_8_19.AnimationState:SetAnimation(0, "appear", false)

			var_8_19.skeleton.A = 0

			local var_8_24 = self:autoKillDOTween(var_0_5.Sequence())

			var_8_24:AppendInterval(0.1)
			var_8_24:AppendCallback(function()
				var_8_19.skeleton.A = 1
			end)
			var_8_24:AppendCallback(function()
				var_8_24:Kill()
			end)
			var_8_24:Play()

			local var_8_25 = var_8_7.state.Complete

			local function var_8_26()
				var_0_3:destroyGameObject(self._aircutin_bg)
				var_0_3:destroyGameObject(self._aircutin_actor)
				var_0_3:destroyGameObject(self._aircutin_fighter)

				var_8_7.state.Complete = var_8_25
			end

			var_8_25 = var_8_7.state.Complete + var_8_26
			var_8_7.state.Complete = var_8_7.state.Complete + var_8_26
			var_8_25 = var_8_25 - var_8_26
		end
	end

	function arg_1_0:show_damage_recovery(arg_12_1, arg_12_2)
		if self._side == var_0_7.character_type.enemy and not arg_12_2 then
			return
		end

		local var_12_0 = self._logic:get_attribute().hp:get_final_value()

		if arg_12_2 then
			var_12_0 = arg_12_2
		end

		self._be_damage = nil

		local var_12_1 = var_0_3:createBattleGameObject((var_0_7:get_final_battle_prefab_path(var_0_7.damage_recovery)))

		var_12_1.transform:SetParent(var_0_6:getInstance(var_0_7:get_battle_name()):get_cutin_root().transform, false)

		local var_12_2 = var_12_1.transform:Find("damage_control_actor")
		local var_12_3 = self:__get_normal_png()
		local var_12_4 = self:__get_broken_png()

		if arg_12_2 then
			var_12_4 = var_12_3
		end

		local var_12_5 = var_12_2.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
		local var_12_6 = var_12_2.transform:GetComponent(typeof(ChangeSpineSlot))
		local var_12_7 = var_0_3:loadBattleTexture2D(var_12_3)
		local var_12_8 = var_0_3:loadBattleTexture2D(var_12_4)

		var_12_6:ChangeSlotWithSpriteName("default", "Actor_picture", var_12_7, false)
		var_12_6:ChangeSlotWithSpriteName("default", "Actor_picture_light", var_12_7, false)
		var_12_6:ChangeSlotWithSpriteName("default", "Actor_damage_picture", var_12_8, false)
		var_12_6:ChangeSlotWithSpriteName("default", "Actor_damage_picture_Light", var_12_8, false)
		var_12_5.AnimationState:SetAnimation(0, "Actor_animation", false)

		local var_12_9 = var_12_1.transform:Find("damage_control_mask/damage_recovery_mask/damage_control").transform:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

		var_12_9.AnimationState:SetAnimation(0, "Damage_control", false)

		local var_12_10 = var_12_1.transform:Find("damage_control_mask")

		if UnityEngine.Screen.width / UnityEngine.Screen.height <= 1.34 then
			var_12_10.transform.localScale = Vector3.New(1.3, 1.3, 1)
			var_12_10.transform.localPosition = Vector3.New(-30, 0, 0)
		end

		local var_12_11 = var_12_10.transform:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

		var_12_11.AnimationState:SetAnimation(0, "Mask_animation", false)

		local var_12_12 = self._spine.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

		var_12_12.skeleton:SetSkin((var_12_12.Skeleton.Data:FindSkin("normal") or nil) and "normal")

		local var_12_14 = var_12_9.AnimationState.Complete

		local function var_12_15()
			var_12_9.AnimationState:SetAnimation(1, "Damage_control_out", false)
			var_12_11.AnimationState:SetAnimation(1, "Mask_animation_out", false)
			var_12_5.AnimationState:SetAnimation(1, "Actor_animation_out", false)

			var_12_9.AnimationState.Complete = var_12_14

			local var_13_0 = var_12_9.AnimationState.Complete

			local function var_13_1()
				if arg_12_1 then
					var_0_3:destroyGameObject(var_12_1)

					self._logic._reduce_hp = self._logic:get_attribute().hp:get_final_value() - var_12_0
					self._is_recover_life = false

					arg_12_1()

					arg_12_1 = nil
				end

				var_12_9.AnimationState.Complete = var_13_0
			end

			var_13_0 = var_12_9.AnimationState.Complete + var_13_1
			var_12_9.AnimationState.Complete = var_12_9.AnimationState.Complete + var_13_1
			var_13_0 = var_13_0 - var_13_1
		end

		var_12_14 = var_12_9.AnimationState.Complete + var_12_15
		var_12_9.AnimationState.Complete = var_12_9.AnimationState.Complete + var_12_15
		var_12_14 = var_12_14 - var_12_15
	end

	function arg_1_0.__get_skin_by_star(arg_15_0, arg_15_1)
		local var_15_0 = var_0_7.cutin_skin[1]

		for iter_15_0, iter_15_1 in pairs(var_0_7.cutin_skin) do
			if arg_15_1 == iter_15_0 then
				var_15_0 = iter_15_1
			end
		end

		return var_15_0
	end

	function arg_1_0:__get_spine_motion(arg_16_1)
		return (var_0_8((arg_16_1 == var_0_7.character_type.enemy or nil) and "Gunfire_R_%d", (self._battle_random:visualRandRange(1, 3))))
	end

	function arg_1_0:__get_normal_png()
		local var_17_0 = var_0_8(var_0_7.ship_icon.model_normal_l, self._pic_id, self._pic_id)

		if not var_0_12:getIsDownloadPatch("data2") then
			return var_17_0
		end

		if string.sub(var_17_0, 9, 22) == "model_normal_l" then
			local var_17_1 = string.gsub(string.gsub(var_17_0, "/ui", ""), "data", "data2")

			if var_0_9.get_h_model_normal_l_list()[var_17_1] then
				var_17_0 = var_17_1
			end
		end

		return var_17_0
	end

	function arg_1_0:__get_broken_png()
		return var_0_8(var_0_7.ship_icon.model_broken_l, self._pic_id, self._pic_id)
	end

	function arg_1_0:__get_spine_sprite(arg_19_1, arg_19_2)
		local var_19_0 = arg_19_2 == nil and (self._logic:judge_is_lowhp(self._now_hp) or self._logic:judge_is_medhp(self._now_hp)) and var_0_7.open_broken or (self._logic:judge_is_lowhp(arg_19_2) or self._logic:judge_is_medhp(arg_19_2)) and var_0_7.open_broken
		local var_19_1
		local var_19_2 = var_0_1.UserData:getKeyData(var_0_7.setting_key_list.setting_broken)

		if var_19_2 ~= "" and var_19_2 ~= " " then
			local var_19_4 = var_0_1.json_decode(var_19_2).value
		end

		local var_19_5 = var_0_1.UserData:getKeyData(var_0_7.setting_key_list.setting_broken)
		local var_19_6 = true

		if var_19_5 ~= "" and var_19_5 ~= " " then
			var_19_6 = var_0_1.json_decode(var_19_5).value
		end

		if var_19_6 ~= "" and var_19_6 ~= " " and type(var_19_6) == "boolean" then
			var_19_6 = var_19_6 or false
		end

		if self._side == var_0_7.character_type.player and self._battle_scene:get_fight_type() ~= gameenum.battle_type.fight_type.plot_main and self._battle_scene:get_fight_type() ~= gameenum.battle_type.fight_type.abyss_2 then
			if self._skin_id == 0 then
				local var_19_7 = var_0_9.find_object_by_cid(self._logic:get_cid())

				if var_19_7 and var_19_7.battle_pic == 0 then
					var_19_1 = var_0_7.ship_icon.model_normal_l

					if var_19_0 and var_19_6 then
						var_19_1 = var_0_7.ship_icon.model_broken_l
					end
				else
					var_19_1 = var_0_7.ship_icon.model_normal_l_battle

					if var_19_0 then
						var_19_1 = var_0_7.ship_icon.model_broken_l
					end
				end
			elseif var_0_11.find_object_by_cid(self._skin_id).battle_pic == 0 then
				var_19_1 = var_0_7.ship_icon.model_normal_l

				if var_19_0 and var_19_6 then
					var_19_1 = var_0_7.ship_icon.model_broken_l
				end
			else
				var_19_1 = var_0_7.ship_icon.model_normal_l_battle

				if var_19_0 then
					var_19_1 = var_0_7.ship_icon.model_broken_l_battle
				end
			end

			if not var_19_6 and self._skin_id == 0 then
				local var_19_8 = var_0_9.find_object_by_cid(self._logic:get_cid())

				var_19_1 = var_19_8 and var_19_8.battle_pic == 0 and var_0_7.ship_icon.model_normal_l or var_0_7.ship_icon.model_normal_l_battle
			elseif not var_19_6 and self._skin_id ~= 0 then
				var_19_1 = var_0_11.find_object_by_cid(self._skin_id).battle_pic == 0 and var_0_7.ship_icon.model_normal_l or var_0_7.ship_icon.model_normal_l_battle
			end
		else
			var_19_1 = self._side == var_0_7.character_type.player and self._battle_scene:get_fight_type() == gameenum.battle_type.fight_type.plot_main and var_19_0 and var_19_6 and var_0_7.ship_icon.model_broken_l or var_0_7.ship_icon.model_normal_l
		end

		local var_19_9 = var_0_8(var_19_1, self._pic_id, self._pic_id)

		if arg_19_1 then
			var_19_9 = var_0_8(var_19_1, arg_19_1, arg_19_1)
		end

		if var_0_12:getIsDownloadPatch("data2") and var_19_6 and string.sub(var_19_9, 9, 22) == "model_normal_l" then
			local var_19_10 = string.gsub(string.gsub(var_19_9, "/ui", ""), "data", "data2")

			if var_0_13:findPath(var_19_10) then
				var_19_9 = var_19_10
			end
		end

		local var_19_11 = self:__cutin_easter_egg(self:__cutin_henshin_skill(var_19_9, var_19_1), var_19_1, self._pic_id)

		if not var_0_13:findPath(var_19_11) then
			var_19_11 = "data/ui/model_normal_l/1/L_NORMAL_1.png"
		end

		return var_19_11
	end

	function arg_1_0.__after_complete_motion(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
		local var_20_0 = arg_20_1.state.Complete

		local function var_20_1()
			if arg_20_4 then
				arg_20_4._is_show_damage_cutin = false
			end

			if arg_20_3 then
				arg_20_3()

				arg_20_3 = nil
			end

			if arg_20_4 then
				arg_20_0._battle_processor:resume_frame()
			end

			arg_20_1.state.Complete = var_20_0

			var_0_3:destroyGameObject(arg_20_2)
		end

		var_20_0 = arg_20_1.state.Complete + var_20_1
		arg_20_1.state.Complete = arg_20_1.state.Complete + var_20_1
		var_20_0 = var_20_0 - var_20_1
	end

	function arg_1_0:__destroy_cutin()
		if self._cutin_gunfire then
			var_0_3:destroyGameObject(self._cutin_gunfire)
		end

		if self._damage_cutin_spine then
			var_0_3:destroyGameObject(self._damage_cutin_spine)
		end

		if self._aircutin_bg then
			var_0_3:destroyGameObject(self._aircutin_bg)
		end

		if self._aircutin_actor then
			var_0_3:destroyGameObject(self._aircutin_actor)
		end

		if self._aircutin_fighter then
			var_0_3:destroyGameObject(self._aircutin_fighter)
		end
	end

	function arg_1_0:__cutin_henshin_skill(arg_23_1, arg_23_2)
		if self._logic:get_attribute().skill_num.ship_henshin_cutin then
			local var_23_0 = self._logic:get_attribute().skill_num.ship_henshin_cutin.now_animation_id
			local var_23_1 = self._logic:get_attribute().skill_num.ship_henshin.now_henshin_cid
			local var_23_2 = self._logic:get_attribute().skill_num.ship_henshin.now_is_skin
			local var_23_3 = self._logic:get_attribute().skill_num.ship_henshin.now_animation_num2

			if self:get_save_stage() and self:get_save_stage() == self._logic:get_attribute().skill_num.ship_henshin_cutin.now_stage then
				if self._logic:get_skin_id() ~= 0 then
					local var_23_4

					if self._pic_id then
						var_23_4 = string.match(tostring(self._pic_id), "_(%d+)$")
						var_23_4 = var_23_4 and tonumber(var_23_4)
					end

					if var_23_2 then
						for iter_23_0, iter_23_1 in pairs(var_23_2) do
							if var_23_4 == iter_23_1 then
								break
							end
						end

						var_23_0 = false and var_23_0 .. "_" .. self._logic:get_attribute().skill_num.ship_henshin.now_animation_num3 or var_23_0 .. "_" .. var_23_3
					else
						var_23_0 = var_23_0 .. "_" .. var_23_3
					end
				else
					var_23_0 = var_23_0 .. "_" .. var_23_3
				end

				if var_23_0 then
					for iter_23_2, iter_23_3 in pairs(var_23_1) do
						if self._logic:get_cid() == iter_23_3 then
							return var_0_8(arg_23_2, var_23_0, var_23_0)
						end
					end

					return arg_23_1
				else
					return arg_23_1
				end
			else
				return arg_23_1
			end
		else
			return arg_23_1
		end
	end

	function arg_1_0.__cutin_easter_egg(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
		if arg_24_3 == "521_3" or arg_24_3 == "521_4" then
			local var_24_0 = var_0_2(1, 100)

			if var_24_0 <= 5 and arg_24_3 == "521_3" then
				arg_24_3 = "521_4"

				return var_0_8(arg_24_2, "521_4", "521_4")
			elseif var_24_0 <= 5 and arg_24_3 == "521_4" then
				arg_24_3 = "521_3"

				return var_0_8(arg_24_2, "521_3", "521_3")
			end
		end

		return arg_24_1
	end
end

function var_0_0.extend_obj(arg_25_0)
	arg_25_0._cutin_spine = nil
	arg_25_0._played_cutin = false
end

return var_0_0
