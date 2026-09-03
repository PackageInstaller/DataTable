-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddMazeTower.lua

MazeTowerAddRoom = class("MazeTowerAddRoom", DebugViewTemplate, _M)

function MazeTowerAddRoom:initialize()
	self._opType = 430
	self._viewConfig = {
		{
			default = "1",
			name = "num",
			title = "增加的层数",
			type = "Input"
		}
	}
end

MazeTowerAddFightTimes = class("MazeTowerAddFightTimes", DebugViewTemplate, _M)

function MazeTowerAddFightTimes:initialize()
	self._opType = 431
	self._viewConfig = {
		{
			default = "1",
			name = "num",
			title = "挑战次数",
			type = "Input"
		}
	}
end
