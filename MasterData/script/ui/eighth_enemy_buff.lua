local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.user
local var_0_4 = gamecore.util_func
local var_0_5 = gameconfig.pve_eighth_enemy_buff_config

gamecore.UILoader:define("eighth_enemy_buff", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)
		self:__init_panel(arg_3_1)
	end

	function arg_1_0:__init_panel(arg_4_1)
		self._map_id = arg_4_1

		self:__init_language()

		self._panel.transform:GetComponent("Canvas").sortingOrder = 700

		self:__set_enemy_buff_data(arg_4_1)
	end

	function arg_1_0:__init_language()
		self._control.enemy_title.text.text = var_0_2:getNowLang("enemy_level")
		self._control.enemy_buff_txt.text.text = var_0_2:getNowLang("enemy_level_title")
		self._control.enemy_buff_txt.buff_show_txt.text.text = var_0_2:getNowLang("enemy_level_tips")
		self._control.buff_show_txt_2.text.text = var_0_2:getNowLang("workshop_effect")
	end

	function arg_1_0:__set_enemy_buff_data(arg_6_1)
		local var_6_0 = {}

		self._enemy_buff_list = {}

		for iter_6_0, iter_6_1 in pairs((var_0_5.get_sequence())) do
			if iter_6_1.level_id == arg_6_1 then
				table.insert(var_6_0, iter_6_1)
			end
		end

		if var_6_0 and next(var_6_0) then
			table.sort(var_6_0, function(arg_7_0, arg_7_1)
				return arg_7_0.buff_level < arg_7_1.buff_level
			end)
		end

		self._enemy_buff_list = lx.clone_table(var_6_0)

		local var_6_1 = 0
		local var_6_2 = var_0_3:get_eighth_map_info()

		if var_0_4.have_index(var_6_2[self._map_id], "enemy_buff_id") then
			if var_6_2[self._map_id].enemy_buff_id > 0 then
				var_6_1 = var_0_5.find_object_by_id(var_6_2[self._map_id].enemy_buff_id).buff_level
			end
		else
			var_6_1 = 0
		end

		self._control.enemy_buff_txt.enemy_buff_level_txt.text.text = "LV" .. var_6_1

		local var_6_3 = self._control.enemy_list

		for iter_6_2 = 1, 10 do
			var_6_3["level_desc_" .. iter_6_2]:SetActive(false)
		end

		for iter_6_3, iter_6_4 in pairs(self._enemy_buff_list) do
			if iter_6_4.buff_level == iter_6_3 then
				var_6_3["level_desc_" .. iter_6_3]:SetActive(true)

				if iter_6_3 <= var_6_1 then
					var_6_3["level_desc_" .. iter_6_3].text.text = iter_6_3 <= 9 and "<color=#2893F9>" .. "LV" .. iter_6_3 .. ".  " .. iter_6_4.desc .. "</color>" or "<color=#2893F9>" .. "LV" .. iter_6_3 .. "." .. iter_6_4.desc .. "</color>"
					var_6_3["level_desc_" .. iter_6_3].text.color = Color.New(0.75, 0.75, 0.75)
				else
					var_6_3["level_desc_" .. iter_6_3].text.text = iter_6_3 <= 9 and "<color=#999999>" .. "LV" .. iter_6_3 .. ".  " .. iter_6_4.desc .. "</color>" or "<color=#999999>" .. "LV" .. iter_6_3 .. "." .. iter_6_4.desc .. "</color>"
					var_6_3["level_desc_" .. iter_6_3].text.color = Color.New(0.85, 0.85, 0.85)
				end
			end
		end
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_9_0)
		arg_9_0._enemy_buff_list = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_10_0)
	local var_10_0 = var_0_1:class("eighth_enemy_buff")

	var_10_0:__initia_lize()

	var_10_0._map_id = 0

	return var_10_0
end

return var_0_0
