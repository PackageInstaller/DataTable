local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = DG.Tweening.DOTween

gamecore.UILoader:define("single_story_node", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:play_in_animation(arg_3_1)
		self:autoKillDOTween(var_0_3.Sequence()):Append(self._panel.transform:GetComponent("CanvasGroup"):DOFade(1, 1))
	end

	function arg_1_0.__init_panel(arg_4_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_5_0)
	return (var_0_2:class("single_story_node"))
end

return var_0_0
