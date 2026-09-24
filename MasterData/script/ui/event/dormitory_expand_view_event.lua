local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_expand_btn()
		var_0_1:createInstance("shop_bounced"):show({
			price = self:__get_dormitory_expand_price(),
			title = var_0_2:getNowLang("roomexpand")
		}, var_0_4.buy_enter_type.dormitory)
	end

	function arg_1_0.__get_dormitory_expand_price(arg_3_0)
		local var_3_0 = 0
		local var_3_1 = var_0_3:get_dormitory_room_num()

		if var_3_1 == 2 then
			var_3_0 = var_0_4.dormitory_const.expand_const.first_price
		elseif var_3_1 == 3 then
			var_3_0 = var_0_4.dormitory_const.expand_const.second_price
		elseif var_3_1 == 4 then
			var_3_0 = var_0_4.dormitory_const.expand_const.third_price
		elseif var_3_1 == 5 then
			var_3_0 = var_0_4.dormitory_const.expand_const.four_price
		end

		return var_3_0
	end

	function arg_1_0.__onClick_base_panel_top_return_btn(arg_4_0)
		var_0_1:destroyInstance("dormitory_expand_view")
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
