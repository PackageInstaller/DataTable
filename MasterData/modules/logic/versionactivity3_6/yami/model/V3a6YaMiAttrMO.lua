-- chunkname: @modules/logic/versionactivity3_6/yami/model/V3a6YaMiAttrMO.lua

module("modules.logic.versionactivity3_6.yami.model.V3a6YaMiAttrMO", package.seeall)

local V3a6YaMiAttrMO = class("V3a6YaMiAttrMO")

function V3a6YaMiAttrMO:ctor()
	self._attrDict = {}
end

function V3a6YaMiAttrMO:refreshInfo(info)
	self:setAttrValue(V3a6YaMiEnum.AttrType.attr1, info and info.attr1)
	self:setAttrValue(V3a6YaMiEnum.AttrType.attr2, info and info.attr2)
	self:setAttrValue(V3a6YaMiEnum.AttrType.attr3, info and info.attr3)
	self:setAttrValue(V3a6YaMiEnum.AttrType.attr4, info and info.attr4)
end

function V3a6YaMiAttrMO:setAttrValue(type, value)
	self._attrDict[type] = value
end

function V3a6YaMiAttrMO:getAttrValue(type)
	return (self._attrDict or nil) and (self._attrDict[type] or 0)
end

function V3a6YaMiAttrMO:resetValues()
	for type, value in pairs(self._attrDict) do
		self:setAttrValue(type, 0)
	end
end

function V3a6YaMiAttrMO:getHightestValue()
	local highValue = 0

	for _, value in pairs(self._attrDict) do
		highValue = math.max(highValue, value)
	end

	return highValue
end

return V3a6YaMiAttrMO
