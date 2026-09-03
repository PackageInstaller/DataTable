-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeOptionRefresh.lua

local MazeBaseOption = require("dm.gameplay.maze.model.MazeBaseOption")
local MazeOptionRefresh = class("MazeOptionRefresh", MazeBaseOption)

function MazeOptionRefresh:initialize()
	super.initialize(self)
end

function MazeOptionRefresh:syncData(data)
	if data.optionId then
		self._optionId = data.optionId
	end
end

return MazeOptionRefresh
