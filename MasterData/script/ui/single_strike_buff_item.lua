local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_3 = UnityEngine.Color
local var_0_4 = gamecore.UILoader
local var_0_6 = string.format
local var_0_7 = gamecore.util_func
local var_0_8 = gameenum.common_type
local var_0_9 = gameconfig.strike_buff_config
local var_0_10 = gameconfig.strike_weather_config

gamecore.UILoader:define("single_strike_buff_item", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self.index = arg_2_1

		self:setVisible(true)
		self:__init_panel(arg_2_2)
	end

	function arg_1_0:__apply_strike_buff_card_color(arg_3_1)
		if arg_3_1.replace then
			self._control.active_bg.image.color = var_0_3(1, 1, 1)

			return
		end

		local var_3_0 = var_0_1:get_buff_item_color()
		local var_3_1 = arg_3_1.id

		if arg_3_1.state == true and arg_3_1.change_id then
			var_3_1 = arg_3_1.change_id
		end

		if var_3_0[var_3_1] then
			for iter_3_0, iter_3_1 in pairs(var_3_0[var_3_1]) do
				if iter_3_1 ~= 1 then
					break
				end
			end

			self._control.active_bg.image.color = true and var_0_3(0.15294117647058825, 0.5843137254901961, 0.9921568627450981) or var_0_3(1, 1, 1)
		else
			self._control.active_bg.image.color = var_0_3(1, 1, 1)
		end
	end

	function arg_1_0:__init_panel(arg_4_1)
		local var_4_0

		if arg_4_1 and next(arg_4_1) then
			self:__apply_strike_buff_card_color(arg_4_1)

			if arg_4_1.score == 0 then
				var_4_0 = var_0_10.find_object_by_id(arg_4_1.id)

				self:__show_weather(var_0_1:get_save_weather())
				self._control.Button:SetActive(true)
			else
				self._control.Button:SetActive(false)

				var_4_0 = var_0_9.find_object_by_id(arg_4_1.id)

				if arg_4_1.state then
					var_4_0 = var_0_9.find_object_by_id(arg_4_1.change_id)

					self._control.extra_icon:SetActive(false)
				elseif var_4_0.change_condition ~= 0 and next(var_4_0.change_condition) then
					self._control.extra_icon:SetActive(true)
					self._control.extra_btn:SetActive(true)

					if arg_4_1 then
						self._data_id = arg_4_1.id
					end

					self._control.extra_icon.image.sprite = self:loadSprite(var_0_8.strike_buff_tan)
				else
					self._control.extra_icon:SetActive(false)
				end
			end

			local var_4_1 = self._control.active_bg.title:GetComponent("TextHorizonScroller")

			var_4_1.isRich = true

			var_4_1:SetText(var_0_7.convert_rich_text(var_4_0.desc))

			if arg_4_1.replace then
				self._control.active_bg.image.sprite = self:loadSprite(var_0_6(var_0_8.strike_buff_active_bg, 3))

				self._control.active_bg.Image:SetActive(true)
			else
				self._control.active_bg.image.sprite = self:loadSprite(var_0_6(var_0_8.strike_buff_active_bg, 1))

				self._control.active_bg.Image:SetActive(false)
			end
		else
			self._control.active_bg.image.color = var_0_3(1, 1, 1)
			self._control.active_bg.image.sprite = self:loadSprite(var_0_6(var_0_8.strike_buff_active_bg, 2))

			self._control.extra_icon:SetActive(false)
			self._control.active_bg.Image:SetActive(false)
			self._control.active_bg.title:GetComponent("TextHorizonScroller"):SetText("")
		end
	end

	function arg_1_0:__show_weather(arg_5_1)
		if arg_5_1 == 0 then
			return
		end

		self._control.extra_icon:SetActive(true)

		self._control.extra_icon.image.sprite = self:loadSprite(var_0_6(var_0_8.strike_buff_weather, arg_5_1))
	end

	function arg_1_0.show_weather_detail(arg_6_0)
		if var_0_4:getInstance("strike_weather") then
			var_0_4:destroyInstance("strike_weather")
		end

		var_0_4:createInstance("strike_weather"):show_for_fight()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_4:class("single_strike_buff_item")

	var_7_0._data_id = nil

	return var_7_0
end

return var_0_0
