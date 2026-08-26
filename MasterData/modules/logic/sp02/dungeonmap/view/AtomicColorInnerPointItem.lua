-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicColorInnerPointItem.lua

module("modules.logic.sp02.dungeonmap.view.AtomicColorInnerPointItem", package.seeall)

local AtomicColorInnerPointItem = class("AtomicColorInnerPointItem", LuaCompBase)

function AtomicColorInnerPointItem:ctor(param)
	self.param = param
	self.colorGameView = param.colorGameView
	self.rotateTime = 0.5
	self.circleRadius = 140
	self.circlePosX, self.circlePosY = param.circlePosX, param.circlePosY
	self.colorType = AtomicDungeonEnum.ColorType.Type0
end

function AtomicColorInnerPointItem:init(go)
	self:__onInit()

	self.go = go
	self.typeItemMap = {}

	for type = 0, 2 do
		self.typeItemMap[type] = gohelper.findChild(self.go, "go_type" .. type)
	end

	gohelper.setActive(self.go, true)
end

function AtomicColorInnerPointItem:addEventListeners()
	return
end

function AtomicColorInnerPointItem:removeEventListeners()
	return
end

function AtomicColorInnerPointItem:refreshUI(data)
	recthelper.setAnchor(self.go.transform, data.posX, data.posY)

	self.colorType = data.type

	for type, typeItem in pairs(self.typeItemMap) do
		gohelper.setActive(typeItem, type == self.colorType)
	end
end

function AtomicColorInnerPointItem:rotateOuterPointItem(curRadAngle, targetRadAngle)
	self.rotateTweenId = ZProj.TweenHelper.DOTweenFloat(curRadAngle, targetRadAngle, self.rotateTime, self.doRotateOuterCircle, self.doRotateFinish, self)
end

function AtomicColorInnerPointItem:doRotateOuterCircle(value)
	local curAnchorPosX = self.circleRadius * math.sin(value)
	local curAnchorPosY = self.circleRadius * math.cos(value)

	recthelper.setAnchor(self.go.transform, curAnchorPosX, curAnchorPosY)
end

function AtomicColorInnerPointItem:rotateInnerPointItem(targetPosX, targetPosY)
	self.rotateTweenId = ZProj.TweenHelper.DOAnchorPos(self.go.transform, targetPosX, targetPosY, self.rotateTime, self.doRotateFinish, self)
end

function AtomicColorInnerPointItem:doRotateFinish()
	self.colorGameView:doRotateFinish()
	self:cleanTween()
end

function AtomicColorInnerPointItem:cleanTween()
	if self.rotateTweenId then
		ZProj.TweenHelper.KillById(self.rotateTweenId)

		self.rotateTweenId = nil
	end
end

function AtomicColorInnerPointItem:onDestroy()
	self:cleanTween()
end

return AtomicColorInnerPointItem
