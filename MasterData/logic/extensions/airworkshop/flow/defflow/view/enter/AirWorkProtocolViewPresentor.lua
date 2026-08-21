-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/enter/AirWorkProtocolViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.enter.AirWorkProtocolViewPresentor", package.seeall)

local M = class("AirWorkProtocolViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:attachToWhichRoot()
	return ViewRootType.PopupTop
end

function M:dependWhatResources()
	return {
		ResName.Airworkshop_protocol
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkProtocolView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
