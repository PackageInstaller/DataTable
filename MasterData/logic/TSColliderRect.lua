-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/view/TSColliderRect.lua

module("logic.extensions.throwshells.view.TSColliderRect", package.seeall)

local TSColliderRect = class("TSColliderRect", TSColliderBase)

function TSColliderRect:ctor(comp, go, offsetPos)
	local x, y, z = Framework.TransformUtil.GetLocalPos(go.transform, 0, 0, 0)
	local x1, y1 = Framework.TransformUtil.GetLocalScale(go.transform, 0, 0, 0)
	local offset = offsetPos and offsetPos or {
		x = 0,
		y = 0
	}

	self._pos = {
		x = comp.center.x + x + offset.x,
		y = comp.center.y + y + offset.y
	}
	self._width = comp.size.x * x1 / 2
	self._height = comp.size.y * y1 / 2
end

function TSColliderRect:checkCollide(pos, radius)
	local distanceX = math.abs(pos.x - self._pos.x)
	local distanceY = math.abs(pos.y - self._pos.y)

	if distanceX > self._width + radius then
		return false
	end

	if distanceY > self._height + radius then
		return false
	end

	if distanceX < self._width then
		return true
	end

	if distanceY < self._height then
		return true
	end

	return (distanceX - self._width) * (distanceX - self._width) + (distanceY - self._height) * (distanceY - self._height) < radius * radius
end

return TSColliderRect
