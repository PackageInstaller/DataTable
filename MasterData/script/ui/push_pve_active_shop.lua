local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.user
local var_0_8 = gameconfig.ship_pve_active_config
local var_0_9 = gameconfig.pve_active_map_config
local var_0_10 = gameconfig.pve_active_buff_config
local var_0_11 = gamecore.util_func
local var_0_12 = lan_rand
local var_0_13 = string.format

gamecore.UILoader:define("push_pve_active_shop", function(arg_1_0)
	function arg_1_0:show()
		self:__init_panel()
		self:setVisible(true)
	end

	function arg_1_0:__init_panel()
		self._panel.transform:GetComponent("Canvas").sortingOrder = var_0_3:createInstance("combat_result")._panel.transform:GetComponent("Canvas").sortingOrder + 1

		self:_init_data()
		self:__init_buff_cell_list()
	end

	function arg_1_0:__init_buff_cell_list()
		self._equip_buff_cell_list = {
			self._control.buff_content.pve_active_buff_cell_1,
			self._control.buff_content.pve_active_buff_cell_2,
			self._control.buff_content.pve_active_buff_cell_3,
			self._control.buff_content.pve_active_buff_cell_4,
			self._control.buff_content.pve_active_buff_cell_5,
			self._control.buff_content.pve_active_buff_cell_6
		}

		self:show_panel_buff_data()
	end

	function arg_1_0:show_panel_buff_data()
		local var_5_0 = var_0_5:get_battle_info()

		if var_5_0 then
			self.map_id = var_5_0.id
		end

		local var_5_2

		if not self.map_id then
			do return end

			local var_5_1 = var_0_5:get_push_buff_list()

			var_5_2 = 0
		end

		for iter_5_0, iter_5_1 in pairs(var_0_9.find_object_by_id(self.map_id).shop_buff) do
			if iter_5_1.weight ~= 0 then
				for iter_5_2 = 1, iter_5_1.weight do
					if not self:__is_max_num(iter_5_1.id) then
						if 0 ~= iter_5_1.id then
							var_5_2 = var_5_2 + 1
						end

						var_0_1(self._retropulsion_buff_list, iter_5_1.id)
					else
						var_0_1(self._full_buff_list, iter_5_1.id)
					end
				end
			end
		end

		for iter_5_3, iter_5_4 in pairs(self._equip_buff_cell_list) do
			iter_5_4.already_buy:SetActive(false)
		end

		if next(self._retropulsion_buff_list) then
			local var_5_4 = self._retropulsion_buff_list[var_0_12(1, #self._retropulsion_buff_list)]
			local var_5_5
			local var_5_6
			local var_5_7
			local var_5_8
			local var_5_9

			if var_5_2 >= 2 then
				var_5_5 = self._retropulsion_buff_list[var_0_12(1, #self._retropulsion_buff_list)]

				while var_5_5 == var_5_4 do
					var_5_5 = self._retropulsion_buff_list[var_0_12(1, #self._retropulsion_buff_list)]
				end
			end

			if var_5_2 >= 3 then
				var_5_6 = self._retropulsion_buff_list[var_0_12(1, #self._retropulsion_buff_list)]

				while var_5_6 == var_5_4 or var_5_6 == var_5_5 do
					var_5_6 = self._retropulsion_buff_list[var_0_12(1, #self._retropulsion_buff_list)]
				end
			end

			if var_5_2 >= 4 then
				var_5_7 = self._retropulsion_buff_list[var_0_12(1, #self._retropulsion_buff_list)]

				while var_5_7 == var_5_4 or var_5_7 == var_5_5 or var_5_7 == var_5_6 do
					var_5_7 = self._retropulsion_buff_list[var_0_12(1, #self._retropulsion_buff_list)]
				end
			end

			if var_5_2 >= 5 then
				var_5_8 = self._retropulsion_buff_list[var_0_12(1, #self._retropulsion_buff_list)]

				while var_5_8 == var_5_4 or var_5_8 == var_5_5 or var_5_8 == var_5_6 or var_5_8 == var_5_7 do
					var_5_8 = self._retropulsion_buff_list[var_0_12(1, #self._retropulsion_buff_list)]
				end
			end

			if var_5_2 >= 6 then
				var_5_9 = self._retropulsion_buff_list[var_0_12(1, #self._retropulsion_buff_list)]

				while var_5_9 == var_5_4 or var_5_9 == var_5_5 or var_5_9 == var_5_6 or var_5_9 == var_5_7 or var_5_9 == var_5_8 do
					var_5_9 = self._retropulsion_buff_list[var_0_12(1, #self._retropulsion_buff_list)]
				end
			end

			self._buff_1 = var_5_4
			self._buff_2 = var_5_5
			self._buff_3 = var_5_6
			self._buff_4 = var_5_7
			self._buff_5 = var_5_8
			self._buff_6 = var_5_9
		end

		if not self._buff_1 then
			return
		end

		local var_5_10 = {}

		table.insert(var_5_10, self._buff_1)
		table.insert(var_5_10, self._buff_2)
		table.insert(var_5_10, self._buff_3)
		table.insert(var_5_10, self._buff_4)
		table.insert(var_5_10, self._buff_5)
		table.insert(var_5_10, self._buff_6)

		if var_5_2 < 6 then
			self:__full_level_list(var_5_2)
		end

		self:__show_buff_info(var_5_10)
	end

	function arg_1_0.__is_max_num(arg_6_0, arg_6_1)
		local var_6_0 = false

		for iter_6_0, iter_6_1 in pairs((var_0_5:get_push_buff_list())) do
			if iter_6_1.id == arg_6_1 and iter_6_1.count == 10 then
				var_6_0 = true

				return true
			end
		end

		return var_6_0
	end

	function arg_1_0:__show_buff_info(arg_7_1)
		for iter_7_0, iter_7_1 in pairs(arg_7_1) do
			if iter_7_1 > 0 then
				local var_7_0 = var_0_10.find_object_by_id(iter_7_1)

				self._equip_buff_cell_list[iter_7_0].buff_bg.image.sprite = self:loadSprite((var_0_13(var_0_4.pve_active_buff_bg_image, (self:__get_buff_level(iter_7_1)))))
				self._equip_buff_cell_list[iter_7_0].buff_image.image.sprite = self:loadSprite((var_0_13(var_0_4.pve_active_buff_image, var_7_0.buff_icon)))

				self._equip_buff_cell_list[iter_7_0].buff_image.buff_lv:SetActive(false)

				self._equip_buff_cell_list[iter_7_0].buff_desc.text.text = var_0_11.convert_rich_text(var_7_0.effect_desc)
				self._equip_buff_cell_list[iter_7_0].buff_button.cost_num.text.text = var_7_0.value
			end
		end
	end

	function arg_1_0:__show_full_buff_info(arg_8_1)
		for iter_8_0, iter_8_1 in pairs(arg_8_1) do
			if iter_8_1 > 0 then
				local var_8_0 = var_0_10.find_object_by_id(iter_8_1)

				self._equip_buff_cell_list[7 - iter_8_0].buff_bg.image.sprite = self:loadSprite((var_0_13(var_0_4.pve_active_buff_bg_image, 3)))
				self._equip_buff_cell_list[7 - iter_8_0].buff_image.image.sprite = self:loadSprite((var_0_13(var_0_4.pve_active_buff_image, var_8_0.buff_icon)))

				self._equip_buff_cell_list[7 - iter_8_0].buff_image.buff_lv:SetActive(false)

				self._equip_buff_cell_list[7 - iter_8_0].buff_desc.text.text = var_8_0.effect_desc

				self._equip_buff_cell_list[7 - iter_8_0].buff_button:SetActive(false)
				self._equip_buff_cell_list[7 - iter_8_0].already_buy:SetActive(true)

				self._equip_buff_cell_list[7 - iter_8_0].already_buy.already_txt.text.text = var_0_2:getNowLang("workshop_max_grade")
			end
		end
	end

	function arg_1_0:__full_level_list(arg_9_1)
		if next(self._full_buff_list) then
			for iter_9_0, iter_9_1 in pairs(self._full_buff_list) do
				local var_9_0 = self._full_buff_list[var_0_12(1, #self._full_buff_list)]
				local var_9_1
				local var_9_2
				local var_9_3
				local var_9_4
				local var_9_5

				if 6 - arg_9_1 >= 2 then
					var_9_1 = self._full_buff_list[var_0_12(1, #self._full_buff_list)]

					while var_9_1 == var_9_0 do
						var_9_1 = self._full_buff_list[var_0_12(1, #self._full_buff_list)]
					end
				end

				if 6 - arg_9_1 >= 3 then
					var_9_2 = self._full_buff_list[var_0_12(1, #self._full_buff_list)]

					while var_9_2 == var_9_0 or var_9_2 == var_9_1 do
						var_9_2 = self._full_buff_list[var_0_12(1, #self._full_buff_list)]
					end
				end

				if 6 - arg_9_1 >= 4 then
					var_9_3 = self._full_buff_list[var_0_12(1, #self._full_buff_list)]

					while var_9_3 == var_9_0 or var_9_3 == var_9_1 or var_9_3 == var_9_2 do
						var_9_3 = self._full_buff_list[var_0_12(1, #self._full_buff_list)]
					end
				end

				if 6 - arg_9_1 >= 5 then
					var_9_4 = self._full_buff_list[var_0_12(1, #self._full_buff_list)]

					while var_9_4 == var_9_0 or var_9_4 == var_9_1 or var_9_4 == var_9_2 or var_9_4 == var_9_3 do
						var_9_4 = self._full_buff_list[var_0_12(1, #self._full_buff_list)]
					end
				end

				if 6 - arg_9_1 >= 6 then
					var_9_5 = self._full_buff_list[var_0_12(1, #self._full_buff_list)]

					while var_9_5 == var_9_0 or var_9_5 == var_9_1 or var_9_5 == var_9_2 or var_9_5 == var_9_3 or var_9_5 == var_9_4 do
						var_9_5 = self._full_buff_list[var_0_12(1, #self._full_buff_list)]
					end
				end

				self._full_buff_1 = var_9_0
				self._full_buff_2 = var_9_1
				self._full_buff_3 = var_9_2
				self._full_buff_4 = var_9_3
				self._full_buff_5 = var_9_4
				self._full_buff_6 = var_9_5
			end

			local var_9_6 = {}

			table.insert(var_9_6, self._full_buff_1)
			table.insert(var_9_6, self._full_buff_2)
			table.insert(var_9_6, self._full_buff_3)
			table.insert(var_9_6, self._full_buff_4)
			table.insert(var_9_6, self._full_buff_5)
			table.insert(var_9_6, self._full_buff_6)
			self:__show_full_buff_info(var_9_6)
		end
	end

	function arg_1_0:_init_data()
		self._control.bg.bg_container.title.text.text = var_0_2:getNowLang("active_buff_shop")
		self._control.point_bg.point_num.text.text = var_0_5:get_push_info_coin()

		self:__init_buff_data()
	end

	function arg_1_0:updata_buy_buff_panel()
		self._control.point_bg.point_num.text.text = var_0_5:get_push_info_coin()

		local var_11_0 = var_0_5:get_bug_buff_index()

		for iter_11_0, iter_11_1 in pairs(self._equip_buff_cell_list) do
			for iter_11_2, iter_11_3 in pairs(var_11_0) do
				if iter_11_0 == iter_11_3 then
					iter_11_1.already_buy:SetActive(true)
					iter_11_1.buff_button:SetActive(false)

					iter_11_1.already_buy.already_txt.text.text = var_0_2:getNowLang("active_buff_have")
				end
			end
		end
	end

	function arg_1_0:__init_buff_data()
		self:_push_active_buff_start_time()
	end

	function arg_1_0.__get_buff_level(arg_13_0, arg_13_1)
		local var_13_1 = 1
		local var_13_2 = var_0_5:get_push_buff_list()

		if var_13_2 and next(var_13_2) then
			for iter_13_0, iter_13_1 in pairs(var_13_2) do
				if iter_13_1.id == arg_13_1 then
					var_13_1 = iter_13_1.count
				end
			end
		end

		return var_13_1 >= 10 and 3 or var_13_1 >= 4 and var_13_1 <= 9 and 2 or 1
	end

	function arg_1_0:_push_active_buff_start_time()
		self._control.limit_bg.limit_desc.text.text = var_0_2:getNowLang("buff_num_max") .. " :" .. self:__init_now_buff_num() .. "/" .. self:__init_max_buff_num()
	end

	function arg_1_0:__init_max_buff_num()
		self.acticity = {}

		local var_15_0 = gameconfig.ship_rule_config.find_object_by_id(var_0_4.pve_init_active_id.fearlessness_event).content.activeId

		for iter_15_0, iter_15_1 in pairs((var_0_8.get_sequence())) do
			if self:get_acticity_time(iter_15_1) and iter_15_1.id == var_15_0 then
				self.acticity = var_0_11.little_clone(iter_15_1)
			end
		end

		local var_15_1 = math.floor((lx.ServerTime:getUtcTime() - (self.acticity.start_time - 54000)) / 86400)

		if var_15_1 >= 9 then
			var_15_1 = 9
		end

		return 90 + var_15_1 * 20
	end

	function arg_1_0.__init_now_buff_num(arg_16_0)
		local var_16_0 = var_0_5:get_push_buff_list()
		local var_16_1 = 0

		if next(var_16_0) == nil then
			var_16_1 = 0
		else
			for iter_16_0, iter_16_1 in pairs(var_16_0) do
				var_16_1 = var_16_1 + iter_16_1.count
			end
		end

		return var_16_1
	end

	function arg_1_0.get_acticity_time(arg_17_0, arg_17_1)
		if not arg_17_1 then
			return false
		end

		arg_17_1.start_time = arg_17_1.start_time or 0
		arg_17_1.end_time = arg_17_1.end_time or 0

		if arg_17_1.start_time == 0 or arg_17_1.end_time == 0 then
			return false
		end

		arg_17_1.award_time = arg_17_1.award_time or 0

		if arg_17_1.award_time == 0 then
			if lx.ServerTime:getUtcTime() > arg_17_1.start_time and lx.ServerTime:getUtcTime() < arg_17_1.end_time then
				return true
			end
		elseif lx.ServerTime:getUtcTime() > arg_17_1.start_time and lx.ServerTime:getUtcTime() < arg_17_1.award_time then
			return true
		end

		return false
	end

	function arg_1_0:_play_into_se(arg_18_1)
		self:playSE(arg_18_1, false)
	end

	function arg_1_0.__onReset(arg_19_0)
		arg_19_0._all_teams = {}
		arg_19_0._from_confirm = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_20_0)
	local var_20_0 = var_0_3:class("push_pve_active_shop")

	var_20_0._all_teams = {}
	var_20_0._from_confirm = false
	var_20_0._retropulsion_buff_list = {}
	var_20_0._full_buff_list = {}
	var_20_0._buff_1 = 0
	var_20_0._buff_2 = 0
	var_20_0._buff_3 = 0
	var_20_0._buff_4 = 0
	var_20_0._buff_5 = 0
	var_20_0._buff_6 = 0
	var_20_0._full_buff_1 = 0
	var_20_0._full_buff_2 = 0
	var_20_0._full_buff_3 = 0
	var_20_0._full_buff_4 = 0
	var_20_0._full_buff_5 = 0

	gamecore.extend_obj(var_20_0)

	return var_20_0
end

return var_0_0
