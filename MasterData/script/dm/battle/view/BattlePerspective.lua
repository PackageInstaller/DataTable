-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattlePerspective.lua

BattlePerspective = {}

function BattlePerspective:new(...)
	self.__index = self

	local obj = setmetatable({}, self)

	obj:initialize(...)

	return obj
end

function BattlePerspective:initialize(viewWidth, viewHeight, eyeHeight, eyeDistance)
	local eyeY = -eyeDistance
	local eyeZ = eyeHeight

	self._unitX = viewWidth / 2
	self._unitY = viewHeight * (1 - eyeY) / eyeZ
	self._eyeY, self._eyeZ = eyeY, eyeZ
end

function BattlePerspective:setFarScale(scale)
	self._farScale = scale
end

function BattlePerspective:norm2view(nx, ny)
	local eyeY, eyeZ = self._eyeY, self._eyeZ
	local p = 1 / (eyeY - ny)
	local sx = eyeY * p
	local vx = nx * sx * self._unitX
	local vz = -ny * eyeZ * p * self._unitY
	local dist2 = nx * nx + (ny - eyeY) * (ny - eyeY)
	local farScale = self._farScale

	if farScale ~= nil then
		local scale = 1 + (farScale - 1) * ny

		return vx, vz, scale, dist2
	else
		return vx, vz, sx, dist2
	end
end

function BattlePerspective:view2norm(vx, vy)
	local eyeY, eyeZ = self._eyeY, self._eyeZ
	local px, py = vx / self._unitX, vy / self._unitY
	local p = 1 / (py - eyeZ)
	local ny = py * eyeY * p
	local nx = -px * eyeZ * p

	return nx, ny
end
