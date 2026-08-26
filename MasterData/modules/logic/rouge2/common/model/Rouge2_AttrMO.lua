-- chunkname: @modules/logic/rouge2/common/model/Rouge2_AttrMO.lua

module("modules.logic.rouge2.common.model.Rouge2_AttrMO", package.seeall)

local Rouge2_AttrMO = pureTable("Rouge2_AttrMO")

function Rouge2_AttrMO:init(info)
	self.attrId = info.attrId
	self.value = info.finalVal
	self.config = Rouge2_AttributeConfig.instance:getAttributeConfig(self.attrId)
end

function Rouge2_AttrMO:getValue()
	return self.value or 0
end

function Rouge2_AttrMO:getId()
	return self.attrId
end

function Rouge2_AttrMO:getCofig()
	return self.config
end

return Rouge2_AttrMO
