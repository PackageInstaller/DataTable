-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_ResultReportListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_ResultReportListModel", package.seeall)

local Rouge2_ResultReportListModel = class("Rouge2_ResultReportListModel", ListScrollModel)

function Rouge2_ResultReportListModel:initList()
	local tempList = {}
	local infoList = Rouge2_OutsideModel.instance:getReviewInfoList()

	if infoList then
		if #infoList >= 2 then
			table.sort(infoList, Rouge2_ResultReportListModel.sortList)
		end

		for _, info in ipairs(infoList) do
			local mo = {}

			mo.info = info

			table.insert(tempList, mo)
		end
	end

	self:setList(tempList)
end

function Rouge2_ResultReportListModel.sortList(a, b)
	return tonumber(a.finishTime) > tonumber(b.finishTime)
end

Rouge2_ResultReportListModel.instance = Rouge2_ResultReportListModel.New()

return Rouge2_ResultReportListModel
