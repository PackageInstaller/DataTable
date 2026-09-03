-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeOptionItemShop.lua

local MazeBaseOption = require("dm.gameplay.maze.model.MazeBaseOption")
local MazeOptionItemShop = class("MazeOptionItemShop", MazeBaseOption)

MazeOptionItemShop:has("_items", {
	is = "rw"
})

function MazeOptionItemShop:initialize()
	super.initialize(self)

	self._viewName = "MazeTreasureShopView"
end

function MazeOptionItemShop:syncData(data)
	if data.type then
		self._type = data.type
	end

	if data.items then
		self._items = data.items
	end

	if data.optionId then
		self._optionId = data.optionId
	end

	if data.level then
		self._level = data.level
	end
end

function MazeOptionItemShop:delTreasure(treasureid)
	local tempitems = {}

	for k, v in pairs(self._items) do
		if treasureid ~= k then
			tempitems[k] = v
		end
	end

	self._items = tempitems
end

return MazeOptionItemShop
