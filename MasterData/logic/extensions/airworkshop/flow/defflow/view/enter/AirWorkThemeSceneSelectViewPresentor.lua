-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/enter/AirWorkThemeSceneSelectViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.enter.AirWorkThemeSceneSelectViewPresentor", package.seeall)

local M = class("AirWorkThemeSceneSelectViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_theme_scene_select
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkThemeSceneSelectView.New())

	return views
end

return M
