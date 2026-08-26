-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongJoystick.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongJoystick", package.seeall)

local V3a8EchoSongJoystick = class("V3a8EchoSongJoystick", VirtualFixedJoystick)
local EnterOuterTh = 0.99
local ExitOuterTh = 0.95

function V3a8EchoSongJoystick:init(go)
	V3a8EchoSongJoystick.super.init(self, go)

	self._goEffect = gohelper.findChild(go, "#go_background/vx_light")

	gohelper.setActive(self._goEffect, false)

	self._inOuter = false
end

function V3a8EchoSongJoystick:refreshHandlePos()
	V3a8EchoSongJoystick.super.refreshHandlePos(self)

	local strength = self:getStrength()

	if strength >= EnterOuterTh then
		self._inOuter = true
	elseif strength < ExitOuterTh then
		self._inOuter = false
	end

	if strength > 0 then
		if self._inOuter then
			if not self._radius then
				local r = self._radius / 2.5
				local lenSq = self._input.x * self._input.x + self._input.y * self._input.y

				if lenSq > 0 then
					local invLen = 1 / math.sqrt(lenSq)
					local posX = self._input.x * invLen * r
					local posY = self._input.y * invLen * r

					transformhelper.setLocalPosXY(self._transhandle, posX, posY)
				end
			end
		end
	else
		self._inOuter = false
	end

	local showEffect = strength > 0

	gohelper.setActive(self._goEffect, showEffect)

	if showEffect then
		local angle = math.atan2(self._transhandlePos.y, self._transhandlePos.x)
		local degree = math.deg(angle)

		transformhelper.setLocalRotation(self._goEffect.transform, 0, 0, degree)
	end
end

return V3a8EchoSongJoystick
