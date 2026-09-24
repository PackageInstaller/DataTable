local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_4 = table.sort
local var_0_5 = gamecore.util_func
local var_0_6 = gameenum.common_type

gamecore.UILoader:define("sort_layer", function(arg_1_0)
	function arg_1_0:set_cost_sort_btn_active(arg_2_1)
		self._control.bg.sort_btn_group.sorttype11:SetActive(arg_2_1 or false)
		self._control.bg.sort_btn_group.sorttype12:SetActive(arg_2_1 or false)
	end

	function arg_1_0.set_sort_func(arg_3_0, arg_3_1)
		arg_3_0._sort_func = arg_3_1
	end

	function arg_1_0.set_sort_id(arg_4_0, arg_4_1)
		arg_4_0._sort_id = arg_4_1
	end

	function arg_1_0:sort_table_by_rule(arg_5_1)
		if not arg_5_1 then
			return
		end

		var_0_4(arg_5_1, self._sort_func)

		return arg_5_1
	end

	function arg_1_0.set_listener(arg_6_0, arg_6_1, arg_6_2)
		arg_6_0._source_data = arg_6_1
		arg_6_0._click_listener = arg_6_2
	end

	function arg_1_0.change_sort_text(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1.text.text = var_0_1:getNowLang(arg_7_2)
	end

	function arg_1_0:show(arg_8_1)
		self:setVisible(arg_8_1)
		self:__init_panel()
	end

	function arg_1_0:close_preference_screening_visible(arg_9_1)
		self._control.bg.sort_btn_group.sorttype9:SetActive(not arg_9_1)
		self._control.bg.sort_btn_group.sorttype10:SetActive(not arg_9_1)
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self._sort_id = 3
			self._control.bg.filter_type.type_txt.text.text = var_0_1:getNowLang("sorttype")
			self._control.bg.sort_btn_group.sorttype1.tip.text.text = var_0_1:getNowLang("sorttype1")
			self._control.bg.sort_btn_group.sorttype2.tip.text.text = var_0_1:getNowLang("sorttype2")
			self._control.bg.sort_btn_group.sorttype3.tip.text.text = var_0_1:getNowLang("sorttype3")
			self._control.bg.sort_btn_group.sorttype4.tip.text.text = var_0_1:getNowLang("sorttype4")
			self._control.bg.sort_btn_group.sorttype5.tip.text.text = var_0_1:getNowLang("sorttype5")
			self._control.bg.sort_btn_group.sorttype6.tip.text.text = var_0_1:getNowLang("sorttype6")
			self._control.bg.sort_btn_group.sorttype7.tip.text.text = var_0_1:getNowLang("sorttype7")
			self._control.bg.sort_btn_group.sorttype8.tip.text.text = var_0_1:getNowLang("sorttype8")
			self._control.bg.sort_btn_group.sorttype9.tip.text.text = var_0_1:getNowLang("sorttype9")
			self._control.bg.sort_btn_group.sorttype10.tip.text.text = var_0_1:getNowLang("sorttype10")
			self._control.bg.sort_btn_group.sorttype11.tip.text.text = var_0_1:getNowLang("sorttype11")
			self._control.bg.sort_btn_group.sorttype12.tip.text.text = var_0_1:getNowLang("sorttype12")

			self:__init_sort_func()

			self._is_already_init = true
		end
	end

	function arg_1_0:__init_sort_func()
		self._sort_func = self._sort_func or function(arg_12_0, arg_12_1)
			if arg_12_0.level == arg_12_1.level then
				if arg_12_0.type == arg_12_1.type then
					if arg_12_0.cid == arg_12_1.cid then
						return arg_12_0.id > arg_12_1.id
					else
						return arg_12_0.cid > arg_12_1.cid
					end
				else
					return arg_12_0.type < arg_12_1.type
				end
			else
				return arg_12_0.level > arg_12_1.level
			end
		end
	end

	function arg_1_0:abyss_special_sort_table_by_rule(arg_13_1, arg_13_2, arg_13_3)
		local var_13_0 = {}
		local var_13_1 = {}

		if arg_13_2 then
			self:set_sort_func(function(arg_14_0, arg_14_1)
				if arg_14_0.star == arg_14_1.star then
					if arg_14_0.type == arg_14_1.type then
						return arg_14_0.cid > arg_14_1.cid
					else
						return arg_14_0.type < arg_14_1.type
					end
				else
					return arg_14_0.star > arg_14_1.star
				end
			end)
			self:__change_img(5)
			self:change_sort_text(arg_13_3, "sorttypes5")
		end

		for iter_13_0, iter_13_1 in pairs(arg_13_1) do
			if iter_13_1.boss == 1 then
				table.insert(var_13_0, iter_13_1)
			else
				table.insert(var_13_1, iter_13_1)
			end
		end

		var_0_4(var_13_0, self._sort_func)
		var_0_4(var_13_1, self._sort_func)

		return (var_0_5.concat_array(var_13_0, var_13_1))
	end

	function arg_1_0:reset_select_state()
		self._sort_func = nil

		self:__init_sort_func()

		for iter_15_0 = 1, 10 do
			if iter_15_0 == 3 then
				self._control.bg.sort_btn_group["sorttype" .. 3].image.sprite = self:loadSprite(var_0_6.sort_type_const.selected2)
			else
				self._control.bg.sort_btn_group["sorttype" .. iter_15_0].image.sprite = self:loadSprite(var_0_6.sort_type_const.btn2)
			end
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_16_0)
	local var_16_0 = var_0_2:class("sort_layer")

	var_16_0._is_already_init = false
	var_16_0._sort_func = nil
	var_16_0._sort_id = nil
	var_16_0._click_listener = nil
	var_16_0._source_data = nil

	gamecore.extend_obj(var_16_0)

	return var_16_0
end

return var_0_0
