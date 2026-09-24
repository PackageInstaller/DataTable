local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gameconfig.item_config

gamecore.UILoader:define("collection_info", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:set_collect_info(arg_3_1)
		local var_3_0 = var_0_3.find_object_by_cid(arg_3_1)

		self._control.name_scroller:GetComponent("TextHorizonScroller"):SetText(var_3_0.title)

		self._control.describe_txt.text.text = var_3_0.desc
	end

	function arg_1_0:__init_panel(arg_4_1)
		self:set_collect_info(arg_4_1)

		self._is_already_init = true
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_5_0)
	return (var_0_2:class("collection_info"))
end

return var_0_0
