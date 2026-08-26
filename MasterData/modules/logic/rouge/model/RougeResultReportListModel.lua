-- chunkname: @modules/logic/rouge/model/RougeResultReportListModel.lua

module("modules.logic.rouge.model.RougeResultReportListModel", package.seeall)

local RougeResultReportListModel = class("RougeResultReportListModel", ListScrollModel)

function RougeResultReportListModel:init()
	local list = RougeFavoriteModel.instance:getReviewInfoList()

	table.sort(list, function(a, b)
		return a.finishTime > b.finishTime
	end)
	self:setList(list)
end

RougeResultReportListModel.instance = RougeResultReportListModel.New()

return RougeResultReportListModel
