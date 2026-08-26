-- chunkname: @modules/logic/versionactivity3_0/karong/view/comp/KaRongDrawLine.lua

module("modules.logic.versionactivity3_0.karong.view.comp.KaRongDrawLine", package.seeall)

local KaRongDrawLine = class("KaRongDrawLine", KaRongDrawBaseLine)

function KaRongDrawLine:ctor(go, fillOrigin_left, fillOrigin_right)
	KaRongDrawLine.super.ctor(self, go)

	self._fillOrigin_left = fillOrigin_left
	self._fillOrigin_right = fillOrigin_right
	self._gomap = gohelper.findChild(self.go, "#go_map")
	self._gopath = gohelper.findChild(self.go, "#go_path")
	self.image = gohelper.findChildImage(self.go, "#go_path/image_horizon")
	self.imageTf = self.image.transform

	gohelper.setActive(self._gomap, false)
	gohelper.setActive(self._gopath, true)
end

function KaRongDrawLine:onInit(x1, y1, x2, y2)
	KaRongDrawLine.super.onInit(self, x1, y1, x2, y2)

	local anchorX, anchorY = KaRongDrawModel.instance:getLineAnchor(x1, y1, x2, y2)

	recthelper.setAnchor(self.go.transform, anchorX, anchorY)
end

function KaRongDrawLine:onAlert(alertType)
	return
end

function KaRongDrawLine:onCrossHalf(dir, progress)
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

function KaRongDrawLine:setProgress(progress)
	KaRongDrawLine.super.setProgress(self, progress)

	self.image.fillAmount = self:getProgress()
end

function KaRongDrawLine:setDir(dir)
	KaRongDrawLine.super.setDir(self, dir)
	self:refreshLineDir()
end

function KaRongDrawLine:refreshLineDir()
	local rotationX, rotationY, rotationZ, width = 0, 0, 0, KaRongDrawEnum.mazeUILineHorizonUIWidth

	self.image.fillOrigin = self._fillOrigin_left

	if self.dir == KaRongDrawEnum.dir.left then
		rotationZ = 180
	elseif self.dir == KaRongDrawEnum.dir.up then
		width = KaRongDrawEnum.mazeUILineVerticalUIWidth
		rotationZ = 90
	elseif self.dir == KaRongDrawEnum.dir.down then
		width = KaRongDrawEnum.mazeUILineVerticalUIWidth
		rotationZ = -90
	end

	transformhelper.setLocalRotation(self.imageTf, rotationX, rotationY, rotationZ)
	recthelper.setWidth(self.imageTf, width)
end

function KaRongDrawLine:isReverseDir(dir)
	return dir == KaRongDrawEnum.dir.left or dir == KaRongDrawEnum.dir.down
end

return KaRongDrawLine
