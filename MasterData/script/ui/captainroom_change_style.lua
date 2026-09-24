local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_5 = gameconfig.item_config
local var_0_6

gamecore.UILoader:define("captainroom_change_style", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:init_style_data()
		self._style_data = {
			{
				id = 10145,
				is_have = false
			},
			{
				id = 10245,
				is_have = false
			}
		}

		for iter_3_0, iter_3_1 in ipairs((var_0_4:get_captainroom_style())) do
			local var_3_0 = 0

			for iter_3_2, iter_3_3 in ipairs(self._style_data) do
				if iter_3_3.id == iter_3_1 then
					var_3_0 = iter_3_2
				end
			end

			self._style_data[var_3_0].is_have = true
		end
	end

	function arg_1_0:show_style_by_index(arg_4_1)
		self._now_click_style_id = self._style_data[arg_4_1].id

		self._control.bg.no_use:SetActive(not self._style_data[arg_4_1].is_have)
		self._control.bg.use_btn:SetActive(self._style_data[arg_4_1].is_have)

		self._control.bg.tips.text.text = self._style_data[arg_4_1].is_have and var_0_5.find_object_by_cid(self._style_data[arg_4_1].id).desc or var_0_5.find_object_by_cid(self._style_data[arg_4_1].id).drop_desc
	end

	function arg_1_0:reset_layer()
		local var_5_0 = self._now_style_id == self._style_data[1].id

		if self._now_style_id == self._style_data[1].id then
			self:show_style_by_index(1)
		else
			self:show_style_by_index(2)
		end

		self._control.bg.style_switch.style_0_btn.toggle.isOn = var_5_0
		self._control.bg.style_switch.style_1_btn.toggle.isOn = not var_5_0
	end

	function arg_1_0.show_style_layer(arg_6_0, arg_6_1)
		var_0_3:play_in_out_animation(var_0_6, arg_6_1, function()
			if not arg_6_1 then
				arg_6_0._control.bg:SetActive(false)
				arg_6_0:setVisible(false)
			end
		end)
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
		end

		self._now_style_id = var_0_4:get_use_info_data().mansion_style

		self:init_style_data()
		self:reset_layer()
		self:show_style_layer(true)

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.bg.changestyle.text.text = var_0_2:getNowLang("changestyle")
		self._control.bg.styleselect.text.text = var_0_2:getNowLang("styleselect")
		self._control.bg.style_switch.style_0_btn.bg_unselected.styledesc0.text.text = var_0_2:getNowLang("styledesc0")
		self._control.bg.style_switch.style_1_btn.bg_unselected.captainstyle2.text.text = var_0_2:getNowLang("captainstyle2")
		self._control.bg.style_switch.style_0_btn.bg.styledesc0_selected.text.text = var_0_2:getNowLang("styledesc0")
		self._control.bg.style_switch.style_1_btn.bg.captainstyle2_selected.text.text = var_0_2:getNowLang("captainstyle2")
		self._control.bg.use_btn.use.text.text = var_0_2:getNowLang("use")
		self._control.bg.no_use.use.text.text = var_0_2:getNowLang("use")
	end

	function arg_1_0:__init_constant()
		var_0_6 = self._control.bg.uITweenSequence
	end

	function arg_1_0:_play_into_se(arg_11_1)
		self:playSE(arg_11_1, false)
	end

	function arg_1_0.__onReset(arg_12_0)
		arg_12_0._is_already_init = false
		arg_12_0._style_data = nil
		arg_12_0._now_style_id = nil
		arg_12_0._now_click_style_id = nil
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_13_0)
	local var_13_0 = var_0_1:class("captainroom_change_style")

	var_13_0._is_already_init = false
	var_13_0._style_data = nil
	var_13_0._now_style_id = nil
	var_13_0._now_click_style_id = nil

	return var_13_0
end

return var_0_0
