-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rotationlist/RotEllipticPathMo.lua

module("logic.extensions.rotationlist.RotEllipticPathMo", package.seeall)

local RotEllipticPathMo = class("RotEllipticPathMo", RotBasePathMo)

function RotEllipticPathMo:ctor()
	self._pxArr = {}
	self._pyArr = {}
	self._defaultP = 1
	self._a, self._b = 0, 0
	self._p = self._defaultP
end

function RotEllipticPathMo:getPointCount()
	return 360 * self._p
end

function RotEllipticPathMo:getPointPos(idx)
	local theta = Mathf.PI * (idx - 1) / self._p / 180

	return self._a * Mathf.Cos(theta), self._b * Mathf.Sin(theta), 0
end

function RotEllipticPathMo:onLoad(a, b, p)
	self._a, self._b = a, b
	self._p = p or self._defaultP
end

return RotEllipticPathMo
