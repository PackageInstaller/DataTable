local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.util_func
local var_0_5 = gamecore.prompt
local var_0_6 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_content_contains_minus_btn()
		self:__set_build_num(-1)
		self:update_data()
	end

	function arg_1_0:__onClick_content_contains_plus_btn()
		self:__set_build_num(1)
		self:update_data()
	end

	function arg_1_0:__onClick_content_contains_max_btn()
		local var_4_0

		if self._data.pos_type == var_0_2.pool_type.ship_build then
			local var_4_1 = var_0_3.dict_lenght(var_0_1:get_character_list())

			if self.user_data.max_ship - var_4_1 <= 0 then
				var_4_0 = 1
			end

			if self.user_data.max_ship - var_4_1 > 0 and self.user_data.max_ship - var_4_1 <= 10 then
				var_4_0 = self.user_data.max_ship - var_4_1

				self._control.tips:SetActive(true)

				self._control.tips.txt.text.text = string.format(var_0_6:getNowLang("maxcapacity"), var_4_0)
			end

			if self.user_data.max_ship - var_4_1 > 10 then
				var_4_0 = 10
			end
		elseif self._data.pos_type == var_0_2.pool_type.equipment_build then
			local var_4_2 = var_0_1:get_equipment_count()

			if self.user_data.max_equip - var_4_2 <= 0 then
				var_4_0 = 1
			end

			if self.user_data.max_equip - var_4_2 > 0 and self.user_data.max_equip - var_4_2 <= 10 then
				var_4_0 = self.user_data.max_equip - var_4_2

				self._control.tips:SetActive(true)

				self._control.tips.txt.text.text = string.format(var_0_6:getNowLang("maxequipcapacity"), var_4_0)
			end

			if self.user_data.max_equip - var_4_2 > 10 then
				var_4_0 = 10
			end
		end

		self:__set_build_num(var_4_0, var_4_0)
		self:update_data()
	end

	function arg_1_0:__onClick_content_contains_confirm_btn()
		if self.not_fast_build == true or self.not_blue_map == true or self.not_oil == true or self.not_bullet == true or self.not_steel == true or self.not_aluminium == true then
			var_0_5:show(var_0_6:getNowLang("supplyresfirst"))

			return
		end

		self:setVisible(false)

		local var_5_0 = {
			count = self._batch_num,
			oil = self._data.oil,
			bullet = self._data.bullet,
			fe = self._data.fe,
			al = self._data.al
		}

		if self._data.pos_type == var_0_2.pool_type.ship_build then
			var_0_1:req_BatchBuildShip(var_5_0)
		elseif self._data.pos_type == var_0_2.pool_type.equipment_build then
			var_0_1:req_BatchBuildEquipment(var_5_0)
		end
	end

	function arg_1_0:__onClick_content_contains_cancel_btn()
		self:setVisible(false)
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
