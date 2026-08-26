-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/base/view/PuzzleMazeBaseAlert.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.view.PuzzleMazeBaseAlert", package.seeall)

local PuzzleMazeBaseAlert = class("PuzzleMazeBaseAlert", UserDataDispose)

function PuzzleMazeBaseAlert:ctor(go)
	PuzzleMazeBaseAlert.super.ctor(self, go)

	self.go = go
end

function PuzzleMazeBaseAlert:onInit(mo, posX, posY)
	self.mo = mo
end

function PuzzleMazeBaseAlert:onEnable(alertObj)
	return
end

function PuzzleMazeBaseAlert:onDisable()
	return
end

function PuzzleMazeBaseAlert:onRecycle()
	return
end

function PuzzleMazeBaseAlert:getKey()
	return
end

return PuzzleMazeBaseAlert
