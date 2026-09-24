local var_0_0 = {}
local var_0_2 = typeof
local var_0_3 = UnityEngine
local var_0_4 = string.format
local var_0_5 = tostring
local var_0_6 = FilledBarFollowHelper
local var_0_7 = gamecore.BattleManager
local var_0_8 = gamecore.UILoader
local var_0_9 = gameenum.common_type
local var_0_12 = DG.Tweening.DOTween
local var_0_13 = DG.Tweening.Core

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:update_hp(arg_2_1, arg_2_2)
		self._now_hp = arg_2_1

		local var_2_0 = self._logic:get_attribute().hp:get_final_value()

		if not self._foreground_img then
			return
		end

		if self._foreground_img:Equals(nil) then
			return
		end

		self._foreground_img.sprite = var_0_7:loadBattleSprite((var_0_9:get_health_sprite_by_value(arg_2_1 / var_2_0)))

		if self._hp_value and not self._hp_value:Equals(nil) then
			self._hp_value.text = var_0_4(var_0_5(arg_2_1) .. "/" .. var_0_5(var_2_0))
		end

		var_0_12.To(var_0_13.DOSetter_float(function(arg_3_0)
			if not self._foreground_img:Equals(nil) then
				self._foreground_img.fillAmount = arg_3_0
			end
		end), self._foreground_img.fillAmount, arg_2_1 / var_2_0, 0.2)

		if arg_2_2 then
			arg_2_2()
		end
	end

	function arg_1_0:update_submarine_hp(arg_4_1, arg_4_2)
		if not self._submarine_foreground_img then
			return
		end

		local var_4_0 = self._logic:get_attribute().hp:get_final_value()

		self._submarine_foreground_img.sprite = var_0_7:loadBattleSprite((var_0_9:get_health_sprite_by_value(arg_4_1 / var_4_0)))
		self._submarine_hp_value.text = var_0_4(var_0_5(arg_4_1) .. "/" .. var_0_5(var_4_0))

		var_0_12.To(var_0_13.DOSetter_float(function(arg_5_0)
			if not self._submarine_foreground_img:Equals(nil) then
				self._submarine_foreground_img.fillAmount = arg_5_0
			end
		end), self._submarine_foreground_img.fillAmount, arg_4_1 / var_4_0, 0.2)

		if arg_4_2 then
			arg_4_2()
		end
	end

	function arg_1_0:set_hp_bar_active(arg_6_1)
		if self._hp_bar and not self._hp_bar:Equals(nil) then
			self._hp_bar:SetActive(arg_6_1)
		end
	end

	function arg_1_0:set_submarine_hp_bar_active(arg_7_1)
		if self._submarine_hp_bar and not self._submarine_hp_bar:Equals(nil) then
			self._submarine_hp_bar:SetActive(arg_7_1)
		end
	end

	function arg_1_0:__init_hp_bar(arg_8_1)
		local var_8_0 = var_0_8:getInstance(var_0_9:get_battle_name())

		if not var_8_0 then
			return
		end

		local var_8_1 = self._logic:get_ship_cfg()

		if not arg_8_1 then
			self._hp_bar = var_0_7:createBattleGameObject("data/prefab/core/hp_bar.prefab")

			self._hp_bar.transform:SetParent(var_8_0:get_hp_bar_root(), false)
		elseif self._side == var_0_9.character_type.enemy and var_8_1.enemyScale and var_8_1.enemyScale ~= 0 then
			local var_8_2, var_8_3 = self:__find_base_hp()

			if not var_8_3 then
				return
			end
		else
			return
		end

		local var_8_4 = self._hp_bar.transform:Find("ship_type"):GetComponent(var_0_2(var_0_3.UI.Image))
		local var_8_5 = self._logic:get_cid()

		var_8_4.sprite = var_0_7:loadBattleSprite((var_0_9:get_ship_type_img_path(var_8_1.border_id, (self._logic:get_ship_type()))))
		self._foreground_img = self._hp_bar.transform:Find("progress/foreground"):GetComponent(var_0_2(var_0_3.UI.Image))
		self._hp_value = self._hp_bar.transform:Find("value"):GetComponent(var_0_2(var_0_3.UI.Text))

		local var_8_6 = self:get_hp_point()
		local var_8_7 = self._hp_bar:GetComponent(var_0_2(var_0_6))

		if self._side == var_0_9.character_type.enemy and var_8_1.enemyScale and var_8_1.enemyScale ~= 0 then
			local var_8_8, var_8_9 = self:__find_base_hp()

			if var_8_9 then
				if arg_8_1 then
					var_8_7:StopFloat()

					return
				else
					self._head_point.boneName = "base_hp"
					var_8_7.target = var_8_8
					var_8_7.offset = Vector2.New(0, (var_8_1.enemyScale - 1) * 10)

					var_8_7:StartTrace()

					self._mask.transform.localScale = Vector3.New(5 * var_8_1.enemyScale, 5 * var_8_1.enemyScale, 1)
				end
			else
				var_8_7.target = var_8_6

				var_8_7:StartTrace()
			end
		else
			var_8_7.target = var_8_6

			var_8_7:StartTrace()
		end

		local var_8_10 = self._logic:get_attribute()
		local var_8_11 = var_8_10.now_hp:get_final_value()
		local var_8_12 = var_8_10.hp:get_final_value()

		self:update_hp(var_8_11)
		self:set_ignore_break_state(var_8_11 / var_8_12 < 0.5)
	end

	function arg_1_0:__find_base_hp()
		local var_9_0 = self._spine_root.transform:Find("head")

		self._head_point = var_9_0.gameObject:GetComponent(var_0_2(Spine.Unity.BoneFollower))
		self._head_point.skeletonRenderer = self._skeleton_animation

		return var_9_0, (self._head_point.skeletonRenderer.skeleton:FindBone("base_hp"))
	end

	function arg_1_0:__destroy_hp()
		if self._hp_bar then
			var_0_7:destroyGameObject(self._hp_bar)

			self._hp_bar = nil
		end

		if self._submarine_hp_bar then
			var_0_7:destroyGameObject(self._submarine_hp_bar)

			self._submarine_hp_bar = nil
		end
	end

	function arg_1_0.set_ignore_break_state(arg_11_0, arg_11_1)
		arg_11_0._ignore_cutin = arg_11_1
	end

	function arg_1_0:get_ignore_break_state()
		return self._ignore_cutin
	end

	function arg_1_0:__init_submarine_hp_bar(arg_13_1)
		local var_13_0 = var_0_8:getInstance(var_0_9:get_battle_name())

		if not var_13_0 then
			return
		end

		local var_13_1 = self._logic:get_ship_cfg()

		self._submarine_hp_bar = var_0_7:createBattleGameObject("data/prefab/core/hp_bar.prefab")

		self._submarine_hp_bar.transform:SetParent(var_13_0:get_hp_bar_root(), false)

		local var_13_2 = self._logic:get_cid()

		self._submarine_hp_bar.transform:Find("ship_type"):GetComponent(var_0_2(var_0_3.UI.Image)).sprite = var_0_7:loadBattleSprite((var_0_9:get_ship_type_img_path(var_13_1.border_id, (self._logic:get_ship_type()))))
		self._submarine_foreground_img = self._submarine_hp_bar.transform:Find("progress/foreground"):GetComponent(var_0_2(var_0_3.UI.Image))
		self._submarine_hp_value = self._submarine_hp_bar.transform:Find("value"):GetComponent(var_0_2(var_0_3.UI.Text))

		local var_13_3 = self._submarine_hp_bar:GetComponent(var_0_2(var_0_6))

		var_13_3.target = arg_13_1.transform:Find("hp")

		var_13_3:StartTrace()
		self:update_submarine_hp((self._logic:get_attribute().now_hp:get_final_value()))
	end
end

function var_0_0.extend_obj(arg_14_0)
	arg_14_0._hp_bar = nil
	arg_14_0._submarine_hp_bar = nil
	arg_14_0._foreground_img = nil
	arg_14_0._submarine_foreground_img = nil
	arg_14_0._hp_value = nil
	arg_14_0._submarine_hp_value = nil
end

return var_0_0
