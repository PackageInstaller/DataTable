-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/view/PuzzleMazeNormalObj.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeNormalObj", package.seeall)

local PuzzleMazeNormalObj = class("PuzzleMazeNormalObj", PuzzleMazeBaseObj)

function PuzzleMazeNormalObj:ctor(go)
	PuzzleMazeNormalObj.super.ctor(self, go)

	self._image = gohelper.findChildImage(self.go, "#image_content")
	self._gochecked = gohelper.findChild(self.go, "#go_checked")

	gohelper.setActive(self._gochecked, false)
end

function PuzzleMazeNormalObj:_getIcon()
	return self._image
end

return PuzzleMazeNormalObj
