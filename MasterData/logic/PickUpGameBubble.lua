-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickUpGameBubble.lua

module("logic.extensions.pickupidea.view.PickUpGameBubble", package.seeall)

local PickUpGameBubble = class("PickUpGameBubble")

function PickUpGameBubble:ctor(compContainer)
	self._compContainer = compContainer
	self.mainGO = self._compContainer.gameObject
	self._transform = self.mainGO.transform
	self._radius = 20
	self._pos = {
		x = 0,
		y = 0
	}
	self._goEff = goutil.findChild(self.mainGO, "effect")
	self._colorChange = self.mainGO:GetComponent(ComponentType.UIImageSpriteChange)
	self._image = self.mainGO:GetComponent(goutil.Type_UIImage)
	self._isMoving = false
end

function PickUpGameBubble:onExit()
	if self._tweenMove then
		self._tweenMove:Kill(false)
	end

	if self._hitEffect then
		UIEffectManager.instance:stopEffect(self._hitEffect)

		self._hitEffect = nil
	end
end

function PickUpGameBubble:beginMove(targetPos)
	self._isMoving = true

	if self._hitEffect then
		UIEffectManager.instance:stopEffect(self._hitEffect)

		self._hitEffect = nil
	end

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._transform, 0, 0, 0)
	local diffx = targetPos.x - x
	local diffy = targetPos.y - y
	local absX = math.abs(x - targetPos.x)
	local absY = math.abs(y - targetPos.y)

	self._color = self._image.color
	self._tweenMove = TweenUtil.ValueTo(0, 1, 1, function(val)
		local x1 = x + diffx * val
		local y1 = y + diffy * val

		self._pos.x = x1
		self._pos.y = y1

		Framework.TransformUtil.SetLocalPos(self.mainGO.transform, x1, y1, 0)

		self._color.a = val
		self._image.color = self._color
	end, function()
		self._color.a = 1
		self._image.color = self._color
		self._isMoving = false

		GlobalDispatcher:dispatch(GlobalNotify.PickUpIdeaBubbleMoveEnd, self._row, self._col)
	end, self, DG.Tweening.Ease.Linear)
end

function PickUpGameBubble:setParams(view, id, row, col)
	self._speed = 60
	self._damageVal = 10
	self._view = view
	self._id = id
	self._row = row
	self._col = col
	self._bubbleCfg = PickupideaConfig.instance:getBubbleCfg(id)

	self._colorChange:SetState(id - 1)
end

function PickUpGameBubble:checkCollide(pos, radius)
	return not self._isMoving and (pos.x - self._pos.x)^2 + (pos.y - self._pos.y)^2 <= math.pow(radius * 2, 2)
end

function PickUpGameBubble:getId()
	return self._id
end

function PickUpGameBubble:isMe(row, col)
	return self._row == row and self._col == col
end

function PickUpGameBubble:getRowCol()
	return self._row, self._col
end

function PickUpGameBubble:isMoving()
	return self._isMoving
end

return PickUpGameBubble
