-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/view/TSColliderCombine.lua

module("logic.extensions.throwshells.view.TSColliderCombine", package.seeall)

local TSColliderCombine = class("TSColliderCombine")

function TSColliderCombine:ctor(go, offsetPos)
	self._wallColliderGo = {}

	local compsR = go:GetComponents(typeof("UnityEngine.BoxCollider"))

	for i = 0, compsR.Length - 1 do
		table.insert(self._wallColliderGo, TSColliderRect.New(compsR[i], go, offsetPos))
	end

	local compsC = go:GetComponents(typeof("UnityEngine.CircleCollider2D"))

	for i = 0, compsC.Length - 1 do
		table.insert(self._wallColliderGo, TSColliderCircle.New(compsC[i], go, offsetPos))
	end
end

function TSColliderCombine:checkCollide(pos, radius)
	local collide = false

	for k, v in pairs(self._wallColliderGo) do
		if v:checkCollide(pos, radius) then
			collide = true
		end
	end

	return collide
end

function TSColliderCombine:onDestroy()
	table.clear(self._wallColliderGo)
end

function TSColliderCombine:move(offset)
	for k, v in pairs(self._wallColliderGo) do
		v:move(offset)
	end
end

return TSColliderCombine
