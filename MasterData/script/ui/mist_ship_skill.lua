local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_7 = gameconfig.pve_mist_skill_config

gamecore.UILoader:define("mist_ship_skill", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)
		self:_init_panel(arg_2_1, arg_2_2)
	end

	function arg_1_0:_init_panel(arg_3_1, arg_3_2)
		self._control.all_skill.transform.localPosition = Vector2(-470 + arg_3_2 * 150, 0)

		self:_set_skill_info(arg_3_1)
	end

	function arg_1_0:_set_skill_info(arg_4_1)
		local var_4_0 = var_0_7.find_object_by_id(arg_4_1.activeskill)
		local var_4_1 = var_0_7.find_object_by_id(arg_4_1.passiveskill1)
		local var_4_2 = var_0_7.find_object_by_id(arg_4_1.passiveskill2)

		self._control.all_skill.skill_1.name_mask.equipname.text.text = var_4_0.name

		self._control.all_skill.skill_1.name_mask.textHorizonScroller:SetText(var_4_0.name)

		self._control.all_skill.skill_1.content.text.text = var_4_0.desc
		self._control.all_skill.skill_2.name_mask.equipname.text.text = var_4_1.name

		self._control.all_skill.skill_2.name_mask.textHorizonScroller:SetText(var_4_1.name)

		self._control.all_skill.skill_2.content.text.text = var_4_1.desc
		self._control.all_skill.skill_3.name_mask.equipname.text.text = var_4_2.name

		self._control.all_skill.skill_3.name_mask.textHorizonScroller:SetText(var_4_2.name)

		self._control.all_skill.skill_3.content.text.text = var_4_2.desc
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0:__initia_lize()
		self._control.all_skill.transform.localPosition = Vector2(-320, 0)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_2:class("mist_ship_skill")

	var_7_0._is_already_init = false
	var_7_0._attr_contents = {}

	gamecore.extend_obj(var_7_0)

	return var_7_0
end

return var_0_0
