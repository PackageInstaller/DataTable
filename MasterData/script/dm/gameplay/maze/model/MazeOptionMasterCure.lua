-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeOptionMasterCure.lua

local MazeBaseOption = require("dm.gameplay.maze.model.MazeBaseOption")
local MazeOptionMasterCure = class("MazeOptionMasterCure", MazeBaseOption)

MazeOptionMasterCure:has("_level", {
	is = "rw"
})
MazeOptionMasterCure:has("_leftTimes", {
	is = "rw"
})
MazeOptionMasterCure:has("_cureHp", {
	is = "rw"
})

function MazeOptionMasterCure:initialize()
	super.initialize(self)
end

function MazeOptionMasterCure:syncData(data)
	if data.optionId then
		self._optionId = data.optionId
	end

	if data.leftTimes then
		self._leftTimes = data.leftTimes
	end
end

function MazeOptionMasterCure:onClickOptionBtn(index)
	print("第" .. index .. "个页签" .. "MazeOptionMasterCure..主角绷带")
end

return MazeOptionMasterCure
