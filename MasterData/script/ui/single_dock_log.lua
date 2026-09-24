local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader

gamecore.UILoader:define("single_dock_log", function(arg_1_0)
	function arg_1_0:__onVisible(arg_2_1, arg_2_2)
		if not arg_2_1 then
			return
		end

		self:__init_panel(arg_2_2)
	end

	function arg_1_0:__init_panel(arg_3_1)
		self:__tog_value_changed()
		self:__init_data(arg_3_1)
	end

	function arg_1_0:__init_data(arg_4_1)
		self._control.use_btn.text.text.text = var_0_2:getNowLang("loguse")
	end

	function arg_1_0:__tog_value_changed()
		self._control.select_tog.toggle.onValueChanged:AddListener(function(arg_6_0)
			self._control.head:SetActive(arg_6_0)

			if arg_6_0 then
				self._control.user_name.text.color = Color.New(0, 0.6078431372549019, 0.9607843137254902)
				self._control.time.text.color = Color.New(0, 0.6078431372549019, 0.9607843137254902)
			else
				self._control.user_name.text.color = Color.New(0.22745098039215686, 0.22745098039215686, 0.22745098039215686)
				self._control.time.text.color = Color.New(0.596078431372549, 0.5764705882352941, 0.5764705882352941)
			end
		end)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	return (var_0_3:class("single_dock_log"))
end

return var_0_0
