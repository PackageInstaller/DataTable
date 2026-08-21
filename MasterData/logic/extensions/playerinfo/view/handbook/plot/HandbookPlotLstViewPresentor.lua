-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/plot/HandbookPlotLstViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.plot.HandbookPlotLstViewPresentor", package.seeall)

local M = class("HandbookPlotLstViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_memory_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookPlotLstView.New())

	return views
end

return M
