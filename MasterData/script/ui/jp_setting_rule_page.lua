local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type

gamecore.UILoader:define("jp_setting_rule_page", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:_init_panel()
	end

	function arg_1_0:_init_panel()
		self:__initial_func()
		var_0_5:play_in_out_animation(self._control.tip_layer.uITweenSequence, true)
	end

	function arg_1_0:__initial_func()
		local var_4_0 = var_0_3:get_use_info_data().paid_diamond
		local var_4_1 = {
			{
				nodetext = "settingrule",
				node = self._control.tip_layer.bg_container.title
			},
			{
				nodetext = "settingrule",
				node = self._control.tip_layer.setting_rule_button_1.txt
			},
			{
				nodetext = "settingprivate",
				node = self._control.tip_layer.setting_rule_button_2.txt
			},
			{
				nodetext = "settingparti",
				node = self._control.tip_layer.setting_rule_button_3.txt
			},
			{
				nodetext = "settinglaw",
				node = self._control.tip_layer.setting_rule_button_4.txt
			}
		}
		local var_4_2 = {
			init_language = function(self, arg_5_1)
				self.text.text = var_0_1:getNowLang(arg_5_1)
			end
		}

		for iter_4_0 = 1, #var_4_1 do
			var_4_2.init_language(var_4_1[iter_4_0].node, var_4_1[iter_4_0].nodetext)
		end

		self._control.tip_layer.unfree_diamond_image.text.text.text = var_4_0
		self._control.tip_layer.free_diamond_image.text.text.text = var_0_3:get_use_info_data().diamond - var_4_0
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_6_0)
	local var_6_0 = var_0_2:class("jp_setting_rule_page")

	gamecore.extend_obj(var_6_0)

	return var_6_0
end

return var_0_0
