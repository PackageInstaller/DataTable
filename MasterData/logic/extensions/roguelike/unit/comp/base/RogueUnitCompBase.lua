-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/base/RogueUnitCompBase.lua

module("logic.extensions.roguelike.unit.comp.base.RogueUnitCompBase", package.seeall)

local M = class("RogueUnitCompBase", IRogueUnitComponent)

function M:ctor(unit)
	self._unit = unit
end

function M:onInit()
	return
end

function M:onReuse()
	return
end

function M:onReset()
	return
end

function M:onDestroy()
	return
end

return M
