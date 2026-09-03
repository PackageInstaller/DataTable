-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeOptionExchangItem.lua

local MazeBaseOption = require("dm.gameplay.maze.model.MazeBaseOption")
local MazeOptionExchangItem = class("MazeOptionExchangItem", MazeBaseOption)

MazeOptionExchangItem:has("_itemId", {
	is = "rw"
})
MazeOptionExchangItem:has("_level", {
	is = "rw"
})

function MazeOptionExchangItem:initialize()
	super.initialize(self)

	self._type = ""
	self._viewName = "MazeTreasureExchangeView"
end

function MazeOptionExchangItem:syncData(data)
	if data.type then
		self._type = data.type
	end

	if data.optionId then
		self._optionId = data.optionId
	end

	if data.rewardId then
		self._rewardId = data.rewardId
	end

	if data.itemId then
		self._itemId = data.itemId
	end
end

return MazeOptionExchangItem
