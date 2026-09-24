local var_0_0 = lx
local var_0_2 = UnityEngine
local var_0_3 = gamecore.UILoader

lx.define_class("SceneManager", function(arg_1_0)
	function arg_1_0.loadScene(arg_2_0, arg_2_1, arg_2_2)
		if not arg_2_1 then
			return
		end

		arg_2_0._func = arg_2_2

		local var_2_0 = var_0_2.SceneManagement.SceneManager.LoadSceneAsync(arg_2_1)

		var_2_0.allowSceneActivation = true
		var_2_0.completed = var_2_0.completed + function(arg_3_0)
			if arg_2_0._func then
				arg_2_0._func()
				gamecore.ResourceLoader:destroyAllUnusedAssets()

				if arg_2_1 == "battle" then
					local var_3_0 = var_0_3:getInstance("home")

					if var_3_0 then
						var_3_0:destroy_live2d()
					end
				elseif arg_2_1 == "main" then
					gamecore.PreloadManager:unload_battle_asset()
					var_0_3:destroyStateUISet("battle")
					var_0_3:destroyStateUISet("battle_3d")
				elseif arg_2_1 == "battle_3d" then
					local var_3_1 = var_0_3:getInstance("home")

					if var_3_1 then
						var_3_1:destroy_live2d()
					end
				end
			end
		end
	end

	function arg_1_0.restart(arg_4_0)
		if gamecore.user and gamecore.user.reset then
			gamecore.user:reset()
		end

		if gamecore.NetworkManager and gamecore.NetworkManager.reset then
			gamecore.NetworkManager:reset()
		end

		gamecore.LaunchManager:reset()
		gamecore.AudioManager:init()
		app:restart()
	end

	function arg_1_0.stop(arg_5_0)
		if exit_self_process then
			exit_self_process()
		end
	end

	function arg_1_0.getIsBattleScene(arg_6_0)
		return var_0_2.SceneManagement.SceneManager.GetActiveScene().name == "battle"
	end
end)

return function()
	local var_7_0 = var_0_0.class("SceneManager")

	var_7_0._current_scene = ""

	return var_7_0
end
