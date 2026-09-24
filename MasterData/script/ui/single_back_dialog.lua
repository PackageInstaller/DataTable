local var_0_0 = {}
local var_0_2 = gamecore.UILoader

gamecore.UILoader:define("single_back_dialog", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3)
		self:setVisible(true)
		self:__init_panel(arg_2_1, arg_2_2, arg_2_3)
	end

	function arg_1_0:__init_panel(arg_3_1, arg_3_2, arg_3_3)
		if arg_3_1 == "1" then
			self._control.back_dialog_box_1:SetActive(true)

			self._control.back_dialog_box_1.dialog_txt.text.text = "<color=#FFFFFF00>-----</color>" .. arg_3_3
			self.box_size_y = self._control.back_dialog_box_1.dialog_txt:GetComponent("Text").preferredHeight + 50
			self._panel.transform.sizeDelta = Vector2(self._panel.transform.sizeDelta.x, self.box_size_y)
			self._control.back_dialog_box_1.rectTransform.anchoredPosition = Vector2(self._control.back_dialog_box_1.rectTransform.anchoredPosition.x, 0)
			now_type = 1
		end

		if arg_3_1 == "2" or arg_3_1 == "3" then
			if now_type == 1 or now_type == 4 then
				self._control.back_dialog_box_2:SetActive(true)

				self._control.back_dialog_box_2.name_txt.text.text = "<color=#FFFFFF00>--</color>" .. arg_3_2
				self._control.back_dialog_box_2.dialog_txt.text.text = "<color=#FFFFFF00>-----</color>" .. arg_3_3
				self.box_size_y = self._control.back_dialog_box_2.dialog_txt:GetComponent("Text").preferredHeight + 75 + self._control.back_dialog_box_2.name_txt:GetComponent("Text").preferredHeight
				self._panel.transform.sizeDelta = Vector2(self._panel.transform.sizeDelta.x, self.box_size_y)
				self._control.back_dialog_box_2.rectTransform.anchoredPosition = Vector2(self._control.back_dialog_box_2.rectTransform.anchoredPosition.x, 0)
				now_type = 2

				return
			end

			if now_type == 2 or now_type == 4 then
				self._control.back_dialog_box_3:SetActive(true)

				self._control.back_dialog_box_3.name_txt.text.text = "<color=#FFFFFF00>--</color>" .. arg_3_2
				self._control.back_dialog_box_3.dialog_txt.text.text = "<color=#FFFFFF00>-----</color>" .. arg_3_3
				self.box_size_y = self._control.back_dialog_box_3.dialog_txt:GetComponent("Text").preferredHeight + 75 + self._control.back_dialog_box_2.name_txt:GetComponent("Text").preferredHeight
				self._panel.transform.sizeDelta = Vector2(self._panel.transform.sizeDelta.x, self.box_size_y)
				self._control.back_dialog_box_3.rectTransform.anchoredPosition = Vector2(self._control.back_dialog_box_3.rectTransform.anchoredPosition.x, 0)
				now_type = 1

				return
			end
		end

		if arg_3_1 == "4" then
			self._control.back_dialog_box_4:SetActive(true)

			self._control.back_dialog_box_4.dialog_txt.text.text = "<color=#FFFFFF00>-----</color>" .. arg_3_3
			self.box_size_y = self._control.back_dialog_box_4.dialog_txt:GetComponent("Text").preferredHeight + 50
			self._panel.transform.sizeDelta = Vector2(self._panel.transform.sizeDelta.x, self.box_size_y)
			self._control.back_dialog_box_4.rectTransform.anchoredPosition = Vector2(self._control.back_dialog_box_4.rectTransform.anchoredPosition.x, 0)
			now_type = 4
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_4_0)
	local var_4_0 = var_0_2:class("single_back_dialog")

	var_4_0._is_already_init = false
	var_4_0.now_type = nil

	return var_4_0
end

return var_0_0
