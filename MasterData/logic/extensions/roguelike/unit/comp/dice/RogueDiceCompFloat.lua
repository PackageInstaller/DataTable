-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/dice/RogueDiceCompFloat.lua

module("logic.extensions.roguelike.unit.comp.dice.RogueDiceCompFloat", package.seeall)

local M = class("RogueDiceCompFloat")

function M:ctor(go)
	self._go = go.gameObject
end

function M:setRandomFloat(rotation, minY, maxY)
	self._rotation = rotation
	self._minY = minY
	self._maxY = maxY
	self._curY = minY
	self._floatOffset = math.random(2, 5) / 100
	self._isFloat = true
	self._isUp = true
	self._isRotate = true
end

function M:stopFloat()
	self._isFloat = false
end

function M:stopAction()
	self._isFloat = false
	self._isRotate = false
end

function M:Update()
	if self._isFloat then
		local pos = self._go.transform.position

		if self._isUp then
			self._curY = self._curY + self._floatOffset

			Astral.TransformUtil.SetPos(self._go.transform, pos.x, self._curY, pos.z)

			if self._curY > self._maxY then
				self._isUp = false
			end
		else
			self._curY = self._curY - self._floatOffset

			Astral.TransformUtil.SetPos(self._go.transform, pos.x, self._curY, pos.z)

			if self._curY < self._minY then
				self._isUp = true
			end
		end
	end

	if self._isRotate then
		self._rotation.x = self._rotation.x + 1
		self._rotation.y = self._rotation.y + 1

		TransformUtils.SetEulerAngles(self._go.transform, self._rotation.x, self._rotation.y, self._rotation.z)
	end
end

return M
