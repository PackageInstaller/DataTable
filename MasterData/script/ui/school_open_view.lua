local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_5 = gameenum.common_type

gamecore.UILoader:define("school_open_view", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__show_animation_state()
		end

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.main.school_btn.btn_text.text.text = var_0_1:getNowLang("questgo")
	end

	function arg_1_0:__show_animation_state()
		self._control.main.high_light.gameObject:SetActive(true)

		self._control.main.prompt_des.image.sprite = self:loadSprite(var_0_5.main_school_open)
		self._control.main.prompt_icon.image.sprite = self:loadSprite(var_0_5.school_open_icon)

		self._control.main.prompt_des.gameObject:SetActive(true)
		var_0_5:play_in_out_animation(self._control.show_on_tween.uITweenSequence, true)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_6_0)
	local var_6_0 = var_0_2:class("school_open_view")

	var_6_0._is_already_init = false

	return var_6_0
end

return var_0_0
