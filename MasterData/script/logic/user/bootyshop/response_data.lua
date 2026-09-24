local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.error_type
local var_0_4 = gamecore.prompt
local var_0_7 = gamecore.user
local var_0_8 = gameconfig.spoils_shop_config
local var_0_16 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:SpoilsBuyResp(arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("bootyshop")

			if not var_2_0 then
				var_2_0 = var_0_1:createInstance("bootyshop")

				var_2_0:show()

				return
			end

			var_2_0:set_coin_num((var_0_7:get_use_info_data()))

			self._data_id_info = var_0_8.find_object_by_id(arg_2_1.id)

			if self._data_id_info.type == 1 then
				var_0_1:createInstance("new_ship_or_equip"):show(true, {
					count = 1,
					type = 1,
					id = self._data_id_info.award_cid,
					is_new = arg_2_1.is_new
				}, var_0_16.enter_get_ship_type.spoils_shop)
			elseif self._data_id_info.type == 2 then
				var_0_1:createInstance("new_ship_or_equip"):show(true, {
					count = 1,
					type = 4,
					id = arg_2_1.ship,
					is_new = arg_2_1.is_new
				}, var_0_16.enter_get_ship_type.spoils_shop)
			elseif self._data_id_info.type == 3 then
				var_0_1:createInstance("reward_tip"):show(self._data_id_info.award_cid, var_0_16.enter_get_ship_type.bootyshop_clothes)
			elseif self._data_id_info.type == 4 and (arg_2_1.id == 5007 or arg_2_1.id == 4013) then
				var_0_1:createInstance("teacher_get"):show(self._data_id_info.award_cid)
			elseif self._data_id_info.type == 9 then
				var_0_1:createInstance("reward_tip"):show_by_enter_type(nil, var_0_16.enter_icon_detail_type.picture_panel, nil, self._data_id_info.award.id)
			else
				var_0_4:show(var_0_2:getNowLang("shopbuysuccess"))
			end

			var_2_0:updata_data()
			var_2_0:__set__now_data(var_2_0._now_label, true)
		else
			var_0_1:createInstance("bootyshop"):updata_data()
			var_0_4:show(var_0_3:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0:MultiSpoilsBuyResp(arg_3_1)
		if arg_3_1.result == 0 then
			local var_3_0 = var_0_1:getInstance("bootyshop")

			if not var_3_0 then
				var_3_0 = var_0_1:createInstance("bootyshop")

				var_3_0:show()

				return
			end

			var_3_0:set_coin_num((var_0_7:get_use_info_data()))

			self._data_id_info = var_0_8.find_object_by_id(arg_3_1.id)

			if self._data_id_info.type == 1 then
				var_0_1:createInstance("new_ship_or_equip"):show(true, {
					count = 1,
					type = 1,
					id = self._data_id_info.award_cid,
					is_new = arg_3_1.is_new
				}, var_0_16.enter_get_ship_type.spoils_shop)
			elseif self._data_id_info.type == 2 then
				var_0_1:createInstance("new_ship_or_equip"):show(true, {
					count = 1,
					type = 4,
					id = arg_3_1.ship,
					is_new = arg_3_1.is_new
				}, var_0_16.enter_get_ship_type.spoils_shop)
			elseif self._data_id_info.type == 3 then
				var_0_1:createInstance("reward_tip"):show(self._data_id_info.award_cid, var_0_16.enter_get_ship_type.bootyshop_clothes)
			elseif self._data_id_info.type == 4 and (arg_3_1.id == 5007 or arg_3_1.id == 4013) then
				var_0_1:createInstance("teacher_get"):show(self._data_id_info.award_cid)
			elseif self._data_id_info.type == 9 then
				var_0_1:createInstance("reward_tip"):show_by_enter_type(nil, var_0_16.enter_icon_detail_type.picture_panel, nil, self._data_id_info.award.id)
			else
				var_0_4:show(var_0_2:getNowLang("shopbuysuccess"))
			end

			var_3_0:updata_data()
			var_3_0:__set__now_data(var_3_0._now_label, true)
		else
			var_0_1:createInstance("bootyshop"):updata_data()
			var_0_4:show(var_0_3:get_err_msg(arg_3_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_4_0)
	arg_4_0._data_id_info = nil
end

return var_0_0
