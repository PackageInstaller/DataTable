-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/statistic/AirWorkStatisticViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.statistic.AirWorkStatisticViewPresentor", package.seeall)

local M = class("AirWorkStatisticViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_statistic_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkStatisticView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

function M:onClickOutside()
	return
end

return M
