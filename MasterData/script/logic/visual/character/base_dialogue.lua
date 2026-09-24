local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = DG.Tweening.DOTween
local var_0_6 = string.format
local var_0_8 = gameconfig.skin_config
local var_0_9 = UnityEngine.Time
local var_0_10 = gamecore.BattleManager
local var_0_11 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:show_normal_attack_dialogue(arg_2_1)
		if self._atk_dialogue == "" or self._atk_dialogue == "0" then
			if self._night_atk_dialogue == "" or self._night_atk_dialogue == "0" then
				return
			else
				self._atk_dialogue = self._night_atk_dialogue
			end
		end

		self.is_night = true

		if self._battle_scene:get_day_or_night_attack() == gameenum.battle_type.day_or_night.day then
			self.is_night = false
		end

		self.is_break_dialog = false

		self:__show_dialogue(self._atk_dialogue, 1, "atk", arg_2_1)
	end

	function arg_1_0:show_night_attack_dialogue(arg_3_1)
		if self._night_atk_dialogue == "" or self._night_atk_dialogue == "0" then
			return
		end

		self.is_night = true

		if self._battle_scene:get_day_or_night_attack() == gameenum.battle_type.day_or_night.day then
			self.is_night = false
		end

		self.is_break_dialog = false

		self:__show_dialogue(self._night_atk_dialogue, 1, "night_atk", arg_3_1)
	end

	function arg_1_0:show_attack_dialogue(arg_4_1)
		self.is_night = true

		if self._battle_scene:get_day_or_night_attack() == gameenum.battle_type.day_or_night.day then
			self.is_night = false

			self:show_normal_attack_dialogue(arg_4_1)

			return
		end

		self:show_night_attack_dialogue(arg_4_1)
	end

	function arg_1_0.show_torpedo_attack_dialogue(arg_5_0)
		return
	end

	function arg_1_0:update_dialogue()
		if self._dialogue_obj and not self._dialogue_obj:Equals(nil) and not self._dialogue_move then
			if self._submarine_hp_bar and not self._submarine_hp_bar:Equals(nil) and self.is_night then
				self._dialogue_obj.transform.position = self._submarine_hp_bar.transform.position + Vector3(self.dialog_pos_x, -0.5, 0)
			elseif self._submarine_hp_bar and not self._submarine_hp_bar:Equals(nil) and (self.is_rise or self.is_break_dialog) then
				self._dialogue_obj.transform.position = self._submarine_hp_bar.transform.position + Vector3(self.dialog_pos_x, -0.5, 0)
			elseif self._hp_bar and not self._hp_bar:Equals(nil) then
				self._dialogue_obj.transform.position = self._hp_bar.transform.position + Vector3(self.dialog_pos_x, -0.5, 0)
			end

			self.time = 0
		elseif self._dialogue_obj and not self._dialogue_obj:Equals(nil) and self._dialogue_move then
			self.time = self.time or 0
			self.time = var_0_9.deltaTime + self.time

			if self._submarine_hp_bar and not self._submarine_hp_bar:Equals(nil) and self.is_night then
				self._dialogue_obj.transform.position = self._submarine_hp_bar.transform.position + Vector3(self.dialog_pos_x, -0.5, 0)
			elseif self._submarine_hp_bar and not self._submarine_hp_bar:Equals(nil) and (self.is_rise or self.is_break_dialog) then
				self._dialogue_obj.transform.position = self._submarine_hp_bar.transform.position + Vector3(self.dialog_pos_x, -0.5, 0)
			elseif self._hp_bar and not self._hp_bar:Equals(nil) then
				self._dialogue_obj.transform.position = self._hp_bar.transform.position + Vector3(self.dialog_pos_x, -0.5, 0)
			end
		end
	end

	function arg_1_0:show_break_dialogue()
		if self._break_dialogue == "" or self._break_dialogue == "0" then
			return
		end

		self.is_night = true

		if self._battle_scene:get_day_or_night_attack() == gameenum.battle_type.day_or_night.day then
			self.is_night = false
		end

		if self._logic:is_submarine() then
			self.is_break_dialog = true
		end

		self:__show_dialogue(self._break_dialogue, 3, "break")
	end

	function arg_1_0:__init_dialogue()
		local var_8_0 = self._logic:get_ship_cfg()
		local var_8_1 = var_0_8.find_object_by_cid((self._logic:get_skin_id()))
		local var_8_2

		if var_8_1 then
			var_8_2 = var_8_1.cv_id or nil
		end

		if var_8_1 and var_8_2 and var_8_2 ~= "0" and var_8_2 ~= 0 then
			self._atk_dialogue = var_8_1.atk_dialogue
			self._night_atk_dialogue = var_8_1.night_atk_dialogue
			self._break_dialogue = var_8_1.break_dialogue
			self._cur_ship_picid = var_8_1.cv_id
		else
			self._atk_dialogue = var_8_0.atk_dialogue
			self._night_atk_dialogue = var_8_0.night_atk_dialogue
			self._break_dialogue = var_8_0.break_dialogue
			self._cur_ship_picid = var_8_0.pic_id
		end
	end

	function arg_1_0:__show_dialogue(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		self._logic.is_dialog = true

		local var_9_0 = var_0_2:getInstance(var_0_11:get_battle_name())

		if not var_9_0 then
			return
		end

		local var_9_1 = self._logic:get_side()

		self._dialogue_obj = var_0_10:createBattleGameObject("data/prefab/core/dialogue.prefab")

		self._dialogue_obj.transform:SetParent(var_9_0:get_dialogue_root().transform, false)

		local var_9_2 = self._dialogue_obj.transform:GetComponent(typeof(UnityEngine.UI.Text))

		var_9_2.text = arg_9_1

		var_0_10:playBattleCV((var_0_6("%s/%s_%s.mp3", self._cur_ship_picid, self._cur_ship_picid, arg_9_3)))

		if self._side == gameenum.battle_type.obj_side.player then
			self._dialogue_obj.transform.pivot = Vector2(0, 0.5)
			self.dialog_pos_x = 1
		else
			self._dialogue_obj.transform.pivot = Vector2(1, 0.5)
			self.dialog_pos_x = 4
		end

		if self._hp_bar and not self._hp_bar:Equals(nil) then
			self._dialogue_obj.transform.position = self._submarine_hp_bar and not self._submarine_hp_bar:Equals(nil) and self.is_night and self._submarine_hp_bar.transform.position + Vector3(self.dialog_pos_x, -0.5, 0) or (self.is_rise or self.is_break_dialog) and self._submarine_hp_bar.transform.position + Vector3(self.dialog_pos_x, -0.5, 0) or self._hp_bar.transform.position + Vector3(self.dialog_pos_x, -0.5, 0)
		end

		local var_9_4 = self:autoKillDOTween(var_0_3.Sequence())

		var_9_4:AppendInterval(arg_9_2)
		var_9_4:AppendCallback(function()
			if not self._dialogue_obj:Equals(nil) then
				self._dialogue_move = true
			end

			var_9_2:DOFade(0, 0.8):OnComplete(function()
				var_0_10:destroyGameObject(self._dialogue_obj)

				self._dialogue_move = false
			end)
		end)
		var_9_4:Play()
	end

	function arg_1_0:__destroy_dialogue()
		if self._dialogue_obj then
			var_0_10:destroyGameObject(self._dialogue_obj)
		end
	end
end

function var_0_0.extend_obj(arg_13_0)
	arg_13_0.time = 0
end

return var_0_0
