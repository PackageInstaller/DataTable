local var_0_0 = {}

UILoader:define("answer_select", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0.__init_panel(arg_3_0)
		return
	end

	function arg_1_0.__initia_lize(arg_4_0)
		return
	end

	function arg_1_0.__onReset(arg_5_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_6_0)
	local var_6_0 = UILoader:class("answer_select")

	gamecore.extend_obj(var_6_0)

	return var_6_0
end

return var_0_0
