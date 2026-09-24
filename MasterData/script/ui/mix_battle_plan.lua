local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameconfig.pve_mix_buff_config
local var_0_3 = table.insert
local var_0_5 = gamecore.Language
local var_0_6 = string.format
local var_0_7 = gameenum.common_type
local var_0_8 = gamecore.user
local var_0_9 = gamecore.prompt
local var_0_10 = gameconfig.pve_eighth_buff_config
local var_0_11 = 12
local var_0_12 = {
	{
		-250,
		0
	},
	{
		-60,
		0
	},
	{
		130,
		0
	},
	{
		320,
		0
	}
}
local var_0_14 = {
	Locked = 0,
	Activated = 3,
	Unactivated = 1,
	UnactivatedSelected = 2,
	ActivatedSelected = 4
}
local var_0_15 = {
	Unactivated = UnityEngine.Color.New(0.2, 0.2, 0.2),
	Activated = UnityEngine.Color.New(0.9607843137254902, 1, 0),
	ActivatedSelected = UnityEngine.Color.New(0, 1, 1)
}
local var_0_16 = {
	White = UnityEngine.Color.New(1, 1, 1),
	Grey = UnityEngine.Color.New(0.8117647058823529, 0.8117647058823529, 0.8117647058823529)
}
local var_0_17 = {
	id = 0,
	obj = {},
	control = {},
	config = {},
	data = {},
	state = var_0_14.Locked,
	new = function(arg_1_0, arg_1_1)
		arg_1_1 = arg_1_1 or {}

		setmetatable(arg_1_1, arg_1_0)

		arg_1_0.__index = arg_1_0
		arg_1_0.id = 0
		arg_1_0.obj = {}
		arg_1_0.control = {}
		arg_1_0.config = {}
		arg_1_0.data = {}
		arg_1_0.state = var_0_14.Locked

		return arg_1_1
	end
}

