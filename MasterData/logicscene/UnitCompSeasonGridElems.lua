-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/UnitCompSeasonGridElems.lua

module("logicscene.scene.unit.component.season.UnitCompSeasonGridElems", package.seeall)

local UnitCompSeasonGridElems = class("UnitCompSeasonGridElems", UnitComponentBase)

function UnitCompSeasonGridElems:onInit()
	self._elements = {}
end

function UnitCompSeasonGridElems:addElement(elem)
	elem.gridUnit = self._unit
	self._elements[elem.id] = elem

	local parent = self._unit.go.transform

	elem.go.transform:SetParent(parent)
end

function UnitCompSeasonGridElems:getElement(id)
	return self._elements[id]
end

function UnitCompSeasonGridElems:getElements()
	return self._elements
end

function UnitCompSeasonGridElems:onDestroy()
	self._unit = nil

	if self._elements then
		for k, elem in pairs(self._elements) do
			elem.gridUnit = nil
		end
	end

	self._elements = nil
end

return UnitCompSeasonGridElems
