local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = DG.Tweening.DOTween

gamecore.UILoader:define("login_prompt", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)

		local var_2_0 = self:autoKillDOTween(var_0_3.Sequence())

		var_2_0:Append(self._panel.transform:DOBlendableLocalMoveBy(Vector3.New(0, 128), 0.86))
		var_2_0:AppendCallback(function()
			self:destroy()
		end)
		var_2_0:Play()
		self._control.text.gameObject:SetActive(true)

		self._control.text.text = arg_2_1
	end
end)

function var_0_0.create(arg_4_0)
	local var_4_0 = var_0_2:class("login_prompt")

	var_4_0:__registerControl("text", UnityEngine.UI.Text)

	return var_4_0
end

return var_0_0
