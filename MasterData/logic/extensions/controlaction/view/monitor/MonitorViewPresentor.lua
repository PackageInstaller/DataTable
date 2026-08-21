-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/monitor/MonitorViewPresentor.lua

module("logic.extensions.controlaction.view.monitor.MonitorViewPresentor", package.seeall)

local M = class("MonitorViewPresentor", ViewPresentor)

M.Url_View = ResName.Regulatory_monitor_panel

function M:dependWhatResources()
	return {
		M.Url_View
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, MonitorView.New())

	return views
end

return M
