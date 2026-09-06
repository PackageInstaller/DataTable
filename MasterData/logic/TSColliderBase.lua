-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/view/TSColliderBase.lua

module("logic.extensions.throwshells.view.TSColliderBase", package.seeall)

local TSColliderBase = class("TSColliderBase")

function TSColliderBase:ctor(comp, go, offsetPos)
	self._pos = {
		x = 0,
		y = 0
	}
end

function TSColliderBase:checkCollide(pos, radius)
	return
end

function TSColliderBase:move(offset)
	self._pos.x = self._pos.x + offset.x
	self._pos.y = self._pos.y + offset.y
end

return TSColliderBase
