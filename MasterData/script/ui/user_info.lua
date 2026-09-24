local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameconfig.chat_head_config
local var_0_5 = gameenum.common_type
local var_0_6 = string.format
local var_0_8 = gameconfig.ship_rule_config
local var_0_9 = gamecore.util_func

gamecore.UILoader:define("user_info", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)

		self._enter_type = arg_2_2

		self:__init_panel(arg_2_1)

		self._panel.transform:GetComponent("Canvas").sortingOrder = 1000
		self._control.info_framework.info_bg.close_button.canvas.sortingOrder = 1001
	end

	function arg_1_0:play_in_animation(arg_3_1)
		self._control.bg_shadw.uITweenSequence:Play(function()
			if arg_3_1 then
				arg_3_1()
			end
		end)
	end

	function arg_1_0:play_out_animation(arg_5_1)
		self._control.bg_shadw.uITweenSequence:PlayReverse(function()
			if arg_5_1 then
				arg_5_1()
			end
		end)
	end

	function arg_1_0.get_user_head_icon(arg_7_0, arg_7_1)
		local var_7_0 = var_0_4.find_object_by_cid(arg_7_1)

		if not var_7_0 then
			return 1
		end

		return var_7_0.icon
	end

	function arg_1_0:__init_panel(arg_8_1)
		local var_8_0
		local var_8_1
		local var_8_2
		local var_8_3
		local var_8_4
		local var_8_5
		local var_8_6
		local var_8_9
		local var_8_10
		local var_8_12
		local var_8_13
		local var_8_14
		local var_8_15
		local var_8_16
		local var_8_17
		local var_8_18
		local var_8_19
		local var_8_20
		local var_8_21

		if not arg_8_1 then
			var_8_1 = var_0_3:get_name()

			local var_8_22 = var_0_3:get_use_info_data()

			var_8_3 = (nil).level

			local var_8_23 = var_0_3:get_user_info()

			var_8_2 = var_0_3:get_account_id()
			var_8_4 = gameconfig.level_config.find_object_by_level((nil).level)
			var_8_5 = var_0_9.dict_lenght(var_0_3:get_character_list())
			var_8_6 = (nil).max_ship
			var_8_10 = (nil).max_equip
			var_8_9 = var_0_3:get_equipment_count()
			var_8_12 = #var_0_3:get_cardbook_ship_list()
			var_8_13 = self:get_user_head_icon((nil).chat_head)
			var_8_14 = var_0_3:get_use_info_data().exploit_rank
			var_8_15 = (nil).exp
			var_8_16 = (nil).map_win
			var_8_17 = (nil).map_total
			var_8_18 = (nil).maneuver_win
			var_8_19 = (nil).maneuver_total
			var_8_20 = (nil).expedition_total
			var_8_21 = (nil).expedition_win
		elseif self._enter_type == var_0_5.user_info_enter_type.cardbook and not arg_8_1._is_friend or self._enter_type == var_0_5.user_info_enter_type.tower and not arg_8_1._is_friend then
			var_8_0 = arg_8_1
			var_8_1 = arg_8_1.name
			var_8_13 = self:get_user_head_icon(arg_8_1.chat_head)
			var_8_3 = arg_8_1.level
			var_8_5 = arg_8_1.ship_count
			var_8_6 = arg_8_1.max_ship
			var_8_12 = arg_8_1.archive_ship
			var_8_9 = arg_8_1.equip
			var_8_10 = arg_8_1.max_equip
			var_8_14 = arg_8_1.rank
			var_8_4 = gameconfig.level_config.find_object_by_level(arg_8_1.level)
			var_8_15 = arg_8_1.exp
			var_8_2 = arg_8_1.account_id
			var_8_16 = arg_8_1.map_win
			var_8_17 = arg_8_1.map_total
			var_8_18 = arg_8_1.maneuver_win
			var_8_19 = arg_8_1.maneuver_total
			var_8_20 = arg_8_1.expedition_total
			var_8_21 = arg_8_1.expedition_win
		else
			var_8_0 = (self._enter_type == var_0_5.user_info_enter_type.tower and arg_8_1._is_friend or self._enter_type == var_0_5.user_info_enter_type.cardbook and arg_8_1._is_friend) and var_0_3:get_friend_info(arg_8_1.account_id) or var_0_3:get_friend_info(arg_8_1)
			var_8_1 = var_8_0.name
			var_8_13 = self:get_user_head_icon(var_8_0.head)
			var_8_3 = var_8_0.level
			var_8_5 = var_8_0.ship
			var_8_6 = var_8_0.max_ship
			var_8_12 = var_8_0.archive_ship
			var_8_9 = var_8_0.equip
			var_8_10 = var_8_0.max_equip
			var_8_14 = var_8_0.exploit
			var_8_4 = gameconfig.level_config.find_object_by_level(var_8_0.level)
			var_8_15 = var_8_0.exp
			var_8_2 = var_8_0.account_id
			var_8_16 = var_8_0.pve.win_count
			var_8_17 = var_8_0.pve.battle_count
			var_8_18 = var_8_0.pvp.win_count
			var_8_19 = var_8_0.pvp.battle_count
			var_8_20 = var_8_0.expedition.battle_count
			var_8_21 = var_8_0.expedition.win_count
		end

		if not var_8_4 then
			return
		end

		local var_8_24 = var_0_8.find_object_by_id(15).content.boatNumMax

		self:play_in_animation()

		self._control.info_framework.user_main_info.player_name.text.text = var_8_1
		self._control.info_framework.user_main_info.lv.text.text = "LV." .. var_8_3
		self._control.info_framework.user_main_info.header_info.img.image.sprite = self:loadSprite(var_0_6(var_0_5.friends_head, var_8_13))
		self._control.info_framework.user_main_info.collection_info.ship_collection.text.text = var_0_1:getNowLang("userinfoshipamount")
		self._control.info_framework.user_main_info.collection_info.ship_number.text.text = var_8_5 .. "/" .. var_8_6
		self._control.info_framework.user_main_info.collection_info.collection.text.text = var_0_1:getNowLang("userinfoshipcardfinishrate")

		if var_8_24 < var_8_12 then
			var_8_12 = var_8_24
		end

		self._control.info_framework.user_main_info.collection_info.collection_rate.text.text = var_8_12 .. "/" .. var_8_24
		self._control.info_framework.user_main_info.collection_info.equipment_collection.text.text = var_0_1:getNowLang("userinfoequipsamount")
		self._control.info_framework.user_main_info.collection_info.equipment_number.text.text = var_8_9 .. "/" .. var_8_10
		self._control.info_framework.user_main_info.rank_group.img.image.sprite = self:loadSprite(var_0_5:get_format_url(var_0_5.common_icon.friend_badge_path, var_8_14))
		self._control.info_framework.user_main_info.rank_group.exp.text.text = var_8_15 .. "/" .. var_8_4.exp

		if var_8_3 >= 251 then
			self._control.info_framework.user_main_info.rank_group.exp.gameObject:SetActive(false)
		end

		self._control.info_framework.user_main_info.main_info_segmentation.slider.value = var_8_15 / var_8_4.exp
		self._control.info_framework.user_main_info.header_info.lv.text.text = var_8_2
		self._control.info_framework.user_main_info.header_info.uid.text.text = var_0_1:get("UID:")
		self._control.info_framework.fight_info.strike_victory_info.victory.text.text = var_0_1:getNowLang("battleinfopvewin")
		self._control.info_framework.fight_info.strike_victory_info.number.text.text = var_8_16
		self._control.info_framework.fight_info.strike_number.strike.text.text = var_0_1:getNowLang("battleinfopvetimes")
		self._control.info_framework.fight_info.strike_number.number.text.text = var_8_17
		self._control.info_framework.fight_info.strike_fail.fail.text.text = var_0_1:getNowLang("battleinfopvefail")
		self._control.info_framework.fight_info.strike_fail.number.text.text = var_8_17 - var_8_16
		self._control.info_framework.fight_info.strike_odds.odds.text.text = var_0_1:getNowLang("battleinfopvewinrate")
		self._control.info_framework.fight_info.strike_odds.number.text.text = var_8_16 == 0 and "0%" or math.floor(var_8_16 * 100 / var_8_17) .. "%"
		self._control.info_framework.fight_info.drill_victory.victory.text.text = var_0_1:getNowLang("battleinfopvpwin")
		self._control.info_framework.fight_info.drill_victory.number.text.text = var_8_18
		self._control.info_framework.fight_info.drill_number.numb.text.text = var_0_1:getNowLang("battleinfopvptimes")
		self._control.info_framework.fight_info.drill_number.number.text.text = var_8_19
		self._control.info_framework.fight_info.drill_fail.fail.text.text = var_0_1:getNowLang("battleinfopvpfail")
		self._control.info_framework.fight_info.drill_fail.number.text.text = var_8_19 - var_8_18
		self._control.info_framework.fight_info.drill_odds.odds.text.text = var_0_1:getNowLang("battleinfopvpwinrate")
		self._control.info_framework.fight_info.drill_odds.number.text.text = var_8_19 == 0 and "0%" or math.floor(var_8_18 * 100 / var_8_19) .. "%"
		self._control.info_framework.fight_info.expedition.expedition.text.text = var_0_1:getNowLang("battleinfoexploretimes")
		self._control.info_framework.fight_info.expedition.number.text.text = var_8_20
		self._control.info_framework.fight_info.expedition_successful.successful.text.text = var_0_1:getNowLang("battleinfoexplorebigwintimes")
		self._control.info_framework.fight_info.expedition_successful.number.text.text = var_8_21
	end

	function arg_1_0:set_head_icon()
		self._control.info_framework.user_main_info.header_info.img.image.sprite = self:loadSprite(var_0_6(var_0_5.friends_head, (self:get_user_head_icon(var_0_3:get_use_info_data().chat_head))))
	end

	function arg_1_0:_play_into_se(arg_10_1)
		self:playSE(arg_10_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_11_0)
	local var_11_0 = var_0_2:class("user_info")

	var_11_0._out = "home"
	var_11_0._enter_type = nil

	gamecore.extend_obj(var_11_0)

	return var_11_0
end

return var_0_0
