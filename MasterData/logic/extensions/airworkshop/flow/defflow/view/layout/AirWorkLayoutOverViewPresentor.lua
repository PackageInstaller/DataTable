-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/layout/AirWorkLayoutOverViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.layout.AirWorkLayoutOverViewPresentor", package.seeall)

local M = class("AirWorkLayoutOverViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_layout_over_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkLayoutOverView.New())

	return views
end

return M
