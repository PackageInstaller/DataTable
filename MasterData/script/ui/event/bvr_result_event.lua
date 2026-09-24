local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.SceneManager
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_close_btn()
		var_0_1:destroyInstance("bvr_result")

		if self.is_campaign then
			self.is_campaign = false

			self._campaign_select:__start_battle_response(self._data)
		else
			var_0_2:loadScene(var_0_3:get_battle_scene_name(), function()
				var_0_1:destroyStateUISet("game")
				var_0_1:createInstance(var_0_3:get_battle_name()):show(self._battle_type)
			end)
		end
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
