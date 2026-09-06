-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/view/CatchPropsGameCatcher.lua

module("logic.extensions.catchprops.view.CatchPropsGameCatcher", package.seeall)

local CatchPropsGameCatcher = class("CatchPropsGameCatcher", CatchPropsAnimCtrl)

function CatchPropsGameCatcher:onEnter()
	CatchPropsGameCatcher.super.onEnter(self)

	self._dragTrigger = Framework.UIDragTrigger.Get(self._nodeParent)
	self._dragTrigger.enabled = false

	self._dragTrigger:AddBeginDragListener(self._onBeginDragCatcher, self)
	self._dragTrigger:AddEndDragListener(self._onEndDragCatcher, self)
	self._dragTrigger:AddDragListener(self._onDragCatcher, self)

	self._collider = goutil.findChild(self._nodeParent, "collider").transform

	local scaleX, scaleY = Framework.TransformUtil.GetLocalScale(self._nodeParent.transform, 1, 1, 1)
	local cx, cyPos = Framework.TransformUtil.GetLocalPos(self._collider, nil, nil, nil)

	self._colliderLocalX = cx * scaleX
	self._colliderLocalY = cyPos * scaleY

	local sizeDelta = self._collider.transform.sizeDelta

	self._colliderSizeX = sizeDelta.x * scaleX
	self._colliderSizeY = sizeDelta.y * scaleY
	self._boundingBox = BoundingBox2D.New()

	self:_onEndDragCatcher()
end

function CatchPropsGameCatcher:onExit()
	self._boundingBox = nil

	self._dragTrigger:RemoveBeginDragListener()
	self._dragTrigger:RemoveEndDragListener()
	self._dragTrigger:RemoveDragListener()
	CatchPropsGameCatcher.super.onExit(self)
end

function CatchPropsGameCatcher:startGame()
	self._dragTrigger.enabled = true
end

function CatchPropsGameCatcher:stopGame()
	self._dragTrigger.enabled = false
end

function CatchPropsGameCatcher:pauseGame(pause)
	self._dragTrigger.enabled = not pause
end

function CatchPropsGameCatcher:getColliderPos()
	local x, y = Framework.TransformUtil.GetLocalPos(self._nodeParent.transform, nil, nil, nil)

	return self._colliderLocalX + x, y + self._colliderLocalY
end

function CatchPropsGameCatcher:setMoveRange(rangeMinX, rangeMaxX)
	self._rangeMinX = rangeMinX
	self._rangeMaxX = rangeMaxX
end

function CatchPropsGameCatcher:getBoundingBox()
	local x, y = self:getColliderPos()

	self._boundingBox:setSize(self._colliderSizeX, self._colliderSizeY)
	self._boundingBox:setCenter(x, y)

	return self._boundingBox
end

function CatchPropsGameCatcher:_onDragCatcher(eventData)
	local trans = self._nodeParent.transform
	local x, y, z = Framework.TransformUtil.GetLocalPos(trans, 0, 0, 0)
	local deltaX = eventData.delta.x

	x = x + deltaX

	if x >= self._rangeMaxX then
		x = self._rangeMaxX
	elseif x <= self._rangeMinX then
		x = self._rangeMinX
	end

	Framework.TransformUtil.SetLocalPos(trans, x, y, z)
	self:setDirection(deltaX < 0)
end

function CatchPropsGameCatcher:_onBeginDragCatcher()
	self:playAnim("lanzi_run", true, true)
end

function CatchPropsGameCatcher:_onEndDragCatcher()
	self:playAnim("lanzi_idle", true, true)
end

return CatchPropsGameCatcher
