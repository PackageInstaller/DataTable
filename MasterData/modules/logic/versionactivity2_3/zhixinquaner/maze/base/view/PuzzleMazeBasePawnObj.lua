-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/base/view/PuzzleMazeBasePawnObj.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.view.PuzzleMazeBasePawnObj", package.seeall)

local PuzzleMazeBasePawnObj = class("PuzzleMazeBasePawnObj", UserDataDispose)

function PuzzleMazeBasePawnObj:ctor(go)
	self:__onInit()

	self.go = go
end

function PuzzleMazeBasePawnObj:onInit(mo)
	self._mo = mo
end

function PuzzleMazeBasePawnObj:onBeginDrag()
	return
end

function PuzzleMazeBasePawnObj:onDraging(x, y)
	self:setPos(x, y)
end

function PuzzleMazeBasePawnObj:onEndDrag(x, y)
	self:setPos(x, y)
end

function PuzzleMazeBasePawnObj:setDir(dir)
	self.dir = dir
end

function PuzzleMazeBasePawnObj:getDir()
	return self.dir
end

function PuzzleMazeBasePawnObj:setPos(x, y)
	self.x = x or 0
	self.y = y or 0
end

function PuzzleMazeBasePawnObj:getPos()
	return self.x or 0, self.y or 0
end

function PuzzleMazeBasePawnObj:destroy()
	self:__onDispose()
end

return PuzzleMazeBasePawnObj
