local var_0_9 = pairs
local FightUIElementsManager = require("fight.FightUIElementsManager")
local fight_camera = require("fight.fight_camera")

return function(arg_1_0)
	return setfenv(function()
		battlefieldRef = nil

		function attachBattleField(arg_3_0)
			battlefieldRef = arg_3_0
		end

		function detachBattleField()
			battlefieldRef = nil
		end

		fightconsoleRef = nil

		function attachConsole(arg_5_0)
			fightconsoleRef = arg_5_0
		end

		function detachConsole()
			fightconsoleRef = nil
		end

		local var_2_0 = FightUIElementsManager

		function getUIElements()
			return var_2_0
		end

		function attachPlayerItem(arg_8_0, arg_8_1)
			var_2_0.attachPlayerItem(arg_8_0, arg_8_1)
		end

		function detachPlayerItem(arg_9_0)
			var_2_0.detachPlayerItem(arg_9_0)

			if players[arg_9_0] then
				players[arg_9_0]:unregisterPlayerItem()
			end
		end

		function detachAllPlayerItems()
			var_2_0.detachAllPlayerItems()
		end

		function getPlayerItem(arg_11_0)
			return var_2_0.getPlayerItem(arg_11_0)
		end

		function getPlayerItems()
			return var_2_0.getPlayerItems()
		end

		function attachBuffPanel(arg_13_0, arg_13_1)
			var_2_0.attachBuffPanel(arg_13_0, arg_13_1)
		end

		function detachBuffPanel(arg_14_0)
			var_2_0.detachBuffPanel(arg_14_0)

			if players[arg_14_0] then
				players[arg_14_0]:unregisterPlayerBuffPanel()
			end
		end

		function detachAllBuffPanels()
			var_2_0.detachAllBuffPanels()
		end

		function getBuffPanel(arg_16_0)
			return var_2_0.getBuffPanel(arg_16_0)
		end

		function initCamera(arg_17_0)
			fight_camera.init(arg_17_0)
			var_2_0.attachFightCamera(fight_camera)
		end

		function getCamera()
			return var_2_0.getCamera()
		end

		function stopCamera()
			var_2_0.getCamera().stop()
		end

		function resetCamera()
			var_2_0.getCamera().reset()
		end

		function getCameraspeed()
			return var_2_0.getCamera().getCameraSpeed()
		end

		function addFightUI(arg_22_0)
			battlefieldRef:addFightUI(arg_22_0)
		end

		function pushCaptainUI(arg_23_0, arg_23_1, arg_23_2)
			return battlefieldRef:pushCaptainUI(arg_23_0, arg_23_1, arg_23_2)
		end

		function addXPBg(arg_24_0)
			battlefieldRef:addXPBg(arg_24_0)
		end

		function addXPEffect(arg_25_0, arg_25_1, arg_25_2)
			battlefieldRef:addXPEffect(arg_25_0, arg_25_1, arg_25_2)
		end

		function playLockAni(arg_26_0, arg_26_1)
			battlefieldRef:playLockAni(arg_26_0, arg_26_1)
		end

		function updateFightUITimeScale(arg_27_0)
			for iter_27_0, iter_27_1 in var_0_9((var_2_0.getUICharacters())) do
				iter_27_1:setTimeScale(iter_27_1:getTimeScale() / arg_27_0 * getBossSpeedUp())
			end

			for iter_27_2, iter_27_3 in var_0_9((var_2_0.getUIBullets())) do
				iter_27_3.bullet:setTimeScale(iter_27_3.bullet:getTimeScale() / arg_27_0 * getBossSpeedUp())
			end
		end
	end, arg_1_0)
end
