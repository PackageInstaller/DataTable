-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/betgame/RogueGuessDiceTrigger.lua

module("logic.extensions.roguelike.view.betgame.RogueGuessDiceTrigger", package.seeall)

local M = class("RogueGuessDiceTrigger")

function M:ctor(container)
	local go = container.gameObject

	self._go = go
end

function M:setEnterCallback(callback)
	self._collisionEnterCallback = callback
end

function M:setExitCallback(callback)
	self._collisionExitCallback = callback
end

function M:OnCollisionEnter(collision)
	if self._collisionEnterCallback then
		self._collisionEnterCallback(collision)
	end
end

function M:OnCollisionExit(collision)
	if self._collisionExitCallback then
		self._collisionExitCallback(collision)
	end
end

return M
