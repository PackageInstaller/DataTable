local var_0_0 = {}
local var_0_1 = gamecore.UILoader

gamecore.UILoader:define("eighth_achievement_task_item", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)
		self:__init_panel(arg_3_1)
	end

	function arg_1_0:__init_panel(arg_4_1)
		self._date = arg_4_1.data
		self._right_node = self._control.right_node
		self._task_name_lab = self._control.task_name_lab
		self._task_name_lab.text.text = self._date.title
		self._task_desc_lab = self._control.task_desc_lab.text
		self._task_desc_lab.text.text = self._date.desc
		self._reward_lab = self._control.reward_lab.text
		self._reward_lab.text.text = self._date.reward
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_6_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_1:class("eighth_achievement_task_item")

	var_7_0:__initia_lize()

	return var_7_0
end

return var_0_0
