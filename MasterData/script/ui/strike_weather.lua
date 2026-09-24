local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = gamecore.util_func
local var_0_16 = gameconfig.strike_weather_config

gamecore.UILoader:define("strike_weather", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)

		local var_3_0 = var_0_2:getInstance("strike_main")

		if var_3_0 then
			self.page_data, self.page_num = var_3_0:get_page_data()
		end

		if arg_3_1 ~= nil then
			self.page_num = arg_3_1
		end

		self:__init_panel()
	end

	function arg_1_0:show_for_fight(arg_4_1)
		self._is_fight = true

		self:setVisible(true)

		local var_4_0 = var_0_2:getInstance("strike_main")

		if var_4_0 then
			self._detail_type = true
			self.page_data, self.page_num = var_4_0:get_page_data()
		else
			self._detail_type = false

			local var_4_1 = var_0_2:getInstance("strike_map")

			if var_4_1 then
				self.page_data, self.page_num = var_4_1:get_map_info()
			end
		end

		if arg_4_1 ~= nil then
			self.page_num = arg_4_1
		end

		self:__init_panel_fight()
	end

	function arg_1_0:__init_panel()
		self._control.weather_info.transform.localPosition = {
			z = 0,
			x = -301.8,
			y = 78.3
		}
		self._user_data = var_0_3:get_strike_data()

		self:check_hard()
	end

	function arg_1_0:__init_panel_fight()
		local var_6_0 = var_0_2:getInstance("fight_prepare")

		if var_6_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_6_0._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		self._control.weather_info.transform.localPosition = {
			z = 0,
			x = 180,
			y = 78.3
		}
		self._user_data = var_0_3:get_strike_data()

		self:show_detail(self._detail_type)
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_8_0)
		return
	end

	function arg_1_0:weather_update(arg_9_1)
		self.page_data, self.page_num = var_0_2:createInstance("strike_main"):get_page_data()

		if arg_9_1 ~= nil then
			self.page_num = arg_9_1
		end

		self._user_data = var_0_3:get_strike_data()

		self:check_hard()
	end

	function arg_1_0:check_hard()
		if not self.page_data then
			return
		end

		self:__init_info()
	end

	function arg_1_0:show_detail(arg_11_1)
		if not self.page_data then
			return
		end

		if arg_11_1 then
			if not self._user_data[self.page_data[self.page_num].id] then
				return
			end

			if self._user_data[self.page_data[self.page_num].id].score >= self.page_data[self.page_num].hard_score then
				self._control.shadow_weather:SetActive(true)
				self._control.weather_close_btn:SetActive(true)
				self._control.weather_info:SetActive(true)
			else
				self._control.shadow_weather:SetActive(false)
				self._control.weather_close_btn:SetActive(false)
				self._control.weather_info:SetActive(false)
			end

			self:__init_info()
		else
			if not self._user_data[self.page_data.id] then
				return
			end

			if self._user_data[self.page_data.id].score >= self.page_data.hard_score then
				self._control.shadow_weather:SetActive(true)
				self._control.weather_close_btn:SetActive(true)
				self._control.weather_info:SetActive(true)
			else
				self._control.shadow_weather:SetActive(false)
				self._control.weather_close_btn:SetActive(false)
				self._control.weather_info:SetActive(false)
			end

			self:__init_fight_info()
		end
	end

	function arg_1_0:strike_weather_set_active(arg_12_1)
		self:setVisible(arg_12_1)
	end

	function arg_1_0:__init_info()
		if not self.page_data[self.page_num].weather2 then
			return
		end

		self._weather_data = var_0_16.find_object_by_id(self.page_data[self.page_num].weather2)

		if not self._weather_data then
			return
		end

		self._control.weather_name.text.text = self._weather_data.title
		self._control.weather_content.text.text = var_0_5.only_extract_word(self._weather_data.effect_desc)
	end

	function arg_1_0:__init_fight_info()
		self._weather_data = var_0_16.find_object_by_id(self.page_data.weather2)
		self._control.weather_name.text.text = self._weather_data.title
		self._control.weather_content.text.text = var_0_5.only_extract_word(self._weather_data.effect_desc)
	end

	function arg_1_0:close_weather()
		self._control.shadow_weather:SetActive(false)
		self._control.weather_close_btn:SetActive(false)
		self._control.weather_info:SetActive(false)
	end

	function arg_1_0:show_weather()
		self._control.shadow_weather:SetActive(true)
		self._control.weather_close_btn:SetActive(true)
		self._control.weather_info:SetActive(true)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_17_0)
	local var_17_0 = var_0_2:class("strike_weather")

	var_17_0:__initia_lize()

	var_17_0._weather_data = {}
	var_17_0.page_num = 0
	var_17_0.page_data = {}
	var_17_0._user_data = {}
	var_17_0._detail_type = true

	return var_17_0
end

return var_0_0
