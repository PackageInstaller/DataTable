local FightWorldMap = require("fight.FightWorldMap")
local var_0_28 = {
	[FIGHTTYPE_TOWER] = {
		width = 3000,
		start = 0
	},
	[FIGHTTYPE_EXPEDITION_TOWER] = {
		width = 3000,
		start = 0
	}
}

return function(arg_1_0)
	return setfenv(function()
		worldMap = nil

		function setWorldMapWidth(arg_3_0, arg_3_1)
			if not var_0_28[arg_3_0] then
				return
			end

			var_0_28[arg_3_0].width = arg_3_1
		end

		function resetFightWorldMap()
			worldMap = var_0_28[fighttype] and FightWorldMap.new(var_0_28[fighttype].width, var_0_28[fighttype].start) or nil
		end

		function isWorldMapExist()
			return worldMap ~= nil
		end

		function moveWorldMap(arg_6_0)
			if not worldMap then
				return
			end

			worldMap:move(arg_6_0)
		end

		function isInWorldMap(arg_7_0)
			if not worldMap then
				return false
			end

			return worldMap:isInWorldMap(worldMap:convertToWorldSpace(arg_7_0))
		end

		function isInCameraValidWorldMap(arg_8_0)
			if not worldMap then
				return false
			end

			return worldMap:isInCameraValidWorldMap(arg_8_0)
		end

		function isOutOfWorldMapRightBound(arg_9_0)
			if not worldMap then
				return false
			end

			return worldMap:isOutOfWorldMapRightBound(worldMap:convertToWorldSpace(arg_9_0))
		end

		function isOutOfWorldMapLeftBound(arg_10_0)
			if not worldMap then
				return false
			end

			return worldMap:isOutOfWorldMapLeftBound(worldMap:convertToWorldSpace(arg_10_0))
		end

		function convertToWorldSpace(arg_11_0)
			if not worldMap then
				return nil
			end

			return worldMap:convertToWorldSpace(arg_11_0)
		end

		function convertToGLSpace(arg_12_0)
			if not worldMap then
				return arg_12_0
			end

			return worldMap:convertToGLSpace(arg_12_0)
		end

		function registerWorldMapListener(arg_13_0, arg_13_1)
			if not worldMap then
				return
			end

			worldMap:registerWorldMapListener(arg_13_0, arg_13_1)
		end

		function unregisterWorldMapListener(arg_14_0)
			if not worldMap then
				return
			end

			worldMap:unregisterWorldMapListener(arg_14_0)
		end

		function getWorldMapSize()
			if not worldMap then
				return 0
			end

			return worldMap:getSize()
		end

		function getWorldMapPosition()
			if not worldMap then
				return 0
			end

			return worldMap:getPosition()
		end

		function setWorldMapPosition(arg_17_0)
			if not worldMap then
				return
			end

			worldMap:setPosition(arg_17_0)
		end

		function convertCameraToWorldSpace()
			if not worldMap then
				return
			end

			return worldMap:convertToWorldSpace(getCamera().getBaseConfig().center)
		end
	end, arg_1_0)
end
