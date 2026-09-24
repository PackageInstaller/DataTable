local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_confirm()
		if self._data.reason == 1 then
			self:setVisible(false)
		else
			local var_2_0 = var_0_1:getInstance("home")

			self:destroyGameObject(var_2_0._live2d)
			var_2_0:setVisible(false)
			gamecore.SceneManager:restart()
		end
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
