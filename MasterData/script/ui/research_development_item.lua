local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore
local var_0_4 = gamecore.Language
local var_0_5 = gameenum.common_type
local var_0_6 = gameconfig.ship_config
local var_0_7 = string.format
local var_0_10 = gameconfig.ship_research_config

gamecore.UILoader:define("research_development_item", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
		self:setVisible(true)

		self.init_ship_info = arg_2_4
		self._ship_all_info = arg_2_5
		self._data_id = arg_2_1
		self._ship_str = arg_2_6

		self:__init_panel(arg_2_3)
	end

	function arg_1_0:__init_panel(arg_3_1)
		self:_init_data(arg_3_1)
		self:__init_language()
	end

	function arg_1_0:_init_data(arg_4_1)
		self._control.item_bg.common_tips:SetActive(false)

		if arg_4_1 then
			self._control.item_bg.common_tips:SetActive(true)
		else
			self._control.item_bg.common_tips:SetActive(false)
		end

		if self._data_id == 10000113 then
			self._control.item_bg.not_choose_bg:SetActive(false)
			self._control.item_bg.icon:SetActive(false)
			self._control.item_bg.state:SetActive(true)
			self._control.item_bg.choose_bg:SetActive(false)

			self._control.item_bg.ship_name.ship_name_1.text.text = ""
			self._control.item_bg.ship_name.ship_name_2.text.text = ""
			self._control.item_bg.state.text.text = "..."
		else
			self._control.item_bg.choose_bg:SetActive(false)
			self:set_show_panel()
			self._control.item_bg.not_choose_bg:SetActive(true)
		end
	end

	function arg_1_0:set_show_panel(arg_5_1)
		self._control.item_bg.icon.image.sprite = nil

		local var_5_1 = arg_5_1 and var_0_10.find_object_by_id(arg_5_1) or var_0_10.find_object_by_id(self.init_ship_info)
		local var_5_2 = var_0_10.find_object_by_id(self._data_id)

		if var_5_1.num == var_5_2.num then
			self._control.item_bg.choose_bg:SetActive(true)
		else
			self._control.item_bg.choose_bg:SetActive(false)
		end

		local var_5_3 = var_0_6.find_object_by_cid(self.init_ship_info)
		local var_5_4 = var_0_6.find_object_by_cid(var_5_2.ship_id)
		local var_5_5 = var_0_1:get_now_research_ship_id()

		self._control.item_bg.state:SetActive(true)
		self._control.item_bg.icon:SetActive(true)

		self._control.item_bg.ship_name.ship_name_1.text.text = var_5_4.title

		self._control.item_bg.ship_name:GetComponent("TextHorizonScroller"):SetText(var_5_4.title)

		self._control.item_bg.icon.image.sprite = self:loadSprite((var_0_7(var_0_5.icon.item_icon, var_5_4.cid)))
		self._control.item_bg.state.text.text = self._ship_str
	end

	function arg_1_0:set_all_ship_state(arg_6_1, arg_6_2)
		if arg_6_2 == 10000113 then
			return
		end

		local var_6_0 = var_0_10.find_object_by_id(arg_6_2)
		local var_6_1 = var_0_10.find_object_by_id(self.now_click_ship_info)
		local var_6_2 = var_0_10.find_object_by_id(self.now_ship_info)

		if self.now_click_ship_info and var_6_1.ship_id ~= var_6_2.ship_id then
			local var_6_4 = self:is_have_data_in_research(arg_6_2)

			if self:__is_finish_all_equip_and_finish_ship_task(arg_6_2) then
				if var_6_1.num == var_6_0.num then
					local var_6_5 = var_0_4:getNowLang("not_research")
				elseif var_6_2.num == var_6_0.num then
					local var_6_6 = var_0_4:getNowLang("research_now")
				else
					local var_6_7 = var_0_4:getNowLang("not_research")
				end
			else
				local var_6_8 = var_0_4:getNowLang("research_complete")
			end
		elseif self:__is_finish_all_equip_and_finish_ship_task(arg_6_2) then
			if var_0_10.find_object_by_id(self.now_ship_info).ship_id == var_6_0.ship_id and self:is_have_research_data() then
				local var_6_9 = var_0_4:getNowLang("research_now")
			else
				local var_6_10 = var_0_4:getNowLang("not_research")
			end
		else
			local var_6_11 = var_0_4:getNowLang("research_complete")
		end

		self._control.item_bg.state.text.text = self._ship_str
	end

	function arg_1_0.__get_research_all_ship_index(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 and next(arg_7_1) then
			for iter_7_0, iter_7_1 in pairs(arg_7_1) do
				if iter_7_1 == arg_7_2 then
					return iter_7_0
				end
			end
		end
	end

	function arg_1_0.__is_finish_all_equip_and_finish_ship_task(arg_8_0, arg_8_1)
		local var_8_0 = false
		local var_8_1 = var_0_10.find_object_by_id(arg_8_1)
		local var_8_2 = var_0_1:get_equip_task_info()
		local var_8_3 = var_0_1:get_ship_task_info()

		if not var_8_3 or not var_8_2 then
			return var_8_0
		end

		if var_8_2 and next(var_8_2) then
			for iter_8_0, iter_8_1 in pairs(var_8_2) do
				for iter_8_2, iter_8_3 in ipairs(var_8_1.equipment) do
					if iter_8_1.id == iter_8_3 and iter_8_1.status == 0 then
						var_8_0 = true

						return true
					end
				end
			end
		end

		if var_8_3 and next(var_8_3) then
			if var_8_1.stage == 1 then
				for iter_8_4, iter_8_5 in pairs(var_8_3) do
					if iter_8_5.id == arg_8_1 + 2 and iter_8_5.status == 0 then
						var_8_0 = true

						return true
					end
				end
			elseif var_8_1.stage == 2 then
				for iter_8_6, iter_8_7 in pairs(var_8_3) do
					if iter_8_7.id == arg_8_1 + 1 and iter_8_7.status == 0 then
						var_8_0 = true

						return true
					end
				end
			elseif var_8_1.stage == 3 then
				for iter_8_8, iter_8_9 in pairs(var_8_3) do
					if iter_8_9.id == arg_8_1 and iter_8_9.status == 0 then
						var_8_0 = true

						return true
					end
				end
			end
		end

		return var_8_0
	end

	function arg_1_0.__init_language(arg_9_0)
		return
	end

	function arg_1_0.__initia_lize(arg_10_0)
		return
	end

	function arg_1_0.__onReset(arg_11_0)
		return
	end

	var_0_3.extend_method(arg_1_0)
end)

function var_0_0.create(arg_12_0)
	local var_12_0 = var_0_2:class("research_development_item")

	var_12_0._ship_info = nil
	var_12_0._data_id = nil
	var_12_0.now_ship_info = nil
	var_12_0.click_ship_info = nil

	var_0_3.extend_obj(var_12_0)

	return var_12_0
end

return var_0_0
