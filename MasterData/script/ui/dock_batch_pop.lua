local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = string.format
local var_0_5 = table.insert
local var_0_6 = gameenum.common_type
local var_0_7 = gamecore.util_func

gamecore.UILoader:define("dock_batch_pop", function(arg_1_0)
	function arg_1_0:update_data()
		if not self._already_init then
			return
		end

		if self._data.pos_type == var_0_6.pool_type.ship_build then
			self._control.content.top.title.text.text = var_0_1:getNowLang("buildboat")
			self._control.content.contains.res_need.need_iten_5.icon.image.sprite = self:loadSprite(var_0_4(var_0_6.common_icon.common_source, "7"))
		elseif self._data.pos_type == var_0_6.pool_type.equipment_build then
			self._control.content.top.title.text.text = var_0_1:getNowLang("buildequip")
			self._control.content.contains.res_need.need_iten_5.icon.image.sprite = self:loadSprite(var_0_4(var_0_6.common_icon.common_source, "8"))
		end

		for iter_2_0, iter_2_1 in ipairs(self.res_need_contents) do
			iter_2_1.num.text.text = iter_2_0 > 4 and self._batch_num or iter_2_0 == 1 and self._data.oil * self._batch_num or iter_2_0 == 2 and self._data.bullet * self._batch_num or iter_2_0 == 3 and self._data.fe * self._batch_num or self._data.al * self._batch_num

			local var_2_0 = tonumber(iter_2_1.num.text.text)

			user_num = self:__get_res_num(iter_2_0)

			if var_2_0 <= user_num then
				if iter_2_0 == 1 then
					self.not_oil = false
				elseif iter_2_0 == 2 then
					self.not_bullet = false
				elseif iter_2_0 == 3 then
					self.not_steel = false
				elseif iter_2_0 == 4 then
					self.not_aluminium = false
				elseif iter_2_0 == 5 then
					self.not_fast_build = false
				elseif iter_2_0 == 6 then
					self.not_blue_map = false
				end

				iter_2_1.num.text.color = Color.New(0, 0, 0)
			else
				if iter_2_0 == 1 then
					self.not_oil = true
				elseif iter_2_0 == 2 then
					self.not_bullet = true
				elseif iter_2_0 == 3 then
					self.not_steel = true
				elseif iter_2_0 == 4 then
					self.not_aluminium = true
				elseif iter_2_0 == 5 then
					self.not_fast_build = true
				elseif iter_2_0 == 6 then
					self.not_blue_map = true
				end

				iter_2_1.num.text.color = Color.New(1, 0, 0)
			end
		end
	end

	function arg_1_0:__onVisible(arg_3_1, arg_3_2)
		if not arg_3_1 then
			return
		end

		self._control.tips:SetActive(false)

		self._data = arg_3_2
		self._control.content.contains.num.text.text = 1
		self._batch_num = 1

		self:__init_panel()
		self:update_data()
	end

	function arg_1_0:__init_panel()
		if self._already_init then
			return
		end

		self:__init_title_name()

		self.res_need_contents = {}

		for iter_4_0 = 1, self._control.content.contains.res_need.transform.childCount do
			var_0_5(self.res_need_contents, self._control.content.contains.res_need.transform:GetChild(iter_4_0 - 1).gameObject)
		end

		self._already_init = true
	end

	function arg_1_0:__init_title_name()
		self._control.content.contains.build_title.text.text = var_0_1:getNowLang("buildnum")
		self._control.content.contains.res_need_title.text.text = var_0_1:getNowLang("resneed")
		self._control.content.contains.confirm_btn.text.text.text = var_0_1:getNowLang("ui_cbtn1")
		self._control.content.contains.cancel_btn.text.text.text = var_0_1:getNowLang("ui_cbtn2")
	end

	function arg_1_0:__set_build_num(arg_6_1, arg_6_2)
		self._control.tips:SetActive(false)

		local var_6_0 = tonumber(self._control.content.contains.num.text.text) + arg_6_1
		local var_6_1
		local var_6_2 = var_0_7.dict_lenght(var_0_3:get_character_list())
		local var_6_3 = var_0_3:get_equipment_count()

		if self._data.pos_type == var_0_6.pool_type.ship_build then
			if self.user_data.max_ship - var_6_2 <= 0 then
				var_6_1 = 1
			end

			if self.user_data.max_ship - var_6_2 > 0 and self.user_data.max_ship - var_6_2 <= 10 then
				var_6_1 = self.user_data.max_ship - var_6_2
			end

			if self.user_data.max_ship - var_6_2 > 10 then
				var_6_1 = 10
			end
		elseif self._data.pos_type == var_0_6.pool_type.equipment_build then
			if self.user_data.max_equip - var_6_3 < 0 then
				var_6_1 = 1
			end

			if self.user_data.max_equip - var_6_3 > 0 and self.user_data.max_equip - var_6_3 <= 10 then
				var_6_1 = self.user_data.max_equip - var_6_3
			end

			if self.user_data.max_equip - var_6_3 >= 10 then
				var_6_1 = 10
			end
		end

		if var_6_1 <= var_6_0 then
			var_6_0 = var_6_1

			if self._data.pos_type == var_0_6.pool_type.ship_build and self.user_data.max_ship - var_6_2 > 0 and self.user_data.max_ship - var_6_2 < 10 then
				self._control.tips:SetActive(true)

				self._control.tips.txt.text.text = string.format(var_0_1:getNowLang("maxcapacity"), var_6_1)
			elseif self._data.pos_type == var_0_6.pool_type.equipment_build and self.user_data.max_equip - var_6_3 > 0 and self.user_data.max_equip - var_6_3 < 10 then
				self._control.tips:SetActive(true)

				self._control.tips.txt.text.text = string.format(var_0_1:getNowLang("maxequipcapacity"), var_6_1)
			end
		elseif var_6_0 <= 0 then
			var_6_0 = 1

			self._control.tips:SetActive(false)
		end

		if arg_6_2 then
			var_6_0 = arg_6_2
		end

		self._batch_num = var_6_0
		self._control.content.contains.num.text.text = self._batch_num
	end

	function arg_1_0:__get_res_num(arg_7_1)
		self.user_data = var_0_3:get_use_info_data()

		local var_7_0 = var_0_3:get_item_count(var_0_6.ship_item_cid.fast_build)
		local var_7_1 = {}

		if self._data.pos_type == var_0_6.pool_type.ship_build then
			var_7_1 = {
				self.user_data.oil,
				self.user_data.bullet,
				self.user_data.fe,
				self.user_data.al,
				var_0_3:get_item_count(var_0_6.ship_item_cid.ship_blueprint),
				var_7_0
			}
		elseif self._data.pos_type == var_0_6.pool_type.equipment_build then
			var_7_1 = {
				self.user_data.oil,
				self.user_data.bullet,
				self.user_data.fe,
				self.user_data.al,
				var_0_3:get_item_count(var_0_6.ship_item_cid.equip_blueprint),
				var_7_0
			}
		end

		if arg_7_1 > #var_7_1 then
			var_7_1[arg_7_1] = 0
		end

		return var_7_1[arg_7_1]
	end

	function arg_1_0.__onReset(arg_8_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_9_0)
	local var_9_0 = var_0_2:class("dock_batch_pop")

	var_9_0._already_init = false
	var_9_0._batch_num = 1
	var_9_0.res_need_contents = {}
	var_9_0._data = {}
	var_9_0.user_data = {}
	var_9_0.not_oil = false
	var_9_0.not_bullet = false
	var_9_0.not_steel = false
	var_9_0.not_aluminium = false
	var_9_0.not_fast_build = false
	var_9_0.not_blue_map = false

	return var_9_0
end

return var_0_0
