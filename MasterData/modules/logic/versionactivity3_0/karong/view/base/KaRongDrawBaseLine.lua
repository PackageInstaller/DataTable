-- chunkname: @modules/logic/versionactivity3_0/karong/view/base/KaRongDrawBaseLine.lua

module("modules.logic.versionactivity3_0.karong.view.base.KaRongDrawBaseLine", package.seeall)

local KaRongDrawBaseLine = class("KaRongDrawBaseLine", UserDataDispose)

function KaRongDrawBaseLine:ctor(go)
	self:__onInit()

	self.go = go
end

function KaRongDrawBaseLine:onInit(x1, y1, x2, y2)
	self.x1, self.y1, self.x2, self.y2 = x1, y1, x2, y2

	local dir = KaRongDrawHelper.getFromToDir(x1, y1, x2, y2)

	self:setDir(dir)
end

function KaRongDrawBaseLine:onCrossFull(dir)
	self:setDir(dir)
	self:setProgress(1)
end

function KaRongDrawBaseLine:onCrossHalf(dir, progress)
	self:setDir(dir)
	self:setProgress(progress)
end

function KaRongDrawBaseLine:onAlert(alertType)
	return
end

function KaRongDrawBaseLine:setProgress(progress)
	self.progress = progress or 0
end

function KaRongDrawBaseLine:getProgress()
	return self.progress or 0
end

function KaRongDrawBaseLine:setDir(dir)
	self.dir = dir
end

function KaRongDrawBaseLine:getDir()
	return self.dir
end

function KaRongDrawBaseLine:clear()
	self:setProgress(0)

	self.dir = nil
end

function KaRongDrawBaseLine:destroy()
	gohelper.destroy(self.go)
	self:__onDispose()
end

return KaRongDrawBaseLine
