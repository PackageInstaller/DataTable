-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/AirWorkShopDefSceneMainViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.AirWorkShopDefSceneMainViewPresentor", package.seeall)

local M = class("AirWorkShopDefSceneMainViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_scene_main_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopDefSceneScrollView.New())
	table.insert(views, AirWorkShopDefSceneUnitCountView.New())
	table.insert(views, AirWorkShopDefSceneMainView.New())
	table.insert(views, AirWorkShopDefScenePreviewSelectView.New())
	table.insert(views, AirAdditionalTerrainInfoView.New())

	return views
end

return M
