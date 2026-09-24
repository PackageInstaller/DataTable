local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_select_big_server_item_bar_bg()
		if gamecore.AuditServerManager:isQAVersion() then
			self:setVisible(false)
			var_0_1:getInstance("enter_game"):select_server_control(true)

			return
		end

		var_0_1:createInstance("select_big_server"):show()
		self:setVisible(false)
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
