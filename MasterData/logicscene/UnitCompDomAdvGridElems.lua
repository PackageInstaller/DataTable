-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/domainadventure/UnitCompDomAdvGridElems.lua

module("logicscene.scene.unit.component.season.UnitCompDomAdvGridElems", package.seeall)

local UnitCompDomAdvGridElems = class("UnitCompDomAdvGridElems", UnitComponentBase)

function UnitCompDomAdvGridElems:onInit()
	self._elements = {}
end

function UnitCompDomAdvGridElems:addElement(elem)
	elem.gridUnit = self._unit
	self._elements[elem.id] = elem

	local parent = self._unit.go.transform

	elem.go.transform:SetParent(parent)
end

function UnitCompDomAdvGridElems:getElement(id)
	return self._elements[id]
end

function UnitCompDomAdvGridElems:getElements()
	return self._elements
end

function UnitCompDomAdvGridElems:onDestroy()
	self._unit = nil

	if self._elements then
		for k, elem in pairs(self._elements) do
			elem.gridUnit = nil
		end
	end

	self._elements = nil
end

return UnitCompDomAdvGridElems
