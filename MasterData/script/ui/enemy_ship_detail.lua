local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = string.format
local var_0_6 = gameconfig.ship_config
local var_0_7 = gameconfig.skin_config
local var_0_8 = gameconfig.robot_config
local var_0_9 = gameconfig.monster_formation_config
local var_0_10 = gameconfig.monster_config
local var_0_11 = gameconfig.ship_rule_config
local var_0_12 = lx.clone_table
local var_0_13 = gameenum.battle_type

gamecore.UILoader:define("enemy_ship_detail", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__init_panel(arg_3_1, arg_3_2)
		var_0_3:set_other_info(arg_3_1)
		self:__init_images()

		local var_3_0 = var_0_11.find_object_by_id(15).content.boatNumMax

		self._datas = arg_3_1

		local var_3_2 = var_0_3:get_maneuver_data_byid(arg_3_1.id)

		self._exercise_id = arg_3_1.id
		self._limit_refresh_count = var_0_4.exercise_count - var_0_3:get_refresh_count()
		self._control.panel_bg.update_bg.update_count.text.text = self._limit_refresh_count
		self._control.panel_bg.update_bg.title.text.text = var_0_1:getNowLang("pvp_left_chance")
		self._control.panel_bg.title_bg.title_text.text.text = var_0_1:getNowLang("pvpoppodetailtitle")
		self._control.panel_bg.left.team_name_mask.team_name.text.text = arg_3_1.name

		self._control.panel_bg.left.team_name_mask:GetComponent("TextHorizonScroller"):SetText(arg_3_1.name)

		self._control.panel_bg.left.team_level.text.text = var_0_5("LV.%d", arg_3_1.level)
		self._control.panel_bg.left.team_logo.image.sprite = self:loadSprite((var_0_5(var_0_4.team_icon, arg_3_1.rank == 0 and 1 or arg_3_1.rank)))
		self._control.panel_bg.left.win_txt.text.text = var_0_1:getNowLang("battleinfopvpwinrate")
		self._control.panel_bg.left.image_txt.text.text = var_0_1:getNowLang("userinfoshipcardfinishrate")
		self._control.panel_bg.bottom_bg.title.text.text = var_0_1:getNowLang("viewotherfleettip")
		self._control.panel_bg.fight_btn.txt.text.text = var_0_1:getNowLang("pvpbtnc")
		self._control.panel_bg.update_btn.updatetext.text.text = var_0_1:getNowLang("ui_refresh")

		if arg_3_1.robot == true then
			self._control.panel_bg.left.win_rate.text.text = "100%"
			self._control.panel_bg.left.image_rate.text.text = "100%"
		else
			self._control.panel_bg.left.win_rate.text.text = arg_3_1.win_rate .. "%"
			self._control.panel_bg.left.image_rate.text.text = math.floor(arg_3_1.collection_rate / var_3_0 * 100) .. "%"
		end

		local var_3_3 = arg_3_1.robot and var_0_9.find_object_by_id(var_0_8.find_object_by_id(arg_3_1.id).npc_formation) or arg_3_1.garrison or {}

		self._all_exercise_info = {}
		self._all_exercise_info = arg_3_1.robot and {
			robot = true,
			exercise_id = var_3_3.formation
		} or {
			robot = true,
			exercise_id = var_3_3
		}
		self._control.panel_bg.bottom_has_finished.title.text.text = var_0_1:getNowLang("viewotherfleettip")
		self._control.panel_bg.bottom_has_finished.score_node.title.text.text = var_0_1:getNowLang("pvpresultdesc")

		if var_3_2 and var_3_2.grade then
			self._control.panel_bg.bottom_has_finished.score_node.score.text.text = var_0_4.rank_sore[var_3_2.grade]
		end

		local var_3_5 = {}

		for iter_3_0 = 1, 6 do
			local var_3_6
			local var_3_7

			if arg_3_1.garrison and next(arg_3_1.garrison) then
				var_3_6 = arg_3_1.garrison[iter_3_0]

				if arg_3_1.garrison[iter_3_0] then
					var_3_7 = var_0_6.find_object_by_cid(var_3_6.cid)
				end
			elseif var_3_3.formation and var_3_3.formation[iter_3_0] then
				var_3_6 = var_0_10.find_object_by_id(var_3_3.formation[iter_3_0])
				var_3_7 = var_0_10.find_object_by_id(var_3_3.formation[iter_3_0])
			end

			local var_3_8 = self._control.panel_bg.right_bg[var_0_5("enemy_ship_item%d", iter_3_0)]

			if var_3_6 then
				local var_3_9 = var_0_12(var_3_6)

				var_3_9.cid = var_3_6.cid or var_3_6.id
				var_3_9.monster_type = arg_3_1.garrison and next(arg_3_1.garrison) and var_0_13.enemy_type.player or var_0_13.enemy_type.monster

				table.insert(var_3_5, var_3_9)

				var_3_8.show_layer.off_set.ship_item.item_icon_mask.quality.image.sprite = self:loadSprite(var_0_4.ship_quality_frame[var_3_7.star])

				local var_3_10

				if var_3_6.skin and var_3_6.skin ~= 0 then
					local var_3_11 = var_0_7.find_object_by_cid(var_3_6.skin).icon

					var_3_10 = var_0_4:get_ship_icon(var_0_4.ship_icon.model_normal_m, tostring(var_3_11), tostring(var_3_11))
				else
					var_3_10 = var_0_4:get_ship_icon(var_0_4.ship_icon.model_normal_m, tostring(var_3_7.pic_id), tostring(var_3_7.pic_id))
				end

				var_3_8.show_layer.off_set.ship_item.item_icon_mask.item_icon.image.sprite = self:loadSprite(var_3_10)
				var_3_8.show_layer.off_set.ship_item.ship_info.bg.type_txt.text.text = var_0_1:getNowLang(var_0_4:get_ship_type_language_key(var_3_7.type, 1))
				var_3_8.show_layer.off_set.ship_item.ship_info.bg.level_txt.text.text = var_0_5("LV.%d", var_3_6.level)
				var_3_8.show_layer.off_set.ship_item.ship_info.bg.level_txt.text.color = var_3_6.level == 110 and Color.New(0.9137254901960784, 0.9137254901960784, 0.03529411764705882) or Color.New(1, 1, 1)
				var_3_8.show_layer.off_set.ship_item.ship_info.bg.country_txt.text.text = var_0_5("(%s)", var_0_1:getNowLang(var_0_4:get_country_language_key(var_3_7.country)))
				var_3_8.show_layer.off_set.ship_item.ship_info.name_bg.ship_name.ship_name_1.text.text = var_3_7.title

				var_3_8.show_layer.off_set.ship_item.ship_info.name_bg.ship_name:GetComponent("TextHorizonScroller"):SetText(var_3_7.title)

				for iter_3_1 = 1, 7 do
					var_3_8.show_layer.off_set.ship_item.ship_info.bg.star_layer[var_0_5("star_%d", iter_3_1)].gameObject:SetActive(iter_3_1 <= var_3_7.star)
				end

				var_3_8.show_layer.off_set.ship_item.ship_info.hp_bar_bg.hp_bar.image.fillAmount = (var_3_6.now_hp or var_3_6.hp) / var_3_6.hp
				var_3_8.show_layer.canvasGroup.alpha = 1
			else
				var_3_8.show_layer.canvasGroup.alpha = 0
			end
		end

		var_0_3:set_exercise_enemy_config_list(var_3_5)

		if not arg_3_2 then
			self:play_in_out_animation(true)
		end

		self:__init_bottom_show()
		self:__init_enemy_ship_detail_order()
	end

	function arg_1_0:__init_images()
		for iter_4_0 = 1, 6 do
			self._control.panel_bg.right_bg["enemy_ship_item" .. iter_4_0].show_layer.off_set.ship_empty.bg.image.sprite = self:loadSprite(var_0_4.fight_prepare_ship_item.ship_empty_bg)
		end
	end

	function arg_1_0:play_in_out_animation(arg_5_1, arg_5_2)
		if arg_5_1 then
			self._control.bg.uITweenSequence:Play(function()
				if arg_5_2 then
					arg_5_2()
				end
			end)
		else
			self._control.bg.uITweenSequence:PlayReverse(function()
				if arg_5_2 then
					arg_5_2()
				end
			end)
		end
	end

	function arg_1_0:_play_into_se(arg_8_1)
		self:playSE(arg_8_1, false)
	end

	function arg_1_0:__onlong_click_event(arg_9_1)
		local var_9_1

		if not self._datas.garrison[arg_9_1] and not self._datas.robot then
			return
		end

		if self._datas.garrison[arg_9_1] then
			local var_9_2 = lx.clone_table(self._datas.garrison[arg_9_1])

			var_9_1 = lx.clone_table(var_0_6.find_object_by_cid(var_9_2.cid))
			var_9_2.lock = false
			var_9_2.name = var_9_1.title
			var_9_2.star = var_9_1.star
			var_9_2.hp = var_9_1.hp
			var_9_2.equipment_num = var_9_1.equipment_num
			var_9_2.exercise_info = self._all_exercise_info
			var_9_2.index = arg_9_1

			var_0_3:set_enter_ship_detail_type(var_0_4.enter_ship_detail_type.captainroom_fleet)
			var_0_2:createInstance("ship_detail"):show(var_0_4.enter_ship_detail_type.single_ship, var_9_2)

			return
		else
			var_9_1 = lx.clone_table(var_0_10.find_object_by_id(((self._datas.garrison and next(self._datas.garrison) or nil) and (self._datas.garrison or var_0_9.find_object_by_id(var_0_8.find_object_by_id(self._datas.id).npc_formation))).formation[arg_9_1]))
		end

		var_0_3:set_enter_ship_detail_type(var_0_4.enter_ship_detail_type.robot_ship)

		var_9_1.equips = var_9_1.equipment
		var_9_1.equipment_num = #var_9_1.equips
		var_9_1.exercise_info = self._all_exercise_info
		var_9_1.index = arg_9_1
		var_9_1.members = {}

		var_0_2:createInstance("ship_detail"):show(var_0_4.enter_ship_detail_type.single_ship, var_9_1, true)
	end

	function arg_1_0:__init_bottom_show()
		local var_10_0 = var_0_3:get_maneuver_data_byid(self._datas.id)

		for iter_10_0, iter_10_1 in pairs({
			self._control.panel_bg.bottom_bg,
			self._control.panel_bg.update_bg,
			self._control.panel_bg.update_btn,
			self._control.panel_bg.fight_btn
		}) do
			if var_10_0 then
				iter_10_1.gameObject:SetActive(not var_10_0.finish)
			end
		end

		if var_10_0 then
			self._control.panel_bg.bottom_has_finished.gameObject:SetActive(var_10_0.finish)
		end
	end

	function arg_1_0:__init_enemy_ship_detail_order()
		local var_11_0 = var_0_2:getInstance("gotofight")
		local var_11_1

		if var_11_0 then
			var_11_1 = var_11_0._panel.transform:GetComponent("Canvas").sortingOrder
		end

		if self._panel.transform:GetComponent("Canvas").sortingOrder == var_11_1 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_11_1 + 1
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_12_0)
	local var_12_0 = var_0_2:class("enemy_ship_detail")

	var_12_0._exercise_id = nil
	var_12_0._datas = nil
	var_12_0._limit_refresh_count = var_0_4.exercise_count
	var_12_0._all_exercise_id = {}

	return var_12_0
end

return var_0_0
