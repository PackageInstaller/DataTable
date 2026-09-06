-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/view/TSColliderCircle.lua

module("logic.extensions.throwshells.view.TSColliderCircle", package.seeall)

local TSColliderCircle = class("TSColliderCircle", TSColliderBase)

function TSColliderCircle:ctor(comp, go, offsetPos)
	local offset = offsetPos and offsetPos or {
		x = 0,
		y = 0
	}
	local x, y, z = Framework.TransformUtil.GetLocalPos(go.transform, 0, 0, 0)
	local x1 = Framework.TransformUtil.GetLocalScale(go.transform, 0, 0, 0)

	self._pos = {
		x = comp.offset.x + x + offset.x,
		y = comp.offset.y + y + offset.y
	}
	self._radius = comp.radius * x1
end

function TSColliderCircle:checkCollide(pos, radius)
	return GameUtil.getVector2Distance(pos, self._pos) < radius + self._radius
end

return TSColliderCircle
