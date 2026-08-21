-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/report/facade/ReportFacade.lua

module("logic.extensions.report.facade.ReportFacade", package.seeall)

local M = class("ReportFacade")

function M:openReportView(data)
	if data and data.playerId then
		ViewMgr.instance:open(ViewName.Report, data)
	end
end

M.instance = M.New()

return M
