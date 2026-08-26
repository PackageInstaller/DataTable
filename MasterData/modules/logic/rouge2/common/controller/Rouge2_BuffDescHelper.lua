-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_BuffDescHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_BuffDescHelper", package.seeall)

local Rouge2_BuffDescHelper = class("Rouge2_BuffDescHelper", Rouge2_ItemDescBaseHelper)

function Rouge2_BuffDescHelper:_initDefaultIncludeTypeList(includeTypeList)
	table.insert(includeTypeList, Rouge2_Enum.RelicsDescType.Desc)
	table.insert(includeTypeList, Rouge2_Enum.RelicsDescType.NarrativeDesc)
end

return Rouge2_BuffDescHelper
