-- chunkname: @modules/logic/rouge2/backpack/model/rpcmo/Rouge2_RelicsAttrMO.lua

module("modules.logic.rouge2.backpack.model.rpcmo.Rouge2_RelicsAttrMO", package.seeall)

local Rouge2_RelicsAttrMO = pureTable("Rouge2_RelicsAttrMO")

function Rouge2_RelicsAttrMO:init(info)
	self._attrId = info.attrId
	self._attrVal = info.attrVal
end

function Rouge2_RelicsAttrMO:getValue()
	return self._attrVal
end

return Rouge2_RelicsAttrMO
