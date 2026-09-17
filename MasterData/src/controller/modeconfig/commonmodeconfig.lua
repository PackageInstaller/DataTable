local playermodel = require("model.playermodel")
local chapter_data = require("data.chapter_data")
local levelmode_data = require("data.levelmode_data")

return {
	getModeProceed = function(arg_1_0)
		return string.format("%d/%d" .. L_LAYER, playermodel.levelmode[playermodel.curMode].status, levelmode_data[playermodel.curMode].totalchapter)
	end,
	getPassLevelCallback = function(arg_2_0)
		return function(arg_3_0, arg_3_1)
			arg_2_0:returnToNormalFight()
		end
	end
}
