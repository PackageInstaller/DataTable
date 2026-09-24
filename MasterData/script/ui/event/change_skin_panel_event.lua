local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onToggle_right_node_select_all_tog(arg_2_0)
		return
	end

	function arg_1_0:__onClick_right_node_change_btn()
		self:__change_skin()

		local var_3_0 = var_0_1:getInstance("voucher_shop")

		if var_3_0 then
			var_3_0:setVisible(true)

			local var_3_1 = var_0_1:getInstance("mall_shop")

			if var_3_1 then
				var_3_0._panel.transform:GetComponent("Canvas").sortingOrder = var_3_1._panel.transform:GetComponent("Canvas").sortingOrder + 1
			end
		end
	end

	function arg_1_0.__onClick_right_node_cancel_btn(arg_4_0)
		local var_4_0 = var_0_1:getInstance("new_ship_or_equip")

		if var_4_0 then
			var_4_0:leave_ship()
		end

		local var_4_1 = var_0_1:getInstance("voucher_shop")

		if var_4_1 then
			var_4_1:setVisible(true)

			local var_4_2 = var_0_1:getInstance("mall_shop")

			if var_4_2 then
				var_4_1._panel.transform:GetComponent("Canvas").sortingOrder = var_4_2._panel.transform:GetComponent("Canvas").sortingOrder + 1
			end
		end

		local var_4_3 = var_0_1:getInstance("ship_detail")
		local var_4_4 = var_0_1:getInstance("mall_shop")

		if var_4_4 and not var_4_3 and not var_4_1 then
			var_4_4:setVisible(true)
		end

		var_0_1:destroyInstance("change_skin_panel")
	end

	function arg_1_0:__onClick_left_node_next_btn()
		self:__next_panel()
	end

	function arg_1_0:__onClick_left_node_last_btn()
		self:__last_panel()
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
