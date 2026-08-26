-- chunkname: @modules/logic/player/model/KeyValueSimplePropertyMO.lua

module("modules.logic.player.model.KeyValueSimplePropertyMO", package.seeall)

local KeyValueSimplePropertyMO = pureTable("KeyValueSimplePropertyMO")

function KeyValueSimplePropertyMO:ctor()
	self._isNumber = true
end

function KeyValueSimplePropertyMO:init(info)
	self.id = info.id
	self.property = info.property
	self._map = {}

	local list = GameUtil.splitString2(info.property, self._isNumber, "|", "#")

	for i, v in ipairs(list) do
		local id = v[1]

		self._map[id] = v[2]
	end
end

function KeyValueSimplePropertyMO:getValue(id, defaultValue)
	return (self._map or nil) and (self._map[id] or defaultValue)
end

function KeyValueSimplePropertyMO:setValue(id, state)
	self._map = self._map or {}
	self._map[id] = state
end

function KeyValueSimplePropertyMO:getString()
	local result = ""

	if not self._map then
		return result
	end

	for k, v in pairs(self._map) do
		local str = string.format("%s#%s", k, v)

		result = not string.nilorempty(result) and result .. "|" .. str or str
	end

	return result
end

return KeyValueSimplePropertyMO
