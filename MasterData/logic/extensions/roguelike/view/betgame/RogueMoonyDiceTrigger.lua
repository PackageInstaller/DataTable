-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/betgame/RogueMoonyDiceTrigger.lua

module("logic.extensions.roguelike.view.betgame.RogueMoonyDiceTrigger", package.seeall)

local M = class("RogueMoonyDiceTrigger")
local kColor = UnityEngine.Shader.PropertyToID("_EmissionColor")

function M:ctor(container)
	local go = container.gameObject

	self._go = go

	local matSetter = MaterialSetter.Get(go)

	matSetter:SetGameObject(go)

	self._matSetter = matSetter
end

function M:setEnterCallback(callback)
	self._collisionEnterCallback = callback
end

function M:setExitCallback(callback)
	self._collisionExitCallback = callback
end

function M:OnCollisionEnter(collision)
	if self._collisionEnterCallback then
		self._collisionEnterCallback(collision, self._go)
	end

	collision.rigidbody:AddForce(collision.relativeVelocity * -0.5, UnityEngine.ForceMode.Impulse)
end

function M:OnCollisionExit(collision)
	if self._collisionExitCallback then
		self._collisionExitCallback(collision)
	end
end

return M
