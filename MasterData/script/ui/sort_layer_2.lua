local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = table.sort
local var_0_5 = gamecore.util_func
local var_0_6 = gameenum.common_type
local var_0_7 = gameconfig.ship_config

gamecore.UILoader:define("sort_layer_2", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(arg_3_1)
		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self:_init_data()
		self:__init_language()
	end

	function arg_1_0:__init_language()
		if not self._is_already_init then
			self._sort_id = 3
			self._control.bg.filter_type.type_txt.text.text = var_0_1:getNowLang("sorttype")
			self._control.bg.sort_btn_group.sorttype1.tip.text.text = var_0_1:getNowLang("active_buff_level")
			self._control.bg.sort_btn_group.sorttype2.tip.text.text = var_0_1:getNowLang("type")
			self._control.bg.sort_btn_group.sorttype3.tip.text.text = var_0_1:getNowLang("rarity")
			self._control.bg.sort_btn_group.sorttype4.tip.text.text = var_0_1:getNowLang("hp")
			self._control.bg.sort_btn_group.sorttype5.tip.text.text = var_0_1:getNowLang("atk")
			self._control.bg.sort_btn_group.sorttype6.tip.text.text = var_0_1:getNowLang("def")
			self._control.bg.sort_btn_group.sorttype7.tip.text.text = var_0_1:getNowLang("equip3")
			self._control.bg.sort_btn_group.sorttype8.tip.text.text = var_0_1:getNowLang("miss")
			self._control.bg.sort_btn_group.sorttype9.tip.text.text = var_0_1:getNowLang("airdef")
			self._control.bg.sort_btn_group.sorttype10.tip.text.text = var_0_1:getNowLang("antisub")
			self._control.bg.sort_btn_group.sorttype11.tip.text.text = var_0_1:getNowLang("speed")
			self._control.bg.sort_btn_group.sorttype12.tip.text.text = var_0_1:getNowLang("radar")
			self._control.bg.sort_btn_group.sorttype13.tip.text.text = var_0_1:getNowLang("cardattribute5")
			self._control.bg.sort_btn_group.sorttype14.tip.text.text = var_0_1:getNowLang("get_time")
			self._control.bg.sort_btn_group.sorttype15.tip.text.text = var_0_1:getNowLang("love_num")
			self._control.bg.sort_btn_group.sorttype16.tip.text.text = var_0_1:getNowLang("ammo")
			self._control.bg.sort_btn_group.sorttype17.tip.text.text = var_0_1:getNowLang("fuel")
			self._control.bg.sort_btn_group.sorttype18.tip.text.text = var_0_1:getNowLang("ship_index")

			local var_5_0 = var_0_3:get_cook_common_state()

			self._control.bg.sort_btn_group.sorttype19.tip.text.text = var_5_0 and var_0_1:getNowLang("goodat") or var_0_1:getNowLang("tactics_level")
			self._control.bg.sort_info.sort_up.sort_up_txt.text.text = var_0_1:getNowLang("ascending_sort")
			self._control.bg.sort_info.sort_down.sort_down_txt.text.text = var_0_1:getNowLang("ascending_order")
			self._control.bg.select_info.cancel.cancel_txt.text.text = var_0_1:getNowLang("cancel")
			self._control.bg.select_info.confirm.confirm_txt.text.text = var_0_1:getNowLang("confirm")

			self:__init_sort_func()

			self._is_already_init = true

			if var_0_3:get_statics_common_state() or var_5_0 then
				self._now_select_sort_layer_num = 19

				self._sort_type[19]:SetActive(true)

				self._sort_type[19].image.sprite = self:loadSprite(var_0_6.sort_type_const.selected1)
			else
				self._now_select_sort_layer_num = 1

				self._sort_type[19]:SetActive(false)

				self._sort_type[1].image.sprite = self:loadSprite(var_0_6.sort_type_const.selected1)
			end

			self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_6.sort_type_const.selected2)
			self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_6.sort_type_const.btn2)
		end
	end

	function arg_1_0:_init_data()
		self._sort_type = {
			self._control.bg.sort_btn_group.sorttype1,
			self._control.bg.sort_btn_group.sorttype2,
			self._control.bg.sort_btn_group.sorttype3,
			self._control.bg.sort_btn_group.sorttype4,
			self._control.bg.sort_btn_group.sorttype5,
			self._control.bg.sort_btn_group.sorttype6,
			self._control.bg.sort_btn_group.sorttype7,
			self._control.bg.sort_btn_group.sorttype8,
			self._control.bg.sort_btn_group.sorttype9,
			self._control.bg.sort_btn_group.sorttype10,
			self._control.bg.sort_btn_group.sorttype11,
			self._control.bg.sort_btn_group.sorttype12,
			self._control.bg.sort_btn_group.sorttype13,
			self._control.bg.sort_btn_group.sorttype14,
			self._control.bg.sort_btn_group.sorttype15,
			self._control.bg.sort_btn_group.sorttype16,
			self._control.bg.sort_btn_group.sorttype17,
			self._control.bg.sort_btn_group.sorttype18,
			self._control.bg.sort_btn_group.sorttype19
		}

		if self._sort_type_state and self._sort_type_state == 1 then
			self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_6.sort_type_const.btn2)
			self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_6.sort_type_const.selected2)
		elseif self._sort_type_state and self._sort_type_state == 2 then
			self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_6.sort_type_const.selected2)
			self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_6.sort_type_const.btn2)
		end
	end

	function arg_1_0.set_cost_sort_btn_active(arg_7_0, arg_7_1)
		return
	end

	function arg_1_0.set_sort_func(arg_8_0, arg_8_1)
		arg_8_0._sort_func = arg_8_1
	end

	function arg_1_0.set_sort_id(arg_9_0, arg_9_1)
		arg_9_0._sort_id = arg_9_1
	end

	function arg_1_0:sort_table_by_rule(arg_10_1)
		if not arg_10_1 then
			return
		end

		if self._now_select_sort_layer_num and self._now_select_sort_layer_num > 3 and self._now_select_sort_layer_num < 14 then
			for iter_10_0, iter_10_1 in pairs(arg_10_1) do
				iter_10_1.data_tmp = var_0_5:get_ship_attr(iter_10_1, (var_0_7.find_object_by_cid(iter_10_1.cid)))
			end
		end

		var_0_4(arg_10_1, self._sort_func)

		return arg_10_1
	end

	function arg_1_0.set_listener(arg_11_0, arg_11_1, arg_11_2)
		arg_11_0._source_data = arg_11_1
		arg_11_0._click_listener = arg_11_2
	end

	function arg_1_0:change_sort_text(arg_12_1, arg_12_2)
		local var_12_0 = var_0_3:get_cook_common_state() and {
			"active_buff_level",
			"type",
			"rarity",
			"hp",
			"atk",
			"def",
			"equip3",
			"miss",
			"airdef",
			"antisub",
			"speed",
			"radar",
			"cardattribute5",
			"get_time",
			"love_num",
			"ammo",
			"fuel",
			"ship_index",
			"goodat"
		} or {
			"active_buff_level",
			"type",
			"rarity",
			"hp",
			"atk",
			"def",
			"equip3",
			"miss",
			"airdef",
			"antisub",
			"speed",
			"radar",
			"cardattribute5",
			"get_time",
			"love_num",
			"ammo",
			"fuel",
			"ship_index",
			"tactics_level"
		}

		arg_12_1.text.text = self._sort_type_state == 2 and var_0_1:getNowLang(var_12_0[self._now_select_sort_layer_num]) .. var_0_1:getNowLang("arrow_up") or var_0_1:getNowLang(var_12_0[self._now_select_sort_layer_num]) .. var_0_1:getNowLang("arrow_down")
	end

	function arg_1_0:__init_sort_func()
		self._sort_func = var_0_3:get_statics_common_state() and (self._sort_func or function(arg_14_0, arg_14_1)
			if arg_14_0.tactics_exp == arg_14_1.tactics_exp then
				if arg_14_0.type == arg_14_1.type then
					if arg_14_0.cid == arg_14_1.cid then
						return arg_14_0.id > arg_14_1.id
					else
						return arg_14_0.cid > arg_14_1.cid
					end
				else
					return arg_14_0.type < arg_14_1.type
				end
			else
				return arg_14_0.tactics_exp > arg_14_1.tactics_exp
			end
		end) or var_0_3:get_cook_common_state() and (self._sort_func or function(arg_15_0, arg_15_1)
			if arg_15_0.cook_exp == arg_15_1.cook_exp then
				if arg_15_0.type == arg_15_1.type then
					if arg_15_0.cid == arg_15_1.cid then
						return arg_15_0.id > arg_15_1.id
					else
						return arg_15_0.cid > arg_15_1.cid
					end
				else
					return arg_15_0.type < arg_15_1.type
				end
			else
				return arg_15_0.cook_exp > arg_15_1.cook_exp
			end
		end) or self._sort_func or function(arg_16_0, arg_16_1)
			if arg_16_0.level == arg_16_1.level then
				if arg_16_0.type == arg_16_1.type then
					if arg_16_0.cid == arg_16_1.cid then
						return arg_16_0.id > arg_16_1.id
					else
						return arg_16_0.cid > arg_16_1.cid
					end
				else
					return arg_16_0.type < arg_16_1.type
				end
			else
				return arg_16_0.level > arg_16_1.level
			end
		end
	end

	function arg_1_0:abyss_special_sort_table_by_rule(arg_17_1, arg_17_2, arg_17_3)
		local var_17_0 = {}
		local var_17_1 = {}

		if arg_17_2 then
			self:set_sort_func(function(arg_18_0, arg_18_1)
				if arg_18_0.star == arg_18_1.star then
					if arg_18_0.type == arg_18_1.type then
						return arg_18_0.cid > arg_18_1.cid
					else
						return arg_18_0.type < arg_18_1.type
					end
				else
					return arg_18_0.star > arg_18_1.star
				end
			end)
			self:__change_img(5)
			self:change_sort_text(arg_17_3, "sorttypes5")
		end

		for iter_17_0, iter_17_1 in pairs(arg_17_1) do
			if iter_17_1.boss == 1 then
				table.insert(var_17_0, iter_17_1)
			else
				table.insert(var_17_1, iter_17_1)
			end
		end

		var_0_4(var_17_0, self._sort_func)
		var_0_4(var_17_1, self._sort_func)

		return (var_0_5.concat_array(var_17_0, var_17_1))
	end

	function arg_1_0:reset_select_state()
		self._sort_func = nil

		self:__init_sort_func()

		for iter_19_0 = 1, 19 do
			if iter_19_0 == 1 then
				self._control.bg.sort_btn_group["sorttype" .. 1].image.sprite = self:loadSprite(var_0_6.sort_type_const.selected1)
			else
				self._control.bg.sort_btn_group["sorttype" .. iter_19_0].image.sprite = self:loadSprite(var_0_6.sort_type_const.btn1)
			end
		end
	end

	function arg_1_0:reset_tactics_select_state()
		self._sort_func = nil

		self:__init_sort_func()

		for iter_20_0 = 1, 19 do
			if iter_20_0 == 19 then
				self._control.bg.sort_btn_group["sorttype" .. 19].image.sprite = self:loadSprite(var_0_6.sort_type_const.selected1)
			else
				self._control.bg.sort_btn_group["sorttype" .. iter_20_0].image.sprite = self:loadSprite(var_0_6.sort_type_const.btn1)
			end
		end
	end

	function arg_1_0:reset_cook_select_state()
		self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_6.sort_type_const.selected2)
		self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_6.sort_type_const.btn2)
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_23_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_24_0)
	local var_24_0 = var_0_2:class("sort_layer_2")

	var_24_0:__initia_lize()

	var_24_0._is_already_init = false
	var_24_0._sort_func = nil
	var_24_0._sort_id = nil
	var_24_0._click_listener = nil
	var_24_0._source_data = nil
	var_24_0._now_select_sort_layer_type = "sorttypes1"
	var_24_0._now_select_sort_layer_num = 1
	var_24_0._sort_type = nil
	var_24_0._sort_type_state = 1

	return var_24_0
end

return var_0_0
