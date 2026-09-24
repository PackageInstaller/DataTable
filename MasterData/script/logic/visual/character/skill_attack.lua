local var_0_0 = {}
local var_0_2 = string.format
local var_0_3 = gamecore.BattleManager
local var_0_4 = gameenum.common_type
local var_0_5 = gameenum.battle_type
local var_0_6 = gamecore.UILoader
local var_0_7 = DG.Tweening.DOTween
local var_0_9 = gameconfig.ship_config
local var_0_10 = gameconfig.skin_config
local var_0_11 = gameconfig.skill_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:show_skill_cutin(arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = var_0_4.skill_cutin.player

		if self._side == var_0_4.character_type.enemy then
			var_2_0 = var_0_4.skill_cutin.enemy
		end

		local var_2_1 = var_0_6:getInstance(var_0_4:get_battle_name())
		local var_2_2

		if var_2_1 then
			var_2_2 = var_2_1:get_cutin_root()
		end

		self._skill_cutin = var_0_3:createBattleGameObject((var_0_4:get_final_battle_prefab_path(var_2_0)))

		if arg_2_3 then
			self._skill_cutin.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).skeleton.A = 0
		end

		self._skill_cutin.transform:SetParent(var_2_2.transform, false)

		self._skill_cutin.transform.localScale = Vector3.New(self._side * 100, 100, 100)

		local var_2_3 = self._skill_cutin.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

		if var_2_3.AnimationState then
			var_2_3.AnimationState:ClearTracks()
		end

		local var_2_4 = self._skill_cutin.transform:GetComponent(typeof(ChangeSpineSlot))
		local var_2_5 = var_0_3:loadBattleTexture2D((self:__get_spine_sprite()))

		var_2_4:ChangeSlotWithSpriteName("default", "Actor_picture", var_2_5, false)
		var_2_4:ChangeSlotWithSpriteName("default", "Actor_picture_black", var_2_5, false)
		var_2_4:ChangeSlotWithSpriteName("default", "Skill_name", var_0_3:loadBattleTexture2D((self:__get_skill_name(arg_2_2))), false)

		if var_2_3.AnimationState then
			var_2_3.AnimationState:SetAnimation(var_0_4.skill_cutin.skill_start.priority, var_0_4.skill_cutin.skill_start.name, var_0_4.skill_cutin.skill_start.loop)
		end

		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.skill_se))
		self:__after_complete_motion(var_2_3, self._skill_cutin, arg_2_1)

		if not arg_2_3 then
			self._skill_cutin.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).skeleton.A = 0

			local var_2_6 = self:autoKillDOTween(var_0_7.Sequence())

			self._battle_processor:enqueue_visual(var_2_6)
			var_2_6:AppendInterval(0.1)
			var_2_6:AppendCallback(function()
				self._skill_cutin.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).skeleton.A = 1
			end)
			var_2_6:AppendCallback(function()
				var_2_6:Kill()
			end)
			var_2_6:Play()
		end
	end

	function arg_1_0:syncytium_skill_cutin(arg_5_1, arg_5_2)
		local var_5_1 = {
			[-1] = {},
			{}
		}
		local var_5_2
		local var_5_3

		for iter_5_0, iter_5_1 in pairs((self._battle_obj_mgr:get_ships_by_side(1))) do
			local var_5_4 = self._battle_processor:find_visual(iter_5_1:getID())
			local var_5_5 = var_0_9.find_object_by_cid(var_5_4._logic:get_cid())

			var_5_4._logic:get_attribute().skill_num = var_5_4._logic:get_attribute().skill_num or {}

			local var_5_7

			if var_5_4._skin_id ~= 0 then
				var_5_7 = var_0_10.find_object_by_cid(var_5_4._skin_id)
			end

			if var_5_4._logic:get_attribute().skill_num.couple_cid_list then
				if var_5_4._logic:get_cid() == var_5_4._logic:get_attribute().skill_num.couple_cid_list[1] then
					var_5_2 = var_0_9.find_object_by_cid(var_5_4._logic:get_cid()).pic_id

					if var_5_7 then
						var_5_2 = var_5_7.skin_id
					end
				end

				if var_5_4._logic:get_cid() == var_5_4._logic:get_attribute().skill_num.couple_cid_list[2] then
					var_5_3 = var_0_9.find_object_by_cid(var_5_4._logic:get_cid()).pic_id

					if var_5_7 then
						var_5_3 = var_5_7.skin_id
					end
				end

				var_5_1[var_5_4._logic:get_side()][var_5_4._logic:get_cid()] = var_5_4._now_hp
			end
		end

		for iter_5_2, iter_5_3 in pairs((self._battle_obj_mgr:get_ships_by_side(-1))) do
			local var_5_8 = self._battle_processor:find_visual(iter_5_3:getID())
			local var_5_9 = var_0_9.find_object_by_cid(var_5_8._logic:get_cid())

			var_5_8._logic:get_attribute().skill_num = var_5_8._logic:get_attribute().skill_num or {}

			if var_5_8._logic:get_attribute().skill_num.couple_cid_list then
				var_5_2 = var_0_9.find_object_by_cid(var_5_8._logic:get_attribute().skill_num.couple_cid_list[1]).pic_id
				var_5_3 = var_0_9.find_object_by_cid(var_5_8._logic:get_attribute().skill_num.couple_cid_list[2]).pic_id
				var_5_1[var_5_8._logic:get_side()][var_5_8._logic:get_cid()] = var_5_8._now_hp
			end
		end

		self._double_skill_cutin = var_0_3:createBattleGameObject((var_0_4:get_final_battle_prefab_path(var_0_4.syncytium_skill_cutin.player)))

		self._double_skill_cutin.transform:SetParent(var_0_6:getInstance(var_0_4:get_battle_name()):get_cutin_root().transform, false)

		self._double_skill_cutin.transform.localScale = Vector3.New(125, 125, 125)

		local var_5_11 = self._double_skill_cutin.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

		var_5_11.AnimationState:ClearTracks()

		local var_5_12 = self._double_skill_cutin.transform:GetComponent(typeof(ChangeSpineSlot))
		local var_5_13
		local var_5_14

		for iter_5_4, iter_5_5 in pairs(var_5_1) do
			if iter_5_4 == self._logic:get_side() then
				for iter_5_6, iter_5_7 in pairs(iter_5_5) do
					if iter_5_6 == arg_5_1 then
						var_5_13 = self:__get_spine_sprite(var_5_2, iter_5_7)
					else
						var_5_14 = self:__get_spine_sprite(var_5_3, iter_5_7)
					end
				end
			end
		end

		local var_5_15 = var_0_3:loadBattleTexture2D(var_5_13)
		local var_5_16 = var_0_3:loadBattleTexture2D(var_5_14)

		var_5_12:ChangeSlotWithSpriteName("default", "Skill_name", var_0_3:loadBattleTexture2D((self:__get_skill_name(108))), false)
		var_5_12:ChangeSlotWithSpriteName("default", "Actor_picture", var_5_15, false)
		var_5_12:ChangeSlotWithSpriteName("default", "Actor_picture_black", var_5_15, false)
		var_5_12:ChangeSlotWithSpriteName("default", "Actor_picture_2nd", var_5_16, false)
		var_5_12:ChangeSlotWithSpriteName("default", "Actor_picture_2nd_black", var_5_16, false)
		var_5_11.AnimationState:SetAnimation(var_0_4.syncytium_skill_cutin.skill_start.priority, var_0_4.syncytium_skill_cutin.skill_start.name, var_0_4.syncytium_skill_cutin.skill_start.loop)
		self:__after_complete_motion(var_5_11, self._double_skill_cutin)

		var_5_11.skeleton.A = 0

		local var_5_17 = self:autoKillDOTween(var_0_7.Sequence())

		var_5_17:AppendInterval(0.1)
		var_5_17:AppendCallback(function()
			var_5_11.skeleton.A = 1
		end)
		var_5_17:AppendCallback(function()
			var_5_17:Kill()
		end)
		var_5_17:Play()
	end

	local var_1_0 = {
		"Actor_picture",
		"Actor_picture_black",
		"Actor_picture_2nd",
		"Actor_picture_2nd_black"
	}
	local var_1_1 = 0.6
	local var_1_2 = 0.8
	local var_1_3 = {
		Actor_picture = {
			0,
			0
		},
		Actor_picture_black = {
			0,
			0
		},
		Actor_picture_2nd = {
			0.3688,
			-1.0928
		},
		Actor_picture_2nd_black = {
			0.3688,
			-1.0928
		}
	}
	local var_1_4 = 0

	function arg_1_0:__apply_cutin_pic_scale_offset(arg_8_1, arg_8_2, arg_8_3)
		if not arg_8_1 or not arg_8_2 then
			return
		end

		local var_8_0 = arg_8_1.skeleton

		if not arg_8_1.skeleton then
			return
		end

		local var_8_1 = {}

		for iter_8_0 = 1, #var_1_0 do
			local var_8_2 = var_8_0:FindBone(var_1_0[iter_8_0])

			if var_8_2 then
				var_8_2:SetToSetupPose()

				local var_8_3 = var_1_3[var_1_0[iter_8_0]]
				local var_8_4 = {
					bone = var_8_2
				}

				if var_1_3[var_1_0[iter_8_0]] then
					var_8_4.center_x = var_8_3[1] or 0
				end

				if var_8_3 then
					var_8_4.center_y = var_8_3[2] or 0
				end

				var_8_4.pose_x = var_8_2.X
				var_8_4.pose_y = var_8_2.Y
				var_8_4.pose_sx = var_8_2.ScaleX
				var_8_4.pose_sy = var_8_2.ScaleY
				var_8_4.last = {}
				var_8_1[#var_8_1 + 1] = var_8_4
			end
		end

		if #var_8_1 == 0 then
			return
		end

		arg_8_3 = arg_8_3 or 0
		var_1_4 = var_1_4 + 1

		local var_8_5 = var_1_4

		local function var_8_6()
			if var_8_5 ~= var_1_4 then
				return
			end

			for iter_9_0 = 1, #var_8_1 do
				local var_9_0 = var_8_1[iter_9_0]
				local var_9_1 = var_8_1[iter_9_0].bone
				local var_9_2 = var_8_1[iter_9_0].last
				local var_9_3

				if var_8_1[iter_9_0].last.sx == var_8_1[iter_9_0].bone.ScaleX then
					var_9_3 = var_9_0.pose_sx or var_9_1.ScaleX

					local var_9_4

					if var_9_2.sy == var_9_1.ScaleY then
						var_9_4 = var_9_0.pose_sy or var_9_1.ScaleY
					end
				end

				var_9_1.ScaleX = var_9_3 * arg_8_2
				var_9_1.ScaleY = var_9_4 * arg_8_2
				var_9_2.sx, var_9_2.sy = var_9_1.ScaleX, var_9_1.ScaleY

				if (1 - arg_8_2) * var_9_3 * var_9_0.center_x ~= 0 then
					var_9_1.X = ((var_9_2.x == var_9_1.X or nil) and (var_9_0.pose_x or var_9_1.X)) + (1 - arg_8_2) * var_9_3 * var_9_0.center_x
					var_9_2.x = var_9_1.X
				end

				if (1 - arg_8_2) * var_9_4 * var_9_0.center_y + arg_8_3 * var_9_4 ~= 0 then
					var_9_1.Y = ((var_9_2.y == var_9_1.Y or nil) and (var_9_0.pose_y or var_9_1.Y)) + ((1 - arg_8_2) * var_9_4 * var_9_0.center_y + arg_8_3 * var_9_4)
					var_9_2.y = var_9_1.Y
				end
			end
		end

		if self._cutin_pic_scale_apply then
			self._cutin_pic_scale_apply.skele.UpdateLocal = self._cutin_pic_scale_apply.skele.UpdateLocal - self._cutin_pic_scale_apply.apply
		end

		self._cutin_pic_scale_apply = {
			skele = arg_8_1,
			apply = var_8_6
		}
		arg_8_1.UpdateLocal = arg_8_1.UpdateLocal + var_8_6

		var_8_6()
	end

	function arg_1_0:get_buff_couple_cutin_infos()
		local var_10_0 = self:get_side()
		local var_10_1 = self._battle_obj_mgr:get_ships_by_side(var_10_0)

		if not var_10_1 then
			return {}
		end

		local var_10_2 = {}

		for iter_10_0, iter_10_1 in pairs(var_10_1) do
			table.insert(var_10_2, iter_10_1)
		end

		table.sort(var_10_2, function(arg_11_0, arg_11_1)
			return (arg_11_0:get_index() or 0) < (arg_11_1:get_index() or 0)
		end)

		local var_10_3 = {}

		for iter_10_2, iter_10_3 in pairs(var_10_1) do
			local var_10_4 = self:__get_couple_cutin_ship_cids(iter_10_3)

			if var_10_4 and next(var_10_4) then
				var_10_3[iter_10_3:get_cid()] = true
			end
		end

		local var_10_5 = {}
		local var_10_6 = {}

		for iter_10_4, iter_10_5 in ipairs(var_10_2) do
			local var_10_7, var_10_8 = self:__get_couple_cutin_ship_cids(iter_10_5)

			if var_10_7 and next(var_10_7) then
				local var_10_9
				local var_10_10

				for iter_10_6, iter_10_7 in ipairs(var_10_7) do
					if var_10_3[iter_10_7] then
						if not var_10_9 then
							var_10_9 = iter_10_7
						else
							var_10_10 = iter_10_7

							break
						end
					end
				end

				if var_10_9 and var_10_10 then
					local var_10_11 = tostring(var_10_8) .. "_" .. var_10_9 .. "_" .. var_10_10

					if not var_10_6[var_10_11] then
						var_10_6[var_10_11] = true

						table.insert(var_10_5, {
							cid_one = var_10_9,
							cid_two = var_10_10,
							skill_type = var_10_8,
							source_id = iter_10_5:getID(),
							index = iter_10_5:get_index(),
							side = var_10_0
						})
					end
				end
			end
		end

		return var_10_5
	end

	function arg_1_0:__get_couple_cutin_ship_cids(arg_12_1)
		if not arg_12_1._skill_data then
			return nil
		end

		local var_12_0 = self._battle_scene:get_fight_type() == var_0_5.fight_type.plot_main and var_0_11.find_object_by_skill_id(arg_12_1._skill_data.skill_id) or var_0_11.find_object_by_skill_type_skill_level(arg_12_1._skill_data.skill, arg_12_1._skill_data.skill_level)

		if not var_12_0 or not var_12_0.effect then
			return nil
		end

		for iter_12_0, iter_12_1 in ipairs(var_12_0.effect) do
			for iter_12_2, iter_12_3 in ipairs(iter_12_1.effect or {}) do
				if iter_12_3.type == var_0_5.action_type.buff_couple_cutin then
					return iter_12_3.shipCids, var_12_0.skill_type
				end
			end
		end

		return nil
	end

	function arg_1_0:couple_skill_cutin(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		local var_13_2
		local var_13_3
		local var_13_1
		local var_13_0

		if arg_13_4 and arg_13_4 == arg_13_1 then
			arg_13_2 = arg_13_1
			arg_13_1 = arg_13_2
		end

		for iter_13_0, iter_13_1 in pairs((self._battle_obj_mgr:get_ships_by_side(self:get_side()))) do
			local var_13_4 = self._battle_processor:find_visual(iter_13_1:getID())

			if var_13_4 then
				local var_13_5 = iter_13_1:get_cid()
				local var_13_6 = var_0_9.find_object_by_cid(var_13_5)
				local var_13_7 = var_13_6 and var_13_6.pic_id

				if var_13_4._skin_id ~= 0 then
					local var_13_8 = var_0_10.find_object_by_cid(var_13_4._skin_id)

					if var_13_8 then
						var_13_7 = var_13_8.skin_id
					end
				end

				if var_13_5 == arg_13_1 then
					var_13_0 = var_13_7
					var_13_2 = var_13_4._now_hp
				end

				if var_13_5 == arg_13_2 then
					var_13_1 = var_13_7
					var_13_3 = var_13_4._now_hp
				end
			end
		end

		self._double_skill_cutin = var_0_3:createBattleGameObject((var_0_4:get_final_battle_prefab_path(var_0_4.syncytium_skill_cutin.player)))

		self._double_skill_cutin.transform:SetParent(var_0_6:getInstance(var_0_4:get_battle_name()):get_cutin_root().transform, false)

		self._double_skill_cutin.transform.localScale = Vector3.New(125, 125, 125)

		local var_13_9 = self._double_skill_cutin.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

		var_13_9.AnimationState:ClearTracks()

		local var_13_10 = self._double_skill_cutin.transform:GetComponent(typeof(ChangeSpineSlot))
		local var_13_11 = var_0_3:loadBattleTexture2D((self:__get_spine_sprite(var_13_0, var_13_2)))
		local var_13_12 = var_0_3:loadBattleTexture2D((self:__get_spine_sprite(var_13_1, var_13_3)))

		var_13_10:ChangeSlotWithSpriteName("default", "Skill_name", var_0_3:loadBattleTexture2D((self:__get_skill_name(arg_13_3))), false)
		var_13_10:ChangeSlotWithSpriteName("default", "Actor_picture", var_13_11, false)
		var_13_10:ChangeSlotWithSpriteName("default", "Actor_picture_black", var_13_11, false)
		var_13_10:ChangeSlotWithSpriteName("default", "Actor_picture_2nd", var_13_12, false)
		var_13_10:ChangeSlotWithSpriteName("default", "Actor_picture_2nd_black", var_13_12, false)
		self:__apply_cutin_pic_scale_offset(var_13_9, var_1_1, var_1_2)
		var_13_9.AnimationState:SetAnimation(var_0_4.syncytium_skill_cutin.skill_start.priority, var_0_4.syncytium_skill_cutin.skill_start.name, var_0_4.syncytium_skill_cutin.skill_start.loop)
		self:__after_complete_motion(var_13_9, self._double_skill_cutin)

		var_13_9.skeleton.A = 0

		local var_13_13 = self:autoKillDOTween(var_0_7.Sequence())

		var_13_13:AppendInterval(0.1)
		var_13_13:AppendCallback(function()
			var_13_9.skeleton.A = 1
		end)
		var_13_13:AppendCallback(function()
			var_13_13:Kill()
		end)
		var_13_13:Play()
	end

	function arg_1_0.couple_skill_cutin_list(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		arg_16_1 = arg_16_1 or {}

		local var_16_0 = 0
		local var_16_1 = #arg_16_1

		local function var_16_3()
			if var_16_0 >= var_16_1 then
				if arg_16_2 then
					arg_16_2()
				end

				return
			end

			var_16_0 = var_16_0 + 1

			arg_16_0:couple_skill_cutin(arg_16_1[var_16_0].cid_one, arg_16_1[var_16_0].cid_two, arg_16_1[var_16_0].skill_type)

			if arg_16_3 then
				arg_16_3(arg_16_1[var_16_0])
			end

			local var_17_0 = var_0_7.Sequence()

			arg_16_0._battle_processor:enqueue_visual(var_17_0)
			var_17_0:AppendInterval(var_0_4.buff_step_time.couple_cutin)
			var_17_0:AppendCallback(var_16_3)
			var_17_0:Play()
		end

		;(nil)()
	end

	function arg_1_0.__get_skill_name(arg_18_0, arg_18_1)
		if not arg_18_1 then
			return var_0_2(var_0_4.skill_name, 10)
		end

		return var_0_2(var_0_4.skill_name, arg_18_1)
	end

	function arg_1_0._play_into_se(arg_19_0, arg_19_1)
		var_0_3:playBattleSE(arg_19_1, false)
	end

	function arg_1_0:__destroy_skill_cutin()
		if self._skill_cutin then
			var_0_3:destroyGameObject(self._skill_cutin)
		end

		if self._double_skill_cutin then
			var_0_3:destroyGameObject(self._double_skill_cutin)
		end
	end
end

function var_0_0.extend_obj(arg_21_0)
	return
end

return var_0_0
