-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeOptionCopyItem.lua

local MazeBaseOption = require("dm.gameplay.maze.model.MazeBaseOption")
local MazeOptionCopyItem = class("MazeOptionCopyItem", MazeBaseOption)

MazeOptionCopyItem:has("_itemId", {
	is = "rw"
})
MazeOptionCopyItem:has("_level", {
	is = "rw"
})

function MazeOptionCopyItem:initialize()
	super.initialize(self)

	self._viewName = "MazeTreasureCopyView"
end

function MazeOptionCopyItem:syncData(data)
	if data.type then
		self._type = data.type
	end

	if data.optionId then
		self._optionId = data.optionId
	end

	if data.rewardId then
		self._rewardId = data.rewardId
	end
end

return MazeOptionCopyItem
