local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.user
local var_0_6 = gameconfig.equip_config

gamecore.UILoader:define("equip_sort_layer", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)
		self:__init_panel(arg_3_1)
	end

	function arg_1_0:__init_panel(arg_4_1)
		self:__init_data()
		self:__init_language()
	end

	function arg_1_0:__init_language()
		self._sort_type[1].tip.text.text = var_0_2:getNowLang("type")
		self._sort_type[2].tip.text.text = var_0_2:getNowLang("rarity")
		self._sort_type[3].tip.text.text = var_0_2:getNowLang("hp")
		self._sort_type[4].tip.text.text = var_0_2:getNowLang("atk")
		self._sort_type[5].tip.text.text = var_0_2:getNowLang("def")
		self._sort_type[6].tip.text.text = var_0_2:getNowLang("equip3")
		self._sort_type[7].tip.text.text = var_0_2:getNowLang("miss")
		self._sort_type[8].tip.text.text = var_0_2:getNowLang("airdef")
		self._sort_type[9].tip.text.text = var_0_2:getNowLang("antisub")
		self._sort_type[10].tip.text.text = var_0_2:getNowLang("aircraftatk")
		self._sort_type[11].tip.text.text = var_0_2:getNowLang("radar")
		self._sort_type[12].tip.text.text = var_0_2:getNowLang("cardattribute5")
		self._sort_type[13].tip.text.text = var_0_2:getNowLang("hit")
		self._sort_type[14].tip.text.text = var_0_2:getNowLang("missilehit")
		self._sort_type[15].tip.text.text = var_0_2:getNowLang("missiletmd")
		self._sort_type[16].tip.text.text = var_0_2:getNowLang("aluminium_use")
		self._sort_type[17].tip.text.text = var_0_2:getNowLang("air_def_correct")
		self._sort_type[18].tip.text.text = var_0_2:getNowLang("air_def_rate")
		self._control.bg.filter_type.type_txt.text.text = var_0_2:getNowLang("sortlabel")
		self._control.bg.sort_info.sort_down.sort_down_txt.text.text = var_0_2:getNowLang("ascending_order")
		self._control.bg.sort_info.sort_up.sort_up_txt.text.text = var_0_2:getNowLang("ascending_sort")
	end

	function arg_1_0:__init_data()
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
			self._control.bg.sort_btn_group.sorttype18
		}

		if self._sort_type_num then
			for iter_6_0, iter_6_1 in pairs(self._sort_type) do
				iter_6_1.image.sprite = iter_6_0 == self._sort_type_num and self:loadSprite(var_0_4.sort_type_const.selected1) or self:loadSprite(var_0_4.sort_type_const.btn1)
			end
		end

		if self._sort_type_state == 1 then
			self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_4.sort_type_const.selected1)
			self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_4.sort_type_const.btn1)
		else
			self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_4.sort_type_const.btn1)
			self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_4.sort_type_const.selected1)
		end

		self._old_equip_list = var_0_5:get_now_equip_list()

		if not self._init_already and not next(self._equip_list) then
			for iter_6_2, iter_6_3 in ipairs(self._old_equip_list) do
				if iter_6_3 and iter_6_3.id then
					local var_6_0 = var_0_6.find_object_by_cid(iter_6_3.id)

					var_6_0.num = iter_6_3.num
					var_6_0.lock = iter_6_3.lock
					var_6_0.id = iter_6_3.id

					table.insert(self._equip_list, var_6_0)
				end
			end

			self._init_already = true
		end
	end

	function arg_1_0.set_listener(arg_7_0, arg_7_1, arg_7_2)
		arg_7_0._source_data = arg_7_1
		arg_7_0._click_listener = arg_7_2
	end

	function arg_1_0.set_sort_func(arg_8_0, arg_8_1)
		arg_8_0._sort_func = arg_8_1
	end

	function arg_1_0:sort_table_by_rule(arg_9_1)
		if self._equip_list and next(self._equip_list) then
			return self._equip_list
		else
			return arg_9_1
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
	local var_12_0 = var_0_1:class("equip_sort_layer")

	var_12_0:__initia_lize()

	var_12_0._sort_type = nil
	var_12_0._sort_type_num = 1
	var_12_0._sort_type_state = 2
	var_12_0._equip_list = {}
	var_12_0._old_equip_list = {}
	var_12_0._init_already = false

	return var_12_0
end

return var_0_0
