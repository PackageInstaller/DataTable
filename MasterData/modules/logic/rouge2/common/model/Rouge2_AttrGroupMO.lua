-- chunkname: @modules/logic/rouge2/common/model/Rouge2_AttrGroupMO.lua

module("modules.logic.rouge2.common.model.Rouge2_AttrGroupMO", package.seeall)

local Rouge2_AttrGroupMO = pureTable("Rouge2_AttrGroupMO")

function Rouge2_AttrGroupMO:init(info)
	self:initAttrInfoList(info.attr)
end

function Rouge2_AttrGroupMO:initAttrInfoList(info)
	self._attrInfoList = {}
	self._attrInfoMap = {}
	self._type2AttrInfoMap = {}

	self:updateAttrInfoList(info)
end

function Rouge2_AttrGroupMO:updateAttrInfoList(updates)
	if not updates then
		return
	end

	for _, updateAttrInfo in ipairs(updates) do
		self:updateAttrInfo(updateAttrInfo)
	end

	Rouge2_MapAttrUpdateController.instance:recordUpdateAttrInfoList(self._attrInfoList)
end

function Rouge2_AttrGroupMO:updateAttrInfo(attrInfo)
	local attrId = attrInfo.attrId
	local attrMo = self._attrInfoMap[attrId]
	local create = attrMo == nil

	if not attrMo then
		attrMo = Rouge2_AttrMO.New()
		self._attrInfoMap[attrId] = attrMo

		table.insert(self._attrInfoList, attrMo)
	end

	attrMo:init(attrInfo)

	if create then
		if attrMo.config then
			if attrMo.config then
				self._type2AttrInfoMap[attrMo.config] = self._type2AttrInfoMap[attrMo.config] or {}

				table.insert(self._type2AttrInfoMap[attrMo.config], attrMo)
			end
		end
	end
end

function Rouge2_AttrGroupMO:getAttrInfoList(attrType)
	return self._type2AttrInfoMap and self._type2AttrInfoMap[attrType]
end

function Rouge2_AttrGroupMO:getAttrInfo(attrId)
	return self._attrInfoMap and self._attrInfoMap[attrId]
end

function Rouge2_AttrGroupMO:getAttrValue(attrId)
	local attrMo = self:getAttrInfo(attrId)

	return (attrMo or nil) and (attrMo.value or 0)
end

return Rouge2_AttrGroupMO
