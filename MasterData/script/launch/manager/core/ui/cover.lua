local var_0_0 = {}
local var_0_1 = gamecore.UILoader

gamecore.UILoader:define("cover", function(arg_1_0)
	function arg_1_0:show()
		if tonumber(string.format("%.2f", UnityEngine.Screen.width / UnityEngine.Screen.height)) >= 2.18 then
			self._panel.transform:GetComponent("Image").type = UnityEngine.UI.Image.Type.Sliced
			self._panel.transform:GetComponent("AspectRatioFitter").enabled = false
			self._ui_panel.anchorMin = Vector2(0.5, 0.5)
			self._ui_panel.anchorMax = Vector2(0.5, 0.5)
			self._ui_panel.sizeDelta = Vector2(1695, 720)
			self._ui_panel.localPosition = Vector3(0, 0, 0)
		end

		self:setVisible(true)
	end

	function arg_1_0.__onVisible(arg_3_0, arg_3_1)
		if not arg_3_1 then
			return
		end
	end
end)

function var_0_0.create(arg_4_0)
	return (var_0_1:class("cover"))
end

return var_0_0
