local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = string.format
local var_0_6 = table.insert
local var_0_8 = gameconfig.pve_mist_ship_config

gamecore.UILoader:define("nf_result", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__init_panel(arg_3_1)
		self._user_fleet_unit = {
			self._control.left.ship_list.fight_result_ship_1,
			self._control.left.ship_list.fight_result_ship_2,
			self._control.left.ship_list.fight_result_ship_3,
			self._control.left.ship_list.fight_result_ship_4,
			self._control.left.ship_list.fight_result_ship_5
		}

		self._control.right.rank_word:SetActive(false)
		self:__show_user_info()
		self:__show_team_list()
		self:__show_rank(arg_3_1)

		if arg_3_1 == 1 then
			self:_play_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.victory_s))
		elseif arg_3_1 == 2 then
			self:_play_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.victory_a))
		elseif arg_3_1 == 3 then
			self:_play_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.victory_b))
		end

		self._rank = arg_3_1
	end

	function arg_1_0:__show_user_info()
		self._control.top.player_name.text.text = var_0_3:get_name()
		self._control.top.player_level.text.text = var_0_5("Lv.%d", var_0_3:get_use_info_data().level)
		self._control.top.title_txt.text.text = var_0_1:getNowLang("warfinishtitle")
	end

	function arg_1_0:__show_team_list()
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in pairs(var_0_3:get_mist_combat_info().members) do
			var_0_6(var_5_0, (var_0_8.find_object_by_id(iter_5_1)))
		end

		for iter_5_2 = 1, 5 do
			self._user_fleet_unit[iter_5_2].gameObject:SetActive(false)
		end

		for iter_5_3 = 1, #var_5_0 do
			self._user_fleet_unit[iter_5_3].gameObject:SetActive(true)
			self._user_fleet_unit[iter_5_3].ship_flag:SetActive(false)

			self._user_fleet_unit[iter_5_3].ship_level.level_num.text.text = "LV." .. var_5_0[iter_5_3].maxlevel
			self._user_fleet_unit[iter_5_3].ship_name.ship_name_1.text.text = var_5_0[iter_5_3].shipnamecn

			self._user_fleet_unit[iter_5_3].ship_name:GetComponent("TextHorizonScroller"):SetText(var_5_0[iter_5_3].shipnamecn)

			self._user_fleet_unit[iter_5_3].ship.ship_bg.image.sprite = self:loadSprite(var_0_4.ship_attrib_bg[var_5_0[iter_5_3].rarity])
			self._user_fleet_unit[iter_5_3].ship_type.type_name.text.text = var_0_1:getNowLang(var_0_4:get_nf_ship_type_language_key(var_5_0[iter_5_3].shiptype))
			self._user_fleet_unit[iter_5_3].ship.ship_icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.ship_icon.model_normal_s, var_5_0[iter_5_3].pic_id))
			self._user_fleet_unit[iter_5_3].ship_hp.hp_bar.image.fillAmount = 1
			self._user_fleet_unit[iter_5_3].ship_hp.hp_bar.image.sprite = self:loadSprite(var_0_4.battle_settlement_hp_normal)
		end

		self._user_fleet_unit[1].ship_flag:SetActive(true)

		self._control.left.fleet_name.text.text = var_0_1:getNowLang("selffleet")
	end

	function arg_1_0:__show_rank(arg_6_1)
		local var_6_0 = "rank_S"

		for iter_6_0, iter_6_1 in pairs(var_0_4.rank_mist_score) do
			if iter_6_0 == arg_6_1 then
				var_6_0 = var_0_5("rank_%s", iter_6_1)
			end
		end

		self:__play_animation(self._control.right.rank, var_6_0, false)
	end

	function arg_1_0.__play_animation(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		arg_7_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_7_2, arg_7_3)
	end

	function arg_1_0:_play_se(arg_8_1)
		self:playSE(arg_8_1, false)
	end

	function arg_1_0:_play_audio(arg_9_1, arg_9_2)
		self:playBackgroundMusic(arg_9_1, arg_9_2)
	end

	function arg_1_0.__onReset(arg_10_0)
		arg_10_0._rank = 1
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_11_0)
	return (var_0_2:class("nf_result"))
end

return var_0_0
