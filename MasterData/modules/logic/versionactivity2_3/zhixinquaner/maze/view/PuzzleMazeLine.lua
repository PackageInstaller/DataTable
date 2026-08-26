-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/view/PuzzleMazeLine.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeLine", package.seeall)

local PuzzleMazeLine = class("PuzzleMazeLine", PuzzleMazeBaseLine)

function PuzzleMazeLine:ctor(go, fillOrigin_left, fillOrigin_right)
	PuzzleMazeLine.super.ctor(self, go)

	self._fillOrigin_left = fillOrigin_left
	self._fillOrigin_right = fillOrigin_right
	self._gomap = gohelper.findChild(self.go, "#go_map")
	self._gopath = gohelper.findChild(self.go, "#go_path")
	self.image = gohelper.findChildImage(self.go, "#go_path/image_horizon")
	self.imageTf = self.image.transform

	gohelper.setActive(self._gomap, false)
	gohelper.setActive(self._gopath, true)
end

function PuzzleMazeLine:onInit(x1, y1, x2, y2)
	PuzzleMazeLine.super.onInit(self, x1, y1, x2, y2)

	local anchorX, anchorY = PuzzleMazeDrawModel.instance:getLineAnchor(x1, y1, x2, y2)

	recthelper.setAnchor(self.go.transform, anchorX, anchorY)
end

function PuzzleMazeLine:onAlert(alertType)
	return
end

function PuzzleMazeLine:onCrossHalf(dir, progress)
	if self.dir == nil and dir ~= nil then
		self:setDir(dir)
	end

	if self.dir ~= nil then
		if self:isReverseDir(self.dir) then
			progress = 1 - progress
		end

		self:setProgress(progress)
	end
end

function PuzzleMazeLine:setProgress(progress)
	PuzzleMazeLine.super.setProgress(self, progress)

	self.image.fillAmount = self:getProgress()
end

function PuzzleMazeLine:setDir(dir)
	PuzzleMazeLine.super.setDir(self, dir)
	self:refreshLineDir()
end

function PuzzleMazeLine:refreshLineDir()
	local rotationX, rotationY, rotationZ, width = 0, 0, 0, PuzzleEnum.mazeUILineHorizonUIWidth

	self.image.fillOrigin = self._fillOrigin_left

	if self.dir == PuzzleEnum.dir.left then
		rotationZ = 180
	elseif self.dir == PuzzleEnum.dir.up then
		width = PuzzleEnum.mazeUILineVerticalUIWidth
		rotationZ = 90
	elseif self.dir == PuzzleEnum.dir.down then
		width = PuzzleEnum.mazeUILineVerticalUIWidth
		rotationZ = -90
	end

	transformhelper.setLocalRotation(self.imageTf, rotationX, rotationY, rotationZ)
	recthelper.setWidth(self.imageTf, width)
end

function PuzzleMazeLine:isReverseDir(dir)
	return dir == PuzzleEnum.dir.left or dir == PuzzleEnum.dir.down
end

return PuzzleMazeLine
