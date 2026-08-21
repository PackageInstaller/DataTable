-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/data/OriginalD6MO.lua

module("logic.extensions.equipment.data.OriginalD6MO", package.seeall)

local M = class("OriginalD6MO")

function M:ctor(DiceAttrNO)
	self:updateByNo(DiceAttrNO)
end

function M:updateByNo(DiceAttrNO)
	self._attrs = {}

	table.insert(self._attrs, DiceAttrMO.New(DiceAttrNO))
end

function M:getAttrs()
	return self._attrs
end

function M:getEffectAttr()
	return self._attrs[1]
end

function M:getLevel()
	return self._attrs[1]:getLevel()
end

return M
