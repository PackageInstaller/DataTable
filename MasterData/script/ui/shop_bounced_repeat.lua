local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = string.format
local var_0_5 = gameenum.common_type

gamecore.UILoader:define("shop_bounced_repeat", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if UnityEngine.Input.GetMouseButtonUp(0) then
			self._is_long_click_minus_btn = false
			self._is_long_click_plus_btn = false
		end

		if self._is_long_click_minus_btn then
			self:__click_minus_btn()
		end

		if self._is_long_click_plus_btn then
			self:__click_plus_btn()
		end
	end

	function arg_1_0:__close_curr_panel()
		if self.buy_enter_type == var_0_5.buy_enter_type.exchange_shop_panel then
			var_0_5:play_in_out_animation(self._control.maskbg.uITweenSequence, false, function()
				var_0_2:destroyInstance("shop_bounced_repeat")
			end)
		else
			var_0_2:destroyInstance("shop_bounced_repeat")
		end
	end

	function arg_1_0:_play_into_se(arg_5_1)
		self:playSE(arg_5_1, false)
	end

	function arg_1_0:show(arg_6_1, arg_6_2, arg_6_3)
		self:setVisible(true)

		self._goods_info = arg_6_1
		self._enter_panel_type = nil

		if arg_6_2 then
			self._enter_type = arg_6_2
		end

		self.confirm_func = arg_6_3

		self:__init_panel(arg_6_1)
	end

	function arg_1_0:__init_panel(arg_7_1)
		if not arg_7_1._goods_count then
			self._goods_count = 1
		end

		local var_7_0 = var_0_1:get_use_info_data()

		self._control.count_num.text.text = tostring(self._goods_count)

		self._control.closebtn.gameObject:SetActive(false)
		self._control.max_text.gameObject:SetActive(false)

		if self._enter_type == "spoils" then
			self._control.exploit_icon.gameObject:SetActive(false)
			self._control.diamond_icon.gameObject:SetActive(false)
			self._control.spoils_icon.gameObject:SetActive(true)
			self._control.combat_icon.gameObject:SetActive(false)
			self._control.furniture_icon.gameObject:SetActive(false)
		elseif self._enter_type == "exploit" then
			self._control.exploit_icon.gameObject:SetActive(true)
			self._control.diamond_icon.gameObject:SetActive(false)
			self._control.spoils_icon.gameObject:SetActive(false)
			self._control.combat_icon.gameObject:SetActive(false)
			self._control.furniture_icon.gameObject:SetActive(false)
		elseif self._enter_type == "combat" then
			self._control.exploit_icon.gameObject:SetActive(false)
			self._control.diamond_icon.gameObject:SetActive(false)
			self._control.spoils_icon.gameObject:SetActive(false)
			self._control.combat_icon.gameObject:SetActive(true)
			self._control.furniture_icon.gameObject:SetActive(false)
		elseif self._enter_type == "furniture" then
			self._control.exploit_icon.gameObject:SetActive(false)
			self._control.diamond_icon.gameObject:SetActive(false)
			self._control.spoils_icon.gameObject:SetActive(false)
			self._control.combat_icon.gameObject:SetActive(false)
			self._control.furniture_icon.gameObject:SetActive(true)
		else
			self._control.exploit_icon.gameObject:SetActive(false)
			self._control.diamond_icon.gameObject:SetActive(true)
			self._control.spoils_icon.gameObject:SetActive(false)
			self._control.combat_icon.gameObject:SetActive(false)
			self._control.furniture_icon.gameObject:SetActive(false)
		end

		self._control.title.text.text = not arg_7_1.lang_title and var_0_3:getNowLang("shopconfirmbuy") or arg_7_1.lang_title
		self._control.confirmbtn.text.text.text = var_0_3:getNowLang("ui_cbtn1")
		self._control.quitbtn.text.text.text = var_0_3:getNowLang("ui_cbtn2")
		self._control.count_text.text.text = var_0_3:getNowLang("buy_num")
		self._control.max_text.text.text = var_0_3:getNowLang("buy_num_max")

		if arg_7_1.id >= 1018 and arg_7_1.id <= 1021 then
			self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc1"), tonumber(arg_7_1.price * self._goods_count), tonumber(self._goods_count), tostring(arg_7_1.brief))
			self._control.former_num.text.text = tostring(var_7_0.diamond)
			self._control.latter_num.text.text = tostring(var_7_0.diamond - tonumber(arg_7_1.price * self._goods_count))

			if var_7_0.diamond - tonumber(arg_7_1.price * self._goods_count) < 0 then
				self._control.latter_num.text.text = var_0_3:getNowLang("not_buy_desc1")

				self._control.confirmbtn.gameObject:SetActive(false)
			else
				self._control.latter_num.text.text = tostring(var_7_0.diamond - tonumber(arg_7_1.price * self._goods_count))

				self._control.confirmbtn.gameObject:SetActive(true)
			end
		elseif self._enter_type == "spoils" then
			if self._goods_count == self._goods_info.now_limit then
				self._control.max_text.gameObject:SetActive(true)
			elseif self._goods_count < self._goods_info.now_limit then
				self._control.max_text.gameObject:SetActive(false)
			end

			self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc2"), tonumber(arg_7_1.price * self._goods_count), tonumber(self._goods_count), tostring(arg_7_1.title))
			self._control.former_num.text.text = tostring(var_7_0.spoils)

			if var_7_0.spoils - tonumber(arg_7_1.price * self._goods_count) < 0 then
				self._control.latter_num.text.text = var_0_3:getNowLang("not_buy_desc2")

				self._control.confirmbtn.gameObject:SetActive(false)
			else
				self._control.latter_num.text.text = tostring(var_7_0.spoils - tonumber(arg_7_1.price * self._goods_count))

				self._control.confirmbtn.gameObject:SetActive(true)
			end
		elseif self._enter_type == "exploit" then
			if self._goods_count == self._goods_info.now_limit then
				self._control.max_text.gameObject:SetActive(true)
			elseif self._goods_count < self._goods_info.now_limit then
				self._control.max_text.gameObject:SetActive(false)
			end

			self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc4"), tonumber(arg_7_1.price * self._goods_count), tonumber(self._goods_count), tostring(arg_7_1.title))
			self._control.former_num.text.text = tostring(var_7_0.exploit)
			self._control.latter_num.text.text = tostring(var_7_0.exploit - tonumber(arg_7_1.price * self._goods_count))

			if var_7_0.exploit - tonumber(arg_7_1.price * self._goods_count) < 0 then
				self._control.latter_num.text.text = var_0_3:getNowLang("not_buy_desc3")

				self._control.confirmbtn.gameObject:SetActive(false)
			else
				self._control.latter_num.text.text = tostring(var_7_0.exploit - tonumber(arg_7_1.price * self._goods_count))

				self._control.confirmbtn.gameObject:SetActive(true)
			end
		elseif self._enter_type == "combat" then
			if self._goods_count == self._goods_info.now_limit then
				self._control.max_text.gameObject:SetActive(true)
			elseif self._goods_count < self._goods_info.now_limit then
				self._control.max_text.gameObject:SetActive(false)
			end

			self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc3"), tonumber(arg_7_1.price * self._goods_count), tonumber(self._goods_count), tostring(arg_7_1.title))
			self._control.former_num.text.text = tostring(arg_7_1.left_combats)
			self._control.latter_num.text.text = tostring(arg_7_1.left_combats - tonumber(arg_7_1.price * self._goods_count))

			if arg_7_1.left_combats - tonumber(arg_7_1.price * self._goods_count) < 0 then
				self._control.latter_num.text.text = var_0_3:getNowLang("not_buy_desc4")

				self._control.confirmbtn.gameObject:SetActive(false)
			else
				self._control.latter_num.text.text = tostring(arg_7_1.left_combats - tonumber(arg_7_1.price * self._goods_count))

				self._control.confirmbtn.gameObject:SetActive(true)
			end
		elseif self._enter_type == "furniture" then
			self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc5"), tonumber(arg_7_1.price * self._goods_count), tonumber(self._goods_count), tostring(arg_7_1.title))
			self._control.former_num.text.text = tostring(var_7_0.furniture_point)
			self._control.latter_num.text.text = tostring(var_7_0.furniture_point - tonumber(arg_7_1.price * self._goods_count))

			if var_7_0.furniture_point - tonumber(arg_7_1.price * self._goods_count) < 0 then
				self._control.latter_num.text.text = var_0_3:getNowLang("not_buy_desc5")

				self._control.confirmbtn.gameObject:SetActive(false)
			else
				self._control.latter_num.text.text = tostring(var_7_0.furniture_point - tonumber(arg_7_1.price * self._goods_count))

				self._control.confirmbtn.gameObject:SetActive(true)
			end
		else
			if arg_7_1.limit_num ~= 0 then
				self._now_limit = arg_7_1.limit_num

				if self._goods_count == self._now_limit then
					self._control.max_text.gameObject:SetActive(true)
				elseif self._goods_count < self._now_limit then
					self._control.max_text.gameObject:SetActive(false)
				end
			end

			self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc1"), tonumber(arg_7_1.price * self._goods_count), tonumber(self._goods_count), tostring(arg_7_1.title))
			self._control.former_num.text.text = tostring(var_7_0.diamond)
			self._control.latter_num.text.text = tostring(var_7_0.diamond - tonumber(arg_7_1.price * self._goods_count))

			if var_7_0.diamond - tonumber(arg_7_1.price * self._goods_count) < 0 then
				self._control.latter_num.text.text = var_0_3:getNowLang("not_buy_desc1")

				self._control.confirmbtn.gameObject:SetActive(false)
			else
				self._control.latter_num.text.text = tostring(var_7_0.diamond - tonumber(arg_7_1.price * self._goods_count))

				self._control.confirmbtn.gameObject:SetActive(true)
			end
		end
	end

	function arg_1_0:__click_minus_btn()
		local var_8_0 = var_0_1:get_use_info_data()
		local var_8_1 = 0

		var_8_1 = self._goods_info.now_limit == 0 and self._stable_limit or self._stable_limit

		if self._goods_count == 1 then
			return
		elseif self._enter_type == "spoils" then
			self._goods_count = self._goods_count - 1
			self._control.count_num.text.text = tostring(self._goods_count)

			if var_8_1 > self._goods_count then
				self._control.max_text.gameObject:SetActive(false)
			end

			self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc2"), tonumber(self._goods_info.price * self._goods_count), tonumber(self._goods_count), tostring(self._goods_info.title))
			self._control.former_num.text.text = tostring(var_8_0.spoils)
			self._control.latter_num.text.text = tostring(var_8_0.spoils - tonumber(self._goods_info.price * self._goods_count))
		elseif self._enter_type == "exploit" then
			self._goods_count = self._goods_count - 1
			self._control.count_num.text.text = tostring(self._goods_count)

			if var_8_1 > self._goods_count then
				self._control.max_text.gameObject:SetActive(false)
			end

			self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc4"), tonumber(self._goods_info.price * self._goods_count), tonumber(self._goods_count), tostring(self._goods_info.title))
			self._control.former_num.text.text = tostring(var_8_0.exploit)
			self._control.latter_num.text.text = tostring(var_8_0.exploit - tonumber(self._goods_info.price * self._goods_count))
		elseif self._enter_type == "combat" then
			self._goods_count = self._goods_count - 1
			self._control.count_num.text.text = tostring(self._goods_count)

			if var_8_1 > self._goods_count then
				self._control.max_text.gameObject:SetActive(false)
			end

			self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc3"), tonumber(self._goods_info.price * self._goods_count), tonumber(self._goods_count), tostring(self._goods_info.title))
			self._control.former_num.text.text = tostring(self._goods_info.left_combats)
			self._control.latter_num.text.text = tostring(self._goods_info.left_combats - tonumber(self._goods_info.price * self._goods_count))
		elseif self._enter_type == "furniture" then
			self._goods_count = self._goods_count - 1
			self._control.count_num.text.text = tostring(self._goods_count)

			if self._goods_count < self._stable_limit then
				self._control.max_text.gameObject:SetActive(false)
			end

			self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc5"), tonumber(self._goods_info.price * self._goods_count), tonumber(self._goods_count), tostring(self._goods_info.title))
			self._control.former_num.text.text = tostring(var_8_0.furniture_point)
			self._control.latter_num.text.text = tostring(var_8_0.furniture_point - tonumber(self._goods_info.price * self._goods_count))
		else
			self._goods_count = self._goods_count - 1
			self._control.count_num.text.text = tostring(self._goods_count)

			if self._goods_count < self._stable_limit then
				self._control.max_text.gameObject:SetActive(false)
			end

			if self._now_limit and self._goods_count < self._now_limit then
				self._control.max_text.gameObject:SetActive(false)
			end

			self._control.use.text.text = self._goods_info.id >= 1018 and self._goods_info.id <= 1021 and var_0_4(var_0_3:getNowLang("buy_num_desc1"), tonumber(self._goods_info.price * self._goods_count), tonumber(self._goods_count), tostring(self._goods_info.brief)) or var_0_4(var_0_3:getNowLang("buy_num_desc1"), tonumber(self._goods_info.price * self._goods_count), tonumber(self._goods_count), tostring(self._goods_info.title))
			self._control.former_num.text.text = tostring(var_8_0.diamond)
			self._control.latter_num.text.text = tostring(var_8_0.diamond - tonumber(self._goods_info.price * self._goods_count))
		end
	end

	function arg_1_0:__click_plus_btn()
		local var_9_0 = var_0_1:get_use_info_data()

		if self._enter_type == "spoils" then
			if self._goods_count == self._goods_info.now_limit or self._goods_count == self._stable_limit then
				self._control.max_text.gameObject:SetActive(true)

				return
			end

			if var_9_0.spoils - (self._goods_count + 1) * self._goods_info.price >= 0 then
				self._goods_count = self._goods_count + 1
				self._control.count_num.text.text = tostring(self._goods_count)
				self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc2"), tonumber(self._goods_info.price * self._goods_count), tonumber(self._goods_count), tostring(self._goods_info.title))
				self._control.former_num.text.text = tostring(var_9_0.spoils)
				self._control.latter_num.text.text = tostring(var_9_0.spoils - tonumber(self._goods_info.price * self._goods_count))

				if self._goods_count == self._goods_info.now_limit or self._goods_count == self._stable_limit then
					self._control.max_text.gameObject:SetActive(true)
				end
			end
		elseif self._enter_type == "exploit" then
			if self._goods_count == self._goods_info.now_limit or self._goods_count == self._stable_limit then
				self._control.max_text.gameObject:SetActive(true)

				return
			end

			if var_9_0.exploit - (self._goods_count + 1) * self._goods_info.price >= 0 then
				self._goods_count = self._goods_count + 1
				self._control.count_num.text.text = tostring(self._goods_count)
				self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc4"), tonumber(self._goods_info.price * self._goods_count), tonumber(self._goods_count), tostring(self._goods_info.title))
				self._control.former_num.text.text = tostring(var_9_0.exploit)
				self._control.latter_num.text.text = tostring(var_9_0.exploit - tonumber(self._goods_info.price * self._goods_count))

				if self._goods_count == self._goods_info.now_limit or self._goods_count == self._stable_limit then
					self._control.max_text.gameObject:SetActive(true)
				end
			end
		elseif self._enter_type == "combat" then
			if self._goods_count == self._goods_info.now_limit or self._goods_count == self._stable_limit then
				self._control.max_text.gameObject:SetActive(true)

				return
			end

			if self._goods_info.left_combats - (self._goods_count + 1) * self._goods_info.price >= 0 then
				self._goods_count = self._goods_count + 1
				self._control.count_num.text.text = tostring(self._goods_count)
				self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc3"), tonumber(self._goods_info.price * self._goods_count), tonumber(self._goods_count), tostring(self._goods_info.title))
				self._control.former_num.text.text = tostring(self._goods_info.left_combats)
				self._control.latter_num.text.text = tostring(self._goods_info.left_combats - tonumber(self._goods_info.price * self._goods_count))

				if self._goods_count == self._goods_info.now_limit or self._goods_count == self._stable_limit then
					self._control.max_text.gameObject:SetActive(true)
				end
			end
		elseif self._enter_type == "furniture" then
			if self._goods_count == self._stable_limit then
				self._control.max_text.gameObject:SetActive(true)

				return
			end

			if var_9_0.furniture_point - (self._goods_count + 1) * self._goods_info.price >= 0 then
				self._goods_count = self._goods_count + 1
				self._control.count_num.text.text = tostring(self._goods_count)
				self._control.use.text.text = var_0_4(var_0_3:getNowLang("buy_num_desc5"), tonumber(self._goods_info.price * self._goods_count), tonumber(self._goods_count), tostring(self._goods_info.title))
				self._control.former_num.text.text = tostring(var_9_0.furniture_point)
				self._control.latter_num.text.text = tostring(var_9_0.furniture_point - tonumber(self._goods_info.price * self._goods_count))

				if self._goods_count == self._stable_limit then
					self._control.max_text.gameObject:SetActive(true)
				end
			end
		else
			if self._goods_count == self._stable_limit then
				self._control.max_text.gameObject:SetActive(true)

				return
			end

			self._now_limit = self._goods_info.limit_num

			if var_9_0.diamond - (self._goods_count + 1) * self._goods_info.price >= 0 then
				if self._now_limit and self._now_limit ~= 0 and self._goods_count == self._now_limit then
					self._control.max_text.gameObject:SetActive(true)

					return
				end

				self._goods_count = self._goods_count + 1
				self._control.count_num.text.text = tostring(self._goods_count)
				self._control.use.text.text = self._goods_info.id >= 1018 and self._goods_info.id <= 1021 and var_0_4(var_0_3:getNowLang("buy_num_desc1"), tonumber(self._goods_info.price * self._goods_count), tonumber(self._goods_count), tostring(self._goods_info.brief)) or var_0_4(var_0_3:getNowLang("buy_num_desc1"), tonumber(self._goods_info.price * self._goods_count), tonumber(self._goods_count), tostring(self._goods_info.title))
				self._control.former_num.text.text = tostring(var_9_0.diamond)
				self._control.latter_num.text.text = tostring(var_9_0.diamond - tonumber(self._goods_info.price * self._goods_count))

				if self._goods_count == self._stable_limit then
					self._control.max_text.gameObject:SetActive(true)
				end
			end
		end
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_11_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_12_0)
	local var_12_0 = var_0_2:class("shop_bounced_repeat")

	var_12_0:__initia_lize()

	var_12_0._is_long_click_minus_btn = false
	var_12_0._is_long_click_plus_btn = false
	var_12_0._goods_info = {}
	var_12_0._goods_count = 1
	var_12_0._now_limit = nil
	var_12_0._stable_limit = 50

	return var_12_0
end

return var_0_0
