local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = DG.Tweening.DOTween
local var_0_3 = gameenum.common_type

gamecore.UILoader:define("logo", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = self:autoKillDOTween(var_0_2.Sequence())
		local var_2_1 = app:getSystem():getChannel()

		arg_2_1 = var_2_1 ~= var_0_3.channel.android_jp and var_2_1 ~= var_0_3.channel.iOS_jp

		self:setVisible(arg_2_1)

		local var_2_2 = self._panel.transform:GetComponent("CanvasGroup")

		var_2_0:AppendCallback(function()
			local var_3_0 = var_2_2:DOFade(1, arg_2_3)
		end)
		var_2_0:AppendInterval(arg_2_2)
		var_2_0:AppendCallback(function()
			var_2_2:DOFade(0, arg_2_3):OnComplete(function()
				arg_2_4()
				var_2_0:Kill()

				var_2_0 = nil
			end)
		end)
		var_2_0:Play()
	end
end)

function var_0_0.create(arg_6_0)
	return (var_0_1:class("logo"))
end

return var_0_0
