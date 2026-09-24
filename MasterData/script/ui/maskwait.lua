local var_0_0 = {}
local var_0_3 = gamecore.UILoader
local var_0_6 = DG.Tweening.DOTween

gamecore.UILoader:define("maskwait", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		if arg_2_1 then
			self:setVisible(true)
		else
			self:setVisible(false)
		end

		self:_init_am()
	end

	function arg_1_0:_init_am()
		seq = self:autoKillDOTween(var_0_6.Sequence())

		seq:AppendCallback(func)
		seq:SetLoops(-1)
		seq:Play()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_4_0)
	return (var_0_3:class("maskwait"))
end

return var_0_0
