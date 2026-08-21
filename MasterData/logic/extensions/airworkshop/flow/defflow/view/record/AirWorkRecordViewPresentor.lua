-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/record/AirWorkRecordViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.record.AirWorkRecordViewPresentor", package.seeall)

local M = class("AirWorkRecordViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_record_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkRecordVIew.New())

	return views
end

return M
