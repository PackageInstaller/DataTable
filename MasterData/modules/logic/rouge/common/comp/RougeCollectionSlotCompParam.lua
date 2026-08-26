-- chunkname: @modules/logic/rouge/common/comp/RougeCollectionSlotCompParam.lua

module("modules.logic.rouge.common.comp.RougeCollectionSlotCompParam", package.seeall)

local RougeCollectionSlotCompParam = pureTable("RougeCollectionSlotCompParam")

function RougeCollectionSlotCompParam:ctor()
	self.cellWidth = 20
	self.cellHeight = 20
	self.isNeedShowIcon = false
	self.cellLineNameMap = {
		[RougeEnum.LineState.Grey] = "rouge_bagline_yellow",
		[RougeEnum.LineState.Green] = "rouge_bagline_green"
	}
	self.cls = RougeCollectionCompCellItem
end

function RougeCollectionSlotCompParam:getLine(lineState)
	if self.cellLineNameMap then
		return self.cellLineNameMap
	end
end

return RougeCollectionSlotCompParam
