-- chunkname: @modules/logic/prototest/model/ProtoTestCaseModel.lua

module("modules.logic.prototest.model.ProtoTestCaseModel", package.seeall)

local ProtoTestCaseModel = class("ProtoTestCaseModel", MixScrollModel)

function ProtoTestCaseModel:getInfoList(scrollGO)
	local mixCellInfos = {}

	for _, mo in ipairs(self:getList()) do
		local paramCount = #mo.value
		local lineWidth = 45 + paramCount * 27.5
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(paramCount, lineWidth, lineWidth)

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

ProtoTestCaseModel.instance = ProtoTestCaseModel.New()

return ProtoTestCaseModel
