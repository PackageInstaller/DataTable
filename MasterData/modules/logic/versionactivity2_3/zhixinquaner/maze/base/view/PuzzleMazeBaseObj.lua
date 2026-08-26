-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/base/view/PuzzleMazeBaseObj.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.view.PuzzleMazeBaseObj", package.seeall)

local PuzzleMazeBaseObj = class("PuzzleMazeBaseObj", UserDataDispose)

function PuzzleMazeBaseObj:ctor(go)
	self:__onInit()

	self.go = go
end

function PuzzleMazeBaseObj:onInit(mo)
	self.mo = mo
	self.isEnter = false

	self:_setVisible(true)
	self:_setPosition()
	self:_setIcon(self.isEnter)
end

function PuzzleMazeBaseObj:onEnter()
	self.isEnter = true

	self:_setIcon(self.isEnter)
end

function PuzzleMazeBaseObj:onExit()
	self.isEnter = false

	self:_setIcon(self.isEnter)
end

function PuzzleMazeBaseObj:onAlreadyEnter()
	return
end

function PuzzleMazeBaseObj:getKey()
	return
end

function PuzzleMazeBaseObj:HasEnter()
	return self.isEnter
end

function PuzzleMazeBaseObj:_setPosition()
	local anchorX, anchorY

	if self.mo.positionType == PuzzleEnum.PositionType.Point then
		anchorX, anchorY = PuzzleMazeDrawModel.instance:getObjectAnchor(self.mo.x, self.mo.y)
	else
		anchorX, anchorY = PuzzleMazeDrawModel.instance:getLineObjectAnchor(self.mo.x1, self.mo.y1, self.mo.x2, self.mo.y2)
	end

	recthelper.setAnchor(self.go.transform, anchorX, anchorY)
end

function PuzzleMazeBaseObj:_setIcon(isLight)
	local iconUrl = self:_getIconUrl(isLight)
	local iconComp = self:_getIcon()

	UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(iconComp, iconUrl, true)
end

function PuzzleMazeBaseObj:_getIcon()
	return
end

function PuzzleMazeBaseObj:_getIconUrl(isLight)
	if not self.mo or not self.mo.iconUrl then
		return
	end

	if self.mo then
		return self.mo.iconUrl
	end
end

function PuzzleMazeBaseObj:_setVisible(isVisible)
	gohelper.setActive(self.go, isVisible)
end

function PuzzleMazeBaseObj:destroy()
	gohelper.destroy(self.go)

	self.isEnter = false

	self:__onDispose()
end

return PuzzleMazeBaseObj
