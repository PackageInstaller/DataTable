local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.ResourceLoader
local var_0_4 = gameenum.common_type
local var_0_5 = DG.Tweening.DOTween
local var_0_6 = string.format
local var_0_7 = gamecore.BattleManager
local var_0_8 = gameconfig.ship_config
local var_0_9 = gameconfig.skin_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:create_submarine_flag()
		if not self._logic:is_submarine() then
			return
		end

		local var_2_0 = UnityEngine.GameObject.Find("sea/unit/player")
		local var_2_1 = var_0_4.ship_position.player[self._index]
		local var_2_2 = var_0_4.ship_position.player[1]

		if self._side == var_0_4.character_type.enemy then
			var_2_0 = UnityEngine.GameObject.Find("sea/unit/enemy")
			var_2_1 = var_0_4.ship_position.enemy[self._index]
			var_2_2 = var_0_4.ship_position.enemy[1]
		end

		local var_2_3 = var_0_1.clone_table(var_2_1)
		local var_2_4 = Vector3.New(var_2_3.x, var_2_3.y * self._battle_processor._hook, var_2_3.z)
		local var_2_5 = Vector3.New(var_2_2.x, var_2_2.y, var_2_2.z)
		local var_2_6 = UnityEngine.GameObject.Find("UnitCamera")
		local var_2_7 = var_2_6:GetComponent(typeof(UnityEngine.Camera))
		local var_2_8 = self._logic:get_attribute().now_hp.get_final_value(var_2_6) / self._logic:get_attribute().hp:get_final_value() < gameenum.battle_type.hp_ratio_type.medhp

		self._submarine_spine_root = var_0_7:createBattleGameObject("data/battle/prefab/ship_root/ship_root.prefab")
		self._ss_mask = self._submarine_spine_root.transform:Find("mask")
		self._submarine_spine_root.transform.localPosition = Vector3.New(var_2_4.x, var_2_5.y, var_2_4.z)

		self._battle_processor:delay(1500, function()
			self._submarine_spine_root.transform:DOLocalMove(var_2_4, 0.8)
		end)
		self._submarine_spine_root.transform:SetParent(var_2_0.transform, false)

		self._ss_shadow = self._submarine_spine_root.transform:Find("shadow")
		self._ss_fake = self:create_spine(self._pic_id, var_2_8)
		self._ss_fake.transform.localScale = Vector3.New(self._side, 1, 1)
		self._ss_fake.transform.localPosition = Vector3.New(0, -3.5, 0)

		self._ss_fake.transform:SetParent(self._submarine_spine_root.transform, false)
		self._ss_fake:SetActive(false)

		self._ss_fake_skele = self._ss_fake.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

		self._ss_fake_skele.AnimationState:SetAnimation(var_0_4.character_anim_type.normal.priority, var_0_4.character_anim_type.normal.name, var_0_4.character_anim_type.normal.loop)

		self._fake_attack_point = self._submarine_spine_root.transform:Find("attack").gameObject:GetComponent(typeof(Spine.Unity.BoneFollower))
		self._fake_attack_point.skeletonRenderer = self._ss_fake_skele
		self._fake_attack_point.boneName = "Attack_Point"

		local var_2_9 = var_0_2:getInstance(var_0_4:get_battle_name()):get_border_root()

		self._ss_border = var_0_7:createBattleGameObject("data/prefab/core/ss_border.prefab")
		self._ss_border.transform:GetComponent(typeof(UnityEngine.Canvas)).worldCamera = var_2_7
		self._ss_border.transform.localScale = Vector3.New(0.0093, 0.0093, 0)
		self._ss_border.transform.localPosition = Vector3.New(0, 1.1, 0)

		self._ss_border.transform:SetParent(self._submarine_spine_root.transform, false)

		local var_2_10, var_2_11 = self:create_graphic_spine(self._pic_id, var_2_8)
		local var_2_12 = Vector3.New(0, -187, 0)
		local var_2_13 = var_0_8.find_object_by_cid(self._logic:get_cid())

		if self._skin_id and self._skin_id ~= 0 then
			var_2_13 = var_0_9.find_object_by_cid(self._skin_id)
		end

		if var_2_13 and var_2_13.fight_position then
			var_2_10.transform.localPosition = Vector3.New(0 + var_2_13.fight_position[1], -187 + var_2_13.fight_position[2], 0)
		end

		for iter_2_0, iter_2_1 in pairs(var_0_4.ss_remove_border_spine_list) do
			if self._logic:get_cid() == iter_2_0 then
				var_2_10.transform.localPosition = iter_2_1
			end
		end

		var_2_10.transform.localScale = Vector3.New(self._side, 1, 1)

		var_2_10.transform:SetParent(self._ss_border.transform:Find("mask").transform, false)
		var_2_11.AnimationState:SetAnimation(var_0_4.character_anim_type.normal.priority, var_0_4.character_anim_type.normal.name, var_0_4.character_anim_type.normal.loop)

		self._submarine_flag = self._submarine_spine_root.transform:Find("flag")

		self:set_submarine_flagship(self._index == 1)

		self._border_skele = var_2_11

		self:__init_submarine_hp_bar(self._submarine_spine_root)

		if var_0_4:get_is_new_battle() then
			self:__ship_surface_revamp()
		end
	end

	function arg_1_0:__ship_surface_revamp()
		local var_4_0 = self:create_effect({
			path = var_0_4.effect_revamp_battle.path
		}, true, true)

		var_4_0.transform.localScale = Vector3.New(1, 1, 1)
		var_4_0.transform.localPosition = Vector3.New(0, -0.15, 0)

		var_4_0.transform:SetParent(self._submarine_spine_root.transform, false)

		local var_4_1 = var_4_0.transform:Find("above")
		local var_4_2 = var_4_0.transform:Find("surface")
		local var_4_3 = var_4_0.transform:Find("below")

		if var_4_1 then
			var_4_1.gameObject:SetActive(false)
		end

		if var_4_2 then
			var_4_2.gameObject:SetActive(true)
		end

		if var_4_3 then
			var_4_3.gameObject:SetActive(false)
		end

		self._surface_revamp_obj = var_4_0

		local var_4_4 = self._submarine_spine_root.transform:Find("shadow")

		if var_4_4 then
			var_4_4.gameObject:SetActive(false)
		end
	end

	function arg_1_0:set_surface_revamp_active(arg_5_1)
		if self._surface_revamp_obj then
			self._surface_revamp_obj.gameObject:SetActive(arg_5_1)
		end
	end

	function arg_1_0:set_submarine_shadow_active(arg_6_1)
		if not self._ss_shadow then
			return
		end

		self._ss_shadow.gameObject:SetActive(arg_6_1)
	end

	function arg_1_0:set_submarine_flagship(arg_7_1)
		if self._index ~= 1 or not self._submarine_flag then
			return
		end

		self._submarine_flag.gameObject:SetActive(arg_7_1)
	end

	function arg_1_0:set_submarine_flag_active(arg_8_1)
		if not self._ss_border then
			return
		end

		self._ss_border:SetActive(arg_8_1)
	end

	function arg_1_0:fake_play_animation(arg_9_1)
		self._ss_fake_skele.AnimationState:SetAnimation(arg_9_1.priority, arg_9_1.name, arg_9_1.loop)
	end

	function arg_1_0:get_fake_attack_point()
		return self._fake_attack_point.transform
	end

	function arg_1_0:add_periscope_damage_text(arg_11_1)
		local var_11_0 = var_0_2:getInstance(var_0_4:get_battle_name())
		local var_11_6
		local var_11_5
		local var_11_4
		local var_11_3
		local var_11_1
		local var_11_2
		local var_11_7

		if not var_11_0 then
			do return end

			var_11_1 = var_0_7:createBattleGameObject((var_0_3:convertToJP(var_0_4.damage_text, "prefab")))
			var_11_2 = var_11_1.transform:Find("crit")
			var_11_3 = var_11_1.transform:Find("miss")
			var_11_4 = var_11_1.transform:Find("kill")
			var_11_5 = var_11_1.transform:Find("tactics")
			var_11_6 = var_11_1.transform:Find("ricochet")
			var_11_7 = var_11_1:GetComponent(typeof(UnityEngine.UI.Text))
		end

		var_11_1.transform:SetParent(var_11_0:get_periscope_damage_parent(), false)

		var_11_7.text = "-" .. arg_11_1.damage

		var_11_3.gameObject:SetActive(false)
		var_11_2.gameObject:SetActive(false)
		var_11_4.gameObject:SetActive(false)
		var_11_6.gameObject:SetActive(false)
		var_11_5.gameObject:SetActive(false)

		if arg_11_1.is_miss and not arg_11_1.is_ricochet then
			var_11_7.text = ""

			var_11_3.gameObject:SetActive(true)
		end

		if arg_11_1.is_miss and arg_11_1.is_ricochet then
			var_11_7.text = ""

			var_11_6.gameObject:SetActive(true)
		end

		if arg_11_1.is_crit then
			var_11_2.gameObject:SetActive(true)

			var_11_7.font = var_0_7:loadBattleFont(var_0_4.damage_font.crit.path)
		end

		if arg_11_1.damage_type == gameenum.battle_type.damage_type.kill then
			var_11_4.gameObject:SetActive(true)
		end

		if arg_11_1.tactics_id then
			var_11_5.transform:Find("tactics_img").transform:GetComponent("Image").sprite = var_0_7:loadBattleSprite(var_0_6(var_0_4.college_tactics, arg_11_1.tactics_id))

			var_11_5.gameObject:SetActive(true)
		end

		local var_11_8 = self:autoKillDOTween(var_0_5.Sequence())

		var_11_8:AppendCallback(function()
			var_11_7.transform:DOLocalMoveY(100, 0.5):OnComplete(function()
				var_0_7:destroyGameObject(var_11_1)
			end)
		end)
		var_11_8:Play()
	end

	function arg_1_0.__destroy_submarine_sea_flag(arg_14_0)
		return
	end
end

function var_0_0.extend_obj(arg_15_0)
	arg_15_0._ss_border = nil
	arg_15_0._ss_fake = nil
	arg_15_0._ss_fake_skele = nil
	arg_15_0._ss_mask = nil
	arg_15_0._ss_shadow = nil
end

return var_0_0
