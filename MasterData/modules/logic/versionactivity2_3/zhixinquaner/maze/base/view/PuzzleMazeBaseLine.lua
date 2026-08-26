-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/base/view/PuzzleMazeBaseLine.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.view.PuzzleMazeBaseLine", package.seeall)

local PuzzleMazeBaseLine = class("PuzzleMazeBaseLine", UserDataDispose)

function PuzzleMazeBaseLine:ctor(go)
	self:__onInit()

	self.go = go
end

function PuzzleMazeBaseLine:onInit(x1, y1, x2, y2)
	self.x1, self.y1, self.x2, self.y2 = x1, y1, x2, y2

	local dir = PuzzleMazeHelper.getFromToDir(x1, y1, x2, y2)

	self:setDir(dir)
end

function PuzzleMazeBaseLine:onCrossFull(dir)
	self:setDir(dir)
	self:setProgress(1)
end

function PuzzleMazeBaseLine:onCrossHalf(dir, progress)
	self:setDir(dir)
	self:setProgress(progress)
end

function PuzzleMazeBaseLine:onAlert(alertType)
	return
end

function PuzzleMazeBaseLine:setProgress(progress)
	self.progress = progress or 0
end

function PuzzleMazeBaseLine:getProgress()
	return self.progress or 0
end

function PuzzleMazeBaseLine:setDir(dir)
	self.dir = dir
end

function PuzzleMazeBaseLine:getDir()
	return self.dir
end

function PuzzleMazeBaseLine:clear()
	self:setProgress(0)

	self.dir = nil
end

function PuzzleMazeBaseLine:destroy()
	gohelper.destroy(self.go)
	self:__onDispose()
end

return PuzzleMazeBaseLine
