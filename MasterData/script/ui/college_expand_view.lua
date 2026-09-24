local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.Language
local var_0_7 = string.format
local var_0_10 = gameenum.common_type

gamecore.UILoader:define("college_expand_view", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:update_class_data()
		self:__get_class_info_by_sever()
		self:__show_open_new_class_prompt()
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
		end

		self:__reset_panel_info()
		self:__get_class_info_by_sever()

		self._is_already_init = true
	end

	function arg_1_0:__get_class_info_by_sever()
		self._now_class_open_table = var_0_1:get_class_total_info()

		self:__update_current_class_data()
	end

	function arg_1_0:__init_language()
		self._control.base_panel.title.text.text = var_0_4:getNowLang("schoolexpand")
		self._control.parent.expand_btn.txt.text.text = var_0_4:getNowLang("expantion")
		self._control.parent.expand_des.text.text = var_0_4:getNowLang("schoolexpandtip")
		self._control.parent.expand_state.text.text = var_0_4:getNowLang("ui_expantioncount")
		self._control.parent.detail_panel.class_one.text.text = var_0_4:getNowLang("classone")
		self._control.parent.detail_panel.class_two.text.text = var_0_4:getNowLang("classtwo")
		self._control.parent.detail_panel.class_three.text.text = var_0_4:getNowLang("classthree")

		for iter_6_0 = 1, self._control.parent.detail_panel.transform.childCount do
			local var_6_0 = self._control.parent.detail_panel.transform:GetChild(iter_6_0 - 1)
			local var_6_1 = {}

			var_6_1.not_open = var_6_0:Find("not_open"):GetComponent("Text")
			var_6_1.class_progress = var_6_0:Find("class_progress"):GetComponent("Text")
			self._now_class_open_state_table[iter_6_0] = var_6_1
			self._now_class_open_state_table[iter_6_0].not_open.text = var_0_4:getNowLang("notopen")
		end
	end

	function arg_1_0:__update_current_class_data()
		for iter_7_0, iter_7_1 in pairs(self._now_class_open_table) do
			self._now_class_open_state_table[iter_7_0].not_open.gameObject:SetActive(false)
			self._now_class_open_state_table[iter_7_0].class_progress.gameObject:SetActive(true)

			self._now_class_open_state_table[iter_7_0].class_progress.text = var_0_7("%s/%s", #iter_7_1.seat, var_0_10.college_const.seat_max_num)
		end
	end

	function arg_1_0:__reset_panel_info()
		for iter_8_0, iter_8_1 in pairs(self._now_class_open_state_table) do
			self._now_class_open_state_table[iter_8_0].not_open.gameObject:SetActive(true)
			self._now_class_open_state_table[iter_8_0].class_progress.gameObject:SetActive(false)
		end
	end

	function arg_1_0:__get_expand_need_diamond()
		local var_9_0 = 0
		local var_9_1 = false

		for iter_9_0, iter_9_1 in pairs(self._now_class_open_table) do
			if #iter_9_1.seat < var_0_10.college_const.seat_max_num then
				var_9_0 = var_0_10.college_const.diamond_cost_min
				var_9_1 = false
			else
				var_9_0 = var_0_10.college_const.diamond_cost_max
				var_9_1 = true
			end
		end

		if #var_0_1:get_class_total_info() == var_0_10.college_const.class_max_num then
			for iter_9_2, iter_9_3 in pairs(self._now_class_open_table) do
				var_9_0 = var_0_10.college_const.diamond_cost_min
				var_9_1 = #iter_9_3.seat >= var_0_10.college_const.seat_max_num
			end
		end

		return var_9_0, var_9_1
	end

	function arg_1_0:__show_open_new_class_prompt()
		local var_10_0 = 0
		local var_10_1 = var_0_3:getInstance("school")

		if var_10_1 then
			var_10_1:update_data()
			var_10_1:update_class_chair_data()
		end

		for iter_10_0, iter_10_1 in pairs(self._now_class_open_table) do
			var_10_0 = var_10_0 + #iter_10_1.seat
		end

		if var_10_0 == var_0_10.college_const.second_class_seat then
			self:__show_prompt_panel(1)
		elseif var_10_0 == var_0_10.college_const.third_class_seat then
			self:__show_prompt_panel(2)
		end
	end

	function arg_1_0.__show_prompt_panel(arg_11_0, arg_11_1)
		var_0_3:createInstance("reward_tip"):show(arg_11_1, var_0_10.enter_get_ship_type.school_panel)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_12_0)
	local var_12_0 = var_0_3:class("college_expand_view")

	var_12_0._is_already_init = false
	var_12_0._now_class_open_table = {}
	var_12_0._now_class_open_state_table = {}

	return var_12_0
end

return var_0_0