gamecore.UILoader:define("mix_battle_plan", function(arg_2_0)
	function arg_2_0.__onUpdate(arg_3_0)
		return
	end

	function arg_2_0:show(arg_4_1)
		self:setVisible(true)
		self:__init_panel(arg_4_1)
	end

	function arg_2_0:__init_panel(arg_5_1)
		if arg_5_1 then
			self._activity_num = arg_5_1
		end

		self:__init_language()
		self:__init_sprite()
		self:__init_const()
		self:__init_buff_detail_data_list()
		self:__update_buff_data()
		self:__update_buff_point()
		self:__onToggle_middle_buff_entrance_root_buff_entrance_1()
	end

	function arg_2_0:__init_language()
		self._control.title.text.text = var_0_5:getNowLang("7th_buff")
		self._control.buff_entrance_1.Text.text.text = var_0_5:getNowLang("shipton3")
		self._control.buff_entrance_2.Text.text.text = var_0_5:getNowLang("shipton2")
		self._control.buff_entrance_3.Text.text.text = var_0_5:getNowLang("shipton1")
		self._control.reset.Text.text.text = var_0_5:getNowLang("campaignreset")
		self._control.cur_have_point_text.text.text = var_0_5:getNowLang("7th_buff_point")
		self._control.buff_name_text.text.text = var_0_5:getNowLang("7th_buff_name")
		self._control.buff_active.Text.text.text = var_0_5:getNowLang("skillupgrade")
		self._control.buff_desc_title.text.text = var_0_5:getNowLang("card_attribute")
		self._control.full_level_text.text.text = var_0_5:getNowLang("workshop_max_grade")
		self._control.buff_desc_title.text.text = var_0_5:getNowLang("workshop_effect")
	end

	function arg_2_0.__init_sprite(arg_7_0)
		return
	end

	function arg_2_0:__init_const()
		self._toggle_list = {
			self._control.buff_entrance_1,
			self._control.buff_entrance_2,
			self._control.buff_entrance_3
		}
	end

	function arg_2_0:__init_buff_detail_data_list()
		for iter_9_0 = 1, var_0_11 do
			local var_9_0 = var_0_17:new()

			var_0_3(self._buff_detail_data_list, var_9_0)
			self:__init_buff_item_prefab(var_9_0)
			self:__init_buff_detail_data_config(var_9_0, iter_9_0)
			self:__init_buff_item_prefab_position(var_9_0, iter_9_0)
			self:__register_buff_item_button_event(var_9_0)
		end
	end

	function arg_2_0:__init_buff_detail_data_config(arg_10_1, arg_10_2)
		local var_10_0

		if arg_10_2 <= 4 then
			var_10_0 = var_0_7.seventh_buff_id.ship_ton_1[arg_10_2]
		elseif arg_10_2 > 4 and arg_10_2 <= 8 then
			var_10_0 = var_0_7.seventh_buff_id.ship_ton_2[arg_10_2 - 4]
		else
			local var_10_1

			if arg_10_2 > 8 then
				var_10_0 = var_0_7.seventh_buff_id.ship_ton_3[arg_10_2 - 8]
				var_10_1 = tonumber
			end
		end

		local var_10_2 = var_10_1(var_10_0 .. (var_10_0 == (1001 or 2001 or 3001) and "00" or "01"))
		local var_10_3 = self._activity_num == 8 and var_0_10.find_object_by_id(var_10_2) or self._activity_num == 7 and var_0_2.find_object_by_id(var_10_2) or var_0_10.find_object_by_id(var_10_2)

		arg_10_1.config = var_10_3

		self:__init_buff_item_prefab_image(arg_10_1, var_10_3.buff_icon)
	end

	function arg_2_0:__init_buff_item_prefab_image(arg_11_1, arg_11_2)
		arg_11_1.control.buff_icon.image.sprite = self:loadSprite((var_0_6(var_0_7.pve_active_buff_image, arg_11_2)))
	end

	function arg_2_0:__init_buff_item_prefab(arg_12_1)
		local var_12_0, var_12_1 = self:loadUIPrefab("mix_buff_item", self._control.buff_item_root.transform)

		var_12_0:setVisible(true)

		arg_12_1.obj = var_12_0
		arg_12_1.control = var_12_1
	end

	function arg_2_0.__init_buff_item_prefab_position(arg_13_0, arg_13_1, arg_13_2)
		arg_13_1.obj._panel:GetComponent("RectTransform").anchoredPosition = Vector2(var_0_12[(arg_13_2 - 1) % 4 + 1][1], var_0_12[(arg_13_2 - 1) % 4 + 1][2])
	end

	function arg_2_0.__register_buff_item_button_event(arg_14_0, arg_14_1)
		arg_14_1.control.buff_icon.button.onClick:RemoveAllListeners()
		arg_14_1.control.buff_icon.button.onClick:AddListener(arg_14_1.state ~= var_0_14.Locked and function()
			arg_14_0._cur_selected_buff_id = arg_14_1.id

			if arg_14_1.state == var_0_14.Unactivated then
				arg_14_1.state = var_0_14.UnactivatedSelected
			elseif arg_14_1.state == var_0_14.Activated then
				arg_14_1.state = var_0_14.ActivatedSelected
			end

			arg_14_0:__record_ship_ton_click_record(arg_14_1)
			arg_14_0:show_buff_detail(arg_14_1)
		end or function()
			var_0_9:show(var_0_5:getNowLang("7th_buff_activation_fail"))
		end)
	end

	function arg_2_0:__record_ship_ton_click_record(arg_17_1)
		if self._cur_ship_ton_buff_index == 3 then
			self._ship_ton_click_record.large = arg_17_1
		elseif self._cur_ship_ton_buff_index == 2 then
			self._ship_ton_click_record.middle = arg_17_1
		elseif self._cur_ship_ton_buff_index == 1 then
			self._ship_ton_click_record.little = arg_17_1
		end
	end

	function arg_2_0:reset_record_ship_ton_click_record()
		self:__reset_record_ship_ton_click_record()
	end

	function arg_2_0:__reset_record_ship_ton_click_record()
		self._ship_ton_click_record.large = nil
		self._ship_ton_click_record.middle = nil
		self._ship_ton_click_record.little = nil
	end

	function arg_2_0:update_buff_data()
		self:__update_buff_data()
	end

	function arg_2_0:__update_buff_data()
		if self._activity_num == 7 then
			for iter_21_0 = 1, var_0_11 do
				local var_21_0 = var_0_8:get_cur_seventh_buff_max_level_id(self._buff_detail_data_list[iter_21_0].config.buff_id)

				self._buff_detail_data_list[iter_21_0].id = var_21_0
				self._buff_detail_data_list[iter_21_0].config = var_0_2.find_object_by_id(var_21_0)
			end
		else
			for iter_21_1 = 1, var_0_11 do
				local var_21_1 = var_0_8:get_cur_eighth_buff_max_level_id(self._buff_detail_data_list[iter_21_1].config.buff_id)

				self._buff_detail_data_list[iter_21_1].id = var_21_1
				self._buff_detail_data_list[iter_21_1].config = var_0_10.find_object_by_id(var_21_1)
			end
		end
	end

	function arg_2_0:update_buff_item_display(arg_22_1)
		self:__update_buff_item_display(arg_22_1)
	end

	function arg_2_0:__update_buff_item_display(arg_23_1)
		local var_23_0 = {}

		var_23_0 = self._activity_num == 7 and var_0_8:get_seventh_buff_list() or var_0_8:get_eighth_buff_list()

		for iter_23_0, iter_23_1 in pairs(self._buff_detail_data_list) do
			local var_23_1 = var_0_14.Locked

			iter_23_1.obj:setVisible(iter_23_1.config.buff_type == self._cur_ship_ton_buff_index)

			if iter_23_1.config.need_id == 0 then
				var_23_1 = var_0_14.Unactivated
			end

			if not arg_23_1 then
				for iter_23_2, iter_23_3 in pairs(var_23_0) do
					if iter_23_3 == iter_23_1.config.need_id and var_23_1 == var_0_14.Locked then
						var_23_1 = var_0_14.Unactivated
					end

					if iter_23_1.id == iter_23_3 then
						var_23_1 = var_0_14.Activated

						break
					end
				end

				if iter_23_1.state ~= var_0_14.ActivatedSelected then
					if iter_23_1.state == var_0_14.UnactivatedSelected then
						var_23_1 = var_0_14.ActivatedSelected
					end

					iter_23_1.state = var_23_1
				end
			else
				iter_23_1.state = var_23_1
			end

			iter_23_1.control.lock_image:SetActive(iter_23_1.state == var_0_14.Locked)
			iter_23_1.control.level_upgrade:SetActive(iter_23_1.state ~= var_0_14.Locked and self._buff_point > 0 and not self:__check_if_cur_buff_is_max_buff(iter_23_1.id))
			self:__update_buff_icon_display(iter_23_1)
		end
	end

	function arg_2_0:__update_buff_icon_display(arg_24_1, arg_24_2)
		local var_24_0
		local var_24_1

		if arg_24_2 then
			for iter_24_0, iter_24_1 in pairs(self._buff_detail_data_list) do
				if iter_24_1.id ~= self._cur_selected_buff_id then
					if iter_24_1.state == var_0_14.UnactivatedSelected then
						iter_24_1.state = var_0_14.Unactivated
					elseif iter_24_1.state == var_0_14.ActivatedSelected then
						iter_24_1.state = var_0_14.Activated
					end

					self:__update_buff_icon_display(iter_24_1)
				end
			end
		end

		if arg_24_1.state == var_0_14.Locked or arg_24_1.state == var_0_14.Unactivated then
			var_24_0 = var_0_15.Unactivated
		elseif arg_24_1.state == var_0_14.UnactivatedSelected then
			var_24_0 = var_0_15.Unactivated
			var_24_1 = var_0_7.seventh_buff_select_frame.selected
		elseif arg_24_1.state == var_0_14.Activated then
			var_24_0 = var_0_15.Activated
			var_24_1 = var_0_7.seventh_buff_select_frame.unselected
		elseif arg_24_1.state == var_0_14.ActivatedSelected then
			var_24_0 = var_0_15.ActivatedSelected
			var_24_1 = var_0_7.seventh_buff_select_frame.selected
		end

		self:__register_buff_item_button_event(arg_24_1)
		arg_24_1.control.activation_select_frame:SetActive(arg_24_1.state == var_0_14.Activated or arg_24_1.state == var_0_14.ActivatedSelected)

		arg_24_1.control.activation_select_frame.image.sprite = self:loadSprite(var_24_1)

		arg_24_1.control.activation_select_state:SetActive(arg_24_1.state == var_0_14.ActivatedSelected or arg_24_1.state == var_0_14.UnactivatedSelected)
		arg_24_1.control.buff_level_image:SetActive(arg_24_1.state == var_0_14.Activated or arg_24_1.state == var_0_14.ActivatedSelected)
		arg_24_1.control.level_text:SetActive(arg_24_1.state == var_0_14.Activated or arg_24_1.state == var_0_14.ActivatedSelected)

		if arg_24_1.id % 100 >= 2 then
			if self._activity_num == 7 then
				var_0_8:set_mix_battle_plan_level(arg_24_1.id % 100, var_0_2.find_object_by_id(arg_24_1.id).order)
			else
				var_0_8:set_eighth_battle_plan_level(arg_24_1.id % 100, var_0_10.find_object_by_id(arg_24_1.id).order)
			end
		end

		arg_24_1.control.level_text.text.text = var_0_6("LV%d", arg_24_1.id % 100)
		arg_24_1.control.buff_icon.image.color = var_24_0

		local var_24_2 = self:__check_if_cur_buff_is_max_buff(self._cur_selected_buff_id)

		self._control.need_buff_point:SetActive(not var_24_2)
		self._control.buff_active:SetActive(not var_24_2)
		self._control.full_level_text:SetActive(var_24_2)
	end

	function arg_2_0:__check_if_cur_buff_is_max_buff(arg_25_1)
		local var_25_0 = tonumber(arg_25_1) + 1
		local var_25_1
		local var_25_2

		if self._activity_num == 7 then
			var_25_1 = var_0_2.find_object_by_id(var_25_0)
			var_25_2 = var_0_8:check_if_seventh_buff_id_is_unlocked(arg_25_1)
		else
			var_25_1 = var_0_10.find_object_by_id(var_25_0)
			var_25_2 = var_0_8:check_if_eighth_buff_id_is_unlocked(arg_25_1)
		end

		return not not (not var_25_1 and var_25_2)
	end

	function arg_2_0:__update_buff_point()
		self._buff_point = self._activity_num == 7 and var_0_8:get_seventh_buff_point() or var_0_8:get_eighth_buff_point()
		self._control.point_text.text.text = self._buff_point
	end

	function arg_2_0:update_buff_point()
		self:__update_buff_point()
	end

	function arg_2_0:show_buff_detail(arg_28_1)
		self._control.buff_detail:SetActive(true)

		self._control.buff_title.text.text = arg_28_1.config.title

		local var_28_0 = var_0_5:convert_rich_text(arg_28_1.config.effect_desc)

		self._control.buff_desc.text.text = arg_28_1.state == var_0_14.UnactivatedSelected and var_28_0 .. "(" .. var_0_5:getNowLang("skillnotopened") .. ")" or var_28_0

		self:__update_buff_icon_display(arg_28_1, true)
	end

	function arg_2_0:__check_if_activated(arg_29_1)
		local var_29_0 = false

		if self._activity_num == 7 then
			for iter_29_0, iter_29_1 in pairs(var_0_8:get_seventh_buff_list()) do
				if iter_29_1 == arg_29_1 then
					var_29_0 = true
				end
			end
		else
			for iter_29_2, iter_29_3 in pairs(var_0_8:get_eighth_buff_list()) do
				if iter_29_3 == arg_29_1 then
					var_29_0 = true
				end
			end
		end

		return var_29_0
	end

	function arg_2_0:__seng_reset_buff_req()
		local var_30_0 = var_0_1:getInstance("msgbox") or var_0_1:createInstance("msgbox")

		if self._activity_num == 7 then
			var_30_0:show(var_0_5:getNowLang("7th_buff_reset"), function()
				var_0_8:req_SeventhResetBuffReq()
			end, function()
				var_30_0:setVisible(false)
			end, var_0_5:getNowLang("ui_tower_reset_title"))
		else
			var_30_0:show(var_0_5:getNowLang("7th_buff_reset"), function()
				var_0_8:req_EighthResetBuffReq()
			end, function()
				var_30_0:setVisible(false)
			end, var_0_5:getNowLang("ui_tower_reset_title"))
		end
	end

	function arg_2_0:__send_buff_active_req()
		local var_35_0

		if self._activity_num == 7 then
			var_35_0 = self:__get_need_upgrade_buff_id()

			if var_0_2.find_object_by_id(var_35_0) then
				function success_upgrade_func()
					self._cur_selected_buff_id = var_35_0
				end

				var_0_8:Set_SeventhUpgradeBuffReq_CallBackFunc(success_upgrade_func)
				var_0_8:req_SeventhUpgradeBuffReq(var_35_0)
			end
		else
			var_35_0 = self:__get_need_upgrade_buff_id()

			if var_0_10.find_object_by_id(var_35_0) then
				function success_upgrade_func()
					self._cur_selected_buff_id = var_35_0
				end

				var_0_8:Set_EighthUpgradeBuffReq_CallBackFunc(success_upgrade_func)
				var_0_8:req_EighthUpgradeBuffReq(var_35_0)
			end
		end
	end

	function arg_2_0:__get_need_upgrade_buff_id()
		local var_38_0 = false

		if self._activity_num == 7 then
			for iter_38_0, iter_38_1 in pairs(var_0_8:get_seventh_buff_list()) do
				if iter_38_1 == self._cur_selected_buff_id then
					var_38_0 = true
				end
			end
		else
			for iter_38_2, iter_38_3 in pairs(var_0_8:get_eighth_buff_list()) do
				if iter_38_3 == self._cur_selected_buff_id then
					var_38_0 = true
				end
			end
		end

		return ((self._cur_selected_buff_id % 10 == 0 or nil) and true or nil) and (self._cur_selected_buff_id + 1 or self._cur_selected_buff_id)
	end

	function arg_2_0:__switch_toggle_image()
		for iter_39_0, iter_39_1 in pairs(self._toggle_list) do
			local var_39_0

			if iter_39_0 == 4 - self._cur_ship_ton_buff_index then
				var_39_0 = var_0_6(var_0_7.seventh_buff_shipton_image.activation_ship_ton, iter_39_0)
				iter_39_1.Text.text.color = var_0_16.White
			else
				var_39_0 = var_0_6(var_0_7.seventh_buff_shipton_image.not_activation_shipton, iter_39_0)
				iter_39_1.Text.text.color = var_0_16.Grey
			end

			iter_39_1.image.sprite = self:loadSprite(var_39_0)
		end
	end

	function arg_2_0:__auto_select_last_buff_item()
		local var_40_0
		local var_40_1 = false
		local var_40_2

		if self._cur_ship_ton_buff_index == 3 and self._ship_ton_click_record.large then
			var_40_1 = true
			var_40_2 = self._ship_ton_click_record.large
		elseif self._cur_ship_ton_buff_index == 2 and self._ship_ton_click_record.middle then
			var_40_1 = true
			var_40_2 = self._ship_ton_click_record.middle
		elseif self._cur_ship_ton_buff_index == 1 and self._ship_ton_click_record.little then
			var_40_1 = true
			var_40_2 = self._ship_ton_click_record.little
		end

		if var_40_1 then
			self:__buff_item_button_invoke(var_40_2)
		else
			for iter_40_0, iter_40_1 in pairs(self._buff_detail_data_list) do
				if iter_40_1.config.buff_type == self._cur_ship_ton_buff_index and (iter_40_1.state == var_0_14.Activated or iter_40_1.state == var_0_14.Unactivated) then
					var_40_0 = iter_40_1
				end
			end

			if var_40_0 then
				self:__buff_item_button_invoke(var_40_0)
			end
		end
	end

	function arg_2_0:buff_item_button_invoke(arg_41_1)
		self:__buff_item_button_invoke(arg_41_1)
	end

	function arg_2_0:__buff_item_button_invoke(arg_42_1)
		local var_42_0

		if arg_42_1 then
			var_42_0 = arg_42_1.control.buff_icon.button
		else
			for iter_42_0, iter_42_1 in pairs(self._buff_detail_data_list) do
				if iter_42_1.id == self._cur_selected_buff_id then
					var_42_0 = iter_42_1.control.buff_icon.button
				end
			end
		end

		var_42_0.onClick:Invoke()
	end

	function arg_2_0:auto_select_last_buff_item()
		self:__auto_select_last_buff_item()
	end

	function arg_2_0:__onReset()
		self:destroyChildren("mix_buff_item")
		self:__initia_lize()
	end

	function arg_2_0.__initia_lize(arg_45_0)
		arg_45_0._buff_detail_data_list = {}
		arg_45_0._cur_ship_ton_buff_index = nil
		arg_45_0._cur_selected_buff_id = 0
		arg_45_0._ship_ton_click_record = {}
		arg_45_0._buff_point = 0
		arg_45_0.acticity = {}
		arg_45_0._activity_num = 0
	end

	function arg_2_0:_play_into_se(arg_46_1)
		self:playSE(arg_46_1, false)
	end

	gamecore.extend_method(arg_2_0)
end)

function var_0_0.create(arg_47_0)
	local var_47_0 = var_0_1:class("mix_battle_plan")

	var_47_0:__initia_lize()

	return var_47_0
end

return var_0_0
