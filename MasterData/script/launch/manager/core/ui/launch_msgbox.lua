local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader

gamecore.UILoader:define("launch_msgbox", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3)
		self._confirm_func = arg_2_2
		self._cancel_func = arg_2_3
		self._control.main.title.text.text = ""
		self._control.main.tip.text.text.text = arg_2_1

		self._control.main.back:SetActive(true)
		self._control.main.confirm:SetActive(true)
		self._control.main.one:SetActive(false)

		self._control.main.confirm.text.text.text = var_0_2:getNowLang("ui_cbtn1")
		self._control.main.back.text.text.text = var_0_2:getNowLang("ui_cbtn2")

		self:setVisible(true)
	end

	function arg_1_0:showOne(arg_3_1, arg_3_2, arg_3_3)
		arg_3_3 = arg_3_3 or var_0_2:getNowLang("ui_cbtn1")
		self._one_func = arg_3_2
		self._cancel_func = arg_3_2

		self._control.main.back:SetActive(false)
		self._control.main.confirm:SetActive(false)
		self._control.main.one:SetActive(true)

		self._control.main.title.text.text = ""
		self._control.main.tip.text.text.text = arg_3_1
		self._control.main.one.text.text.text = arg_3_3

		self:setVisible(true)
	end

	function arg_1_0.__onVisible(arg_4_0, arg_4_1)
		if not arg_4_1 then
			return
		end
	end

	function arg_1_0:__onClick_main_confirm()
		self._confirm_func = nil

		self:setVisible(false)

		if self._confirm_func then
			self._confirm_func()
		end
	end

	function arg_1_0:__onClick_main_back()
		self._cancel_func = nil

		self:setVisible(false)

		if self._cancel_func then
			self._cancel_func()
		end
	end

	function arg_1_0:__onClick_main_one()
		self._one_func = nil

		self:setVisible(false)

		if self._one_func then
			self._one_func()
		end
	end

	function arg_1_0:__onClick_main_close()
		self._cancel_func = nil

		self:setVisible(false)

		if self._cancel_func then
			self._cancel_func()
		end
	end
end)

function var_0_0.create(arg_9_0)
	local var_9_0 = var_0_3:class("launch_msgbox")

	var_9_0._confirm_func = nil
	var_9_0._cancel_func = nil
	var_9_0._one_func = nil

	var_9_0:__registerClickEvent("main/back")
	var_9_0:__registerClickEvent("main/confirm")
	var_9_0:__registerClickEvent("main/btn")
	var_9_0:__registerClickEvent("main/close")

	return var_9_0
end

return var_0_0
