local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = string.format
local var_0_4 = gamecore.user
local var_0_6 = gameenum.common_type

gamecore.UILoader:define("dormitory_expand_view", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:update_curr_dormitory_capacity()
		self._control.dorm_progress.text.text = var_0_4:get_dormitory_room_num() .. "/" .. var_0_6.dormitory_const.room_max_capacity
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
		end

		self:update_curr_dormitory_capacity()

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.base_panel.top.title.text.text = var_0_1:getNowLang("roomexpand")
		self._control.expand_des.text.text = var_0_3(var_0_1:getNowLang("roomexpandadd"), var_0_6.dormitory_const.warehouse_capacity_const)
		self._control.expand_state.text.text = var_0_1:getNowLang("ui_expantioncount")
		self._control.dorm_des.text.text = var_0_1:getNowLang("roomdot")
		self._control.expand_btn.txt.text.text = var_0_1:getNowLang("expantion")
	end

	function arg_1_0.__onReset(arg_6_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_2:class("dormitory_expand_view")

	var_7_0._is_already_init = nil

	return var_7_0
end

return var_0_0
