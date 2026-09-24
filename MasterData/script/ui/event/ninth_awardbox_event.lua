local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_awardbox_bg_top_close(arg_2_0)
		if var_0_1:getInstance("equip_attr") then
			var_0_1:destroyInstance("equip_attr")
		elseif var_0_1:getInstance("specificdetails") then
			var_0_1:destroyInstance("specificdetails")
		end

		var_0_1:destroyInstance("ninth_awardbox_item")
		var_0_1:destroyInstance("ninth_awardbox")

		local var_2_0 = var_0_1:getInstance("ninth_main_map")

		if var_2_0 then
			var_2_0:_show_reward_red_point()
		end
	end

	function arg_1_0:__onClick_detail_shadow()
		self._control.detail_shadow.gameObject:SetActive(false)
		self._equip_attr:setVisible(false)
	end

	function arg_1_0.__onClick_award_msgbox_main_confirm(arg_4_0)
		return
	end

	function arg_1_0.__onClick_award_msgbox_main_close(arg_5_0)
		return
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
