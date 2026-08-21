-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/dice/RogueUnitCompDices.lua

module("logic.extensions.roguelike.unit.comp.dice.RogueUnitCompDices", package.seeall)

local M = class("RogueUnitCompDices", RogueUnitCompBase)

function M:onInit()
	self._diceMOTable = {}
end

function M:onReset()
	self:clearAllDice()
end

function M:onDestroy()
	self:onReset()
end

function M:getAllDice()
	return self._diceMOTable
end

function M:clearAllDice()
	return
end

function M:addDice(id, code)
	return
end

function M:removeDice(id)
	return
end

function M:getDiceMO(id)
	return self._diceMOTable[id] or false
end

return M
