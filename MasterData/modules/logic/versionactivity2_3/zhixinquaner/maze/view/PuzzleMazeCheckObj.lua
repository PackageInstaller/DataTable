-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/view/PuzzleMazeCheckObj.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeCheckObj", package.seeall)

local PuzzleMazeCheckObj = class("PuzzleMazeCheckObj", PuzzleMazeBaseObj)

function PuzzleMazeCheckObj:ctor(go)
	PuzzleMazeCheckObj.super.ctor(self, go)

	self._image = gohelper.findChildImage(self.go, "#image_content")
	self._gochecked = gohelper.findChild(self.go, "#go_checked")
	self._goflag = gohelper.findChild(self.go, "#go_flag")
end

function PuzzleMazeCheckObj:onInit(mo)
	PuzzleMazeCheckObj.super.onInit(self, mo)
	self:setCheckIconVisible(false)
	gohelper.setActive(self._goflag, mo.objType == PuzzleEnum.MazeObjType.End)
end

function PuzzleMazeCheckObj:onEnter()
	PuzzleMazeCheckObj.super.onEnter(self)
	self:setCheckIconVisible(true)
end

function PuzzleMazeCheckObj:onExit()
	PuzzleMazeCheckObj.super.onExit(self)
	self:setCheckIconVisible(false)
end

function PuzzleMazeCheckObj:setCheckIconVisible(isVisible)
	gohelper.setActive(self._gochecked, isVisible)
end

function PuzzleMazeCheckObj:_setIcon(isLight)
	PuzzleMazeCheckObj.super._setIcon(self, isLight)
	ZProj.UGUIHelper.SetGrayscale(self._image.gameObject, not isLight)
end

function PuzzleMazeCheckObj:_getIcon()
	return self._image
end

return PuzzleMazeCheckObj
