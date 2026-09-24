local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = DamageTextHelper
local var_0_3 = gamecore.ResourceLoader
local var_0_4 = gameenum.common_type
local var_0_5 = string.format
local var_0_6 = DG.Tweening.DOTween
local var_0_7 = gamecore.BattleManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:add_damage_text(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = arg_2_1.damage_info
		local var_2_1 = arg_2_1.damage_info.damage_type
		local var_2_2 = arg_2_1.damage_info.damage

		if not arg_2_1.damage_info.damage_type then
			var_2_1 = 1
		end

		local var_2_3 = tostring(var_2_2)

		if var_2_1 == gameenum.battle_type.damage_type.normal or var_2_1 == gameenum.battle_type.damage_type.crit or var_2_1 == gameenum.battle_type.damage_type.kill then
			var_2_3 = "-" .. ((arg_2_1.damage_info.is_miss or nil) and "")
		end

		if var_2_1 == gameenum.battle_type.damage_type.recover then
			-- block empty
		end

		if arg_2_1.damage_info.is_immune then
			local var_2_5 = tostring(var_2_2)

			if var_2_2 > 0 then
				local var_2_7

				var_2_7 = var_2_5 and "-" .. var_2_5
			end
		end

		if arg_2_1.damage_info.is_dodging then
			-- block empty
		end

		local var_2_9 = Vector3(0.1 * self._battle_random:visualRandRange(-4, 4), 0.1 * self._battle_random:visualRandRange(0, 5), 0)
		local var_2_10 = var_0_1:getInstance(var_0_4:get_battle_name())
		local var_2_17
		local var_2_16
		local var_2_13
		local var_2_12
		local var_2_15
		local var_2_11
		local var_2_14

		if not var_2_10 then
			do return end

			var_2_11 = var_0_7:createBattleGameObject((var_0_3:convertToJP(var_0_4.damage_text, "prefab")))
			var_2_12 = var_2_11.transform:Find("crit")
			var_2_13 = var_2_11.transform:Find("miss")
			var_2_14 = var_2_11.transform:Find("kill")
			var_2_15 = var_2_11.transform:Find("tactics")
			var_2_16 = var_2_11.transform:Find("ricochet")
			var_2_17 = var_2_11:GetComponent(typeof(UnityEngine.UI.Text))

			local var_2_18 = var_2_11:GetComponent(typeof(UnityEngine.CanvasGroup))
		end

		var_2_11.transform:SetParent(var_2_10:get_damage_text_root(), false)

		if not var_2_11:Equals(nil) and self._hp_bar and not self._hp_bar:Equals(nil) then
			var_2_11.transform.position = self._hp_bar.transform.position + Vector3(var_2_9.x, -0.7, 0)
		end

		var_2_17.text = "-" .. arg_2_1.damage_info.damage

		var_2_13.gameObject:SetActive(false)
		var_2_12.gameObject:SetActive(false)
		var_2_14.gameObject:SetActive(false)
		var_2_15.gameObject:SetActive(false)
		var_2_16.gameObject:SetActive(false)

		if arg_2_1.damage_info.is_miss and not arg_2_1.damage_info.is_ricochet then
			var_2_17.text = ""

			var_2_13.gameObject:SetActive(true)
		end

		if arg_2_1.damage_info.is_miss and arg_2_1.damage_info.is_ricochet then
			var_2_17.text = ""

			var_2_16.gameObject:SetActive(true)
		end

		if arg_2_1.damage_info.is_crit then
			var_2_12.gameObject:SetActive(true)

			var_2_17.font = var_0_7:loadBattleFont(var_0_4.damage_font.crit.path)
		end

		if arg_2_1.damage_info.damage_type == gameenum.battle_type.damage_type.kill then
			var_2_14.gameObject:SetActive(true)
		end

		if arg_2_1.damage_info.tactics_id then
			var_2_15.transform:Find("tactics_img").transform:GetComponent("Image").sprite = var_0_7:loadBattleSprite(var_0_5(var_0_4.college_tactics, arg_2_1.damage_info.tactics_id))

			var_2_15.gameObject:SetActive(true)
		end

		local var_2_19 = self:autoKillDOTween(var_0_6.Sequence())

		self._damage_text_num = self._damage_text_num or 0

		var_2_19:AppendInterval(0.01 * self._damage_text_num)
		var_2_19:AppendCallback(function()
			self._damage_text_num = self._damage_text_num + 1

			var_2_17.transform:DOLocalMoveY(10 + 25 * self._damage_text_num, 1):SetRelative(true):OnComplete(function()
				var_2_17.transform:DOLocalMoveY(50, 1.5):SetRelative(true)
			end)
		end)
		var_2_19:AppendInterval(1)
		var_2_19:AppendCallback(function()
			var_2_18:DOFade(0, 1)
		end)
		var_2_19:AppendInterval(1.5 + 0.1 * self._damage_text_num)
		var_2_19:AppendCallback(function()
			if var_0_7 and var_0_7.destroyGameObject then
				var_0_7:destroyGameObject(var_2_11)

				self._damage_text_num = self._damage_text_num - 1
			end
		end)
		var_2_19:Play()

		if var_2_2 > 0 then
			self:set_hp_bar_active(true)
			self:set_submarine_hp_bar_active(true)

			local function var_2_20()
				local var_7_0 = var_0_1:getInstance(var_0_4:get_battle_name()):get_hp_bar_status()

				if arg_2_2 > 0 or var_2_0.is_recover_life or self._is_recover_life then
					self._battle_processor:delay(800, function()
						if self._is_now_dead then
							return
						end

						self:set_hp_bar_active(var_7_0)
						self:set_submarine_hp_bar_active(var_7_0)
					end)
				elseif not self:__check_is_recovery(arg_2_1) then
					self._is_now_dead = true

					self._battle_processor:delay(500, function()
						self:set_hp_bar_active(false)
						self:set_submarine_hp_bar_active(false)
					end)
					self:death_to_undersea(nil, arg_2_3)
				end
			end

			if arg_2_1.damage_info and arg_2_1.damage_info.damage then
				self._logic._reduce_hp = self._logic._reduce_hp or 0
				self._be_damage = self._be_damage or self._logic._reduce_hp
				self._be_damage = self._be_damage + arg_2_1.damage_info.damage
				arg_2_2 = self._logic:get_attribute().hp:get_final_value() - self._be_damage
				arg_2_2 = self._logic:get_attribute().hp:get_final_value() - self._be_damage < 0 and 0 or arg_2_2
			end

			if arg_2_1.damage_info and arg_2_1.damage_info.is_recover_life then
				self._is_recover_life = true
				arg_2_2 = 0
			end

			self:show_damage_cutin(arg_2_2, arg_2_1.step)
			self:update_hp(arg_2_2, var_2_20)
			self:update_submarine_hp(arg_2_2, var_2_20)
			self._battle_processor:update_boss_hp(arg_2_1.damage_info.boss_info, arg_2_3)
		end
	end

	function arg_1_0:__check_is_recovery(arg_10_1)
		local var_10_0
		local var_10_1

		if arg_10_1.step == "aircraft_attack" then
			var_10_0 = self._battle_processor._battlefield._battle_report.air_attack_recovery
		elseif arg_10_1.step == "open_missile_attack" then
			var_10_0 = self._battle_processor._battlefield._battle_report.open_missile_attack_recovery
		elseif arg_10_1.step == "open_antisub_attack" then
			var_10_0 = self._battle_processor._battlefield._battle_report.open_antisub_attack_recovery
		elseif arg_10_1.step == "open_torpedo_attack" then
			var_10_0 = self._battle_processor._battlefield._battle_report.open_torpedo_attack_recovery
		elseif arg_10_1.step == "normal_attack" then
			var_10_1 = arg_10_1.recovery
		elseif arg_10_1.step == "normal_attack2" then
			var_10_1 = arg_10_1.recovery
		elseif arg_10_1.step == "close_torpedo_attack" then
			var_10_0 = self._battle_processor._battlefield._battle_report.close_torpedo_attack_recovery
		elseif arg_10_1.step == "close_missile_attack" then
			var_10_0 = self._battle_processor._battlefield._battle_report.close_missile_attack_recovery
		elseif arg_10_1.step == "night_attack" then
			var_10_1 = arg_10_1.recovery
		end

		if var_10_0 then
			for iter_10_0, iter_10_1 in pairs(var_10_0) do
				if iter_10_1.recovery_id == self._logic:getID() then
					return true
				end
			end
		end

		if var_10_1 and var_10_1.recovery_id == self._logic:getID() then
			return true
		end

		return false
	end

	function arg_1_0:__init_damage_text()
		local var_11_0 = var_0_1:getInstance(var_0_4:get_battle_name())

		if var_11_0 then
			local var_11_1 = var_11_0:get_damage_text_root()

			self._damage_text_helper = var_0_7:createBattleGameObject((var_0_3:convertToJP(var_0_4.damage_text_helper, "prefab")))
			self._damage_text = self._damage_text_helper:GetComponent(typeof(var_0_2))
			self._damage_text_2 = self._damage_text_helper:GetComponent(typeof(var_0_2))

			self._damage_text:SetRoot(var_11_1)
			self._damage_text_2:SetRoot(var_11_1)
		end
	end
end

function var_0_0.extend_obj(arg_12_0)
	arg_12_0._damage_text_helper = nil
	arg_12_0._damage_text = nil
	arg_12_0._damage_text_2 = nil
end

return var_0_0
