local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = string.format
local var_0_6 = gameconfig.robot_config
local var_0_7 = gameconfig.chat_head_config

gamecore.UILoader:define("exercise_item", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0.find_object_by_avatar(arg_3_0, arg_3_1)
		for iter_3_0, iter_3_1 in pairs((var_0_6.get_sequence())) do
			if iter_3_1.user_avatar == arg_3_1 then
				return iter_3_1
			end
		end
	end

	function arg_1_0:__init_panel(arg_4_1)
		if not arg_4_1 then
			return
		end

		self._data = arg_4_1

		local var_4_0 = var_0_1:get_maneuver_data_byid(arg_4_1.id)
		local var_4_1 = self:find_object_by_avatar(arg_4_1.chat_head)

		if var_4_1 then
			local var_4_3 = var_0_7.find_object_by_cid(var_4_1.user_avatar)

			self._control.bg.bg_btn.user_icon.image.sprite = self:loadSprite(var_4_3 and var_0_5(var_0_4.user_icon, var_4_3.icon) or var_0_5(var_0_4.user_icon, 1))
		end

		if arg_4_1.robot == false then
			self._control.bg.bg_btn.user_icon.image.sprite = self:loadSprite(var_0_5(var_0_4.user_icon, var_0_7.find_object_by_cid(arg_4_1.chat_head).icon))
		end

		self._control.bg.bg_btn.logo.image.sprite = self:loadSprite((var_0_5(var_0_4.team_icon, arg_4_1.rank == 0 and 1 or arg_4_1.rank)))
		self._control.bg.bg_btn.exercise_name.text.text = arg_4_1.name
		self._control.bg.bg_btn.exercise_name.level_text.text.text = var_0_5("(Lv.%d)", arg_4_1.level)
		self._control.bg.bg_btn.desc_text.text.text = arg_4_1.signature

		self._control.bg.bg_btn.fight_btn:SetActive(not var_4_0.finish)
		self._control.bg.bg_btn.score_node:SetActive(var_4_0.finish)

		self._control.bg.bg_btn.fight_btn.text.text.text = var_0_2:getNowLang("pvpbtnc")

		if var_4_0.finish then
			self._control.bg.bg_btn.score_node.title.text.text = var_0_2:getNowLang("pvpresultdesc")
			self._control.bg.bg_btn.score_node.score.text.text = var_0_4.rank_sore[var_4_0.grade]
		end
	end

	function arg_1_0:_play_into_se(arg_5_1)
		self:playSE(arg_5_1, false)
	end

	function arg_1_0.update_exercise_item_panel(arg_6_0, arg_6_1)
		local var_6_0 = var_0_3:getInstance("enemy_ship_detail")

		if var_6_0 then
			var_6_0:__init_panel(arg_6_1, true)
			var_0_1:set_maneuver_target_info(arg_6_1)
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_3:class("exercise_item")

	var_7_0._data = nil

	return var_7_0
end

return var_0_0
