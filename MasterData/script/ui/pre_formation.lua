local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.user
local var_0_6 = gamecore.prompt
local var_0_8 = 5
local var_0_9 = gamecore.util_func

gamecore.UILoader:define("pre_formation", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:__init_data(arg_2_1)
		self:__init_panel()
		self:setVisible(true)
	end

	function arg_1_0.save_team_info_all(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = 0

		var_3_0 = not arg_3_2 and var_0_5:get_current_team() or arg_3_2

		if var_3_0 <= 8 then
			log.print_r(var_3_0, "这个队伍号不是预设编队,不应该走这里")

			return
		end

		var_0_5:req_TeamSave({
			quick = true,
			id = var_3_0,
			members = arg_3_1
		})
	end

	function arg_1_0:refresh_info_list()
		self:__refresh_data_info_list()
	end

	function arg_1_0:exit_pre_formation()
		self:__exit_pre_formation()
	end

	function arg_1_0:get_sub_type()
		return self._sub_type or 0
	end

	function arg_1_0.set_is_from_confirm(arg_7_0, arg_7_1)
		arg_7_0._from_confirm = arg_7_1
	end

	function arg_1_0:team_save_error(arg_8_1)
		self:__team_save_error(arg_8_1)
	end

	function arg_1_0.__init_data(arg_9_0, arg_9_1)
		arg_9_0._params = arg_9_1
		arg_9_0._sub_type = arg_9_1.sub_type
		arg_9_0._enter_team = arg_9_1.enter_team
	end

	function arg_1_0:__init_panel()
		local var_10_0 = var_0_3:getInstance("dock_team")

		if var_10_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_10_0._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		self._now_page_num = 1

		self:__init_text()
		self:_set_now_preteam_index(1)
	end

	function arg_1_0:_set_now_preteam_index(arg_11_1)
		self._control.top_widget.page_index_one.not_image:SetActive(arg_11_1 ~= 1)
		self._control.top_widget.page_index_one.selected_image:SetActive(arg_11_1 == 1)
		self._control.top_widget.page_index_one.number:SetActive(true)
		self._control.top_widget.page_index_two.not_image:SetActive(arg_11_1 ~= 2)
		self._control.top_widget.page_index_two.selected_image:SetActive(arg_11_1 == 2)
		self._control.top_widget.page_index_two.number:SetActive(true)
		self._control.top_widget.page_index_three.not_image:SetActive(arg_11_1 ~= 3)
		self._control.top_widget.page_index_three.selected_image:SetActive(arg_11_1 == 3)
		self._control.top_widget.page_index_three.number:SetActive(true)
		self:__update_team_data_item()
	end

	function arg_1_0:__init_text()
		self._control.top_widget.top_title_text.text.text = var_0_2:getNowLang("pre_formation")
	end

	function arg_1_0:__get_team_data()
		self._all_teams = var_0_5:get_team_group(var_0_4.team_group_type.prepare)

		local var_13_0 = {}

		for iter_13_0, iter_13_1 in pairs(self._all_teams and var_0_9.little_clone(self._all_teams) or {}) do
			var_0_1(var_13_0, iter_13_1)
		end

		return var_13_0
	end

	function arg_1_0:__update_team_data_item()
		local var_14_0 = self:__get_team_data()

		for iter_14_0 = 1, var_0_8 do
			local var_14_1 = self._pre_formation_team_item_list[iter_14_0] or self:loadUI("pre_formation_team_item")

			var_14_1._panel.transform:SetParent(self._control.buttom_weight.teams.Viewport.Content.rectTransform, false)
			var_14_1:show(iter_14_0, var_14_0[iter_14_0 + (self._now_page_num - 1) * 5], self._params, self._now_page_num, self._enter_team)

			self._pre_formation_team_item_list[iter_14_0] = var_14_1
		end
	end

	function arg_1_0:__refresh_data_info_list()
		if self._from_confirm then
			self._from_confirm = false

			self:__exit_pre_formation()

			local var_15_0 = var_0_3:getInstance("fight_prepare")

			if var_15_0 then
				var_15_0:setVisible(true)
			end

			return
		end

		self:__update_team_data_item()
	end

	function arg_1_0:__team_save_error(arg_16_1)
		self._from_confirm = false

		local var_16_0 = ""

		if arg_16_1 == 6 then
			var_16_0 = var_0_2:getNowLang("nosameshipinteam")
		elseif arg_16_1 == 60 then
			var_16_0 = var_0_2:getNowLang("pre_formation_cannot_use")
		elseif arg_16_1 == 16 then
			var_16_0 = var_0_2:getNowLang("pveinexpore")
		elseif arg_16_1 == 146 then
			var_16_0 = var_0_2:getNowLang("noticeshipisinguard")
		end

		local var_16_1 = var_0_3:getInstance("dock_team")

		if var_16_1 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_16_1._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		var_0_6:show(var_16_0)
	end

	function arg_1_0.__exit_pre_formation(arg_17_0)
		var_0_3:destroyInstance("pre_formation")
	end

	function arg_1_0.__onReset(arg_18_0)
		arg_18_0._all_teams = {}
		arg_18_0._from_confirm = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_19_0)
	local var_19_0 = var_0_3:class("pre_formation")

	var_19_0._all_teams = {}
	var_19_0._from_confirm = false
	var_19_0._pre_formation_team_item_list = {}
	var_19_0._allow_mouse_move = true
	var_19_0._preteam_start_pos = nil
	var_19_0._preteam_end_pos = nil
	var_19_0._now_page_num = 1
	var_19_0._enter_team = 1

	gamecore.extend_obj(var_19_0)

	return var_19_0
end

return var_0_0
