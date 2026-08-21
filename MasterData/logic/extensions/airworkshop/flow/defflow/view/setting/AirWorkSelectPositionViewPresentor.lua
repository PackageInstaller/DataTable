-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/setting/AirWorkSelectPositionViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.setting.AirWorkSelectPositionViewPresentor", package.seeall)

local M = class("AirWorkSelectPositionViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_ui_map_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkSelectPositionView.New())

	return views
end

return M
