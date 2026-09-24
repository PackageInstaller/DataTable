local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_mian_top_return_btn()
		self:setVisible(false)

		local var_2_0 = var_0_1:getInstance("score_push_map")

		if var_2_0 then
			var_2_0:setVisible(true)
			var_2_0:__show_answer_award_tips()
		else
			var_0_1:createInstance("score_push_map"):show()
		end
	end

	function arg_1_0.__onClick_shadow_btn(arg_3_0)
		return
	end

	function arg_1_0:__onClick_detail_shadow()
		self._control.detail_shadow.gameObject:SetActive(false)
		self._equip_attr:setVisible(false)
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
